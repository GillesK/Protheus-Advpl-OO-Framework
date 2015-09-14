#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


    
#DEFINE ENTER CHR(13)+CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSV   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv   			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/



/*/{Protheus.doc} TSImpCsv
Classe de base para importa��o via arquivo CSV.
@type class
@author Gilles Koffmann - Sigaware Pb
@since 02/11/2013
@version 1.2
/*/
Class TSImpCsv
	
//	Data sOption
	Data sArquivo
//	Data sTable
//	Data aDef

	Data nLinCol

/*/{Protheus.doc} nLinDat
Linha do arquivo onde come�am os dados
@type property
/*/	 
	Data nLinDat

/*/{Protheus.doc} nLinTit
Linha do arquivo onde est�o os titulos para verifi��o de layout
@type property

/*/	 	
	Data nLinTit

/*/{Protheus.doc} aTitulos
Array onde est�o os nomes dos titulos do arquivo para verifica��o do layout
O Array tem que ser pre-ecnhido na mesma ordem que as colunas do arquivo 
@type property
@example
	aAdd(::aTitulos, "APRESENTA��O")
/*/	 		
	Data aTitulos

/*/{Protheus.doc} aColunas
Array onde est�o os nomes e os tipos dos campos nas tabelas protheus.
O Array tem que ser pre-ecnhido na mesma ordem que as colunas do arquivo
@type property
@example
	aAdd(::aColunas, {"ZZZ_APRESE", "C" })
/*/	 		 
	Data aColunas
	
/*/{Protheus.doc} aVetor
Array contendo os dados de 1 linha do arquivo de entrada.
@type property
@example
	aadd(::aVetor, {::aColunas[nX][1], conversao, NIL})
/*/	 		  	
	Data aVetor	
	
	Method New() Constructor
	Method doImport()
	
	Method procLinha()	
	Method criaVect()
	Method procString()
	
	Method callExec()
//	Method callExe2() 
//	Method callExe3()
	
//	Method update()
	Method sfZap() 	
//	Method procErro() 
//	Method identErro()
	 
//	Method idFrnCGC()
//	Method idCodMun() 
//	Method idFrnIE()
	
	Method prepCols() 
	method prepFiles()
	method tratEspec()
	method readHead()
	method confFile()
	method linhaComp()	
		
	method prepTits()
EndClass

/*/{Protheus.doc} New
Constructor
@type method
@param sArquivo, character, caminho completo do arquivo para importar
/*/
Method New( sArquivo ) Class TSImpCsv
	//::sOption := sOption
	::sArquivo := sArquivo       
	//::sTable := sTable
	::nLinCol := 0
	::nLinDat := 5
	::nLinTit := 4
	::aTitulos := {}
	::aColunas := {}		        
//	::aDef := { {1,"", 2},{2,"", 2}, ;
	//		{10,"", 1}, {11,"", 1}, {12,"", 1}, {13,"", 1}, {14,"", 1},;
		//	 {100,"SE2",3},  {101,"SN1",3},  {102,"SB1",3},   {103,"SA1",3}}
	::aVetor := {}	
return Self                      

/*/{Protheus.doc} prepTits
M�todo para informar os tit�los do arquivo se quiser fazer o controle de layout.
Os t�tulos devem ser informado dentro de aTitulos respeitando a ordem das colunas
do arquivo sendo importado
@type method
@example
	aAdd(::aTitulos, "APRESENTA��O")
@see aTitulos
/*/
Method prepTits()  Class TSImpCsv

return


/*/{Protheus.doc} callExec
M�todo responsavel pela atualiza��o no Protheus. Chamado para cada linha do arquivo de entrada
@type method
/*/
Method callExec()  Class TSImpCsv

return


/*/{Protheus.doc} prepCols
M�todo para informar os campos da tabela Protheus sendo importada.
Os campos devem ser informados dentro de aColunas respeitando a ordem das colunas
do arquivo sendo importado
@type method
@example
	aAdd(::aColunas, {"ZZZ_APRESE", "C" })
@see aColunas
/*/
Method prepCols() class TSImpCsv

	cLinha  := aHead[::nLinCol]
	aColu := Separa(cLinha,";",.T.)
	                           
	// identificar tipos
	DbSelectArea("SX3")
  	SX3->(DbSetOrder(2))      
	For nX := 1 to Len(aColu)
		If SX3->(DbSeek(AllTrim(aColu[nX])))
			aAdd(::aColunas, {Alltrim(aColu[nX]), SX3->X3_TIPO })
//		else
//			aadd(::aColunas, {"", ""})
	    Endif                            
    Next nX
    
    cBobLol := ""
return


/*/{Protheus.doc} tratEspec
Tratamento espec�fico de um campo. Para classes filhas
@type method
@param nX, num�rico, O indice da coluna sendo tratada para acessar aColunas
@param cInput, character, dado a tratar
@return character, dado tratado
/*/
Method tratEspec(nX, cInput) class TSImpCsv
		
return 


