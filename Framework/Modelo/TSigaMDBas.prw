#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


#define CPOPOR	1 
#define CPOTEC 	2
#define TIPO	 	3
#define CHAVE		4
		
#define VALOR		5
#define MUDADO	6


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSigaMDBasบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Base Modelo 					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSigaMDBas
Classe de base Modelo. Uma classe modelo representa uma tabela Protheus
e providencia m้todos para localizar, acessar, inserir, atualizar e deletar
uma entidade dentro do banco de dados sem ter que se preocupar com os detalhes de acesso
a base 
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
@example
Defini็ใo de uma classe filha  <br>
 <br>
Method New( ) Class TELicGrupoTributario  <br> 
	_Super:New()  <br>
	::tabela 			:= 	"ZZN"  <br>	
	::entidade			:=	"Aliquota de Grupo Tributario"  <br>
	::funcao			:=	"Cadastro de Aliquota de Grupo Tributario"  <br>	
return (Self)  <br>
 <br>
 <br>
Method iniCampos() class TELicGrupoTributario  <br>
	// Nome externo, nome interno, tipo <br>
	local cpoDef <br>
	cpoDef := {{"filial", "ZZN_FILIAL", "C"}; <br>
				,{"grupoTributario", "ZZN_GRTRIB", "C"}; <br>
				,{"aliquota", "ZZN_ALIQ", "N"}} <br>
	::addCpoDef(cpoDef)	 <br>
		 <br>
	::setChave({"ZZN_FILIAL", "ZZN_GRTRIB"}) <br>
return  <br>
 <br>
Exemplo de utiliza็ใo da classe filha  <br>
 <br>
	local oGrpTrib, nAliq  <br>
	loca xReturn  <br>
	 <br>
	oGrpTrib := TELicGrupoTributario():New()  <br>
	 <br>
	xReturn := oGrpTrib:find('1')  <br>
	 <br>
	if xReturn[1]  <br>
		nAliq := oGrpTrib:valor('aliquota')  <br>
	else  <br>
		MsgInfo(xReturn[2])  <br>
	endif  <br>
	 <br>
	xReturn := oGrpTrig:setar('aliquota', 10)  <br>
	if xReturn[1]  <br>
		oGrpTrig:salvar()  <br>
	else  <br>
		MsgInfo(xReturn[2])  <br>
	endif  <br>
	 <br>
	oGrpTrib:deletar()  <br>
/*/
Class TSigaMDBas 

/*/{Protheus.doc} tabela
Nome da tabela Protheus. Deve ser informado no contrutor da classe filha
@type property
@proptype character
@example
	::tabela 	  		:= 			"SB1"
/*/
	data tabela
	
/*/{Protheus.doc} entidade
Nome da entidade em Portugues. Deve ser informado no contrutor da classe filha
@type property
@proptype character
@example
	::entidade			:=			"Produto"	
/*/	
	data entidade
	
/*/{Protheus.doc} funcao
Fun็ใo da entidade. Deve ser informado no contrutor da classe filha
@type property
@proptype character
@example
	::funcao			:=		"Cadastro de produto"
