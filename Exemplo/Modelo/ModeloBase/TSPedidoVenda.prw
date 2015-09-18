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
ฑฑบDescricao ณ Classe de Pedido de Venda Header          					    		    บฑฑ
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
EndClass


Method New( ) Class TSPedidoVenda 
	_Super:New()
	::tabela 	  := 		"SC5"	
	::entidade			:=	"Pedido de Venda"
	::funcao			:= "Pedido de Venda"		
	
return (Self)


Method iniCampos() class TSPedidoVenda
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial", "C5_FILIAL", "C"};
				,{"numero", "C5_NUM", "C"};
				,{"mensagemNota", "C5_MENNOTA", "C"};
				,{"cliente", "C5_CLIENTE", "C"};
				,{"lojaCliente", "C5_LOJACLI", "C"};
				,{"tipo", "C5_TIPO", "C"};
				,{"tipoCliente", "C5_TIPOCLI", "C"};
				,{"acrescimoFinanceiro", "C5_ACRSFIN", "N"}}

	::addCpoDef(cpoDef)	

	::setChave({{1,{"C5_FILIAL", "C5_NUM"}}})			
return


Method itens() class TSPedidoVenda
return ::hasMany("TSItemPedidoVenda", 1,  {"C5_NUM"})

method cliente()  class TSPedidoVenda
return ::belongsTo("TSCliente", {"C5_CLIENTE","C5_LOJACLI"}, 1)

 