/*/{Protheus.doc} doImport
M�todo principal para executar a importa��o
@type method
/*/
Method doImport()  class TSImpCsv

	static aExcCol := {}
	static nHandle, nHLog, nHLogExec, nRegistro := 2
//	static aVetor := {}            
	static aColu := {}         
	static aHead := {}	          
	static conversao, lEnd                   
	static cLinha, cLinhaLog
	static logDir := "c:\Totvs\LogImport\"
	static cUserId := __cUserId
	static logFile := "ImportacaoCsv_Log_" + cUserId  + "_" + dtos(Date()) + "_" + ;
		    			SUBSTR(TIME(), 1, 2) + SUBSTR(TIME(), 4, 2) + SUBSTR(TIME(), 7, 2) ;
		    			+ ".log"
	private lImp := .F.	

//	private sTable 
//	private nProcess := ::aDef[AScanX(::aDef, {|x,y|x[1]==val(::sOption) })][3]

//	if nProcess != 2
	//	::sTable := ::aDef[AScanX(::aDef, {|x,y|x[1]==val(::sOption) })][2]
//	Endif
		
	if !self:prepFiles()
		return
	endif
	
	// Ler o header do arquivo
	self:readHead()
	
	// inicializar o array com o nome dos titulos
	self:prepTits()
	
	// verificar que � o layout esperado
	if self:confFile()	
		self:prepCols()
	
		aDadosTemp := {}
		
		if !Empty(::sTable)
			DbSelectArea(::sTable)
		EndIf
		
		While !FT_FEOF(nHandle)
		       
		 	::aVetor := {}
			IncProc("Lendo arquivo, aguarde...")
		 
			cLinha := FT_FREADLN(nHandle)
			
			// testar linha inteira
			cLinha := self:linhaComp(cLinha)
			cLinha := self:procLinha(cLinha) 
			aDadosTemp := Separa(cLinha,";",.T.)
			                                                            
			if (Len(aDadosTemp) > 1)
				self:criaVect()
				nTamArX := len(::aVetor)
				self:callExec()				
				/*Do Case	
				   // tipo de processamento				   	
					Case nProcess == 1  // ExecAuto padr�o
						lImp := .F.
						while !lImp		
							self:callExec()		        		           
							self:procErro()
							lImp := .t.
						EndDo						
					Case nProcess == 2 // Insert tabela Generica
						self:callExe2()
					Case nProcess == 3   // Processamento especifico
						self:callExe3()
					Otherwise
						MsgStop("Tipo de processamento n�o definido")
						exit
				EndCase*/								
			EndIf
			
			FT_FSKIP(nHandle)                                 
			nRegistro += 1
		EndDo
	else
		MsgStop("O layout do arquivo de dados � diferente do esperado. Por favor contate o suporte TI / Protheus", "TImpCsv:Erro")
	EndIf
		 
	FT_FUSE()
	FClose(nHLog)    
		 
	ApMsgInfo("Importa��o do registros conclu�da com sucesso! Verifique o arquivo de log","SUCESSO")
	
return  



// PROTECTED



Method linhaComp(input) class TSImpCsv
	local aDadosT, nextLine 
	// para tratar o LFCR numa linha
	aDadosT := Separa(input,";",.T.)
	while Len(aDadosT) < Len(::aColunas)
		// Read Next Line		
		FT_FSKIP(nHandle)		
		nextLine := FT_FREADLN(nHandle)
		input := input + nextLine
		aDadosT := Separa(input,";",.T.)		
	end while
return input


Method readHead() class TSImpCsv
	// ler o cabe�alho do arquivo
	FT_FGOTOP(nHandle)
	for i := 1 to ::nLinDat - 1
		aadd(aHead, FT_FReadLn(nHandle))	
		FT_FSKIP(nHandle)
	end
return

// Metodo para tirar as aspas eventuais
Method procLinha(cNoAspa) class TSImpCsv
	local cNoAspa2 := ""
	local lEnd := .T.
	local nPos1, nPos2
	local cPart1, cPart2, cPart3, cPartInt
	
	while lEnd
		nPos1 := at('"', cNoAspa)
		if nPos1 != 0
			// cPart1"cPart2"cPart3
			cPart1 := substr(cNoAspa, 1, nPos1)
			cPartInt := substr(cNoAspa, nPos1 + 1 , 9999 )
	
			nPos2 := at('"', cPartInt)
			cPart2 := 	substr(cPartInt,  1 , nPos2)
			cPart2 := strtran(cPart2,";",",") //parte2 - s� o valor at� a 2� aspas, eliminando todas as virgulas
						
			cPart3 := substr(cPartInt,  nPos2 +1 , 9999)
//			nPos2 := at('"', substring(cString,waspa1+1,9999)) //busca posi��o da 2� aspa ap�s a 1� aspa
			cNoAspa2 += cPart1+cPart2 
			cNoAspa := cPart3
		else
			cNoAspa2 += cNoAspa 
			lEnd := .F.
		endif	
	EndDo
return cNoAspa2


