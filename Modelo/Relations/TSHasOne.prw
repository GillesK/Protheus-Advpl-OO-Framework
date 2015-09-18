#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSHasOne� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Rela��o Has One   					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSHasOne
Rela��o de tipo One to One.

Herda de TSOneOMany
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSHasOne From TSOneOMany

	method obterOrFail()
	method New() constructor	
EndClass

method New(parent, relatedType, foreignKey, indexOtherKey) class TSHasOne
	_Super:New(parent, relatedType, foreignKey, indexOtherKey)
	
return  (Self)

/*/{Protheus.doc} obterOrFail
Obter os objetos da rela��o
@type method
@return array, {lRet, obj} lRet: .T. se encontrou e obj = instancia de TSigaMDBas. lRet: .F. se n�o, obj : Mensagem de erro 
/*/
method obterOrFail() class TSHasOne
	local xRet
	xRet := _Super:obterOrFail()
	if xRet[1]
		xRet := xRet[2]:first()
	endif	
return xRet