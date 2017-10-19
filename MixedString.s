;To take two strings, and mix them together, and store as a mixed string.
;Joseph Medinas

MAX_LEN	EQU		100
	
;Code area
		AREA     MixedString, CODE, READONLY
        ENTRY                   
		EXPORT	main
			
main
	LDR R1, =str1
	LDR R2, =str2
	LDR	R7, =mixStr
loop	LDRB	R3, [R1], #1
		CBZ	R3, DoneStrOne
		STRB R3, [R7], #1
		LDRB	R3, [R2], #1
		CBZ R3, DoneStrTwo
		STRB R3, [R7], #1
		B loop
DoneStrOne
loop2
	LDRB	R3, [R2],#1
	CBZ R3, DONE
	B loop2
	
DoneStrTwo
loop3
	LDRB	R3,[R1],#1
	CBZ R3, DONE
	B loop3
	
DONE
	STRB R3, [R7]
	
stop
        MOV      r0, #0x18; angel_SWIreason_ReportException
        LDR      r1, =0x20026; ADP_Stopped_ApplicationExit
		SVC		#0x11; previously SWI
		;BKPT #0xAB for semihosting isn't supported in Keil's uV

		ALIGN

;Data area
        AREA     StrData, DATA, READWRITE
		EXPORT	adrStr1
		EXPORT	adrStr2
		EXPORT	adrMixStr
			
adrStr1	DCD		str1
adrStr2	DCD		str2
adrMixStr	DCD	mixStr
	
str1	DCB		"Metro State!", 0
		ALIGN
str2	DCB		"This is cool", 0
		ALIGN
mixStr	SPACE	MAX_LEN
		END