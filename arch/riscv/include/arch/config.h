#ifndef XTF_RISCV_CONFIG_H
#define XTF_RISCV_CONFIG_H

/* Xen loads RISC-V guests at the base of guest RAM (GUEST_RAM0_BASE). */
#define XTF_VIRT_START 0x80000000

#define RISCV_IMAGE_MAGIC  "RISCV\0\0\0"
#define RISCV_IMAGE_MAGIC2 "RSC\x05"

#define RISCV_HEADER_VERSION_MINOR 2
#define RISCV_HEADER_VERSION_MAJOR 0

#define RISCV_HEADER_VERSION (RISCV_HEADER_VERSION_MAJOR << 16 | \
                              RISCV_HEADER_VERSION_MINOR)

#endif /* XTF_RISCV_CONFIG_H */

/*
 * Local variables:
 * mode: C
 * c-file-style: "BSD"
 * c-basic-offset: 4
 * tab-width: 4
 * indent-tabs-mode: nil
 * End:
 */
