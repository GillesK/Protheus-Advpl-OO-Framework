#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSProduto � Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Produto          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*/{Protheus.doc} TSProduto
Classe representando um produto (SB1).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/

Class TSProduto From TSigaMDBas

	method New() Constructor
	
	Method iniCampos() 	
	method execute()
EndClass


Method New( ) Class TSProduto 
	_Super:New()
	::tabela 	  		:= 			"SB1"
	::entidade			:=			"Produto"
	::funcao			:=		"Cadastro de produto"	
	::execAuto := 			.T.
return (Self)




method execute(aVetor, opcao) class TSProduto
	// TODO
	MSExecAuto({|x,y| Mata010(x,y)},::aVetor, opcao)	
return 


Method iniCampos() class TSProduto
	// Nome externo, nome interno, tipo
	local cpoDef
	cpoDef := {{"filial", "B1_FILIAL", "C"};
				,{"codigo", "B1_COD", "C"};
				,{"origem", "B1_ORIGEM", "C"};
				,{"grupoTributario", "B1_GRTRIB", "C"}}
	::addCpoDef(cpoDef)	
		
	::setChave({"B1_FILIAL", "B1_COD"})				
return

