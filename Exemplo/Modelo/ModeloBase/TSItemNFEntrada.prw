#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSItemNFEntradaบ Autor ณ gilles koffmann บ Data  ณ  16/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Item de Nota Fiscal de entrada		    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSItemNFEntrada
Classe representando um item de NF de entrada (SD1).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSItemNFEntrada From TSigaMDBas
	method New() Constructor
	method iniCampos()
//	method execAuto()
//	method tes()
	method nf()
	method produto()
	method itemPedidoCompra()
	method pedidoCompra()
EndClass


Method New( ) Class TSItemNFEntrada
	_Super:New()
	::tabela 	  := 		"SD1"	
	::entidade			:=	"Item de NF de entrada"
	::funcao			:= "Item de NF de entrada"		
	
return (Self)


Method iniCampos() class TSItemNFEntrada 
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial"						, "D1_FILIAL"		, "C"};
				,{"item"						, "D1_ITEM"		, "C"};
				,{"produto"					, "D1_COD"			, "C"};
				,{"numeroNf"					, "D1_DOC"			, "C"};
				,{"serie"						, "D1_SERIE"		, "C"};
				,{"fornecedor"				, "D1_FORNECE"	, "C"};
				,{"lojaFornecedor"			, "D1_LOJA"		, "C"};
				,{"pedidoCompra"				, "D1_PEDIDO"		, "C"};
				,{"itemPedidoCompra"			, "D1_ITEMPC"		, "C"};
				,{"sequenciaPedidoCompra"	, "D1_NUMSEQ"		, "C"};
				,{"unidadeMedida"				, "D1_UM"			, "C"};
				,{"quantidade"				, "D1_QUANT"		, "N"};
				,{"armazem"					, "D1_LOCAL"		, "C"};
				,{"tipoDocumento"				, "D1_TIPO"		, "C"};
				,{"lote"						, "D1_LOTECTL"	, "C"};
				,{"dataValidade"				, "D1_DTVALID"	, "D"}}

	::addCpoDef(cpoDef)	

	::setChave({{"1",{"D1_FILIAL", "D1_DOC", "D1_SERIE","D1_FORNECE", "D1_LOJA", "D1_COD", "D1_ITEM"}}})			
return

method pedidoCompra() class TSItemNFEntrada
return ::belongsTo("TSPedidoCompra", { "D1_PEDIDO"}, "1" )

method itemPedidoCompra()  class TSItemNFEntrada
return ::belongsTo("TSItemPedidoCompra", { "D1_PEDIDO", "D1_ITEMPC", "D1_NUMSEQ"}, "1" )

Method nf() class TSItemNFEntrada
return ::belongsTo("TSNFEntrada", {"D1_DOC", "D1_SERIE","D1_FORNECE", "D1_LOJA"}, "1" )

Method produto() class TSItemNFEntrada
return ::belongsTo("TSProduto", {"D1_COD"}, "1")
