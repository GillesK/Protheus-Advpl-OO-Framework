#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


    
#DEFINE ENTER CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TSIMPCSV   º Autor ³ Gilles Koffmann   º Data  ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de Importação de dados via arquivo csv   			  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework Copyright Sigaware Pb                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/



/*/{Protheus.doc} TSImpCsv
Classe de base para importação via arquivo CSV.
@type class
@author Gilles Koffmann - Sigaware Pb
@since 02/11/2013
@version 1.2
/*/
Class TSImpCsv
	
//	Data sOption
	Data sArquivo
//	Data sTable
//	Data aDef

	Data nLinCol

/*/{Protheus.doc} nLinDat
Linha do arquivo onde começam os dados
@type property
/*/	 
	Data nLinDat

/*/{Protheus.doc} nLinTit
Linha do arquivo onde estão os titulos para verifição de layout
@type property

/*/	 	
	Data nLinTit

/*/{Protheus.doc} aTitulos
Array onde estão os nomes dos titulos do arquivo para verificação do layout
O Array tem que ser pre-ecnhido na mesma ordem que as colunas do arquivo 
@type property
@example
	aAdd(::aTitulos, "APRESENTAÇÃO")
/*/	 		
	Data aTitulos

/*/{Protheus.doc} aColunas
Array onde estão os nomes e os tipos dos campos nas tabelas protheus.
O Array tem que ser pre-ecnhido na mesma ordem que as colunas do arquivo
@type property
@example
	aAdd(::aColunas, {"ZZZ_APRESE", "C" })
/*/	 		 
	Data aColunas
	
/*/{Protheus.doc} aVetor
Array contendo os dados de 1 linha do arquivo de entrada.
@type property
@example
	aadd(::aVetor, {::aColunas[nX][1], conversao, NIL})
/*/	 		  	
	Data aVetor	
	
	Method New() Constructor
	Method doImport()
	
	Method procLinha()	
	Method criaVect()
	Method procString()
	
	Method callExec()
//	Method callExe2() 
//	Method callExe3()
	
//	Method update()
	Method sfZap() 	
//	Method procErro() 
//	Method identErro()
	 
//	Method idFrnCGC()
//	Method idCodMun() 
//	Method idFrnIE()
	
	Method prepCols() 
	method prepFiles()
	method tratEspec()
	method readHead()
	method confFile()
	method linhaComp()	
		
	method prepTits()
EndClass

/*/{Protheus.doc} New
Constructor
@type method
@param sArquivo, character, caminho completo do arquivo para importar
/*/
Method New( sArquivo ) Class TSImpCsv
	//::sOption := sOption
	::sArquivo := sArquivo       
	//::sTable := sTable
	::nLinCol := 0
	::nLinDat := 5
	::nLinTit := 4
	::aTitulos := {}
	::aColunas := {}		        
//	::aDef := { {1,"", 2},{2,"", 2}, ;
	//		{10,"", 1}, {11,"", 1}, {12,"", 1}, {13,"", 1}, {14,"", 1},;
		//	 {100,"SE2",3},  {101,"SN1",3},  {102,"SB1",3},   {103,"SA1",3}}
	::aVetor := {}	
return Self                      

/*/{Protheus.doc} prepTits
Método para informar os titúlos do arquivo se quiser fazer o controle de layout.
Os títulos devem ser informado dentro de aTitulos respeitando a ordem das colunas
do arquivo sendo importado
@type method
@example
	aAdd(::aTitulos, "APRESENTAÇÃO")
@see aTitulos
/*/
Method prepTits()  Class TSImpCsv

return


/*/{Protheus.doc} callExec
Método responsavel pela atualização no Protheus. Chamado para cada linha do arquivo de entrada
@type method
/*/
Method callExec()  Class TSImpCsv

return


/*/{Protheus.doc} prepCols
Método para informar os campos da tabela Protheus sendo importada.
Os campos devem ser informados dentro de aColunas respeitando a ordem das colunas
do arquivo sendo importado
@type method
@example
	aAdd(::aColunas, {"ZZZ_APRESE", "C" })
@see aColunas
/*/
Method prepCols() class TSImpCsv

	cLinha  := aHead[::nLinCol]
	aColu := Separa(cLinha,";",.T.)
	                           
	// identificar tipos
	DbSelectArea("SX3")
  	SX3->(DbSetOrder(2))      
	For nX := 1 to Len(aColu)
		If SX3->(DbSeek(AllTrim(aColu[nX])))
			aAdd(::aColunas, {Alltrim(aColu[nX]), SX3->X3_TIPO })
