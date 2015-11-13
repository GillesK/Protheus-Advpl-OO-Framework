#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


#define CPOPOR	1 
#define CPOTEC 	2
#define TIPO	 	3
#define TAMANHO	4
#define DECIMAL	5
//#define AUTOINC	4
//#define FILIAL	5
//#define CHAVE		4
		
#define VALOR		6
#define MUDADO	7
#define ORDEM		8

#define INSERIR		3
#define ATUALIZAR		4
#define DELETAR		5

#define CHAVE_IND		1
#define CHAVE_CPO		2
#define CHAVE_ALIAS	3

#define CHAVE_FIND_MODEL			1
#define BETWEEN_FIND_MODEL		2

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
	data eaChave
	
	data campoInc
	data campoFilial
	data pkIndex
	data temFilial
	
	//data relations
//	data findModel
	
/*/{Protheus.doc} execAuto
Se a entidade é atualizada atraves de ExecAuto ou acesso direto a base. Valor lógico.
Deve ser informado no contrutor da classe filha
@type  property
@proptype lógico
/*/	 		
	data isExecAuto
	data filhos

	method New() Constructor
	
	method findOrFail()
	method find()
	
	method findAllOrFail()	
	method findAll()
								
	method valor()	
	method salvar()
	method getFilialCpo()	
	method geraFilial() 
	method getAutoIncCpo()
	method geraNum() 
	method confirmNum(lIns) 
	method rollbackNum(lIns)
	
	method setFilhos()
	method deletar()
	method setar()		
	method getEAVector()
	method setEAChave(eaChave)	
	method ordCampos()
	method execAuto()
	method resExecAuto()	
//	Method procErroBatch()
	method fillCampos()
	method resetCampos()				
		
	method isSet()
	
//	method defDBCampos()
//	method defDBIndices()
//	method defDBGatilhos()
	
	method iniCampos()
	method addCpoDef()
	method setChave()
	method getChave()	
	method addCpoInc(pCpoInc) 
	method setCpoFilial(pCpoFilial) 
	method setPkIndex(pPkIndex)
	
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
	method hydrateAlias()
	method hydAllAlias()
	method hydAColsPos()		
	method getColBrowse()
	method extractACols(paHeader, colecao)	
		
	method all()
	method simulAHeader()
	method simulACols()
	method retCpoTec()
//	method getCampo(cpoName)	
	method getCampo()
	
//	method RegToMemory()	
	method getVar()
	method setVar()
	
	method setOrderInternal()
	method clone()
	method setMemory()	
EndClass

/*/{Protheus.doc} New
Constructor
@type method
/*/
Method New() Class TSigaMDBas
	::campos := {}
	::eaChave := nil
	::chave := nil
	::pkIndex := nil
	::temFilial := .T.	
	::iniCampos()
	//::resetCampos()
	::isExecAuto := 	.F.
//	::findModel := CHAVE_FIND_MODEL
	
return (Self)

method setFilhos(filhos) class TSigaMDBas
	::filhos := filhos
return

/*/{Protheus.doc} iniCampos
Método para inicializar a definição dos campos e da chave primaria.
Toda classe filha precisa definir.
@type method
@see #TSigaMDBas::addCpoDef
/*/	
method iniCampos()  class TSigaMDBas

return

/*/{Protheus.doc} filial
xFilial
@type method
/*/
method filial() class  TSigaMDBas
	local ret := ""
	if ::temFilial
		ret := xFilial(::tabela)
	endif
return ret

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
	local cOrdem := "01"
	for i := 1 to Len(aCampoDef)	
		// adicionar autoInc
/*		if Len(aCampoDef[i]) == 3
			aadd(aCampoDef[i], .F.)
		endif
		if Len(aCampoDef[i]) == 4
			aadd(aCampoDef[i], .F.)
		endif*/		
		// Adicionar Chave
		//aadd(aCampoDef[i], .F.)
		// valor
		// adicionar tamanho e decimal
		if Len(aCampoDef[i]) == 3
			aadd(aCampoDef[i], 0)
		endif		
		if Len(aCampoDef[i]) == 4
			aadd(aCampoDef[i], 0)
		endif				
		aadd(aCampoDef[i], nil)
		//mudado
		aadd(aCampoDef[i], .F.)
		//ordem
		aadd(aCampoDef[i], cOrdem)
		
		aadd(::campos, aCampoDef[i])
		cOrdem := Soma1(cOrdem)
	next
	
	if ::temFilial
		::campoFilial := ::campos[1][CPOTEC]
	endif 

