Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD142E2663
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867190; cv=none; b=T4vTKUNci1QIdNa6eQfv3KmkdUodFk/OGiLyW8jT618r9g36ZzVF1gbOrcY8CZBWfIO6CbYJVmjLpbVdBm+6zwSLE1eTSD9Oc9OaeEFOWE3A6T7oUGemu2RAOMBpkYI9SbhVC1kkKwr1UJK7COSG8Lhn9jBSz5SW9JnU/Uq4OHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867190; c=relaxed/simple;
	bh=7HnEL2yCmGiYmEb6+OXjZiTRyzeClemdSBfsp6rP9pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+ki9wxpCsK8MYRVAx1UbzuZhuG5x8HnG1IIpHttvmHt1sO4V4S/ehH6RUd8PLbKcpUerXN9gvSZnD+k13xJdCzkgd44ISMI9bG/sn0wfPIPX3+Myp51v+A70avFAlhHRm/dJo1JcJElTrLNp2uzuxhxcRWbr3L58hldVZJIywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUTff+Ud; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUTff+Ud"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceae1ed204so364195ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784867187; x=1785471987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQ+yDzmyCWalJrDnGOXnGLJg/OdswTxPlYEHdjTd5E4=;
        b=bUTff+Ud+vHM/NzPxfiy5CRGuFoJqFy9shxyJ0OmZMYMCGNUz5fbGfSqAWdgVs4Lcn
         UmkxnTkwsdGNVoxkq8q6sAfm+GZnXYOXRLXtIpakqt9/VX4g9eCQ+2CxKKLKg4v7ai+R
         6Kku507iKP4+fn5Cj/IDaaLIlT/qhUMMRbwxCAwRe04MFyef36Ic4xZ3TcgErr46PXCd
         1k/iQB+Uvq5hNwV/rpHqJF4gn0CObbbhT126ivM285aNaZJUwENrwTxdbzzWV1BAjbk2
         YfrzbE/77Ro5SCwg388vI4Z55ByMJf3yFK2AdMvwZEJ5FaPC+1+sRfZXmBVt2uW9L3sj
         Dm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784867187; x=1785471987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQ+yDzmyCWalJrDnGOXnGLJg/OdswTxPlYEHdjTd5E4=;
        b=LdFHN7bxmz2TKZx+xD7jhzcFHgC/0aSGUdx6esC6adqafYpaTZeS3UOX3+0zQ1p9QH
         qinlMqdnHXZihhRB3HmSIbz9AFAk35hATPtZPyWTlwVdstabs5E0Yn1oGb5EoAB9ulLv
         1IKOBTAz7twed87jGfbWcTA2ArB8rzm8ijqTebfuHA6SVL8dCRoIRpnQGb7jYabPZ8QR
         vNfvhm1RbdpAW/hbHRPp/QNIVDOYTAQ9iyhHo/GRIeTYBvIgLYsYsTsYBRJ2VJ/vPWUG
         5sO44ivlocI0d3ybv4Ud4Occ1TJMZIsWaqlvLwn97bMt8e28WZ2ksLiTm4b6TikZZHiZ
         dT8Q==
X-Gm-Message-State: AOJu0YzYcW5lI9jHyPgPORzweQSGI6co8SCLpn0P7el5y5Ozoi8nbJmw
	02snq/01C6ZQkre6yvupesFH2sGsm6HqoBo7Lqby1HuvMkz98tkyWl4q+AhB3w92
X-Gm-Gg: AR+sD11JkGilfXHarOzqu1qpX/rXTXZSSlk2GT3PCj0sh3iqgzqrJ33Pezk+XmghYsQ
	iLbn5PAELnsOA2ax86yeGxabnbWZqx3ts47kBLPgl6/MrrmMcfr1+6M8VN0QdVUtSpw0eIci9H3
	OjEAMZfbLN8yck1C6aI8OA3XEX6nb3WhZzcHnPEYED4DfkwzHWpIDU6V5NlwLZK1kzlJsnnGfoO
	ZUUEEvABVnBh8SYD12jbAzE1xjj2qS3qahTzaAdQRbWIIVL9UhqkqVSpDQXYF47SCACdcYzSwwG
	I1o7UkBEGtChZQp9IHcqOsr0Pv9McoZahXgNe7K2e5eGbhekmP8PUbfhMIefMseKbIcEjxz4yIS
	ojsKlq/uA7A6qhzBJZYvfYduOW9caHuHl+5ok2yeou5KKXc//Eu8EdwsOynv7yI2x+wzbtxkfxg
	0kbRia6rR0pnoiQPkuMRXM/KJhoPNPrMT8
