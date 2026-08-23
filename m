Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B303AF660
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514199; cv=none; b=b+l37ZGS33Mn0ZsTvOELbkPVxAcgHNKpcM7VuZ6PsGiFNWgwMjmXd66kZYcj4KGXD76qXCrZHMTnQOz1Ss0abe2ykhFKhm6d1I5w2TmTQIlzHaiV2lQcz9oXTdewuEQd9pREMffiIINU7LctYr56WLAjLzZgE5nU5+WFqAGv3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514199; c=relaxed/simple;
	bh=OjvTEvumgytDMbCv9R29Et2RWJGHO/ONMevDa5e88pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzi1WVpwZhMShrTykBa1/jE/6VPIZInGHbfLJM/9rHC3nxM1vhpyVjJoUGVkpxWpyxozuHskV3tYImL186/8w4ng3elyLUKmMCrEOFKszc8boKZqFtAYA5lk3n8DhbQLrUeII7rXgN5dtAD9pz5b3gg3OAOtLIx1lKfmf0GAnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWVzqRQ3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWVzqRQ3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2163313a91.2
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514196; x=1788118996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkWm12bEYYWEcuCTjopZZjietQQo0jH7pug9NjLnoUk=;
        b=KWVzqRQ39Ikgyvd54DBbBTT0aoPwOrT5p55q9tQuM6mzuEejpfFI3T1/7m1itdbQfT
         NNCTmBNC0/PiXJLrezeXbizjXdJhDh6ItCcfq663TOkg2gx9g+jKVh7VqHkdMOLbEwnn
         ukksNn2qN23cqjiOOlZcAgmSfLd9w1+J0tMKQKLY8LJwDgYu+YF0mN62qnTy/YdiW1ny
         B2J186MdTN4lpV8G+85kpFnpUMwegcyNw31t/vNJv3mZ0MeIKpTNiXkLa8jsXzRFsgv0
         5nY/nO2F/P7XA4pNuWJ9oD9TNAP00Wem+vUtqAH0cY9Dq4ovB1hmUey1FB1M21rcXbUO
         ZUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514196; x=1788118996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hkWm12bEYYWEcuCTjopZZjietQQo0jH7pug9NjLnoUk=;
        b=GTcnRKCsqSkSu0m3JSq4JazQP+gqQkrO/VlYxQDzZLOC8cCcl6PzGZrrRszc+e8Mpz
         5C/S0t05JxuVVO9+3ocV5lpiJfiAq9m1yWAbRH0MpP9gInQgMe9yPPQzTGASMQ1aqUR4
         Bs+emEcsa8GGBnODwnqPQNiPAiJM+Y+pbK9HdZ4Vk9d7+DzpkE1CapsSPGKo4JnUllFw
         /FeiEe1jD22kPE1VoqQ+v4YOKmbCsP6+M5GJHOp3qAyyOdMQJmULUxMbd16N/hTwDn35
         htLkR0GDnYkdQXez3AK3kfiG5gqv5KfdyTpJ0uETF1Gs6+257YVWIFpioPBJFvoNTLC+
         davw==
X-Gm-Message-State: AFuF++nIqB4MdLwEtFFXtHY21V5jzGKfkoAojhh5JizmkB2U15S4zbbc
	q7Tu1nBz47xe9AAFWFLeWXoNU6Pp9RXIKFMCkZR5cXjNnPggXNBoMdyTASXjtmgU
X-Gm-Gg: AR+sD104VNpErX4fb3TiCqWQsbKP7qNyjASJSq60ZeUVd6JhPuhau5MajFJY8l3v9MI
	zNQ332xrEmPjLPOoJD3iMzeo8qAkvksWI3lmEPHmasUGs6d7xyMVxLZ468pYhfALlLGYiNTbZH0
	iirwS5gv6hO7tOXsBFI0m6Z9qs03ZFwoQlhmVuGJNhj8U0t8QJYqQk/vRkVj+z9k5G4GB4GgqIC
	7Sri9INCvUsQC3iPlxgG/7JEkCvD7Fp8F+gc0ES6w8OZhKr+2hizJQDTq/5EQu5WUAJbB8G30Lx
	Lc/vUZomwj2vc7l44ktIy1v/H+/dwpxDPLLvMb65gFt/jW4lEvDLZJmpau27s7AkOvjS2FhgcLc
	y5ReceShXBxSmBZ8xyWGiKH8chcKinmn2jF5U+yfBWWfBMrACqk9pOzaY+n7gHJUsVcjUiluhDe
	YIAR9Enj64JeJn9StQPqstymDmCsajgSZbL+jZFxjey5pIdJ/OKM7q69IgW889mkYC+X7d0Rt/T
	YIkLY4QOAde5Icy0T0r6MCBm672BXbCiOuEwxZErOYnFZQoEVChzeY=
