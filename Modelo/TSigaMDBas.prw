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

#define INSERIR		3
#define ATUALIZAR		4
#define DELETAR		5

#define CHAVE_IND		1
#define CHAVE_CPO		2
/*
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
*/


/*/{Protheus.doc} TSigaMDBas
Classe de base Modelo. Uma classe modelo representa uma tabela Protheus
e providencia métodos para localizar, acessar, inserir, atualizar e deletar
uma entidade dentro do banco de dados sem ter que se preocupar com os detalhes de acesso
a base 
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
@todo metodo para incrementar um codigo sxe sxf
Gerenciar nickname de indexo
Relação Many to Many
@example
Definição de uma classe filha  <br>
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
	::setChave({{1,{"ZZN_FILIAL", "ZZN_GRTRIB"}}}) <br>
return  <br>


 <br>
Exemplo de utilização da classe filha  <br>
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
Nome da tabela Protheus. Deve ser informado no construtor da classe filha
@type property
@proptype character
@example
	::tabela 	  		:= 			"SB1"
/*/
	data tabela
	
/*/{Protheus.doc} entidade
Nome da entidade em Portugues. Deve ser informado no construtor da classe filha
@type property
@proptype character
@example
	::entidade			:=			"Produto"	
/*/	
	data entidade
	
/*/{Protheus.doc} funcao
Função da entidade. Deve ser informado no construtor da classe filha
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

	// chave primaria
	data chave

	// todas as chaves com indexo
	data chaves
	
	//data relations
	
/*/{Protheus.doc} execAuto
Se a entidade é atualizada atraves de ExecAuto ou acesso direto a base. Valor lógico.
Deve ser informado no contrutor da classe filha
@type  property
@proptype lógico
/*/	 		
	data execAuto

	method New() Constructor
	
///	method findByOrFail()
	method findOrFail()
	method find()
			
//	method findBOFFilial()			
//	method findOFFilial()
	
//	method findAllBOFCpo(index, numCpo, pChave)	
///	method findAllByOrFail()
	method findAllOrFail()	
	method findAll()
					
///	method findAllBy() 
///	method findBy()


//	method findFilial()
//	method findByFilial()		 
			
	method valor()	
	method salvar()
	method deletar()
	method setar()		
	method getEAVector()
	method execAuto()
	method resExecAuto()	
//	Method procErroBatch()
	method fillCampos()
	method resetCampos()				
	
	method isSet()
	
	method defDBCampos()
	method defDBIndices()
	method defDBGatilhos()
	
	method iniCampos()
	method addCpoDef()
	method setChave()
	
	method salvaRegistro()
	method isInsert()
	method deletaRegistro(valChave)	

	method hasOne()
	method belongsTo() 
	method hasMany()
	method belongsToMany()	
	method hasManyThrough()	
	method filial()
	method getValKey()
	
	method hydrateM()
	method hydrateACols()
	method hydratePos()
		
	method all()
	method simulAHeader()
	method simulACols()
	method retCpoTec()
	
//	method RegToMemory()	
	method getVar()
	method setVar()
EndClass

/*/{Protheus.doc} New
Constructor
@type method
/*/
Method New() Class TSigaMDBas
	::campos := {}
	::iniCampos()
	//::resetCampos()
	::execAuto := 	.F.	
return (Self)


/*/{Protheus.doc} iniCampos
Método para inicializar a definição dos campos e da chave primaria.
Toda classe filha precisa definir.
@type method
@see #TSigaMDBas::addCpoDef
/*/	
method iniCampos()  class TSigaMDBas

return

method filial() class  TSigaMDBas
return xFilial(::tabela)

/*/{Protheus.doc} addCpoDef
Método permitindo definir os campos. Deve ser chamado no método iniCampos()
O array em entrada do método comtem arrays com a seguinte estrutura:  
1- Nome do campo em portugues  
2- Nome do campo na base  
3- Tipo do campo
Este array podera ser gerado a partir do dicionario SX3  
@type method
@param aCampoDef, array, array de arrays com a definição dos campos
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
	::setChave({{1,{"B1_FILIAL", "B1_COD"}}}) <br>				
