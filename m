Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EFB2FF65F
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867186; cv=none; b=b0DGmjMN0UG+JeShRIf7jZl0sUUsapRDN1emlxdh9SY5COMzZjpevKSPqGUhpk4WooFHxA/yIyMKQ15Dxz9RgxbbWVrviEoVdT0DNe22Y7dNongJYkouQ704jW/M5PYE5nTDNzYxgKT7plrdJiKUFpHIZtl1jEzQe4p5kU2Eyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867186; c=relaxed/simple;
	bh=nXjqYzAhLLLNfTl+JOpHqKf8EnqAimOdhS9pyAjZse8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No9KJaPlewnJtPL6oQ7hTnZZfB5NTw2+7h2kSITbpJN1rKTwP4Y0Ut7c8+rvKsmDz90N5KIROuLCSU8KAwbqN/QGWGplDTnQt7TQKdWgNdXMKDbwPLZSJ1kBORd92+nCbysHhIIVKQLiG8BXHF+LIDz14Omvll1Ob8yvayn8Z+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrJv5csG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrJv5csG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so548125ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784867184; x=1785471984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vnt1cW0/+YbKONYhyLzr1+xVPWPVLMkfYs5cZ1oGTk=;
        b=XrJv5csG6cUC4P7/SEZ+bXEp57wxjcSeFQxVHaSiE0TC1ESKw2btTMb+FMk3abrd/E
         r/omIcgPENILybnRXj6bUiPz6up0qUPiDupjw206BekH9BiZnTgvEI6ktGlPKVH/giRh
         b4Mt9skjMkp6ngFdjVWgg9sKahvvdLzVNV5DOH6IA4GSHpObDFiJrpXABj3ze3ohhAUK
         iM/H5O+0uXx9en9yCThmS44x3CJD0TlEYbFT9HG46VThe3sxTl0YOCWm7DZ4rQZnByxp
         I2MVjFqCwa/KbMtI8cnH78pC5/dsOfEvBwn4sq9fVo/nni72m21QfVVM2gN9uKIK42pY
         +zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784867184; x=1785471984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+vnt1cW0/+YbKONYhyLzr1+xVPWPVLMkfYs5cZ1oGTk=;
        b=EVxlUtFbk7WdWKZW/PqjNFghBgUtHpYRIft7WX8SQy7sHoOB54boTH5ta5kFf/6aoK
         uKgJIAAAihdjR3hpaZWgzRATahOrZkrEzex8ZJAsoK0YkP/6UCi2FdMstN8aHYBGQCUu
         ZdGGeuuLON9qfZZoSQ8l/L9p/fw+bilN1xi0KKr2lprxjZINYhDkuDoUlo4CUCMczeo7
         C9uWiFV26lcxi20P1gjtws9ZzzCoekBGAP78pdu+I+hQAsjRQwHy64ZQ852gPj4EYbds
         +TiEvuabjpr1O9HCi76UEZ5c/32738C3v/Nm4U80OZK044tqLSt44v8DkpHGOcm7tss9
         aC1w==
X-Gm-Message-State: AOJu0Yy7beOKxtSX/2GHCVXOnOmcoNtl1fHDaBElIrDaksPGS9xLqfYl
	HSv6+sZ/TMuiHRUyxuGovozT4uJXHEPvfycnWdqKAzhxhm1aM/SUEMT/oFRHfrGe
X-Gm-Gg: AR+sD10Wbck7jJtSRYqoACyOYlrwEXtrsnBtwu/9RDqtUUujDE8VBuvSVWthvHql6kw
	1DuTetMu2LNPB9LB0UfgQkOu0CyjV8Y9kxlvm0jBqQFMngWIQ5Bdts2kS4WLrayrmWgF1hj25k0
	81HStyQ3n6iXtSBrF81LNjJVOcNDeCXGQfl+9S7sJ+SG7Wmx49ec5Jovyp6xXxGlOasHkrCxFNk
	ppGwP4q5qPR3CeVfxrlTZBisWHBKwydy7J4OcmVYzqa9rWHo3cxrWgUpTKti3uHrjsyT+NFZ0tM
	wlEUxJe3OZ/lAN0YnXuZ7qYFNwQHevnru6GByzOALpy6+i2G6BXozh51uFxo+7OBsmCCQGwzKur
	dKZgpDdf6STE6hTTm5mAaCLSTIvIyxVau6JP04ALrNNTX7vaQeO2DaOm9wHErzkgHIvzpd5B4Pg
	IZ/OBReGgO47EACSrzC0OQFgDqAGPPOK4hXYCUZMPW/Sg=
