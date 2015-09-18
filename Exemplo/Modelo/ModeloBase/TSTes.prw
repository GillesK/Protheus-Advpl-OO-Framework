#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSTes� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Tes          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSTes
Classe representando uma Tes (SF4).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSTes From TSigaMDBas
	method New() Constructor
	method iniCampos()
	method execAuto()
	method mensagemNota()
EndClass


Method New( ) Class TSTes 
	_Super:New()
	::tabela 	  := 		"SF4"	
	::entidade			:=	"Tes"
	::funcao			:= "Cadastro de Tipo de Entrada e Saida"		
	
return (Self)


Method iniCampos() class TSTes
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial", "F4_FILIAL", "C"};
				,{"codigo", "F4_CODIGO", "C"};
				,{"tipo", "F4_TIPO", "C"};
				,{"mensagemPadrao", "F4_XMENPAD", "C"};
				,{"geraDuplicata", "F4_DUPLIC", "C"}}

	::addCpoDef(cpoDef)	

	::setChave({{1,{"F4_FILIAL", "F4_CODIGO"}}})			
return

//method pedidoVendaItem()  class TSTes
//return ::hasMany("TSPedidoVendaItem", "C6_TES", 
method mensagemNota() class TSTes
return ::belongsTo("TSFormula", {"F4_XMENPAD"}, 1)