return


/*/{Protheus.doc} getCampo
Retorna o campo
@type method
@param cpoName, character, Nome do campo em portugues ou nome tecnico
@return array, definição do campo
/*/
method getCampo(cpoName)  class TSigaMDBas
	local nPos
	local xReturn := nil
		
	nPos := ascan(::campos, {|x| x[CPOPOR] == cpoName })
	if nPos != 0
		xReturn :=  ::campos[nPos]
	else
		nPos := ascan(::campos, {|x| x[CPOTEC] == cpoName })
		if 	nPos != 0
			xReturn :=  ::campos[nPos]
		endif
	endif	
return xReturn


/*/{Protheus.doc} addCpoInc
Determina o campo com numeração automatica
@type method
@param pCpoInc, character, nome do campo técnico com auto incremento
/*/method addCpoInc(pCpoInc)  class TSigaMDBas
	::campoInc := pCpoInc	
return

/*/{Protheus.doc} setCpoFilial
Determina o campo que representa a filial. Por default é o primeiro campo definido
@type method
@param pCpoFilial, character, Campo que representa a filial (nome técnico)
/*/
method setCpoFilial(pCpoFilial) class TSigaMDBas
	::campoFilial := pCpoFilial
return

/*/{Protheus.doc} setPkIndex
Determina a chave primaria, por default é o primerio indexo definido
@type method
@param pPkIndex, cheracter, Numero do indexo que representa a chave primaria
/*/
method setPkIndex(pPkIndex)  class TSigaMDBas
	local nPos
	::pkIndex := pPkIndex
	nPos := ascan(::chaves, {|x| x[CHAVE_IND] == ::pkIndex})
	if nPos != 0
		::chave := ::chaves[nPos][CHAVE_CPO]
	endif
return

/*/{Protheus.doc} setChave
Método permitindo definir as chaves. Deve ser chamado no método iniCampos()
@type method
@param aChave, array, array com o numero do indice e os campos compondo a chave primaria
@example
	::setChave({{1,{"B1_FILIAL", "B1_COD"}}}) <br>
/*/
method setChave(aChaves)  class TSigaMDBas
	local nPos
	local i
	if ::chave == nil
		::chave := aChaves[1][CHAVE_CPO]
	endif
	::chaves := aChaves
	
	if ::pkIndex == nil
		::pkIndex := aChaves[1][CHAVE_IND]
	endif
	
	if ::eaChave == nil
		::eaChave := 	aChaves[1][CHAVE_CPO]
	endif
/*	for i := 1 to len(::chave)
		nPos := ascan(::campos, {|x| x[CPOTEC] == ::chave[i]})
		if nPos > 0
			::campos[nPos][CHAVE] := .T.
		endif
	next*/ 
return



/*/{Protheus.doc} getChave
Retorna o array contendo os campos da chave
@type method
@param index, character, Numero ou nome do indexo.
@return array, campos do indexo
/*/
method getChave(index) class  TSigaMDBas
	local nPos
	local aRet := nil
	// chave : CHAVE_ALIAS
	if valType(index) == "N"
		index := str(index)
	endif	
	nPos := ascan(::chaves, {|x| x[CHAVE_IND] = index})
	if nPos != 0 
		aRet := ::chaves[nPos][CHAVE_CPO]
	else
		nPos := ascan(::chaves, {|x| x[CHAVE_ALIAS] = index})
		if nPos != 0 
			aRet := ::chaves[nPos][CHAVE_CPO]
		endif		
	endif 
return aRet


/*method getChavePos(index, nPos)
	local aChave
	aChave := ::getChave(index)
return aChave[nPos]*/


