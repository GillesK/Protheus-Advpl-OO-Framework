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
ฑฑบUso       ณ Elfa								                            บฑฑ
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
	method itemEmpenho()
	method simulMod()
	method getEAItem()
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
	cpoDef := {{"filial"						, "C6_FILIAL"		, "C"};
				,{"numeroPedido"				, "C6_NUM"			, "C"};
				,{"item"						, "C6_ITEM"		, "C"};
				,{"tes"						, "C6_TES"			, "C"};
				,{"produto"					, "C6_PRODUTO"	, "C"};
				,{"descricaoProduto"			, "C6_DESCRI"		, "C"};				
				,{"quantidadeEmpenhada"		, "C6_QTDEMP"		, "N"};
				,{"unidadeMedida"				, "C6_UM"			, "C"};				
				,{"valorTotal"				, "C6_VALOR"		, "N"};
				,{"quantidadeVendida"		, "C6_QTDVEN"		, "N"};
				,{"quantidadeLiberada"		, "C6_QTDLIB"		, "N"};
				,{"quantidadeLiberadaRep"	, "C6_XQTDLIB"	, "N"};								
				,{"precoLista"				, "C6_PRUNIT"		, "N"};
				,{"precoUnitario"				, "C6_PRCVEN"		, "N"};
				,{"valorDesconto"				, "C6_VALDESC"	, "N"};
				,{"armazem"					, "C6_LOCAL"		, "C"};				
				,{"codigoFiscal"				, "C6_CF"			, "C"};
				,{"dataEntrega"				, "C6_ENTREG"		, "D"};
				,{"codigoEmpenhoLicitacao"	, "C6_XCDEMP"		, "C"};
				,{"tipoOperacao"				, "C6_OPER"		, "C"};
				,{"numeroSolicitacaoCompra"	, "C6_XNUMSC"		, "C"};
				,{"itemSolicitacaoCompra"	, "C6_XITEMSC"	, "C"};
				,{"numeroNFEntrada"			, "C6_XNUMNFE"	, "C"};				
				,{"cliente"					, "C6_CLI"			, "C"};				
				,{"lojaCliente"				, "C6_LOJA"		, "C"};
				,{"lote"						, "C6_LOTECTL"	, "C"};
				,{"dataValidade"				, "C6_DTVALID"	, "D"};
				,{"AUTDELETA"					, "AUTDELETA"		, "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{"1",{"C6_FILIAL", "C6_NUM", "C6_ITEM"}}})			
return

Method tes() class TSItemPedidoVenda
return ::belongsTo("TSTes", {"C6_TES"}, "1")

Method pedido() class TSItemPedidoVenda
return ::belongsTo("TSPedidoVenda", {"C6_NUM"}, "1" )

Method produto() class TSItemPedidoVenda
return ::belongsTo("TSProduto", {"C6_PRODUTO"}, "1")

Method itemEmpenho() class TSItemPedidoVenda
return ::belongsTo("TELicItemEmpenho", {"C6_XCDEMP"}, "1" )

method simulMod() class TSItemPedidoVenda
	self:setar("produto" 					, self:valor("produto"))
	self:setar("quantidadeVendida" 			, self:valor("quantidadeVendida"))
	self:setar("quantidadeLiberada" 		, self:valor("quantidadeLiberada"))
	self:setar("precoUnitario" 				, self:valor("precoUnitario"))
	self:setar("precoLista" 					, self:valor("precoLista"))
	self:setar("valorTotal" 					, self:valor("valorTotal"))
	self:setar("tes" 							, self:valor("tes"))			

	self:setar("lote" 						, self:valor("lote"))
	self:setar("dataValidade" 				, self:valor("dataValidade"))
	self:setar("numeroSolicitacaoCompra" 	, self:valor("numeroSolicitacaoCompra"))
	self:setar("itemSolicitacaoCompra" 	, self:valor("itemSolicitacaoCompra"))		
	self:setar("numeroNFEntrada" 			, self:valor("numeroNFEntrada"))			
	self:setar("codigoEmpenhoLicitacao" 	, self:valor("codigoEmpenhoLicitacao"))			
return


method getEAItem(campo, opcao)  class TSItemPedidoVenda
	if opcao == 4 .And. !::isInsert() .And. campo[CPOTEC] == "C6_ITEM" //atualiza็ใo
		return {"LINPOS", "C6_ITEM", campo[VALOR]}
	else
		return _Super:getEAItem(campo,opcao)
	endif
return