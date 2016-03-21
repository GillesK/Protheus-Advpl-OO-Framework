#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TSGrupoProduto º Autor ³ gilles koffmann º Data  ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de Grupo de Produto          					    		    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework copyright Sigaware Pb                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
	method produtos()
EndClass


Method New( ) Class TSGrupoProduto 
	_Super:New()
	// Inicialização do nome da tabela
	::tabela 	  		:= 			"SBM"
	// Nome em portugues do modelo
	::entidade			:=			"Grupo de Produto"
	::funcao			:=		"Cadastro de grupo de produto"
	// Uso de execAuto para inserir, atualizar e deletar	
	::isExecAuto := 			.F.
return (Self)


Method iniCampos() class TSGrupoProduto
	// Nome externo, nome interno, tipo
	local cpoDef
	// definição dos campos e aliases
	cpoDef := {{"filial"			, "BM_FILIAL"		, "C"};
				,{"codigo"			, "BM_GRUPO"		, "C"};
				,{"descricao"		, "BM_DESC"			, "C"}}
	::addCpoDef(cpoDef)	
	
	// definição das chaves: equivalente aos indexos	
	::setChave({{"1",{"BM_FILIAL", "BM_GRUPO"}}})				
return


// Definição da relação com o modelo Produto
method produtos()  class TSGrupoProduto
// Um grupo de produto é constituido de varios Produtos -> usar a relação HasMany
// TSProduto: nome da classe 
// "4" : indexo utilizado na classe TSProduto para fazer a relação. Chave estrangeira.
// {'BM_GRUPO'} : Campos no grupo de produto que permitem acessar os produtos atraves do indexo 4
return ::HasMany('TSProduto', "4", {'BM_GRUPO'} )