/*/{Protheus.doc} findOrfail
Procura uma entidade pela indexo definido no parametro Index
@type method
@param pChave, character, valor da chave de busca
@param index, numérico, Numero do indexo no Protheus
@param filial, character, Filial
@return array, {lRet, oObj} lRet: .T. se encontrou com oObj = self, .F. se não, oObj : Mensagem de erro
/*/
/*method findOrFail(pChave, index, filial)  class TSigaMDBas
	local tabela := ::tabela
	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea
	local aCpo
	local lFound := .F.
	local nPosIni, nPosFim, nPosFil
	local cChavTyp, cpoIni
	
	if !Empty(pChave)
		if filial == nil
			filial := ::filial()
		endif
		if index == nil
			index := "1"
		endif
		axArea := &(tabela)->(getarea())
		dbselectarea(::tabela)
		::setOrderInternal(index)
		//&(tabela)->(dbsetorder(index))
		&(tabela)->(dbgotop())
		
		Do Case
			Case ::findModel == CHAVE_FIND_MODEL
				If &(tabela)->(DBSeek(filial+pChave))
					self:fillCampos() 
					aRet[2] := Self
				else
					self:resetCampos()
					aRet := {.F., ::entidade + " " + pChave + " não enconstrado no " + ::funcao}
				Endif
			Case ::findModel == BETWEEN_FIND_MODEL
				// get campos ini e fim
				aCpo := ::getChave(index)
				//nPosFil := ascan(::campos, {|x| x[CPOTEC] == aChave[1] })
				// TODO testar se tem filial
				cpoIni := ::getCampo(aCpo[2])
				cChavTyp := pChave
				if cpoIni[TIPO] == "D"
					cChavTyp := stod(pChave)
				endif					
				//nPosFim := ascan(::campos, {|x| x[CPOTEC] == aChave[3] })
				If &(tabela)->(DBSeek(filial))
					while !&(tabela)->(Eof()) .And. &(tabela)->(&(aCpo[1])) == filial
						if cChavTyp >= &(tabela)->(&(aCpo[2])) 
							if cChavTyp <= &(tabela)->(&(aCpo[3])) 
								lFound := .T.
								self:fillCampos()
								aRet[2] := Self 
								exit
							endif
						endif
						&(tabela)->(dbskip())
					enddo		
					if !lFound
						self:resetCampos()
						aRet := {.F., ::entidade + " " + pChave + " não enconstrado no " + ::funcao}
					endif
				else
					self:resetCampos()
					aRet := {.F., ::entidade + " " + pChave + " não enconstrado no " + ::funcao}					
				endif	
		EndCase
		
		restarea(axArea)
	else
		self:resetCampos()
		aRet := {.F., ::entidade + " resetado: chave vazia"}
	endif	

return aRet*/ 


method findOrFail(pChave, pFilter, index,  filial)  class TSigaMDBas
	local tabela := ::tabela
	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao} 
	local axArea
	local aCpo
	local lFound := .F.
	local nPosIni, nPosFim, nPosFil
	local cChavTyp, cpoIni
	
//	if !Empty(pChave)
		if pChave == nil
			pChave := ""
		endif
		if filial == nil
			filial := ::filial()
		endif
		if index == nil
			index := ::pkIndex
		endif
		axArea := &(tabela)->(getarea())
		dbselectarea(::tabela)
		::setOrderInternal(index)
		
		if pFilter != nil
			&(tabela)->(DbSetFilter({|| &pFilter }, pFilter))
		endif
		//&(tabela)->(dbsetorder(index))
		&(tabela)->(dbgotop())
		
		If &(tabela)->(DBSeek(filial+pChave))
			self:fillCampos() 
			aRet[2] := Self
		else
			self:resetCampos()
			aRet := {.F., ::entidade + " " + pChave + " não enconstrado no " + ::funcao}
		Endif		
		
		restarea(axArea)
	//else
		//self:resetCampos()
		//aRet := {.F., ::entidade + " resetado: chave vazia"}
	//endif
return aRet

/*/{Protheus.doc} find
Procura uma entidade pela indexo definido no parametro Index.
@type method
@param pChave, character, valor da chave de busca
@param index, numérico, Numero do indexo no Protheus
@param filial, character, Filial
@return objeto, self ou nil se não encontrado
/*/
method find(pChave, pFilter, index,  filial)  class TSigaMDBas
//	local tabela := ::tabela
//	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao}
	local aRet := nil 
//	local axArea

	aRet := ::findOrFail(pChave, pFilter, index, filial)
	if aRet[1]
		aRet := aRet[2]
	else 
		aRet := nil 
	endif

return aRet



/*/{Protheus.doc} findAllOrFail
Encontra todas as instancias representado pelo index e chave
@type method
@param pChave, character, chave de acesso no indexo
@param index, numérico, Numero do indexo a usar
@param numCpo, numérico, Quantos campos devem ser usados dentro do indexo
@param filial, character, Filial
@return array, {lRet, oObj} lRet: .T. se encontrou com oObj = coleção (TSColecao) de self, .F. se não, oObj : Mensagem de erro
/*/

