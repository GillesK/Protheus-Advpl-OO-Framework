#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TSIMPCSVEAFornecedor   º Autor ³ Gilles Koffmann   º Data  ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de Importação de dados via arquivo csv Fornecedor   			  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework Copyright Sigaware Pb                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*/{Protheus.doc} TSImpCsvEAFornecedor
Importação de arquivo csv de fornecedor (SA2) via rotina automatica.
Gerencia só inserção
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
	