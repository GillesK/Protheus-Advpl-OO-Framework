#INCLUDE "protheus.ch"     
#INCLUDE 'fileio.ch'                      
#INCLUDE "folder.ch"     
#include "msobject.ch"
                     
#DEFINE ENTER CHR(13)+CHR(10)

/*/{Protheus.doc} TSUTLog
Classe de log dos testes
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/09/2015
@version 1.0
/*/Class TSUTLog
                               
//	Data oEnv
  	Data nHandle        
  	data logDir
  	data logFile  	
	
	Method New() Constructor
//	Method writeLog()         
	Method write()
//	Method convert() 
//	Method isExclu()
//	Method readInFile()	

EndClass       

/*/{Protheus.doc} New
Constructor
@type method
@param logDir, character, pasta (caminho absoluto) onde sera escrito o arquivo de log dos testes
/*/
Method New(logDir) Class TSUTLog

//	::logFile := logFile	  
//	local cUserId := __cUserId	
	Local logFile := "Test_Log_"  + dtos(Date()) + "_" + ;
		    			SUBSTR(TIME(), 1, 2) + SUBSTR(TIME(), 4, 2) + SUBSTR(TIME(), 7, 2) ;
		    			+ ".log"		
	::logDir := logDir		    			
	// criar arquivo de log e escrever header (data de processamento / arquivo processado / parametros)		
    ::nHandle := FCREATE(logDir + logFile)
	If ::nHandle == -1     
		// TODO STOP
//		Alert("Erro ao criar o arquivo " + logDir + logFile + " Erro: " + Str(Ferror()))
		return nil
	Else   
//		FWrite(nHLog, dtoc(Date()) + " " + time() + " " + cgArquivo + " " + ncbTabela + " " + ENTER)   
	EndIf                             
return  Self



/*/{Protheus.doc} write
Escreve na log. Uso interno
@type method
@param nome, character, Nome do teste
@param dados, character, Descrição do teste
@param resultado, mix, resultado do teste
@param esperado, mix, resultado esperado do teste
@param lRet, character, resultado final do teste "Ok" ou "Ko"

/*/
Method write(nome, dados, resultado, esperado, lRet) Class TSUTLog
	local cTipo, res, esp 
	FWrite(::nHandle, "Test: " + nome  + ENTER)
	FWrite(::nHandle, "   input: " + dados  + ENTER)
	if resultado == nil
		resultado := "nil"
	endif
	if esperado == nil
		esperado := "nil"
	endif	
	cTipo := valtype(resultado)
	Do Case
		case cTipo == 'C'
			res := resultado
			esp := esperado			
		case cTipo == 'D'
			res := dtoc(resultado)
			esp := dtoc(esperado)	
		case cTipo == 'L'
			if resultado == .T.
				res := "True"
			else
				res := "False"
			endif
			if esperado == .T.
				esp := "True"
			else
				esp := "False"
			endif			
		case cTipo == 'N'
			res := str(resultado)
			esp := str(esperado)			
	endcase
	FWrite(::nHandle, "   resultado: " + res  + ENTER)
	FWrite(::nHandle, "   esperado: " + esp  + ENTER)
	FWrite(::nHandle, "   " + lRet  + ENTER)
	FWrite(::nHandle, ENTER)			
return


/*Method writeLog(sOrigin, nRegistro) Class TSUTLog          
	local nHLogExec, lEnd, cLinhaLog
	FErase(::logDir + 'templog.log')
	MostraErro(::logDir, 'templog.log')  		
					// Abrir arquivo
	FWrite(::nHandle, "Registro: " + str(nRegistro)  + ENTER)   				
	
//				nHLogExec := FT_FUSE('c:\Download\importacaolog.log')
	nHLogExec := FOpen(::logDir + 'templog.log')
	lEnd := .F.
	while !lEnd
		cLinhaLog := FReadStr(nHLogExec, 100)					
						
		FWrite(::nHandle, cLinhaLog  )														
		if (Len(cLinhaLog) < 100)
			lEnd := .T.						
		EndIf
	EndDo						
	FClose(nHLogExec)    
					// Processar para botar no arquivo de log
					// Numero de registro | Mensagem | Dado invalido  
return*/         
