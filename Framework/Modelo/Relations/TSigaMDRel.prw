#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSigaMDRelบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Base Rela็ใo 					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSigaMDRel
Classe de base Rela็ใo.
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSigaMDRel 

	data relatedType
	data related	
	data parent
	
	Method New() constructor
	method obter()
	method obterOrFail()	 
	method getvalKey()
EndClass

method New(parent, relatedType) class TSigaMDRel 
	::parent := parent
	::relatedType := relatedType
	cNameObj := entidade + "():New()"
	::related := &(cNameObj) 
return

method getValKey(parentKey) class TSigaMDRel
	local valChave := ""
	local aRet := {.T., ""}
	local cpoKey 
	if parentKey == nil
		cpoKey := parent:chave
	else
		cpoKey := parentKey
	endif
	for i := 1 to len(cpoKey)
		nPos := ascan(parent:campos, {|x| x[CPOTEC] == cpoKey[i] })
		if nPos != 0
			valChave := valChave + parent:campos[nPos][VALOR]
		else
			// TODO : erro			
			aRet := {.F., "Campos de chave nใo encontrados"}
			return aRet			
		endif
	next	
	aRet[2] := valChave
return aRet

/*/{Protheus.doc} obter
Obter os objetos da rela็ใo
@type method
@return mix, instancia de TSColecao ou TSigaMDBas, nil se nใo tem objetos na rela็ใo
/*/
Method obter() class TSigaMDRel
	local xRet 
	xRet := ::obterOrFail()
	if xRet[1]
		return xRet[2]
	else
		return nil
	endif
return xRet

/*/{Protheus.doc} obterOrFail
Obter os objetos da rela็ใo
@type method
@return array, {lRet, obj} lRet: .T. se encontrou e obj = instancia de TSColecao ou TSigaMDBas. lRet: .F. se nใo, obj : Mensagem de erro 
/*/
method obterOrFail() class TSigaMDRel

return 