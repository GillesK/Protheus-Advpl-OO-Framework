#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSIMPCSVExecAuto   � Autor � Gilles Koffmann   � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br              ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Importa��o de dados via arquivo csv   			  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework Copyright Sigaware Pb                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Class TSICGeneri From TSImpCsv

	Data sTable
	
	method New() Constructor	
	method callExec()
	Method update()	
EndClass


method New(pTable, sArquivo) class TSICGeneri
	_Super:New(sArquivo)
	::sTable := pTable
return Self


method callExec() class TSICGeneri

   	//nTamArX := len(::aVetor)
   
   if nTamArX > 0   
   		self:update(.T., 1)				
	EndIf
	
return 

Method update(lIns, nIndIni) class TSICGeneri
   	local sTable := ::sTable
   	nTamArX := len(::aVetor)
   
   //dbSelectArea(sTable)	
	Reclock(sTable, lIns)
	For Nx := nIndIni To nTamArX					
		nPosCmp := FieldPos(::aVetor[Nx][1])
		If nPosCmp > 0
			&(sTable)->(fieldPut(nPosCmp, ::aVetor[Nx][2]))//AC8->&aVetor[Nx][1] := aVetor[Nx][2]	
		EndIf	
	Next Nx
	&(sTable)->(MsUnlock())
return



	