//		else
//			aadd(::aColunas, {"", ""})
	    Endif                            
    Next nX
    
    cBobLol := ""
return


/*/{Protheus.doc} tratEspec
Tratamento específico de um campo. Para classes filhas
@type method
@param nX, numérico, O indice da coluna sendo tratada para acessar aColunas
@param cInput, character, dado a tratar
@return character, dado tratado
/*/
Method tratEspec(nX, cInput) class TSImpCsv
		
return 


/*/{Protheus.doc} doImport
Método principal para executar a importação
@type method
/*/
Method doImport()  class TSImpCsv

	static aExcCol := {}
	static nHandle, nHLog, nHLogExec, nRegistro := 2
//	static aVetor := {}            
	static aColu := {}         
	static aHead := {}	          
	static conversao, lEnd                   
	static cLinha, cLinhaLog
	static logDir := "c:\Totvs\LogImport\"
	static cUserId := __cUserId
	static logFile := "ImportacaoCsv_Log_" + cUserId  + "_" + dtos(Date()) + "_" + ;
		    			SUBSTR(TIME(), 1, 2) + SUBSTR(TIME(), 4, 2) + SUBSTR(TIME(), 7, 2) ;
		    			+ ".log"
	private lImp := .F.	

//	private sTable 
//	private nProcess := ::aDef[AScanX(::aDef, {|x,y|x[1]==val(::sOption) })][3]

//	if nProcess != 2
	//	::sTable := ::aDef[AScanX(::aDef, {|x,y|x[1]==val(::sOption) })][2]
//	Endif
		
	if !self:prepFiles()
		return
	endif
	
	// Ler o header do arquivo
	self:readHead()
	
	// inicializar o array com o nome dos titulos
	self:prepTits()
	
	// verificar que é o layout esperado
	if self:confFile()	
		self:prepCols()
	
		aDadosTemp := {}
		
		if !Empty(::sTable)
			DbSelectArea(::sTable)
		EndIf
		
		While !FT_FEOF(nHandle)
		       
		 	::aVetor := {}
			IncProc("Lendo arquivo, aguarde...")
		 
			cLinha := FT_FREADLN(nHandle)
			
			// testar linha inteira
			cLinha := self:linhaComp(cLinha)
			cLinha := self:procLinha(cLinha) 
			aDadosTemp := Separa(cLinha,";",.T.)
			                                                            
			if (Len(aDadosTemp) > 1)
				self:criaVect()
				nTamArX := len(::aVetor)
				self:callExec()				
				/*Do Case	
				   // tipo de processamento				   	
					Case nProcess == 1  // ExecAuto padrão
						lImp := .F.
						while !lImp		
							self:callExec()		        		           
							self:procErro()
							lImp := .t.
						EndDo						
					Case nProcess == 2 // Insert tabela Generica
						self:callExe2()
					Case nProcess == 3   // Processamento especifico
						self:callExe3()
					Otherwise
						MsgStop("Tipo de processamento não definido")
						exit
				EndCase*/								
			EndIf
			
			FT_FSKIP(nHandle)                                 
			nRegistro += 1
		EndDo
	else
		MsgStop("O layout do arquivo de dados é diferente do esperado. Por favor contate o suporte TI / Protheus", "TImpCsv:Erro")
	EndIf
		 
	FT_FUSE()
	FClose(nHLog)    
		 
	ApMsgInfo("Importação do registros concluída com sucesso! Verifique o arquivo de log","SUCESSO")
	
return  



// PROTECTED



Method linhaComp(input) class TSImpCsv
	local aDadosT, nextLine 
	// para tratar o LFCR numa linha
	aDadosT := Separa(input,";",.T.)
	while Len(aDadosT) < Len(::aColunas)
		// Read Next Line		
		FT_FSKIP(nHandle)		
		nextLine := FT_FREADLN(nHandle)
		input := input + nextLine
		aDadosT := Separa(input,";",.T.)		
	end while
return input


Method readHead() class TSImpCsv
	// ler o cabeçalho do arquivo
	FT_FGOTOP(nHandle)
	for i := 1 to ::nLinDat - 1
		aadd(aHead, FT_FReadLn(nHandle))	
		FT_FSKIP(nHandle)
	end
return

