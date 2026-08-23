Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199923A5E8F
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514197; cv=none; b=DYa9Hlr+cu0T2Np0yxIHslLUkuAyzFH5s9MntUWie+sSJWBMBSMxac5xnj792iGnEIakyy9oCVY2cbbYBAoEhKdvjPKYlou6ZjYqx+kDSY5ZuzBMrCcYOuSML0cUpbKCMhStMR8w8naujitJXouT2iIGCNGEGV1RwRBLNzKRTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514197; c=relaxed/simple;
	bh=JVNXBJLzSO1a6GvJ4iJbl6iS9whprZQ7KrrS7p2lOaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7p9e3FOXzW9F87ohFdY9POIL5s4248SlOt0fTEpi5xAiZ+fmI12yuIlPoaxBMRsZBAvAgFDxV8Caw/Rc9isZd51Dy96OVnlTDA2548O8abMi5OB5M4DxNOGsMGETbaXSswkoR5AqvZQZQBloINI1mHZwcUdH6o5YNc2HDJbgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4Too4dX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4Too4dX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc891373e0so29749425ad.2
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514194; x=1788118994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0T907ktvalHhRNYkX4QThwJ+Ff7fzwyrvRfyZYhcaM=;
        b=i4Too4dXwgNAHW45IuqqEHdROeG8h1l19Exm3ZvH9XHCGM1ztG/M76cwOy/unYyANv
         fI1mjVmQQS3vaEw9QqmwZBTJ++FH4ZOJY4+4Pl16wKW21nMmn/mzLiG5KhnqMUgHpsx+
         CgMiD4hWbyF+s9ipJBqvr0TYH2283IdPYoo1jFsx6wHv+dNf+mw5cyMCG8ffVJaKBcon
         tFVFk3BxGOukbQ1RUOAdQddX/JHWouSoIfa356oTAUiouscDTD7VLQcX7jvH3uvXqFVZ
         /h9KB1xmhNhbJkLjGcyuhtglyj89UT7d04jJupv4G+FlLS4TPGuc/BtRZ+41qwAQZ8sh
         pEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514194; x=1788118994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0T907ktvalHhRNYkX4QThwJ+Ff7fzwyrvRfyZYhcaM=;
        b=FbRVzpLk1ZAQe3UaXpRMYdKB79QaBL8y7hI1NP9bwu3bDea+IBnHwbYrfOMA2ZiF4F
         CJM+uALjpJ8Pd0c2lUP6UwHq8hK5No0YWQd1hkb9n/ZyVe27ZPmhs02pWRq2CzAdotRT
         uEtaBBJKTPdLT/McKSrH8ysqVXSHLcPzCbs92MHmth/gKxNmU6auwQyFjMRvsIdxlwXA
         521Fl4LX6NaiwqklMMlHckWBvQmEoVzhztdGHr91vTw2eYWBS9GoLiUAKEfUG4Mhizog
         bLss/H3cGeM9AmfQvBZR52KV5Jat17TpmUt4VNj37dBl9gROg4Hmn1dggYnJLz52G2CX
         E7SA==
X-Gm-Message-State: AFuF++m11J1q1leLjjTkTAgi7njyId6+7gPs9ptaVRA56LbslzxeL1CQ
	d5vchlax+r8v29+ynO4KVul6Ep29/mhhwJWabDwsm+7nNzoOXVrlS4n7ztUYMMA5
X-Gm-Gg: AR+sD13m0VzNi6+mieg1Upw+8m5e4eGb0dmKQWQQI0ezb8TWgcCLuwRKpVpNaTzfVZB
	ZiMH8jFyzlBA9onC/fuW2mXWCeF4Vgxz5J9tQU21yHQ8ni3nEKuaCZzSpMEBne7zhXcI5uajO85
	VcMyAb4/icShHSVlWqWV0dDeL+dARO0zQCARZQYM2ljuZ9b3gD8NADs397PURdKLfmRgN9noUiI
	b8AWscvuDNGVZNiUqIuGyf5nkKxfdRcnE0i+PLqE7HzHlB3I1pNVAG66hOUpwHLVdhwhni6Bfuf
	TcpDUkwkiiKoVFba1FtBzAAkWWYYnrFROMH0UTEJ74AehXbq1vD6JOw/5v8BNC7SI8OCT7EpMGQ
	+VyG15hUu1lWYW+LBuSsIQ0kEvc4XHEddoMpnHE5MxUJhoygb1CBWVw9keFnOiMFVuP31julgvk
	aOR/L/hmF+mXpDZU9M/EwbBIP4U8Q215Q2PIZChCF84mC1WLirXGFtFhMs4lPaDgQx3MZpS9TZB
	G38vWRtXMJIrS2/s+3SpkkTMNWcWnuDhVC92g9yRQ6ynBoGnV1MPH0=
X-Received: by 2002:a17:90b:224a:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-395df677766mr20487258a91.14.1787514194285;
        Sun, 23 Aug 2026 12:43:14 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 8/9] selftests/bpf: move shared build definitions into Makefile.buildvars
Date: Sun, 23 Aug 2026 12:42:40 -0700
Message-ID: <20260823194241.3415152-9-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the build definitions a test runner needs - tree layout and
tool locations, flag assembly, feature probes, signing key paths, the
permissive-mode helpers - into Makefile.buildvars, in their current
order, as preparation for building each test runner instance in its
own sub-make: the definitions become includable by more than one
makefile. No rules or recipes are changed.

