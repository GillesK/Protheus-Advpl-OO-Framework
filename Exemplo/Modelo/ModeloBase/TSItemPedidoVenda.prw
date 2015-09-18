#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSPedidoVendaItemบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Item dePedido de Venda   			    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSItemPedidoVenda
Classe representando um pedido de venda (SC5).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSItemPedidoVenda From TSigaMDBas
	method New() Constructor
	method iniCampos()
//	method execAuto()
	method tes()
	method pedido()
	method produto()
EndClass


Method New( ) Class TSItemPedidoVenda 
	_Super:New()
	::tabela 	  := 		"SC6"	
	::entidade			:=	"Item de Pedido de Venda"
	::funcao			:= "Item de Pedido de Venda"		
	
return (Self)


Method iniCampos() class TSItemPedidoVenda 
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial", "C6_FILIAL", "C"};
				,{"numeroPedido", "C6_NUM", "C"};
				,{"item", "C6_ITEM", "C"};
				,{"tes", "C6_TES", "C"};
				,{"produto", "C6_PRODUTO", "C"};
				,{"quantidadeEmpenhada", "C6_QTDEMP", "N"};
				,{"valorTotal", "C6_VALOR", "N"};
				,{"quantidadeVendida", "C6_QTDVEN", "N"};
				,{"precoLista", "C6_PRUNIT", "N"};
				,{"precoUnitario", "C6_PRCVEN", "N"};
				,{"valorDesconto", "C6_VALDESC", "N"}}
				

	::addCpoDef(cpoDef)	

	::setChave({{1,{"C6_FILIAL", "C6_NUM", "C6_ITEM"}}})			
return

Method tes() class TSItemPedidoVenda
return ::belongsTo("TSTes", {"C6_TES"}, 1)


Method pedido() class TSItemPedidoVenda
return ::belongsTo("TSPedidoVenda", {"C6_NUM"}, 1 )

Method produto() class TSItemPedidoVenda
return ::belongsTo("TSProduto", {"C6_PRODUTO"}, 1)