/*method findAllOrFail( pChave, index, numCpo, filial)  class TSigaMDBas
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
	local aCpo
	
	if !Empty(pChave)
		if index == nil
			index := "1"
		endif
		if filial == nil
			filial := ::filial()
		endif
		axArea := &(tabela)->(getarea())
		dbselectarea(::tabela)
		::setOrderInternal(index)
		//&(tabela)->(dbsetorder(index))
		&(tabela)->(dbgotop())
		
		aCpo := ::getChave(index)
		if 	numCpo == nil
			if aCpo == nil
				aRet := {.F., "Chave não encontrada"}
			else
				numCpo := Len(aCpo) 
			endif
		endif

		If &(tabela)->(DBSeek(filial+pChave))
			//nPos := ascan(::chaves, {|x| x[CHAVE_IND] = index})
			if aCpo != nil 
				for i := 1 to numCpo
					aadd(aValCurr, &(tabela)->(&(aCpo[i])))										
				Next
			endif
			while !&(tabela)->(EOF()) .And. lCont 
				for j := 1 to Len(aValCurr)
					if aValCurr[j] != &(tabela)->(&(aCpo[j]))
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

return aRet*/



method findAllOrFail( pChave, index, numCpo, pFilter, filial)  class TSigaMDBas
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
	local aCpo
	
//	if !Empty(pChave)
		if pChave == nil
			pChave := ""
		endif
		if index == nil
			index := ::pkIndex
		endif
		if filial == nil
			filial := ::filial()
		endif
		axArea := &(tabela)->(getarea())
		dbselectarea(::tabela)
		::setOrderInternal(index)
		//&(tabela)->(dbsetorder(index))
		if pFilter != nil
			&(tabela)->(DbSetFilter({|| &pFilter }, pFilter))
		endif		
		&(tabela)->(dbgotop())
		
		aCpo := ::getChave(index)
		if 	numCpo == nil
			if aCpo == nil
				aRet := {.F., "Chave não encontrada"}
			else
				numCpo := Len(aCpo) 
			endif
/*			nPos := ascan(::chaves, {|x| x[CHAVE_IND] = index})
			if nPos != 0 
				numCpo := Len (::chaves[nPos][CHAVE_CPO])
			else

			endif*/
		endif

		If &(tabela)->(DBSeek(filial+pChave))
			//nPos := ascan(::chaves, {|x| x[CHAVE_IND] = index})
			if aCpo != nil 
				for i := 1 to numCpo
					aadd(aValCurr, &(tabela)->(&(aCpo[i])))										
				Next
			endif
			while !&(tabela)->(EOF()) .And. lCont 
				for j := 1 to Len(aValCurr)
					if aValCurr[j] != &(tabela)->(&(aCpo[j]))
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
//	else
//		self:resetCampos()
//		aRet := {.F., ::entidade + " resetado: chave vazia"}
//	endif

return aRet


/*/{Protheus.doc} findAll
Encontra todas as instancias representado pelo index e chave
@type method
@param pChave, character, chave de acesso no indexo
@param index, numérico, Numero do indexo a usar
@param numCpo, numérico, Quantos campos devem ser usados dentro do indexo
@param filial, character, Filial
@return objeto, coleção (TSColecao) de self ou nil se não encontrado
/*/
method findAll( pChave, index, numCpo, pFilter, filial)  class TSigaMDBas
//	local tabela := ::tabela
//	local aRet := {.T., ::entidade + " enconstrado no " +  ::funcao}
	local aRet := nil 
//	local axArea

	aRet := ::findAllOrFail( pChave,index, numCpo, pFilter, filial)
	if aRet[1]
		aRet := aRet[2]
	else 
		aRet := nil 
	endif

return aRet



/*/{Protheus.doc} isSet
Permite saber se o modelo esta pre-enchido com uma entidade ou não
@type method
@return lógico, .T. se esta pre-enchido, .F. se não
/*/
method isSet() Class TSigaMDBas
	local xReturn := .F.
	local i, cpo
	for i := 1 to Len(::chave) 
		cpo := ::getCampo(::chave[i])
		if cpo[VALOR] != nil  
			xReturn := .T.
			exit
		endif
	next
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
   	Local bError         := { |e| oError := e , Break(e) }
   	Local bErrorBlock

	bErrorBlock    := ErrorBlock( bError )
	for i := 1 to len(::campos)
		begin sequence
			::campos[i][VALOR] := (&(tabela))->(&(Self:campos[i][CPOTEC]))
		Recover
			ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
		end sequence
	next
	Errorblock(bErrorBlock)
	
//		if ValType(&(tabela+"->"+Self:campos[i][2])) <> "U" //ValType(&(tabela+"->"+Self:campos[i][2]))
//		else
//			MsgAlert("cpo not found")
//		endif		
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
	local nPos, cpo
	local xReturn := nil
		
	cpo := ::getCampo(campo)
