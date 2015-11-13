user function trycatch()
	Local x
   Local y              := "TryTest"
   Local bErrorBlock := ErrorBlock({|e| oError := e, break(e)})
   
	for i := 1 to 5
		// TODO gerenciar erro
//		if ValType(&(tabela+"->"+Self:campos[i][2])) <> "U" //ValType(&(tabela+"->"+Self:campos[i][2]))
		begin sequence
		//TRY
  		  	x := &y.(,)    
     	//CATCH e as IdxException
     		ConOut( ProcName() + " " + Str(ProcLine()) + " " + str(i)  )
       //   ConOut( ProcName() + " " + Str(ProcLine()) + " " + str(i) + e:cErrorText )
       //END TRY
		end sequence
     	ConOut( "OK" + ProcName() + " " + Str(ProcLine()) + " " + str(i)  )

	 
//		else
//			MsgAlert("cpo not found")
//		endif
	next
	
	Errorblock(bErrorBlock)
return


user function tryc3()
	Local x
   Local y              := "TryTest"
   Local bErrorBlock := ErrorBlock({|e| oError := e, break(e)})

	begin sequence   
	for i := 1 to 5
		// TODO gerenciar erro
//		if ValType(&(tabela+"->"+Self:campos[i][2])) <> "U" //ValType(&(tabela+"->"+Self:campos[i][2]))

		//TRY
  		  	x := &y.(,)    
     	//CATCH e as IdxException
     		ConOut( ProcName() + " " + Str(ProcLine()) + " " + str(i)  )
       //   ConOut( ProcName() + " " + Str(ProcLine()) + " " + str(i) + e:cErrorText )
       //END TRY
		
     	ConOut( "OK" + ProcName() + " " + Str(ProcLine()) + " " + str(i)  )

	 
//		else
//			MsgAlert("cpo not found")
//		endif
	next
	end sequence
	Errorblock(bErrorBlock)
return

User Function TryC2
  
        Local x
        Local y              := "TryTest"
     
        Local bError         := { |e| oError := e , Break(e) }
        Local bErrorBlock    := ErrorBlock( bError )
        
        Local oError
    
       BEGIN SEQUENCE
           TRY
               x := &y.(,)    
           CATCH e as IdxException
               ConOut( "catch" + ProcName() + " " + Str(ProcLine()) + " " + e:cErrorText )
           END TRY
       RECOVER
           ConOut( "recover" + ProcName() + " " + Str(ProcLine()) + " " + oError:Description )
       END SEQUENCE 
      ErrorBlock( bErrorBlock )    
    
   Return( NIL )


