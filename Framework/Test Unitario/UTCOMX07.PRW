#INCLUDE "protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "XMLXFUN.CH"        
#INCLUDE 'fileio.ch'                      
#INCLUDE "folder.ch"   
#include "msobject.ch"


// Inserção 3 ou exclusao 5 de Ordem de coleta referente a NF de devolução de venda
user function UTCOMX07(mvSerie, mvNF, mvOpcao)

	Local oError
	
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '0101' USER 'Admin'  PASSWORD '#D0c3m3l@' 

	oError := ErrorBlock({|e|     MsgAlert("Mensagem de Erro: " +chr(10)+ e:Description)})		

	if mvOpcao == '3'	
		Execblock("TCOMX007",.F.,.F.,{mvSerie,mvNF, val(mvOpcao)})
	endIf
	
	if mvOpcao == '5' // excluir
		//if (SF1->F1_TIPO == 'D')
			liRet := Execblock("TCOMX002",.F.,.F.,{PadR(mvSerie,TamSx3("F1_SERIE")[1],"")+ mvNF,5,4})
			if liRet
				Execblock("TCOMX007",.F.,.F.,{mvSerie,mvNF, val(mvOpcao)})				
			EndIf
		//EndIf		
	EndIf
	
	ErrorBlock(oError)
	
	RESET ENVIRONMENT
	
return