return
/*/
method addCpoDef(aCampoDef)  class TSigaMDBas
	local i
	for i := 1 to Len(aCampoDef)	
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
Método permitindo definir as chaves. Deve ser chamado no método iniCampos()
@type method
@param aChave, array, array com o numero do indice e os campos compondo a chave primaria
@example
	::setChave({{1,{"B1_FILIAL", "B1_COD"}}}) <br>
/*/
method setChave(aChave)  class TSigaMDBas
	local nPos
	local i
	::chave := aChave[1][2]
	::chaves := aChave
	for i := 1 to len(::chave)
		nPos := ascan(::campos, {|x| x[CPOTEC] == ::chave[i]})
		if nPos > 0
			::campos[nPos][CHAVE] := .T.
		endif
	next 
return


/*/{Protheus.doc} findOrfail
Procura uma entidade pela indexo definido no parametro Index
@type method
@param pChave, character, valor da chave de busca
@param index, numérico, Numero do indexo no Protheus
@param filial, character, Filial
@return array, {lRet, oObj} lRet: .T. se encontrou com oObj = self, .F. se não, oObj : Mensagem de erro
/*/
method findOrFail(pChave, index, filial)  class TSigaMDBas
	local tabela := ::tabela
	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea
	
	if !Empty(pChave)
		if filial == nil
			filial := xFilial(::tabela)
		endif
		if index == nil
			index := 1
		endif
		axArea := &(tabela)->(getarea())
		dbselectarea(::tabela)
		&(tabela)->(dbsetorder(index))
		&(tabela)->(dbgotop())
		
		If &(tabela)->(DBSeek(filial+pChave))
			self:fillCampos() 
			aRet[2] := Self
		else
			self:resetCampos()
			aRet := {.F., ::entidade + " " + pChave + " não enconstrado no " + ::funcao}
		Endif
		restarea(axArea)
	else
		self:resetCampos()
		aRet := {.F., ::entidade + " resetado: chave vazia"}
	endif	

return aRet 



/*/{Protheus.doc} findOrFail
Procura uma entidade pela chave primaria representada pelo indice numero 1. 
@type method
@param pChave, character, chave de acesso a entidade
@param filial, character, Filial
@return array, {lRet, oObj} lRet: .T. se encontrou com oObj = self, .F. se não, oObj : Mensagem de erro 
/*/
//Method findOrFail(pChave, filial) class TSigaMDBas
//return ::findByOrFail(1,pChave, filial)



/*/{Protheus.doc} find
Procura uma entidade pela indexo definido no parametro Index.
@type method
@param pChave, character, valor da chave de busca
@param index, numérico, Numero do indexo no Protheus
@param filial, character, Filial
@return objeto, self ou nil se não encontrado
/*/
method find(pChave,index, filial)  class TSigaMDBas
//	local tabela := ::tabela
//	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao}
	local aRet := nil 
//	local axArea

	aRet := ::findOrFail(pChave, index, filial)
	if aRet[1]
		aRet := aRet[2]
	else 
		aRet := nil 
	endif

return aRet
//::findByFilial(index, xFilial(::tabela), pChave)

/*/{Protheus.doc} find
Procura uma entidade pela chave primaria representada pelo indice numero 1. 
@type method
@param pChave, character, chave de acesso a entidade
@return objeto, self ou nil se não encontrado 
/*/
//Method find(pChave, filial) class TSigaMDBas
//return ::findBy(1,pChave, filial)



/*/{Protheus.doc} findAllByOrFail
Encontra todas as instancias representado pelo index e chave
@type method
@param index, numérico, Numero do indexo a usar
@param pChave, character, chave de acesso no indexo
@param numCpo, numérico, Quantos campos devem ser usados dentro do indexo
@return array, {lRet, oObj} lRet: .T. se encontrou com oObj = coleção (TSColecao) de self, .F. se não, oObj : Mensagem de erro
/*/
//method findAllBOFCpo(index,  pChave, numCpo)  class TSigaMDBas
method findAllOrFail( pChave, index, numCpo, filial)  class TSigaMDBas
	local tabela := ::tabela
	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao}
