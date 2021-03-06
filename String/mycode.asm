inputString MACRO string
    MOV AH,0Ah
    LEA DX,string
    INT 21h     
ENDM

outputString MACRO string
    MOV AH,09h
    LEA DX,string
    INT 21h   
ENDM


fixString MACRO string ;used to delete char not sense of string value
    
    XOR CX,CX
    MOV CL,length     
    MOV BX,CX
    MOV string[BX],'$'
    CLD    ; Clear flag
    LEA SI,buff
    LEA DI,string  
    REP MOVSB     
    
    
ENDM
              
searchCharString MACRO string,findChar,result  
    LOCAL exit,totalexit,searchLoop,found,loopsave,notfound
    MOV BX,0
    MOV CX,0
    searchLoop:
        CMP string[bx],'$' ;Check not the end of string        
        JE notfound  
        MOV DL,string[bx]     
        CMP DL,findChar    ;Search findChar in string
        JE found
        INC BX
        JMP searchLoop       
    found:              ;Save and convert to String
        
            MOV AX,BX    
            MOV BX,0 
       loopsave:  
            MOV DX,0
            MOV CX,10
            DIV CX
            CMP AX,0
            JE exit 
            MOV result[bx],DL             
            ADD result[bx],'0'
            INC BX
            JMP loopsave    
       exit: 
            MOV result[bx],DL 
            ADD result[bx],'0'
            JMP totalexit
    notfound:                ;If the result is not found, the result will return 'N'
            MOV BX,0          
            MOV DL,'N'
            MOV result[bx],'N'    
    totalexit:           ;Exit end of MACRO 



ENDM

searchStringinString MACRO string1, string2 , result
    LOCAL exit,totalexit,searchLoop,checkNextChar,loopcheckNextChar,save,loopsave,notfound
    MOV BX,0
    MOV CX,0
    searchLoop:
        CMP string1[bx],'$' ;Check not the end of string        
        JE notfound  
        MOV DL,string1[bx]     
        CMP DL,string2[0]    ;Search findChar in string
        JE checkNextChar
        INC BX
        JMP searchLoop       
    checkNextChar:              
       MOV temp,BX   
       MOV CX,0
       loopcheckNextChar:     
           INC CX
           MOV BX,CX  
           CMP string2[BX],'$'
           JE save  
           MOV DH,string2[BX]
           MOV BX,temp
           ADD BX,CX    
           MOV DL,string1[BX] 
           CMP DL,DH 
           JE loopcheckNextChar
           MOV BX,temp
           INC BX
           JMP searchLoop
       save:    
            
            MOV AX,temp  
            INC AX  
            MOV BX,0    
            
       loopsave:  
            MOV DX,0
            MOV CX,10
            DIV CX
            CMP AX,0
            JE exit 
            MOV result[bx],DL             
            ADD result[bx],'0'
            INC BX
            JMP loopsave    
       exit: 
            MOV result[bx],DL 
            ADD result[bx],'0'
            JMP totalexit
    notfound:                ;If the result is not found, the result will return 'N'
            MOV BX,0          
            MOV DL,'N'
            MOV result[bx],'N'    
    totalexit:           ;Exit end of MACRO 




ENDM

reverseString MACRO string1, string2      
    local pushString,setBXandPopString,popString
    MOV BX,0
    MOV CX,0
    pushString:
        CMP string1[bx],'$'   ;Check to end of string
        JE setBXandPopString
        MOV DX,0
        MOV DL,string1[bx]
        PUSH DX      
        INC BX
        INC CX                  
        JMP pushString
    setBXandPopString:
        MOV BX,0    
    popString:
        POP DX
        MOV string2[bx],DL
        INC BX
        LOOP popString
                                              
ENDM


copyString MACRO string1,string2     
    LOCAL exit,copyloop
    MOV BX,0
    copyloop:
        CMP string1[bx],'$'
        JE exit
        MOV DL,string1[bx]  ;DL like a temp value to copy string2[bx],string1[bx]
        MOV string2[bx],DL
        INC BX
        JMP copyloop
    exit:  
    MOV string2[bx],'$'

ENDM  

lengthString MACRO string,length 
    local lengthloop,save,loopsave,exit
    MOV BX,0
    lengthloop:
        CMP string[bx],'$'
        JE save
        INC BX
        JMP lengthloop
    save:
    MOV AX,BX
    MOV BX,0 
      
    loopsave:  
    MOV DX,0
    MOV CX,10
    DIV CX
    CMP AX,0
    JE exit 
    MOV length[bx],DL  
    ADD length[bx],'0'
    INC BX
    JMP loopsave    
    exit: 
    MOV length[bx],DL 
    ADD length[bx],'0'
    
