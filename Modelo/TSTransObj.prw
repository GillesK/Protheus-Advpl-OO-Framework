#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE 'fileio.ch'       
#include "msobject.ch"

#define CHAVE 1
#define VALOR	2

/*/{Protheus.doc} TSTransObj
Classe que representa um entidade com chaves e valores. Serve quando
precisamos de uma estrutura de dados que não pode ser representado  por um TSigaMDBas
pois não tem representação na base de dados
@type class
@author Gilles
@since 15/11/2015
@version 1.0
/*/
class TSTransObj 
	data campos
	
	method New() constructor
	method valor()
	method chave()
	method setCampo()
	method hydrateAlias()
	method hydAllAlias()
	method equal()
	method cloneCampo()
	method clone()
	method getAHeader()
	method hydrateACols()
	method hydAColsPos()		
	method numCampos()
endclass

method New()  class  TSTransObj
	::campos := {}
return self

method numCampos() class  TSTransObj
return Len(::campos)

/*/{Protheus.doc} valor
Retorna o valor associado a chave (key)
@type method
@param key, ${param_type}, chave
/*/
method valor(key) class  TSTransObj
	local nPos
	Do case
		case ValType(key) == "N"
			return ::campos[key][VALOR]
		case ValType(key) == "C"
			nPos := ascan(::campos, {|x| AllTrim(x[1]) == key})
			if nPos != 0 
				return ::campos[nPos][VALOR] 
			endif   
	endcase
return 

method chave(index)  class  TSTransObj
return ::campos[index][CHAVE]

/*/{Protheus.doc} setCampo
Seta o valor, se a chave ja existe, muda o valor. Se a chave não existe ela é criada
@type method
@param key, ${param_type}, (Descrição do parâmetro)
@param value, ${param_type}, (Descrição do parâmetro)
/*/
method setCampo(key, value)  class  TSTransObj
	nPos := ascan(::campos, {|x| x[1] == key})
	if nPos != 0 
		::campos[nPos][VALOR] := value
	else
		aadd(::campos, {key, value}) 
	endif   
return

/*/{Protheus.doc} cloneCampo
(long_description)
@type method
@param key, ${param_type}, (Descrição do parâmetro)
@param item, ${param_type}, (Descrição do parâmetro)
/*/
method cloneCampo(key, item)  class  TSTransObj
	::setCampo(key, item:valor(key))   
return


method clone()  class  TSTransObj
	local oTObj
	oTObj := TSTransObj():New()
	oTObj:campos := AClone(::campos)   
return oTObj

/*/{Protheus.doc} equal
Compara o valor associado a chave com o valor de outro objeto TTransObj
@type method
@param key, ${param_type}, (Descrição do parâmetro)
@param item, ${param_type}, (Descrição do parâmetro)
/*/
method equal(key, item)  class  TSTransObj
	local lRet := .F.
	
	if self:valor(key) == item:valor(key)
		lRet := .T.
	endif
return lRet


/*/{Protheus.doc} hydrateAlias
Preenche o objeto com os campos da query atualmente posicionado
@type method
@param aliasQry, array, Alias da query
/*/
method hydrateAlias(aliasQry, aCampos) class  TSTransObj
	local i
   	Local bError         := { |e| oError := e , Break(e) }
   	Local bErrorBlock	
   	local fldName, fldVal
   	local aLastQuery, oQuery, aCpo, oIterat, cpo
	
	bErrorBlock    := ErrorBlock( bError )
	if aCampos == nil 
		aLastQuery    := GetLastQuery()
	
		oQuery := TSQuery():New()
		colCpo := oQuery:getCampos(aLastQuery[2])
		oIterat := colCpo:getIterator()	
		cpo := oIterat:first()
		while !oIterat:eoc()
			begin sequence
				::setCampo(cpo, (aliasQry)->(&(cpo)))
			Recover
				ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
			end sequence		
			cpo := oIterat:seguinte()
		enddo
	else
		for i:= 1 to Len(aCampos)
			begin sequence
				::setCampo(aCampos[i], (aliasQry)->(&(aCampos[i])))
			Recover
				ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
			end sequence
		next 
	endif
