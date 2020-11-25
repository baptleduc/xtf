# Architecture specific configuration for x86

ARCH_PATH := $(ROOT)/arch/x86

PV_ENVIRONMENTS    := $(filter pv%,$(ALL_ENVIRONMENTS))
HVM_ENVIRONMENTS   := $(filter hvm%,$(ALL_ENVIRONMENTS))
32BIT_ENVIRONMENTS := $(filter pv32% hvm32%,$(ALL_ENVIRONMENTS))
64BIT_ENVIRONMENTS := $(filter pv64% hvm64%,$(ALL_ENVIRONMENTS))

# $(env)_guest => pv or hvm mapping
$(foreach env,$(PV_ENVIRONMENTS),$(eval $(env)_guest := pv))
$(foreach env,$(HVM_ENVIRONMENTS),$(eval $(env)_guest := hvm))

# $(env)_arch => x86_32/64 mapping
$(foreach env,$(32BIT_ENVIRONMENTS),$(eval $(env)_arch := x86_32))
$(foreach env,$(64BIT_ENVIRONMENTS),$(eval $(env)_arch := x86_64))

# Default guest configfiles
defcfg-pv    := $(ROOT)/config/default-pv.cfg.in
defcfg-hvm   := $(ROOT)/config/default-hvm.cfg.in

COMMON_AFLAGS += -I$(ARCH_PATH)/include
COMMON_CFLAGS += -I$(ARCH_PATH)/include
COMMON_CFLAGS += -mno-red-zone -mno-sse

COMMON_AFLAGS-x86_32 := -m32
COMMON_AFLAGS-x86_64 := -m64
COMMON_CFLAGS-x86_32 := -m32 -mregparm=3
COMMON_CFLAGS-x86_64 := -m64

hvm64-format := $(firstword $(filter elf32-x86-64,$(shell $(OBJCOPY) --help)) elf32-i386)

# Compilation recipe for hvm64
# hvm64 needs linking normally, then converting to elf32-x86-64 or elf32-i386
define build-hvm64
	$(LD) $$(LDFLAGS_hvm64) $$(DEPS-hvm64) -o $$@.tmp
	$(OBJCOPY) $$@.tmp -O $(hvm64-format) $$@
	rm -f $$@.tmp
endef
