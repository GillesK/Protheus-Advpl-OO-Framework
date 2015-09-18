#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSGrupoProduto � Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Grupo de Produto          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*/{Protheus.doc} TSGrupoProduto
Classe representando um grupo de produto (SBM).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/

Class TSGrupoProduto From TSigaMDBas

	method New() Constructor
	
	Method iniCampos() 	
//	method defDBCampos()
	method produto()
EndClass


Method New( ) Class TSGrupoProduto 
	_Super:New()
	// Inicializa��o do nome da tabela
	::tabela 	  		:= 			"SBM"
	// Nome em portugues do modelo
	::entidade			:=			"Grupo de Produto"
	::funcao			:=		"Cadastro de grupo de produto"
	// Uso de execAuto para inserir, atualizar e deletar	
	::execAuto := 			.F.
return (Self)


Method iniCampos() class TSGrupoProduto
	// Nome externo, nome interno, tipo
	local cpoDef
	// defini��o dos campos e aliases
	cpoDef := {{"filial", "BM_FILIAL", "C"};
				,{"codigo", "BM_GRUPO", "C"};
				,{"descricao", "BM_DESC", "C"}}
	::addCpoDef(cpoDef)	
	
	// defini��o das chaves: equivalente aos indexos	
	::setChave({{1,{"BM_FILIAL", "BM_GRUPO"}}})				
return




// Defini��o da rela��o com o modelo grupo tributario
method produto()  class TSGrupoProduto

return ::HasMany('TSProduto', 4, {'BM_GRUPO'} )




 
