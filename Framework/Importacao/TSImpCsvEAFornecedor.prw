#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSVEAFornecedor   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv Fornecedor   			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
/*/{Protheus.doc} TSImpCsvEAFornecedor
Importa��o de arquivo csv de fornecedor (SA2) via rotina automatica.
Gerencia s� inser��o
@type class
@author Gilles Koffmann - Sigaware Pb
@since 02/12/2013
@version 1.0
/*/
Class TSImpCsvEAFornecedor From TTSICExeAut

	method execute()
	method erroCampo()	
EndClass

method execute() class TSImpCsvEAFornecedor

	MSExecAuto({|x,y| Mata020(x,y)},::aVetor,3)

return 

	
Method erroCampo() class TSImpCsvEAFornecedor
	local nPos
	local nRet := .F.
	if (at("HELP: CGC",cLinhaLog) > 0) .Or. (at("HELP: CPFINVALID",cLinhaLog) > 0)
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(::aVetor, {|x,y|x[1]=='A2_CGC'})
		if nPos > 0
			::aVetor[nPos][2] := ""
		endIf				
	endif
	
	if (at("HELP: REGNOIS",cLinhaLog) > 0)
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(::aVetor, {|x,y|x[1]=='A2_COD_MUN'})
//		adel(aVetor, nPos)
		if nPos > 0
			::aVetor[nPos][2] := "99999"
		endIf				
	endif	
	
	if at("HELP: IE",cLinhaLog) > 0
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(::aVetor, {|x,y|x[1]=='A2_INSCR'})
		if nPos > 0
			::aVetor[nPos][2] := ""
		endIf				
	endif	
return nRet

/*Method idFrnCGC() class TSICExeAut
	local nPos
	local nRet := .F.
	if (at("HELP: CGC",cLinhaLog) > 0) .Or. (at("HELP: CPFINVALID",cLinhaLog) > 0)
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(::aVetor, {|x,y|x[1]=='A2_CGC'})
		if nPos > 0
			::aVetor[nPos][2] := ""
		endIf				
	endif
return nRet

Method idCodMun() class TSICExeAut
	local nPos
	local nRet := .F.
	if (at("HELP: REGNOIS",cLinhaLog) > 0)
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(::aVetor, {|x,y|x[1]=='A2_COD_MUN'})
//		adel(aVetor, nPos)
		if nPos > 0
			::aVetor[nPos][2] := "99999"
		endIf				
	endif
return nRet

Method idFrnIE() class TSICExeAut
	local nPos
	local nRet := .F.
	if at("HELP: IE",cLinhaLog) > 0
		// colocar nada dentro do campo A2_CGC
		nRet := .T.
		nPos := AScanX(::aVetor, {|x,y|x[1]=='A2_INSCR'})
		if nPos > 0
			::aVetor[nPos][2] := ""
		endIf				
	endif
return nRet*/
	