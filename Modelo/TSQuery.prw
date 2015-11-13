#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"


class TSQuery

	method New() constructor
	method getCampos()
endclass


method New()  class  TSQuery
return self

	
method getCampos(cQuery) class  TSQuery
	local colCpo
	local nPosSel, nPosFrom
	local cCampos, aCampos,  i, aName
	colCpo := TSColecao():New()
	nPosSel := at("SELECT", cQuery)
	nPosFrom :=  at("FROM", cQuery)
	cCampo := substr(cQuery , nPosSel + 6, nPosFrom - 8)
	aCampos := separa(cCampo, ",")
	for i := 1 to len(aCampos)
		aName := separa(alltrim(aCampos[i]), " ")
		if Len(aName) >= 2
			colCpo:add(alltrim(aName[2]))
		else
			colCpo:add(alltrim(aName[1]))
		endif
	next 
return colCpo