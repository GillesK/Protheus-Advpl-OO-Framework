#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TSigaUpd   º Autor ³ Gilles Koffmann   º Data  ³  17/08/15  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de compatibilizacao Protheus (criação/update 	     º±±
±±º          ³  no dicionario)                                             º±±
±±º          ³  Criado a partir da rotina Totvs HSPGERAT() (executado em   º±±
±±º          ³  formulas) e complementos de Handerson Duarte              º±±
±±º          ³                                          					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework Copyright Sigaware Pb                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*/{Protheus.doc} TSigaUpd
Classe de execução de compatibilizador Protheus (mudança de estrutura de dicionario e base)
para todas as empresas
@type class
@todo implantar a re-ordenação dos gatilhos
@author Gilles Koffmann - Sigaware Pb
@since 13/09/2015
@version 1.0
/*/
Class TSigaUpd
	
	method update()
	method ProcATU(sTabela, aRegsTab, aRegsCpo, aRegsInd, aRegsGatilhos) 
	method MyOpenSM0Ex()  
	Method GeraSX2(aRegs) 	
	method GeraSX3(aRegs) 
	Method GeraSIX(aRegs) 	
	Method GeraSXB(aRegs)	
	Method GeraSX7()
	
	Method sfVerInd(mvTabela,mvChave)
	method sfSeqSIX(mvTabela)	
	method sfSeqSX3(mvTabela)	
		
	Method DelSX7(aRegs)		 	
	method sfSeqSX7(pCampo)
	method reordSX7()
	method reordSX3()
	
	method formatA(aRegs)
	method New() constructor
EndClass


/*/{Protheus.doc} New
Constructor
@type method
/*/
method New() class TSigaUpd
	//_Super:New()
return self

/*/{Protheus.doc} update
Lança a execução do update de dicionario
@type method
@param aTab, array, Contendo os registros para criar tabelas SX2
@param aCpo, array, Contendo os registros para criar campos SX3
@param aCpoOrd, array, Contendo os registros para ordenar os campos, na forma {campo, campo Antes}
@param aIdx, array, Contendo os registros para criar os indexos SIX
@param aGatDel, array, Contendo os registros para deletar gatilhos. na forma {campo, campo dominio}. É aconselhado colocar os deletes de gatilhos em um compatibilizador a parte
@param aGat, array, Contendo os registros para criar os gatilhos SX7
@param aGatOrd, array, Contendo os registros para ordenar os gatilhos
/*/
method update(aTab , aCpo , aCpoOrd , aIdx , aGatDel , aGat, aGatOrd)  class TSigaUpd
	cArqEmp 					:= "SigaMat.Emp"
	__cInterNet 	:= Nil
	
	PRIVATE cMessage
	PRIVATE aArqUpd	 := {}
	PRIVATE aREOPEN	 := {}
	PRIVATE oMainWnd
	Private nModulo 	:= 51 // modulo SIGAHSP
	
	Set Dele On
	
	lEmpenho				:= .F.
	lAtuMnu					:= .F.
	
	Processa({|| ::ProcATU(aTab , aCpo , aCpoOrd , aIdx , aGatDel , aGat, aGatOrd)},"Processando compatibilizador","Aguarde , processando preparação dos arquivos")	
return 


/*/{Protheus.doc} formatA
Agrupa o array de entrada por entidade, SX3-> por tabela, SX7 -> por campo, SIX -> por tabela
@type method
@param aRegs, array, array a re-ordenar
/*/
method formatA(aRegs)  class TSigaUpd
	local aRet := {}, cur, aNew
	local i

	ASORT(aRegs, , , { | x,y | x[1] < y[1] } )
	
	i := 1
	while i <= Len(aRegs)
		cur := aRegs[i][1]
		aNew := {}						
		while i <= Len(aRegs) .And. cur == aRegs[i][1]   
			aadd(aNew, aRegs[i])
			i += 1
		enddo
		aadd(aRet, aNew)
	enddo				
	
return aRet



/*/{Protheus.doc} ProcATU
Execução do update 
@type method
@param aTab, array, Contendo os registros para criar tabelas SX2
@param aCpo, array, Contendo os registros para criar campos SX3
@param aCpoOrd, array, Contendo os registros para ordenar os campos, na forma {campo, campo Antes}
@param aIdx, array, Contendo os registros para criar os indexos SIX
@param aGatDel, array, Contendo os registros para deletar gatilhos. na forma {campo, campo dominio}. É aconselhado colocar os deletes de gatilhos em um compatibilizador a parte
@param aGat, array, Contendo os registros para criar os gatilhos SX7
@param aGatOrd, array, Contendo os registros para ordenar os gatilhos
/*/
method ProcATU(aRegsTab, aRegsCpo, aCpoOrd, aRegsInd, aGatDel, aRegsGatilhos, aGatOrd)  class TSigaUpd
Local cTexto    	:= ""
Local cFile     	:= ""
Local cMask     	:= "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    	:= 0
Local nI        	:= 0
Local nX        	:= 0
Local aRecnoSM0 	:= {}
Local lOpen     	:= .F.
local i

ProcRegua(1)
IncProc("Verificando integridade dos dicionários....")
If (lOpen := IIF(Alias() <> "SM0", ::MyOpenSm0Ex(), .T. ))

	dbSelectArea("SM0")
	dbGotop()
	While !Eof()
  		If Ascan(aRecnoSM0,{ |x| x[2] == M0_CODIGO}) == 0
			Aadd(aRecnoSM0,{Recno(),M0_CODIGO})
		EndIf			
		dbSkip()
	EndDo	

	If lOpen
		For nI := 1 To Len(aRecnoSM0)
			SM0->(dbGoto(aRecnoSM0[nI,1]))
			RpcSetType(2)
			RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL)
 		nModulo := 05 // modulo faturamento
			lMsFinalAuto := .F.
			cTexto += Replicate("-",128)+CHR(13)+CHR(10)
			cTexto += "Empresa : "+SM0->M0_CODIGO+SM0->M0_NOME+CHR(13)+CHR(10)

			ProcRegua(8)

			Begin Transaction

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza o dicionario de arquivos.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			if aRegsTab != nil
				if Len(aRegsTab) >0
					IncProc("Analisando Dicionario de Arquivos...")
					cTexto += ::GeraSX2(aRegsTab)
				endif
			endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza o dicionario de dados.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			if aRegsCpo != nil
				if Len(aRegsCpo) >0			
					IncProc("Analisando Dicionario de Dados...")
					// Reorganiza array
					// sort
					aRegsCpo2 := ::formatA(aRegsCpo)					

					for i := 1 to len(aRegsCpo2)
						cTexto += ::GeraSX3(aRegsCpo2[i])
					next
				endif
			endif					
			
			// reord cpo
			if aCpoOrd != nil
				if Len(aCpoOrd) > 0
					for i := 1 to Len(aCpoOrd) 
						cTexto += ::reordSx3(aCpoOrd[i][1], aCpoOrd[i][2])
					next		
				endif
			endif			
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza os indices.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			if aRegsInd != nil
				if Len(aRegsInd) >0			
					IncProc("Analisando arquivos de índices. "+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
					
					aRegsInd2 :=  ::formatA(aRegsInd)

					for i := 1 to len(aRegsInd2)
						cTexto += ::GeraSIX(aRegsInd2[i])
					next
				endif
			endif
			
			// dele gatilhos
			if aGatDel != nil
				if Len(aGatDel) >0
					cTexto += ::DelSX7(aGatDel)
				endif
			endif
							
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza os gatilhos.          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			if aRegsGatilhos != nil
				if Len(aRegsGatilhos) >0			
					IncProc("Analisando Gatilhos...")
					aRegsGat2 :=  ::formatA(aRegsGatilhos)
					for i := 1 to len(aRegsGat2)
						cTexto += ::GeraSX7(aRegsGat2[i])
					next															
				endif
			endif						

			End Transaction
	
			__SetX31Mode(.F.)
			For nX := 1 To Len(aArqUpd)
				IncProc("Atualizando estruturas. Aguarde... ["+aArqUpd[nx]+"]")
				If Select(aArqUpd[nx])>0
					dbSelecTArea(aArqUpd[nx])
					dbCloseArea()
				EndIf
				X31UpdTable(aArqUpd[nx])
				If __GetX31Error()
					Alert(__GetX31Trace())
					Aviso("Atencao!","Ocorreu um erro desconhecido durante a atualizacao da tabela : "+ aArqUpd[nx] + ". Verifique a integridade do dicionario e da tabela.",{"Continuar"},2)
					cTexto += "Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "+aArqUpd[nx] +CHR(13)+CHR(10)
				EndIf
				dbSelectArea(aArqUpd[nx])
			Next nX		

			RpcClearEnv()
			If !( lOpen := ::MyOpenSm0Ex() )
				Exit
		 EndIf
		Next nI
		
		If lOpen
			
			cTexto 				:= "Log da atualizacao " + CHR(13) + CHR(10) + cTexto
			__cFileLog := MemoWrite(Criatrab(,.f.) + ".LOG", cTexto)
			
			DEFINE FONT oFont NAME "Mono AS" SIZE 5,12
			DEFINE MSDIALOG oDlg TITLE "Atualizador [UPDANVIS] - Atualizacao concluida." From 3,0 to 340,417 PIXEL
				@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
				oMemo:bRClicked := {||AllwaysTrue()}
				oMemo:oFont:=oFont
				DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
				DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL //Salva e Apaga //"Salvar Como..."
			ACTIVATE MSDIALOG oDlg CENTER
	
		EndIf
		
	EndIf
		
EndIf 	

Return(Nil)



/*/{Protheus.doc} MyOpenSM0Ex
Abertura do arquivo de empresas
@type method
/*/
method MyOpenSM0Ex()  class TSigaUpd

	Local lOpen := .F.
	Local nLoop := 0
	
	For nLoop := 1 To 20
		dbUseArea( .T.,, "SIGAMAT.EMP", "SM0", .F., .F. )
		If !Empty( Select( "SM0" ) )
			lOpen := .T.
			dbSetIndex("SIGAMAT.IND")
			Exit	
		EndIf
		Sleep( 500 )
	Next nLoop
	
	If !lOpen
		Aviso( "Atencao !", "Nao foi possivel a abertura da tabela de empresas de forma exclusiva !", { "Ok" }, 2 )
	EndIf

Return( lOpen )




/*/{Protheus.doc} GeraSX2
Geração ou atualização dos registros de SX2
@type method
@param aRegs, array, registro de descrição de tabelas
/*/
Method GeraSX2(aRegs)  class TSigaUpd
	Local aArea 			:= GetArea()
	Local i      		:= 0
	Local j      		:= 0
	//Local aRegs  		:= {}
	Local cTexto 		:= ''
	Local lInclui		:= .F.
	
	//aRegs  := {}
	//AADD(aRegs,{"ZZZ","                                        ","ZZZ070  ","PRECOS FABRICA ANVISA         ","PRECOS FABRICA ANVISA         ","PRECOS FABRICA ANVISA         ","                                        ","C","E","E",00," ","                                                                                                                                                                                                                                                          "," ",00,"                                                                                                                                                                                                                                                              ","                              ","                              "})
	
	dbSelectArea("SX2")
	dbSetOrder(1)
	
	For i := 1 To Len(aRegs)
	
		dbSetOrder(1)
	 	lInclui := !DbSeek(aRegs[i, 1])
	
	 	cTexto += IIf( aRegs[i,1] $ cTexto, "", aRegs[i,1] + "\")
	
		RecLock("SX2", lInclui)
	  	For j := 1 to FCount()
	   		If j <= Len(aRegs[i])
	   			If allTrim(Field(j)) == "X2_ARQUIVO"
	   				aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
	   			EndIf
	    		/*If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
	     			Loop
	    		Else*/
	     		FieldPut(j,aRegs[i,j])
	    		//EndIf
	   		Endif
	  	Next
	 	MsUnlock()
	 	
	Next i
	
	RestArea(aArea)