ENDM    


upperString MACRO string  
    local upperloop,exit,notchange
    MOV BX,0
    upperloop:
    CMP string[bx],'$'
    JE exit 
    CMP string[bx],'a'
    JB notchange   
    CMP string[bx],123
    JNB notchange
    SUB string[bx],32
    notchange:     
    INC BX
    JMP upperloop
    exit:
ENDM  

lowerString MACRO string
    local  lowerloop,notchange1,exit
    MOV BX,0
    lowerloop:
    CMP string[bx],'$'
    JE exit
    CMP string[bx],'A'
    JB notchange1
    CMP string[bx],91
    JNB notchange1
    ADD string[bx],32
    notchange1:
    INC BX
    JMP lowerloop
    exit:
ENDM
 

catString MACRO string1,string2  
    local catloop1,next,catloop2,exit
    MOV BX,0
    catloop1:
    CMP string1[bx],'$'
    JE next
    INC BX
    JMP catloop1
    
    next: 
    MOV temp2,BX
    MOV BX,0
    catloop2:              
        
        CMP string2[bx],'$'
        JE exit
        MOV DL,string2[bx]
        MOV temp1,bx
        MOV BX,temp2
        ADD BX,temp1
        MOV string1[BX],DL
        MOV BX,temp1
        INC BX 
        JMP catloop2
   exit: 
ENDM   
    
compareLengthString MACRO string1,string2
    local lengthloop,save,lengthloop1,save1,length1Longer,equalLength,exit
    MOV BX,0
    lengthloop:
        CMP string1[bx],'$'
        JE save
        INC BX
        JMP lengthloop
    save:
        MOV length1,BX
    MOV BX,0
    lengthloop1:
        CMP string2[bx],'$'
        JE save1
        INC BX
        JMP lengthloop1
    save1:
        MOV length2,BX   
    MOV DX,length1
    CMP DX,BX
    JE equalLength
    JB length1Longer
    outputString msgString1Longer
    JMP exit
    length1Longer:
        outputString msgString2Longer
        JMP exit
    equalLength:
        outputString msgStringEqualLonger
    exit:         
  
ENDM

compareString MACRO string1,string2
    local lengthloop,lengthloop1,save,save1,length1Longer,equalLength,exit  
    MOV BX,0
    lengthloop:
        CMP string1[bx],'$'
        JE save
        INC BX
        JMP lengthloop
    save:
        MOV length1,BX
    MOV BX,0
    lengthloop1:
        CMP string2[bx],'$'
        JE save1
        INC BX
        JMP lengthloop1
    save1:
        MOV length2,BX   
    MOV DX,length1
    CMP DX,BX
    JE equalLength
    JB length1Longer
    outputString msgString1CMP
    JMP exit
    length1Longer:
        outputString msgString2CMP
        JMP exit
    equalLength:
        MOV BX,0
        loopCMP:
            CMP string1[bx],'$'
            JE equalCMP 
            MOV CL,string1[bx]
            MOV DL,string2[bx]
            CMP CL,DL
            JA string1CMP
            JB string2CMP
            INC BX
            JMP loopCMP
        string1CMP:
        outputString msgString1CMP
        JMP exit
        string2CMP:
        outputString msgString2CMP
        JMP exit
        equalCMP:
        outputString msgStringEqualCMP        
    exit:    
ENDM
 
 
repaceWord MACRO string,word,wordReplace   
    local searchLoop,found,exit
    MOV BX,0
    MOV CX,0
    searchLoop:
        CMP string[bx],'$' ;Check not the end of string        
        JE exit  
        MOV DL,string[bx]     
        CMP DL,findChar    ;Search findChar in string
        JE found
        INC BX
        JMP searchLoop       
    found:              ;Save and convert to String   
        MOV DL,wordReplace
        MOV string[bx],DL 
        INC BX
        JMP searchLoop
    exit:           ;Exit end of MACRO 
        
ENDM 

