#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TSigaMDBasº Autor ³ gilles koffmann º Data  ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de Base Modelo 					    		    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework copyright Sigaware Pb                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


Class TSigaMDBas 

	data tabela
	data entidade
	data funcao
	//data chave
	//data codigo
	// 1 Nome externo, 2 nome interno, 3 tipo, 4 valor, 5 mudado, 6 chave 	
	data campos
	data execAuto

	
	method New() Constructor
	method find()
	method findAllBy()
	method save()
	method delete()
	method get()
	method set()		
	method prepExecAuto()
	Method procErroBatch()
	method fillCampos()
	method resetCampos()				
	
	method isSet()
	
	method defDBCampos()
	method defDBIndices()
	method defDBGatilhos()
	
	method iniCampos()
		
EndClass

Method New() Class TSigaMDBas
	::campos := {}
	//::codigo := ""
	//::isSet := .F.
	::iniCampos()
	::resetCampos()
return (Self)


Method find(pChave) class TSigaMDBas
	local tabela := ::tabela
	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea
	
	if !Empty(pChave)
		axArea := &(tabela)->(getarea())
		dbselectarea(::tabela)
		&(tabela)->(dbsetorder(1))
		&(tabela)->(dbgotop())
		
		If &(tabela)->(DBSeek(xFilial(tabela)+pChave))
			self:fillCampos()
	/*		for i := 1 to len(::campos)
				::campos[i][4] := (&(tabela))->(&(Self:campos[i][2])) 
			next*/	
			//self:getInfo() 
		else
			self:resetCampos()
			aRet := {.F., ::entidade + " não enconstrado no " + ::funcao}
		Endif
		restarea(axArea)
	else
		self:resetCampos()
		aRet := {.F., ::entidade + " resetado: chave vazia"}
	endif
	
return aRet

method isSet() Class TSigaMDBas
	local xReturn := .F.
	nPos := ascan(::campos, {|x| x[6] == .T. })
	if nPos != 0 .And. ::campos[nPos][4] != nil  
		xReturn := .T.
	endif
return xReturn

method resetCampos() class TSigaMDBas
	local i	
	for i := 1 to len(::campos)
		::campos[i][4] := nil
		::campos[i][5] := .F.
	next	
return

method fillCampos() class TSigaMDBas
	local tabela := ::tabela
	local i

	for i := 1 to len(::campos)
		::campos[i][4] := (&(tabela))->(&(Self:campos[i][2])) 
	next	
return 

method get(campo) class TSigaMDBas
	local nPos
	local xReturn := nil
	
	nPos := ascan(::campos, {|x| x[1] == campo })
	if nPos != 0
		xReturn :=  ::campos[nPos][4]
	else
		nPos := ascan(::campos, {|x| x[2] == campo })
		if 	nPos != 0
			xReturn :=  ::campos[nPos][4]
		endif
	endif
return xReturn


method set(campo, valor) class  TSigaMDBas
	local nPos
	local xReturn := .T.
		
	nPos := ascan(::campos, {|x| x[1] == campo })
	if nPos != 0
		campos[nPos][4] := valor
		campos[nPos][5] := .T.
	else
		nPos := ascan(::campos, {|x| x[2] == campo })
		if 	nPos != 0
			campos[nPos][4] := valor
			campos[nPos][5] := .T.
		else 
			xReturn := .F.
		endif
	endif		
return xReturn


Method save() class TSigaMDBas
	// TODO
	// se campos chave com indicador de modificado entao é Inserção
	// se nao update
	local aRet := {.T., ::entidade + " salva no " +  ::funcao}	
	
	local tabela := ::tabela
	local nPos	
	//local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea := &(tabela)->(getarea())
	local lIns := .F.
	local valChave := ""
	
	// TODO chamada do log
	
	// determina inserção ou update
	for i := 1 to len(::chave)
		nPos := ascan(::campos, {|x| x[2] == ::chave[i] })
		if nPos != 0
			// campo da chave foi mudado
			if ::campos[nPos][5] := .T.
				lIns := .T.
			endif
			valChave := valChave + ::campos[nPos][4]
		else
			// TODO : erro			
			aRet := {.F., "Campos de chave não encontrados"}
			return aRet			
		endif
	next
	
   // Exec auto ou insert direto
	if ::execAuto
		::preExecAuto()
		::execute()
	else
		// msunlock
		dbselectarea(tabela)	
		&(tabela)->(dbsetorder(1))
		&(tabela)->(dbgotop())
		if !lIns			
			if !(&(tabela)->(DBSeek(valChave)))
				aRet := {.F., "Registro não encontrado na base para fazer atualização"}
				return aRet							
			endif
		endif	
		recLock(tabela, lIns)			
		for i := 1 to len(::campos)
			if Self:campos[i][5] == .T.
				&(tabela)->(&(Self:campos[i][2])) := Self:campos[i][4]
			endif 						
		next
		MsUnlock(&(tabela))		
	endif
	
	//aRet := {.F., ::entidade + " não enconstrado no " + ::funcao}

	restarea(axArea)
return aRet

method delete() class TSigaMDBas
	// TODO
return


method prepExecAuto() class TSigaMDBas
	//TODO
return


Method procErroBatch() class TSigaMDBas
	//TODO
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
