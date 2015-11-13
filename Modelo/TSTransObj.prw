#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"

#define CHAVE 1
#define VALOR	2

class TSTransObj 
	data campos
	
	method New() constructor
	method valor()
	method setCampo()
	method hydrateAlias()
	method hydAllAlias()
	method equal()
	method cloneCampo()
endclass

method New()  class  TSTransObj
	::campos := {}
return self

method valor(key) class  TSTransObj
	local nPos
	Do case
		case ValType(key) == "N"
			return ::campos[key][VALOR]
		case ValType(key) == "C"
			nPos := ascan(::campos, {|x| x[1] == key})
			if nPos != 0 
				return ::campos[nPos][VALOR] 
			endif   
	endcase
return 

method setCampo(key, value)  class  TSTransObj
	nPos := ascan(::campos, {|x| x[1] == key})
	if nPos != 0 
		::campos[nPos][VALOR] := value
	else
		aadd(::campos, {key, value}) 
	endif   
return

method cloneCampo(key, item)  class  TSTransObj
	::setCampo(key, item:valor(key))   
return

method equal(key, item)  class  TSTransObj
	local lRet := .F.
	
	if self:valor(key) == item:valor(key)
		lRet := .T.
	endif
return lRet

method hydrateAlias(aliasQry) class  TSTransObj
	local i
   	Local bError         := { |e| oError := e , Break(e) }
   	Local bErrorBlock	
   	local fldName, fldVal
   	local aLastQuery, oQuery, aCpo, oIterat, cpo
	
	bErrorBlock    := ErrorBlock( bError )
	aLastQuery    := GetLastQuery()
	
	oQuery := TSQuery():New()
	colCpo := oQuery:getCampos(aLastQuery[2])
	oIterat := colCpo:getIterator()	
	cpo := oIterat:first()
	while !oIterat:eoc()
		begin sequence
			::setCampo(cpo, (aliasQry)->(&(cpo)))
		Recover
			ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
		end sequence		
		cpo := oIterat:seguinte()
	enddo
/*	for i:= 1 to (aliasQry)->(FCount())
		begin sequence
			fldName := (aliasQry)->(FieldFieldName(i))
			fldVal := (aliasQry)->(FieldGet(i))
			::setCampo(fldName, fldVal)
		Recover
			ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
		end sequence
	next*/ 
	Errorblock(bErrorBlock)	
return


method hydAllAlias(aliasQry) class  TSTransObj
   	local colObj, oNewObj	
   	local axArea
   			
 //  	axArea := aliasQry->(getarea())
   	
	colObj := TSColecao():New()
	(aliasQry)->(DbGoTop())
	While (aliasQry)->(!EOF())
		oNewObj := TSTransObj():New()
//		oNewObj := &(cNewObj)
		oNewObj:hydrateAlias(aliasQry)
		colObj:add(oNewObj)		
		(aliasQry)->(DbSkip())
	enddo
	(aliasQry)->(DbGoTop())	
//	restarea(axArea)		
return colObj