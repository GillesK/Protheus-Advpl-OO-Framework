#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSProduto บ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br              บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Produto          					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Elfa								                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
	method execAuto()
	method grupoTributario()
	method grupoProduto()
	method fornecedorPadrao()	
EndClass


Method New( ) Class TSProduto 
	_Super:New()
	// Inicializa็ใo do nome da tabela
	::tabela 	  		:= 			"SB1"
	// Nome em portugues do modelo
	::entidade			:=			"Produto"
	::funcao			:=		"Cadastro de produto"
	// Uso de execAuto para inserir, atualizar e deletar	
	::isExecAuto := 			.T.
return (Self)


Method iniCampos() class TSProduto
	// Nome externo, nome interno, tipo
	local cpoDef
	// defini็ใo dos campos e aliases
	cpoDef := {{"filial"					, "B1_FILIAL"		, "C"};
				,{"codigo"					, "B1_COD"			, "C"};
				,{"origem"					, "B1_ORIGEM"		, "C"};
				,{"grupoTributario"		, "B1_GRTRIB"		, "C"};
				,{"descricao"				, "B1_DESC"		, "C"};				
				,{"grupoProduto"			, "B1_GRUPO"		, "C"};
				,{"fornecedorPadrao"		, "B1_PROC"		, "C"};
				,{"lojaFornecedorPadrao"	, "B1_LOJPROC"	, "C"};
				,{"armazemPadrao"			, "B1_LOCPAD"		, "C"};
				,{"unidadeMedida"			, "B1_UM"			, "C"}}
				
	::addCpoDef(cpoDef)	
	
	// defini็ใo das chaves: equivalente aos indexos	
	::setChave({{"1",{"B1_FILIAL", "B1_COD"}};
				,{"4",{"B1_FILIAL", "B1_GRUPO", "B1_COD"}}})				
return


method execAuto(opcao) class TSProduto
	// exec auto do modelo
	MSExecAuto({|x,y| Mata010(x,y)},::getEAVector(),opcao)
return

// Defini็ใo da rela็ใo com o modelo grupo tributario
method grupoTributario()  class TSProduto
// 1 representa o index que vai ser usado na tabela do grupo tributario e 
// {B1_GRTRIB} a chave usada para procurar o grupo tributario
return ::belongsTo('TEGrupoTributario', {'B1_GRTRIB'}, "1" )

// Defini็ใo da rela็ใo com o modelo grupo tributario
method grupoProduto()  class TSProduto
// 1 representa o index que vai ser usado na tabela do grupo tributario e 
// {B1_GRTRIB} a chave usada para procurar o grupo tributario
return ::belongsTo('TSGrupoProduto', {'B1_GRUPO'}, "1" )

method fornecedorPadrao()  class TSProduto
// 1 representa o index que vai ser usado na tabela do grupo tributario e 
// {B1_GRTRIB} a chave usada para procurar o grupo tributario
return ::belongsTo('TSFornecedor', {'B1_PROC', 'B1_LOJPROC'}, "1" )

 
