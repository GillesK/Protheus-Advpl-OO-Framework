#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSNFSaida� Autor � gilles koffmann � Data  �  23/11/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe da Nota Fiscal de Saida          	    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Elfa								                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSNFSaida
Classe representando uma nota fiscal de saida (SF2).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 23/11/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSNFSaida From TSigaMDBas
	method New() Constructor
	method iniCampos()
//	method execAuto()
	method itens()
	method cliente()
EndClass


Method New( ) Class TSNFSaida 
	_Super:New()
	::tabela 	  := 		"SF2"	
	::entidade	  :=	"Nota Fiscal de Saida"
	::funcao	  := 	"Nota Fiscal de Saida"		
//	::isExecAuto   := .T.
return (Self)


Method iniCampos() class TSNFSaida
	local cpoDef
	// Nome externo, nome interno, tipo, AutoInc	, campo filial
	cpoDef := {{"filial"					,"F2_FILIAL"		, "C"};
				,{"numero"					,"F2_DOC"			, "C"};
				,{"serie"					,"F2_SERIE"		, "C"};
				,{"cliente"				,"F2_CLIENTE"		, "C"};
				,{"lojaCliente"			,"F2_LOJA"			, "C"};
				,{"tipo"					,"F2_TIPO"			, "C"};
				,{"formularioPropio"		,"F2_FORMUL"		, "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{"1",{"F2_FILIAL", "F2_DOC", "F2_SERIE", "F2_CLIENTE", "F2_LOJA", "F2_FORMUL", "F2_TIPO"}}})
	
return


Method itens() class TSNFSaida
return ::hasMany("TSItemNFSaida", "3", {"F2_DOC", "F2_SERIE", "F2_CLIENTE", "F2_LOJA"})

method cliente()  class TSNFSaida
return ::belongsTo("TSCliente", {"F2_CLIENTE", "F2_LOJA"}, "1")

