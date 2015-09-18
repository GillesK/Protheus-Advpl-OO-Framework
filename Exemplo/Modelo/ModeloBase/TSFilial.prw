#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSFilial� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Filial          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*/{Protheus.doc} TSFilial
Classe representando uma filial (SM0).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSFilial From TSigaMDBas
		
	method New() Constructor			
	method iniCampos()
EndClass


Method New( ) Class TSFilial 
	_Super:New()
	::tabela 			:= 		"SM0"
	::entidade			:=		"Filial"
	::funcao				:= "Cadastro de Filial"		
//	dbselectarea(::tabela)
//	self:fillCampos()
return (Self)



Method iniCampos() class TSFilial
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"empresa", "M0_CODIGO", "C"};
				,{"filial", "M0_CODFIL", "C"};
				,{"estadoEntrega", "M0_ESTENT", "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{1,{"M0_CODIGO", "M0_CODFIL"}}})
return