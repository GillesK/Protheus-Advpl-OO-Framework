#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSPedidoCompraบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Pedido de Compra Header          	    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Elfa								                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSPedidoCompra
Classe representando um pedido de compra (SC7).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSPedidoCompra From TSigaMDBas
	method New() Constructor
	method iniCampos()
	method execAuto()
	method itens()
	method fornecedor()
	method simulMod()
EndClass


Method New( ) Class TSPedidoCompra 
	_Super:New()
	::tabela 	  := 		"SC7"	
	::entidade	  :=	"Pedido de Compra"
	::funcao	  := "Pedido de Compra"		
	::isExecAuto   := .T.
return (Self)


Method iniCampos() class TSPedidoCompra
	local cpoDef
	// Nome externo, nome interno, tipo, AutoInc	, campo filial
	cpoDef := {{"filial"					,"C7_FILIAL"		, "C"};
				,{"numero"					,"C7_NUM"			, "C"};
				,{"fornecedor"			,"C7_FORNECE"		, "C"};
				,{"loja"					,"C7_LOJA"			, "C"};
				,{"dataEmissao"			,"C7_EMISSAO"		, "D"};
				,{"condicaoPagamento"	,"C7_COND"			, "C"};
				,{"filialEntrega"			,"C7_FILENT"		, "C"};
				,{"contato"				,"C7_CONTATO"		, "C"}}

//				,{"item"					,"C7_ITEM", "C"};
	//			,{"sequencia"				,"C7_SEQUEN", "C"};
	
	::addCpoDef(cpoDef)	
	::addCpoInc("C7_NUM")

	::setChave({{"1",{"C7_FILIAL", "C7_NUM"}}})
	
//	::setEAChave({"C5_NUM"})
return


Method itens() class TSPedidoCompra
return ::hasMany("TSItemPedidoCompra", "1", {"C7_NUM"})

method fornecedor()  class TSPedidoCompra
return ::belongsTo("TSFornecedor", {"C7_FORNECE","C7_LOJA"}, "1")


method execAuto(opcao) class TSPedidoCompra
	//::getEAVector()
	//private lMsErroAuto := .F.
	local aCabec := self:getEAVector()
	local aItens := self:itens():getEAVector() 

	//Mata410(aCabec, aItens, opcao)
	MSExecAuto({|v,x,y,z| MATA120(v,x,y,z)},1,aCabec, aItens, opcao)	
//	MSExecAuto({|X, Y, Z| Mata120(X,Y, Z)}, aCabec, aItens, opcao)
	
return lMsErroAuto 


method simulMod() class TSPedidoCompra
	self:setar("condicaoPagamento" 	, self:valor("condicaoPagamento"))
	self:setar("filialEntrega"		, self:valor("filialEntrega"))
	self:setar("contato"				, self:valor("contato"))
//	oPedVen:setar("condicaoPagamento" 		, oPedVen:valor("condicaoPagamento"))	
return