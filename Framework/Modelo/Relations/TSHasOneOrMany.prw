#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSHasOneOrMany� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Rela��o Has One Or Many   					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSHasOneOrMany
Classe definindo uma rela��o de tipo One To Many
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
@param parent, TSigaMDBas, instancia de quem esta definindo a rela��o
@param relatedType, character, Tipo relacionado
@param indexFk, num�rico, n�mero do indexo para procurar no modelo relacionado
@param localKey, array, chave na tabela fonte
@example
	Um grupo tributario � asociado a varios produtos <br>
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