//	local aRet := nil 
	local axArea
	local oRes := TSColecao():New()
	local aValCurr := {}
	local cNewObj
	local oNewObj
	local lCont := .T.
	local i, j
	local nPos
	
	if !Empty(pChave)
		if index == nil
			index := 1
		endif
		if filial == nil
			filial := xFilial(tabela)
		endif
		axArea := &(tabela)->(getarea())
		dbselectarea(::tabela)
		&(tabela)->(dbsetorder(index))
		&(tabela)->(dbgotop())
		
		if 	numCpo == nil
			nPos := ascan(::chaves, {|x| x[CHAVE_IND] = index})
			if nPos != 0 
				numCpo := Len (::chaves[nPos][CHAVE_CPO])
			else
				aRet := {.F., "Chave não encontrada"}
			endif
		endif

		If &(tabela)->(DBSeek(filial+pChave))
			nPos := ascan(::chaves, {|x| x[CHAVE_IND] = index})
			if nPos != 0 
				for i := 1 to numCpo
					aadd(aValCurr, &(tabela)->(&(Self:chaves[nPos][CHAVE_CPO][i])))										
				Next
			endif
			while !&(tabela)->(EOF()) .And. lCont 
				for j := 1 to Len(aValCurr)
					if aValCurr[j] != &(tabela)->(&(Self:chaves[nPos][CHAVE_CPO][j]))
						lCont := .F.
						exit
					endif
				next
				if !lCont
					exit
				endif
				// criar nova entidade
				cNewObj := GetClassName(self)+ "():New()"
				oNewObj := &(cNewObj)
					
				oNewObj:fillCampos()
					
				oRes:add(oNewObj)	 
	//				aadd(aRes, oNewObj) 
				// reter os valores				 
					//self:fillCampos() 			
					//aRet := Self
				&(tabela)->(DbSkip())
			endDo
			aRet[2] := oRes
		else
			self:resetCampos()
			aRet := {.F., ::entidade + " " + pChave + " não enconstrado no " + ::funcao}
		Endif
		restarea(axArea)							
			//aRet := findAllBOFCpo(index, Len (::chaves[nPos][CHAVE_CPO]), pChave)
	else
		self:resetCampos()
		aRet := {.F., ::entidade + " resetado: chave vazia"}
	endif

return aRet


/*/{Protheus.doc} findAllOrFail
Encontra todas as instancias representado pela chave e index 1
@type method
@param index, numérico, Numero do indexo a usar
@param pChave, character, chave de acesso no indexo
@param numCpo, numérico, Quantos campos devem ser usados dentro do indexo
@return array, {lRet, oObj} lRet: .T. se encontrou com oObj = coleção (TSColecao) de self, .F. se não, oObj : Mensagem de erro
/*/
//method findAllOrFail(index, pChave, numCpo)  class TSigaMDBas
//return ::findAllByOrFail(1,pChave, numCpo)



/*/{Protheus.doc} findAll
Encontra todas as instancias representado pelo index e chave
@type method
@param index, numérico, Numero do indexo a usar
@param pChave, character, chave de acesso no indexo
@param numCpo, numérico, Quantos campos devem ser usados dentro do indexo
@return objeto, coleção (TSColecao) de self ou nil se não encontrado
/*/
method findAll( pChave, index, numCpo, filial)  class TSigaMDBas
//	local tabela := ::tabela
//	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao}
	local aRet := nil 
//	local axArea

	aRet := ::findAllOrFail( pChave,index, numCpo, filial)
	if aRet[1]
		aRet := aRet[2]
	else 
		aRet := nil 
	endif

return aRet

/*/{Protheus.doc} findAll
Encontra todas as instancias representado pela chave e index 1
@type method
@param pChave, character, chave de acesso no indexo
@param numCpo, numérico, Quantos campos devem ser usados dentro do indexo
@return objeto, coleção (TSColecao) de self ou nil se não encontrado
/*/
//method findAll(pChave, numCpo)  class TSigaMDBas		
//return ::findAllBy(1,pChave, numCpo)



