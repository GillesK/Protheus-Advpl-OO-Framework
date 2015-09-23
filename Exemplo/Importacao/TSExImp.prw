#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSIMPEX  บ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Importa็ใo de dados de exemplo			    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework Copyright Sigaware Pb                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
				Case cInput == "Nใo" 
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