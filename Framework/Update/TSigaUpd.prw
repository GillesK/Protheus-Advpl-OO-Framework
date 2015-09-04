#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


    
#DEFINE ENTER CHR(13)+CHR(10)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSigaUpd   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de compatibilizacao Protheus (cria��o/update no dicionario)		  ���
���          �  Criado a partir da rotina Totvs HSPGERAT() (executado em formulas) e complementos  ���
���          �  de handerson Duarte                                        ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Class TSigaUpd
	
	method ProcATU(sTabela, aRegsTab, aRegsCpo, aRegsInd, aRegsGatilhos) 
	method MyOpenSM0Ex()  
	Method GeraSX2(aRegs) 	
	method GeraSX3(aRegs) 
	Method GeraSIX(aRegs) 	
	method sfSeqSIX(mvTabela)	
	method sfSeqSX3(mvTabela)	
	Method GeraSXB(aRegs)	
	Method sfVerInd(mvTabela,mvChave)
	Method GeraSX7()	 	
 	
EndClass





/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �ProcATU   � Autor �                       � Data �  /  /    ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao de processamento da gravacao dos arquivos           ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Baseado na funcao criada por Eduardo Riera em 01/02/2002   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
method ProcATU(sTabela, aRegsTab, aRegsCpo, aRegsInd, aRegsGatilhos)  class TSigaUpd
Local cTexto    	:= ""
Local cFile     	:= ""
Local cMask     	:= "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    	:= 0
Local nI        	:= 0
Local nX        	:= 0
Local aRecnoSM0 	:= {}
Local lOpen     	:= .F.

