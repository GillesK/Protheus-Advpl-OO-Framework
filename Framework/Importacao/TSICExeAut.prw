#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSICExeAut   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados arquivo csv via ExecAuto   			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSICExeAut
Classe de base para importa��o via arquivo CSV com ExecAuto.
Deve-se herdar desta classe para importar numa tabela que tenha rotina ExecAuto.
Definir obrigatoriamente o metodo prepCols() e execute() e a propiedade ::nLinDat.
S�o facultativos os m�todos tratEspec(), prepTits() e as propiedades ::nLinCol e ::nLinTit.

Herda de TSImpCsv
@type class
@author Gilles Koffmann - Sigaware Pb
@since 12/10/2013
@version 1.2
@see TSImpCsv
/*/
Class TSICExeAut From TSImpCsv

	method callExec()
	Method procErro()
	Method identErro()
	method execute()
	method erroCampo()		
EndClass

method callExec() class TSICExeAut

	private lMsErroAuto := .F.
	
	lMsErroAuto := .F.
	lImp := .F.
	while !lImp		
		self:execute()		        		           
		self:procErro()
		lImp := .t.
	EndDo		
return 

/*/{Protheus.doc} execute
M�todo onde deve ser colocado o chamado ao ExecAuto
@type method
@example
	MSExecAuto({|x,y| Mata030(x,y)},::aVetor,3)
/*/
method execute() class TSICExeAut
	
return 

Method procErro() class TSICExeAut
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
return


	
Method identErro() class TSICExeAut
	nHLogExec := FOpen('c:\Totvs\logImport\importacaolog.log')
	lEnd := .F.
	lIdent := .F.
	while !lEnd .And. !lIdent
		cLinhaLog := FReadStr(nHLogExec, 65536)					
				
		lIdent := self:erroCampo()				
/*		lIdent := self:idFrnCGC()
		if !lIdent
			lIdent := self:idFrnIE()
		EndIf*/		
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


/*/{Protheus.doc} erroCampo
(long_description)
@type method
/*/
Method erroCampo() class TSICExeAut

return	.T.