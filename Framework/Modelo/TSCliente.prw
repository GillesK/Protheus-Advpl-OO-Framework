#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSCliente� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Cliente          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TSCliente From TSigaMDBas


	method New() Constructor
	method iniCampos()
EndClass

Method New( ) Class TSCliente 
	_Super:New()
	::tabela 	  := 		"SA1"	
	::entidade			:=	"Cliente"
	::funcao			:= "Cadastro de Cliente"	
// 	::estadoCol := 	"A1_EST"
	//::codigoCol := 	"A1_COD"
	//::lojaCol 		:= 	"A1_LOJA"
	
return (Self)


Method iniCampos() class TSCliente
	// Nome externo, nome interno, tipo, mudaddo, valor, chave
	aadd(::campos, {"filial", "A1_FILIAL", "C",nil,.F.,.T.})
	aadd(::campos, {"codigo", "A1_COD", "C",nil,.F.,.T.})
	aadd(::campos, {"loja", "A1_LOJA", "C",nil,.F.,.T.})
	aadd(::campos, {"estado", "A1_EST", "C",nil,.F.,.F.})				
return