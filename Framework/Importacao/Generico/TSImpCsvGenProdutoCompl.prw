#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSImpCsvGenSB1Compl   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv SB1 complemento	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Class TSImpCsvGenProdutoCompl From TSICGeneri

	Method New() Constructor
	method callExec()
EndClass

method New() class  TSImpCsvGenProdutoCompl
	_Super:New()
	::sTable := "SB1"
return Self

method callExec() class TSImpCsvGenProdutoCompl

local sTable := ::sTable
	nTamArX := len(::aVetor)
	if nTamArX > 0 // sn1
          //dbSelectArea('SB1')        
		if &(sTable)->(dbSeek(xFilial(sTable)+::aVetor[1][2]))  // ESTA PESQUISA NAO ESTA CERTA: DEDPENDANDO Do ARQUIVO DE ENTRADA
			self:update(.F., 2)
		EndIf
	endif
return 


	
