

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSTSMOD1 � Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de  Test Execu�ao de testes unitario     		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Elfa                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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