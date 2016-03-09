#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSColecao� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Base Cole��o 					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSColecao
Cole��o
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
@param ind, num�rico, Index dentro da cole��o
/*/
method obter(ind) Class TSColecao
	if ind < 1 .Or. ind > ::length()
		return nil
	endif
return ::aCol[ind]

/*/{Protheus.doc} add
Adicionar objeto a cole��o
@type method
@param obj, objeto, Objeto a adicinar a cole��o
/*/
method add(obj) Class TSColecao
	aadd(::aCol, obj)	
return

/*/{Protheus.doc} reset
Esvazia a cole��o
@type method
/*/
method reset() Class TSColecao
	//::nCurr := 0
	::aCol := {}
return

/*/{Protheus.doc} length
Retorna o tamanho da cole��o
@type method
/*/
method length() Class TSColecao	
return len(::aCol)

/*/{Protheus.doc} find
Encontrar um elemento na cole��o. (relacionado a TSigaMDBas e TSTransObj)
@type method
@param key, character, chave (relacionado a TSigaMDBas e TSTransObj)
@param values, mixed, valor
@param bCode, bl�co de codigo, Mesma forma que para ascan
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
@param bCode, bloco de c�digo, bloco de codigo do ascan
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
@param nNum1, num�rico, (Descri��o do par�metro)
@param nNum2, num�rico, (Descri��o do par�metro)
@param bCode, booleano, (Descri��o do par�metro)
/*/
method sort(nNum1, nNum2, bCode) Class TSColecao
return asort(::aCol, nNum1, nNum2, bCode)


/*/{Protheus.doc} sortA
Ordena a cole��o. (relacionado a TSigaMDBas e TSTransObj)
@type method
@param keys, array, chaves participando do sort
@param comp, character, operador de compara��o
@param bCode, bloco de c�digo, bloco de c�digo do sort (TODO)
/*/
method sortA(keys, comp, bCode) Class TSColecao
	local bCode
	local compare
	default comp := "<"

//	compare  := "x:concat(keys) " + comp + " y:concat(keys)"
//return asort(::aCol, , , {|x,y| &compare})
return asort(::aCol, , , {|x,y| x:concat(keys) < y:concat(keys)})

/*/{Protheus.doc} excluir
Excluir 1 item da cole��o
@type method
@param pos, num�rico, posi��o do item a excluir
/*/
method excluir(pos)  Class TSColecao
	local curLen
	curLen := self:length()
	ADel(::aCol, pos)
	ASize(::aCol, curLen -1)
return 