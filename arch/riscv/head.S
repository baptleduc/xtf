#include <arch/page.h>

        .section ".text.head", "ax", %progbits

.globl _elf_start
_elf_start:
        /* sp = &boot_stack[PAGE_SIZE] */
        la      sp, boot_stack
        li      t0, PAGE_SIZE
        add     sp, sp, t0

        call    test_main

1:      j       1b

        .type   _elf_start, %function
        .size   _elf_start, . - _elf_start

        .section ".bss.page_aligned", "aw", %nobits
        .balign PAGE_SIZE
.globl boot_stack
boot_stack:
        .skip   PAGE_SIZE

        .type   boot_stack, %object
        .size   boot_stack, . - boot_stack

/*
 * Local variables:
 * tab-width: 8
 * indent-tabs-mode: nil
 * End:
 */
