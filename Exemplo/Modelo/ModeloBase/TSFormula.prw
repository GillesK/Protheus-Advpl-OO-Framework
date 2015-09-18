#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSFormula� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de formula          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSPedidoVenda
Classe representando uma formula (SM4).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSFormula From TSigaMDBas
	method New() Constructor
	method iniCampos()

EndClass


Method New( ) Class TSFormula 
	_Super:New()
	::tabela 	  := 		"SM4"	
	::entidade			:=	"Formula"
	::funcao			:= "Cadastro de Formula"		
return (Self)


Method iniCampos() class TSFormula
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial", "M4_FILIAL", "C"};
				,{"codigo", "M4_CODIGO", "C"};
				,{"formula", "M4_FORMULA", "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{1,{"M4_FILIAL", "M4_CODIGO"}}})			
return


