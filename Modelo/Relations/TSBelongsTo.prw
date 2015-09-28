#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSBelongsToบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Rela็ใo Belongs To   					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSBelongsTo
Classe de rela็ใo "Pertence a".
Herda de TSigaMDRel
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSBelongsTo  From TSigaMDRel
/**
     * The foreign key of the parent model.
     *
     * @var string
     */
    data foreignKey
    /**
     * The associated key on the parent model.
     *
     * @var string
     */
    data indexOtherKey
    /**
     * The name of the relationship.
     *
     * @var string
     */
    //data relation
    
    method New() constructor
    method obterOrFail()
EndClass


/*/{Protheus.doc} New
Construtor
@type method
@param parent, TSigaMDBas, instancia de quem esta definindo a rela็ใo
@param relatedType, character, Tipo relacionado
@param foreignKey, array, foreign key na tabela.
@param indexOtherKey, num้rico, n๚mero do indexo para procurar no modelo relacionado
/*/
method New(parent, relatedType, foreignKey, indexOtherKey) class TSBelongsTo
	_Super:New(parent, relatedType)
	
	::foreignKey := foreignKey
	::indexOtherKey := indexOtherKey
	
return  (Self)


/*/{Protheus.doc} obterOrFail
Obter os objetos da rela็ใo
@type method
@return array, {lRet, obj} lRet: .T. se encontrou e obj = instancia de TSigaMDBas. lRet: .F. se nใo, obj : Mensagem de erro 
/*/
method obterOrFail() class TSBelongsTo
	local xRet
	local ind := ::indexOtherKey
	local pai
	local fk
	if ::indexOtherKey == nil
		ind := 1
	endif
	   
	pai := Self:parent
	fk :=  Self:foreignKey  
	xRet := pai:getValKey(fk)

	if xRet[1]
		xRet := ::related:findOrFail( xRet[2], ind)
	endif	
return xRet

