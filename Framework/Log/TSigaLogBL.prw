#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TSigaLogBLº Autor ³ gilles koffmann º Data  ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Sigaware Pb ºE-Mail³ gilles@sigawarepb.com.br                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Classe de Log Businnes Logic				 					    		    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Framework copyright Sigaware Pb                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


Class TSigaLogBL From TSigaBLBas

	data chave
	data valChave
	data campos
	data oLog
	data tabela
	
	method New() Constructor
	Method ant(pTabela, paCampos)
	Method log(pTabela)	
EndClass


Method New() Class TSigaLogBL
	_Super:New()

	oLog := TSigaLog():New()
return (Self)


Method ant(pTabela, paCampos)  Class TSigaLogBL
	Local aiAreaSIX		:= SIX->(GetArea())
	Local aiAreaSX3		:= SX3->(GetArea())	
//	Local ciAliasIx			:=	Padr(pTabela,Len(SIX->INDICE),"")
	//Local ciAliasX3			:=	Padr(pTabela,Len(SX3->X3_ARQUIVO),"")	
	local aChave := {}
		
	::tabela := pTabela
	DbSelectArea(pTabela)
	
	DBSeletArea("SIX")
	SIX->(DBSetOrder(1))//INDICE+ORDEM
	SIX->(DBGoTop())
	If SIX->(DBSeek(pTabela))
		::chave := SIX->INDICE
	EndIf
//	RestArea(aiArea)
	RestArea(aiAreaSIX)
	
	aChave := separa(::chave, "+", .F.)
	::valChave := ""
	for i := 1 to Len (aChave)
		::valChave := ::valChave +  (&(pTabela))->(&(aChave[i]))
	next
	
	if (paCampos != nil) .And. (!Empty(paCampos))
		for i := 1 to Len (paCampos)
			aadd(::campos, {paCampos[i],(&(pTabela))->(&(paCampos[i]))})
		next
	else
		// Read SX3
		DBSeletArea("SX3")
		SX3->(DBSetOrder(1))
		SX3->(DBGoTop())
		If SX3->(DBSeek(pTabela))
			Do While SX3->(!EoF()) .And. SX3->X3_ARQUIVO == pTabela
				aadd(::campos, {SX3->X3_CAMPO,(&(pTabela))->(&(SX3->X3_CAMPO))})
				SX3->(DBSkip())
			EndDo
		EndIf		
		RestArea(aiAreaSX3)		
	endif
	

return


Method log(pTabela)  Class TSigaLogBL
	DbSelectArea(pTabela)
	// recuperar o primerio indice da tabela
	// recuperar o valor da chave
	// Comparar os campos com o antigo valor e botar na tabela
	
	for i := 1 to Len (::campos)
		if ::campos[i][2] != (&(pTabela))->(&(::campos[i][1]))
			// Old Value
			oLog:set('tabela', ::tabela)
			// tabela tem que ser com numero de empresa
			oLog:set('chave', ::chave)
			oLog:set('valorChave', ::valChave)
			oLog:set('campo', ::campos[i][1])
			oLog:set('antigoValor', ::campos[i][2])
			oLog:set('novoValor', (&(pTabela))->(&(::campos[i][1])))
			oLog:set('usuario', __USERID)
			oLog:set('dataHora', Now())
			// funcao
			// TODO criar 2 tabelas 1 header (chave valor de chave usuario funcao ...
			// outra com os valores antigos novos com chave estrangeira do header
			oLog:save()
		endif		
	next	
	
	
	
return