X-Received: by 2002:a17:902:ea05:b0:2c9:e9c7:2b59 with SMTP id d9443c01a7336-2cfa6c7569cmr72475365ad.35.1784867186023;
        Thu, 23 Jul 2026 21:26:26 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f0072a8sm44437015ad.34.2026.07.23.21.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 21:26:25 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v4 3/3] selftests/bpf: build each test runner instance in its own sub-make
Date: Thu, 23 Jul 2026 21:26:00 -0700
Message-ID: <20260724042600.175440-4-nickolay.lysenko@gmail.com>
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

Replace the DEFINE_TEST_RUNNER/DEFINE_TEST_RUNNER_RULES double-expansion
machinery with Makefile.runner: one sub-make invocation per test runner
instance (test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_progs-bpf_gcc, test_maps), each in its own single-flavor namespace
written in plain make - no $$-escaping, no per-flavor eval guards, no
accumulating vpath directives.

The main Makefile keeps everything that exists once - tool sub-builds,
vmlinux.h, signing keys, tests.h generation, shared helper objects,
standalone binaries and the kselftest lib.mk contract - and delegates to
the runner through explicit per-instance rules. Light-skeleton demand
lists are derived from the tests' own '#include "*.lskel.h"' lines; the
bench object list is derived from $(wildcard benchs/bench_*.c). The ~20
inline $(if $(PERMISSIVE),...) fragments collapse into one skip_on_fail
helper in Makefile.buildvars.

This also fixes a latent parallel-build race (objects including libbpf
internal headers now order against the bpftool sub-build that installs
them) and makes the signing key generation rule properly grouped (the
two-target form ran genkey twice concurrently under -j).

Validation is as for the whole series: BPF objects, skeleton headers,
userspace objects and 21/22 binaries byte-identical with the previous
Makefile (bench differs only in object link order); emit_tests and the
installed tree identical; BPF CI green on x86_64 gcc/llvm, aarch64 and
s390x including GCC-BPF, ASAN and veristat jobs; all 76 benchmarks
produce identical outcomes.

The shared helper objects the main Makefile pre-builds depend on a
superset of the prerequisites the runner's uniform object rule uses,
so the unflavored test_progs and test_maps sub-makes always see them
as up to date and never race to recompile them in the shared output
directory.

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

Four stale target-specific lines are dropped on the way:
'$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline' (and the
test_xdp_noinline sibling) attach to names nothing builds - the BPF
objects have been %.bpf.o for years - and the
$(OUTPUT)/flow_dissector_load.o / $(OUTPUT)/cgroup_getset_retval_hooks.o
header dependencies likewise name objects no rule produces.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 625 ++++++------------
 .../testing/selftests/bpf/Makefile.buildvars  |   8 +
 tools/testing/selftests/bpf/Makefile.runner   | 315 +++++++++
 3 files changed, 527 insertions(+), 421 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1843679fc..09cff693b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
+#
+# Everything that exists once lives here: toolchain setup, tool
+# sub-builds, vmlinux.h, shared helper objects, standalone binaries and
+# the lib.mk contract. Each test-runner instance (test_progs and its
+# flavors, test_maps) is built by its own Makefile.runner sub-make;
+# shared definitions live in Makefile.buildvars.
+
 include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
@@ -16,17 +23,10 @@ SKIP_LIBBFD	?=
 SKIP_CRYPTO	?=
 
 
-
-# Some utility functions use LLVM libraries
-jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
-
-
-# Check whether bpf cpu=v4 is supported or not by clang
 ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
 CLANG_CPUV4 := 1
 endif
 
-
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
 	test_sockmap \
@@ -38,16 +38,6 @@ TEST_INST_SUBDIRS := no_alu32
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
@@ -165,7 +155,7 @@ endif
 # to build individual tests.
 # NOTE: Semicolon at the end is critical to override lib.mk's default static
 # rule for binaries.
