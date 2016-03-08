#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TEGrupoTributario� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Aliquotas por grupo tributario		    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Elfa                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TEGrupoTributario From TElfaMDBas
		
	method New() Constructor
	method iniCampos()	
EndClass

Method New( ) Class TEGrupoTributario 
	_Super:New()
	::tabela := 			"ZZN"	
	::entidade			:=	"Aliquota de Grupo Tributario"
	::funcao			:=	"Cadastro de Aliquota de Grupo Tributario"	
return (Self)


Method iniCampos() class TEGrupoTributario
	// Nome externo, nome interno, tipo
	local cpoDef
	cpoDef := {{"filial"					, "ZZN_FILIAL"	, "C"};
				,{"grupoTributario"		, "ZZN_GRTRIB"	, "C"};
				,{"aliquota"				, "ZZN_ALIQ"		, "N"};
				,{"ufOrigemRepasseIcms"	, "ZZN_UFREP"		, "N"}}
	::addCpoDef(cpoDef)	
		
	::setChave({{"1",{ "ZZN_FILIAL", "ZZN_GRTRIB"}}})
	
return

//Method produto() class TEGrupoTributario
//return TSHasMany():New(self, "TSProduto", {"B1_GRTRIB"}, nil)