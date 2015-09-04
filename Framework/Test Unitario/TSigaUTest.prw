#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSigaUTestบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Base Test unitario 					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSigaUTest
Classe base para defini็ใo de testes unitarios
@type class
@author Gilles Koffmann - Siagware Pb
@since 04/09/2015
@version 1.0
@example
A classe herdando de TSigaUTest (aqui TTestLicCalcCust) tera o seguinte formato <br>
 <br>
Method New(oFactory) Class TTestLicCalcCust <br>
	_Super:New(oFactory) <br>
	// defini็ใo do nome do test <br>
	::nome := "Test da funcao TELPropBL():calcCust()" <br>
return (Self) <br>
 <br>
// m้todo executando os testes <br>
method exec() class TTestLicCalcCust <br>
	local xReturn <br>
	local pTpCalc, pPf, pRpIcms, pValDesc, pValCap, pDesc87, pValDescCap, pValIcms <br>
	 <br>
	// cria็ใo do objeto a testar  <br>
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
	// Explica็ใo do caso de teste  <br>	
	::dados := "Tipo calculo = 2, Valor de Icms = 0"  <br>
	// execu็ใo da fun็ใo a testar	 <br>
	xReturn := oLicPropBl:calcCust(pTpCalc, pPf, pRpIcms, pValDesc, pValCap, pDesc87, pValDescCap, pValIcms)  <br>
	// verifica็ใo do resultado e escritura na log  <br>
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
Descri็ใo do teste
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
M้todo que compara dois valores e escreve o resultado na log
@type method
@param resultado, mix, resultado do teste
@param esperado, mix, resultado esperado do teste
@return l๓gico .T. se o resultado = esperado, .F. se resultado != esperado
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
M้todo de execu็ใo do teste. Abstrato. Deve ser definir na classe filha
@type method
/*/
method exec() class  TSigaUTest

return