-$(notdir $(TEST_GEN_PROGS) $(TEST_KMODS)				\
+$(notdir $(TEST_GEN_PROGS) $(TEST_KMOD_TARGETS)				\
 	 $(TEST_GEN_PROGS_EXTENDED)): %: $(OUTPUT)/% ;
 
 # sort removes libbpf duplicates when not cross-building
@@ -179,11 +169,14 @@ $(MAKE_DIRS):
 
 $(OUTPUT)/%.o: %.c
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) -o $@
 
+# Headers may appear among the prerequisites for dependency tracking;
+# they must not reach the clang/gcc command line (clang treats a bare .h
+# argument as a precompiled-header job and refuses -o).
 $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
+	$(Q)$(LINK.c) $(filter-out %.h,$^) $(LDLIBS) -o $@
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
@@ -257,6 +250,39 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
+# All helper objects a runner instance links, pre-built here so runner
+# sub-makes sharing $(OUTPUT) never compile them concurrently.
+HELPER_OBJS := $(TESTING_HELPERS) $(CGROUP_HELPERS) $(UNPRIV_HELPERS)	\
+	       $(TRACE_HELPERS) $(JSON_WRITER) $(CAP_HELPERS)		\
+	       $(NETWORK_HELPERS) $(OUTPUT)/usdt_1.o $(OUTPUT)/usdt_2.o	\
+	       $(OUTPUT)/xsk.o
+
+# $(BPFTOOL) is a prerequisite because its sub-make is what installs
+# libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h) into
+# $(INCLUDE_DIR); without it, helpers including those headers race the
+# install and can silently pick up the source-tree copies instead.
+#
+# Invariant: this list must be a superset of every prerequisite the
+# runner's EXTRA_OBJS rule attaches to these same objects (EXTRA_HDRS,
+# both tests.h flavors, $(BPFOBJ)). It guarantees the helpers built
+# here are never older than a runner-side prerequisite, so the
+# unflavored test_progs and test_maps sub-makes, which share $(OUTPUT),
+# treat them as up to date instead of both recompiling the same object
+# file concurrently.
+$(HELPER_OBJS): flow_dissector_load.h ip_check_defrag_frags.h		\
+		$(VERIFY_SIG_HDR) $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)\
+		prog_tests/tests.h map_tests/tests.h $(BPFOBJ) $(BPFTOOL)
+
+$(OUTPUT)/flow_dissector_load: flow_dissector_load.h
+
+# ---------------------------------------------------------------------
+# Tool sub-builds: bpftool and libbpf (host and, when cross-compiling,
+# target variants) and resolve_btfids.
+#
+# Note the deliberate asymmetry: the host libbpf builds without
+# sanitizers and with the host toolchain.
+# ---------------------------------------------------------------------
+
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
@@ -324,7 +350,7 @@ endif
 
 # vmlinux.h is first dumped to a temporary file and then compared to
 # the previous version. This helps to avoid unnecessary re-builds of
