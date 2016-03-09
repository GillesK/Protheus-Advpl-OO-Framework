#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSPedidoVendaบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Pedido de Venda Header          	    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSPedidoVenda
Classe representando um pedido de venda (SC5).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSPedidoVenda From TSigaMDBas
	method New() Constructor
	method iniCampos()
	method execAuto()
	method itens()
	method cliente()
	method simulMod()
EndClass


Method New( ) Class TSPedidoVenda 
	_Super:New()
	::tabela 	  := 		"SC5"	
	::entidade	  :=	"Pedido de Venda"
	::funcao	  := "Pedido de Venda"		
	::isExecAuto   := .T.
return (Self)


Method iniCampos() class TSPedidoVenda
	local cpoDef
	// Nome externo, nome interno, tipo, AutoInc	, campo filial
	cpoDef := {{"filial"						,"C5_FILIAL"		, "C"};
				,{"numero"						,"C5_NUM"			, "C"};
				,{"mensagemNota"				,"C5_MENNOTA"		, "C"};
				,{"cliente"					,"C5_CLIENTE"		, "C"};
				,{"lojaCliente"				,"C5_LOJACLI"		, "C"};
				,{"clienteEntrega"			,"C5_CLIENT"		, "C"};
				,{"lojaClienteEntrega"		,"C5_LOJAENT"		, "C"};				
				,{"tipo"						,"C5_TIPO"			, "C"};
				,{"tipoCliente"				,"C5_TIPOCLI"		, "C"};
				,{"acrescimoFinanceiro"		,"C5_ACRSFIN"		, "N"};
				,{"dataEmissao"				,"C5_EMISSAO"		, "D"};
				,{"moeda"						,"C5_MOEDA"		, "N"};
				,{"condicaoPagamento"		,"C5_CONDPAG"		, "C"};
				,{"tabelaPreco"				,"C5_TABELA"		, "C"};
				,{"setor"						,"C5_SETOR"		, "C"};
				,{"codigoVendedor1"			,"C5_VEND1"		, "C"};
				,{"tipoLiberacao"				,"C5_TIPLIB"		, "C"};
				,{"pedidoLiberadoTotal"		,"C5_LIBEROK"		, "C"};
				,{"codigoTransportadora"		,"C5_TRANSP"		, "C"};
				,{"idUsuario"					,"C5_IDUSU"		, "C"};
				,{"notaFiscal"				,"C5_NOTA"			, "C"};
				,{"bloqueioRegra"				,"C5_BLQ"			, "C"}}


	::addCpoDef(cpoDef)	
	::addCpoInc("C5_NUM")

	::setChave({{"1",{"C5_FILIAL", "C5_NUM"}}})
	
//	::setEAChave({"C5_NUM"})
return


Method itens() class TSPedidoVenda
return ::hasMany("TSItemPedidoVenda", "1", {"C5_NUM"})

method cliente()  class TSPedidoVenda
return ::belongsTo("TSCliente", {"C5_CLIENTE","C5_LOJACLI"}, "1")

method execAuto(opcao) class TSPedidoVenda
	//::getEAVector()
	//private lMsErroAuto := .F.
	local nPos, i		
	local aCabec := self:getEAVector(opcao)
	local aItens := self:itens():getEAVector(opcao)
/*	if Len(aItens) == 0
		aItens := nil
	endif*/

/*	if opcao == 4 //atualiza็ใo
		for i := 1 to Len(aItens)
			nPos := aScan(aItens[i], {|x| allTrim(x[1]) == "C6_ITEM"})
			aItens[i][nPos][3] := aItens[i][nPos][2]
			aItens[i][nPos][2] := "C6_ITEM"
			aItens[i][nPos][1] := "LINPOS"
		next
	endif*/
	
	//Mata410(aCabec, aItens, opcao)
	MSExecAuto({|X, Y, Z| Mata410(X,Y, Z)}, aCabec, aItens, opcao)
	
return lMsErroAuto


method simulMod() class TSPedidoVenda
	self:setar("tipo" 						, self:valor("tipo"))
	self:setar("cliente" 					, self:valor("cliente"))
	self:setar("lojaCliente" 				, self:valor("lojaCliente"))
	self:setar("lojaClienteEntrega" 		, self:valor("lojaClienteEntrega"))
//	oPedVen:setar("condicaoPagamento" 		, oPedVen:valor("condicaoPagamento"))	
return