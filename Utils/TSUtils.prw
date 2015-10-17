#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"

       


Class TSUtils

	method New() constructor
	method replaceStr(cIn, cToken, cValor)	
endclass


method New() class TSUtils
return Self

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

/*method defAHeader class TSGetDados


  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  For nX := 1 to Len(aFields)
    If SX3->(DbSeek(aFields[nX]))
      Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
    Endif
  Next nX*/
  
  
  
  