//	nPos := ascan(::campos, {|x| x[CPOPOR] == campo })
//	if cpo != nil
		xReturn :=  cpo[VALOR]
//	endif

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
	local nPos, cpo
//	local xReturn := {.T., "Campo encontrado e setado"}
		
	cpo := ::getCampo(campo)
	//nPos := ascan(::campos, {|x| x[CPOPOR] == campo })
//	if cpo != nil
		cpo[VALOR] := valor
		cpo[MUDADO] := .T.
//	else
//		xReturn := {.F., "campo não encontrado"}
//	endif		
return /*xReturn*/

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
	local lMsErroEA
	// TODO chamada do log
	
	lMsHelpAuto 		:= .T.
	lMsErroAuto 		:= .F. 	
	//força a gravação das informações de erro em array para manipulação da gravação ao invés de gravar direto no arquivo temporário 
	lAutoErrNoFile 	:= .T.
	
	// determina inserção ou update
	lIns := ::isInsert( @valChave)
//	if aRet2[1]
	   // Exec auto ou insert direto
	if lIns
		::geraFilial()
		::geraNum()				
	endif		   
	if ::isExecAuto
		if !lIns
			opcao := ATUALIZAR				
		endif								
		//::prepExecAuto()
		// numeração
		lMsErroEA := ::execAuto(opcao)
		aRet4 := ::resExecAuto(lMsErroEA, lIns)
		if !aRet4[1]
			aRet := {.F., aRet4[2]}
		endif 					
	else
		// Reclock
		aRet3 := ::salvaRegistro(lIns, valChave)
			
		if !aRet3[1]
			aRet := {.F., aRet3[2]}
		endif 		
	endif		
//	else
//		aRet := {.F., aRet2[2]}
//	endif

	//aRet := {.F., ::entidade + " não enconstrado no " + ::funcao}
	restarea(axArea)
return aRet


method geraFilial()  class TSigaMDBas
	local filCpo
	filCpo := ::getFilialCpo()
	if filCpo != nil
		::setar(filCpo[CPOTEC] ,::filial())			
	endif
return

method getFilialCpo() class TSigaMDBas	
return ::getCampo(::campoFilial)

method getAutoIncCpo()  class TSigaMDBas
return ::getCampo(::campoInc)

method geraNum()  class TSigaMDBas
	local nPos
	//local aRet := nil
	local cpoInc
	cpoInc := ::getAutoIncCpo()
	if cpoInc != nil	
		::setar(cpoInc[CPOTEC] ,GetSxeNum(::tabela, cpoInc[CPOTEC]))
	endif	
return 

method confirmNum(lIns)  class TSigaMDBas
	local incCpo
	
	incCpo := ::getAutoIncCpo()
	if incCpo != nil .And. lIns
		ConfirmSX8()
	endif
return

method rollbackNum(lIns)  class TSigaMDBas
	local incCpo
	
	incCpo := ::getAutoIncCpo()
	if incCpo != nil	.And. lIns
		RollBackSX8()
	endif
return

method salvaRegistro(lIns, valChave)  class TSigaMDBas
	local aRet := {.T., ""}
	local tabela := ::tabela
	local i
   	Local bError         := { |e| oError := e , Break(e) }
   	Local bErrorBlock 
	
	dbselectarea(tabela)	
	::setOrderInternal(::pkIndex)
//	&(tabela)->(dbsetorder(1))
	&(tabela)->(dbgotop())
	if !lIns			
		if !(&(tabela)->(DBSeek(valChave)))
			aRet := {.F., "Registro não encontrado na base para fazer atualização"}
			return aRet							
		endif
	endif	
	recLock(tabela, lIns)
	bErrorBlock    := ErrorBlock( bError )			
	for i := 1 to len(::campos)
		if Self:campos[i][MUDADO] == .T.
			// TODO gerenciar erro
			begin sequence
				&(tabela)->(&(Self:campos[i][CPOTEC])) := Self:campos[i][VALOR]
			Recover
				ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
			end sequence						
		endif 						
	next
	Errorblock(bErrorBlock)	
	&(tabela)->(MsUnlock())
	::confirmNum(lIns)
	//MsUnlock(&(tabela))	
return aRet