replaceString MACRO string1,string2,stringReplace   
    local searchLoop,checkNextChar,loopcheckNextChar,replaceString,replaceLoop,exit
    MOV BX,0
    MOV CX,0
    searchLoop:
        CMP string1[bx],'$' ;Check not the end of string        
        JE exit  
        MOV DL,string1[bx]     
        CMP DL,string2[0]    ;Search findChar in string
        JE checkNextChar
        INC BX
        JMP searchLoop       
    checkNextChar:              
       MOV temp,BX   
       MOV CX,0
       loopcheckNextChar:  
           INC CX
           MOV BX,CX  
           CMP string2[BX],'$'
           JE replaceString  
           MOV DH,string2[BX]
           MOV BX,temp
           ADD BX,CX    
           MOV DL,string1[BX] 
           CMP DL,DH 
           JE loopcheckNextChar
           MOV BX,temp
           INC BX
           JMP searchLoop
       replaceString:     
           MOV CX,-1
           replaceLoop:
               INC CX 
               MOV BX,CX
               CMP string2[BX],'$'
               JE searchLoop
               MOV DL,stringReplace[BX]
               MOV BX,temp
               ADD BX,CX
               MOV string1[BX],DL 
               JMP replaceLoop
              
    exit:           ;Exit end of MACRO   
ENDM  

insertChar MACRO string, char, index   
   local doneLength,insertloop,lengthloop,done,exit   
   MOV BX,0
    lengthloop:
        CMP string[bx],'$'
        JE doneLength
        INC BX
        JMP lengthloop
    doneLength:   
    MOV DL,char
    insertloop:
        
        CMP BX,index
        JE  done   
        ;JA exit
        DEC BX
        MOV DL,string[BX]
        INC BX
        MOV string[BX],DL
        DEC BX
        JMP insertloop
   done:
        MOV DL,char
        MOV string[BX],DL
   exit:     
        
ENDM


deleteChar MACRO string, index 
    local deleteCharloop,deleteEndWord,exit 
    MOV BX,index
    DEC BX
    deleteCharloop:       
        CMP string[BX],'$'
        JE deleteEndWord  
        
        INC BX
        MOV DL,string[BX]
        DEC BX
        MOV string[BX],DL
        INC BX
        JMP deleteCharloop
   deleteEndWord:
        DEC BX
        MOV string[BX],'$'  
   exit:
ENDM
    
    
deleteString MACRO string, index, lengthToDelete     
    mov doneLength,deleteStringloop,addEndString 
  ;  MOV BX,0
 ;   lengthloop:
 ;       CMP string[bx],'$'
 ;       JE doneLength
 ;       INC BX
 ;       JMP lengthloop  
 ;   CMP BX,index
    JB exit     
        
    doneLength:   
    MOV BX,index
    DEC BX
    deleteStringloop:
        ADD BX,lengthToDelete
        CMP string[BX],'$'
        JE  addEndString      
        SUB BX,lengthToDelete
        ADD BX,lengthToDelete
        MOV DL,string[BX]
        SUB BX,lengthToDelete
        MOV string[BX],DL
        INC BX
        JMP deleteStringloop
   addEndString:
        SUB BX,lengthToDelete
        MOV string[BX],'$' 
   exit:
