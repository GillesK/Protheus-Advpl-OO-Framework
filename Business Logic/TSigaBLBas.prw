#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSigaBLBas� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Base para Regras de Gest�o			    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*/{Protheus.doc} TSigaBLBas
Classe base para defini��o de regras de negocio (Business Logic)
@type class
@author Gilles Koffmann - Sigaware Pb
@since 04/03/2014
@version 1.0
/*/
Class TSigaBLBas  

	data idFunc
	data erroTitulo
		
	method New() Constructor
	method getErroTit()
	method mailDebug()
		
EndClass


/*/{Protheus.doc} New
Constructor
@type method
/*/
Method New() Class TSigaBLBas
	
return (Self)


method getErroTit()  Class TSigaBLBas
	local cTit
	cTit := ::erroTitulo + ::idFunc
return cTit



method mailDebug(cMsg) class TSigaBLBas
										

return

	

