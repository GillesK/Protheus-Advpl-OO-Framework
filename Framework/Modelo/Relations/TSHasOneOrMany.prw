#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSHasOneOrManyบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
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


/*/{Protheus.doc} TSHasOneOrMany
Classe definindo uma rela็ใo de tipo One To Many
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0

/*/
Class TSHasOneOrMany From TSigaMDRel
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
    
	method New() constructor
	method obterOrFail()
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
method New(parent, relatedType, indexFk, localKey) class TSHasOneOrMany
	_Self:New(parent, relatedType)
	
	::indexFk := indexFk
	::localKey := localKey	
return

method obterOrFail() class TSHasOneOrMany
	local xRet
	xRet := ::getValKey(::localKey)
	if xRet[1]
		xRet := related:findAllByOrFail(::indexFk, xRet[2])
	endif	
return xRet

