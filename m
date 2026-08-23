Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75636B924
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447394; cv=none; b=T/TOLc0rJs9cZrlKwJ/TG6eiHdbKkQ9vnrgYxr+GGFONS6Pzz/CNXe3RIW7TMPs2ajM4xb4Q3rG/h9njp69ZNcz57EFrKVXDe5FjLZ1FzYc/RUVP6LuK7CWRor0w0O6iPPLNL8gTc1TMcZqMWY/QR4Y0Tp32jOfCMDZOwSTpLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447394; c=relaxed/simple;
	bh=Exks+ZjR4jK2cYxO5fLwswAGNumBk2nTN+6w8/Q4J3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0nmPzeAgl0pXzzzD1f+riWWYZgNDQS1vewAig51Gs3z1LIfxPzlQhWDctFrEnq2uQM/G6KzWPW+as3cKnAVAF9yRm4/eTFMNdzQShpEko/ChE1+HDvQtJczrGhnDVzS7PcM3gLaOIwqjwxU7wrXrcjEoaz0Np6q9XOnbJCQQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF7yFhdu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF7yFhdu"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2508525a91.1
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447380; x=1788052180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KoZC043c2DUrtAjpRgw79sbO5kmDsXoSk6tIV9opLsg=;
        b=dF7yFhdu5o2BpGpfOE58mQqg9YYF90waEyiMyKDte5N48L/rx5XLz0O49V9uLElOfR
         Band50gfcNXlnrNAK4xRbU5yfLWn6mbsZ60TfkvD3PCy7y/n1S06B8gdwnsw41DekrI8
         v3yWyk5qOau4RD5shYJTTURvbUG1At5Q/oVen2iYR5f+KeqgivCyRAyvlJvla8GEz0F9
         GplvV47Z+RzKWxZz4/T68N3gfuBaKSCwEByCZ3aXzuX5JvLFvXfbBlRbzE+Q/YqvPM+Y
         /DvObthtSagrPIglBBcVIVaRluUOaKSmXQSQNg25hp2vMGWf+uO0Zdd64r0ZuilDV/IX
         oesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447380; x=1788052180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoZC043c2DUrtAjpRgw79sbO5kmDsXoSk6tIV9opLsg=;
        b=EvjjwxomccnuVsOuIifRO3hzG02/PqCq0CUM0Jak8cqPgBSDLhVxdZtVljgGqP3SMJ
         RKA5dLl9F2MnJjBkFRG/TZChyssK8YnIYaRvsmFCWyQpCA99EaSoqw4lHuAHwUXz4NAU
         CnkKJYRsWLyaJQP9KfsAxKryjNgFVeTGpYshW8rhiZX7d4+I3xBi8zspljroRiIaeI+7
         /6rwxGufHplM6E+i66i8lspHwaSO5kPgmml9OocAmfoV7WN+hiTytjlvp2mrx3gywSoF
         L0UNotzb1MyoXG1yEN3bjhJUvpP2NDL4G0LvDTB9dy9YklfZei0MRp1DkmsmrGPl2DiP
         ETOg==
X-Gm-Message-State: AFuF++lLwuxy/L2pVMF3jClH9luD2UxusgWAipgT3IMaJrhxBjpngFXc
	+JaQrS5pABDt21nwA+RfGId4NCtHrq9Cj59hotUNlFSwmK/BgXJGYk6e0b7TFUsT
X-Gm-Gg: AR+sD10iZBEEgb5Ab+KmplRuUtFd8Z2FBkR+f6RLuWhrrX8lYNpRsIP3n1cfYVoAKSN
	bXjTQfmGHqJKOc7y1h3/JYeOe0pjZlusN8bzQHVS8stz19JA8v/jL0IW1pI5AHrR8ZwlAeyIk9K
	eTu5Z/xz/NdWNNrYWicp2044fomtm7NJef7DjCuWAfmu5sz0jdZhn0S7nJkD8cwvH+UxEB/jrZI
	pxTv4Ld2l0SnpyQjXR7r5afAPoAzTyGIiuYzmWSF5jK/tzbRYXxMydkl4U5bSQEaemHqZSdAkZs
	1tKjAqNZNAWbTB0T3vik4aDS2BA8iZyzaYTr0btqv+AdZb98Qlz2sPft182BaElC2l2yml2Vvq7
	eGX/KNRmfJd5pZBgEIZ88Ybtiuy9Z9B4PjAddEG/dIsPTNkPkZFNH9bT/J+Ez1F4YRqndugulKm
	0GFfRIf7e3r9Kg7LpzY+7+jDTY+rR17m7AtjJjfZUAJmB0EJxPS0HqOq/VXlmUqhXSm1ZwBnHJm
	R65sOD5rprttP1yxyoVFm1tDKuGziOxxI+mZYQy1RWPyazHtY0rGXc=
X-Received: by 2002:a17:90b:33c4:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-395c3552287mr28545260a91.13.1787447379705;
        Sat, 22 Aug 2026 18:09:39 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 9/9] selftests/bpf: build each test runner instance in its own sub-make
Date: Sat, 22 Aug 2026 18:09:00 -0700
Message-ID: <20260823010900.1730708-10-nickolay.lysenko@gmail.com>
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

Replace the DEFINE_TEST_RUNNER/DEFINE_TEST_RUNNER_RULES double-expansion
machinery with Makefile.runner: one sub-make invocation per test runner
instance (test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_progs-bpf_gcc, test_maps), each in its own single-flavor namespace
written in plain make - no $$-escaping, no per-flavor eval guards, no
accumulating vpath directives.

The main Makefile keeps everything that exists once - tool sub-builds,
vmlinux.h, signing keys, tests.h generation, standalone binaries and
the kselftest lib.mk contract - and delegates to the runner through
explicit per-instance rules. The light-skeleton demand lists stay
hand-maintained as before. The $(OUTPUT) directory rule, previously
generated inside the deleted define, joins MAKE_DIRS.