The include sits directly after ../lib.mk, ahead of the
../../../build/Makefile.feature evaluation, so the definitions are in
place for everything the top Makefile parses afterwards - in particular
the LLVM feature probe captures srctree and PKG_CONFIG from their new
location, and the top Makefile's remaining uses of both are all
recipe-time expansions. Two evaluation-time changes follow from
the new position and a third is made on the way, each commented in
place: CFLAGS and LDFLAGS are
reassembled around a snapshot taken before lib.mk, keeping the
pre-split order;
CLANG_SYS_INCLUDES becomes an immediate assignment (its inputs are
final by this point, and expanding it forks shells); and the
CLANG_HAS_ARENA_ASAN probe now sees CLANG as resolved from
LLVM=<suffix-or-path> rather than the bare 'clang' default it saw
above the include, while the CLANG_CPUV4 probe, needed before lib.mk,
keeps the old behavior.

BPF_GCC, TEST_KMODS and the knobs the runner never reads (SKIP_*,
submake_extras, TEST_KMOD_TARGETS, the VMLINUX_BTF block) stay in the
Makefile - the first two are needed before lib.mk is included, where
Makefile.buildvars cannot yet be, and reach the runners from there once
a later patch adds them: TEST_KMODS exported in the environment, BPF_GCC
as the bpf_gcc flavor's compiler parameter. Definitions that reach no
runner, directly or as a sub-make parameter, also stay - except
HOST_INCLUDE_DIR, which moves with the conditional block it shares
with the host build directories - and the four that derive from
Makefile.buildvars values sit in a block right after the include.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 175 ++---------------
 .../testing/selftests/bpf/Makefile.buildvars  | 184 ++++++++++++++++++
 2 files changed, 198 insertions(+), 161 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8ac6c8844d4a..432897613b90 100644
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
@@ -185,7 +97,21 @@ override define CLEAN
 	$(Q)$(MAKE) docs-clean
 endef
 
+# ../lib.mk appends to the flags inherited from the environment;
+# Makefile.buildvars rebuilds CFLAGS and LDFLAGS around these snapshots
+# so that its own additions precede lib.mk's, as they did when they
+# were defined above the include.
+INHERITED_CFLAGS := $(CFLAGS)
+INHERITED_LDFLAGS := $(LDFLAGS)
 include ../lib.mk
+include Makefile.buildvars
+
+# Definitions only this Makefile consumes; placed after the include
+# because some of them derive from Makefile.buildvars values.
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
 NON_CHECK_FEAT_TARGETS := clean docs-clean emit_tests
 CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
@@ -230,21 +156,6 @@ ifeq ($(feature-llvm),1)
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
@@ -333,17 +244,6 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
 	$(call msg,MOD,,$@)
 	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/$(@F) $@$(if $(PERMISSIVE),; fi)
 
-
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
@@ -364,7 +264,6 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
@@ -457,46 +356,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
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
 # Build BPF object using Clang
 # $1 - input .c file
 # $2 - output .o file
@@ -763,10 +622,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$
 
 endef
 
-VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
 VERIFY_SIG_HDR := verification_cert.h
-VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
-PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
 # One genkey run produces both files. A plain two-target rule is not
 # grouped - if both files are stale make would run genkey twice, under
@@ -802,7 +658,6 @@ LIBARENA_COMMON_DEPS := $(wildcard libarena/Makefile		\
 LIBARENA_BPF_DEPS := $(LIBARENA_COMMON_DEPS) $(wildcard libarena/selftests/*)
 LIBARENA_BENCH_BPF_DEPS := $(LIBARENA_COMMON_DEPS) $(wildcard libarena/benchs/*)
 
-LIBARENA_SKEL := libarena/libarena.skel.h
 LIBARENA_BENCH_SKEL := libarena/libarena_bench.skel.h
 
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
@@ -812,8 +667,6 @@ $(LIBARENA_BENCH_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BENCH_BPF_
 	+$(MAKE) -C libarena benchmarks $(LIBARENA_MAKE_ARGS)
 
 ifneq ($(CLANG_HAS_ARENA_ASAN),)
-LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
-CFLAGS += -DHAS_BPF_ARENA_ASAN
 
 $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
new file mode 100644
index 000000000000..dc0be9ee72bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -0,0 +1,184 @@
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
+LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
+
+PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
+LDLIBS += $(PCAP_LIBS)
+
+ifneq ($(LLVM),)
+# Silence some warnings when compiled with clang
+CLANG_WARN_CFLAGS := -Wno-unused-command-line-argument
+endif
+
+# Before the split these definitions sat above the ../lib.mk include:
+# they appended to the flags inherited from the environment, and
+# lib.mk's additions (USERCFLAGS/USERLDFLAGS among them) came last.
+# This file is parsed after lib.mk at the top level and in its place
+# in the runner sub-makes, so the same order is rebuilt here. The
+# includer snapshots the inherited flags in INHERITED_CFLAGS and
+# INHERITED_LDFLAGS before lib.mk runs; whatever lib.mk appended since
+# is the tail of the current value.
+lib_mk_added = $(wordlist $(words x $(INHERITED_$(1))),$(words $($(1))),$($(1)))
+LIB_MK_CFLAGS := $(call lib_mk_added,CFLAGS)
+LIB_MK_LDFLAGS := $(call lib_mk_added,LDFLAGS)
+CFLAGS = $(INHERITED_CFLAGS) $(COMMON_CFLAGS) $(PCAP_CFLAGS)		\
+	 $(CLANG_WARN_CFLAGS) $(LIB_MK_CFLAGS)
+LDFLAGS = $(INHERITED_LDFLAGS) $(SAN_LDFLAGS) $(LIB_MK_LDFLAGS)
+
+# Check whether clang supports BPF address sanitizer (requires LLVM 22+).
+# This runs after ../lib.mk has resolved CLANG from LLVM=<suffix or path>,
+# so it probes the compiler that builds the BPF objects.
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

