Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2837756B
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447389; cv=none; b=L7z6rM+487d4MteBd4Ueb2YYhycxgMfGyXIY45TGSHYdp6C6Bzofn1QUAK3gpj0hBxIzhU0cvBXCV3gRZG1ZrwPdtGFJM9p7rSTXkFgomDY/Z6gEzFgVX3cmV+D0xWG4Z29mfT5N83VZLvZvqDA+2Crb66i5XZejMXyjLK0LI4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447389; c=relaxed/simple;
	bh=eXq2d3oW/TO7O/F/YP2ZaOLuQS6OPXjmOkJptkR6swc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELbFjqN+y+IwKrRC9unLIFh6meBuQloBNHBDVAK1yioGzaXoOG/O7MUITbD+0vyD85DMsQt+rNX4PuqybcCA9xlcIRm2lI/t1unjzAxX9QOVTtDU07niQdjdcBjJBTy/ytPSnrAUgLN41+PWm1IKMkz1aOQPEMcQJMhNjqXcl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuuoPy8B; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuuoPy8B"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc891373e0so25234775ad.2
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447378; x=1788052178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVu3H27A67/AmdCVUhd8XeW60s0GtMVgphaO+6k9nE0=;
        b=UuuoPy8Bh5flKMGYYCy2SIK2Wdg+XX2hsXdidElwLarrK0/u8fpjnmS711KYp9rgr/
         w7OI04gKhcCqOJxhCAKgyVRMEuuMiLoYAdC2uj0VCuNJ/ko2kfsl8RxSlFxI9/xbAlVb
         4gCeCLbtCYGEfPEO2emM1ZgdwSiPAnRZe2AjxhGzVxPIheywRPzw/HFX0ksGoSflMw49
         0WcYYXye6o88gICJdXCKkmVDYcneiujLH6/v2Pg6p/80fjbaNcg1gRIU7+/ZuNEEcH2z
         1PU7xXhO9uwZbBuBmhoqzi8oRvZK8g8JZxYgmQiimWfVCUNrkaLjrANxkk4rkyInCyWl
         6ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447378; x=1788052178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vVu3H27A67/AmdCVUhd8XeW60s0GtMVgphaO+6k9nE0=;
        b=VD/94IZys45AfY1iSctlLfv1UHu8ApHZ4ReTmMsCGSQbjDID/GuWtukhMaS/K7mMVw
         y2RY/1r7vOyMG/o/hcdTciD5LALexJPdiI9XiS6sekURnBcEU0arcN4JUsPkWmw0+x29
         yLOLv9O806FP16GD2DJ0ayT4mhSSPcbUZ1n8cyJqG6Kqn1UFZTrQzJnGqLWv4BcWaqex
         cC9RSUDbUoLaYHSX2nOlhvD8k4/fWGLbhTWWICC9USGlljWsNDvItQ+QuUBDIYyCEqCz
         5seFnqSEe+fLiH2J8leGG7NILbg8JWAYOcngn4IpeqhTmv/8xD0zl9S1Jv6VcmZlQe18
         vvuw==
X-Gm-Message-State: AFuF++l/mSED5R4DOsXey2lVCpuk1jrmL7E1zpiPDDHnuvnJHbkvXBjj
	ZVPq9rqGQc/KvmSU/i5YF8c+qskwCV357vGcfIa0Gxk7maGA0BlNgxTXaO/r84pV
X-Gm-Gg: AR+sD10jhqqI6wJmAtE5WkOeeEQ3K3RznL0YXKOASdBuqHp8fOuV6EOP8IRc0chKhia
	4uc8WX8yWpw3t2u31fxQp+wsFiNwBMwYqgZe6mCkuVzrzp9pRPwgrSfJ+XXBYQgFko1/usJW1WX
	0q6VFyTujFXVcye0lb4yvWRxsOEOVurEUKz43JDQfsxvRnx1AM11sbGC2Yr3af79a68L0Esrjmb
	MStFdyerg3T+PpZKTkPlSRvJNjzWg0quWVVDHsUZDw6csb/ngelSMJzQNlWgKnVby3Rttv3PP6o
	ncXIkykNFNNrFUf800wvVbAXroE0M+CDQjjK0Toc1cq/dWo1ubZUwso7UnDTRzJyJsS3JSrFnCu
	atDSuGSuJajnVLrV9EAHJ14Vhw56nukWxMxaEPSwYbxjjZ5Qp/UM9vNUPgYgoEleIlgiaVNJ4cO
	afK9JZmt/E5wy2s3+pOGYoASFrbadfyb8gOCJG4NcKI0PPrWNTN9HIUJ443chdcDOkzoY6qlBrE
	VcPBroG3j1NR2YmXnFnpy7TEJHRrJcSksre2/V/2uZZzaALYXs3lKM=
