#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSImpCsvGenSN1   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv SN1  			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Class TSImpCsvGenSN1 From TSICGeneri

	Method New() Constructor
	method callExec()
EndClass

method New() class TSImpCsvGenSN1
	_Super:New()
	::sTable := "SN1"
return Self

method callExec() class TSImpCsvGenSN1

	local sTable := ::sTable
	nTamArX := len(::aVetor)
	
	if nTamArX > 0 // sn1
			//dbSelectArea('SN1')
			//N1_FILIAL+N1_CBASE+N1_ITEM
		if !(&(sTable)->(dbSeek(xFilial(sTable)+::aVetor[3][2]+::aVetor[3][2])))  // AQUI TEM UM PROBLEMA
			self:update(.T., 1)
		Else
			MsgStop('Linha j� existe ou � duplicada: Filial:'+::aVetor[2][2]+ ' Codigo Base: ' +aVetor[3][2])
		EndIf
	endif
return 


	
