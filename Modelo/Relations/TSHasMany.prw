#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSHasMany� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Rela��o Has Many   					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSHasMany
Rela��o de tipo One To Many.

Herda de TSOneOMany
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSHasMany From TSOneOMany

	method New() constructor
EndClass


method New(parent, relatedType, foreignKey,  indexOtherKey) class TSHasMany
	_Super:New(parent, relatedType, foreignKey, indexOtherKey)
	
return  (Self)