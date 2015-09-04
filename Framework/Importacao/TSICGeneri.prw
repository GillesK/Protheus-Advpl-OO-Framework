#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
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
*/

/*/{Protheus.doc} TSICGeneri
Classe de base para importa��o via arquivo CSV com inser��o generica (Reclock, msUnlock).
Deve-se herdar desta classe para importar numa tabela que n�o tenha rotina ExecAuto.
Definir obrigatoriamente o metodo prepCols() e a propiedade ::nLinDat.
S�o facultativos os metodos tratEspec(), prepTits() e as propiedades ::nLinCol e ::nLinTit.

Herda de : TSImpCsv
@type class
@author Gilles Koffmann - Sigaware Pb
@since 12/10/2013
@version 1.2
@see TSImpCsv
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

/*/{Protheus.doc} update
Update na base
@type method
@param lIns, l�gico, .T. inserir, .F. atualiza��p
@param nIndIni, num�rico, Indice de coluna a partir do qual se faz a atualiza��o
/*/
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



	
