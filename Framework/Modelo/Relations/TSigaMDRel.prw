#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"   
  


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSigaMDRel� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Base Rela��o 					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSigaMDRel
Classe de base Rela��o.
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSigaMDRel 

	data relatedType
	data related	
	data parent
	
	Method New() constructor
	method obter()
	method obterOrFail()	 
	//method getvalKey()
EndClass

method New(parent, relatedType) class TSigaMDRel 
	::parent := parent
	::relatedType := relatedType
	cNameObj := ::relatedType + "():New()"
	::related := &(cNameObj) 
return  (Self)



/*/{Protheus.doc} obter
Obter os objetos da rela��o
@type method
@return mix, instancia de TSColecao ou TSigaMDBas, nil se n�o tem objetos na rela��o
/*/
Method obter() class TSigaMDRel
	local xRet 
	xRet := ::obterOrFail()
	if xRet[1]
		return xRet[2]
	else
		return nil
	endif
return xRet

/*/{Protheus.doc} obterOrFail
Obter os objetos da rela��o
@type method
@return array, {lRet, obj} lRet: .T. se encontrou e obj = instancia de TSColecao ou TSigaMDBas. lRet: .F. se n�o, obj : Mensagem de erro 
/*/
method obterOrFail() class TSigaMDRel

return 