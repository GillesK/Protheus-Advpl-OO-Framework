#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSNFEntradaบ Autor ณ gilles koffmann บ Data  ณ  16/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe da Nota Fioscal de Entrada          	    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Elfa								                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSNFEntrada
Classe representando uma nota fiscal de entrada (SF1).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSNFEntrada From TSigaMDBas
	method New() Constructor
	method iniCampos()
//	method execAuto()
	method itens()
	method fornecedor()
EndClass


Method New( ) Class TSNFEntrada 
	_Super:New()
	::tabela 	  := 		"SF1"	
	::entidade	  :=	"Nota Fiscal de Entrada"
	::funcao	  := 	"Nota Fiscal de Entrada"		
//	::isExecAuto   := .T.
return (Self)


Method iniCampos() class TSNFEntrada
	local cpoDef
	// Nome externo, nome interno, tipo, AutoInc	, campo filial
	cpoDef := {{"filial"					,"F1_FILIAL"		, "C"};
				,{"numero"					,"F1_DOC"			, "C"};
				,{"serie"					,"F1_SERIE"		, "C"};
				,{"fornecedor"			,"F1_FORNECE"		, "C"};
				,{"lojaFornecedor"		,"F1_LOJA"			, "C"};
				,{"tipo"					,"F1_TIPO"			, "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{"1",{"F1_FILIAL", "F1_DOC", "F1_SERIE", "F1_FORNECE", "F1_LOJA", "F1_TIPO"}}})
	
//	::setEAChave({"C5_NUM"})
return


Method itens() class TSNFEntrada
return ::hasMany("TSItemNFEntrada", "1", {"F1_DOC", "F1_SERIE", "F1_FORNECE", "F1_LOJA"})

method fornecedor()  class TSNFEntrada
return ::belongsTo("TSFornecedor", {"F1_FORNECE", "F1_LOJA"}, "1")

// mata103