X-Received: by 2002:a17:90b:5303:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-395c354cbffmr37762881a91.3.1787514195276;
        Sun, 23 Aug 2026 12:43:15 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 9/9] selftests/bpf: build each test runner instance in its own sub-make
Date: Sun, 23 Aug 2026 12:42:41 -0700
Message-ID: <20260823194241.3415152-10-nickolay.lysenko@gmail.com>
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

Replace the DEFINE_TEST_RUNNER/DEFINE_TEST_RUNNER_RULES double-expansion
machinery - whose rules never appear in the source as written, are
invisible to make's own debugging facilities, and are easy to break
for one flavor while testing another - with Makefile.runner: one
sub-make invocation per test runner
instance (test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_progs-bpf_gcc, test_maps), each in its own single-flavor namespace
written in plain make - no define/eval layer, no per-flavor guards,
no accumulating vpath directives.

The main Makefile keeps everything that exists once - tool sub-builds,
vmlinux.h, signing keys, tests.h generation, standalone binaries and
the kselftest lib.mk contract - and delegates to the runner through
explicit per-instance rules.

The rules for one flavor's BPF objects and skeletons live in
Makefile.skel, instantiated by the main Makefile for the default
flavor and by each runner sub-make that builds BPF objects. lib.mk's
install rule copies the default flavor's BPF objects - the files the
flat copy of every flavor's objects resolved to before. No file is
built twice in one build: the main Makefile produces the default
flavor's artifacts before the unflavored test_progs sub-make runs,
and each flavored runner writes its own subdirectory plus its binary
in $(OUTPUT) (the bpftool
link in $(OUTPUT) is refreshed by both unflavored sub-makes, as
before).

The runner instances link userspace objects the main Makefile
builds once; the
flavored instances link the shared objects instead of compiling
their own identical copies.

This also fixes a latent parallel-build race: the runner objects
including libbpf's internal headers now order against the bpftool
sub-build that installs them into $(INCLUDE_DIR).

Smaller behaviour changes that come with the move, for the record:
the skeleton recipes' build-log lines take the msg helper's format
and stream, the shared userspace objects log as CC rather than
EXT-OBJ/LIB-OBJ, and TEST-HDR lines lose their runner tag; the signed
light-skeleton rule lists the key and certificate it uses as
prerequisites; the extras copy skips an empty file list and, in
permissive mode, does not wait for files whose build was skipped;
$(OUTPUT)/test_maps waits for the same shared prerequisites as the
other runners; the bare-name convenience targets for the
linked-skeleton constituents (make linked_funcs1.bpf.o) are gone; the
.d include no longer special-cases the clean, docs-clean and
emit_tests goals,
which a runner sub-make never runs; and the test objects' first-build
ordering lists only the generated headers the runner itself consumes,
the rest being built by the main Makefile before any runner starts.

The runner sub-makes receive CC and CLANG as resolved by lib.mk on
their command line: Makefile.buildvars probes clang's capabilities
with $(CLANG), and a runner has to reach the same verdict as the top
level when LLVM=<suffix or path> selects a non-default toolchain.
The unflavored in-tree instance skips the extras copy as before; the
runner compares the realpath of $(OUTPUT) with $(CURDIR), make's
physical working directory, so a tree reached through a symlink
still counts as in-tree. The userspace objects depend on the
generated tests.h of the runner that includes them only
(test_progs.o on prog_tests/tests.h, test_maps.o on
map_tests/tests.h); before, every extra object of a runner depended
on that runner's tests.h. The other headers those objects depended
on - flow_dissector_load.h, ip_check_defrag_frags.h, the libarena
skeletons - are included by none of them and are dropped.

Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 475 +++++-------------
 .../testing/selftests/bpf/Makefile.buildvars  |  12 +
 tools/testing/selftests/bpf/Makefile.runner   | 199 ++++++++
 tools/testing/selftests/bpf/Makefile.skel     | 141 ++++++
 4 files changed, 478 insertions(+), 349 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100644 tools/testing/selftests/bpf/Makefile.skel

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 432897613b90..9b9905610070 100644
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
@@ -156,6 +143,9 @@ ifeq ($(feature-llvm),1)
 endif
 endif
 
