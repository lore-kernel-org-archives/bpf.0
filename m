Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A213E7BCF
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693337; cv=none; b=kak2HQMPVNJq+OLQnkJY9CGVfcxOxeXILHhHvY73qiXYpjKrzZFhu6VG3PLETohhNbsjxQiBmZxU8xpdojfFa9ew9bt3pBdM4bkxF36aNOdGIYc7pe+1h6VDpZe0aToELvtY2Hhjo1Fk89HQxOZv+SxOwTq1rCmur76oJOmE71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693337; c=relaxed/simple;
	bh=hWv0bjZKIELmwlYZPcfKTvRyPlWwTeyZtcbimNOdRzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDSNTwpr+DamKgppMleJF4EpueNIIHA7sw7la9kt1nvTqB81BWL36z2fG3XG4mp689Mwh3IZ9IvMKS4WgbqIIKyLUWjW2wWuG+ilJoPcXdvUZlFzNQDA2Ys2TjZdnpek4GJkUGLfToSE2AqO0JDARW7ZwI0+DCXk/QMeKQju8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3gr8GCn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3gr8GCn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccf2360620so80938725ad.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 21:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784693334; x=1785298134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFkuvTRXbrG1uJW0biVmye0d9NG456RSYQYg5DIf/AI=;
        b=q3gr8GCn07UHVQBMlRbAvDPMCWubElC6QFUYI3YDVsl03un4YRKlwSsmWfcBkaoK2K
         nkLsg3W2yAP3zNwER6I73S13fpz0ONuKX1YN8iWVZT7swV5wZCXkvyZA6Gb/xis6cwWG
         RF3xgM3kXo2NFWeVYm5ZYug8M9rk5kry+b8QaV6BZE1KADKTG1VXCtCsemza2pRMc6ZD
         HAnzgYrrCZvBeIdYW0Q4K5YgFJeB/xLswY97x8eigfy3yQUNeLrDVW4v2DLyWOvXQRGu
         p/lvQSg8qURLg96jHZo6CuIivj6P6lUHmbv1HPReUvTidEPQzDIGILyZSr3hS0wkg5Ha
         oWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784693334; x=1785298134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFkuvTRXbrG1uJW0biVmye0d9NG456RSYQYg5DIf/AI=;
        b=VZ79TyawR3CN2SDSwKYapPgQvrROxYsUVwCFtzeX91HUFAOI2gSsX/wjKOxYMcFtMC
         z6L57QZDbmDCd323fs1tBzRhz3U6Y2QNWVSHoORp9GuQiNZIxV+IrVenhODp812cBL9R
         98koL+Prb4T3hHt14Eg17wD1A8QIU2m4Q7HfezDRpXWwZ4BwXLrR2HcfzKPZ1CBSh/QR
         RFkJ3UOzs7jIIP2W5B8iDZ47qSrj+ls/+wl3npQ33mzNciWabtB2AD9jgYojTDN4OVPe
         JxLtdaFO5aWDZqlqmQlFfG8RfjGakN7a2MmVENXOMQuryV8kFBWMzgtAkeQs19OqGbEm
         u16g==
X-Gm-Message-State: AOJu0YwETc/eWWj66NJNXF9mpHNO3KtNNmBgDyoY6nM0LGfEDqURf7Fx
	fZGIhR5hrEbOn2f/CmhThBT68/Wg7S/oRNc+/iRy1thYpx2ZCpAAu03fvTzkqv0l
X-Gm-Gg: AR+sD10Gieg3xxFEn3g90+pk8eeF9IyhkUqyIeDgy63o5/v/RUiPCL4Ayd5Lro0+mU0
	4bvQVbsXdZEirtriEYkmjeo3QmT2L3/7x7ttkgHuUzfxAcRCWDNdIsAJGCTi39b8b6bmnK4+C+2
	hsf773JAi4KNbbgpXXgzfuJIPRh23Ufscof/WA9C1OWd8k/0cwn8ZIULRP4kJG4lVVc9NjKA7Hg
	I3Lj29wR4MqP0Tg/kcxUHyJ8CbEHFT/ZNAoxReEH8tBTwn+RCvOYdTG5NC8h6twr6C+lqOMZZcx
	WCt1UD2K94xRbhWFjxrtubkukot4JE7G8fx61s9pVKgEJh+6ddmo22QYrZk5ZyLUo8nKtQpavsZ
	a1sPUVZo2ZO6fAWY7VkBVK5GubJ07oGGSbTDLVEYw4e3nvOpX1zD6lp9bcl2km9ewkMjMKlqT8I
	7C/f/iwdcB0Te9pJ82F4Osq/kf1uiuuGH9TCc=
