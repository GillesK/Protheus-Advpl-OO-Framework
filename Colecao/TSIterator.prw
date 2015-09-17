#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TSIteratorบ Autor ณ gilles koffmann บ Data  ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบEmpresa   ณ Sigaware Pb บE-Mailณ gilles@sigawarepb.com.br                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Classe de Itera็ใo de uma cole็ใo 					    		    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Framework copyright Sigaware Pb                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


/*/{Protheus.doc} TSIterator
Iterator de  cole็ใo
@type class
@author Gilles Koffmann - Sigaware Pb
@since 03/09/2014
@version 1.0
/*/
Class TSIterator
	data oCol
	data nCurr
	
	method New() Constructor
	method seguinte()
	method anterior()
	method first()
	method last()	
	method eoc()
	method boc()
	method current()
EndClass 


/*/{Protheus.doc} New
Construtor
@type method
@param oCol, objeto, Cole็ใo
/*/
method New(oCol) Class TSIterator
	//::oCol := {}
	::nCurr := 1
	::oCol := oCol
return self


/*/{Protheus.doc} Eoc
Retorna .T. se posicinado no final da cole็ใo
@type method
@return l๓gico, 
/*/
method eoc()  Class TSIterator
	local xRet := .F.
	local nLim := ::oCol:length() + 1
	if ::nCurr == nLim
		xRet := .T.
	endif
return xRet

/*/{Protheus.doc} Boc
Retorna .T. se posicinado no inicio da cole็ใo
@type method
@return l๓gico,
/*/
method boc()  Class TSIterator
	local xRet := .F.
	if ::nCurr == 0
		xRet := .T.
	endif
return xRet


/*/{Protheus.doc} anterior
Se posiciona no elemento anterior da cole็ใo
@type method
@return mix, objeto da cole็ใo ou nil se ja esta no inicio
/*/
method anterior() Class TSIterator
	if ::nCurr < 1
		return nil
	endif
	::nCurr -= 1
return	::oCol:obter(::nCurr)

/*/{Protheus.doc} seguinte
Se posiciona no elemento seguinte da cole็ใo
@type method
@return mix, objeto da cole็ใo ou nil se ja esta no final
/*/
method seguinte() Class TSIterator
	if ::nCurr > ::oCol:length()
		return nil
	endif
	::nCurr += 1
return	::oCol:obter(::nCurr)

/*/{Protheus.doc} first
Se posiciona e retorna o primeiro da cole็ใo
@type method
@return mix, retorna o primeiro da cole็ใo ou nil se cole็ใo vazia
/*/
method first() Class TSIterator
	if ::oCol:length() == 0
		return nil
	endif
	::nCurr := 1
return	::oCol:obter(::nCurr)

/*/{Protheus.doc} last
Se posiciona e retorna o ultimo da cole็ใo
@type method
@return mix, retorna o ultimo da cole็ใo ou nil se cole็ใo vazia
/*/
method last() Class TSIterator
	if ::oCol:length() == 0
		return nil
	endif
	::nCurr := ::oCol:length()
return	::oCol:obter(::nCurr)


method current() Class  TSIterator
	if ::oCol:length() == 0
		return nil
	endif
return ::oCol:obter(::nCurr)
