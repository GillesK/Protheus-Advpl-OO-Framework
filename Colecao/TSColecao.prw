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
Encontrar um elemento na cole��o
@type method
@param bCode, bl�co de codigo, Mesma forma que para ascan
/*/
method find(bCode)  Class TSColecao	
return ascan(::aCol, bCode)


/*/{Protheus.doc} sort
Sort
@type method
@param nNum1, num�rico, (Descri��o do par�metro)
@param nNum2, num�rico, (Descri��o do par�metro)
@param bCode, booleano, (Descri��o do par�metro)
/*/
method sort(nNum1, nNum2, bCode) Class TSColecao
return asort(::aCol, nNum1, nNum2, bCode)