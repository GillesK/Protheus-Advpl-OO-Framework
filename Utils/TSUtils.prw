#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"

       


/*/{Protheus.doc} TSUtils
Classe de utilidades
@type class
@author Gilles
@since 08/03/2016
@version 1.0
/*/
Class TSUtils

	method New() constructor
	method replaceStr(cIn, cToken, cValor)
	method listStack()	
endclass


/*/{Protheus.doc} New
Constructor
@type method
/*/
method New() class TSUtils
return Self


/*/{Protheus.doc} replaceStr
Substitui em cIn o cToken por cValor
@type method
@param cIn, character, cadeia de character que estamos escaneando
@param cToken, character, Token que estamos procurando dentro de cIn
@param cValor, character, valor que vai substituir o token
/*/
method replaceStr(cIn, cToken, cValor) class TSUtils
	local cMsg := cIn
	local nPos
	nPos :=  at(cToken, cIn)
	
	if nPos != 0
		cMsg := substr(cIn, 1, nPos -1)
		cMsg += cValor
		cMsg += substr(cIn, nPos + len(cToken))
	endif
	
return cMsg


/*/{Protheus.doc} listStack
Lista a stacj atual
@type method
/*/
method listStack() class TSUtils
	Local n := 1
	local cStack := ""
	 
	Do While !Empty(ProcName(n))
		cStack += AllTrim(ProcName(n++))
	EndDo
Return cStack

/*method defAHeader class TSGetDados


  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  For nX := 1 to Len(aFields)
    If SX3->(DbSeek(aFields[nX]))
      Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
    Endif
  Next nX*/
  
  
  
  