

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSTSMOD1 บ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de  Test Execu็ao de testes unitario     		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Elfa                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/


// dados de teste

/*	Prod		origem		grtrib		pre-prod	origem		grtrib
20070048       	2   	501			000391	
20170051       	3   	201			000044	
20170073       	5		201			000045
20240086       	7		201			000204
90010016       	2		301
90010096       	7		301			000053
90010105       	7		401
										000199
										000151					102
*/
	/*Cliente
	000099	01	PB
	031098	01	SP*/
	
	// Margem minima 16% (ZLK)
	
	/*Fornecedor		Estado	
	000141			PB
	000020			SP*/
	
	/* ZLI 
	Origem		Aliquota
	PB			17
	SP			7
	
	ZLJ
	Aliquota	repasse
	4			13,54
	17			0
	7			10,75
*/
user function TSTSMOD1(sConfFile, sLogDir)

	// read env file and record
	// create log file
	//oTstFactory := TSUTFactor():New(sConfFile, sLogDir)
	oTstFactory := TSUTFactor():New("C:\Totvs\TotvsTest\sigaware\modelo\env.ini", "C:\Totvs\TotvsTest\sigaware\modelo\")
	
	//oTestCalc := TTestCalc():New(oTstFactory)
	//oTestCalc:exec()
	oTstModelo := TTestSigaMDBas():new(oTstFactory)
	oTstModelo:exec()
							
	oTstFactory:resEnv()
return