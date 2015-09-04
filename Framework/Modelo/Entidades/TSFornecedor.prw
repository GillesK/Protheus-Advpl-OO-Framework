#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSFornecedor� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Fornecedor          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSFornecedor
Classe representando um fornecedor (SA2).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSFornecedor From TSigaMDBas

	method New() Constructor
		
	method iniCampos()
EndClass


Method New( ) Class TSFornecedor 
	_Super:New()
	::tabela 	  := 		"SA2"	
	::entidade			:=	"Fornecedor"
	::funcao			:=	"Cadastro de Fornecedor"		
	::execAuto := 			.T.	
return (Self)


Method iniCampos() class TSFornecedor
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial", "A2_FILIAL", "C"};
				,{"codigo", "A2_COD", "C"};
				,{"loja", "A2_LOJA", "C"};
				,{"estado", "A2_EST", "C"}}

	::addCpoDef(cpoDef)	

	::setChave({"A2_FILIAL", "A2_COD"})
		
return