// Metodo para tirar as aspas eventuais
Method procLinha(cNoAspa) class TSImpCsv
	local cNoAspa2 := ""
	local lEnd := .T.
	local nPos1, nPos2
	local cPart1, cPart2, cPart3, cPartInt
	
	while lEnd
		nPos1 := at('"', cNoAspa)
		if nPos1 != 0
			// cPart1"cPart2"cPart3
			cPart1 := substr(cNoAspa, 1, nPos1)
			cPartInt := substr(cNoAspa, nPos1 + 1 , 9999 )
	
			nPos2 := at('"', cPartInt)
			cPart2 := 	substr(cPartInt,  1 , nPos2)
			cPart2 := strtran(cPart2,";",",") //parte2 - só o valor até a 2ª aspas, eliminando todas as virgulas
						
			cPart3 := substr(cPartInt,  nPos2 +1 , 9999)
//			nPos2 := at('"', substring(cString,waspa1+1,9999)) //busca posição da 2ª aspa após a 1ª aspa
			cNoAspa2 += cPart1+cPart2 
			cNoAspa := cPart3
		else
			cNoAspa2 += cNoAspa 
			lEnd := .F.
		endif	
	EndDo
return cNoAspa2


Method criaVect() class TSImpCsv
			// Cria o vector
	local cNoAspa, cNoAspa2, lEnd        
	for nX := 1 to len(::aColunas)
		if ::aColunas[nX][1] != ""
			if AScanX(aExcCol, {|x,y| x == AllTrim(::aColunas[nX][1])}) == 0
				if substr(aDadosTemp[nX], 1, 2) != "<#"
					// trata aspa
					cNoAspa := aDadosTemp[nX]
					cNoAspa := self:procString(cNoAspa) 				 
					
					Do Case								
						Case ::aColunas[nX][2] == 'C'
							if len(cNoAspa) > 250
								conversao := substr(cNoAspa, 1, 250)
							else
								conversao := cNoAspa 
							EndIf						 					  		
						Case ::aColunas[nX][2] == 'N' 
							nPos := at(',', cNoAspa)
							If nPos > 0
				        		conversao := val(strtran(cNoAspa,',', '.'))	
				        	Else
					        	conversao := val(cNoAspa)	
				        	EndIf
				        							
						Case ::aColunas[nX][2] == 'D'				        				
			        		conversao := stod(alltrim(cNoAspa))
					EndCase
																	
					conversao = self:tratEspec(nX, conversao)
					aadd(::aVetor, {::aColunas[nX][1], conversao, NIL})
				EndIf
			Endif
		EndIf	
	next nX
return





Method procString(cNoAspa) class TSImpCsv
	local nPos1
	
	if at("'", cNoAspa) = 1
		cNoAspa := substr(cNoAspa, 2, len(cNoAspa))
		if at("'", cNoAspa) = len(cNoAspa)
			if len(cNoAspa) == 1
				cNoAspa := ""
			else
				cNoAspa := substr(cNoAspa, 1, len(cNoAspa) - 1)
			endif
		EndIf
	EndIf
					
	// trata dupla aspa
	if at('"', cNoAspa) = 1
		cNoAspa := substr(cNoAspa, 2, len(cNoAspa))
		if rat('"', cNoAspa) = len(cNoAspa)
			if len(cNoAspa) == 1
				cNoAspa := ""
			else
				cNoAspa := substr(cNoAspa, 1, len(cNoAspa) - 1)
			endif
		EndIf
	EndIf					
					
		//  trata dupla aspa no corpo
	lEnd := .T.
	cNoAspa2 := ""
	while lEnd
		nPos1 := at('"', cNoAspa)
		if nPos1 != 0
			if substr(cNoAspa, nPos1 + 1 , 1 ) == '"'
				cNoAspa2 += substr(cNoAspa, 1, nPos1 - 1) + '"'
				if nPos1 + 1 == len(cNoAspa)  
					lEnd := .F.
				else
					cNoAspa := substr(cNoAspa, nPos1 + 2, Len(cNoAspa))							
				endIf    		
			endif
		else
			cNoAspa2 += cNoAspa 
			lEnd := .F.
		endif	
	EndDo
return cNoAspa2



Method sfZap(cTab) class TSImpCsv
	local cTabela := RetSqlName(cTab)
	cAlias := "TMP"
	
	USE (cTabela) ALIAS (cAlias) EXCLUSIVE NEW VIA "TOPCONN"
	If NetErr()   
		MsgStop("Nao foi possivel abrir "+cTabela+" em modo EXCLUSIVO.")
		return .F.     
	Else   
		ZAP   
		USE   
		MsgStop("Registros da tabela "+cTabela+" eliminados com sucesso.")
		return .T.		
	Endif
