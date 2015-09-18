#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSCliente� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Cliente          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSCliente
Classe representando um cliente (SA1).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSCliente From TSigaMDBas
	method New() Constructor
	method iniCampos()
	method execAuto()
EndClass


Method New( ) Class TSCliente 
	_Super:New()
	::tabela 	  := 		"SA1"	
	::entidade			:=	"Cliente"
	::funcao			:= "Cadastro de Cliente"		
	::execAuto := 			.T.	
return (Self)


Method iniCampos() class TSCliente
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial", "A1_FILIAL", "C"};
				,{"codigo", "A1_COD", "C"};
				,{"loja", "A1_LOJA", "C"};
				,{"estado", "A1_EST", "C"};
				,{"grupoTributario", "A1_GRPTRIB", "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{1,{"A1_FILIAL", "A1_COD", "A1_LOJA"}}})			
return


method execAuto(opcao) class TSCliente
	MSExecAuto({|x,y| Mata030(x,y)},::getEAVector(),opcao)
return