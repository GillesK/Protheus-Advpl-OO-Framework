
user function TSExCol()
	local oCol := TScolecao():New()
	local oIterat, oItem
	
	oCol:add("a")
	oCol:add("b")
	oCol:add("c")
			
	oIterat := oCol:getIterator()
	oItem := oIterat:first()
	while !oIterat:eoc()
		conout(oItem)
		oItem := oIterat:seguinte()		
	enddo
	
return	