#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSOneOMany� Autor � gilles koffmann � Data  �  17/08/15   ���
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


/*/{Protheus.doc} TSOneOMany
Classe definindo uma rela��o de tipo One To Many
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0

/*/
Class TSOneOMany From TSigaMDRel
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
method New(parent, relatedType, indexFk, localKey) class TSOneOMany
	_Super:New(parent, relatedType)
	
	::indexFk := indexFk
	::localKey := localKey	
return  (Self)

/*/{Protheus.doc} obterOrFail
Obter os objetos da rela��o
@type method
@return array, {lRet, obj} lRet: .T. se encontrou e obj = instancia de TSColecao. lRet: .F. se n�o, obj : Mensagem de erro 
/*/
method obterOrFail() class TSOneOMany
	local xRet
	local pai := Self:parent
	local lk := Self:localKey
	xRet := pai:getValKey(lk)
	if xRet[1]
		xRet := self:related:findAllByOrFail(::indexFk, xRet[2])
	endif	
return xRet

