#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � SIGEXMOD� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Exemplo de uso das classe de modelo TSigaMDBas, TSTransObj  ���
���          � TSColecao                                                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


user function SIGEXMOD()
	local oGrpProd, oGrpProd2, oGroProd3, oGrpProd4, oGrpProd5, oGrpProd6
	local salvaDesc, codExis, codNovo, colProdutos
	local aRet
	local cMsg := ""
	local cAliasTRB := GetNextAlias()
	local colObj, oIterat, oIterat2, oPrd, oItm
	local colTest, oObjB, oObjA, oIterat3, oItm2, objF	
	
	// Codigo de um grupo de produto (SBM) existente na sua base referenciado por alguns produtos (B1_GRUPO)
	codExis := "1100"
	// Codigo de um grupo de produto que n�o deve existir na sua base para fazer um teste de inser��o
	codNovo := "XXXV"

	// Cirar novo grupo de produto
	// A defini��o de TSGrupoProduto esta na pasta ModeloBase
	oGrpProd3 := TSGrupoProduto():New()

	// Para modificar o valor de 1 campo, podemos usar o nome em portugues que foi definido 
	// na classe TSGrupoProduto ou a nome do campo tecnico no caso do codigo BM_GRUPO, 
	oGrpProd3:setar("codigo"	, codNovo)
	oGrpProd3:setar("descricao"	, "TEST INSERCAO GRUPO")

	// O retorno do m�todo salvar() � um array da forma {lRet, msgErro} onde lRet = .T. quando foi salvado
	// com sucesso ou .F. quando teve erro acompanhado da raz�o do erro dentro de msgErro
	// Isto � util no caso de um objeto salvado por ExecAuto.
	// Quando o m�todo de atualiza��o � via ExecAuto (Confere TSPedidoVenda), temos tambem a possibilidade 
	// de recuperar o codigo que foi gerado automaticamente passando por referencia a variavel obj:salvar(@num)
	aRet := oGrpProd3:salvar()
	if !aRet[1]
		MsgAlert(aRet[2])
		return
	endif
	
	// Encontrar o grupo que foi criado para comprovar que esta na base
	oGrpProd := TSGrupoProduto():New()	
	
	// Por default o metodo find usa a filial corrente e o indexo 1
	if oGrpProd:find(codNovo) == nil
		MsgAlert("Grupo de produto n�o encontrado")
		return
	else
		MsgInfo("Grupo " + codNovo + " encontrado na base. A descri��o dele � " + oGrpProd:valor("descricao"))
	endif
	
	// Atualizar descri��o grupo de produto
	salvaDesc := oGrpProd:valor("descricao")
	oGrpProd:setar("descricao", "TESTE MODIFICACAO GRUPO")
	oGrpProd:salvar()
		
	// Comprovar que o grupo foi modificado na base
	oGrpProd2 := TSGrupoProduto():New()
	oGrpProd2:find(codNovo) 
	MsgInfo("A descri��o do grupo " + codNovo + " � " + oGrpProd:valor("descricao"))		
		
	// Retornar para a descri��o inicial
	oGrpProd2:setar("descricao", salvaDesc )
	oGrpProd2:salvar()	
	
	// navegar para produtos
	oGrpProd4 := TSGrupoProduto():New()
	oGrpProd4:find(codExis)
	
	// Em 1 linha de c�digo nos obtemos todos os produtos associados ao grupo de produto
	// dentro de uma cole��o TSColecao
	colProdutos := oGrpProd4:produtos():obter()
	
	// o iterator permite percorrer a cole��o
	oIterat := colProdutos:getIterator()
	oPrd := oIterat:first()
	while !oIterat:eoc()
		cMsg += " " + oPrd:valor("codigo")
		// proximo
		oPrd := oIterat:seguinte()
	enddo
	// Mostrar os Produtos
	MsgInfo("Os Produtos do grupo " + codExis + " s�o " + cMsg)

	// Deletar o grupo 
	oGrpProd2:deletar()
	
	// comprovar quie foi deletado
	oGrpProd6 := TSGrupoProduto():New()
	if oGrpProd6:find(codNovo) == nil 
		MsgInfo("o grupo " + codNovo + " foi deletado com sucesso")
	endif
	
	// Hydrate
	// A outra maneira de pre-encher o modelo que n�o seja atraves do
	// find() que vai procurar na base ou atraves da valoriza��o campo a campo
	// a traves do m�todo setar() e a hydrata��o. Podemos pre-encher o modelo
	// com variaveis de memoria (M->) hydrateM(), atraves da posi��o atual 
	// da tabela hydratePos(), atraves do resultado de uma query hydrateAlias()
	// e hydAllAlias(), e atraves do conteudo de um aCols do objeto MsNewGetDados
	// hydrateACols() e hydAColsPos() 
	//method hydrateM()
	//method hydrateACols()
	//method hydratePos()
	//method hydrateAlias()
	//method hydAllAlias()
	//method hydAColsPos()
	
	DbSelectArea("SBM")
	SBM->(DbSeek(xFilial("SBM")+codExis))
	oGrpProd5 := TSGrupoProduto():New()
	oGrpProd5:hydratePos()
	
	MsgInfo("Grupo " + oGrpProd5:valor("codigo") + " hydratado. A descri��o dele � " + oGrpProd5:valor("descricao"))

	// TSTransObj
	// Este objeto se comporta como um objeto de modelo TSigaMdBas so que muito mais flexivel
	// pois ele n�o representa uma tabela em particular. Ele � util para 
	// obter uma interface unificada e limpa dentro do projeto.
	// Tipicamente ele � usado quando temos uma query complexa (com joins) 
	// cujo resultado devemos passar para outra fun��o. Em vez de passsar a query
	// em se, colocamos o resultado dela dentro de uma cole��o de TSTransObj.
	// Pode se criar tambem manualmente ou a partir de 1 aCols e 1 aHeader (hydrateACols)
	// N�o se pode salvar um TSTransObj na base.
	 
	oTrans := TSTransObj():New()
	
	// query deve ser adapatada em fun��o do compartilhamento das tabelas
	beginSQL Alias cAliasTRB 
		SELECT BM_FILIAL filial, BM_GRUPO codGrupo, B1_COD codProduto 
		FROM %table:SBM% SBM
		INNER JOIN %table:SB1% SB1 ON B1_GRUPO = BM_GRUPO
									AND SB1.%NotDel% 
		WHERE 
			BM_FILIAL = %xFilial:SBM%
			AND BM_GRUPO = %exp:codExis%
			AND SBM.%NotDel%
	EndSQL
	
	colObj := oTrans:hydAllAlias(cAliasTRB)

	oIterat2 := colObj:getIterator()
	oItm := oIterat2:first()
	cMsg := ""
	while !oIterat2:eoc()
		cMsg += " " + oItm:valor("codProduto")
		// proximo
		oItm := oIterat2:seguinte()
	enddo
	// Mostrar os Produtos
	MsgInfo("Os Produtos do grupo " + codExis + " s�o " + cMsg)
	
	// ACols / AHeader
	// podemos gerar o aHeader a partir do objeto TSTransObj (utilidade)
	oTrans := TSTransObj():New()
	aHeader := oTrans:getAHeader(, {"B1_COD", "BM_GRUPO"},.F.)
	
	// Dentro da classe TSColecao temos metodos de manipula��o
	colTest := TSColecao():New()
	oObjB := TSTransObj():New()
	oObjB:setar("COLA", "2")
	oObjB:setar("COLB", "1")
	colTest:add(oObjB)
	oObjA := TSTransObj():New()
	oObjA:setar("COLA", "1")
	oObjA:setar("COLB", "1")
	colTest:add(oObjA)

	// findA procurar um objeto
	objF := colTest:findA({"COLA", "COLB"}, {"1","1"})
	// display
	MsgInfo("O Objeto encontrado � " + objF:toString())
	
	// sortA: organizar
	colTest:sortA({"COLA", "COLB"})
	// display
	oIterat3 := colTest:getIterator()
	oItm2 := oIterat3:first()
	cMsg := "A ordem da cole��o � "
	while !oIterat3:eoc()
		cMsg += " " + oItm2:toString()
		// proximo
		oItm2 := oIterat3:seguinte()
	enddo
	MsgInfo(cMsg)
return

