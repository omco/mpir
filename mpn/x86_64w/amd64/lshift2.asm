
;  Copyright 2009 Jason Moxham
;
;  Windows Conversion Copyright 2008 Brian Gladman
;
;  This file is part of the MPIR Library.
;
;  The MPIR Library is free software; you can redistribute it and/or modify
;  it under the terms of the GNU Lesser General Public License as published
;  by the Free Software Foundation; either version 2.1 of the License, or (at
;  your option) any later version.

;  The MPIR Library is distributed in the hope that it will be useful, but
;  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
;  License for more details.

;  You should have received a copy of the GNU Lesser General Public License
;  along with the MPIR Library; see the file COPYING.LIB.  If not, write
;  to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;  Boston, MA 02110-1301, USA.
;
;  mp_limb_t mpn_lshift1(mp_ptr, mp_ptr, mp_size_t)
;  rax                      rdi     rsi        rdx
;  rax                      rcx     rdx        r8d

%include "..\yasm_mac.inc"

%define reg_save_list rsi, rdi

    CPU  Athlon64
    BITS 64

    FRAME_PROC mpn_lshift2, 0, reg_save_list
    movsxd  rax, r8d
	lea     rsi, [rdx+rax*8-24]
	lea     rdi, [rcx+rax*8-24]
	mov     ecx, 3
	sub     rcx, rax
	xor     eax, eax
	xor     edx, edx
	cmp     rcx, 0
	jge     L_skiplp
	xalign  16
L_lp:
	mov     r8, [rsi+rcx*8]
	mov     r9, [rsi+rcx*8+8]
	mov     r10, [rsi+rcx*8+16]
	mov     r11, [rsi+rcx*8+24]
	add     rax, rax
	adc     r8, r8
	adc     r9, r9
	adc     r10, r10
	adc     r11, r11
	sbb     rax, rax
	add     rdx, rdx
	adc     r8, r8
	adc     r9, r9
	adc     r10, r10
	adc     r11, r11
	mov     [rdi+rcx*8+24], r11
	sbb     rdx, rdx
	mov     [rdi+rcx*8], r8
	add     rcx, 4
	mov     [rdi+rcx*8-24], r9
	mov     [rdi+rcx*8-16], r10
	jnc     L_lp
L_skiplp:
	cmp     rcx, 2
	ja      L_xit
	je      L_case1
	jp      L_case2
L_case3:
	mov     r8, [rsi+rcx*8]
	mov     r9, [rsi+rcx*8+8]
	mov     r10, [rsi+rcx*8+16]
	add     rax, rax
	adc     r8, r8
	adc     r9, r9
	adc     r10, r10
	sbb     rax, rax
	add     rdx, rdx
	adc     r8, r8
	adc     r9, r9
	adc     r10, r10
	sbb     rdx, rdx
	mov     [rdi+rcx*8], r8
	mov     [rdi+rcx*8+8], r9
	mov     [rdi+rcx*8+16], r10
	jmp     L_xit
	xalign  16
L_case2:
	mov     r8, [rsi+rcx*8]
	mov     r9, [rsi+rcx*8+8]
	add     rax, rax
	adc     r8, r8
	adc     r9, r9
	sbb     rax, rax
	add     rdx, rdx
	adc     r8, r8
	adc     r9, r9
	sbb     rdx, rdx
	mov     [rdi+rcx*8], r8
	mov     [rdi+rcx*8+8], r9
	jmp     L_xit
	xalign  16
L_case1:
	mov     r8, [rsi+rcx*8]
	add     rax, rax
	adc     r8, r8
	sbb     rax, rax
	add     rdx, rdx
	adc     r8, r8
	sbb     rdx, rdx
	mov     [rdi+rcx*8], r8
L_xit:
	lea     rax, [rdx+rax*2]
	neg     rax
    END_PROC reg_save_list

    end