X-Received: by 2002:a17:903:1210:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2cfa71d950emr68278705ad.14.1784867184033;
        Thu, 23 Jul 2026 21:26:24 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f0072a8sm44437015ad.34.2026.07.23.21.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 21:26:23 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v4 2/3] selftests/bpf: move shared build definitions into Makefile.buildvars
Date: Thu, 23 Jul 2026 21:25:59 -0700
Message-ID: <20260724042600.175440-3-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724042600.175440-1-nickolay.lysenko@gmail.com>
References: <20260724042600.175440-1-nickolay.lysenko@gmail.com>
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

Definitions keep the order they had in the Makefile; the only
exception is called out in a comment (CFLAGS is prepended rather than
appended, as this file is included after lib.mk). Knobs the runner
never reads (SKIP_*, submake_extras, VMLINUX_BTF, TEST_KMOD_TARGETS)
stay in the main Makefile.

BPF_GCC, TEST_KMODS and the VMLINUX_BTF block stay in the Makefile at
their current positions - the first two are needed before lib.mk is
included, where Makefile.buildvars cannot yet be, and none of them is
shared with the coming runner sub-makes except through the environment
(a later patch exports what the runners need).

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 146 +---------------
 .../testing/selftests/bpf/Makefile.buildvars  | 165 ++++++++++++++++++
 2 files changed, 171 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2ed953b84..1843679fc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -3,93 +3,29 @@ include ../../../build/Build.include
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
-
-ifneq ($(wildcard $(GENHDR)),)
-  GENFLAGS := -DHAVE_GENHDR
-endif
 
-BPF_GCC		?= $(shell command -v bpf-gcc;)
-ifdef ASAN
-SAN_CFLAGS 	?= -fsanitize=address -fno-omit-frame-pointer
-else
-SAN_CFLAGS	?=
+# Needed before lib.mk is included (gates the flavor list below), which
+# is also why it cannot live in Makefile.buildvars.
+ifeq ($(origin BPF_GCC),undefined)
+BPF_GCC := $(shell command -v bpf-gcc;)
 endif
-SAN_LDFLAGS	?= $(SAN_CFLAGS)
-RELEASE		?=
-OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
-
-LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
-LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
 SKIP_DOCS	?=
 SKIP_LLVM	?=
 SKIP_LIBBFD	?=
 SKIP_CRYPTO	?=
 
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
@@ -213,21 +149,8 @@ ifeq ($(feature-llvm),1)
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
+include Makefile.buildvars
+
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../../../vmlinux				\
@@ -314,16 +237,6 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
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
-
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
 TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
@@ -344,7 +257,6 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
@@ -437,45 +349,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
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
@@ -760,10 +633,6 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$
 
 endef
 
-VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
-VERIFY_SIG_HDR := verification_cert.h
-VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
-PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
 $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
@@ -794,14 +663,11 @@ LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
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
index 000000000..ef12018fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared toolchain, path and flag definitions for the BPF selftests
+# build, included by both Makefile and Makefile.runner. Definitions
+# follow the order they had in the Makefile before the split.
+
+CXX ?= $(CROSS_COMPILE)g++
+OBJCOPY ?= $(CROSS_COMPILE)objcopy
+
+CURDIR := $(abspath .)
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
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+ifdef ASAN
+SAN_CFLAGS 	?= -fsanitize=address -fno-omit-frame-pointer
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
+# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
+# benchmark compilation failure is fatal. Set to 0 to tolerate failures
+# and continue building the remaining tests.
+BPF_STRICT_BUILD ?= 1
+PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
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
+# Unlike the pre-split Makefile, this file is included after ../lib.mk
+# (top level) or without it (runner), so COMMON_CFLAGS is prepended to
+# preserve the original include-search order.
+LIB_MK_CFLAGS := $(CFLAGS)
+CFLAGS = $(COMMON_CFLAGS) $(PCAP_CFLAGS) $(LIB_MK_CFLAGS)
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
+
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
+USE_BOOTSTRAP := ""
+else
+TRUNNER_BPFTOOL := $(DEFAULT_BPFTOOL)
+USE_BOOTSTRAP := "bootstrap/"
+endif
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
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
+MENDIAN:=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+# Immediate on purpose: expanding get_sys_includes forks several shells.
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
+VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
+VERIFY_SIG_HDR := verification_cert.h
+VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
+PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
+
+LIBARENA_SKEL := libarena/libarena.skel.h
+
+ifneq ($(CLANG_HAS_ARENA_ASAN),)
+LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
+CFLAGS += -DHAS_BPF_ARENA_ASAN
+endif
-- 
2.43.0