/*/{Protheus.doc} isSet
Permite saber se o modelo esta pre-enchido com uma entidade ou não
@type method
@return lógico, .T. se esta pre-enchido, .F. se não
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
@param campo, character, Nome do campo em portugues ou nome técnico na base
@return mix, valor do campo
@example 
	::oFornecedor:valor('estado')
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
@param campo, character, Nome do campo em portugues ou nome técnico na base
@param valor, mix, Valor do campo
@return array, {lRet, cMessage} lRet: .T. se conseguiu setar .F. se não, cMessage : Mensagem de erro
@example 
	::oFornecedor:setar('estado', 'PB')
/*/
method setar(campo, valor) class  TSigaMDBas
	local nPos
	local xReturn := {.T., "Campo encontrado e setado"}
		
	nPos := ascan(::campos, {|x| x[CPOPOR] == campo })
	if nPos != 0
		::campos[nPos][VALOR] := valor
		::campos[nPos][MUDADO] := .T.
	else
		nPos := ascan(::campos, {|x| x[CPOTEC] == campo })
		if 	nPos != 0
			::campos[nPos][VALOR] := valor
			::campos[nPos][MUDADO] := .T.
		else 
			xReturn := {.F., "campo não encontrado"}
		endif
	endif		
return xReturn

/*/{Protheus.doc} salvar
Salvar as modificações do modelo na base. Gerencia a inserção como a modificação
@type method
@return array, {lRet, cMessage} lRet: .T. se conseguiu salvar .F. se não, cMessage : Mensagem de erro
/*/
Method salvar() class TSigaMDBas
	local aRet := {.T., ::entidade + " salva no " +  ::funcao}
	local aRet2 := {}
	local aRet3 := {}
	local aRet4 := {}
	
	local tabela := ::tabela	
	//local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea := &(tabela)->(getarea())
	local lIns := .F.
	local valChave := ""
	local opcao := INSERIR
	
	// TODO chamada do log
	
	// determina inserção ou update
	aRet2 := ::isInsert(@lIns, @valChave)
	if aRet2[1]
	   // Exec auto ou insert direto
		if ::execAuto
			if !lIns
				opcao := ATUALIZAR
			endif								
			//::prepExecAuto()
			::execAuto(opcao)
			aRet4 := ::resExecAuto()
			if !aRet4[1]
				aRet[2] := aRet4[2]
			endif 					
		else
			// Reclock
			aRet3 := ::salvaRegistro(lIns, valChave)
			if !aRet3[1]
				aRet[2] := aRet3[2]
			endif 		
		endif		
	else
		aRet[2] := aRet2[2]
	endif

	//aRet := {.F., ::entidade + " não enconstrado no " + ::funcao}
	restarea(axArea)
return aRet



method salvaRegistro(lIns, valChave)  class TSigaMDBas
	local aRet := {.T., ""}
	local tabela := ::tabela
	local i
	
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
		if Self:campos[i][MUDADO] == .T.
			&(tabela)->(&(Self:campos[i][CPOTEC])) := Self:campos[i][VALOR]
		endif 						
	next
	&(tabela)->(MsUnlock())
	//MsUnlock(&(tabela))	
return aRet


method isInsert(lIns, valChave) class TSigaMDBas
	local aRet := {.T.,""}
	local nPos
	local i

	lIns := .F.
	valChave := ""
	for i := 1 to len(::chave)
		nPos := ascan(::campos, {|x| x[CPOTEC] == ::chave[i] })
		if nPos != 0
			// campo da chave foi mudado
			if ::campos[nPos][MUDADO] == .T.
				lIns := .T.
			endif
			valChave := valChave + ::campos[nPos][VALOR]
		else
			// TODO : erro			
			aRet := {.F., "Campos de chave não encontrados"}
			return aRet			
		endif
	next
return aRet



/*/{Protheus.doc} deletar
Deleta o modelo na base
@type method
@return array, {lRet, cMessage} lRet: .T. se conseguiu salvar .F. se não, cMessage : Mensagem de erro
/*/
method deletar() class TSigaMDBas
	local tabela := ::tabela
	local aRet := {.T., "deletado com sucesso"}
	local aRet2
	local aRet3
	local aRet4
	local lIns := .F.
	local axArea := &(tabela)->(getarea())
	local valChave := ""
	// determina inserção ou update
	aRet2 := ::isInsert(@lIns, @valChave)
	if aRet2[1]
		if ::execAuto
			//::prepExecAuto()
			::execAuto(DELETAR)
			aRet4 := ::resExecAuto()
			if !aRet4[1]
				aRet[2] := aRet4[2]
			endif
		else
			// Reclock
			aRet3 := ::deletaRegistro(valChave)
			if !aRet3[1]
				aRet[2] := aRet3[2]
			endif 		
		endif
	else
		aRet[2] := aRet2[2]
	endif		
	
	restarea(axArea)	
