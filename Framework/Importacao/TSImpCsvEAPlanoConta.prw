#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSVEAPlanoConta   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv Plano de conta   			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*/{Protheus.doc} TSImpCsvEAPlanoConta
Importa��o de arquivo csv de Plano de conta via rotina automatica.
Gerencia s� inser��o
@type class
@author Gilles Koffmann - Sigaware Pb
@since 02/12/2013
@version 1.0
/*/
Class TSImpCsvEAPlanoConta From TSICExeAut

	method execute()
EndClass

method execute() class TSImpCsvEAPlanoConta

	MSExecAuto( {|X,Y,Z| CTBA020(X,Y,Z)} ,::aVetor , 3, {})
	
return 


	
