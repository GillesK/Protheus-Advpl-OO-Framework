#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TESetor  � Autor � gilles koffmann    � Data �  22/10/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Setor de Venda						    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Elfa                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TESetor From TElfaMDBas
		
	method New() Constructor
	method iniCampos()	
	method findVigente()
EndClass

Method New( ) Class TESetor //ZZU // MA030TOK
	_Super:New()
	::tabela := 			"ZZS"	
	::entidade			:=	"Setor"
	::funcao			:=	"Cadastro de Setor"	
return (Self)


Method iniCampos() class TESetor
	// Nome externo, nome interno, tipo
	local cpoDef
	cpoDef := {{"filial"					, "ZZS_FILIAL", "C"};
				,{"regiao"					, "ZZS_REGIAO", "C"};
				,{"setor"					, "ZZS_SETOR"	, "C"};
				,{"vendedor"				, "ZZS_VEND"	, "C"};
				,{"dataInicial"			, "ZZS_DTINI"	, "D"};
				,{"dataFinal"				, "ZZS_DTFIM"	, "D"};
				,{"rota"					, "ZZS_ROTA"	, "C"}}
				
	::addCpoDef(cpoDef)	
		
	::setChave({{"1",{ "ZZS_FILIAL", "ZZS_REGIAO", "ZZS_SETOR", "ZZS_ROTA"}}})
	
return

Method findVigente(pChave) class TESetor
	local xReturn
	local pFilter
	local cData := dtos(dDatabase)
	pFilter :=  "'" + cData + "'" + " >= DtoS(ZZS_DTINI) .AND. " + "'" + cData + "'" + " <= DtoS(ZZS_DTFIM)"
	xReturn := ::findOrFail(pChave,pFilter)	
return xReturn

//Method produto() class TEGrupoTributario
//return TSHasMany():New(self, "TSProduto", {"B1_GRTRIB"}, nil)