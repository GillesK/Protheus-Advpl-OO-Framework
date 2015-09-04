#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSVEAProduto   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv produto   			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*/{Protheus.doc} TSImpCsvEAProduto
Importa��o de arquivo csv de Produto (SB1) via rotina automatica.
Gerencia s� inser��o
@type class
@author Gilles Koffmann - Sigaware Pb
@since 02/12/2013
@version 1.0
/*/
Class TSImpCsvEAProduto From TSICExeAut

	method execute()
EndClass

method execute() class TSImpCsvEAProduto

	MSExecAuto({|x,y| Mata010(x,y)},::aVetor,3)
	
return 


	