method isInsert( valChave) class TSigaMDBas
	local aRet := {.T.,""}
	local nPos, cpo
	local i
	local lIns

	lIns := .F.
	valChave := ""
	for i := 1 to len(::chave)
		cpo := ::getCampo(::chave[i])
		//nPos := ascan(::campos, {|x| x[CPOTEC] == ::chave[i] })
//		if cpo != nil
			// campo da chave foi mudado
		if cpo[MUDADO] == .T.
			lIns := .T.
		endif
		if cpo[VALOR] == nil
			lIns := .T.
		else				  
			valChave := valChave + cpo[VALOR]
		endif
//		else
			// TODO : erro			
//			aRet := {.F., "Campos de chave não encontrados"}
//			return aRet			
//		endif
	next
return lIns



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
	local lMsErroEA
	
	lMsHelpAuto 		:= .T.
	lMsErroAuto 		:= .F. 	
	//força a gravação das informações de erro em array para manipulação da gravação ao invés de gravar direto no arquivo temporário 
	lAutoErrNoFile 	:= .T.
		
	// determina inserção ou update
	lIns := ::isInsert( @valChave)
//	if aRet2[1]
	if ::isExecAuto
			//::prepExecAuto()
		if !lIns
			lMsErroEA := ::execAuto(DELETAR)
			aRet4 := ::resExecAuto(lMsErroEA, lIns)
			if !aRet4[1]
				aRet := {.F., aRet4[2]}
			endif
		endif
	else
			// Reclock
		if !lIns
			aRet3 := ::deletaRegistro(valChave)
			if !aRet3[1]
				aRet := {.F., aRet3[2]}
			endif 		
		endif
	endif
//	else
//		aRet := {.F., aRet2[2]}
//	endif		
	
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

method setEAChave(eaChave) class TSigaMDBas
	::eaChave := eaChave
return


/*/{Protheus.doc} getEAVector
Retorna o vector de dados para chamar o ExecAuto
@type method
@return array, array contendo os dados no formato esperado pela ExecAuto
/*/
method getEAVector() class TSigaMDBas
	local i
	local cCpoTec, cpoVal, lCpoMud
	local aVetor := {}
	local nPos
	local eaChave
	//private lMsErroAuto := .F.
	
	self:ordCampos()	
	for i := 1 to len(self:campos)
		nPos := ascan(::eaChave, {|x| x == self:campos[i][CPOTEC]} )
		if (self:campos[i][MUDADO] == .T.) .Or. (nPos != 0 .And. self:campos[i][VALOR] != nil)
			// ou faz parta da chave primaria
			cCpoTec := self:campos[i][CPOTEC]
			cpoVal := self:campos[i][VALOR]
			aadd(aVetor , {cCpoTec,cpoVal,nil})
		endif	
	next
return aVetor


method resExecAuto(lMsErroEA, lIns)   class TSigaMDBas
	local aiRet := {.T., ""}
	local ciText0
	local aiErro
	local niX

	If lMsErroEA
		::rollbackNum(lIns)
		ciTexto		:=	" Erro Rotina Automática "+ Chr(13)+Chr(10)	
		aiErro 		:= GetAutoGRLog()
		For niX := 1 To Len(aiErro)
			ciTexto += aiErro[niX] + Chr(13)+Chr(10)
		Next niX								
		
		aiRet		:=	{.F.,ciTexto}
	else
		::confirmNum(lIns)
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
//	local aRet := {.T., ""}
	local cpoKey, cpo
	local i
	 
	if parentKey == nil
		cpoKey := ::chave
	else
		cpoKey := parentKey
	endif
	
	for i := 1 to len(cpoKey)
		cpo := ::getCampo(cpoKey[i])
		//nPos := ascan(::campos, {|x| x[CPOTEC] == cpoKey[i] })
		//nPos := ascan(::campos, {|x| x[2] == cpoKey[i] })
//		if cpo != nil
		Do case
			case cpo[TIPO] == "N"
				valChave := valChave + str(cpo[VALOR],cpo[TAMANHO], cpo[DECIMAL])				
			case cpo[TIPO] == "D"
				valChave := valChave + dtos(cpo[VALOR])				
			otherwise
				valChave := valChave + cpo[VALOR]	
		end case

//		else
			// TODO : erro			
//			aRet := {.F., "Campos de chave não encontrados"}
//			return aRet			
//		endif
	next	
	//aRet[2] := valChave
return valChave


