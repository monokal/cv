; Thanks to the Docker guys as this is a blatent rip-off of their hello-world image!

BITS 64
    org 0x00400000  ; Program load offset

; 64-bit ELF header
ehdr:
    ;  1), 0 (ABI ver.)
    db 0x7F, "ELF", 2, 1, 1, 0       ; e_ident
    times 8 db 0                     ; reserved (zeroes)

    dw 2              ; e_type: Executable file
    dw 0x3e           ; e_machine:  AMD64
    dd 1              ; e_version:  current version
    dq _start         ; e_entry:    program entry address (0x78)
    dq phdr - $$      ; e_phoff program header offset (0x40)
    dq 0              ; e_shoff no section headers
    dd 0              ; e_flags no flags
    dw ehdrsize       ; e_ehsize:   ELF header size (0x40)
    dw phdrsize       ; e_phentsize:    program header size (0x38)
    dw 1              ; e_phnum:    one program header
    dw 0              ; e_shentsize
    dw 0              ; e_shnum
    dw 0              ; e_shstrndx

ehdrsize equ $ - ehdr

; 64-bit ELF program header
phdr:
    dd 1              ; p_type: loadable segment
    dd 5              ; p_flags read and execute
    dq 0              ; p_offset
    dq $$             ; p_vaddr:    start of the current section
    dq $$             ; p_paddr:    "       "
    dq filesize       ; p_filesz
    dq filesize       ; p_memsz
    dq 0x200000       ; p_align:    2^11=200000 = section alignment

; program header size
phdrsize equ $ - phdr

; Start of CV program
_start:

    ; sys_write(stdout, message, length)
    mov rax, 1           ; sys_write
    mov rdi, 1           ; stdout
    mov rsi, message     ; message address
    mov rdx, length      ; message string length
    syscall

    ; sys_exit(return_code)
    mov rax, 60          ; sys_exit
    mov rdi, 0           ; return 0 (success)
    syscall

    message:
        db 0x0A
        db "Hey! I'm Daniel,", 0x0A
        db 0x0A
        db "I'm a passionate and experienced open-source enthusiast with a focus", 0x0A
        db "on highly available, scalable full-stack deployment and management", 0x0A
        db "solutions, including next-generation platforms such as the Mesosphere,", 0x0A
        db "CoreOS, Docker and Kubernetes stacks. I pride myself on knowing what's", 0x0A
        db "around the corner and I am therefore able to offer and implement", 0x0A
        db "solutions which are a step ahead of the competition.", 0x0A
        db 0x0A
        db "If you were expecting my full CV in a 600 byte image, think again!", 0x0A
        db 0x0A
        db "You can get the rest via:", 0x0A
        db 0x0A
        db "    - LinkedIn: https://www.linkedin.com/in/ddmiddleton", 0x0A
        db "    - Email: d@monokal.io", 0x0A
        db 0x0A
        db "Thanks!", 0x0A
        db 0x0A
    length: equ $-message            ; message length calculation

; File size calculation
filesize equ $ - $$
