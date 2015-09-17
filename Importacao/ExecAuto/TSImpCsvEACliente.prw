#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSVEACliente   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv Cliente  			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*/{Protheus.doc} TSImpCsvEACliente
Importa��o de arquivo csv de cliente (SA1) via rotina automatica.
Gerencia s� inser��o
@type class
@author Gilles Koffmann - Sigaware Pb
@since 02/12/2013
@version 1.0
/*/
Class TSImpCsvEACliente From TSICExeAut
	method execute()
EndClass


method execute() class TSImpCsvEACliente
	MSExecAuto({|x,y| Mata030(x,y)},::aVetor,3)	
return 


	
