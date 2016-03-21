#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TTestSigaMDBasº Autor ³ gilles koffmann º Data  ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de  Test unitario da Classe de base Modelo    		    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework copyright Sigaware Pb                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


Class TTestSigaMDBas from TSigaUTest 
	method New() Constructor
	method exec()	
EndClass


Method New(oFactory) Class TTestSigaMDBas
	_Super:New(oFactory)
	::nome := "Test das funcões da classe TSigaMDBas"
return (Self)


method exec() class TTestSigaMDBas
	local xReturn
	local xProd, xPreProd
	local codNovo, codExis
	local oGrpProd, oGrpProd2, oGrpProd3, oGrpProd4, oGrpProd5
	local colProdutos, oProd, oColProd, oProd2, oGp

	codNovo := "0202"
	codExis := '0200'
	
	oGrpProd := TSGrupoProduto():New()	
	// Grupo de Produto find
	xReturn := oGrpProd:find(codExis)
	::dados := "Acessar grupo de produto " + codExis
	//Self:assert(xReturn, .T.)
	Self:assert(Alltrim(xReturn:valor('descricao')), "BENS DE CONSUMO")
	
	// Grupo de produto setar
	oGrpProd:setar("descricao", "BENS DE CONSUMO MODIF 2")
	Self:assert(Alltrim(oGrpProd:valor('descricao')), "BENS DE CONSUMO MODIF")
	
	// Grupo de produto salvar atualizacao
	oGrpProd:salvar()
	oGrpProd2 := TSGrupoProduto():New()
	xReturn := oGrpProd2:find(codExis) 
	//Self:assert(xReturn[1], .T.)
	Self:assert(Alltrim(xReturn:valor('descricao')), "BENS DE CONSUMO MODIF")
	
	// Colocar para descricao anterior
	//TODO
	
	// Grupo de produto salvar inserção
	oGrpProd3 := TSGrupoProduto():New()
//	oGrpProd3:setar("filial", oGrpProd3:filial())
	oGrpProd3:setar("codigo", codNovo)
	oGrpProd3:setar("descricao", "TEST INSERCAO GRUPO")
	oGrpProd3:salvar()
	oGrpProd4 := TSGrupoProduto():New()
	xReturn := oGrpProd4:find(codNovo) 
	//Self:assert(xReturn[1], .T.)
	Self:assert(Alltrim(xReturn:valor('codigo')), codNovo)
			
	// Grupo de produto deletar
	oGrpProd4:deletar()
	oGrpProd5 := TSGrupoProduto():New()
	xReturn := oGrpProd5:find(codNovo) 
	Self:assert(xReturn, nil)
	//Self:assert(Alltrim(xReturn[2]:valor('codigo')), "0202")	
	
	// navegar para produto //38
	colProdutos := oGrpProd:produtos():obter()
	Self:assert(colProduto:length(), 38)
	
	// Produto -> Findall by grupo de produto
	oProd := TSProduto():New()
	oColProd := oProd:findAll( codExis, 4)
	Self:assert(oColProd:length(), 38)
		 
	// navegar de produto para grupo de produto
	oProd2 := TSProduto():New()
	oProd2:find('IN.PR.0006')
	oGp := oProd2:grupoProduto():obter()
	Self:assert(Alltrim(oGp:valor('descricao')), "BENS DE CONSUMO MODIF")
	
	// Exec aAuto pedido de venda
	
	// Hydrate
	
	// ACols / AHeader
	
	// compara / sort
		
return