return aRet


method deletaRegistro(valChave) class  TSigaMDBas
	local aRet := {.T., ""}
	local tabela := ::tabela
	
	dbselectarea(tabela)	
	&(tabela)->(dbsetorder(1))
	&(tabela)->(dbgotop())
				
	if !(&(tabela)->(DBSeek(valChave)))
		aRet := {.F., ::entidade + " " + valChave + " não encontrado na base para fazer atualização"}
	else
		recLock(tabela, .F.)
		&(tabela)->(DbDelete())			
		&(tabela)->(MsUnlock())
		//MsUnlock(&(tabela))									
	endif
return aRet

/*/{Protheus.doc} execAuto
Definição do ExecAuto. A definir na classe filha
@type method
@param opcao, numérico, opçao do ExecAuto 3: Inserir, 4: alterar, 5: Deletar
@example
	method execAuto(opcao) class TSCliente <br>
		MSExecAuto({|x,y| Mata030(x,y)},::getEAVector(),opcao) <br>
	return
/*/
method execAuto(opcao) class TSigaMDBas

return

	
/*/{Protheus.doc} getEAVector
Retorna o vector de dados para chamar o ExecAuto
@type method
@return array, array contendo os dados no formato esperado pela ExecAuto
/*/
method getEAVector() class TSigaMDBas
	local i
	local aVetor := {}
	private lMsErroAuto := .F.
	
	for i := 1 to len(::campos)
		aadd(aVetor , {::campos[i][CPOTEC],::campos[i][VALOR],nil})	
	next
return aVetor


method resExecAuto()   class TSigaMDBas
	local aiRet := {.T., ""}
	local ciText0
	local aiErro
	local niX
	
	If lMsErroAuto	
		ciTexto		:=	" Erro Rotina Automática "+ Chr(13)+Chr(10)	
		aiErro 		:= GetAutoGRLog()
		For niX := 1 To Len(aiErro)
			ciTexto += aiErro[niX] + Chr(13)+Chr(10)
		Next niX								
		
		aiRet		:=	{.F.,ciTexto}
	endif							  
return aiRet


// RELATIONS




/*/{Protheus.doc} hasOne
Relação One to One
@type method
@param relatedType, character, Tipo relacionado
@param indexFk, numérico, número do indexo para procurar no modelo relacionado
@param localKey, array, chave na tabela fonte
@return TSigaMDRel, instancia da relação
/*/
method hasOne( relatedType, indexFk, localKey) class TSigaMDBas	
return TSHasOne:New(self, relatedType, indexFk, localKey)


/*/{Protheus.doc} hasMany
Relação One to Many 
@type method
@param relatedType, character, Tipo relacionado
@param indexFk, numérico, número do indexo para procurar no modelo relacionado
@param localKey, array, chave na tabela fonte
@return TSigaMDRel, instancia da relação
/*/
method hasMany( relatedType, indexFk,  localKey) class TSigaMDBas
return TSHasMany():New(self, relatedType, indexFk,  localKey)

/*/{Protheus.doc} belongsTo
Relação pertence a (1)
@type method
@param relatedType, character, Tipo relacionado
@param foreignKey, array, foreign key na tabela.
@param indexOtherKey, numérico, número do indexo para procurar no modelo relacionado
@return TSigaMDRel, instancia da relação
/*/
method belongsTo(relatedType, foreignKey, indexOtherKey) class TSigaMDBas
return TSBelongsTo():New(self, relatedType, foreignKey, indexOtherKey)


/*/{Protheus.doc} belongsToMany
Relação many to many
@type method
@param nome, character, Nome em portugues da entidade
@param entidade, character, Nome da Classe
@param indexFk, character, Representa o indexo da Foreign Key
@param camposPk, array, diferente de nil se diferente da Primary Key
/*/
method belongsToMany( entidade, indexFk, camposPk) class TSigaMDBas
//	aadd(::relation, {REL_BELONGSTOMANY, entidade, indexFk, camposPk})
	// MANY TO MANY
