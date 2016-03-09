#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSColecaoบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Base Cole็ใo 					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSColecao
Cole็ใo
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSColecao
	data aCol
	//data nCurr
	
	method New() Constructor
	method add()
	method length()
	method reset()
	method obter()		
	method getIterator()
	method find()
	method sort()	
	method hydrateAlias()
	method findA()
	method sortA()
	method excluir()
EndClass 


method New() Class TSColecao
	::aCol := {}
	//::nCurr := 0
return self

/*/{Protheus.doc} getIterator
Retorna um novo iterator
@type method
/*/
method getIterator() Class TSColecao
return TSIterator():New(self)

/*/{Protheus.doc} obter
Obter o objeto no indice especificado
@type method
@param ind, num้rico, Index dentro da cole็ใo
/*/
method obter(ind) Class TSColecao
	if ind < 1 .Or. ind > ::length()
		return nil
	endif
return ::aCol[ind]

/*/{Protheus.doc} add
Adicionar objeto a cole็ใo
@type method
@param obj, objeto, Objeto a adicinar a cole็ใo
/*/
method add(obj) Class TSColecao
	aadd(::aCol, obj)	
return

/*/{Protheus.doc} reset
Esvazia a cole็ใo
@type method
/*/
method reset() Class TSColecao
	//::nCurr := 0
	::aCol := {}
return

/*/{Protheus.doc} length
Retorna o tamanho da cole็ใo
@type method
/*/
method length() Class TSColecao	
return len(::aCol)

/*/{Protheus.doc} find
Encontrar um elemento na cole็ใo. (relacionado a TSigaMDBas e TSTransObj)
@type method
@param key, character, chave (relacionado a TSigaMDBas e TSTransObj)
@param values, mixed, valor
@param bCode, bl๓co de codigo, Mesma forma que para ascan
/*/
method find( key, value, bCode)  Class TSColecao
	local oObj := nil
	local nPos
	if key == nil	
		nPos := ascan(::aCol, bCode)
	else
		nPos := ascan(::aCol, {|x| x:equalVal(key, value)})
	endif
	if nPos != 0
		oObj := ::aCol[nPos]
	endif
return oObj


/*/{Protheus.doc} findA
Encontra o objeto (relacionado a TSigaMDBas e TSTransObj)
@type method
@param keys, array, array de chaves (relacionado a TSigaMDBas e TSTransObj)
@param values, array, array de valores
@param bCode, bloco de c๓digo, bloco de codigo do ascan
/*/
method findA( keys, values, bCode)  Class TSColecao
	local oObj := nil
	local nPos
	local i
	local cCompare := ""
	local value := ""
	
	if keys == nil	
		nPos := ascan(::aCol, bCode)
	else 
		nPos := ascan(::aCol, {|x| x:equalValA(keys, values)})	
	endif
	if nPos != 0
		oObj := ::aCol[nPos]
	endif
return oObj


/*/{Protheus.doc} sort
Sort
@type method
@param nNum1, num้rico, (Descri็ใo do parโmetro)
@param nNum2, num้rico, (Descri็ใo do parโmetro)
@param bCode, booleano, (Descri็ใo do parโmetro)
/*/
method sort(nNum1, nNum2, bCode) Class TSColecao
return asort(::aCol, nNum1, nNum2, bCode)


/*/{Protheus.doc} sortA
Ordena a cole็ใo. (relacionado a TSigaMDBas e TSTransObj)
@type method
@param keys, array, chaves participando do sort
@param comp, character, operador de compara็ใo
@param bCode, bloco de c๓digo, bloco de c๓digo do sort (TODO)
/*/
method sortA(keys, comp, bCode) Class TSColecao
	local bCode
	local compare
	default comp := "<"

//	compare  := "x:concat(keys) " + comp + " y:concat(keys)"
//return asort(::aCol, , , {|x,y| &compare})
return asort(::aCol, , , {|x,y| x:concat(keys) < y:concat(keys)})

/*/{Protheus.doc} excluir
Excluir 1 item da cole็ใo
@type method
@param pos, num้rico, posi็ใo do item a excluir
/*/
method excluir(pos)  Class TSColecao
	local curLen
	curLen := self:length()
	ADel(::aCol, pos)
	ASize(::aCol, curLen -1)
return 