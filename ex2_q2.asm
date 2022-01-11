
; Eliyahu Levinson 
; This program gets 3 arrays of numbers (Bvec (BYTE), Wvec (SWORD), Dvec (SDWORD))
; from the data file and counts the summ of their members to the fourth (SumVec) array
; and then prints it. (All 4 array are the same size).

INCLUDE Irvine32.inc
INCLUDE ex2_q2_data.inc

.data
	header BYTE "Eliyahu Levinson: Ex2-Q2", 13, 10, 0

.code
main PROC
	mov edx, OFFSET header
	call writeString

	mov esi, 0					; Initialize a counter for adresses
	mov ecx, lengthOf Bvec		; Initialize $ecx for loop
sumVectors:
	movzx eax, Bvec[esi]		; Get the first array member
	mov SumVec[esi*4], eax		; Move it to the SumVec's member
	movsx eax, Wvec[esi*2]		; Get the second array member
	add SumVec[esi*4], eax		; Count the summ	
	mov eax, Dvec[esi*4]		; Get the third array member
	add SumVec[esi*4], eax		; Count the summ

	inc esi						; Update the counter
	loop sumVectors

	mov edi, OFFSET SumVec		; Print the SumVec array
	mov ecx, lengthOf SumVec
	call Print_Dword_Arr

	exit
main ENDP
END main