X-Received: by 2002:a17:903:946:b0:2cf:6f7f:55d8 with SMTP id d9443c01a7336-2cf6f7f6a7cmr105857315ad.37.1784693334421;
        Tue, 21 Jul 2026 21:08:54 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e987asm6843235ad.51.2026.07.21.21.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:08:53 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [RFC PATCH bpf-next v3 2/3] selftests/bpf: move shared build definitions into Makefile.buildvars
Date: Tue, 21 Jul 2026 21:08:29 -0700
Message-ID: <20260722040830.387979-3-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the toolchain, path, flag, probe and knob definitions that are not
rules into Makefile.buildvars: output-tree layout, libbpf/bpftool binary
locations, BPF_CFLAGS/COMMON_CFLAGS assembly, libelf/libpcap probes,
endianness and clang feature detection, the vmlinux BTF search list,
signing key paths, permissive-mode knob and the libarena skeleton names.

This is preparation for building each test runner instance in its own
sub-make: the definitions become includable by more than one makefile.
No rules or recipes are changed. One deliberate nuance: the include
sits after ../lib.mk, so CFLAGS is now assembled by *prepending*
COMMON_CFLAGS (keeping the include-search order identical to before,
where the definitions preceded lib.mk's additions).

Build artifacts are byte-identical before and after this change.

BPF_GCC and TEST_KMODS stay defined only in the main Makefile - they
are needed there before lib.mk is included, where Makefile.buildvars
cannot yet be - and are exported so the runner sub-makes' buildvars
include receives them from the environment instead of keeping a
second copy that could silently drift.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 169 +---------------
 .../testing/selftests/bpf/Makefile.buildvars  | 191 ++++++++++++++++++
 2 files changed, 202 insertions(+), 158 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 09e5be201..ce589f102 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -3,93 +3,28 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-CXX ?= $(CROSS_COMPILE)g++
-OBJCOPY ?= $(CROSS_COMPILE)objcopy
-
-CURDIR := $(abspath .)
-TOOLSDIR := $(abspath ../../..)
-LIBDIR := $(TOOLSDIR)/lib
-BPFDIR := $(LIBDIR)/bpf
-TOOLSINCDIR := $(TOOLSDIR)/include
-TOOLSARCHINCDIR := $(TOOLSDIR)/arch/$(SRCARCH)/include
-BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
-APIDIR := $(TOOLSINCDIR)/uapi
-ifneq ($(O),)
-GENDIR := $(O)/include/generated
-else
-GENDIR := $(abspath ../../../../include/generated)
-endif
-GENHDR := $(GENDIR)/autoconf.h
-PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
-ifneq ($(wildcard $(GENHDR)),)
-  GENFLAGS := -DHAVE_GENHDR
+# BPF_GCC and TEST_KMODS are needed before lib.mk is included (they gate
+# the flavor list and TEST_GEN_FILES), while Makefile.buildvars can only
+# be included after it, so they are defined here - once - and exported
+# for the runner sub-makes, whose Makefile.buildvars include picks them
+# up from the environment.
+ifeq ($(origin BPF_GCC),undefined)
+BPF_GCC := $(shell command -v bpf-gcc;)
 endif
+export BPF_GCC TEST_KMODS
 
-BPF_GCC		?= $(shell command -v bpf-gcc;)
-ifdef ASAN
-SAN_CFLAGS 	?= -fsanitize=address -fno-omit-frame-pointer
-else
-SAN_CFLAGS	?=
-endif
-SAN_LDFLAGS	?= $(SAN_CFLAGS)
-RELEASE		?=
-OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
-
-LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
-LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
-
-SKIP_DOCS	?=
-SKIP_LLVM	?=
-SKIP_LIBBFD	?=
-SKIP_CRYPTO	?=
-
-# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
-# benchmark compilation failure is fatal. Set to 0 to tolerate failures
-# and continue building the remaining tests.
-BPF_STRICT_BUILD ?= 1
-PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
-
-ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-endif
 
-COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
-	  -Wall -Werror -fno-omit-frame-pointer				\
-	  -Wno-unused-but-set-variable					\
-	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
-	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)	\
-	  -I$(CURDIR)/libarena/include
-LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
-
-PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
-PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
-LDLIBS += $(PCAP_LIBS)
-CFLAGS += $(COMMON_CFLAGS) $(PCAP_CFLAGS)
 
 # Some utility functions use LLVM libraries
 jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
 
-ifneq ($(LLVM),)
-# Silence some warnings when compiled with clang
-CFLAGS += -Wno-unused-command-line-argument
-endif
 
 # Check whether bpf cpu=v4 is supported or not by clang
 ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
 CLANG_CPUV4 := 1
 endif
 
-# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
-CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
-	$(CLANG) --target=bpf -fsanitize=kernel-address \
-	-mllvm -asan-shadow-addr-space=1 \
-	-x c -c - -o /dev/null 2>/dev/null && echo 1)
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
@@ -132,9 +67,8 @@ TEST_PROGS := test_kmod.sh \
 TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh
 
-TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+TEST_KMODS ?= bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
 	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
-TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
@@ -150,9 +84,6 @@ TEST_GEN_PROGS_EXTENDED = \
 
 TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
 
-ifneq ($(V),1)
-submake_extras := feature_display=0
-endif
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
@@ -188,6 +119,8 @@ override OUTPUT := $(patsubst %/,%,$(OUTPUT))
 endif
 endif
 
+include Makefile.buildvars
+
 ifneq ($(SKIP_LLVM),1)
 ifeq ($(feature-llvm),1)
   LLVM_CFLAGS  += -DHAVE_LLVM_SUPPORT
@@ -213,30 +146,6 @@ ifeq ($(feature-llvm),1)
 endif
 endif
 
-SCRATCH_DIR := $(OUTPUT)/tools
-BUILD_DIR := $(SCRATCH_DIR)/build
-INCLUDE_DIR := $(SCRATCH_DIR)/include
-BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
-ifneq ($(CROSS_COMPILE),)
-HOST_BUILD_DIR		:= $(BUILD_DIR)/host
-HOST_SCRATCH_DIR	:= $(OUTPUT)/host-tools
-HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
-else
-HOST_BUILD_DIR		:= $(BUILD_DIR)
-HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
-HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
-endif
-HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
-RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
-		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
-		     ../../../../vmlinux				\
-		     /sys/kernel/btf/vmlinux				\
-		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
-ifeq ($(VMLINUX_BTF),)
-$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
-endif
 
 # Define simple and short `make test_progs`, `make test_maps`, etc targets
 # to build individual tests.
@@ -314,15 +223,6 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
 	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/$(@F) $@$(if $(PERMISSIVE),; fi)
 
 
-DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
-ifneq ($(CROSS_COMPILE),)
-CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
-TRUNNER_BPFTOOL := $(CROSS_BPFTOOL)
-USE_BOOTSTRAP := ""
-else
-TRUNNER_BPFTOOL := $(DEFAULT_BPFTOOL)
-USE_BOOTSTRAP := "bootstrap/"
-endif
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
@@ -344,7 +244,6 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
@@ -437,45 +336,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		HOSTPKG_CONFIG='$(PKG_CONFIG)' \
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
-# Get Clang's default includes on this system, as opposed to those seen by
-# '--target=bpf'. This fixes "missing" files on some architectures/distros,
-# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
-#
-# Use '-idirafter': Don't interfere with include mechanics except where the
-# build would have failed anyways.
-define get_sys_includes
-$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
-	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=%s ", $$2, $$3)}')
-endef
-
-# Determine target endianness.
-IS_LITTLE_ENDIAN := $(shell $(CC) -dM -E - </dev/null | \
-			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
-MENDIAN:=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
-BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
-
-ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif
-
-CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
-	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
-	     -I$(CURDIR)/libarena/include				\
-	     -I$(abspath $(OUTPUT)/../usr/include)			\
-	     -std=gnu11		 					\
-	     -fno-strict-aliasing 					\
-	     -Wno-microsoft-anon-tag					\
-	     -fms-extensions						\
-	     -Wno-compare-distinct-pointer-types			\
-	     -Wno-initializer-overrides					\
-	     #
-# TODO: enable me -Wsign-compare
-
-CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
@@ -756,10 +616,6 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$
 
 endef
 
-VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
-VERIFY_SIG_HDR := verification_cert.h
-VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
-PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
 $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
@@ -790,14 +646,11 @@ LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
 				 libarena/selftests/*		\
 				 libarena/*.bpf.o)
 
-LIBARENA_SKEL := libarena/libarena.skel.h
 
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
 
 ifneq ($(CLANG_HAS_ARENA_ASAN),)
-LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
-CFLAGS += -DHAS_BPF_ARENA_ASAN
 
 $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
new file mode 100644
index 000000000..7b468ddf8
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared toolchain, path and flag definitions for the BPF selftests build.
+# Included by both Makefile (the top level) and Makefile.runner (one
+# test-runner instance).
+#
+# Requirements at include time:
+#   - $(OUTPUT) is set to an absolute path
+#   - tools/build/Build.include, tools/scripts/Makefile.arch and
+#     tools/scripts/Makefile.include have been included (for SRCARCH etc.)
+
+CXX ?= $(CROSS_COMPILE)g++
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+
+TOOLSDIR := $(abspath ../../..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+TOOLSARCHINCDIR := $(TOOLSDIR)/arch/$(SRCARCH)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+ifneq ($(O),)
+GENDIR := $(O)/include/generated
+else
+GENDIR := $(abspath ../../../../include/generated)
+endif
+GENHDR := $(GENDIR)/autoconf.h
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+ifeq ($(srctree),)
+srctree := $(abspath ../../../..)
+endif
+
+ifdef ASAN
+SAN_CFLAGS	?= -fsanitize=address -fno-omit-frame-pointer
+else
+SAN_CFLAGS	?=
+endif
+SAN_LDFLAGS	?= $(SAN_CFLAGS)
+RELEASE		?=
+OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
+
+LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
+SKIP_DOCS	?=
+SKIP_LLVM	?=
+SKIP_LIBBFD	?=
+SKIP_CRYPTO	?=
+
+# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
+# benchmark compilation failure is fatal. Set to 0 to tolerate failures
+# and continue building the remaining tests.
+BPF_STRICT_BUILD ?= 1
+PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
+
+# BPF_GCC and TEST_KMODS are defined once in the main Makefile (they
+# are needed there before lib.mk) and arrive here via the environment;
+# TEST_KMODS= on the command line disables the modules.
+TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
+
+# Output-tree layout. Defined before COMMON_CFLAGS on purpose: CFLAGS
+# below is expanded immediately and references $(INCLUDE_DIR).
+SCRATCH_DIR := $(OUTPUT)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+INCLUDE_DIR := $(SCRATCH_DIR)/include
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(BUILD_DIR)/host
+HOST_SCRATCH_DIR	:= $(OUTPUT)/host-tools
+HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
+else
+HOST_BUILD_DIR		:= $(BUILD_DIR)
+HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
+HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+
+DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
+ifneq ($(CROSS_COMPILE),)
+CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
+TRUNNER_BPFTOOL := $(CROSS_BPFTOOL)
+USE_BOOTSTRAP :=
+else
+TRUNNER_BPFTOOL := $(DEFAULT_BPFTOOL)
+USE_BOOTSTRAP := bootstrap/
+endif
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11			\
+	  -Wall -Werror -fno-omit-frame-pointer				\
+	  -Wno-unused-but-set-variable					\
+	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
+	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
+	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)	\
+	  -I$(CURDIR)/libarena/include
+LDFLAGS += $(SAN_LDFLAGS)
+LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
+
+PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
+LDLIBS += $(PCAP_LIBS)
+# Prepend rather than append: the include-search order must stay
+# "$(COMMON_CFLAGS) first, lib.mk additions after" regardless of whether
+# lib.mk was included before this file (top level) or not at all (runner).
+CFLAGS := $(COMMON_CFLAGS) $(PCAP_CFLAGS) $(CFLAGS)
+
+ifneq ($(LLVM),)
+# Silence some warnings when compiled with clang
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
+CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
+	$(CLANG) --target=bpf -fsanitize=kernel-address \
+	-mllvm -asan-shadow-addr-space=1 \
+	-x c -c - -o /dev/null 2>/dev/null && echo 1)
+ifneq ($(CLANG_HAS_ARENA_ASAN),)
+CFLAGS += -DHAS_BPF_ARENA_ASAN
+endif
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../../../vmlinux				\
+		     /sys/kernel/btf/vmlinux				\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=%s ", $$2, $$3)}')
+endef
+
+# Determine target endianness.
+IS_LITTLE_ENDIAN := $(shell $(CC) -dM -E - </dev/null | \
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+MENDIAN := $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN := $(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+CLANG_SYS_INCLUDES := $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
+	     -I$(CURDIR)/libarena/include				\
+	     -I$(abspath $(OUTPUT)/../usr/include)			\
+	     -std=gnu11		 					\
+	     -fno-strict-aliasing 					\
+	     -Wno-microsoft-anon-tag					\
+	     -fms-extensions						\
+	     -Wno-compare-distinct-pointer-types			\
+	     -Wno-initializer-overrides					\
+	     #
+# TODO: enable me -Wsign-compare
+
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
+
+# Signing key/cert shared by the signed light skeletons and test_progs.
+VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
+VERIFY_SIG_HDR := verification_cert.h
+VERIFICATION_CERT := $(BUILD_DIR)/signing_key.der
+PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
+
+# libarena skeletons, built by the libarena/ sub-make (driven by the top
+# level Makefile); test_progs and its flavors depend on the headers.
+LIBARENA_SKEL := libarena/libarena.skel.h
+ifneq ($(CLANG_HAS_ARENA_ASAN),)
+LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
+endif
+
+ifneq ($(V),1)
+submake_extras := feature_display=0
+endif
-- 
2.43.0