X-Received: by 2002:a17:90b:3c50:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-395dec98ad3mr13470805a91.0.1787447377817;
        Sat, 22 Aug 2026 18:09:37 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:37 -0700 (PDT)
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
	nickolay.lysenko@gmail.com
Subject: [PATCH bpf-next v6 8/9] selftests/bpf: move shared build definitions into Makefile.buildvars
Date: Sat, 22 Aug 2026 18:08:59 -0700
Message-ID: <20260823010900.1730708-9-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the definitions that are not rules into Makefile.buildvars:
output-tree layout, libbpf/bpftool binary locations,
BPF_CFLAGS/COMMON_CFLAGS assembly, libelf/libpcap probes, endianness
and clang feature detection, signing key paths, the permissive-mode
knob with its skip_on_fail and skip_if_missing helpers, the srctree
fallback, PKG_CONFIG and the libarena skeleton names. This is
preparation for building each test runner instance in its own
sub-make: the definitions become includable by more than one
makefile. No rules or recipes are changed; definitions keep their
order.

The include sits directly after ../lib.mk, ahead of the
../../../build/Makefile.feature evaluation, so the definitions are in
place for everything the top Makefile parses afterwards - in
particular the LLVM feature probe captures srctree and PKG_CONFIG
from their new location, and the top Makefile's remaining uses of
both are all recipe-time expansions. Two evaluation-time changes are
called out in comments: CFLAGS is assembled by *prepending*
COMMON_CFLAGS (keeping the include-search order identical to before,
when the definitions preceded lib.mk's additions), and
CLANG_SYS_INCLUDES becomes an immediate assignment (expanding
get_sys_includes forks several shells; CLANG and CLANG_TARGET_ARCH
are final by this point).

BPF_GCC, TEST_KMODS and the knobs the runner never reads (SKIP_*,
submake_extras, TEST_KMOD_TARGETS, the VMLINUX_BTF block) stay in the
Makefile - the first two are needed before lib.mk is included, where
Makefile.buildvars cannot yet be, and reach the runners through the
environment (a later patch exports them). Definitions nothing
outside the Makefile reads also stay: CXX in its original place;
BPFTOOLDIR, HOST_BPFOBJ, BPF_TARGET_ENDIAN, CLANG_CFLAGS and
VERIFY_SIG_HDR in a block right after the include, since they derive
from Makefile.buildvars values.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 171 +----------------
 .../testing/selftests/bpf/Makefile.buildvars  | 173 ++++++++++++++++++
 2 files changed, 182 insertions(+), 162 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 57907859c210..fe838bb23bcd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -5,109 +5,21 @@ include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
 
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
-
 BPF_GCC		?= $(shell command -v bpf-gcc;)
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
-# Permissive-mode recipe suffix: on failure, remove the target, emit a
-# SKIP marker and report success so the rest of the build continues.
-# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
-# $(2) - optional extra files to remove alongside the target
-# $(3) - optional note appended to the SKIP message
-skip_on_fail = $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
-	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' 1>&2; })
-
-# Permissive-mode recipe prefix: when a prerequisite object is missing
-# (its compile failed and was skipped), remove the target and $(3),
-# emit a SKIP marker and report success without running the rest of
-# the recipe.
-# $(1) - SKIP tag
-# $(2) - input files to check
-# $(3) - optional extra files to remove alongside the target
-skip_if_missing = $(if $(PERMISSIVE),for f in $(2); do [ -f $$f ] || { \
-	$(RM) $@ $(3); \
-	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)' 1>&2; exit 0; }; done;)
-
-ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-endif
-
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
-
 # Some utility functions use LLVM libraries
 jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
 
-ifneq ($(LLVM),)
-# Silence some warnings when compiled with clang
-CFLAGS += -Wno-unused-command-line-argument
-endif
-
 # Check whether bpf cpu=v4 is supported or not by clang
 ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
 CLANG_CPUV4 := 1
 endif
 
-# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
-CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
-	$(CLANG) --target=bpf -fsanitize=kernel-address \
-	-mllvm -asan-shadow-addr-space=1 \
-	-x c -c - -o /dev/null 2>/dev/null && echo 1)
-
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
 	test_sockmap \
@@ -186,6 +98,15 @@ override define CLEAN
 endef
 
 include ../lib.mk
+include Makefile.buildvars
+
+# Definitions only this Makefile consumes; placed after the include
+# because some of them derive from Makefile.buildvars values.
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
+VERIFY_SIG_HDR := verification_cert.h
 
 NON_CHECK_FEAT_TARGETS := clean docs-clean emit_tests
 CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
@@ -230,21 +151,6 @@ ifeq ($(feature-llvm),1)
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
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../../../vmlinux				\
@@ -334,16 +240,6 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
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
@@ -364,7 +260,6 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
@@ -457,46 +352,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
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
-	     -I$(TOOLSINCDIR) -I$(CURDIR)/libarena/include		\
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
-
 $(OUTPUT)/flow_dissector_load: flow_dissector_load.h
 
 # Build BPF object using Clang
@@ -764,11 +619,6 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$
 
 endef
 
-VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
-VERIFY_SIG_HDR := verification_cert.h
-VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
-PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
-
 # One genkey run produces both files. A plain two-target rule is not
 # grouped - under -j make would run genkey twice concurrently and the
 # openssl invocations race; the pattern form is implicitly grouped even
@@ -802,7 +652,6 @@ LIBARENA_COMMON_DEPS := $(wildcard libarena/Makefile		\
 LIBARENA_BPF_DEPS := $(LIBARENA_COMMON_DEPS) $(wildcard libarena/selftests/*)
 LIBARENA_BENCH_BPF_DEPS := $(LIBARENA_COMMON_DEPS) $(wildcard libarena/benchs/*)
 
-LIBARENA_SKEL := libarena/libarena.skel.h
 LIBARENA_BENCH_SKEL := libarena/libarena_bench.skel.h
 
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
@@ -812,8 +661,6 @@ $(LIBARENA_BENCH_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BENCH_BPF_
 	+$(MAKE) -C libarena benchmarks $(LIBARENA_MAKE_ARGS)
 
 ifneq ($(CLANG_HAS_ARENA_ASAN),)
-LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
-CFLAGS += -DHAS_BPF_ARENA_ASAN
 
 $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
new file mode 100644
index 000000000000..75e4cfddeb62
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared toolchain, path and flag definitions for the BPF selftests
+# build, included by both Makefile and Makefile.runner. Definitions
+# follow the order they had in the Makefile before the split.
+
+TOOLSDIR := $(abspath ../../..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+TOOLSARCHINCDIR := $(TOOLSDIR)/arch/$(SRCARCH)/include
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
+# Permissive-mode recipe suffix: on failure, remove the target, emit a
+# SKIP marker and report success so the rest of the build continues.
+# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
+# $(2) - optional extra files to remove alongside the target
+# $(3) - optional note appended to the SKIP message
+skip_on_fail = $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
+	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' 1>&2; })
+
+# Permissive-mode recipe prefix: when a prerequisite object is missing
+# (its compile failed and was skipped), remove the target and $(3),
+# emit a SKIP marker and report success without running the rest of
+# the recipe.
+# $(1) - SKIP tag
+# $(2) - input files to check
+# $(3) - optional extra files to remove alongside the target
+skip_if_missing = $(if $(PERMISSIVE),for f in $(2); do [ -f $$f ] || { \
+	$(RM) $@ $(3); \
+	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)' 1>&2; exit 0; }; done;)
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
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+# Immediate on purpose: expanding get_sys_includes forks several shells.
+CLANG_SYS_INCLUDES := $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
+	     -I$(TOOLSINCDIR) -I$(CURDIR)/libarena/include		\
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
+VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
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

