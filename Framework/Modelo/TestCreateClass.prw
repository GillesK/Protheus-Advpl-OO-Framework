#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


Class TTestCriaClass
	data toto
	method New() constructor
endclass

method New() class TTestCriaClass
	::toto := "toto"
return self

user function creclas()
	local oTest, cName
	cClass := 'TTestCriaClass'
	cName := 'TTestCriaClass():New()'
	oTest := &(cName)
return