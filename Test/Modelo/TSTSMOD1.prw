

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
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


user function TSTSMOD1(sConfFile, sLogDir)

	// read env file and record
	// create log file
	//oTstFactory := TSUTFactor():New(sConfFile, sLogDir)
	oTstFactory := TSUTFactor():New("C:\Totvs\TotvsTest\sigaware\modelo\env.ini";
				, "C:\Totvs\TotvsTest\sigaware\modelo\";
				,"SBM")
	
	//oTestCalc := TTestCalc():New(oTstFactory)
	//oTestCalc:exec()
	oTstModelo := TTestSigaMDBas():new(oTstFactory)
	oTstModelo:exec()
							
	oTstFactory:resEnv()
return