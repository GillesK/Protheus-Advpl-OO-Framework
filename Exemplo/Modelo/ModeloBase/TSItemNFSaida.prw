#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSItemNFSaidaบ Autor ณ gilles koffmann บ Data  ณ  16/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Item de Nota Fiscal de saida		    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSItemNFSaida
Classe representando um item de NF de Saida (SD2).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSItemNFSaida From TSigaMDBas
	method New() Constructor
	method iniCampos()
//	method execAuto()
//	method tes()
	method nf()
	method produto()
	method itemPedidoVenda()
	method pedidoVenda()
EndClass


Method New( ) Class TSItemNFSaida
	_Super:New()
	::tabela 	  := 		"SD2"	
	::entidade			:=	"Item de NF de saida"
	::funcao			:= "Item de NF de saida"		
	
return (Self)


Method iniCampos() class TSItemNFSaida
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial"						, "D2_FILIAL"		, "C"};
				,{"item"						, "D2_ITEM"		, "C"};
				,{"produto"					, "D2_COD"			, "C"};
				,{"numeroNf"					, "D2_DOC"			, "C"};
				,{"serie"						, "D2_SERIE"		, "C"};
				,{"cliente"					, "D2_CLIENTE"	, "C"};
				,{"lojaFornecedor"			, "D2_LOJA"		, "C"};
				,{"pedidoVenda"				, "D2_PEDIDO"		, "C"};
				,{"itemPedidoVenda"			, "D2_ITEMPV"		, "C"};
				,{"unidadeMedida"				, "D2_UM"			, "C"};
				,{"quantidade"				, "D2_QUANT"		, "N"};
				,{"armazem"					, "D2_LOCAL"		, "C"};
				,{"tipoDocumento"				, "D2_TIPO"		, "C"};
				,{"lote"						, "D2_LOTECTL"	, "C"};
				,{"dataValidade"				, "D2_DTVALID"	, "D"};
				,{"formularioPropio"			, "D2_FORMUL"		, "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{"3",{"D2_FILIAL", "D2_DOC", "D2_SERIE","D2_CLIENTE", "D2_LOJA", "D2_COD", "D2_ITEM"}}})			
return

method pedidoVenda() class TSItemNFSaida
return ::belongsTo("TSPedidoVenda", { "D2_PEDIDO"}, "1" )

method itemPedidoVenda()  class TSItemNFSaida
return ::belongsTo("TSItemPedidoVenda", { "D2_PEDIDO", "D2_ITEMPV"}, "1" )

Method nf() class TSItemNFSaida
return ::belongsTo("TSNFSaida", {"D2_DOC", "D2_SERIE","D2_CIENTE", "D2_LOJA", "D2_FORMUL", "D2_TIPO"}, "1" )

Method produto() class TSItemNFSaida
return ::belongsTo("TSProduto", {"D2_COD"}, "1")