/*	for i:= 1 to (aliasQry)->(FCount())
		begin sequence
			fldName := (aliasQry)->(FieldFieldName(i))
			fldVal := (aliasQry)->(FieldGet(i))
			::setCampo(fldName, fldVal)
		Recover
			ConOut( ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
		end sequence
	next*/ 
	Errorblock(bErrorBlock)	
return


/*/{Protheus.doc} hydAllAlias
Preenche uma coleção de objetos TTransObj com o resultado da query
@type method
@param aliasQry, array, alias da query
/*/
method hydAllAlias(aliasQry, aCampos) class  TSTransObj
   	local colObj, oNewObj	
   	local axArea
   			
 //  	axArea := aliasQry->(getarea())
   	
	colObj := TSColecao():New()
	(aliasQry)->(DbGoTop())
	While (aliasQry)->(!EOF())
		oNewObj := TSTransObj():New()
//		oNewObj := &(cNewObj)
		oNewObj:hydrateAlias(aliasQry, aCampos)
		colObj:add(oNewObj)		
		(aliasQry)->(DbSkip())
	enddo
	(aliasQry)->(DbGoTop())	
//	restarea(axArea)		
return colObj




method getAHeader(aHeaderInt, aFlds, lValid)    class  TSTransObj
	local  curTab, nPos, nX
//	local aHeaderInt := {}
	local axArea := SX3->(getarea())
//	local cValid

	// Define os campos de acordo com o array
	DbSelectArea("SX3")
	
	if aHeaderInt == nil
		aHeaderInt := {}
	endif
//	if ((aFlds == nil .And. aNoCampos == nil) .Or. (aNoCampos != nil))
//		aFlds := ::getFields(aFlds, aNoCampos) 
//	endif
		
	SX3->(DbSetOrder(2))
	SX3->(DbGoTop())		
	// Faz a contagem de campos no array
	For nX := 1 to Len(aFlds)
		// posiciona sobre o campo
//		SX3->(DbGoTop())		
		If SX3->(DbSeek(aFlds[nX]))	
			// adiciona as informações do campo para o getdados
//			cValid := nil
			if (lValid == nil) .Or. (lValid != nil .And. lValid == .T.)
				Aadd(aHeaderInt, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL;
					,SX3->X3_VALID,SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})			
				//cValid := SX3->X3_VALID
			else
				Aadd(aHeaderInt, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL;
					,"","",SX3->X3_TIPO,SX3->X3_F3,"" })			
			endif  	
		Endif		  		  	
	Next nX

	restarea(axArea)
	// Faz a contagem de campos no array
/*	For nX := 1 to Len(aFields)
		// Cria a variavel referente ao campo
		If DbSeek(aFields[nX])
			Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
		Endif
				
	Next nX*/
		
return aHeaderInt



/*/{Protheus.doc} hydrateACols
Preeche o objeto a partir do aHeader e aCols
@type method
@param paHeader, array, aHeader
@param paCols, array, aCols
@return TSColecao, os objetos do aCols
/*/
method hydrateACols(paHeader, paCols) class  TSTransObj
	local nPos, cpo
	local colObj
	local oObj
	local cCreate	
	local j, i
	
	colObj := TSColecao():New()
	for j := 1 to len(paCols)
		//cCreate := GetClassName(Self) + "():New()"
		oObj := TSTransObj():New()
		oObj:hydAColsPos(paHeader, paCols, j)
/*		for i := 1 to Len(paHeader)
			cpo := oObj:getCampo(alltrim(paHeader[i][2]))
			//nPos := ascan(oObj:campos, {|x| x[CPOTEC] == alltrim(paHeader[i][2])})
			if cpo != nil
				cpo[VALOR] := paCols[j][i] 	
			endif		
		next*/
		colObj:add(oObj)
	next
	//Local xProd := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO" })
	//Local _Prod := aCols[n,xProd]
return colObj


/*/{Protheus.doc} hydAColsPos
Preeche o objeto a partir do aHeader e a linha do aCols indicada 
@type method
@param paHeader, array, aHeader
@param paCols, array, aCols
@param nAt, numérico, posição no aCols
/*/
method hydAColsPos(paHeader, paCols, nAt)  class  TSTransObj
	local i
	for i := 1 to Len(paHeader)
		::setCampo(AllTrim(paHeader[i][2]), paCols[nAt][i])
	next
return self