/*/{Protheus.doc} hydrateM
Preeche o objeto a partir da variavel de memoria M 
@type method
/*/
method hydrateM() class  TSigaMDBas
	local tipo
	local i
   	Local bError         := { |e| oError := e , Break(e) }
   	Local bErrorBlock

	bErrorBlock    := ErrorBlock( bError )	
	for i:= 1 to len(::campos)
		begin sequence
			::campos[i][VALOR] := M->(&(self:campos[i][CPOTEC]))
		Recover
			ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
		end sequence
	next 
	Errorblock(bErrorBlock)	
return


/*/{Protheus.doc} hydratePos
Hydrata o modelo com o registro posicionado
@type method
/*/
method hydratePos() class  TSigaMDBas
	::fillCampos()
/*	local tipo
	local i
	local sTabela := ::tabela
   	Local bError         := { |e| oError := e , Break(e) }
   	Local bErrorBlock	
	
	bErrorBlock    := ErrorBlock( bError )	
	for i:= 1 to len(::campos)
		begin sequence
			::campos[i][VALOR] := (&(tabela))->(&(Self:campos[i][CPOTEC]))
			::campos[i][VALOR] := &(sTabela)->(&(self:campos[i][CPOTEC]))
		Recover
			ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
		end sequence
	next 
	Errorblock(bErrorBlock)*/	
return


method hydrateAlias(aliasQry) class  TSigaMDBas
	local i
   	Local bError         := { |e| oError := e , Break(e) }
   	Local bErrorBlock	
	
	bErrorBlock    := ErrorBlock( bError )	
	for i:= 1 to len(::campos)
		begin sequence
			::campos[i][VALOR] := (aliasQry)->(&(Self:campos[i][CPOTEC]))
		Recover
			ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
		end sequence
	next 
	Errorblock(bErrorBlock)	
return

method hydAllAlias(aliasQry) class  TSigaMDBas
   	local colObj, cNewObj, oNewObj	
   	local axArea
   			
 //  	axArea := aliasQry->(getarea())
   	
	colObj := TSColecao():New()
	(aliasQry)->(DbGoTop())
	While (aliasQry)->(!EOF())
		cNewObj := GetClassName(self)+ "():New()"
		oNewObj := &(cNewObj)
		oNewObj:hydrateAlias(aliasQry)
		colObj:add(oNewObj)		
		(aliasQry)->(DbSkip())
	enddo
	(aliasQry)->(DbGoTop())	
//	restarea(axArea)		
return colObj

/*/{Protheus.doc} hydrateACols
Preeche o objeto a partir do aHeader e aCols
@type method
@param paHeader, array, aHeader
@param paCols, array, aCols
@return TSColecao, os objetos do aCols
/*/
method hydrateACols(paHeader, paCols) class  TSigaMDBas
	local nPos, cpo
	local colObj
	local oObj
	local cCreate	
	local j, i
	
	colObj := TSColecao():New()
	for j := 1 to len(paCols)
		cCreate := GetClassName(Self) + "():New()"
		oObj := &(cCreate)
		for i := 1 to Len(paHeader)
			cpo := oObj:getCampo(alltrim(paHeader[i][2]))
			//nPos := ascan(oObj:campos, {|x| x[CPOTEC] == alltrim(paHeader[i][2])})
			if cpo != nil
				cpo[VALOR] := paCols[j][i] 	
			endif		
		next
		colObj:add(oObj)
	next
	//Local xProd := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO" })
	//Local _Prod := aCols[n,xProd]
return colObj


method hydAColsPos(paHeader, paCols, nAt)  class  TSigaMDBas
	local i, cpo
	for i := 1 to Len(paHeader)
		cpo := self:getCampo(alltrim(paHeader[i][2]))
		//nPos := ascan(oObj:campos, {|x| x[CPOTEC] == alltrim(paHeader[i][2])})
		if cpo != nil
			cpo[VALOR] := paCols[nAt][i] 	
		endif		
	next
return self



method extractACols(paHeader, colecao)  class  TSigaMDBas
	local oIterat, oItem, i
	local aCols := {}, aCol := {}
	
	oIterat := colecao:getIterator()
	oItem := colecao:first()
	while !oIterat:eoc()
		aCol := {}
		for i := 1 to len(paHeader)
	 		aadd(aCol, oItem:valor(paHeader[i][2]))
	 	next
	 	aadd(aCol, .F.)
		Aadd(aCols,	aCol)
	 	oItem := oIterat:seguinte()			 	
	enddo 	
return aCols

