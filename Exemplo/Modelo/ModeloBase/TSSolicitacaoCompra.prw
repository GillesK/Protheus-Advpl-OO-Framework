// MATA110
#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSSolicitacaoCompra� Autor � gilles koffmann � Data  � 30/09/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Solicita��o de Compras Header		    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSSolicitacaoCompra
Classe representando uma solicita��o de compra (SC1).
Herda de TSigaMDBas
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2015
@version 1.0
@see TSigaMDBas.html
/*/
Class TSSolicitacaoCompra From TSigaMDBas
	method New() Constructor
	method iniCampos()
	method execAuto()
	method itens()

EndClass


Method New( ) Class TSSolicitacaoCompra 
	_Super:New()
	::tabela 	  := 		"SC1"	
	::entidade			:=	"Solicita��o de Compra"
	::funcao			:= "Solicita��o de Compra"
	::isExecAuto   := .T.
return (Self)


Method iniCampos() class TSSolicitacaoCompra
	local cpoDef
	// Nome externo, nome interno, tipo	
	cpoDef := {{"filial"						, "C1_FILIAL"		, "C"};
				,{"numero"						, "C1_NUM"			, "C"};				
				,{"nomeSolicitante"			, "C1_SOLICIT"	, "C"};
				,{"dataEmissao"				, "C1_EMISSAO"	, "D"}}

	::addCpoDef(cpoDef)	
	::addCpoInc("C1_NUM")

	::setChave({{"1",{"C1_FILIAL", "C1_NUM"}}})	
	
//	::setEAChave({"C1_FILIAL","C1_NUM"})		
return



Method itens() class TSSolicitacaoCompra
return ::hasMany("TSItemSolicitacaoCompra", "1", {"C1_NUM"})



method execAuto(opcao, lItens) class  TSSolicitacaoCompra
	//::getEAVector()
	//private lMsErroAuto := .F.		
	local aCabec := self:getEAVector()	
	local aItens := self:itens():getEAVector() 

	//Mata410(aCabec, aItens, opcao)
	MSExecAuto({|x,y,z| Mata110(x,y,z)}, aCabec, aItens, opcao)
	
return lMsErroAuto 