-# $(TRUNNER_BPF_OBJS)
+# BPF objects.
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 	$(call msg,GEN,,$@)
@@ -349,292 +375,11 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		HOSTPKG_CONFIG='$(PKG_CONFIG)' \
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
-
-$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
-$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
-
-$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
-$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
-
-# Build BPF object using Clang
-# $1 - input .c file
-# $2 - output .o file
-# $3 - CFLAGS
-# $4 - binary name
-define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
-endef
-# Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
-define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
-endef
-# Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
-define CLANG_CPUV4_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
-endef
-# Build BPF object using GCC
-define GCC_BPF_BUILD_RULE
-	$(call msg,GCC-BPF,$4,$2)
-	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2 $(if $(PERMISSIVE),|| \
-		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
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
-	kfunc_call_test_subprog.c
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
-xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
-xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
-xdp_features.skel.h-deps := xdp_features.bpf.o
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
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
-		--name $$(notdir $$(<:.bpf.o=))					\
-		--skel $$@ --subskel $$(@:.skel.h=.subskel.h) $$< $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h);				\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
-
-$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
-		--name $$(notdir $$(<:.bpf.o=_lskel)) --lskel			\
-		--skel $$@ $$< $(if $(PERMISSIVE),|| {				\
-		$$(RM) $$@;							\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
-
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
-	$(Q)BPFTOOL=$$(BPFTOOL) PRIVATE_KEY=$(PRIVATE_KEY)			\
-		VERIFICATION_CERT=$(VERIFICATION_CERT)				\
-		./gen_bpf_skel.sh --sign					\
-		--name $$(notdir $$(<:.bpf.o=_lskel))				\
-		--skel $$@ $$< $(if $(PERMISSIVE),|| {				\
-		$$(RM) $$@;							\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
-
-$(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
-
-# .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
-.SECONDEXPANSION:
-$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
-	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.bpf.o))
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
-		--name $$(notdir $$(@:.skel.h=))				\
-		--skel $$@ --subskel $$(@:.skel.h=.subskel.h)			\
-		$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h);				\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
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
-	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),|| \
-		($(RM) $$@; printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)))
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
-
-$(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
+# One genkey run produces both files. A plain two-target rule is not
+# grouped - under -j make would run genkey twice concurrently and the
+# openssl invocations race; the pattern form is implicitly grouped even
+# with make < 4.3 (same workaround as the test_kmods rule).
+$(BUILD_DIR)/%.pem $(BUILD_DIR)/%.der: $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
@@ -663,113 +408,162 @@ LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
 				 libarena/selftests/*		\
 				 libarena/*.bpf.o)
 
-
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
 
 ifneq ($(CLANG_HAS_ARENA_ASAN),)
-
 $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
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
+# ---------------------------------------------------------------------
+# Generated test list headers
+# ---------------------------------------------------------------------
+
+define gen_tests_hdr
+	$(call msg,TEST-HDR,,$@)
+	$(Q)(echo '/* Generated header, do not edit */';		\
+	     sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p' \
+		$(@D)/*.c | sort) > $@
+endef
+
+prog_tests/tests.h: $(wildcard prog_tests/*.c)
+	$(gen_tests_hdr)
+
+map_tests/tests.h: $(wildcard map_tests/*.c)
+	$(gen_tests_hdr)
+
+# ---------------------------------------------------------------------
+# Test runner instances, one sub-make each (see Makefile.runner).
+# ---------------------------------------------------------------------
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
+		  $(HELPER_OBJS)					\
+		  $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so	\
+		  $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file		\
+		  $(OUTPUT)/uprobe_multi $(TEST_KMOD_TARGETS)
+
+FORCE:
+
+# The default flavor's skeletons are also inputs of bench, test_maps,
+# xskxceiver, xdp_* and test_cpp; "default-skels" builds just those
+# without the test_progs test objects and binary.
+.PHONY: default-skels
+default-skels: $(RUNNER_PREREQS)
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR= TESTS_DIR=prog_tests \
+		BPF_CC='$(CLANG)' BPF_CC_MSG=CLNG-BPF BPF_SYS_INCLUDES='$(CLANG_SYS_INCLUDES)'	\
+		BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v3'		\
+		BPF_DEFINES=-DENABLE_ATOMICS_TESTS skels
+
+$(OUTPUT)/test_progs: $(RUNNER_PREREQS) default-skels FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR= TESTS_DIR=prog_tests \
+		BPF_CC='$(CLANG)' BPF_CC_MSG=CLNG-BPF BPF_SYS_INCLUDES='$(CLANG_SYS_INCLUDES)'	\
+		BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v3'		\
+		BPF_DEFINES=-DENABLE_ATOMICS_TESTS
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
+$(OUTPUT)/test_maps: $(RUNNER_PREREQS) map_tests/tests.h default-skels FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_maps FLAVOR= TESTS_DIR=map_tests
+
+# Default-flavor BPF objects and skeletons consumed by targets in this
+# Makefile (and by lib.mk's install rule) are produced by the runner
+# sub-make above; the empty recipe plus the order-only prerequisite
+# makes them available here without duplicating the runner's rules.
+DEFAULT_BPF_OBJS := $(patsubst progs/%.c,$(OUTPUT)/%.bpf.o,$(wildcard progs/*.c))
+TEST_GEN_FILES += $(DEFAULT_BPF_OBJS)
+
+BENCH_SKELS := $(addprefix $(OUTPUT)/,					\
+	       test_overhead.skel.h trigger_bench.skel.h		\
+	       ringbuf_bench.skel.h perfbuf_bench.skel.h		\
+	       bloom_filter_bench.skel.h bpf_loop_bench.skel.h		\
+	       strncmp_bench.skel.h bpf_hashmap_full_update_bench.skel.h\
+	       local_storage_bench.skel.h				\
+	       local_storage_rcu_tasks_trace_bench.skel.h		\
+	       bench_local_storage_create.skel.h			\
+	       bpf_hashmap_lookup.skel.h htab_mem_bench.skel.h		\
+	       crypto_bench.skel.h bench_sockmap_prog.skel.h		\
+	       lpm_trie_bench.skel.h lpm_trie_map.skel.h		\
+	       bpf_nop_bench.skel.h xdp_lb_bench.skel.h)
+TOP_SKELS := $(addprefix $(OUTPUT)/,xsk_xdp_progs.skel.h		\
+	     xdp_hw_metadata.skel.h xdp_features.skel.h			\
+	     test_core_extern.skel.h) $(BENCH_SKELS)
+
+# Empty-recipe delegation: "default-skels" (re)builds the file via the
+# runner sub-make, after which make re-stats the target, so dependents
+# see fresh timestamps within the same invocation. Dependents still
+# rebuild on mtime only - the phony prerequisite does not cascade.
+$(DEFAULT_BPF_OBJS) $(TOP_SKELS): default-skels ;
+
+# ---------------------------------------------------------------------
+# Standalone test binaries
+# ---------------------------------------------------------------------
+
+# test_verifier is much simpler than test_maps/test_progs and
+# sufficiently different from them (e.g., its tests.h uses a completely
+# different pattern), that it's worth just defining its rules explicitly.
 verifier/tests.h: verifier/*.c
-	$(shell ( cd verifier/; \
-		  echo '/* Generated header, do not edit */'; \
-		  echo '#ifdef FILL_ARRAY'; \
-		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
-		  echo '#endif' \
-		) > verifier/tests.h)
-$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
+	$(Q)( cd verifier/; \
+	      echo '/* Generated header, do not edit */'; \
+	      echo '#ifdef FILL_ARRAY'; \
+	      ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
+	      echo '#endif' \
+	    ) > verifier/tests.h
+
+$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
 # Include find_bit.c to compile xskxceiver.
 EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tests/test_xsk.h