return

/*/{Protheus.doc} hasManyThrough
(long_description)
@type method
@example
(examples)
@see (links_or_references)
/*/
method hasManyThrough() class TSigaMDBas

return
 

method getValKey(parentKey) class TSigaMDBas
	local valChave := ""
	local aRet := {.T., ""}
	local cpoKey
	local i
	 
	if parentKey == nil
		cpoKey := ::chave
	else
		cpoKey := parentKey
	endif
	
	for i := 1 to len(cpoKey)
		nPos := ascan(::campos, {|x| x[CPOTEC] == cpoKey[i] })
		//nPos := ascan(::campos, {|x| x[2] == cpoKey[i] })
		if nPos != 0
			valChave := valChave + ::campos[nPos][VALOR]
		else
			// TODO : erro			
			aRet := {.F., "Campos de chave não encontrados"}
			return aRet			
		endif
	next	
	aRet[2] := valChave
return aRet


/*/{Protheus.doc} hydrateM
Preeche o objeto a partir da variavel de memoria M 
@type method
/*/
method hydrateM() class  TSigaMDBas
	local tipo
	local i
	
	for i:= 1 to len(::campos)
		//tipo := Type(M->(&(self:campos[i][CPOTEC]))) 
		//if tipo != "U" .And. tipo != "UE" .And. tipo != "UI"
			::campos[i][VALOR] := M->(&(self:campos[i][CPOTEC]))
		//endif  
	next 
return


/*/{Protheus.doc} hydratePos
Hydrata o modelo com o registro posicionado
@type method
/*/method hydratePos() class  TSigaMDBas
	local tipo
	local i
	local sTabela := ::tabela
	
	for i:= 1 to len(::campos)
//		tipo := Type(M->(&(self:campos[i][CPOTEC]))) 
		//if tipo != "U" .And. tipo != "UE" .And. tipo != "UI"
			::campos[i][VALOR] := &(sTabela)->(&(self:campos[i][CPOTEC]))
		//endif  
	next 
return

/*/{Protheus.doc} hydrateACols
Preeche o objeto a partir do aHeader e aCols
@type method
@param paHeader, array, aHeader
@param paCols, array, aCols
@return TSColecao, os objetos do aCols
/*/
method hydrateACols(paHeader, paCols) class  TSigaMDBas
	local nPos
	local colObj
	local oObj
	local cCreate	
	local j, i
	
	colObj := TSColecao():New()
	for j := 1 to len(paCols)
		cCreate := GetClassName(Self) + "():New()"
		oObj := &(cCreate)
		for i := 1 to Len(paHeader)
			nPos := ascan(oObj:campos, {|x| x[CPOTEC] == alltrim(paHeader[i][2])})
			if nPos != 0
				oObj:campos[nPos][VALOR] := paCols[j][i] 	
			endif		
		next
		colObj:add(oObj)
	next
	//Local xProd := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO" })
	//Local _Prod := aCols[n,xProd]
return colObj


/*/{Protheus.doc} all
Retorna todos os elementos da tabela
@type method
@return TSColecao, todos os registros da tabela
/*/
method all() class  TSigaMDBas
	local tabela := ::tabela
	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea
	local colObj
	local oObj
	local cCreate
	
	colObj := TSColecao():New()

	axArea := &(tabela)->(getarea())
	dbSelectArea(::tabela)
	&(tabela)->(dbSetOrder(1))
	&(tabela)->(dbGoTop())
	
	while !&(tabela)->(EOF())
		cCreate := GetClassName(Self) + "():New()"  
		oObj := &(cCreate)
		oObj:fillCampos()		
		colObj:add(oObj)	
		&(tabela)->(DbSkip())
	endDo	
	
	restarea(axArea)
return colObj

/*method RegToMemory()  class  TSigaMDBas
//	local var 
//	local nPos
//	local xReturn := nil
//	local cpoVar := ""
// NAO FUNCIONA: AS VARIAVEIS DE MEMORIA SAO REINICIALIZADAS AO SAIR DO METODO		
//	cpoVar := ::retCpoTec(campo)
		
	RegToMemory(::tabela, .F., .F., .F.)	
return*/ 