ProcRegua(1)
IncProc("Verificando integridade dos dicion�rios....")
If (lOpen := IIF(Alias() <> "SM0", MyOpenSm0Ex(), .T. ))

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

			//����������������������������������Ŀ
			//�Atualiza o dicionario de arquivos.�
			//������������������������������������
			if aRegsTab != nil
				if Len(aRegsTab) >0
					IncProc("Analisando Dicionario de Arquivos...")
					cTexto += GeraSX2(aRegsTab)
				endif
			endif
			//�������������������������������Ŀ
			//�Atualiza o dicionario de dados.�
			//���������������������������������
			if aRegsCpo != nil
				if Len(aRegsCpo) >0			
					IncProc("Analisando Dicionario de Dados...")
					cTexto += GeraSX3(aRegsCpo, sTabela)
				endif
			endif					
			//�������������������������������Ŀ
			//�Atualiza os gatilhos.          �
			//���������������������������������
			if aRegsGatilhos != nil
				if Len(aRegsGatilhos) >0			
					IncProc("Analisando Gatilhos...")
					cTexto += GeraSX7(aRegsGatilhos)
				endif
			endif						
			//��������������������Ŀ
			//�Atualiza os indices.�
			//����������������������
			if aRegsInd != nil
				if Len(aRegsInd) >0			
					IncProc("Analisando arquivos de �ndices. "+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
					cTexto += GeraSIX(aRegsInd,sTabela)
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
			If !( lOpen := MyOpenSm0Ex() )
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


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �MyOpenSM0Ex� Autor �Sergio Silveira       � Data �07/01/2003���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Efetua a abertura do SM0 exclusivo                         ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Atualizacao FIS                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
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




/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � GeraSX2  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Funcao generica para copia de dicionarios                  ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Method GeraSX2(aRegs)  class TSigaUpd
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aRegs  		:= {}
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
Return('SX2 : ' + cTexto  + CHR(13) + CHR(10))
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � GeraSX3  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Funcao generica para copia de dicionarios                  ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
method GeraSX3(aRegs, sTabela)  class TSigaUpd
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
//Local aRegs  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.
local ciSeq := ""

ciSeq:=sfSeqSX3(sTabela)
If !Empty(ciSeq)
	for k:= 1 to len(aRegs)
		ciSeq	:=	Soma1(ciSeq,2,.T.)
		aRegs[k][2] := ciSeq
	Next
Endif
/*aRegs  := {}
AADD(aRegs,{"ZZZ","01","ZZZ_FILIAL","C",02,00,"Filial      ","Sucursal    ","Branch      ","Filial do Sistema        ","Sucursal                 ","Branch of the System     ","@!                                           ","                                                                                                                                ","���������������","                                                                                                                                ","      ",01,"��"," "," ","U","N"," "," "," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","033"," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","02","ZZZ_PRIATI","C",**,00,"Princ. Ativo","Princ. Ativo","Princ. Ativo","Principio Ativo          ","Principio Ativo          ","Principio Ativo          ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","03","ZZZ_CNPJ  ","C",14,00,"Cnpj        ","Cnpj        ","Cnpj        ","Cnpj                     ","Cnpj                     ","Cnpj                     ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","04","ZZZ_LABORA","C",**,00,"Laboratorio ","Laboratorio ","Laboratorio ","Laboratorio              ","Laboratorio              ","Laboratorio              ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","05","ZZZ_CGGREM","C",15,00,"Cod. Ggrem  ","Cod. Ggrem  ","Cod. Ggrem  ","Codigo Ggrem             ","Codigo Ggrem             ","Codigo Ggrem             ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","06","ZZZ_EAN   ","C",14,00,"Ean         ","Ean         ","Ean         ","Ean                      ","Ean                      ","Ean                      ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","07","ZZZ_PRODUT","C",**,00,"Produto     ","Produto     ","Produto     ","Produto                  ","Produto                  ","Produto                  ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","08","ZZZ_APRESE","C",**,00,"Apresentacao","Apresentacao","Apresentacao","Apresentacao             ","Apresentacao             ","Apresentacao             ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","09","ZZZ_CLATER","C",**,00,"Clas. Terape","Clas. Terape","Clas. Terape","Classe Terapeutica       ","Classe Terapeutica       ","Classe Terapeutica       ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","10","ZZZ_PF0   ","N",12,02,"PF0         ","PF0         ","PF0         ","Preco Fabrica 0%         ","Preco Fabrica 0%         ","Preco Fabrica 0%         ","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","11","ZZZ_PF12  ","N",12,02,"PF12        ","PF12        ","PF12        ","Preco fabrica 12%        ","Preco fabrica 12%        ","Preco fabrica 12%        ","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","12","ZZZ_PF17  ","N",12,02,"PF17        ","PF17        ","PF17        ","Preco fabrica 17%        ","Preco fabrica 17%        ","Preco fabrica 17%        ","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","13","ZZZ_PF18  ","N",12,02,"PF18        ","PF18        ","PF18        ","Preco fabrica 18%        ","Preco fabrica 18%        ","Preco fabrica 18%        ","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","14","ZZZ_PF19  ","N",12,02,"PF19        ","PF19        ","PF19        ","Preco fabrica 19%        ","Preco fabrica 19%        ","Preco fabrica 19%        ","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","15","ZZZ_PF17MA","N",12,02,"PF17MA      ","PF17MA      ","PF17MA      ","Preco fabrica 17% Manaus ","Preco fabrica 17% Manaus ","Preco fabrica 17% Manaus ","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","16","ZZZ_PMC0  ","N",12,02,"PMC0        ","PMC0        ","PMC0        ","Preco max. consumidor 0% ","Preco max. consumidor 0% ","Preco max. consumidor 0% ","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","17","ZZZ_PMC12 ","N",12,02,"PMC12       ","PMC12       ","PMC12       ","Preco max. consumidor 12%","Preco max. consumidor 12%","Preco max. consumidor 12%","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","18","ZZZ_PMC17 ","N",12,02,"PMC17       ","PMC17       ","PMC17       ","Preco max. consumidor 17%","Preco max. consumidor 17%","Preco max. consumidor 17%","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","19","ZZZ_PMC18 ","N",12,02,"PMC18       ","PMC18       ","PMC18       ","Preco max. consumidor 18%","Preco max. consumidor 18%","Preco max. consumidor 18%","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","20","ZZZ_PMC19 ","N",12,02,"PMC19       ","PMC19       ","PMC19       ","Preco max. consumidor 19%","Preco max. consumidor 19%","Preco max. consumidor 19%","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","21","ZZZ_PMC17M","N",12,02,"PMC17M      ","PMC17M      ","PMC17M      ","Preco max. consum. 17% Ma","Preco max. consum. 17% Ma","Preco max. consum. 17% Ma","@E 999,999,999.99                            ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","22","ZZZ_RESHOS","C",01,00,"Rest. Hospit","Rest. Hospit","Rest. Hospit","Restricao Hospitalar     ","Restricao Hospitalar     ","Restricao Hospitalar     ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","23","ZZZ_CAP   ","C",01,00,"Cap         ","Cap         ","Cap         ","Cap                      ","Cap                      ","Cap                      ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})
AADD(aRegs,{"ZZZ","24","ZZZ_CFAZ87","C",01,00,"Confaz 87   ","Confaz 87   ","Confaz 87   ","Confaz 87                ","Confaz 87                ","Confaz 87                ","                                             ","                                                                                                                                ","���������������","                                                                                                                                ","      ",00,"��"," "," ","U","N","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","   ","N","N","N"})*/

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
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
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


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � GeraSIX  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Funcao generica para copia de dicionarios                  ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Method GeraSIX(aRegs, sTabela)  class TSigaUpd
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
//Local aRegs  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.
local ciSeq := ""

ciSeq  :=sfSeqSIX(sTabela)
If !Empty(ciSeq)
	for k:= 1 to len(aRegs)
		ciSeqAtu	:=	sfVerInd(sTabela,aRegs[k][3])
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
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
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
Return('SIX : ' + cTexto  + CHR(13) + CHR(10))
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � GeraSXB  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Funcao generica para copia de dicionarios                  ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Method GeraSXB(aRegs) class TSigaUpd
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aRegs  		:= {}
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
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
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
Return('SXB : ' + cTexto  + CHR(13) + CHR(10))


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � sfSeqSX3  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Captura a Ultima Sequencia da Ordem da Tabela para Gravas o Campo    ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
method sfSeqSX3(mvTabela) class TSigaUpd 
	Local ciRet			:=	""
	Local aiArea 			:= GetArea()
	Local aiAreaSX3		:= SX3->(GetARea())
	Local ciAlias			:=	Padr(mvTabela,Len(SX3->X3_ARQUIVO),"")
	
	DBSeletArea("SX3")
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

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � sfSeqSIX  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Captura a Ultima Sequencia da Ordem da Tabela para Gravas o �ndice    ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
method sfSeqSIX(mvTabela) class TSigaUpd
	Local ciRet			:=	""
	Local aiArea 			:= GetArea()
	Local aiAreaSIX		:= SIX->(GetARea())
	Local ciAlias			:=	Padr(mvTabela,Len(SIX->INDICE),"")
	
	DBSeletArea("SIX")
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

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � GeraSX7  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Funcao generica para copia de dicionarios                  ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Method GeraSX7(aRegs) class TSigaUpd
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
//Local aRegs  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.

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
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aRegs[i,j] := SubStr(aRegs[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
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
Return('SX7 : ' + cTexto  + CHR(13) + CHR(10))

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � sfVerInd  � Autor � MICROSIGA             � Data �   /  /   ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Verifica se a Chave do �ndice j� existe ou n�o    ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Method sfVerInd(mvTabela,mvChave) class TSigaUpd
	Local ciRet			:=	""
	Local aiArea 			:= GetArea()
	Local aiAreaSIX		:= SIX->(GetARea())
	Local ciAlias			:=	Padr(AllTrim(mvTabela),Len(SIX->INDICE)," ")
	Local ciChave			:=	Padr(AllTrim(mvChave),Len(SIX->CHAVE)," ")
	
	DBSeletArea("SIX")
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