return



method confFile() class TSImpCsv
	local cLinha
	local aTit := {}
	local ret := .T.
	
	if Len(::aTitulos) != 0
		cLinha  := aHead[::nLinTit]
		aTit := Separa(cLinha,";",.T.)
	
		For nX := 1 to Len(aTit)
       	if AllTrim(aTit[nX]) != ::aTitulos[nX]
       		ret := .F.
       		exit
       	EndIf                     
   		Next nX
   	EndIf 	
return ret



Method prepFiles() class TSImpCsv

	If !File(::sArquivo)
		MsgStop("O arquivo " + ::sArquivo + " não foi encontrado. A importação será abortada!","ATENCAO")
		Return .F.
	EndIf
	 
	nHandle := FT_FUSE(::sArquivo)
	if nHandle = -1  
		MsgStop("Não foi possivel abrir o arquivo " + ::sArquivo ,"ATENCAO")
		Return .F.
	endif
	
	ProcRegua(FT_FLASTREC(nHandle))
                                                     
	// criar arquivo de log e escrever header (data de processamento / arquivo processado / parametros)

    nHLog := FCREATE(logDir + logFile)
	If nHLog == -1   
		Alert("Erro ao criar o arquivo " + logDir + logFile + " Erro: " + Str(Ferror()))
		return .F.
	Else   
		FWrite(nHLog, dtoc(Date()) + " " + time() + " " + ::sArquivo +  " " + ENTER)   
	EndIf                                       

return .T.



/*Method  callExec() class TImpCsv
			// Chama rotina de inclusao Produto
	lMsErroAuto := .F.          
	nTamArX := len(::aVetor)
			
	Do Case			
		Case ::sOption == "10" // clientes	
			MSExecAuto({|x,y| Mata030(x,y)},aVetor,3) 				
		        
		Case ::sOption == "11" // fornecedores					
			MSExecAuto({|x,y| Mata020(x,y)},aVetor,3) 				
		        		                           
		Case ::sOption == "12"	// Produto			
			MSExecAuto({|x,y| Mata010(x,y)},aVetor,3) 				

		Case ::sOption == "13" // Plano de conta					
			MSExecAuto( {|X,Y,Z| CTBA020(X,Y,Z)} ,aVetor , 3, {}) 				
	
		Case  ::sOption == "14"	// Contatos
		//MSExecAuto({|x,y| TMKA070(x,y)}, aVetor,3)
			MSExecAuto({|x,y,z,a,b|TMKA070(x,y,z,a,b)},aVetor,3,{},{}, .F.)  
	EndCase

					
return*/

/*Method callExe2() class TImpCsv   
   	nTamArX := len(aVetor)
   
   if nTamArX > 0   
   		self:update(.T., 1)				
	EndIf
return*/

/*Method callExe3() class TImpCsv
	local sTable := ::sTable
	Do Case
		Case ::sOption == "100"	// c. pagar
			//dbSelectArea('SE2')                          
			&(sTable)->(DbSetOrder(1))
			//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA                                                    
			cChvTmp := padr(aVetor[1][2], 3)+aVetor[2][2]+aVetor[4][2]+padr(aVetor[5][2], 3)+padr(aVetor[6][2], 3)+aVetor[8][2]+aVetor[9][2]
			// ESTA PESQUISA NAO ESTA CERTA: DEDPENDANDO Do ARQUIVO DE ENTRADA
			While &(sTable)->(dbSeek(cChvTmp))
				aVetor[5][2] := cValToChar((val(SE2->E2_PARCELA)+1))
				cChvTmp := padr(aVetor[1][2], 3)+aVetor[2][2]+aVetor[4][2]+padr(aVetor[5][2], 3)+padr(aVetor[6][2], 3)+aVetor[8][2]+aVetor[9][2]
			EndDo     
			lTst := .t.
			self:update(.T., 1)
			
		Case ::sOption == "101" .and. nTamArX > 0 // sn1
			//dbSelectArea('SN1')
			//N1_FILIAL+N1_CBASE+N1_ITEM
			if !(&(sTable)->(dbSeek(xFilial(sTable)+aVetor[3][2]+aVetor[3][2])))  // AQUI TEM UM PROBLEMA
				self:update(.T., 1)
			Else
				MsgStop('Linha já existe ou é duplicada: Filial:'+aVetor[2][2]+ ' Codigo Base: ' +aVetor[3][2])
			EndIf	


		Case ::sOption == "102" .and. nTamArX > 0  // sb1 complemento
          //dbSelectArea('SB1')        
			if &(sTable)->(dbSeek(xFilial(sTable)+aVetor[1][2]))  // ESTA PESQUISA NAO ESTA CERTA: DEDPENDANDO Do ARQUIVO DE ENTRADA
				self:update(.F., 2)
			EndIf

	
		Case ::sOption == "103" .and. nTamArX > 0  // sa1 complemento
	        //dbSelectArea('SA1')        
			if &(sTable)->(dbSeek(xFilial(sTable)+aVetor[1][2]))  // ESTA PESQUISA NAO ESTA CERTA: DEDPENDANDO Do ARQUIVO DE ENTRADA
				self:update(.F., 2)
			EndIf
	EndCase	
			
return*/

