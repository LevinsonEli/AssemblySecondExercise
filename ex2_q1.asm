
; Eliyahu Levinson
; This program gets a symbol and a number from user
; And prints a triangle of inputed number's height
; For example for input * and 3 the output will be
;   *
;  ***
; *****
;

INCLUDE Irvine32.inc

.data
	header BYTE "Eliyahu Levinson: Ex2-Q1", 13, 10, 0
	rqst_char BYTE "Please Enter a character: ", 0
	rqst_size BYTE "Please Enter the triangle size: ", 0
	incorrectInputMsg BYTE "The number must be positive. ", 13, 10, 0

	indexOuterLoop DWORD 0		; Index of outer loop
	curNumOfSpaces DWORD 0		; Current number of spaces each side from symbols to print
	curNumOfSymbols DWORD 0		; Current number of symbols to print 
	symbol BYTE 0				; The inputed symbol
.code
main PROC
	mov edx, OFFSET header
	call writeString

	
	mov edx, OFFSET rqst_char	; Request to enter a symbol
	call writeString
	call readChar				; The symbol goes to $al
	call writeChar
	call CRLF
	mov symbol, al				; Storing the symbol in memory

	mov edx, OFFSET rqst_size	; Request to enter a number
	call writeString
	call readDec
	cmp eax, 0					; If inputed number is <= 0
	JBE incorrectInput			; Print error and exit
	mov ecx, eax				; Puting the number to $ecx to initialize a loop couter

	mov curNumOfSpaces, ecx		; Initialize number of spaces to print each size from the symbol

	mov curNumOfSymbols, 1		; Initialize number of symbols

printTriangle:
	mov indexOuterLoop, ecx			; Storing the index in memory

	; Printing white spaces
	mov ecx, curNumOfSpaces
	mov al, ' '
	printWhiteSpacesBeforeSymbol:
		call writeChar
		loop printWhiteSpacesBeforeSymbol
	
	; Printing symbols
	mov ecx, curNumOfSymbols
	mov al, symbol
	printSymbols:
		call writeChar
		loop printSymbols

	; Printing white spaces
	mov ecx, curNumOfSpaces
	mov al, ' '
	printWhiteSpacesAfterSymbol:
		call writeChar
		loop printWhiteSpacesAfterSymbol
	call CRLF
	 
	dec curNumOfSpaces				; Updating number of spaces for the next line
	add curNumOfSymbols, 2			; Updating number of symbols for the next line
	mov ecx, indexOuterLoop			; Getting index of outer loop from memory
	loop printTriangle
	JMP exitProgram

incorrectInput:						; Printing error: "The number must be posotive. "
	mov edx, OFFSET incorrectInputMsg
	call writeString
exitProgram:

	exit
main ENDP
END main