Method criaVect() class TSImpCsv
			// Cria o vector
	local cNoAspa, cNoAspa2, lEnd        
	for nX := 1 to len(::aColunas)
		if ::aColunas[nX][1] != ""
			if AScanX(aExcCol, {|x,y| x == AllTrim(::aColunas[nX][1])}) == 0
				if substr(aDadosTemp[nX], 1, 2) != "<#"
					// trata aspa
					cNoAspa := aDadosTemp[nX]
					cNoAspa := self:procString(cNoAspa) 				 
					
					Do Case								
						Case ::aColunas[nX][2] == 'C'
							if len(cNoAspa) > 250
								conversao := substr(cNoAspa, 1, 250)
							else
								conversao := cNoAspa 
							EndIf						 					  		
						Case ::aColunas[nX][2] == 'N' 
							nPos := at(',', cNoAspa)
							If nPos > 0
				        		conversao := val(strtran(cNoAspa,',', '.'))	
				        	Else
					        	conversao := val(cNoAspa)	
				        	EndIf
				        							
						Case ::aColunas[nX][2] == 'D'				        				
			        		conversao := stod(alltrim(cNoAspa))
					EndCase
																	
					conversao = self:tratEspec(nX, conversao)
					aadd(::aVetor, {::aColunas[nX][1], conversao, NIL})
				EndIf
			Endif
		EndIf	
	next nX
return





Method procString(cNoAspa) class TSImpCsv
	local nPos1
	
	if at("'", cNoAspa) = 1
		cNoAspa := substr(cNoAspa, 2, len(cNoAspa))
		if at("'", cNoAspa) = len(cNoAspa)
			if len(cNoAspa) == 1
				cNoAspa := ""
			else
				cNoAspa := substr(cNoAspa, 1, len(cNoAspa) - 1)
			endif
		EndIf
	EndIf
					
	// trata dupla aspa
	if at('"', cNoAspa) = 1
		cNoAspa := substr(cNoAspa, 2, len(cNoAspa))
		if rat('"', cNoAspa) = len(cNoAspa)
			if len(cNoAspa) == 1
				cNoAspa := ""
			else
				cNoAspa := substr(cNoAspa, 1, len(cNoAspa) - 1)
			endif
		EndIf
	EndIf					
					
		//  trata dupla aspa no corpo
	lEnd := .T.
	cNoAspa2 := ""
	while lEnd
		nPos1 := at('"', cNoAspa)
		if nPos1 != 0
			if substr(cNoAspa, nPos1 + 1 , 1 ) == '"'
				cNoAspa2 += substr(cNoAspa, 1, nPos1 - 1) + '"'
				if nPos1 + 1 == len(cNoAspa)  
					lEnd := .F.
				else
					cNoAspa := substr(cNoAspa, nPos1 + 2, Len(cNoAspa))							
				endIf    		
			endif
		else
			cNoAspa2 += cNoAspa 
			lEnd := .F.
		endif	
	EndDo
return cNoAspa2



Method sfZap(cTab) class TSImpCsv
	local cTabela := RetSqlName(cTab)
	cAlias := "TMP"
	
	USE (cTabela) ALIAS (cAlias) EXCLUSIVE NEW VIA "TOPCONN"
	If NetErr()   
		MsgStop("Nao foi possivel abrir "+cTabela+" em modo EXCLUSIVO.")
		return .F.     
	Else   
		ZAP   
		USE   
		MsgStop("Registros da tabela "+cTabela+" eliminados com sucesso.")
		return .T.		
	Endif
return



method confFile() class TSImpCsv
	local cLinha
	local aTit := {}
	local ret := .T.
	
	if Len(::aTitulos) != 0
		cLinha  := aHead[::nLinTit]
		aTit := Separa(cLinha,";",.T.)
	
		For nX := 1 to Len(aTit)
       	if AllTrim(aTit[nX]) != ::aTitulos[nX]
       		ret := .F.
       		exit
       	EndIf                     
   		Next nX
   	EndIf 	
return ret



Method prepFiles() class TSImpCsv

	If !File(::sArquivo)
		MsgStop("O arquivo " + ::sArquivo + " n�o foi encontrado. A importa��o ser� abortada!","ATENCAO")
		Return .F.
	EndIf
	 
	nHandle := FT_FUSE(::sArquivo)
	if nHandle = -1  
		MsgStop("N�o foi possivel abrir o arquivo " + ::sArquivo ,"ATENCAO")
		Return .F.
	endif
	
	ProcRegua(FT_FLASTREC(nHandle))
                                                     
	// criar arquivo de log e escrever header (data de processamento / arquivo processado / parametros)

    nHLog := FCREATE(logDir + logFile)
	If nHLog == -1   
		Alert("Erro ao criar o arquivo " + logDir + logFile + " Erro: " + Str(Ferror()))
		return .F.
	Else   
		FWrite(nHLog, dtoc(Date()) + " " + time() + " " + ::sArquivo +  " " + ENTER)   
	EndIf                                       

return .T.