/*/{Protheus.doc} getVar
Retorna o valor do campo de memoria M->
@type method
@param campo, character, Nome do campo
/*/
method getVar(campo)  class  TSigaMDBas
//	local var 
//	local nPos
//	local xReturn := nil
	local cpoVar := ""
		
	cpoVar := ::retCpoTec(campo)
		
return M->(&(cpoVar))


/*/{Protheus.doc} setVar
Atualiza a variavel de memoria M->
@type method
@param campo, character, Nome do campo
@param valor, mix, Valor do campo
/*/method setVar(campo, valor)  class  TSigaMDBas
//	local var 
//	local nPos
//	local xReturn := nil
	local cpoVar := ""
		
	cpoVar := ::retCpoTec(campo)
	
	M->(&(cpoVar)) := valor 
//	var := CriaVar(cpoVar)	
return 


/*/{Protheus.doc} retCpoTec
Retorna o nome técnico do campo
@type method
@param campo, character, Nome do campo
@return character, nome técnico do campo
/*/
method retCpoTec(campo)  class  TSigaMDBas
	local nPos
	local cpoVar := ""
	
	nPos := ascan(::campos, {|x| x[CPOPOR] == campo })
	if nPos != 0
		cpoVar :=  ::campos[nPos][CPOTEC]
	else
		nPos := ascan(::campos, {|x| x[CPOTEC] == campo })
		if 	nPos != 0
			cpoVar :=  ::campos[nPos][CPOTEC]
		endif
	endif
return cpoVar

/*/{Protheus.doc} simulAHeader
Retorna um aHeader
@type method
@param tabela, character, Tabela
@param aFields, array, Lista do campos a incluir no aHeader, se nil -> todos
@param aNoCampos, array, Lista dos campos a ser excluidos do aHeader
@return array, aHeader
/*/
method simulAHeader( aFlds, aNoCampos)    class  TSigaMDBas
	local  curTab, nPos, nX
	local aHeaderInt := {}
	local axArea := SX3->(getarea())

	// Define os campos de acordo com o array
	DbSelectArea("SX3")
	
	if ((aFlds == nil .And. aNoCampos == nil) .Or. (aNoCampos != nil)) 
		aFlds := {}
		SX3->(DbSetOrder(1))
		SX3->(DbGoTop())
		If SX3->(DbSeek(::tabela))
			curTab := SX3->X3_ARQUIVO
			while !SX3->(Eof()) .And. curTab == SX3->X3_ARQUIVO
				nPos := 0
				if aNoCampos != nil
					nPos := ascan(aNoCampos, {|x| ::retCpoTec(x) == SX3->X3_CAMPO})
				endif
				if nPos == 0 
					Aadd(aFlds, SX3->X3_CAMPO)
				endif				
				SX3->(DbSkip())
			enddo 
		endif
	endif
		
	SX3->(DbSetOrder(2))
	SX3->(DbGoTop())		
	// Faz a contagem de campos no array
	For nX := 1 to Len(aFlds)
		// posiciona sobre o campo
		cpoTec := ::retCpoTec(aFlds[nX])
		If SX3->(DbSeek(cpoTec))	
			// adiciona as informações do campo para o getdados	  	
			Aadd(aHeaderInt, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
				SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
		Endif		  		  	
	Next nX

	restarea(axArea)
	// Faz a contagem de campos no array
/*	For nX := 1 to Len(aFields)
		// Cria a variavel referente ao campo
		If DbSeek(aFields[nX])
			Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
		Endif
				
	Next nX*/
		
return aHeaderInt


/*/{Protheus.doc} simuACols
Simula um aCols
@type method
@param aValores, array, Valores a ser colocados no aCols, 1 linha por linha de aCols
@return array, aCols
/*/
method simulACols(aValores)   class  TSigaMDBas
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet
	local aColsInt := {}
	local i
	
	for i := 1 to Len(aValores)
	// adiciona linha a linha das tabelas
		Aadd(aColsInt, aValores[i])
		/*.f. -> Campo do delete do array GETDADOS*/
	next																			
Return aColsInt