+# Some utility functions use LLVM libraries
+$(OUTPUT)/jit_disasm_helpers.o: CFLAGS += $(LLVM_CFLAGS)
+
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../../../vmlinux				\
@@ -174,7 +164,7 @@ $(notdir $(TEST_GEN_PROGS) $(TEST_KMODS)				\
 	 $(TEST_GEN_PROGS_EXTENDED)): %: $(OUTPUT)/% ;
 
 # sort removes libbpf duplicates when not cross-building
-MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	\
+MAKE_DIRS := $(sort $(OUTPUT) $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf \
 	       $(BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/bpftool		\
 	       $(HOST_BUILD_DIR)/resolve_btfids				\
 	       $(INCLUDE_DIR))
@@ -260,9 +250,31 @@ $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
 $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
 $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS) flow_dissector_load.h
-$(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
-$(OUTPUT)/xsk.o: $(BPFOBJ)
+
+# Defined ahead of the first rule that lists it as a prerequisite.
+VERIFY_SIG_HDR := verification_cert.h
+
+# The userspace objects the runner instances link (RUNNER_OBJS, see
+# Makefile.buildvars) are built here, once, so that no runner sub-make
+# ever writes a file this Makefile also builds.
+#
+# $(TRUNNER_BPFTOOL) is a prerequisite because its sub-make is what
+# installs libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h)
+# into $(INCLUDE_DIR) - the cross-compiled bpftool's when cross-compiling;
+# without it, trace_helpers.c races the install and can silently pick up
+# the source-tree copies instead.
+RUNNER_OBJS := $(sort $(RUNNER_OBJS-test_progs) $(RUNNER_OBJS-test_maps)\
+		      $(RUNNER_LIB_OBJS-test_progs))
+$(RUNNER_OBJS): $(VERIFY_SIG_HDR) $(BPFOBJ) $(TRUNNER_BPFTOOL)
+$(OUTPUT)/test_progs.o: prog_tests/tests.h
+$(OUTPUT)/test_maps.o: map_tests/tests.h
+
+# find_bit.c is the only runner source outside this directory,
+# so it needs a rule of its own.
+$(OUTPUT)/find_bit.o: $(TOOLSDIR)/lib/find_bit.c
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $< $(LDLIBS) -o $@
 
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
@@ -331,7 +343,7 @@ endif
 
 # vmlinux.h is first dumped to a temporary file and then compared to
 # the previous version. This helps to avoid unnecessary re-builds of
-# $(TRUNNER_BPF_OBJS)
+# BPF objects.
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 	$(call msg,GEN,,$@)
@@ -356,274 +368,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		HOSTPKG_CONFIG='$(PKG_CONFIG)' \
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
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
-
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
-VERIFY_SIG_HDR := verification_cert.h
-
 # One genkey run produces both files. A plain two-target rule is not
 # grouped - if both files are stale make would run genkey twice, under
 # -j concurrently, and the openssl invocations race; the pattern form
@@ -672,76 +416,109 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
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
+# The LLVM feature-probe results and TEST_KMODS are exported
+# to the runner sub-makes. CC is passed explicitly instead: exporting it
+# would also leak lib.mk's CC into the libbpf sub-build, which computes
+# its own. ('export NAME' on an undefined
+# variable creates an empty one, so these stay below the definitions.)
+export LLVM_LDLIBS LLVM_LDFLAGS TEST_KMODS
+export INHERITED_CFLAGS INHERITED_LDFLAGS
+
+RUNNER_MAKE := $(MAKE) -f Makefile.runner OUTPUT=$(OUTPUT) CC='$(CC)'	\
+	       CLANG='$(CLANG)'
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
+# well as inside the runner sub-makes: bench, xskxceiver, xdp_* and
+# test_cpp depend on individual skeletons, and lib.mk's
+# install rule copies the BPF objects. Instantiate the shared rules
+# (Makefile.skel) for the default flavor, so those consumers depend on
+# exactly the files they use; the unflavored runners' delegation rules
+# below list the whole set as prerequisites, so those sub-makes find the
+# files this Makefile owns up to date.
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
+# Sys includes come from the *host* gcc, not $(BPF_GCC), as the rule
+# this replaces had it.
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
+# test_maps compiles map_tests/*.c against the default flavor's skeletons
+$(OUTPUT)/test_maps: $(RUNNER_PREREQS) $(BPF_OBJS)	\
+		     $(ALL_SKELS) FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_maps FLAVOR= TESTS_DIR=map_tests
+
+TEST_GEN_FILES += $(BPF_OBJS)
 
 # Define test_verifier test runner.
 # It is much simpler than test_maps/test_progs and sufficiently different from
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
index dc0be9ee72bc..5c6c147d03c7 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -182,3 +182,15 @@ ifneq ($(CLANG_HAS_ARENA_ASAN),)
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
index 000000000000..7361ff7de330
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.runner
@@ -0,0 +1,199 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Build one BPF test-runner instance: test_progs, one of its flavors
+# (no_alu32, cpuv4, bpf_gcc), or test_maps.
+#
+# Each instance is an independent sub-make - the flavored ones with their
+# own output directory, the unflavored ones sharing $(OUTPUT) with the
+# main Makefile - so everything here is written in plain make: no
+# define/eval layer, no per-flavor guards. This file is always
+# invoked by the main Makefile, never directly: all shared
+# prerequisites (libbpf, bpftool,
+# resolve_btfids, vmlinux.h, veristat, userspace objects, signing key,
+# libarena skeletons, extra binaries and - for the
+# unflavored instances - the default flavor's BPF objects and
+# skeletons) are built by the main Makefile *before* this one runs and
+# are referenced below as plain files.
+#
+# Parameters, passed on the sub-make command line:
+#   OUTPUT      the selftests output directory, as lib.mk resolved it
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
+#   CC, CLANG   C compiler and clang (as resolved by lib.mk in the main
+#               Makefile; clang also drives the feature probes in
+#               Makefile.buildvars)
+#
+# From the environment, exported by the main Makefile:
+#   LLVM_LDLIBS/LLVM_LDFLAGS
+#               results of the top-level LLVM feature probe
+#   TEST_KMODS  the kernel test modules to copy into a flavor directory
+#   INHERITED_CFLAGS/INHERITED_LDFLAGS
+#               the flags the main Makefile inherited from its own
+#               environment (see Makefile.buildvars)
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
+# The top Makefile hands down the flags it inherited from the
+# environment in INHERITED_CFLAGS/INHERITED_LDFLAGS; start from those
+# rather than from its assembled CFLAGS/LDFLAGS, which make exports
+# alongside whenever they came from the environment.
+CFLAGS := $(INHERITED_CFLAGS)
+LDFLAGS := $(INHERITED_LDFLAGS)
+
+include Makefile.buildvars
+
+# Keep in sync with the CFLAGS/LDFLAGS additions in ../lib.mk, in its
+# order (the selftests include path is spelled from srctree here; lib.mk
+# spells it from its own directory).
+ifneq ($(LLVM),)
+CFLAGS += -Wno-address-of-packed-member
+CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
+endif
+CFLAGS += -D_GNU_SOURCE=
+CFLAGS += -I$(srctree)/tools/testing/selftests
+CFLAGS += $(USERCFLAGS)
+LDFLAGS += $(USERLDFLAGS)
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
+# Permissive build behaviour (skip-on-failure compile, partial-link) only
+# applies to test_progs and its flavors; runners that use strong cross-object
+# references (e.g. test_maps) keep strict semantics even when permissive.
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
+EXTRA_FILES := $(OUTPUT)/urandom_read				\
+	       $(OUTPUT)/liburandom_read.so			\
+	       $(OUTPUT)/xdp_synproxy				\
+	       $(OUTPUT)/sign-file				\
+	       $(OUTPUT)/uprobe_multi				\
+	       $(addprefix $(OUTPUT)/,$(TEST_KMODS))		\
+	       ima_setup.sh 					\
+	       $(VERIFY_SIG_SETUP)				\
+	       $(wildcard progs/btf_dump_test_case_*.c)		\
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
+# When the compiler generates a %.d file, only skel basenames (not
+# full paths) are specified as prerequisites for corresponding %.o
+# file. vpath directives below instruct make to search for skel files
+# in $(RDIR), if they are not present in the working directory.
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
+# compile individual test files
+# Note: we cd into output directory to ensure embedded BPF object is found
+# The %.test.d dependency files are a side effect of the -MMD below; the
+# separate no-recipe rule for them orders the first compilation after
+# skeleton generation and re-orders test object compilation when headers
+# change.
+$(TEST_OBJS): $(RDIR)/%.test.o: $(TESTS_DIR)/%.c | $(RDIR)/%.test.d
+	$(call msg,TEST-OBJ,$(BINARY),$@)
+	$(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< $(LDLIBS) -o $(@F)) \
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
+# non-flavored in-srctree builds receive special treatment, in particular, we
+# do not need to copy extra resources (see e.g. test_btf_dump_case())
+.PHONY: extras
+extras: $(if $(PERMISSIVE),$(wildcard $(EXTRA_FILES)),$(EXTRA_FILES)) | $(RDIR)
+ifneq ($(FLAVOR):$(realpath $(OUTPUT)),:$(CURDIR))
+ifneq ($(strip $(EXTRA_FILES)),)
+	$(call msg,EXT-COPY,$(BINARY),$(EXTRA_FILES))
+	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args) $(EXTRA_FILES) $(RDIR)/
+endif
+endif
+
+# some X.test.o files have runtime dependencies on Y.bpf.o files
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
index 000000000000..a871ea76817d
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: GPL-2.0
+# Rules to build the BPF objects and skeletons of one build flavor,
+# shared by the main Makefile (which instantiates them for the default
+# flavor, so that bench, xskxceiver, xdp_* and test_cpp can depend on
+# the exact skeletons they consume) and by Makefile.runner (which
+# instantiates them for each runner instance that builds BPF objects:
+# the flavored ones in their own output directories, the unflavored
+# test_progs one in $(OUTPUT), where it finds them already built).
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
+# Makefile and by the unflavored test_progs sub-make; the main Makefile
+# lists every skeleton and BPF object as a prerequisite of the unflavored
+# runners' delegation rules, so the files are always fresh by the time
+# that sub-make re-evaluates them.
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
+SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
+
+LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
+		linked_vars.skel.h linked_maps.skel.h 			\
+		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
+		test_usdt.skel.h tracing_multi.skel.h			\
+		tracing_multi_module.skel.h				\
+		tracing_multi_intersect.skel.h				\
+		tracing_multi_session.skel.h
+
+LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
+	core_kern.c core_kern_overflow.c test_ringbuf.c			\
+	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
+	test_ringbuf_overwrite.c
+
+LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
+
+# Generate both light skeleton and libbpf skeleton for these
+LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
+	kfunc_call_test_subprog.c test_global_percpu_data.c
+SKEL_BLACKLIST += $(LSKELS) $(LSKELS_SIGNED)
+
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
+LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
+LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
+
+SKELS := $(patsubst %.c,$(RDIR)/%.skel.h,				\
+	   $(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),$(BPF_SRCS)))
+LSKELS_H        := $(patsubst %.c,$(RDIR)/%.lskel.h,$(LSKELS) $(LSKELS_EXTRA))
+LSKELS_SIGNED_H := $(patsubst %.c,$(RDIR)/%.lskel.h,$(LSKELS_SIGNED))
+LINKED_SKELS_H  := $(addprefix $(RDIR)/,$(LINKED_SKELS))
+ALL_SKELS := $(SKELS) $(LSKELS_H) $(LSKELS_SIGNED_H) $(LINKED_SKELS_H)
+
+HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
+			$(wildcard $(CURDIR)/libarena/include/*.[ch])	\
+			$(addprefix $(BPFDIR)/,	bpf_core_read.h	\
+			                        bpf_endian.h	\
+						bpf_helpers.h	\
+			                        bpf_tracing.h)
+
+# The following tests contain C code that, although technically legal,
+# triggers GCC warnings that cannot be disabled: declaration of
+# anonymous struct types in function parameter lists.
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
+GEN_SKEL := ./gen_bpf_skel.sh
+
+$(SKELS): $(RDIR)/%.skel.h: $(RDIR)/%.bpf.o $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$<,$(@:.skel.h=.subskel.h))	\
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) $(GEN_SKEL) --name $*						\
+		--skel $@ --subskel $(@:.skel.h=.subskel.h) $<		\
+		$(call skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+$(LSKELS_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$<)				\
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) $(GEN_SKEL) --name $*_lskel --lskel				\
+		--skel $@ $< $(call skip_on_fail,SKEL)
+
+$(LSKELS_SIGNED_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL)	\
+		    $(GEN_SKEL) $(PRIVATE_KEY) $(VERIFICATION_CERT) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$<)				\
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY) (signed)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) PRIVATE_KEY=$(PRIVATE_KEY)				\
+		VERIFICATION_CERT=$(VERIFICATION_CERT)			\
+		$(GEN_SKEL) --sign --name $*_lskel			\
+		--skel $@ $< $(call skip_on_fail,SKEL)
+
+# .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
+.SECONDEXPANSION:
+$(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps)) \
+		   $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(call skip_if_missing,SKEL,$(addprefix $(RDIR)/,$($*.skel.h-deps)),$(@:.skel.h=.subskel.h)) \
+	printf '  %-8s%s %s\n' 'LINK-BPF' ' [$(BINARY)]' '$(notdir $(@:.skel.h=.bpf.o))'; \
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) $(GEN_SKEL) --name $*						\
+		--skel $@ --subskel $(@:.skel.h=.subskel.h)		\
+		$(addprefix $(RDIR)/,$($*.skel.h-deps))			\
+		$(call skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+endif # BPF_CC
-- 
2.43.0

