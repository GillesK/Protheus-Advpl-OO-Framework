#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSIMPCSVExecAuto   บ Autor ณ Gilles Koffmann   บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br              บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Importa็ใo de dados via arquivo csv   			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework Copyright Sigaware Pb                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Class TSICExeAut From TSImpCsv

	method callExec()
	Method procErro()
	Method identErro()
	Method idFrnCGC()
	Method idCodMun()	
	Method idFrnIE()
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

Method idFrnCGC() class TSICExeAut
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
return nRet

	