/*/	
	data funcao
	//data chave
	//data codigo
	// 1 Nome externo, 2 nome interno, 3 tipo, 4 valor, 5 mudado, 6 chave
	
	data campos

	data chave
	
/*/{Protheus.doc} execAuto
Se a entidade ้ atualizada atraves de ExecAuto ou acesso direto a base. Valor l๓gico.
Deve ser informado no contrutor da classe filha
@type  property
@proptype l๓gico
/*/	 		
	data execAuto

	method New() Constructor
	method find()
	method findAllBy()
	method valor()	
	method salvar()
	method deletar()
	method setar()		
	method prepExecAuto()
	Method procErroBatch()
	method fillCampos()
	method resetCampos()				
	
	method isSet()
	
	method defDBCampos()
	method defDBIndices()
	method defDBGatilhos()
	
	method iniCampos()
	method addCpoDef()
	method setChave()
		
EndClass

/*/{Protheus.doc} New
Constructor
@type method
/*/Method New() Class TSigaMDBas
	::campos := {}
	::iniCampos()
	//::resetCampos()
return (Self)


/*/{Protheus.doc} iniCampos
M้todo para inicializar a defini็ใo dos campos e da chave primaria.
Toda classe filha precisa definir.
@type method
@see #TSigaMDBas:addCpoDef
/*/	
method iniCampos()  class TSigaMDBas

return


/*/{Protheus.doc} find
Procura uma entidade pela chave primaria representada pelo indice numero 1. 
@type method
@param pChave, character, chave de acesso a entidade
@return array, {lRet, cMessage} lRet: .T. se encontrou .F. se nใo, cMessage : Mensagem de erro 
/*/
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
		else
			self:resetCampos()
			aRet := {.F., ::entidade + " nใo enconstrado no " + ::funcao}
		Endif
		restarea(axArea)
	else
		self:resetCampos()
		aRet := {.F., ::entidade + " resetado: chave vazia"}
	endif
	
return aRet

/*/{Protheus.doc} isSet
Permite saber se o modelo esta pre-enchido com uma entidade ou nใo
@type method
@return l๓gico, .T. se esta pre-enchido, .F. se nใo
/*/
method isSet() Class TSigaMDBas
	local xReturn := .F.
	nPos := ascan(::campos, {|x| x[CHAVE] == .T. })
	if nPos != 0 .And. ::campos[nPos][VALOR] != nil  
		xReturn := .T.
	endif
return xReturn

/*/{Protheus.doc} resetCampos
Reseta os campos do modelo
@type method
/*/
method resetCampos() class TSigaMDBas
	local i	
	for i := 1 to len(::campos)
		::campos[i][VALOR] := nil
		::campos[i][MUDADO] := .F.
	next	
return


method fillCampos() class TSigaMDBas
	local tabela := ::tabela
	local i

	for i := 1 to len(::campos)
		::campos[i][VALOR] := (&(tabela))->(&(Self:campos[i][CPOTEC])) 
	next	
return 


/*/{Protheus.doc} valor
Obter o valor do campo
@type method
@param campo, character, Nome do campo em portugues ou nome t้cnico na base
@return mix, valor do campo
/*/
method valor(campo) class TSigaMDBas
	local nPos
	local xReturn := nil
		
	nPos := ascan(::campos, {|x| x[CPOPOR] == campo })
	if nPos != 0
		xReturn :=  ::campos[nPos][VALOR]
	else
		nPos := ascan(::campos, {|x| x[CPOTEC] == campo })
		if 	nPos != 0
			xReturn :=  ::campos[nPos][VALOR]
		endif
	endif
return xReturn

/*/{Protheus.doc} setar
Permite setar o valor de um campo
@type method
@param campo, character, Nome do campo em portugues ou nome t้cnico na base
@param valor, mix, Valor do campo
@return array, {lRet, cMessage} lRet: .T. se conseguiu setar .F. se nใo, cMessage : Mensagem de erro
/*/
method setar(campo, valor) class  TSigaMDBas
	local nPos
	local xReturn := {.T., "Campo encontrado e setado"}
		
	nPos := ascan(::campos, {|x| x[CPOPOR] == campo })
	if nPos != 0
		campos[nPos][VALOR] := valor
		campos[nPos][MUDADO] := .T.
	else
		nPos := ascan(::campos, {|x| x[CPOTEC] == campo })
		if 	nPos != 0
			campos[nPos][VALOR] := valor
			campos[nPos][MUDADO] := .T.
		else 
			xReturn := {.F. "campo nใo encontrado"}
		endif
	endif		
return xReturn

/*/{Protheus.doc} salvar
Salvar as modifica็๕es do modelo na base. Gerencia a inser็ใo como a modifica็ใo
@type method
@return array, {lRet, cMessage} lRet: .T. se conseguiu salvar .F. se nใo, cMessage : Mensagem de erro
/*/
Method salvar() class TSigaMDBas
	// TODO
	// se campos chave com indicador de modificado entao ้ Inser็ใo
	// se nao update
	local aRet := {.T., ::entidade + " salva no " +  ::funcao}	
	
	local tabela := ::tabela
	local nPos	
	//local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea := &(tabela)->(getarea())
	local lIns := .F.
	local valChave := ""
	
	// TODO chamada do log
	
	// determina inser็ใo ou update
	for i := 1 to len(::chave)
		nPos := ascan(::campos, {|x| x[CPOTEC] == ::chave[i] })
		if nPos != 0
			// campo da chave foi mudado
			if ::campos[nPos][MUDADO] := .T.
				lIns := .T.
			endif
			valChave := valChave + ::campos[nPos][VALOR]
		else
			// TODO : erro			
			aRet := {.F., "Campos de chave nใo encontrados"}
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
				aRet := {.F., "Registro nใo encontrado na base para fazer atualiza็ใo"}
				return aRet							
			endif
		endif	
		recLock(tabela, lIns)			
		for i := 1 to len(::campos)
			if Self:campos[i][5] == .T.
				&(tabela)->(&(Self:campos[i][CPOTEC])) := Self:campos[i][VALOR]
			endif 						
		next
		MsUnlock(&(tabela))		
	endif
	
	//aRet := {.F., ::entidade + " nใo enconstrado no " + ::funcao}

	restarea(axArea)
return aRet

/*/{Protheus.doc} deletar
Deleta o modelo na base
@type method
/*/
method deletar() class TSigaMDBas
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


/*/{Protheus.doc} addCpoDef
M้todo permitindo definir os campos. Deve ser chamado no m้todo iniCampos()
O array em entrada do m้todo comtem arrays com a seguinte estrutura:  
1- Nome do campo em portugues  
2- Nome do campo na base  
3- Tipo do campo
Este array podera ser gerado a partir do dicionario SX3  
@type method
@param aCampoDef, array, array de arrays com a defini็ใo dos campos
@example
Method iniCampos() class TSProduto <br>
	// Nome externo, nome interno, tipo <br>
	local cpoDef <br>
	cpoDef := {{"filial", "B1_FILIAL", "C"}; <br>
				,{"codigo", "B1_COD", "C"}; <br>
				,{"origem", "B1_ORIGEM", "C"}; <br>
				,{"grupoTributario", "B1_GRTRIB", "C"}} <br>
	::addCpoDef(cpoDef)	 <br>
		 <br>
	::setChave({"B1_FILIAL", "B1_COD"}) <br>				
return
/*/
method addCpoDef(aCampoDef)  class TSigaMDBas
	for i := 0 to Len(aCampoDef)	
		// adicionar chave
		aadd(aCampoDef[i], .F.)
		// valor
		aadd(aCampoDef[i], nil)
		//mudado
		aadd(aCampoDef[i], .F.)
		
		aadd(::campos, aCampoDef[i])
	next
return

/*/{Protheus.doc} setChave
M้todo permitindo definir a chave primaria. Deve ser chamado no m้todo iniCampos()
@type method
@param aChave, array, array com os campos compondo a chave primaria
@example
	::setChave({"B1_FILIAL", "B1_COD"}) <br>
/*/
method setChave(aChave)  class TSigaMDBas
	local nPos
	::chave := aChave
	for i := 0 to len(:chave)
		nPos := ascan(::campos, {|x| x[CPOTEC] == ::chave[i]})
		if nPos > 0
			::campos[nPos][CHAVE] := .T.
		endif
	next 
return