ENDM            
                                    
                                    
DSEG SEGMENT   
    msgNotice0 DB "-----------------------------------------------",10,13             
    msgNotice1 DB "1.Input String",10,13
    msgNotice2 DB "2.Output String ",10,13  
    msgNotice3 DB "3.Search Char in String",10,13
    msgNotice4 DB "4.Search String in String",10,13
    msgNotice5 DB "5.Reserve String",10,13
    msgNotice6 DB "6.Copy String",10,13
    msgNotice7 DB "7.Length of String",10,13
    msgNotice8 DB "8.Upper string",10,13
    msgNotice9 DB "9.Lower String" ,10,13
    msgNotice10 DB "a.Compare Length String",10,13
    msgNotice11 DB "b.Cat String"  ,10,13
    msgNotice12 DB "c.Compare String",10,13
    msgNotice13 DB "d.Replace word" ,10,13
    msgNotice14 DB "e.Delete char",10,13
    msgNotice15 DB "f.Delete string" ,10,13
    msgNotice16 DB "g.Insert char",10,13 
    msgNotice17 DB "h.Exit",10,13
    msgNotice18 DB "Select choice ... :   $"
    
    msgString1CMP DB "String1 bigger than String2 $"
    msgString2CMP DB "String2 bigger than String1 $"     
    
    msgStringEqualCMP DB "String1 like the same String2 $"
    msgString1Longer DB "String1 longer than String2 $"
    msgString2Longer DB "String2 longer than String1 $"
    msgStringEqualLonger DB "String 1 and String 2 have the same length $"
    msgInput DB "Input your string: $"
    msgOutput DB "The result is: $"   
    msgInputChar DB "Input char: $"
    result DB 30 DUP('$') 
    div10 DB 10
    findChar DB 'e'     
    wordReplace DB 'u'  
    wordInsert DB 'k'  
    deletecharr DW '$'
    temp DW 0  
    temp1 DW 0    
    temp2 DW 0 
    length1 DW ?
    length2 DW ? 
    lengthStr DB '$'
    charTemp DB 0
    lengthex1 DW 0
    enterLine DB 10,13,'$' 
    stringReplace DB 30 DUP('$')
    string1 DB 60 DUP('$') 
    string2 DB 60 DUP('$')  
    string3 DB 60 DUP('$')
    select DB 60 DUP('$')
        max DB 60
        length DB ?
        buff DB 60 DUP(?) 
        
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    
start:
    MOV AX,DSEG
    MOV DS,AX
    MOV ES,AX     
    
    MOV DL,0      
    OR DL,0   
        
    loopselect:  
    outputString enterLine
    outputString msgNotice0  
    inputString max
    fixString select     
    cmp select,'1'
    je select1
    cmp select,'2'
    je select2 
    cmp select,'3'
    je select3   
    cmp select,'4'
    je select4  
    cmp select,'5'
    je select5    
    cmp select,'6'
    je select6
    cmp select,'7'
    je select7 
    cmp select,'8'
    je select8 
    cmp select,'9'
    je select9 
    cmp select,'a'
    je select10
    cmp select,'b'
    je select11  
    cmp select,'c'
    je select12
    cmp select,'d'
    je select13  
    cmp select,'e'
    je select14  
    cmp select,'f'
    je select15
    cmp select,'g'
    je select16  
    cmp select,'h'
    je select17  
                    
    select1: 
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1   
    
    jmp loopselect
            
    select2:
    outputString enterLine
    outputString string1
    jmp loopselect
            
            
    select3:    
    outputString enterLine
    outputString msgInputChar
    mov ah,01     
    int 21h
    mov findChar,al
    searchCharString string1,findChar,result  
    outputString enterLine
    outputString msgOutput
    outputString result
    jmp loopselect     
    
    select4:
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string2
    searchStringinString string1,string2,result   
    reverseString result,result
    outputString enterLine
    outputString msgOutput    
    outputString result     
    jmp loopselect
    
    select5:
    reverseString string1,string2   
    copyString string1, string2
    outputString string2      
    jmp loopselect  
    
    select6:
    copyString string1, string2
    outputString enterLine
    outputString msgOutput
    outputString string2     
    jmp loopselect 
   
    select7:  
    
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1    
    lengthString string1, lengthStr  
    reverseString lengthStr,lengthStr  
    outputString enterLine
    outputString msgOutput   
    outputString lengthStr 
    jmp loopselect          
    
    select8: 
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1
    upperString string1 
    outputString enterLine
    outputString msgOutput  
    outputString string1   
    jmp loopselect    
     
    select9:   
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1
    lowerString string1 
    outputString enterLine   
    outputString msgOutput  
    outputString string1   
    jmp loopselect    
    
    
    select10:
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string2    
    compareLengthString string1,string2
    jmp loopselect   
    
    select11:
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string2    
    catString string1 string2
    outputString string1    
    jmp loopselect   
    select12:
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string2 
    compareString string1,string2 
    jmp loopselect   
    
    select13:     
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1    
    outputString enterLine
    outputString msgInputChar
    mov ah,01     
    int 21h
    mov findChar,al    
    repaceWord string1,findChar,wordReplace      
    outputString string1  
    jmp loopselect   
    
    select14:  
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1    
    outputString enterLine
    outputString msgInputChar
    mov ah,01     
    int 21h    
    mov ah,0
    mov deletecharr,ax 
    deleteChar string1,deletecharr
    outputString enterLine
    outputString msgOutput
    outputString string1
    jmp loopselect   
        
    
    
    select15: 
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1
    deleteString string1,5,2
    outputString enterLine
    outputString msgOutput
    outputString string1
    jmp loopselect   
        
        
    select16:     
    outputString enterLine
    outputString msgInput  
    inputString max  
    fixString string1  
    outputString enterLine
    outputString msgInputChar
    mov ah,01     
    int 21h
    mov wordInsert,al  
    insertChar string1,wordInsert,5 
    jmp loopselect
    select17:  
    
    
    MOV AH,4CH
    INT 21h
    
  
    CSEG ENDS
END start