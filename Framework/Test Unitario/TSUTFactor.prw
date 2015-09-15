#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"    
#INCLUDE "TBICONN.CH" 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSUTfactorบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de  Test unitario Factory 					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSUTFactor
Classe "Factory" para criar testes. Esta classe ้ responsavel por ler o arquivo de configura็ใo de ambiente
e inicializar a Log.
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/09/2015
@version 1.0
@example
Para criar uma execu็ใo de varios testes unitarios, precisa-se criar uma user function
que podera ser chamada diretamente no smartclient e que tera o seguite tipo de execu็ใo  <br>
 <br>
user function TSTLIC1(sConfFile, sLogDir)  <br>
  <br>
	oTstFactory := TSUTFactor():New("C:\Totvs\TotvsTest\env.ini", "C:\Totvs\TotvsTest\")  <br>
	 <br>
	// a sequencia dos testes unitarios  <br>
	// TTestLicCalcMgrPro herda de TSigaUTest  <br> 								
	oTstLicCalcMgrPro := TTestLicCalcMgrPro():new(oTstFactory)  <br>
	// execu็ใop do teste  <br>
	oTstLicCalcMgrPro:exec()  <br>
	 <br>
	// TTestLicCalcMgrMax herda de TSigaUTest  <br>
	oTstLicCalcMgrMax := TTestLicCalcMgrMax():new(oTstFactory)  <br>
	oTstLicCalcMgrMax:exec()	 <br>
	 <br>		
	// reset do ambiente  <br>				
	oTstFactory:resEnv()  <br>
return
 
/*/
Class TSUTFactor 

	data empresa
	data filial
	data usuario
	data senha
	
	data envFile
	data logDir
	
	data oLog
	data tables
	
	//data codigo
	
	method New() Constructor

	Method prepEnv()		
	Method resEnv()
	Method readEnvFile()	 	
EndClass


/*/{Protheus.doc} New
Constructor
O arquivo de defini็ใo do ambiente (sEnvFile) no formato .ini deve definir os seguintes elementos: 
empresa=xx  
filial=xx 
usuario=xxxxxx 
senha=xxxxxxx 
@type method
@param sEnvFile, character, caminha absoluto para o arquivo de defini็ใo de ambiente.
@param sLogDir, character, Pasta onde vai ser escrito o arquivo de log
/*/
Method New(sEnvFile, sLogDir, cTables) Class TSUTFactor
	::envFile := sEnvFile
	::logDir := sLogDir
	::oLog := TSUTLog():New(sLogDir)
	::tables := cTables
	// Read env File
	self:readEnvFile(::envFile)	
	self:prepEnv()
return (Self)


Method prepEnv() class TSUTFactor
	PREPARE ENVIRONMENT EMPRESA (self:empresa) FILIAL (self:filial) USER (self:usuario)  PASSWORD (self:senha) TABLES (self:tables)  
	//PREPARE ENVIRONMENT EMPRESA (::oEnv:_EMPRESA:TEXT) FILIAL (::oEnv:_FILIAL:TEXT) USER (::oEnv:_USUARIO:TEXT)  PASSWORD (::oEnv:_SENHA:TEXT) TABLES (::oEnv:_TABLES:TEXT) MODULO (::oEnv:_MODULO:TEXT)	               	                                       
	//PREPARE ENVIRONMENT EMPRESA (self:empresa) FILIAL (self:filial) USER (self:usuario)  PASSWORD (self:senha) TABLEA 'SA1' MODULO 'SIGAFAT' 
return

/*/{Protheus.doc} resEnv
Reset do ambiente
@type method
/*/
Method resEnv() class TSUTFactor
	RESET ENVIRONMENT
return
                      

Method readEnvFile(sConfFile) Class TSUTFactor
	local nHandle
//	Local cXml := ""
	//Local oXml
	Local cError   := ""
	Local cWarning := ""	
	local sRead
	local sLine := ""
	local aLinha := {} 
	// Ler arquivo fonte como string
	If !File(sConfFile)          
		// TODO write Log
		MsgStop("O arquivo " + sConfFile + " nใo foi encontrado. A gera็ใo serแ abortada!","ATENCAO")
		Return nil
	EndIf
	 
	nHandle := FT_FUse(sConfFile)  

	if nHandle == -1  
		// TODO write Log
		MsgStop("Nใo foi possivel abrir o arquivo " + sConfFile ,"ATENCAO")
		Return nil
	endif
	
//	ProcRegua(FT_FLASTREC(nHandle))	        

	FT_FGOTOP(nHandle)         
//	sRead := FReadStr(nHandle)
//	cXml  := cXml +  
	While !FT_FEOF(nHandle)
		sLine  := FT_FReadLn(nHandle)
		aLinha := separa(sLine, "=")
		//(Self:(&(aLinha[1]))) := aLinha[2]
		Do case
			case aLinha[1] == "empresa"
				::empresa := aLinha[2] 
			case aLinha[1] == "filial"
				::filial := aLinha[2]
			case aLinha[1] == "usuario"
				::usuario := aLinha[2] 
			case aLinha[1] == "senha"
				::senha := aLinha[2] 
		EndCase						 					
//		sRead := FReadStr(nHandle)     
		FT_FSkip(nHandle)
	EndDo
	 
	FT_FUse()			   	    

	// Initializa XmlParser
/*	oXml := XmlParser( cXml, "_", @cError, @cWarning )	
	
	If (oXml == NIL )   
		// TODO Write Log
		// TODO Throw exception ?
//		MsgStop("Falha ao gerar Objeto XML : "+cError+" / "+cWarning)
		Return nil
	Endif*/		
return                      



/*Method Create(sConfDir, sLogDir) class TMain

// Open config file       
// Esta fun็ใo vai articular os testes que devem ser executados
// Podem ser varios testes um atras do outro, ou pode ser um test unico

// os testes podem ser testes de nใo regressใo assim como 
// pode ser utilizado tambem para acelerar os testes unitaios e de integra็ใo

// Os testes "unitarios" sใo responsaveis por setar o ambiente
// Usaremos a orienta็ใo a objeto para fatorizar os elementos comuns
// entre os varios testes
	local oXml := NIL  	
		        
	::sConfDir := sConfDir + "\" 
	::sLogDir := sLogDir + "\"
	              
	// Create Log File
	//::oLog := TLog():Create(::sLogDir)
	
	// Open main config file
	oXml := self:readFile(::sConfDir + "config.xml")                               
	if oXml != nil                                                 
		oTests := XmlChildEx(oXML, "_TESTS")	
		if (oTests != nil)		
			oTest := XmlChildEx(oXML:_TESTS, "_TEST")		
			if (oTest != nil)
				if (valType(oTest) == "A")
					for i := 1 To Len(oTest)
			          self:parseTest(oTest[i])
					next i					
				Else
			    	self:parseTest(oTest)	
				EndIf
			EndIf	       		                            
		else                
			self:parseT2(oXml,::sConfDir)
		EndIf
	EndIf	
return*/