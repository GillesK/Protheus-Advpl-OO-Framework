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
	
return


method obterOrFail() class TSHasOne
	local xRet
	xRet := _Super:obterOrFail()
	if xRet[1]
		xRet := xRet[2]:first()
	endif	
return xRet