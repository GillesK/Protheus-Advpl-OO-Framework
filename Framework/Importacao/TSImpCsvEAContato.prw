#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSVEAContato   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv Contato  			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

/*/{Protheus.doc} TSImpCsvEAContato
Importa��o de arquivo csv de Contato via rotina automatica.
Gerencia s� inser��o
@type class
@author Gilles Koffmann - Sigaware Pb
@since 02/12/2013
@version 1.0
/*/
Class TSImpCsvEAContato From TSICExeAut

	method execute()
EndClass

method execute() class TSImpCsvEAContato

	MSExecAuto({|x,y,z,a,b|TMKA070(x,y,z,a,b)},::aVetor,3,{},{}, .F.)
	
return 


	
