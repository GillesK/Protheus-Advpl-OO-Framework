#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"     



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TSFilial� Autor � gilles koffmann � Data  �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Empresa   � Sigaware Pb �E-Mail� gilles@sigawarepb.com.br                 ���
�������������������������������������������������������������������������͹��
���Descricao � Classe de Filial          					    		    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Framework copyright Sigaware Pb                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


Class TSFilial From TSigaMDBas

//	Data estadoEntregaCol
//	data empresaCol
//	data filialCol
	
//	data estadoEntrega
//	data empresa
//	data filial
		
	method New() Constructor
//	method getEstadoEntrega()
//	method getEmpresa()
//	method getFilial()
//	method getInfo()				
	method iniCampos()
EndClass


Method New( ) Class TSFilial 
	_Super:New()
	::tabela 			:= 		"SM0"
	::entidade			:=		"Filial"
	::funcao				:= "Cadastro de Filial"		
// 	::estadoEntregaCol := 	"M0_ESTENT"
// 	::empresaCol := 			"M0_CODIGO"
// 	::filialCol :=			"M0_CODFIL"
	dbselectarea(::tabela)
	self:fillCampos()
return (Self)


/*Method getInfo() class TSFilial
	local tabela := 	::tabela
	//dbSelectArea(Self:tabela)
	::estadoEntrega := &(tabela)->(&(Self:estadoEntregaCol))
	::empresa := &(tabela)->(&(Self:empresaCol))
	::filial := &(tabela)->(&(Self:filialCol))	
return*/ 

/*BEGINDOC
//�������������������������������������������������������������Ŀ
//�FS26953-2015 get Uf da Filial                      �
//���������������������������������������������������������������
ENDDOC*/

/*method getEstadoEntrega() class TSFilial
 
return (::estadoEntrega)

method getEmpresa() class TSFilial
 
return ::empresa

method getFilial() class TSFilial
 
return ::filial*/

Method iniCampos() class TSFilial
	// Nome externo, nome interno, tipo, mudaddo, valor
	aadd(::campos, {"empresa", "M0_CODIGO", "C",nil,.F.,.T.})
	aadd(::campos, {"filial", "M0_CODFIL", "C",nil,.F.,.T.})
	aadd(::campos, {"estadoEntrega", "M0_ESTENT", "C",nil,.F.,.F.})				
return