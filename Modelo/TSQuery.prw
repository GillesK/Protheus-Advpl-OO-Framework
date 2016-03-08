#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"


/*/{Protheus.doc} TSQuery
Classe que representa um query de base de dados
@type class
@author Gilles
@since 15/11/2015
@version 1.0
/*/
class TSQuery

	method New() constructor
	method getCampos()
	method getWord()
	method getSelFrom()
endclass


method New()  class  TSQuery
return self

	
/*/{Protheus.doc} getCampos
Retorna uma coleção com os nomes dos campos selecionados pela query
@type method
@param cQuery, character, (Descrição do parâmetro)
/*/
method getCampos(cQuery) class  TSQuery
	local colCpo
	local nPosSel, nPosFrom, nPosCase, nPosNome, nPosSub
	local cCampos, aCampos,  i, aName, cCpoUp

	colCpo := TSColecao():New()
	cQryUp := UPPER(cQuery)
	
	::getSelFrom(cQryUp, @nPosSel, @nPosFrom)
	
//	nPosSel := at("SELECT", cQryUp)
//	nPosFrom :=  rat("FROM", cQryUp)
	cCampo := substr(cQuery , nPosSel + 6, nPosFrom - 9)
	aCampos := separa(allTrim(cCampo), ",")
	for i := 1 to len(aCampos)
		cCpoUp := aCampos[i]
		nPosCase := at("CASE", cCpoUp)
		nPosSub := at("SELECT", cCpoUp)
		Do Case
			Case nPosCase != 0 .Or. nPosSub != 0  
				nPosNome := rat(" ", aCampos[i])
				colCpo:add(allTrim(substr(aCampos[i], nPosNome + 1)))				
			Otherwise
				aName := separa(alltrim(aCampos[i]), " ")
				if Len(aName) >= 2
					colCpo:add(alltrim(aName[2]))
				else
					colCpo:add(alltrim(aName[1]))
				endif				  
		endcase
	next 
return colCpo

method getSelFrom(cQryUp, nPosSel, nPosFrom) class  TSQuery
	local aSel, aFrom
	local indSel := 2, indFrom := 1  
	aSel := ::getWord(cQryUp, "SELECT")
	aFrom := ::getWord(cQryUp, "FROM")
	
	nPosSel := aSel[1]
	if Len(aSel) == 1
		nPosFrom := aFrom[1]
	else
		while aSel[indSel] < aFrom[indFrom]
			if indSel == Len(aSel)
				indFrom += 1
				exit
			endif
			indSel += 1
			indFrom += 1
		enddo	
		nPosFrom := aFrom[indFrom]
	endif
return

method getWord(cQuery, cWord) class  TSQuery
	local aSel := {}, pos := -1
	local currInd := 0
//	cQryUp := UPPER(cQuery)
	while pos != 0
		pos := at(cWord, cQuery)
		if pos != 0
			aadd(aSel, currInd + pos)
			cQuery := substr(cQuery, pos + Len(cWord))
			currInd += pos + Len(cWord)
		endif
	enddo		
return aSel

