#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIterator� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Itera��o de uma cole��o 					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSIterator
Iterator de  cole��o
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSIterator
	data oCol
	data nCurr
	
	method New() Constructor
	method seguinte()
	method anterior()
	method first()
	method last()	
	method eoc()
	method boc()
	method current()
EndClass 


/*/{Protheus.doc} New
Construtor
@type method
@param oCol, objeto, Cole��o
/*/
method New(oCol) Class TSIterator
	//::oCol := {}
	::nCurr := 1
	::oCol := oCol
return self


/*/{Protheus.doc} Eoc
Retorna .T. se posicinado no final da cole��o
@type method
@return l�gico, 
/*/
method eoc()  Class TSIterator
	local xRet := .F.
	local nLim := ::oCol:length() + 1
	if ::nCurr == nLim
		xRet := .T.
	endif
return xRet

/*/{Protheus.doc} Boc
Retorna .T. se posicinado no inicio da cole��o
@type method
@return l�gico,
/*/
method boc()  Class TSIterator
	local xRet := .F.
	if ::nCurr == 0
		xRet := .T.
	endif
return xRet


/*/{Protheus.doc} anterior
Se posiciona no elemento anterior da cole��o
@type method
@return mix, objeto da cole��o ou nil se ja esta no inicio
/*/
method anterior() Class TSIterator
	if ::nCurr < 1
		return nil
	endif
	::nCurr -= 1
return	::oCol:obter(::nCurr)

/*/{Protheus.doc} seguinte
Se posiciona no elemento seguinte da cole��o
@type method
@return mix, objeto da cole��o ou nil se ja esta no final
/*/
method seguinte() Class TSIterator
	if ::nCurr > ::oCol:length()
		return nil
	endif
	::nCurr += 1
return	::oCol:obter(::nCurr)

/*/{Protheus.doc} first
Se posiciona e retorna o primeiro da cole��o
@type method
@return mix, retorna o primeiro da cole��o ou nil se cole��o vazia
/*/
method first() Class TSIterator
	if ::oCol:length() == 0
		return nil
	endif
	::nCurr := 1
return	::oCol:obter(::nCurr)

/*/{Protheus.doc} last
Se posiciona e retorna o ultimo da cole��o
@type method
@return mix, retorna o ultimo da cole��o ou nil se cole��o vazia
/*/
method last() Class TSIterator
	if ::oCol:length() == 0
		return nil
	endif
	::nCurr := ::oCol:length()
return	::oCol:obter(::nCurr)


method current() Class  TSIterator
	if ::oCol:length() == 0
		return nil
	endif
return ::oCol:obter(::nCurr)