Return('SX2 : ' + cTexto  + CHR(13) + CHR(10))



/*/{Protheus.doc} GeraSX3
Geração ou atualização dos registros de SX2
@type method
@param aRegs, array, registro de descrição de campos

/*/
method GeraSX3(aRegs)  class TSigaUpd
	Local aArea 			:= GetArea()
	Local i      		:= 0
	Local j      		:= 0
	//Local aRegs  		:= {}
	Local cTexto 		:= ''
	Local lInclui		:= .F.
	local ciSeq := ""
	
	ciSeq:= ::sfSeqSX3(aRegs[1][1])
	If !Empty(ciSeq)
		for k:= 1 to len(aRegs)
			ciSeq	:=	Soma1(ciSeq,2,.T.)
			aRegs[k][2] := ciSeq
		Next
	Endif
	
	dbSelectArea("SX3")
	dbSetOrder(1)
	
	For i := 1 To Len(aRegs)
	
		If(Ascan(aArqUpd, aRegs[i,1]) == 0)
	 		aAdd(aArqUpd, aRegs[i,1])
	 	EndIf
	
	 	dbSetOrder(2)
	 	lInclui := !DbSeek(aRegs[i, 3])
	
	 	cTexto += IIf( aRegs[i,1] $ cTexto, "", aRegs[i,1] + "\")
	
	 	RecLock("SX3", lInclui)
	  	For j := 1 to FCount()
	   		If j <= Len(aRegs[i])
	   			/*If allTrim(Field(j)) == "X2_ARQUIVO"
	   				aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
	   			EndIf*/
	    		If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
	     			Loop
	    		Else
	     			FieldPut(j,aRegs[i,j])
	    		EndIf
	   		Endif
	  	Next
	 	MsUnlock()
	Next i
	
	
	RestArea(aArea)
Return('SX3 : ' + cTexto  + CHR(13) + CHR(10))

// reordenar campo
// campo vai depois de outro campo
// duas etapas insere o campo e realoca



/*/{Protheus.doc} reordSx3
reordenar os campos
@type method
@param pCampo, ${param_type}, Campo a mover
@param pCpoAntes, ${param_type}, campo apos o qual o pCampo sera instalado
/*/
method reordSx3(pCampo, pCpoAntes) class TSigaUpd
	local cOrdCpoAnt, cArquivo, cOrdCpo, curOrd, curArq, cpoTrat
	local cTexto := ""
	Local aArea 			:= GetArea()
		 
	dbSelectArea("SX3")
	SX3->(dbSetOrder(2))  // X3_CAMPO
	SX3->(DbGoTop())
	
	// procura ordem do campo antes
	if SX3->(DbSeek(pCpoAntes))
		cOrdCpoAnt := SX3->X3_ORDEM
		curOrd :=  SX3->X3_ORDEM
		cArquivo := SX3->X3_ARQUIVO
		SX3->(DbGoTop())
		
		// procura o campo que devemos re ordenar e atualizar a ordem
		if SX3->(DbSeek(pCampo))
			if SX3->X3_ORDEM != Soma1(curOrd) 
				RecLock("SX3", .F.)
				curOrd := Soma1(curOrd)
				SX3->X3_ORDEM = curOrd
				SX3->(MsUnlock())
				
				// re 0rdenar o resto
				SX3->(dbSetOrder(1))  // X3_ARQUIVO+X3_ORDEM
				SX3->(DbGoTop())	
				cpoTrat := pCampo
				if SX3->(DbSeek(cArquivo+curOrd))
					curArq := SX3->X3_ARQUIVO  
					while !SX3->(Eof()) .And. curArq == SX3->X3_ARQUIVO
						if SX3->X3_CAMPO != cpoTrat
							RecLock("SX3", .F.)
							curOrd := Soma1(curOrd)
							SX3->X3_ORDEM = curOrd
							cpoTrat := SX3->X3_CAMPO 
							SX3->(MsUnlock())
							// temos que fechar e re-abrir pois mexemos com a Ordem que faz parte do indexo
							SX3->(DbCloseArea())
							dbSelectArea("SX3")
							SX3->(dbSetOrder(1))
							SX3->(DbSeek(cArquivo+curOrd))								
						endif
						SX3->(DbSkip())  
					enddo 
				endif
			endif
		else
			cTexto += "Campo não encontrado"
		endif		
	else 
		cTexto += "Campo antes não encontrado"	
	endif
	
	RestArea(aArea)
				
return ('SX3 reord: ' + cTexto  + CHR(13) + CHR(10))



/*/{Protheus.doc} GeraSIX
Geração ou atualização dos registros de SIX
@type method
@param aRegs, array, registro de indices
/*/Method GeraSIX(aRegs)  class TSigaUpd
	Local aArea 			:= GetArea()
	Local i      		:= 0
	Local j      		:= 0
	local k
	//Local aRegs  		:= {}
	Local cTexto 		:= ''
	Local lInclui		:= .F.
	local ciSeq := ""
	
	ciSeq  := ::sfSeqSIX(aRegs[1][1])
	If !Empty(ciSeq)
		for k:= 1 to len(aRegs)
			ciSeqAtu	:=	::sfVerInd(aRegs[1][1],aRegs[k][3])
			ciSeq	:=	IIF(Empty(ciSeqAtu),Soma1(ciSeq,1,.T.),ciSeqAtu)
			aRegs[k][2] := ciSeq
			//AADD(aRegs,{"SD3",ciSeq,"D3_FILIAL+D3_XNROC+D3_XITEM+D3_XSEQ				
		next	
	EndIf
	
	
	//aRegs  := {}
	//AADD(aRegs,{"ZZZ","1","ZZZ_FILIAL+ZZZ_EAN                                                                                                                                              ","Filial+Ean                                                            ","Filial+Ean                                                            ","Filial+Ean                                                            ","U","                                                                                                                                                                ","          ","S"})
	
	dbSelectArea("SIX")
	dbSetOrder(1)
	
	For i := 1 To Len(aRegs)
	
		If(Ascan(aArqUpd, aRegs[i,1]) == 0)
	 		aAdd(aArqUpd, aRegs[i,1])
	 	EndIf
	
	 	dbSetOrder(1)
	 	lInclui := !DbSeek(aRegs[i, 1] + aRegs[i, 2])
	 	If !lInclui
	  		TcInternal(60,RetSqlName(aRegs[i, 1]) + "|" + RetSqlName(aRegs[i, 1]) + aRegs[i, 2])
	 	Endif
	
	 	cTexto += IIf( aRegs[i,1] $ cTexto, "", aRegs[i,1] + "\")
	
	 	RecLock("SIX", lInclui)
	  	For j := 1 to FCount()
	   		If j <= Len(aRegs[i])
	//   	If allTrim(Field(j)) == "X2_ARQUIVO"
	//   		aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
	//   	EndIf
	//    If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
	//     Loop
	//    Else
	     		FieldPut(j,aRegs[i,j])
	//    EndIf
		   Endif
	  	Next
	 	MsUnlock()
	Next i
	
	
	RestArea(aArea)
Return('SIX : ' + cTexto  + CHR(13) + CHR(10))




/*/{Protheus.doc} GeraSXB
Geração de SXB
@type method
@todo Não testado - Testar
@param aRegs, array, Registro de SXB
/*/Method GeraSXB(aRegs) class TSigaUpd
	Local aArea 			:= GetArea()
	Local i      		:= 0
	Local j      		:= 0
	//Local aRegs  		:= {}
	Local cTexto 		:= ''
	Local lInclui		:= .F.
	
	//aRegs  := {}
	//AADD(aRegs,{"      "," ","  ","  ","Nome                ","Nombre              ","Name                ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "})
	
	dbSelectArea("SXB")
	dbSetOrder(1)
	
	For i := 1 To Len(aRegs)
	
	 	dbSetOrder(1)
	 	lInclui := !DbSeek(aRegs[i, 1] + aRegs[i, 2] + aRegs[i, 3] + aRegs[i, 4])
	
	 	cTexto += IIf( aRegs[i,1] $ cTexto, "", aRegs[i,1] + "\")
	
	 	RecLock("SXB", lInclui)
	  	For j := 1 to FCount()
	   		If j <= Len(aRegs[i])
	//   	If allTrim(Field(j)) == "X2_ARQUIVO"
	//   		aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
	//   	EndIf
	//    If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
	//     Loop
	//    Else
	     		FieldPut(j,aRegs[i,j])
	//    EndIf
	   		Endif
	  	Next
	 	MsUnlock()
	Next i
	
	
	RestArea(aArea)
Return('SXB : ' + cTexto  + CHR(13) + CHR(10))



/*/{Protheus.doc} sfSeqSX3
Encontra a ultima sequencia da tabela
@type method
@param mvTabela, character, tabela
/*/method sfSeqSX3(mvTabela) class TSigaUpd 
	Local ciRet			:=	""
	Local aiArea 			:= GetArea()
	Local aiAreaSX3		:= SX3->(GetARea())
	Local ciAlias			:=	Padr(mvTabela,Len(SX3->X3_ARQUIVO),"")
	
	DBSelectArea("SX3")
	SX3->(DBSetOrder(1))//X3_ARQUIVO+X3_ORDEM
	SX3->(DBGoTop())
	If SX3->(DBSeek(ciAlias))
		Do While SX3->(!EoF()) .And. SX3->X3_ARQUIVO==ciAlias
			ciRet	:=	SX3->X3_ORDEM
			SX3->(DBSkip())
		EndDo
	EndIf
	
	RestArea(aiArea)
	RestArea(aiAreaSX3)
Return (ciRet)


/*/{Protheus.doc} sfSeqSX7
Encontra a ultima sequencia do gatilho
@type method
@param pCampo, ${param_type}, campo do gatilho
/*/method sfSeqSX7(pCampo) class TSigaUpd 
	Local ciRet			:=	""
//	Local aiArea 			:= GetArea()
	Local aiAreaSX7		:= SX7->(GetArea())
	//Local ciAlias			:=	Padr(mvTabela,Len(SX3->X3_ARQUIVO),"")
	local curCampo
				
	DBSelectArea("SX7")
	SX7->(DBSetOrder(1))
	SX7->(DBGoTop())
	If SX7->(DBSeek(pCampo))
		curCampo := SX7->X7_CAMPO
		Do While SX7->(!EoF()) .And. SX7->X7_CAMPO == curCampo
			ciRet	:=	SX7->X7_SEQUENC
			SX7->(DBSkip())
		EndDo
	EndIf
	
//	RestArea(aiArea)
	RestArea(aiAreaSX7)
Return (ciRet)


/*/{Protheus.doc} sfSeqSIX
Encontra a ultima sequencia do indexo
@type method
@param mvTabela, character, tabela
/*/method sfSeqSIX(mvTabela) class TSigaUpd
	Local ciRet			:=	""
	Local aiArea 			:= GetArea()
	Local aiAreaSIX		:= SIX->(GetARea())
	Local ciAlias			:=	Padr(mvTabela,Len(SIX->INDICE),"")
	
	DBSelectArea("SIX")
	SIX->(DBSetOrder(1))//INDICE+ORDEM
	SIX->(DBGoTop())
	If SIX->(DBSeek(ciAlias))
		Do While SIX->(!EoF()) .And. SIX->INDICE==ciAlias
			ciRet	:=	SIX->ORDEM
			SIX->(DBSkip())
		EndDo
	EndIf
	
	RestArea(aiArea)
	RestArea(aiAreaSIX)
Return (ciRet)




/*/{Protheus.doc} GeraSX7
Gera ou atualiza gatilhos
@type method
@param aRegs, array, contendo a definição dos gatilhos
/*/
Method GeraSX7(aRegs) class TSigaUpd
	Local aArea 			:= GetArea()
	Local i      		:= 0
	Local j      		:= 0
	local k
	//Local aRegs  		:= {}
	Local cTexto 		:= ''
	Local lInclui		:= .F.
	
	ciSeq:= ::sfSeqSX7(aRegs[1][1])
	If !Empty(ciSeq)
		for k:= 1 to len(aRegs)
			ciSeq	:=	Soma1(ciSeq)
			aRegs[k][2] := ciSeq
		Next
	Endif
	
	//aRegs  := {}
	//AADD(aRegs,{"Z03_PROD  ","001","LEFT(SB1->B1_DESC,50)                                                                               ","Z03_DESPRO","P","S","SB1",01,"xFilial('SB1')+M->Z03_PROD                                                                          ","                                        ","U"})
	
	dbSelectArea("SX7")
	dbSetOrder(1)
	
	For i := 1 To Len(aRegs)
	
		dbSetOrder(1)
	 	lInclui := !DbSeek(aRegs[i, 1] + aRegs[i, 2])
	
	 	cTexto += IIf( aRegs[i,1] $ cTexto, "", aRegs[i,1] + "\")
	
		RecLock("SX7", lInclui)
	  	For j := 1 to FCount()
	   		If j <= Len(aRegs[i])
	   			//If allTrim(Field(j)) == "X2_ARQUIVO"
	   				//aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
	   			//EndIf
	    		If !lInclui .AND. AllTrim(Field(j)) == "X7_SEQUENC"
	     			Loop
	    		Else
	     			FieldPut(j,aRegs[i,j])
	    		EndIf
	   		Endif
	  	Next
	 	MsUnlock()
	Next i
	
	RestArea(aArea)
Return('SX7 : ' + cTexto  + CHR(13) + CHR(10))




/*/{Protheus.doc} DelSX7
Deleta certos gatilhos
@type method
@param aRegs, array, na forma {campo, campo dominio}
/*/
Method DelSX7(aRegs) class TSigaUpd
	Local aArea 			:= GetArea()
	Local k      		:= 0
	//Local j      		:= 0
	//Local aRegs  		:= {}
	Local cTexto 		:= ''
	//Local lInclui		:= .F.
	local curCampo
	local cOrdCur
	local aCpoTrat := {}
	local nPos

// Indentificação de um gatilho
// X7_CAMPO, X7_CDOMIN
// aRegs tem a forma {{X7_CAMPO, X7_CDOMIN}}

//aRegs  := {}
//AADD(aRegs,{"Z03_PROD  ","001","LEFT(SB1->B1_DESC,50)                                                                               ","Z03_DESPRO","P","S","SB1",01,"xFilial('SB1')+M->Z03_PROD                                                                          ","                                        ","U"})

// delete dos registros

	dbSelectArea("SX7")
	SX7->(dbSetOrder(1))

	for k := 1 to len(aRegs)
		cTexto += IIf( aRegs[k,1] $ cTexto, "", aRegs[k,1] + "\")
		SX7->(DbGoTop())	
		if SX7->(DbSeek(aRegs[k][1]))
			curCampo := SX7->X7_CAMPO
			while !SX7->(EOF()) .And. SX7->X7_CAMPO == curCampo
				if Alltrim(SX7->X7_CDOMIN) == allTrim(aRegs[k][2])
					RecLock("SX7", .F.)
					SX7->(DbDelete())
					SX7->(MsUnlock())
					exit
				endif  
				SX7->(DbSkip())
			enddo  			
		endif				
	next

	RestArea(aArea)

	for k := 1 to len(aRegs)
		cTexto += IIf( aRegs[k,1] $ cTexto, "", aRegs[k,1] + "\")
		SX7->(DbGoTop())	
		nPos := ascan(aCpoTrat, {|x| x == aRegs[k][1]})
		if nPos == 0
			aadd(aCpoTrat, aRegs[k][1])
			::reordSX7(aRegs[k])							
		endif
	next	
		
Return('SX7 : ' + cTexto  + CHR(13) + CHR(10))




/*/{Protheus.doc} reordSX7
Reordenar os gatilhos. Tira os buracos da sequencia
@type method
@param aRegs, array, (Descrição do parâmetro)
/*/
method reordSX7(aRegs)  class TSigaUpd
	Local aArea 			:= GetArea()
	Local k      		:= 0
	//Local j      		:= 0
	//Local aRegs  		:= {}
	Local cTexto 		:= ''
	//Local lInclui		:= .F.
	local curCampo
	local cOrdCur

// re-ordenação
//	cOrdCur := '001'
	//aCpoTrat := {}
	dbSelectArea("SX7")
	SX7->(dbSetOrder(1))
	SX7->(DbGoTop())
	
	if SX7->(DbSeek(aRegs[1]))
		curCampo := SX7->X7_CAMPO
		cOrdCur := '001'
		while !SX7->(EOF()) .And. SX7->X7_CAMPO == curCampo
//					cOrdem := SX7->X7_SEQUENC
			if SX7->X7_SEQUENC != cOrdCur
				RecLock("SX7", .F.)
				SX7->X7_SEQUENC := cOrdCur   
				SX7->(MsUnlock())
				// temos que fechar e re-abrir pois mexemos com a Ordem que faz parte do indexo
				SX7->(DbCloseArea())
				dbSelectArea("SX7")
				SX7->(dbSetOrder(1))
				SX7->(DbSeek(aRegs[1]+cOrdCur))
			endif
			cOrdCur := Soma1(cOrdCur)  
			SX7->(DbSkip())
		enddo  			
	endif				

	RestArea(aArea)
return




/*/{Protheus.doc} sfVerInd
Verifica se o Indice mudou
@type method
@param mvTabela, character, tabela
@param mvChave, character, a chave do indice sendo procurado
@return character, valor da chave quando encontrada, vazio se não
/*/
Method sfVerInd(mvTabela,mvChave) class TSigaUpd
	Local ciRet			:=	""
	Local aiArea 			:= GetArea()
	Local aiAreaSIX		:= SIX->(GetARea())
	Local ciAlias			:=	Padr(AllTrim(mvTabela),Len(SIX->INDICE)," ")
	Local ciChave			:=	Padr(AllTrim(mvChave),Len(SIX->CHAVE)," ")
	
	DBSelectArea("SIX")
	SIX->(DBSetOrder(1))//INDICE+ORDEM
	SIX->(DBGoTop())
	If SIX->(DBSeek(ciAlias))
		Do While SIX->(!EoF()) .And. SIX->INDICE==ciAlias
			If SIX->CHAVE==ciChave
				ciRet	:=	SIX->ORDEM
				ConOut("Existe a Chave" +ciChave)
				Exit
			EndIf
			SIX->(DBSkip())
		EndDo
	EndIf
	
	RestArea(aiArea)
	RestArea(aiAreaSIX)
Return (ciRet)