/*/{Protheus.doc} all
Retorna todos os elementos da tabela
@type method
@return TSColecao, todos os registros da tabela
/*/
method all(pFilter) class  TSigaMDBas
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
	if pFilter != nil
		&(tabela)->(DbSetFilter({|| &pFilter }, pFilter))
	endif			
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
/*/
method setVar(campo, valor)  class  TSigaMDBas
//	local var 
//	local nPos
//	local xReturn := nil
	local cpoVar := ""
		
	cpoVar := ::retCpoTec(campo)
	
	M->(&(cpoVar)) := valor 
//	var := CriaVar(cpoVar)	
return 


method setMemory() class   TSigaMDBas
	local i
	for i := 1 to len(::campos)
		M->(&(self:campos[i][CPOTEC])) := self:campos[i][VALOR]		
	next
return


/*/{Protheus.doc} retCpoTec
Retorna o nome técnico do campo
@type method
@param campo, character, Nome do campo
@return character, nome técnico do campo
/*/
method retCpoTec(campo)  class  TSigaMDBas
	local nPos, cpo
	local cpoVar := campo
	
	cpo := ::getCampo(campo)
//	nPos := ascan(::campos, {|x| x[CPOPOR] == campo })
	if cpo != nil
		cpoVar :=  cpo[CPOTEC]
	endif
return cpoVar


method ordCampos()   class  TSigaMDBas
	local  curTab, nPos, nX, cpo
	local aHeaderInt := {}
	local axArea := SX3->(getarea())

	// Define os campos de acordo com o array
	DbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	SX3->(DbGoTop())
	If SX3->(DbSeek(::tabela))
		curTab := SX3->X3_ARQUIVO
		while !SX3->(Eof()) .And. curTab == SX3->X3_ARQUIVO
			cpo := ::getCampo(Alltrim(SX3->X3_CAMPO))
			//nPos := ascan(self:campos, {|x| x[CPOTEC] == Alltrim(SX3->X3_CAMPO)})
			if cpo != nil
				cpo[ORDEM] := SX3->X3_ORDEM
			endif				
			SX3->(DbSkip())
		enddo 
	endif

	aSort(self:campos, , , { |x, y| x[ORDEM] < y[ORDEM] } )
	
	restarea(axArea)
	
return

/*/{Protheus.doc} simulAHeader
Retorna um aHeader
@type method
@param aFields, array, Lista do campos a incluir no aHeader, se nil -> todos
@param aNoCampos, array, Lista dos campos a ser excluidos do aHeader
@return array, aHeader
/*/
method simulAHeader( aFlds, aNoCampos, lValid)    class  TSigaMDBas
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
//		SX3->(DbGoTop())		
		If SX3->(DbSeek(cpoTec))	
			// adiciona as informações do campo para o getdados
			if (lValid == nil) .Or. (lValid != nil .And. lValid == .T.)  	
				Aadd(aHeaderInt, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
					SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
			else
				Aadd(aHeaderInt, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,/*SX3->X3_VALID*/,;
					SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
			endif
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


method getColBrowse(aHeaderInt, aFlds, aNoCampos, lValid)     class  TSigaMDBas
	//local aColunas
	local  curTab, nPos, nX
	//local aHeaderInt := {}
	local axArea := SX3->(getarea())

	// Define gilleos campos de acordo com o array
	if aHeaderInt == nil
		aHeaderInt := {}
	endif
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
//		SX3->(DbGoTop())
		If SX3->(DbSeek(cpoTec))	
			// adiciona as informações do campo para o getdados
			if SX3->X3_TIPO != "M"
				Aadd(aHeaderInt, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_TIPO, SX3->X3_TAMANHO,SX3->X3_DECIMAL;
							,SX3->X3_PICTURE})
			endif
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


method setOrderInternal(index)  class  TSigaMDBas
	// se index é numerico
		// se inferior ou igual a 9 
		// se superior a 9
	// se caracter
		// se len == 1
			// transformar
		// se len > 1 
			// usar alias
	local idx := index
	local tabela := ::tabela
	local aAlf := {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
	local nPos
	if valType(idx) == "N"
		&(tabela)->(dbsetorder(idx))
	else
		if Len(idx) == 1
			// transforma letra em numero
			nPos := ascan(aAlf, {|x| x == idx})
			if nPos != 0
				idx := 9 + nPos
			else
				idx := val(idx)				
			endif			
			&(tabela)->(dbsetorder(idx))
		else
			&(tabela)->(dbordernickname(idx))
		endif
	endif  	
return


method clone()  class  TSigaMDBas
	local cCreate, oObj
	cCreate := GetClassName(Self) + "():New()"
	oObj := &(cCreate)

	oObj:campos := aClone(self:campos)
		
return oObj
