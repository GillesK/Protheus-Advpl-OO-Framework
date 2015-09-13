#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSigaUTest� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Base Test unitario 					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSigaUTest
Classe base para defini��o de testes unitarios
@type class
@author Gilles Koffmann - Siagware Pb
@since 04/09/2015
@version 1.0
@example
A classe herdando de TSigaUTest (aqui TTestLicCalcCust) tera o seguinte formato <br>
 <br>
Method New(oFactory) Class TTestLicCalcCust <br>
	_Super:New(oFactory) <br>
	// defini��o do nome do test <br>
	::nome := "Test da funcao TELPropBL():calcCust()" <br>
return (Self) <br>
 <br>
// m�todo executando os testes <br>
method exec() class TTestLicCalcCust <br>
	local xReturn <br>
	local pTpCalc, pPf, pRpIcms, pValDesc, pValCap, pDesc87, pValDescCap, pValIcms <br>
	 <br>
	// cria��o do objeto a testar  <br>
	oLicPropBl := TELPropBL():New()  <br>
	 <br>
	pTpCalc := "2"  <br>
	pPf := 2  <br>
	pRpIcms := 3  <br>
	pValDesc := 4  <br>
	pValCap := 5  <br>
	pDesc87 := 6  <br>
	pValDescCap := 7  <br>
	pValIcms := 0  <br>
	 <br>
	// Explica��o do caso de teste  <br>	
	::dados := "Tipo calculo = 2, Valor de Icms = 0"  <br>
	// execu��o da fun��o a testar	 <br>
	xReturn := oLicPropBl:calcCust(pTpCalc, pPf, pRpIcms, pValDesc, pValCap, pDesc87, pValDescCap, pValIcms)  <br>
	// verifica��o do resultado e escritura na log  <br>
	Self:assert(xReturn, 1.6631232)  <br>
	 <br>
	// novo teste  <br>
	pTpCalc := "2"  <br>
	pPf := 2  <br>
	pRpIcms := 3  <br>
	pValDesc := 4  <br>
	pValCap := 5  <br>
	pDesc87 := 6  <br>
	pValDescCap := 7  <br>
	pValIcms := 7  <br>
	 <br>	
	::dados := "Tipo calculo = 2, Valor de Icms diferente de 0"  <br>	
	xReturn := oLicPropBl:calcCust(pTpCalc, pPf, pRpIcms, pValDesc, pValCap, pDesc87, pValDescCap, pValIcms)  <br>
	Self:assert(xReturn, 1.762910592)  <br>
	 <br>	
return
/*/
Class TSigaUTest 
	
	Data oFactory
	
/*/{Protheus.doc} nome
Nome do teste
@type property

/*/	
	Data nome

/*/{Protheus.doc} dados
Descri��o do teste
@type property

/*/		
	Data dados
	
	Data result
	
	method New() Constructor
	method assert()
	method exec()
		
EndClass


/*/{Protheus.doc} New
Constructor
@type method
@param oFactory, objeto, objeto de tipo TSUTFactor
@see TSUTFactor
/*/
Method New(oFactory) Class TSigaUTest
	::oFactory := oFactory
return (Self)

/*/{Protheus.doc} assert
M�todo que compara dois valores e escreve o resultado na log
@type method
@param resultado, mix, resultado do teste
@param esperado, mix, resultado esperado do teste
@return l�gico .T. se o resultado = esperado, .F. se resultado != esperado
/*/
method assert(resultado, esperado)  Class TSigaUTest
	local lRet := "OK"
	if resultado != esperado
		lRet := "KO
	endif	
	// Nome do test , Ok or KO e porque	
	::oFactory:oLog:write(::nome, ::dados , resultado, esperado, lRet)
return lRet



/*/{Protheus.doc} exec
M�todo de execu��o do teste. Abstrato. Deve ser definir na classe filha
@type method
/*/
method exec() class  TSigaUTest

return


method simulAHeader(tabela, aFields, aNoCampos)
	local  curTab, nPos
	private aHeader := {}

	// Define os campos de acordo com o array
	DbSelectArea("SX3")

	if aNoCampos != nil
		aFields := {}
		SX3->(DbSetOrder(1))
		SX3->(DbGoTop())
		If SX3->(DbSeek(tabela))
			curTab := SX3->X3_ARQUIVO
			while !SX3->(Eof()) .And. curTab == SX3->X3_ARQUIVO
				nPos := ascan(aNoCampos, {|x| x == SX3->X3_CAMPO})
				if nPos == 0 
					Aadd(aFields, SX3->X3_CAMPO)
				endif				
				SX3->(DbSkip())
			enddo 
		endif
	endif
		
	SX3->(DbSetOrder(2))
	SX3->(DbGoTop())		
	// Faz a contagem de campos no array
	For nX := 1 to Len(aFields)
		// posiciona sobre o campo
		If SX3->(DbSeek(aFields[nX]))	
			// adiciona as informa��es do campo para o getdados	  	
			Aadd(aHeader, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
				SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
		Endif		  		  	
	Next nX

	
	// Faz a contagem de campos no array
/*	For nX := 1 to Len(aFields)
		// Cria a variavel referente ao campo
		If DbSeek(aFields[nX])
			Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
		Endif
				
	Next nX*/
		
return

method simuACols(aValores) class TSigaUTest
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet
	private aCols := {}
	
	for i := 1 to Len(aValores)
	// adiciona linha a linha das tabelas
		Aadd(aCols, aValores[i])
		/*.f. -> Campo do delete do array GETDADOS*/
	next																			
Return