-$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
+$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp_features.skel.h | $(OUTPUT)
+$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp_features.skel.h
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
@@ -781,11 +575,18 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
 	$(Q)$(CXX) $(CXXFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
-# Benchmark runner
-$(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
+# ---------------------------------------------------------------------
+# Benchmark runner. The benchmark list is defined by the files in
+# benchs/: every benchs/bench_*.c is compiled and linked in.
+# ---------------------------------------------------------------------
+
+BENCH_OBJS := $(sort $(patsubst benchs/%.c,$(OUTPUT)/%.o,$(wildcard benchs/bench_*.c)))
+
+$(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ) | default-skels
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
-		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2))
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) -o $@ $(call skip_on_fail,BENCH)
+
+# benchmark-specific generated-skeleton dependencies
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -805,37 +606,19 @@ $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_tr
 $(OUTPUT)/bench_bpf_nop.o: $(OUTPUT)/bpf_nop_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_xdp_lb.o: $(OUTPUT)/xdp_lb_bench.skel.h bench_bpf_timing.h
 $(OUTPUT)/bench_bpf_timing.o: bench_bpf_timing.h
+
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
-$(OUTPUT)/bench: $(OUTPUT)/bench.o \
-		 $(TESTING_HELPERS) \
-		 $(TRACE_HELPERS) \
-		 $(CGROUP_HELPERS) \
-		 $(OUTPUT)/bench_count.o \
-		 $(OUTPUT)/bench_rename.o \
-		 $(OUTPUT)/bench_trigger.o \
-		 $(OUTPUT)/bench_ringbufs.o \
-		 $(OUTPUT)/bench_bloom_filter_map.o \
-		 $(OUTPUT)/bench_bpf_loop.o \
-		 $(OUTPUT)/bench_strncmp.o \
-		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
-		 $(OUTPUT)/bench_local_storage.o \
-		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
-		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
-		 $(OUTPUT)/bench_local_storage_create.o \
-		 $(OUTPUT)/bench_htab_mem.o \
-		 $(OUTPUT)/bench_bpf_crypto.o \
-		 $(OUTPUT)/bench_sockmap.o \
-		 $(OUTPUT)/bench_lpm_trie_map.o \
-		 $(OUTPUT)/bench_bpf_timing.o \
-		 $(OUTPUT)/bench_bpf_nop.o \
-		 $(OUTPUT)/bench_xdp_lb.o \
-		 $(OUTPUT)/usdt_1.o \
-		 $(OUTPUT)/usdt_2.o \
-		 #
+$(OUTPUT)/bench: $(OUTPUT)/bench.o		\
+		 $(OUTPUT)/testing_helpers.o	\
+		 $(OUTPUT)/trace_helpers.o	\
+		 $(OUTPUT)/cgroup_helpers.o	\
+		 $(OUTPUT)/usdt_1.o		\
+		 $(OUTPUT)/usdt_2.o		\
+		 $(BENCH_OBJS)
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
-		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some benchmarks may have been skipped)' 1>&2))
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ \
+		$(call skip_on_fail,LINK,,(some benchmarks may have been skipped))
 
 # This works around GCC warning about snprintf truncating strings like:
 #
