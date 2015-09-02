#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSigaUTest� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Base Test unitario 					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TSigaUTest 
	
	Data oFactory
	Data nome
	Data dados
	Data result
	
	method New() Constructor
	method assert()
		
EndClass


Method New(oFactory) Class TSigaUTest
	::oFactory := oFactory
return (Self)

method assert(resultado, esperado)  Class TSigaUTest
	local lRet := "Ok"
	if resultado != esperado
		lRet := "Ko
	endif
	
	// Nome do test , Ok or KO e porque	
	::oFactory:oLog:write(::nome, ::dados , resultado, esperado, lRet)
return lRet


