#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TSIMPCSVExecAuto   º Autor ³ Gilles Koffmann   º Data  ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de Importação de dados via arquivo csv   			  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework Copyright Sigaware Pb                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*/{Protheus.doc} TSICGeneri
Classe de base para importação via arquivo CSV com inserção generica (Reclock, msUnlock).
Deve-se herdar desta classe para importar numa tabela que não tenha rotina ExecAuto.
Definir obrigatoriamente o metodo prepCols() e a propiedade ::nLinDat.
São facultativos os metodos tratEspec(), prepTits() e as propiedades ::nLinCol e ::nLinTit.

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
@param lIns, lógico, .T. inserir, .F. atualizaçãp
@param nIndIni, numérico, Indice de coluna a partir do qual se faz a atualização
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



	
