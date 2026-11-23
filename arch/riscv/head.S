#include <arch/config.h>
#include <arch/page.h>

        .section ".text.head", "ax", %progbits

/*
 * Linux RISC-V Image header (Documentation/arch/riscv/boot-image-header.rst),
 * which Xen requires to load a domain kernel.
 */
.globl _elf_start
_elf_start:
        j       entry                   /* code0 */
        .word   0                       /* code1 */
        .balign 8
        .dword  0                       /* text_offset */
        .dword  __image_size            /* image_size */
        .dword  0                       /* flags */
        .word   RISCV_HEADER_VERSION
        .word   0                       /* reserved 1 */
        .dword  0                       /* reserved 2 */
        .ascii RISCV_IMAGE_MAGIC
        .balign 4
        .ascii RISCV_IMAGE_MAGIC2
        .word   0                       /* reserved 3 */

entry:
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
