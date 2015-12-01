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
    CLD    ; Clear flag
    LEA SI,buff
    LEA DI,string  
    REP MOVSB
ENDM
              
searchCharString MACRO string,findChar,result
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
    MOV BX,0
    copyloop:
        CMP string1[bx],'$'
        JE exit
        MOV DL,string1[bx]  ;DL like a temp value to copy string2[bx],string1[bx]
        MOV string2[bx],DL
        INC BX
        JMP copyloop
    exit:

ENDM  

lengthString MACRO string,length
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
       replaceString:     
           MOV CX,0
           replaceLoop:
               INC CX 
               MOV BX,CX
               CMP string2[BX],'$'
               JE searchLoop
               MOV DH,stringReplace[BX]
               MOV BX,temp
               ADD BX,CX
               MOV string1[BX],DL 
               JMP replaceString
              
    exit:           ;Exit end of MACRO   
ENDM     

DSEG SEGMENT 
    msgString1CMP DB "String1 bigger than String2 $"
    msgString2CMP DB "String2 bigger than String1 $"
    msgStringEqualCMP DB "String1 like the same String2 $"
    msgString1Longer DB "String1 longer than String2 $"
    msgString2Longer DB "String2 longer than String1 $"
    msgStringEqualLonger DB "String 1 and String 2 have the same length $"
    msgInput DB "Input your string: $"
    msgOutput DB "The result is: $"   
    stringReplay DB 30 DUP('$')
    result DB 30 DUP('$') 
    div10 DB 10
    findChar DB 'e'     
    wordReplace DB 'u'
    temp DW 0  
    temp1 DW 0    
    temp2 DW 0 
    length1 DW ?
    length2 DW ?
    charTemp DB 0
    lengthex1 DW 0
    enterLine DB 10,13,'$'
    string1 DB 30 DUP('$') 
    string2 DB 30 DUP('$')
        max DB 30
        length DB ?
        buff DB 31 DUP(?) 
        
DSEG ENDS

CSEG SEGMENT
    ASSUME CS:CSEG, DS:DSEG
    
start:
    MOV AX,DSEG
    MOV DS,AX
    MOV ES,AX     
    
    MOV DL,0
    OR DL,0
    outputString msgInput  
    inputString max  
    fixString string1 
    
    outputString enterLine  
    outputString msgInput        
    inputString max  
    fixString string2    
    
    outputString enterLine
    outputString msgOutput
    
    
    ;reverseString string1,string2   
    ;copyString string1, string2
    ;outputString string2  
    
    
    
    ;lengthString string1, lengthStr  
    ;reverseString lengthStr,lengthStr
    ;outputString lengthStr     
    
    
    ;upperString string1
    ;outputString string1
    
    
    ;lowerString string1
    ;outputString string1
     
     
    ;catString string1 string2
    ;outputString string1
    
    ;compareLengthString string1,string2
    
    ;compareString string1,string2
    
    ;searchCharString string1,findChar,result
    ;outputString result
    searchStringinString string1,string2,result   
    reverseString result,result
    outputString result 
     
    ;repaceWord string1,findChar,wordReplace      
    ;outputString string1
    
    replaceString string1,string2,stringReplace
        
    ;MOV AX,6
    ;DIV div10
    
    
    
    
    
    MOV AH,4CH
    INT 21h
    
  
    CSEG ENDS
END start