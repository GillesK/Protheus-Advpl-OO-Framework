// MATA110
#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSItemSolicitacaoCompraบ Autor ณ gilles koffmann บ Data  ณ 30/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br              บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Item Solicita็ใo de Compras 		    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSItemSolicitacaoCompra
Classe representando um item de solicita็ใo de compra (SC1).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSItemSolicitacaoCompra From TSigaMDBas
	method New() Constructor
	method iniCampos()

	method produto()
//	method execAuto()
//	method itens()
//	method cliente()
EndClass


Method New( ) Class TSItemSolicitacaoCompra 
	_Super:New()
	::tabela 	  := 		"SC1"	
	::entidade			:=	"Item de Solicita็ใo de Compra"
	::funcao			:= "Item de Solicita็ใo de Compra"		
return (Self)


Method iniCampos() class TSItemSolicitacaoCompra
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial"							, "C1_FILIAL"		, "C"};
				,{"numero"							, "C1_NUM"			, "C"};
				,{"item"							, "C1_ITEM"		, "C"};
				,{"produto"						, "C1_PRODUTO"	, "C"};
				,{"descricaoProduto"				, "C1_DESCRI"		, "C"};
				,{"quantidade"					, "C1_QUANT"		, "N"};
				,{"armazem"						, "C1_LOCAL"		, "C"};
				,{"unidadeMedida"					, "C1_UM"			, "C"};				
				,{"dataPrevisionalNecessidade"	, "C1_DATPRF"		, "D"};
				,{"observacao"					, "C1_OBS"			, "C"};
				,{"flagAprovacao"					, "C1_APROV"		, "C"};
				,{"centroCusto"					, "C1_CC"			, "C"};
				,{"fornecedor"					, "C1_FORNECE"	, "C"};
				,{"lojaFornecedor"				, "C1_LOJA"		, "C"};
				,{"recordNumber"					, "C1_REC_WT"		, "N"};
				,{"AUTDELETA"						,"AUTDELETA"		, "C"}}
				
	::addCpoDef(cpoDef)	

	::setChave({{"1",{"C1_FILIAL", "C1_NUM", "C1_ITEM"}}})
				
//	::setEAChave({"C1_FILIAL", "C1_NUM", "C1_ITEM", "C1_PRODUTO", "C1_QUANT"})			
return




method produto() class  TSItemSolicitacaoCompra
return ::belongsTo("TSProduto", {"C1_PRODUTO"}, "1")

/*Method itens() class TSPedidoVenda
return ::hasMany("TSItemPedidoVenda", 1, {"C5_NUM"})

method cliente()  class TSPedidoVenda
return ::belongsTo("TSCliente", {"C5_CLIENTE","C5_LOJACLI"}, 1)*/

/*method execAuto(opcao) class TSSolicitacaoCompra
	//::getEAVector()
		MSExecAuto({|X, Y, Z| Mata110(X,Y, Z)}, aFatura[1][nCnt][1],aFatura[1][nCnt][2], 3)
return*/ 