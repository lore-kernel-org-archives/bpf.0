Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E6472F8C
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656171; cv=none; b=lUztwBgOcHS5K4J37fmPE98XiModZvu9QM3RhWS7DQkLNZx684EhGznVsCKL/IP5MMt3wtS19E99yLKvOw+Pg/r+VhN9rW5xcBSbUtSxDzOSV4AEOeLByam6AZ2BoIC7+6eIdPQGyJwSx7yjBvK1olG+YeNNTzfttQmz2++9910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656171; c=relaxed/simple;
	bh=SP3Y8oiHNBS8NpjEp1APXdQ6orvJPupG16hqvLoPYfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGHTVQn9KkrepzMgRJEJzbvjDhdBuTBRECSbJerXpqZghKXHybt6acfx29IboPt6f4v+n9/nX7p+cRBsYCE2e5K0Yl8fhM9mdOi/APewt3Cigfv7SRLmiG9War4uLxaYNEJHOR23PZCp5ywqtRIUDXGpLDCjYlofKfKVw8Ybkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4EH2Wvu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4EH2Wvu"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848761b5897so6419513b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656169; x=1785260969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/nCLaEC6KIDRQofGBsPQolQCc72mf9dFarFOnYO7RM=;
        b=i4EH2WvuINsbYmhB0GLl3AKu/SoTEM7uNDxsN8SkIo8RP3n6o46SMNnxwaFBrsP5B1
         N7SZ0z+e/hELouq3UQN23Ri+oAybN0B5+ldlyAB4Qie/c5WOlHZR6Za60k/SIcpW9lkI
         jc9/e/JeZrhEuI+PtubDGdBlrJn2hUY7x5worgMagGQt+wxHscLN7mP6FjGxacr6kDiO
         9U4XtAZotJ7vtBheEuBXegtX7akWMANdNWIubR/6BOXyroK2Uk1SjXRid126ADii8iMg
         FVgsQD43JoNs728Cge2cS6Z4qwIo4Yts6AJW13UaLsOBT6YXQ2H+M0Me7cIcopIkumYp
         x1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656169; x=1785260969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p/nCLaEC6KIDRQofGBsPQolQCc72mf9dFarFOnYO7RM=;
        b=EU+e9cUSj/19G5QWVBKjmAj7QBiGtpvM2AbTBDu1sNRFoOTypEanoVC2afA00cuf8V
         haIsggUYczGxr5G4Wd2210h6ukFKkyLXfQiNhhTZ5fCIPmGqfZwjQ7LiInLkL0Ott6K6
         tZrRXnPUG2SqeJULfRckEP/iaModPEZXao/QSykVX0nwqSQyhhIevJPkwirJfad+5rTE
         gYTPN/4ZXwCG6nmhMP6QGCBxMlc2SAYmt6JNyClJAUwmMATZEcuOfuK0KYaua+6m6YoH
         ELfholIDJJTBHMUGjgNOko0tbQXkWD0trDFk3awledgJd53Gkp2RC8jyUte7OZH15ry8
         xEQw==
X-Gm-Message-State: AOJu0YxEHc6ltvze+kEcU9llwmhUFjR+SvPaGdIeUDD1IA6XcDtAWuFG
	lm1yQ+JxOeFtU/HIizzcAKIebipgNujGWerTYQxv3EZagdEcUEk1v3KnragVyXmQ
X-Gm-Gg: AR+sD10U6cxTwXZrpK9M8dCbJDbKlk1D4r7IuRS2ZR7WqklNbDBTd0kyJ2yGu5Ooxcx
	kSJp+BT63UYBBc572s8KMcZPUbIDtl4cNWmKtCmau0boXEhe/a0LtLzNX2El8+J4ffkMaRau0zJ
	w5hDx4B/OA/+Y34PDbwMNpHPZpfu5ALpoyvoYaqpuL8aWJ1bsqg0YUr1rTIQDhKLjwEtW9Y/4bK
	qeyElGmcvA620edelkZYzKd0pC4D9J9vJosmQly63zInQLATzlvy2yKCWXX7rSavSPyvtLRWobO
	FJ9D1jqORY+XxbX4jw5HDtt4zZxFH+nAjglK0Owakb/QhN7OykW4+76A4jrrez/ZZJPPVOZqgsO
	/XX0W0fg3R72XN6v03OrwJnPbwNClvDraCNrswok89KP22Uyn09xWNEetIadR868PVGOEiku1ky
	zS/5LthfShW6CaKn5LUCzhoMei
X-Received: by 2002:a05:6a00:9084:b0:845:4126:222b with SMTP id d2e1a72fcca58-84c2931072dmr21086342b3a.28.1784656169125;
        Tue, 21 Jul 2026 10:49:29 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172984b0sm85737b3a.27.2026.07.21.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:49:28 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 2/3] selftests/bpf: move shared build definitions into Makefile.buildvars
Date: Tue, 21 Jul 2026 10:49:08 -0700
Message-ID: <20260721174909.8044-3-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
References: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
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

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 165 +--------------
 .../testing/selftests/bpf/Makefile.buildvars  | 196 ++++++++++++++++++
 2 files changed, 203 insertions(+), 158 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e3a27403c..f5c0f81f6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -3,93 +3,24 @@ include ../../../build/Build.include
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
+# These probes gate the flavor list, which must be final before lib.mk is
+# included; keep values consistent with Makefile.buildvars.
+ifeq ($(origin BPF_GCC),undefined)
+BPF_GCC := $(shell command -v bpf-gcc;)
 endif
 
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
@@ -132,9 +63,8 @@ TEST_PROGS := test_kmod.sh \
 TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh
 
-TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+TEST_KMODS ?= bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
 	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
-TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
@@ -150,9 +80,6 @@ TEST_GEN_PROGS_EXTENDED = \
 
 TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
 
-ifneq ($(V),1)
-submake_extras := feature_display=0
-endif
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
@@ -188,6 +115,8 @@ override OUTPUT := $(patsubst %/,%,$(OUTPUT))
 endif
 endif
 
+include Makefile.buildvars
+
 ifneq ($(SKIP_LLVM),1)
 ifeq ($(feature-llvm),1)
   LLVM_CFLAGS  += -DHAVE_LLVM_SUPPORT
@@ -213,30 +142,6 @@ ifeq ($(feature-llvm),1)
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
@@ -314,15 +219,6 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
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
 
 TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
 
@@ -346,7 +242,6 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
@@ -439,45 +334,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
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
@@ -758,10 +614,6 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$
 
 endef
 
-VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
-VERIFY_SIG_HDR := verification_cert.h
-VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
-PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
 $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
@@ -792,14 +644,11 @@ LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
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
index 000000000..2a7efe6d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -0,0 +1,196 @@
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
+# Immediate (with an override-preserving guard): a plain ?= stays
+# recursively expanded and would re-run 'command -v' on every expansion.
+ifeq ($(origin BPF_GCC),undefined)
+BPF_GCC		:= $(shell command -v bpf-gcc;)
+endif
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
+# Kernel test modules; TEST_KMODS= on the command line disables them.
+TEST_KMODS ?= bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
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

