/**
 * @file tests/stubriscv/main.c
 * @ref test-stubriscv - Minimal RISC-V stub.
 *
 * @page test-stubriscv RISC-V stub
 *
 * Print a message and the test result through the legacy SBI console putchar
 * extension, without any hypercall.
 *
 * @see tests/stubriscv/main.c
 */

#define SBI_EXT_0_1_CONSOLE_PUTCHAR 1

const char test_title[] = "Hello from XTF guest\n";

static void sbi_putchar(char c)
{
    register unsigned long a0 asm ("a0") = c;
    register unsigned long a7 asm ("a7") = SBI_EXT_0_1_CONSOLE_PUTCHAR;

    asm volatile ("ecall" : "+r" (a0) : "r" (a7) : "memory");
}

static void sbi_puts(const char *s)
{
    for ( ; *s; s++ )
        sbi_putchar(*s);
}

void test_main(void)
{
    sbi_puts(test_title);
    sbi_puts("Test result: SUCCESS\n");
}

/*
 * Local variables:
 * mode: C
 * c-file-style: "BSD"
 * c-basic-offset: 4
 * tab-width: 4
 * indent-tabs-mode: nil
 * End:
 */
