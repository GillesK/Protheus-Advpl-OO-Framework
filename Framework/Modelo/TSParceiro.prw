#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSParceiro� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Parceiro          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TSParceiro From TSigaMDBas

	Data codigoCol
	Data estadoCol
	Data lojaCol
	
	data loja
	data estado

	method New() Constructor
	method getEstado()		
	method getInfo()
EndClass

Method New( ) Class TSParceiro 
	_Super:New()
	
	::loja	:= ""
return (Self)




Method getInfo() class TSParceiro
	local tabela := 	::tabela
	::codigo := &(tabela)->(&(Self:codigoCol))
	::loja := &(tabela)->(&(Self:lojaCol))
	::estado := &(tabela)->(&(Self:estadoCol))
return 

/*BEGINDOC
//�������������������������������������������������������������Ŀ
//�FS26953-2015 get Uf do Cliente                      �
//���������������������������������������������������������������
ENDDOC*/
// ZL3_CLIENT, ZL3_LOJA
Method getEstado() class TSParceiro
	
return ::estado

