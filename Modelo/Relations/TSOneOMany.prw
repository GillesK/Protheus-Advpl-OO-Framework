#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSOneOManyบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Rela็ใo Has One Or Many   					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSOneOMany
Classe definindo uma rela็ใo de tipo One To Many.

Herda de TSigaMDRel
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0

/*/
Class TSOneOMany From TSigaMDRel
/**
     * The foreign key of the parent model.
     *
     * @var string
     */
    data indexFk
    /**
     * The local key of the parent model.
     *
     * @var string
     */
    data localKey
    
    data numCpoFk
    data comFilial
    
	method New() constructor
	method obterOrFail()
	method salvar()
	method salvarVarios()
	method getEAVector()	
EndClass


/*/{Protheus.doc} New
Construtor
@type method
@param parent, TSigaMDBas, instancia de quem esta definindo a rela็ใo
@param relatedType, character, Tipo relacionado
@param indexFk, num้rico, n๚mero do indexo para procurar no modelo relacionado
@param localKey, array, chave na tabela fonte
@example
	Um grupo tributario ้ asociado a varios produtos <br>
	 <br>
Method produto() class TEGrupoTributario <br>
return TSHasMany():New(self, "TSProduto", {"B1_GRTRIB"}, nil) <br>	
/*/
method New(parent, relatedType, indexFk, localKey) class TSOneOMany
	_Super:New(parent, relatedType)
	
	::indexFk := indexFk
	::localKey := localKey
	::numCpoFk := len(localKey) + 1		
return  (Self)

/*/{Protheus.doc} obterOrFail
Obter os objetos da rela็ใo
@type method
@return array, {lRet, obj} lRet: .T. se encontrou e obj = instancia de TSColecao. lRet: .F. se nใo, obj : Mensagem de erro 
/*/
method obterOrFail() class TSOneOMany
	local xRet, valKey
	local pai := Self:parent
	local lk := Self:localKey
	valKey := pai:getValKey(lk)
//	if xRet[1]
//	if comFilial != nil .And. comFilial == .T.	
	//	xRet := self:related:findAllOrFail(  valKey, ::indexFk, ::numCpoFk, "")
//	else
		xRet := self:related:findAllOrFail(  valKey, ::indexFk, ::numCpoFk)
	//endif
//	endif	
return xRet


method salvar(modelo) class TSOneOMany
	local i
	local aChave
	local pai
	// procurar chave
	aChave := modelo:getChave(::indexFk)
	
	pai := self:parent
	modelo:geraFilial()
//	$model->setAttribute($this->getPlainForeignKey(), $this->getParentKey());
	for i := 1 to len(self:localKey)
		//::parent:valor(self:localKey[i])
		//nPos := ascan(::parent:campos, {|x| x[CPOTEC] == self:localKey[i] })
		//nPos := ascan(::campos, {|x| x[2] == cpoKey[i] })
		if modelo:temFilial
			modelo:setar(aChave[i+1], pai:valor(self:localKey[i]))
		else
			modelo:setar(aChave[i], pai:valor(self:localKey[i]))
		endif		
	next
return modelo:salvar()


/*/{Protheus.doc} salvarVarios
Salvar os filhos
@type method
@param modelos, cole็ใo, cole็ใo dos filhos
/*/
method salvarVarios(modelos) class TSOneOMany
	local oIterat, modelo
	local pai 
	
	pai := self:parent
	if pai:isExecAuto
		pai:setFilhos(modelos)
	else
		oIterat := modelos:getIterator()
		modelo := oIterat:first()
		while !oIterat:eoc()
			::salvar(modelo)		
			modelo := oIterat:seguinte()
		enddo	
	endif
return


method getEAVector() class TSOneOMany
	local aVector := {}
	local i, pai, oIterat
	local modelo
//	local aVetMod 
	
	pai := self:parent
	if pai:filhos != nil
		oIterat := pai:filhos:getIterator()
		modelo := oIterat:first()
		while !oIterat:eoc()
			aadd(aVector, modelo:getEAVector())
			modelo := oIterat:seguinte()
		enddo
	endif
return aVector
