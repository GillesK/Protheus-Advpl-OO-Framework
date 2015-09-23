#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPEX  � Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados de exemplo			    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TSImpEx From TSICGeneri

	method New() Constructor
	method prepCols()
	method tratEspec()	
	Method prepTits()
		
EndClass

Method New( sArquivo ) Class TSImpEx
	_Super:New( "ZZZ", sArquivo)
	::nLinCol := 0
	::nLinDat := 5
	::nLinTit := 4	
return (Self)

Method prepTits() class TSImpEx

	aAdd(::aTitulos, "TITULO 1")
	aAdd(::aTitulos, "TITULO 2")
	aAdd(::aTitulos, "CNPJ")

return

Method prepCols() class TSImpEx

	aAdd(::aColunas, {"ZZZ_1", "C" })
	aAdd(::aColunas, {"ZZZ_2", "C" })
	aAdd(::aColunas, {"ZZZ_CNPJ", "C" })
													
return


Method tratEspec(nX, cInput) class TSImpEx
	local conversao;

	conversao := cInput;
	
	Do Case 
		Case ::aColunas[nX][2] = 'C'
			
			// Sim / Nao
			Do Case			
				Case cInput == "Sim" 
					conversao := "S"
				Case cInput == "N�o" 
					conversao := "N"									
				Otherwise
				  	conversao := cInput
			EndCase
			
			// Cnpj
			if ::aColunas[nX][1] == 'ZZZ_CNPJ'
				//xx.xxx.xxx/xxxx-xx			
				conversao := substr(cInput,1,2) + substr(cInput,4,3) + substr(cInput,8,3) + substr(cInput,12,4)  + substr(cInput,17,2)
			EndIf
	EndCase			
	
return conversao


user function TSExImp()
	local oImpCsv 
	
	oImpCsv :=  TSImpEx():New('C:\Totvs\Exemplo\ExFile.csv')

	oImpCsv:doImport()
return