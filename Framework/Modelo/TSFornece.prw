#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSFornecedor� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Fornecedor          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TSFornece From TSigaMDBas

	method New() Constructor
		
	method iniCampos()
EndClass

Method New( ) Class TSFornece 
	_Super:New()
	::tabela 	  := 		"SA2"	
	::entidade			:=	"Fornecedor"
	::funcao			:=	"Cadastro de Fornecedor"	
// 	::estadoCol := 	"A2_EST"
//	::codigoCol := 	"A2_COD"
//	::lojaCol 		:= 	"A2_LOJA"
	
return (Self)


Method iniCampos() class TSFornece
	// Nome externo, nome interno, tipo, mudaddo, valor
	aadd(::campos, {"filial", "A2_FILIAL", "C",nil,.F.,.T.})
	aadd(::campos, {"codigo", "A2_COD", "C",nil,.F.,.T.})
	aadd(::campos, {"loja", "A2_LOJA", "C",nil,.F.,.T.})
	aadd(::campos, {"estado", "A2_EST", "C",nil,.F.,.F.})				
return
