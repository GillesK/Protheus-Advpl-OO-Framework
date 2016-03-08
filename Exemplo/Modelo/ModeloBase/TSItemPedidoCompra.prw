#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSItemPedidoCompraบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Item dePedido de Compra   			    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Elfa								                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSItemPedidoCompra
Classe representando um item pedido de compra (SC7).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSItemPedidoCompra From TSigaMDBas
	method New() Constructor
	method iniCampos()
//	method execAuto()
//	method tes()
	method pedido()
	method produto()
	method itemSc()
	method isEmpenho()
//	method solicitacaoCompra()
	method simulMod()	
	method initDel()
EndClass


Method New( ) Class TSItemPedidoCompra 
	_Super:New()
	::tabela 	  := 		"SC7"	
	::entidade			:=	"Item de Pedido de Compra"
	::funcao			:= "Item de Pedido de Compra"		
	
return (Self)


Method iniCampos() class TSItemPedidoCompra
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial"							,"C7_FILIAL"	, "C"};
				,{"numero"							,"C7_NUM"		, "C"};
				,{"item"							,"C7_ITEM"		, "C"};
				,{"produto"						,"C7_PRODUTO"	, "C"};
				,{"descricaoProduto"				,"C7_DESCRI"	, "C"};				
				,{"sequencia"						,"C7_SEQUEN"	, "C"};
				,{"numeroSC"						,"C7_NUMSC"	, "C"};
				,{"itemSC"							,"C7_ITEMSC"	, "C"};
				,{"quantidade"					,"C7_QUANT"	, "N"};
				,{"unidadeMedida"					,"C7_UM"		, "C"};				
				,{"dataEntrega"					,"C7_DATPRF"	, "D"};
				,{"preco"							,"C7_PRECO"	, "N"};
				,{"total"							,"C7_TOTAL"	, "N"};
				,{"tes"							,"C7_TES"		, "C"};
				,{"recordNumber"					,"C7_REC_WT"	, "N"};
				,{"AUTDELETA"						,"AUTDELETA"	, "C"};
				,{"tipoOperacao"					,"C7_OPER"		, "C"};
				,{"dataPrevistaFaturamento"		,"C7_XDTFAT"	, "D"};
				,{"reposicaoLicitacao"			,"C7_XLICREP"	, "C"};
				,{"centroCusto"					,"C7_CC"		, "C"};
				,{"desconto"						,"C7_DESC"		, "N"};
				,{"repasse"						,"C7_XDESIT2"	, "N"};
				,{"tipoItem"						,"C7_XPRDEMP"	, "C"}}

				//,{"fornecedor"			,"C7_FORNECE", "C"};
				//,{"loja"					,"C7_LOJA", "C"};
				
	::addCpoDef(cpoDef)	

	::setChave({{"1",{"C7_FILIAL", "C7_NUM", "C7_ITEM", "C7_SEQUEN"}}})			
return

//Method tes() class TSItemPedidoVenda
//return ::belongsTo("TSTes", {"C6_TES"}, "1")
//method solicitacaoCompra()  class TSItemPedidoCompra
//return ::belongsTo("TSSolicitacaoCompra", {"C7_NUMSC"}, "1" )

method itemSc()  class TSItemPedidoCompra
return ::belongsTo("TSItemSolicitacaoCompra", {"C7_NUMSC", "C7_ITEMSC"}, "1" )

method isEmpenho() class TSItemPedidoCompra
	lRet := .F.
	if !Empty(self:itemSc():obter():valor("codigoEmpenhoLicitacao"))
		lRet := .T.
	endif
return lRet


Method pedido() class TSItemPedidoCompra
return ::belongsTo("TSPedidoCompra", {"C7_NUM"}, "1" )

Method produto() class TSItemPedidoCompra
return ::belongsTo("TSProduto", {"C7_PRODUTO"}, "1")


method simulMod() class TSItemPedidoCompra
	self:setar("produto"					, self:valor("produto"))
	self:setar("quantidade"				, self:valor("quantidade"))
	self:setar("preco"					, self:valor("preco"))
	self:setar("AUTDELETA"				, "N")			
	self:setar("recordNumber"			, self:recNumber)
return

method initDel()  class TSItemPedidoCompra
	self:setar("AUTDELETA", "S")
	self:setar("recordNumber", self:recNumber)
return
