#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSBelongsTo� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Rela��o Belongs To   					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
@param parent, ${param_type}, (Descri��o do par�metro)
@param relatedType, ${param_type}, (Descri��o do par�metro)
@param foreignKey, ${param_type}, (Descri��o do par�metro)
@param indexOtherKey, ${param_type}, (Descri��o do par�metro)
@example
(examples)
@see (links_or_references)
/*/
method New(parent, relatedType, foreignKey, indexOtherKey) class TSBelongsTo
	_Super:New(parent, relatedType)
	
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
	local pai
	local fk
	if ::indexOtherKey == nil
		ind := 1
	endif
	   
	pai := Self:parent
	fk :=  Self:foreignKey  
	xRet := pai:getValKey(fk)

	if xRet[1]
		xRet := ::related:findByOrFail(ind, xRet[2])
	endif	
return xRet

