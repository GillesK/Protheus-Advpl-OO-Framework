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
(long_description)
@type method
@param parent, ${param_type}, (Descri็ใo do parโmetro)
@param relatedType, ${param_type}, (Descri็ใo do parโmetro)
@param foreignKey, ${param_type}, (Descri็ใo do parโmetro)
@param indexOtherKey, ${param_type}, (Descri็ใo do parโmetro)
@example
(examples)
@see (links_or_references)
/*/
method New(parent, relatedType, foreignKey, indexOtherKey) class TSBelongsTo
	_Self:New(parent, relatedType)
	
	::foreignKey := foreignKey
	::indexOtherKey := indexOtherKey
	
return


/*/{Protheus.doc} obterOrFail
(long_description)
@type method
@example
(examples)
@see (links_or_references)
/*/method obterOrFail() class TSBelongsTo
	local xRet
	local ind := ::indexOtherKey
	
	if ::indexOtherKey == nil
		ind := 1
	endif
	   
	xRet := ::getValKey(::foreignKey)

	if xRet[1]
		xRet := related:findByOrFail(ind, xRet[2])
	endif	
return xRet