@@ -863,7 +646,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 			       liburandom_read.so)			\
 	$(OUTPUT)/FEATURE-DUMP.selftests
 
-.PHONY: docs docs-clean
+.PHONY: docs docs-clean libarena libarena_asan
 
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
index ef12018fa..3a4962b05 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -46,6 +46,14 @@ LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 BPF_STRICT_BUILD ?= 1
 PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
 
+# Permissive-mode recipe suffix: on failure, remove the target, emit a
+# SKIP marker and report success so the rest of the build continues.
+# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
+# $(2) - optional extra files to remove alongside the target
+# $(3) - optional note appended to the SKIP message
+skip_on_fail = $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
+	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' 1>&2; })
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/selftests/bpf/Makefile.runner
new file mode 100644
index 000000000..ced44aad7
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.runner
@@ -0,0 +1,315 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Build one BPF test-runner instance: test_progs, one of its flavors
+# (no_alu32, cpuv4, bpf_gcc), or test_maps.
+#
+# Each instance is an independent sub-make with its own output directory,
+# so everything here is written in plain make - no $$-escaping, no eval,
+# no per-flavor guards. This file is always invoked by the main Makefile,
+# never directly: all shared prerequisites (libbpf, bpftool, vmlinux.h,
+# veristat, helper objects, signing key, generated tests.h, extra
+# binaries) are built by the main Makefile *before* this one runs and are
+# referenced below as plain files.
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
+EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c		\
+		 network_helpers.c testing_helpers.c btf_helpers.c	\
+		 cap_helpers.c unpriv_helpers.c sysctl_helpers.c	\
+		 netlink_helpers.c jit_disasm_helpers.c io_helpers.c	\
+		 test_loader.c xsk.c disasm.c disasm_helpers.c		\
+		 json_writer.c bpftool_helpers.c usdt_1.c usdt_2.c
+LIB_SOURCES := find_bit.c
+EXTRA_HDRS := flow_dissector_load.h ip_check_defrag_frags.h		\
+	      $(VERIFY_SIG_HDR) $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)
+EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so	\
+	       $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file		\
+	       $(OUTPUT)/uprobe_multi					\
+	       $(addprefix $(OUTPUT)/,$(TEST_KMODS))			\
+	       ima_setup.sh $(VERIFY_SIG_SETUP)				\
+	       $(wildcard progs/btf_dump_test_case_*.c)			\
+	       $(wildcard progs/*.bpf.o)
+endif
+
+ifeq ($(RUNNER),test_maps)
+EXTRA_SOURCES := test_maps.c testing_helpers.c
+endif
+
+# Note on the unflavored runners, which share $(OUTPUT) with the main
+# Makefile: helper objects the main Makefile also uses (and lists in the
+# runner prerequisites) are already built and fresh when a runner starts,
+# so the rules below find them up to date and never write them. This
+# holds because the main Makefile's helper-object rule depends on a
+# superset of the prerequisites the EXTRA_OBJS rule uses here - keep
+# the two lists in sync (see the invariant comment there).
+
+TESTS_HDR := $(TESTS_DIR)/tests.h
+
+TEST_SRCS  := $(notdir $(wildcard $(TESTS_DIR)/*.c))
+TEST_OBJS  := $(patsubst %.c,$(RDIR)/%.test.o,$(TEST_SRCS))
+TEST_DEPS  := $(TEST_OBJS:.o=.d)
+EXTRA_OBJS := $(patsubst %.c,$(RDIR)/%.o,$(filter %.c,$(EXTRA_SOURCES)))
+LIB_OBJS   := $(patsubst %.c,$(RDIR)/%.o,$(LIB_SOURCES))
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
+# BPF objects that cannot have a regular skeleton.
+SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
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
+	kfunc_call_test_subprog.c
+SKEL_BLACKLIST += $(LSKELS) $(LSKELS_SIGNED)
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
+LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
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
+	$(call msg,GEN-SKEL,$(BINARY),$@)
+	$(Q)$(GEN_SKEL) --name $*					\
+		--skel $@ --subskel $(@:.skel.h=.subskel.h) $<		\
+		$(call skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+$(LSKELS_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(call msg,GEN-SKEL,$(BINARY),$@)
+	$(Q)$(GEN_SKEL) --name $*_lskel --lskel				\
+		--skel $@ $< $(call skip_on_fail,SKEL)
+
+$(LSKELS_SIGNED_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL)	\
+		    $(GEN_SKEL) $(PRIVATE_KEY) $(VERIFICATION_CERT) | $(RDIR)
+	$(call msg,GEN-SKEL,$(BINARY) (signed),$@)
+	$(Q)PRIVATE_KEY=$(PRIVATE_KEY)					\
+		VERIFICATION_CERT=$(VERIFICATION_CERT)			\
+		$(GEN_SKEL) --sign --name $*_lskel			\
+		--skel $@ $< $(call skip_on_fail,SKEL)
+
+.SECONDEXPANSION:
+$(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps)) \
+		   $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(call msg,LINK-BPF,$(BINARY),$(@:.skel.h=.bpf.o))
+	$(call msg,GEN-SKEL,$(BINARY),$@)
+	$(Q)$(GEN_SKEL) --name $*					\
+		--skel $@ --subskel $(@:.skel.h=.subskel.h)		\
+		$(addprefix $(RDIR)/,$($*.skel.h-deps))			\
+		$(call skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+endif # BPF_CC
+
+.PHONY: skels
+skels: $(ALL_SKELS)
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
+$(TEST_DEPS): $(RDIR)/%.test.d: $(TESTS_DIR)/%.c $(EXTRA_HDRS) $(BPFOBJ) \
+	      | $(RDIR) $(ALL_SKELS)
+
+include $(wildcard $(TEST_DEPS))
+
+$(RDIR)/jit_disasm_helpers.o: CFLAGS += $(LLVM_CFLAGS)
+
+$(EXTRA_OBJS): $(RDIR)/%.o: %.c $(EXTRA_HDRS) $(TESTS_HDR) $(BPFOBJ) | $(RDIR)
+	$(call msg,EXT-OBJ,$(BINARY),$@)
+	$(Q)$(CC) $(CFLAGS) -c $< -o $@
+
+$(LIB_OBJS): $(RDIR)/%.o: $(TOOLSDIR)/lib/%.c | $(RDIR)
+	$(call msg,LIB-OBJ,$(BINARY),$@)
+	$(Q)$(CC) $(CFLAGS) -c $< -o $@
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
+# Prerequisite order is also link order (test objects, extra objects,
+# libbpf, lib objects).
+$(OUTPUT)/$(BINARY): $(if $(PERMISSIVE_TESTS),$(wildcard $(TEST_OBJS)),$(TEST_OBJS)) \
+		     $(EXTRA_OBJS) $(BPFOBJ) $(LIB_OBJS)		\
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
-- 
2.43.0

