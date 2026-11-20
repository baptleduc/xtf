# Architecture specific configuration for riscv

ARCH_PATH := $(ROOT)/arch/riscv

# Xen only runs RV64 guests for now.
ARCH_ENVS := riscv64

# $(env)_guest => guest type, used to select the default config file.
# RISC-V has no pv/hvm distinction, so all environments share one guest type.
riscv64_guest := riscv

# $(env)_arch mapping
riscv64_arch := riscv64

# Default guest configfile
defcfg-riscv := $(ROOT)/config/default-riscv.cfg.in

# Pin the ISA and ABI rather than inheriting the toolchain default, which is
# usually rv64gc/lp64d.  The guest never enables the FPU, so no F/D.
COMMON_AFLAGS += -I$(ARCH_PATH)/include -march=rv64imac -mabi=lp64
COMMON_CFLAGS += -I$(ARCH_PATH)/include -march=rv64imac -mabi=lp64

# ld.lld before LLVM 15 has no RISC-V linker relaxation, and rejects the
# R_RISCV_ALIGN relocations emitted when it is enabled.
COMMON_AFLAGS += -mno-relax
COMMON_CFLAGS += -mno-relax

# XTF_VIRT_START is above 2G, out of reach of the default medlow model.
COMMON_CFLAGS += -mcmodel=medany

# Compilation recipe for riscv64
# riscv64 needs linking normally, then converting to a binary format
define build-riscv64
	$(LD) $$(LDFLAGS_riscv64) $$(DEPS-riscv64) -o $$@-syms
	$(OBJCOPY) $$@-syms -O binary $$@
endef
