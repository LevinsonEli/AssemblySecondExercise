
; Eliyahu Levinson
; This program gets a string from the user and makes from it a new string so:
; The new string contains only upperCase letters from the inputed string
; And also all the lowerCase letters of it changed to uperCase

INCLUDE Irvine32.inc

.data
	studentData BYTE "Eliyahu Levinson: Ex2-Q3", 13, 10, 0
	getStringMsg BYTE "Enter a string: ", 0
	beforeOutputMsg BYTE "After processing the string is: ", 13, 10, 0

	N = 80								; The length of string
	inputString BYTE N DUP (?) 
	outputString BYTE N DUP (?) 
	stringLength BYTE N

.code
main PROC
	mov edx, OFFSET studentData
	call writeString

	mov edx, OFFSET getStringMsg		; Printing "Enter a string: "
	call writeString

	movzx ecx, stringLength				; Getting a string from the user
	mov edx, OFFSET inputString
	call readString

	mov esi, OFFSET inputString			; Initializing adresses of input and output strings
	mov edi, OFFSET outputString

	movzx ecx, stringLength				; Initializing $ecx for loop
makeStringAplphabetUpperCase:
	cmp BYTE PTR [esi], 'A'				; If the symbol < 'A'
	JL nextIteration					; Go to next symbol
	
	cmp BYTE PTR [esi], 'z'				; If the symbol > 'z'
	JG nextIteration					; Go to next symbol

	cmp BYTE PTR [esi], 'Z'				; If the symbol is upper case letter
	JLE copyToOutputString				; Copy it and go next

	cmp BYTE PTR [esi], 'a'				; If the symbol > 'Z' and < 'a'
	JL nextIteration					; Go to next symbol

	sub BYTE PTR [esi], 32				; Capitalizing the letter

	copyToOutputString:					; Coppying to the output string
		mov al, [esi]
		mov BYTE PTR [edi], al
		inc edi							; Updating the output string pointer

	nextIteration:
		inc esi							; Updating the input string pointer
		loop makeStringAplphabetUpperCase
	mov BYTE PTR [edi], 0				; Setting the end of output string

	mov edx, OFFSET beforeOutputMsg		; Printing output
	call writeString
	mov edx, OFFSET outputString
	call writeString
	call CRLF

	exit
main ENDP
END main