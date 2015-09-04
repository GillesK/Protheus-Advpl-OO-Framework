#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSVGenContasAPagar   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv Contas a pagar   			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


Class TSImpCsvGenContasAPagar From TSICGeneri

	Method New() Constructor
	method callExec()
EndClass

method New() class TSImpCsvGenContasAPagar
	_Super:New()
	::sTable := "SE2"
return Self
	
method callExec() class TSImpCsvGenContasAPagar
local sTable := ::sTable

	&(sTable)->(DbSetOrder(1))
	//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA                                                    
	cChvTmp := padr(::aVetor[1][2], 3)+::aVetor[2][2]+::aVetor[4][2]+padr(::aVetor[5][2], 3)+padr(::aVetor[6][2], 3)+::aVetor[8][2]+::aVetor[9][2]
	// ESTA PESQUISA NAO ESTA CERTA: DEDPENDANDO Do ARQUIVO DE ENTRADA
	While &(sTable)->(dbSeek(cChvTmp))
		::aVetor[5][2] := cValToChar((val(SE2->E2_PARCELA)+1))
		cChvTmp := padr(::aVetor[1][2], 3)+::aVetor[2][2]+::aVetor[4][2]+padr(::aVetor[5][2], 3)+padr(::aVetor[6][2], 3)+::aVetor[8][2]+::aVetor[9][2]
	EndDo     
	lTst := .t.
	self:update(.T., 1)
	
return 


	