/*Method update(lIns, nIndIni) class TImpCsv
   	local sTable := ::sTable
   	nTamArX := len(aVetor)
   
   //dbSelectArea(sTable)	
	Reclock(sTable, lIns)
	For Nx := nIndIni To nTamArX					
		nPosCmp := FieldPos(aVetor[Nx][1])
		If nPosCmp > 0
			&(sTable)->(fieldPut(nPosCmp, aVetor[Nx][2]))//AC8->&aVetor[Nx][1] := aVetor[Nx][2]	
		EndIf	
	Next Nx
	&(sTable)->(MsUnlock())
return*/


/*Method procErro() class TImpCsv
	if lMsErroAuto            
		// delete file
		FErase('c:\Totvs\logImport\importacaolog.log')
		MostraErro('c:\Totvs\logImport\', 'importacaolog.log')
		
		if !self:identErro()
			// Abrir arquivo
			FWrite(nHLog, "Registro: " + str(nRegistro)  + ENTER)   				
	
	//		nHLogExec := FT_FUSE('c:\Download\importacaolog.log')
			nHLogExec := FOpen('c:\Totvs\logImport\importacaolog.log')
			lEnd := .F.
			while !lEnd
				cLinhaLog := FReadStr(nHLogExec, 100)					
												
				FWrite(nHLog, cLinhaLog  )														
				if (Len(cLinhaLog) < 100)
					lEnd := .T.						
				EndIf
			EndDo						
			FClose(nHLogExec)
			lImp := .T.
		EndIf    
		// Processar para botar no arquivo de log
		// Numero de registro | Mensagem | Dado invalido
	else
		lImp := .T.  
	Endif
return */

/*Method identErro() class TImpCsv
	nHLogExec := FOpen('c:\Totvs\logImport\importacaolog.log')
	lEnd := .F.
	lIdent := .F.
	while !lEnd .And. !lIdent
		cLinhaLog := FReadStr(nHLogExec, 65536)					
				
		lIdent := self:idFrnCGC()
		if !lIdent
			lIdent := self:idFrnIE()
		EndIf		
//		if !lIdent
	//		lIdent := idCodMun()
		//EndIf				
//		idFrnEnder()			
		if (Len(cLinhaLog) < 65536)
			lEnd := .T.						
		EndIf
	EndDo						
	FClose(nHLogExec)    
return lIdent

Method idFrnCGC() class TImpCsv
	local nPos
	local nRet := .F.
	if (at("HELP: CGC",cLinhaLog) > 0) .Or. (at("HELP: CPFINVALID",cLinhaLog) > 0)
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(aVetor, {|x,y|x[1]=='A2_CGC'})
		if nPos > 0
			aVetor[nPos][2] := ""
		endIf				
	endif
return nRet

Method idCodMun() class TImpCsv
	local nPos
	local nRet := .F.
	if (at("HELP: REGNOIS",cLinhaLog) > 0)
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(aVetor, {|x,y|x[1]=='A2_COD_MUN'})
//		adel(aVetor, nPos)
		if nPos > 0
			aVetor[nPos][2] := "99999"
		endIf				
	endif
return nRet

Method idFrnIE() class TImpCsv
	local nPos
	local nRet := .F.
	if at("HELP: IE",cLinhaLog) > 0
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(aVetor, {|x,y|x[1]=='A2_INSCR'})
		if nPos > 0
			aVetor[nPos][2] := ""
		endIf				
	endif
return nRet */