The rules for one flavor's BPF objects and skeletons live in
Makefile.skel, parameterized by the output directory and the compiler
(this layout and the userspace-object one below are Eduard's, from
review): the main Makefile instantiates them for the default flavor,
Makefile.runner for the flavored instances. Makefile.skel is
self-contained: the hand-maintained skeleton metadata (the demand
lists, LINKED_SKELS and its -deps map, the skeleton blacklist, the
BPF-object header list, the per-source flag overrides) sits next to
the derivations and rules that read it, and Makefile.buildvars keeps
only definitions shared between files. bench,
test_maps, xskxceiver, xdp_*, test_cpp and the install list therefore
depend on
exactly the files they consume, as they do today, and every output
path keeps a single writer - the main Makefile owns the default
flavor's artifacts in $(OUTPUT), each flavored runner its own
subdirectory. The unflavored sub-makes, which share $(OUTPUT),
include the same rule file; the delegating rules list the full
artifact set as prerequisites, so those sub-makes always find the
files fresh and never rebuild them.

The userspace objects the runner instances link are likewise built
here, once, from per-runner lists in Makefile.buildvars: no runner
sub-make ever writes a file another make instance also builds, and
the flavored instances link the shared objects instead of compiling
their own identical copies - the only per-flavor artifacts left are
the BPF objects, skeletons and test objects that actually differ
between flavors. With no compile rule left for these objects in the
runner, a missing one would fall back to make's built-in %.o rule and
be silently rebuilt with default flags, so the runner disables
built-in rules (MAKEFLAGS += -r).

This also fixes a latent parallel-build race (objects including libbpf
internal headers now order against the bpftool sub-build that installs
them).

In permissive mode the runner link rule keeps the current Makefile's
semantics: test objects existing at parse time are normal
prerequisites (editing a test source relinks the runner), the full
set stays order-only to drive the build attempts, and the recipe
links the wildcard survivors.

BPF_GCC and TEST_KMODS are exported next to the LLVM probe results:
the runner sub-makes read both from the environment.

The BPF compiler differences between flavors (clang vs bpf-gcc,
-mcpu level, extra defines and system includes) are plain parameters
on the sub-make invocation, so the runner has a single BPF
compilation rule with no conditionals.

Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 476 +++++-------------
 .../testing/selftests/bpf/Makefile.buildvars  |  12 +
 tools/testing/selftests/bpf/Makefile.runner   | 175 +++++++
 tools/testing/selftests/bpf/Makefile.skel     | 143 ++++++
 4 files changed, 455 insertions(+), 351 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100644 tools/testing/selftests/bpf/Makefile.skel

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fe838bb23bcd..22f3a261dc16 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -12,9 +12,6 @@ SKIP_LLVM	?=
 SKIP_LIBBFD	?=
 SKIP_CRYPTO	?=
 
-# Some utility functions use LLVM libraries
-jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
-
 # Check whether bpf cpu=v4 is supported or not by clang
 ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
 CLANG_CPUV4 := 1
@@ -31,16 +28,6 @@ TEST_INST_SUBDIRS := no_alu32
 ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 TEST_INST_SUBDIRS += bpf_gcc
-
-# The following tests contain C code that, although technically legal,
-# triggers GCC warnings that cannot be disabled: declaration of
-# anonymous struct types in function parameter lists.
-progs/btf_dump_test_case_bitfields.c-bpf_gcc-CFLAGS := -Wno-error
-progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS := -Wno-error
-progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
-progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
-progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
-
 endif
 
 ifneq ($(CLANG_CPUV4),)
@@ -151,6 +138,9 @@ ifeq ($(feature-llvm),1)
 endif
 endif
 
+# Some utility functions use LLVM libraries
+$(OUTPUT)/jit_disasm_helpers.o: CFLAGS += $(LLVM_CFLAGS)
+
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../../../vmlinux				\
@@ -169,7 +159,7 @@ $(notdir $(TEST_GEN_PROGS) $(TEST_KMODS)				\
 	 $(TEST_GEN_PROGS_EXTENDED)): %: $(OUTPUT)/% ;
 
 # sort removes libbpf duplicates when not cross-building
-MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	\
+MAKE_DIRS := $(sort $(OUTPUT) $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf \
 	       $(BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/bpftool		\
 	       $(HOST_BUILD_DIR)/resolve_btfids				\
 	       $(INCLUDE_DIR))
@@ -256,9 +246,26 @@ $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
 $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
 $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
-$(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
-$(OUTPUT)/xsk.o: $(BPFOBJ)
+
+# The userspace objects the runner instances link (RUNNER_OBJS, see
+# Makefile.buildvars) are built here, once, so that no runner sub-make
+# ever writes a file this Makefile also builds.
+#
+# $(BPFTOOL) is a prerequisite because its sub-make is what installs
+# libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h) into
+# $(INCLUDE_DIR); without it, trace_helpers.c races the install and can
+# silently pick up the source-tree copies instead.
+RUNNER_OBJS := $(sort $(RUNNER_OBJS-test_progs) $(RUNNER_OBJS-test_maps)\
+		      $(RUNNER_LIB_OBJS-test_progs))
+$(RUNNER_OBJS): $(VERIFY_SIG_HDR) prog_tests/tests.h map_tests/tests.h	\
+		$(BPFOBJ) $(BPFTOOL)
+
+# find_bit.c is the only runner source outside this directory,
+# so it needs a rule of its own.
+$(OUTPUT)/find_bit.o: $(TOOLSDIR)/lib/find_bit.c
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $< -o $@
 
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
@@ -327,7 +334,7 @@ endif
 
 # vmlinux.h is first dumped to a temporary file and then compared to
 # the previous version. This helps to avoid unnecessary re-builds of
-# $(TRUNNER_BPF_OBJS)
+# BPF objects.
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 	$(call msg,GEN,,$@)
@@ -354,271 +361,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 
 $(OUTPUT)/flow_dissector_load: flow_dissector_load.h
 
-# Build BPF object using Clang
-# $1 - input .c file
-# $2 - output .o file
-# $3 - CFLAGS
-# $4 - binary name
-define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2 $(call skip_on_fail,BPF)
-endef
-# Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
-define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2 $(call skip_on_fail,BPF)
-endef
-# Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
-define CLANG_CPUV4_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2 $(call skip_on_fail,BPF)
-endef
-# Build BPF object using GCC
-define GCC_BPF_BUILD_RULE
-	$(call msg,GCC-BPF,$4,$2)
-	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2 $(call skip_on_fail,BPF)
-endef
-
-SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
-
-LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
-		linked_vars.skel.h linked_maps.skel.h 			\
-		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h tracing_multi.skel.h			\
-		tracing_multi_module.skel.h				\
-		tracing_multi_intersect.skel.h				\
-		tracing_multi_session.skel.h
-
-LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
-	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
-	test_ringbuf_overwrite.c
-
-LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
-
-# Generate both light skeleton and libbpf skeleton for these
-LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c test_global_percpu_data.c
-SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)
-
-test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
-linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
-linked_vars.skel.h-deps := linked_vars1.bpf.o linked_vars2.bpf.o
-linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
-# In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
-# but that's created as a side-effect of the skel.h generation.
-test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
-test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
-test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
-tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
-tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
-tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
-tracing_multi_session.skel.h-deps := tracing_multi_session_attach.bpf.o tracing_multi_check.bpf.o
-
-LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
-LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
-
-HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
-			$(wildcard $(CURDIR)/libarena/include/*.[ch])	\
-			$(addprefix $(BPFDIR)/,	bpf_core_read.h	\
-			                        bpf_endian.h	\
-						bpf_helpers.h	\
-			                        bpf_tracing.h)
-
-# Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
-# $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
-# Parameters:
-# $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
-define DEFINE_TEST_RUNNER
-TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
-TRUNNER_BINARY := $1$(if $2,-)$2
-TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
-				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
-TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
-				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
-TRUNNER_LIB_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
-				 $$(filter %.c,$(TRUNNER_LIB_SOURCES)))
-TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
-TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
-TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
-TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.bpf.o, $$(TRUNNER_BPF_SRCS))
-TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
-				 $$(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),\
-					       $$(TRUNNER_BPF_SRCS)))
-TRUNNER_BPF_LSKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS) $$(LSKELS_EXTRA))
-TRUNNER_BPF_SKELS_LINKED := $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SKELS))
-TRUNNER_BPF_LSKELS_SIGNED := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS_SIGNED))
-TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
-
-# Evaluate rules now with extra TRUNNER_XXX variables above already defined
-$$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
-
-endef
-
-# Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER and
-# set up by DEFINE_TEST_RUNNER itself, create test runner build rules with:
-# $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
-define DEFINE_TEST_RUNNER_RULES
-
-# Permissive build behaviour (skip-on-failure compile, partial-link) only
-# applies to test_progs and its flavors; runners that use strong cross-object
-# references (e.g. test_maps) keep strict semantics even when permissive.
-# The check is inlined per-runner so $1 is substituted at $(call) time and
-# the result is baked into each rule's recipe.
-
-ifeq ($($(TRUNNER_OUTPUT)-dir),)
-$(TRUNNER_OUTPUT)-dir := y
-$(TRUNNER_OUTPUT):
-	$$(call msg,MKDIR,,$$@)
-	$(Q)mkdir -p $$@
-endif
-
-# ensure we set up BPF objects generation rule just once for a given
-# input/output directory combination
-ifeq ($($(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs),)
-$(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs := y
-$(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
-		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
-		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
-		     $$(INCLUDE_DIR)/vmlinux.h				\
-		     $(HEADERS_FOR_BPF_OBJS)				\
-		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
-	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
-					  $(TRUNNER_BPF_CFLAGS)         \
-					  $$($$<-CFLAGS)		\
-					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
-
-$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
-	$(Q)$$(call skip_if_missing,SKEL,$$<,$$(@:.skel.h=.subskel.h))	\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
-	BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh					\
-		--name $$(notdir $$(<:.bpf.o=))					\
-		--skel $$@ --subskel $$(@:.skel.h=.subskel.h) $$< $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h))
-
-$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
-	$(Q)$$(call skip_if_missing,SKEL,$$<)					\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
-	BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh					\
-		--name $$(notdir $$(<:.bpf.o=_lskel)) --lskel			\
-		--skel $$@ $$< $$(call skip_on_fail,SKEL)
-
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
-	$(Q)$$(call skip_if_missing,SKEL,$$<)					\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY) (signed)] $$(notdir $$@)' 1>&2; \
-	BPFTOOL=$$(BPFTOOL) PRIVATE_KEY=$(PRIVATE_KEY)				\
-		VERIFICATION_CERT=$(VERIFICATION_CERT)				\
-		./gen_bpf_skel.sh --sign					\
-		--name $$(notdir $$(<:.bpf.o=_lskel))				\
-		--skel $$@ $$< $$(call skip_on_fail,SKEL)
-
-$(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
-
-# .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
-.SECONDEXPANSION:
-$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
-	$(Q)$$(call skip_if_missing,SKEL,$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)),$$(@:.skel.h=.subskel.h)) \
-	printf '  %-12s %s\n' 'LINK-BPF' '[$(TRUNNER_BINARY)] $$(notdir $$(@:.skel.h=.bpf.o))' 1>&2; \
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
-	BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh					\
-		--name $$(notdir $$(@:.skel.h=))				\
-		--skel $$@ --subskel $$(@:.skel.h=.subskel.h)			\
-		$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h))
-
-# When the compiler generates a %.d file, only skel basenames (not
-# full paths) are specified as prerequisites for corresponding %.o
-# file. vpath directives below instruct make to search for skel files
-# in TRUNNER_OUTPUT, if they are not present in the working directory.
-vpath %.skel.h $(TRUNNER_OUTPUT)
-vpath %.lskel.h $(TRUNNER_OUTPUT)
-vpath %.subskel.h $(TRUNNER_OUTPUT)
-
-endif
-
-# ensure we set up tests.h header generation rule just once
-ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
-$(TRUNNER_TESTS_DIR)-tests-hdr := y
-$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
-	$$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
-	$$(shell (echo '/* Generated header, do not edit */';					\
-		  sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'	\
-			$(TRUNNER_TESTS_DIR)/*.c | sort ;	\
-		 ) > $$@)
-endif
-
-$(TRUNNER_OUTPUT)/resolve_btfids.test.o: $(RESOLVE_BTFIDS) $(TRUNNER_OUTPUT)/btf_data.bpf.o
-$(TRUNNER_OUTPUT)/resolve_btfids.test.o: private TEST_NEEDS_BTFIDS = 1
-
-# compile individual test files
-# Note: we cd into output directory to ensure embedded BPF object is found
-$(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
-		      $(TRUNNER_TESTS_DIR)/%.c				\
-		      | $(TRUNNER_OUTPUT)/%.test.d
-	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$$(call skip_on_fail,TEST))
-	$$(if $$(TEST_NEEDS_BTFIDS),						\
-		$(Q)if [ -f $$@ ]; then						\
-		$(if $(filter 1,$(V)),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"); \
-		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
-		fi)
-
-$(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
-			    $(TRUNNER_TESTS_DIR)/%.c			\
-			    $(TRUNNER_EXTRA_HDRS)			\
-			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
-			    $(TRUNNER_BPF_SKELS)			\
-			    $(TRUNNER_BPF_LSKELS)			\
-			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
-			    $(TRUNNER_BPF_SKELS_LINKED)
-
-ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
-include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
-endif
-
-# add per extra obj CFGLAGS definitions
-$(foreach N,$(patsubst $(TRUNNER_OUTPUT)/%.o,%,$(TRUNNER_EXTRA_OBJS)),	\
-	$(eval $(TRUNNER_OUTPUT)/$(N).o: CFLAGS += $($(N).c-CFLAGS)))
-
-$(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
-		       %.c						\
-		       $(TRUNNER_EXTRA_HDRS)				\
-		       $(VERIFY_SIG_HDR)				\
-		       $(TRUNNER_TESTS_HDR)				\
-		       $$(BPFOBJ) | $(TRUNNER_OUTPUT)
-	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
-
-$(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
-	$$(call msg,LIB-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
-
-# non-flavored in-srctree builds receive special treatment, in particular, we
-# do not need to copy extra resources (see e.g. test_btf_dump_case())
-$(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
-ifneq ($2:$(OUTPUT),:$(shell pwd))
-	$$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
-	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args) $$^ $(TRUNNER_OUTPUT)/
-endif
-
-# some X.test.o files have runtime dependencies on Y.bpf.o files
-$(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
-
-$(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS))	\
-			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
-			     $(TRUNNER_LIB_OBJS)			\
-			     $(TRUNNER_BPFTOOL)				\
-			     $(OUTPUT)/veristat				\
-			     | $(TRUNNER_BINARY)-extras			\
-			     $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS)))
-	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$(filter %.a %.o,$$(wildcard $(TRUNNER_TEST_OBJS)) $$(filter-out $(TRUNNER_TEST_OBJS),$$^)),$$(filter %.a %.o,$$^)),$$(filter %.a %.o,$$^)) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
-	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
-		   $(OUTPUT)/$(if $2,$2/)bpftool
-
-endef
-
 # One genkey run produces both files. A plain two-target rule is not
 # grouped - under -j make would run genkey twice concurrently and the
 # openssl invocations race; the pattern form is implicitly grouped even
@@ -666,81 +408,113 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
 endif
 
-# Define test_progs test runner.
-TRUNNER_TESTS_DIR := prog_tests
-TRUNNER_BPF_PROGS_DIR := progs
-TRUNNER_EXTRA_SOURCES := test_progs.c		\
-			 cgroup_helpers.c	\
-			 trace_helpers.c	\
-			 network_helpers.c	\
-			 testing_helpers.c	\
-			 btf_helpers.c		\
-			 cap_helpers.c		\
-			 unpriv_helpers.c 	\
-			 sysctl_helpers.c	\
-			 netlink_helpers.c	\
-			 jit_disasm_helpers.c	\
-			 io_helpers.c		\
-			 test_loader.c		\
-			 xsk.c			\
-			 disasm.c		\
-			 disasm_helpers.c	\
-			 json_writer.c 		\
-			 $(VERIFY_SIG_HDR)		\
-			 flow_dissector_load.h	\
-			 ip_check_defrag_frags.h	\
-			 bpftool_helpers.c	\
-			 usdt_1.c usdt_2.c	\
-			 $(LIBARENA_SKEL)	\
-			 $(LIBARENA_ASAN_SKEL)
-TRUNNER_LIB_SOURCES := find_bit.c
-TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
-		       $(OUTPUT)/liburandom_read.so			\
-		       $(OUTPUT)/xdp_synproxy				\
-		       $(OUTPUT)/sign-file				\
-		       $(OUTPUT)/uprobe_multi				\
-		       $(TEST_KMOD_TARGETS)				\
-		       ima_setup.sh 					\
-		       $(VERIFY_SIG_SETUP)				\
-		       $(wildcard progs/btf_dump_test_case_*.c)		\
-		       $(wildcard progs/*.bpf.o)
-TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
-$(eval $(call DEFINE_TEST_RUNNER,test_progs))
-
-# Define test_progs-no_alu32 test runner.
-TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
-$(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
-
-# Define test_progs-cpuv4 test runner.
+# Generated test list headers
+
+define gen_tests_hdr
+	$(call msg,TEST-HDR,,$@)
+	$(Q)(echo '/* Generated header, do not edit */';		\
+		  sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'	\
+		$(@D)/*.c | sort) > $@
+endef
+
+prog_tests/tests.h: $(wildcard prog_tests/*.c)
+	$(gen_tests_hdr)
+
+map_tests/tests.h: $(wildcard map_tests/*.c)
+	$(gen_tests_hdr)
+
+# Test runner instances, one sub-make each (see Makefile.runner).
+
+# The LLVM feature-probe results, BPF_GCC and TEST_KMODS are exported
+# to the runner sub-makes. CC is passed explicitly instead: exporting it
+# would also leak lib.mk's CC into the libbpf/bpftool/resolve_btfids
+# sub-builds, which compute their own. ('export NAME' on an undefined
+# variable creates an empty one, so these stay below the definitions.)
+export LLVM_CFLAGS LLVM_LDLIBS LLVM_LDFLAGS BPF_GCC TEST_KMODS
+
+RUNNER_MAKE := $(MAKE) -f Makefile.runner OUTPUT=$(OUTPUT) CC='$(CC)'
+
+# Everything a runner instance references but does not know how to build.
+RUNNER_PREREQS := $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
+		  $(TRUNNER_BPFTOOL) $(RESOLVE_BTFIDS)			\
+		  $(OUTPUT)/veristat					\
+		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
+		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
+		  prog_tests/tests.h map_tests/tests.h			\
+		  $(RUNNER_OBJS)					\
+		  $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so	\
+		  $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file		\
+		  $(OUTPUT)/uprobe_multi $(TEST_KMOD_TARGETS)
+
+# The main Makefile cannot tell whether $(OUTPUT)/test_progs is stale -
+# only the runner sub-make knows its full dependency graph. FORCE makes
+# the delegating rules below always run; their dependents still rebuild
+# on mtime only.
+FORCE:
+
+# The default flavor's BPF objects and skeletons are consumed here as
+# well as inside the runner sub-makes: bench, test_maps, xskxceiver,
+# xdp_* and test_cpp depend on individual skeletons, and lib.mk's
+# install rule copies the BPF objects. Instantiate the shared rules
+# (Makefile.skel) for the default flavor, so those consumers depend on
+# exactly the files they use; the runner delegation rules below list
+# the whole set as prerequisites, so a runner sub-make never rebuilds
+# a file this Makefile owns.
+RDIR := $(OUTPUT)
+FLAVOR :=
+BINARY := test_progs
+BPF_CC := $(CLANG)
+BPF_CC_MSG := CLNG-BPF
+BPF_SYS_INCLUDES := $(CLANG_SYS_INCLUDES)
+BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3
+BPF_DEFINES := -DENABLE_ATOMICS_TESTS
+include Makefile.skel
+
+DEFAULT_RUNNER_ARGS := RUNNER=test_progs FLAVOR= TESTS_DIR=prog_tests	\
+	BPF_CC='$(BPF_CC)' BPF_CC_MSG=$(BPF_CC_MSG)			\
+	BPF_SYS_INCLUDES='$(BPF_SYS_INCLUDES)'				\
+	BPF_CC_FLAGS='$(BPF_CC_FLAGS)' BPF_DEFINES=$(BPF_DEFINES)
+
+$(OUTPUT)/test_progs: $(RUNNER_PREREQS) $(BPF_OBJS) $(ALL_SKELS) FORCE
+	+$(Q)$(RUNNER_MAKE) $(DEFAULT_RUNNER_ARGS)
+
+$(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=no_alu32 TESTS_DIR=prog_tests \
+		BPF_CC='$(CLANG)' BPF_CC_MSG=CLNG-BPF BPF_SYS_INCLUDES='$(CLANG_SYS_INCLUDES)'	\
+		BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v2'
+
 ifneq ($(CLANG_CPUV4),)
-TRUNNER_BPF_BUILD_RULE := CLANG_CPUV4_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
-$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
+$(OUTPUT)/test_progs-cpuv4: $(RUNNER_PREREQS) FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=cpuv4 TESTS_DIR=prog_tests \
+		BPF_CC='$(CLANG)' BPF_CC_MSG=CLNG-BPF BPF_SYS_INCLUDES='$(CLANG_SYS_INCLUDES)'	\
+		BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v4'		\
+		BPF_DEFINES=-DENABLE_ATOMICS_TESTS
 endif
 
-# Define test_progs BPF-GCC-flavored test runner.
 ifneq ($(BPF_GCC),)
-TRUNNER_BPF_BUILD_RULE := GCC_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(call get_sys_includes,gcc,)
-$(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
+# Sys includes come from the *host* gcc, not $(BPF_GCC) - bpf-gcc's own
+# search path lacks the host's asm-generic/ headers.
+GCC_SYS_INCLUDES := $(call get_sys_includes,gcc,)
+
+$(OUTPUT)/test_progs-bpf_gcc: $(RUNNER_PREREQS) FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=bpf_gcc TESTS_DIR=prog_tests \
+		BPF_CC='$(BPF_GCC)' BPF_CC_MSG=GCC-BPF				\
+		BPF_SYS_INCLUDES='$(GCC_SYS_INCLUDES)'				\
+		BPF_CC_FLAGS='-DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2'
 endif
 
-# Define test_maps test runner.
-TRUNNER_TESTS_DIR := map_tests
-TRUNNER_BPF_PROGS_DIR := progs
-TRUNNER_EXTRA_SOURCES := test_maps.c
-TRUNNER_LIB_SOURCES :=
-TRUNNER_EXTRA_FILES :=
-TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
-TRUNNER_BPF_CFLAGS :=
-$(eval $(call DEFINE_TEST_RUNNER,test_maps))
-
-# Define test_verifier test runner.
-# It is much simpler than test_maps/test_progs and sufficiently different from
-# them (e.g., test.h is using completely pattern), that it's worth just
-# explicitly defining all the rules explicitly.
+# test_maps compiles map_tests/*.c against the default flavor's skeletons
+$(OUTPUT)/test_maps: $(RUNNER_PREREQS) map_tests/tests.h $(BPF_OBJS)	\
+		     $(ALL_SKELS) FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_maps FLAVOR= TESTS_DIR=map_tests
+
+TEST_GEN_FILES += $(BPF_OBJS)
+
+# Standalone test binaries
+
+# test_verifier is much simpler than test_maps/test_progs and
+# sufficiently different from them (e.g., its tests.h uses a completely
+# different pattern), that it's worth just defining its rules explicitly.
 verifier/tests.h: verifier/*.c
 	$(Q)( cd verifier/; \
 		  echo '/* Generated header, do not edit */'; \
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
index 75e4cfddeb62..6395b4e5c7d6 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -171,3 +171,15 @@ ifneq ($(CLANG_HAS_ARENA_ASAN),)
 LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
 CFLAGS += -DHAS_BPF_ARENA_ASAN
 endif
+
+RUNNER_OBJS-test_progs := $(addprefix $(OUTPUT)/,			\
+	test_progs.o cgroup_helpers.o trace_helpers.o			\
+	network_helpers.o testing_helpers.o btf_helpers.o		\
+	cap_helpers.o unpriv_helpers.o sysctl_helpers.o			\
+	netlink_helpers.o jit_disasm_helpers.o io_helpers.o		\
+	test_loader.o xsk.o disasm.o disasm_helpers.o			\
+	json_writer.o bpftool_helpers.o usdt_1.o usdt_2.o)
+RUNNER_OBJS-test_maps := $(addprefix $(OUTPUT)/,			\
+	test_maps.o testing_helpers.o)
+
+RUNNER_LIB_OBJS-test_progs := $(OUTPUT)/find_bit.o
diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/selftests/bpf/Makefile.runner
new file mode 100644
index 000000000000..a15efef2c8a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.runner
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Build one BPF test-runner instance: test_progs, one of its flavors
+# (no_alu32, cpuv4, bpf_gcc), or test_maps.
+#
+# Each instance is an independent sub-make with its own output directory,
+# so everything here is written in plain make - no $$-escaping, no eval,
+# no per-flavor guards. This file is always invoked by the main Makefile,
+# never directly: all shared prerequisites (libbpf, bpftool, vmlinux.h,
+# veristat, userspace objects, signing key, generated tests.h, extra
+# binaries and - for the unflavored instances - the default flavor's
+# BPF objects and skeletons) are built by the main Makefile *before*
+# this one runs and are referenced below as plain files.
+#
+# Parameters (all passed on the sub-make command line):
+#   OUTPUT      absolute path of the selftests output directory
+#   RUNNER      base binary name: test_progs | test_maps
+#   FLAVOR      flavor suffix: empty | no_alu32 | cpuv4 | bpf_gcc
+#   TESTS_DIR   directory with the test sources: prog_tests | map_tests
+#   BPF_CC      compiler for progs/*.c BPF objects ($(CLANG) or
+#               $(BPF_GCC)); empty for test_maps, which builds none
+#   BPF_CC_MSG  build-log tag: CLNG-BPF | GCC-BPF
+#   BPF_CC_FLAGS
+#               compiler-specific flags (-O2, target/-mcpu or gcc knobs)
+#   BPF_SYS_INCLUDES
+#               system include flags matching BPF_CC
+#   BPF_DEFINES extra defines for BPF objects (e.g. -DENABLE_ATOMICS_TESTS)
+#   CC          C compiler (as resolved by lib.mk in the main Makefile)
+#   LLVM_CFLAGS/LLVM_LDLIBS/LLVM_LDFLAGS
+#               results of the top-level LLVM feature probe
+
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+
+# Same message helpers as ../lib.mk, which only the top level includes.
+ifeq ($(V),1)
+Q =
+msg =
+else
+Q = @
+msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
+MAKEFLAGS += --no-print-directory
+endif
+
+include Makefile.buildvars
+
+# Keep in sync with the CFLAGS/LDFLAGS additions in ../lib.mk.
+CFLAGS += -D_GNU_SOURCE=
+CFLAGS += -I$(srctree)/tools/testing/selftests
+CFLAGS += $(USERCFLAGS)
+LDFLAGS += $(USERLDFLAGS)
+ifneq ($(LLVM),)
+CFLAGS += -Wno-address-of-packed-member
+CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
+endif
+
+BINARY := $(RUNNER)$(if $(FLAVOR),-$(FLAVOR))
+RDIR   := $(OUTPUT)$(if $(FLAVOR),/$(FLAVOR))
+
+all: $(OUTPUT)/$(BINARY)
+.PHONY: all
+
+# Delete partially updated (corrupted) files on error
+.DELETE_ON_ERROR:
+
+# No built-in rules: every file built here has an explicit rule, and the
+# objects that come from the main Makefile have to be an error when
+# missing rather than a silent rebuild by the built-in %.o recipes.
+MAKEFLAGS += -r
+
+# Permissive skip-on-failure of individual tests applies to test_progs and
+# its flavors only; test_maps uses strong cross-object references and keeps
+# strict semantics even when BPF_STRICT_BUILD=0.
+PERMISSIVE_TESTS := $(if $(filter test_progs,$(RUNNER)),$(PERMISSIVE))
+
+$(RDIR):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+# ---------------------------------------------------------------------
+# Per-runner sources
+# ---------------------------------------------------------------------
+
+ifeq ($(RUNNER),test_progs)
+GENERATED_HDRS := $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)
+EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so	\
+	       $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file		\
+	       $(OUTPUT)/uprobe_multi					\
+	       $(addprefix $(OUTPUT)/,$(TEST_KMODS))			\
+	       ima_setup.sh $(VERIFY_SIG_SETUP)				\
+	       $(wildcard progs/btf_dump_test_case_*.c)			\
+	       $(wildcard progs/*.bpf.o)
+endif
+
+TEST_SRCS  := $(notdir $(wildcard $(TESTS_DIR)/*.c))
+TEST_OBJS  := $(patsubst %.c,$(RDIR)/%.test.o,$(TEST_SRCS))
+TEST_DEPS  := $(TEST_OBJS:.o=.d)
+
+# ---------------------------------------------------------------------
+# BPF objects and skeletons - rules shared with the main Makefile
+# ---------------------------------------------------------------------
+
+include Makefile.skel
+
+# When the compiler generates a %.d file, only skel basenames (not full
+# paths) are specified as prerequisites for the corresponding %.o file.
+# The vpath directives instruct make to also search for skel files in
+# $(RDIR) if they are not present in the working directory.
+vpath %.skel.h $(RDIR)
+vpath %.lskel.h $(RDIR)
+vpath %.subskel.h $(RDIR)
+
+# ---------------------------------------------------------------------
+# Test objects and runner binary
+# ---------------------------------------------------------------------
+
+$(RDIR)/resolve_btfids.test.o: $(RESOLVE_BTFIDS) $(RDIR)/btf_data.bpf.o
+$(RDIR)/resolve_btfids.test.o: private TEST_NEEDS_BTFIDS = 1
+
+# Compile individual test files.
+# Note: we cd into the output directory to ensure embedded BPF objects
+# are found. The %.test.d dependency files are a side effect of the -MMD
+# below; the separate no-recipe rule for them orders the first
+# compilation after skeleton generation and re-orders test object
+# compilation when headers change.
+$(TEST_OBJS): $(RDIR)/%.test.o: $(TESTS_DIR)/%.c | $(RDIR)/%.test.d
+	$(call msg,TEST-OBJ,$(BINARY),$@)
+	$(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< -o $(@F)) \
+		$(if $(PERMISSIVE_TESTS),$(call skip_on_fail,TEST))
+	$(if $(TEST_NEEDS_BTFIDS),					\
+		$(Q)if [ -f $@ ]; then					\
+		$(if $(filter 1,$(V)),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(BINARY)]" "$(notdir $@)"); \
+		$(RESOLVE_BTFIDS) --btf $(RDIR)/btf_data.bpf.o $@;	\
+		$(RESOLVE_BTFIDS) --patch_btfids $@.BTF_ids $@;		\
+		fi)
+
+$(TEST_DEPS): $(RDIR)/%.test.d: $(TESTS_DIR)/%.c $(GENERATED_HDRS) $(BPFOBJ) \
+	      | $(RDIR) $(ALL_SKELS)
+
+include $(wildcard $(TEST_DEPS))
+
+# Non-flavored in-srctree builds receive special treatment, in particular
+# we do not need to copy extra resources (see e.g. test_btf_dump_case()).
+.PHONY: extras
+extras: $(if $(PERMISSIVE),$(wildcard $(EXTRA_FILES)),$(EXTRA_FILES)) | $(RDIR)
+ifneq ($(FLAVOR):$(OUTPUT),:$(CURDIR))
+ifneq ($(strip $(EXTRA_FILES)),)
+	$(call msg,EXT-COPY,$(BINARY),$(notdir $(EXTRA_FILES)))
+	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args) $(EXTRA_FILES) $(RDIR)/
+endif
+endif
+
+# In permissive mode, link whatever test objects were successfully built
+# (their compilation may have been skipped): the objects existing at
+# parse time are normal prerequisites - so editing a test source still
+# relinks the runner - while the full set stays order-only to drive the
+# build attempts, and the wildcard in the recipe picks up the survivors
+# at link time.
+# Prerequisite order is also link order (test objects, runner objects,
+# libbpf, lib objects).
+$(OUTPUT)/$(BINARY): $(if $(PERMISSIVE_TESTS),$(wildcard $(TEST_OBJS)),$(TEST_OBJS)) \
+		     $(RUNNER_OBJS-$(RUNNER)) $(BPFOBJ)			\
+		     $(RUNNER_LIB_OBJS-$(RUNNER))			\
+		     $(TRUNNER_BPFTOOL) $(OUTPUT)/veristat		\
+		     | extras $(BPF_OBJS)				\
+		     $(if $(PERMISSIVE_TESTS),$(TEST_OBJS))
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS)						\
+		$(if $(PERMISSIVE_TESTS),$(wildcard $(TEST_OBJS))	\
+			$(filter-out $(TEST_OBJS),$(filter %.a %.o,$^)),\
+			$(filter %.a %.o,$^))				\
+		$(LDLIBS) $(LLVM_LDLIBS) $(LDFLAGS) $(LLVM_LDFLAGS) -o $@
+	$(Q)ln -sf $(if $(FLAVOR),..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
+		   $(RDIR)/bpftool
diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
new file mode 100644
index 000000000000..bd6b7d1152f6
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: GPL-2.0
+# Rules to build the BPF objects and skeletons of one build flavor,
+# shared by the main Makefile (which instantiates them for the default
+# flavor, so that bench, test_maps, xskxceiver, test_cpp and the
+# install rule can depend on the exact files they consume) and by
+# Makefile.runner (which instantiates them for the flavored runner
+# instances in their own output directories).
+#
+# Parameters (variables defined by the includer):
+#   RDIR             output directory of this flavor
+#   FLAVOR           flavor name, empty for the default
+#   BINARY           runner binary name, for build-log messages
+#   BPF_CC           BPF compiler
+#   BPF_CC_MSG       build-log tag (CLNG-BPF/GCC-BPF)
+#   BPF_CC_FLAGS     per-flavor compiler flags
+#   BPF_SYS_INCLUDES system include flags for $(BPF_CC)
+#   BPF_DEFINES      extra defines (-DENABLE_ATOMICS_TESTS)
+#
+# The default flavor's rules are instantiated identically by the main
+# Makefile and by the unflavored runner sub-makes; the main Makefile
+# lists every skeleton and BPF object as a prerequisite of the runner
+# delegation rules, so the files are always fresh by the time a runner
+# sub-make re-evaluates them.
+
+# ---------------------------------------------------------------------
+# BPF objects and skeletons
+# ---------------------------------------------------------------------
+
+ifneq ($(BPF_CC),)
+
+BPF_SRCS := $(notdir $(wildcard progs/*.c))
+BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
+
+LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
+	core_kern.c core_kern_overflow.c test_ringbuf.c			\
+	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
+	test_ringbuf_overwrite.c
+
+LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
+
+SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c \
+		  $(LSKELS) $(LSKELS_SIGNED)
+
+# Skeletons made by linking multiple BPF objects together. The %-deps
+# mapping is the only hand-maintained metadata: it cannot be derived from
+# the sources.
+test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
+linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
+linked_vars.skel.h-deps := linked_vars1.bpf.o linked_vars2.bpf.o
+linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
+# In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
+# but that's created as a side-effect of the skel.h generation.
+test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
+test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
+test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
+tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
+tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_session.skel.h-deps := tracing_multi_session_attach.bpf.o tracing_multi_check.bpf.o
+
+LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
+		linked_vars.skel.h linked_maps.skel.h			\
+		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
+		test_usdt.skel.h tracing_multi.skel.h			\
+		tracing_multi_module.skel.h				\
+		tracing_multi_intersect.skel.h				\
+		tracing_multi_session.skel.h
+
+LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
+
+# Generate both light skeleton and libbpf skeleton for these
+LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
+	kfunc_call_test_subprog.c test_global_percpu_data.c
+
+SKELS := $(patsubst %.c,$(RDIR)/%.skel.h,				\
+	   $(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),$(BPF_SRCS)))
+LSKELS_H        := $(patsubst %.c,$(RDIR)/%.lskel.h,$(LSKELS) $(LSKELS_EXTRA))
+LSKELS_SIGNED_H := $(patsubst %.c,$(RDIR)/%.lskel.h,$(LSKELS_SIGNED))
+LINKED_SKELS_H  := $(addprefix $(RDIR)/,$(LINKED_SKELS))
+ALL_SKELS := $(SKELS) $(LSKELS_H) $(LSKELS_SIGNED_H) $(LINKED_SKELS_H)
+
+HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)			\
+			$(wildcard $(CURDIR)/libarena/include/*.[ch])	\
+			$(addprefix $(BPFDIR)/,	bpf_core_read.h		\
+						bpf_endian.h		\
+						bpf_helpers.h		\
+						bpf_tracing.h)
+
+# Per-source BPF compilation flag overrides ($<-CFLAGS / $<-$(FLAVOR)-CFLAGS).
+# GCC cannot disable "declaration of anonymous struct in parameter list"
+# warnings triggered by these (technically legal) test programs.
+progs/btf_dump_test_case_bitfields.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
+
+$(BPF_OBJS): $(RDIR)/%.bpf.o: progs/%.c progs/*.h			\
+	     $(INCLUDE_DIR)/vmlinux.h $(HEADERS_FOR_BPF_OBJS)		\
+	     | $(RDIR) $(BPFOBJ)
+	$(call msg,$(BPF_CC_MSG),$(BINARY),$@)
+	$(Q)$(BPF_CC) $(BPF_CFLAGS) $(BPF_SYS_INCLUDES) $(BPF_DEFINES)	\
+		$($<-CFLAGS) $($<-$(FLAVOR)-CFLAGS)			\
+		$(BPF_CC_FLAGS) -c $< -o $@ $(call skip_on_fail,BPF)
+
+# gen_bpf_skel.sh picks the bpftool binary up from the environment.
+export BPFTOOL
+GEN_SKEL := ./gen_bpf_skel.sh
+
+$(SKELS): $(RDIR)/%.skel.h: $(RDIR)/%.bpf.o $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$<,$(@:.skel.h=.subskel.h))	\
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	$(GEN_SKEL) --name $*						\
+		--skel $@ --subskel $(@:.skel.h=.subskel.h) $<		\
+		$(call skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+$(LSKELS_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$<)				\
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	$(GEN_SKEL) --name $*_lskel --lskel				\
+		--skel $@ $< $(call skip_on_fail,SKEL)
+
+$(LSKELS_SIGNED_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL)	\
+		    $(GEN_SKEL) $(PRIVATE_KEY) $(VERIFICATION_CERT) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$<)				\
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY) (signed)]' '$(notdir $@)'; \
+	PRIVATE_KEY=$(PRIVATE_KEY)					\
+		VERIFICATION_CERT=$(VERIFICATION_CERT)			\
+		$(GEN_SKEL) --sign --name $*_lskel			\
+		--skel $@ $< $(call skip_on_fail,SKEL)
+
+.SECONDEXPANSION:
+$(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps)) \
+		   $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$(addprefix $(RDIR)/,$($*.skel.h-deps)),$(@:.skel.h=.subskel.h)) \
+	printf '  %-8s%s %s\n' 'LINK-BPF' ' [$(BINARY)]' '$(notdir $(@:.skel.h=.bpf.o))'; \
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	$(GEN_SKEL) --name $*						\
+		--skel $@ --subskel $(@:.skel.h=.subskel.h)		\
+		$(addprefix $(RDIR)/,$($*.skel.h-deps))			\
+		$(call skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+endif # BPF_CC
-- 
2.43.0

