#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSProduto บ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Produto          					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/


Class TSProduto From TSigaMDBas

//	Data origemCol
//	Data grupoTributarioCol

//	data origem
//	data grupoTributario

	method New() Constructor
//	method getOrigem()
//	method getGrupoTributario()
//	method getInfo()		
	Method iniCampos() 	
	method execute()
EndClass


Method New( ) Class TSProduto 
	_Super:New()
	::tabela 	  		:= 			"SB1"
	::entidade			:=			"Produto"
	::funcao			:=		"Cadastro de produto"	
// 	::origemCol := 			"B1_ORIGEM"
//	::grupoTributarioCol := 	"B1_GRTRIB"
	//::chave := 				{'B1_FILIAL','B1_COD'}
	::execAuto := 			.T.
	
return (Self)


/*Method getInfo() class TSProduto
	local tabela := 	::tabela
	::origem := &(tabela)->(&(Self:origemCol))
	::grupoTributario := &(tabela)->(&(Self:grupoTributarioCol))
return*/ 

method execute(aVetor, opcao) class TSProduto
	// TODO
	MSExecAuto({|x,y| Mata010(x,y)},::aVetor, opcao)	
return 


/*BEGINDOC
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFS26953-2015 get Uf do Cliente                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ENDDOC*/
// ZL3_CLIENT, ZL3_LOJA
/*Method getOrigem() class TSProduto
	
return ::origem

Method getGrupoTributario() class TSProduto
	
return ::grupoTributario*/

Method iniCampos() class TSProduto
	// Nome externo, nome interno, tipo,  valor, mudaddo, chave 
	aadd(::campos, {"filial", "B1_FILIAL", "C",nil,.F.,.T.})
	aadd(::campos, {"codigo", "B1_COD", "C",nil,.F.,.T.})
	aadd(::campos, {"origem", "B1_ORIGEM", "C",nil,.F.,.F.})
	aadd(::campos, {"grupoTributario", "B1_GRTRIB", "C",nil,.F.,.F.})				
return

