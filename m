Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE444E64A
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977592; cv=none; b=ETbZnk8CxwtVuQumtIOCHGZviuBYtWqaz3szK5iRnQ6EdZBgidj7J/B9qQOETb+eNc2CZ7c0Heg+p+kRc6C/CAvcm0ZBJKOzx1J3+B8KMIyy62EsDI9e6ALaFENulsA/Rx4IHF0NjLXZZ+GZLOfdHtcvGVfE5PQfLOTvluZPnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977592; c=relaxed/simple;
	bh=dhj+sss7VzM4mfQh2Zqg2juHhYAc573X7wa02ECjktM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWJw5pPwEB55+tWWi+YwpCAXdNLivVyBdiQBkJrGybzEd55CygBFY0lVafVLKCIxL/frCUaXTViBqjR6iSNnfsC05W0VsvX/2eMyJLRs/NtOLnxvuvpMAP3rQ5mt0NbnRVYFOV7v3LjWYMOCwysnEfYijQFiZQG80Rb0X/hM+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPNnKtvK; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPNnKtvK"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so2288283a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977588; x=1790582388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iw0Ba4TSBeXzbvODDjPYUc2xXeQd9uIw9LFqYrwaP1I=;
        b=cPNnKtvKCPTNm2QmVq5e2oboWBBFTRCiVlhNQ0EF110NVZBjrgsXYDDnUrjYl8tesJ
         oG2n60vrIBMBJcZUObmyvY1E6wE3pydvxEVeYDeiRNGyRHPOmqDKDnynksqQn4HDU/AB
         iIL/M+ARkH3FrN+4QrE0P9cLbpPQUiBZMXFdlUg6It0rlV+/0n6yCEF/iJSzPwNYqTqp
         vg7/51hGHdw4myoJ46MnHH74XRy5SRKEXYVZP5cpR6JY58EDkLuHPe0iAAErKuOHaC/8
         +x57REfC+KKDeY8tmLMcuAUB/QIQkdKzQhZXSG/UEIGmM69lXVFqkaLZaUtUI56UoU9S
         mUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977588; x=1790582388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iw0Ba4TSBeXzbvODDjPYUc2xXeQd9uIw9LFqYrwaP1I=;
        b=ZrXf13VQ43YhX/l6NS14oVfSW+mRbIEXh1iV+ioNrEosLXg1WplhSz9KH5m4f7+bDX
         HFMI+JckC2dZdXH/I9OMOvxwME1d8hTNNqwbSg+YMGodxh+ftD2oaN95bZG+h55OZkIY
         NpnfnNQ16X25GXSRMLTA47ja1SYR9y9acjCLcae5DZCcFe6a+JHdAuvz6H8/OpYsV7b5
         7ho/VDFfG0BOhLf68uHEwrgT7NuYfDUbbBLNv+Vx8s1ZbxPTrEWP3aDIK0ySw5tQVY5q
         ctxyGwakzHexdFyyw8irdDTsbYE9f1ibsV9MKw4aqbfxcVhw1QNQSl9I9cwhI5u/doyv
         QBJQ==
X-Gm-Message-State: AFuF++nBRdZDYiO5XM3yJWeE29Y+UN7prB03HDWyYYabgNtrs4Uvk2Ob
	v44c3LOFlak9oUBOu/azoShyEDqX6epqgfvyjClqbed2o38LOPSgcOO1DhP24CzYMwY=
X-Gm-Gg: AYBFou0+EMudQYszdvCwebqcPutopPJa68ZNXUbEYetr/83HUGZ/gDo4ChL6YMOiRZt
	8tqh6vndFDCgOsLTusvbEyL3AXhOdcmYdISIUjC6Tp+d6Optr7fZ0rTC1IWE9ISc4lLJ7ZI0fKO
	Kt9RmFnnwAmlZGYmWcGuSCOzMtGLxkN54ENHxg3qN9eKIHBpmYkuJQQ/cqrP2aN0SWtry2z9RUB
	m64fFYEaI0RxUxYUARy/EJ1hKon4nleOiIOPBklXOGdaZaDHboMFnOatB6HerFhSCnJTmvbMBCI
	KNxoq/70OgeUh7YXzGv13McDIbbkvvg7ikR9+06ofymh/+aNFu8sXcsx+vjY0CZ9z9I0u5p4D1/
	+BnuR/mjmXHO5U63e644SrK4aCBvbfcnlhaOrlIGvGEmvO88MNHmbGRX+A5Aov72AN6PndXsaC2
	S2ie8KnCRwSMXpJrSEEx6N3B+8tS74VD+ETfh3EzOiwT9m9LhXafGbXb4hFCn1gSDRn+CbmCn9E
	UOSDNDVV16RYBHQjuV7/aIlA8iL9OAkYUZfUPlynFYY6SDkYmiY4FIP1fE4NYVaoA==
X-Received: by 2002:a17:90b:5885:b0:39d:f6a6:60d8 with SMTP id 98e67ed59e1d1-39e54cb0e29mr16814260a91.3.1789977588113;
        Mon, 21 Sep 2026 00:59:48 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm12843830a91.6.2026.09.21.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:59:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 9/9] selftests/bpf: build each test runner instance in its own sub-make
Date: Mon, 21 Sep 2026 00:58:55 -0700
Message-ID: <20260921075855.2065871-10-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace DEFINE_TEST_RUNNER/DEFINE_TEST_RUNNER_RULES with
Makefile.runner, invoked once per test runner instance. Each invocation
uses ordinary make rules in a single-flavor namespace.

The main Makefile owns shared build outputs and the kselftest
run/install rules. Makefile.skel supplies the BPF object and skeleton
rules used by both the main Makefile and the runners. The main Makefile
builds the default flavor before invoking unflavored runners; flavored
runners build in separate directories.

Build shared userspace objects once and link them into every flavor.
Order their compilation after the bpftool sub-build, which installs the
libbpf-internal headers they include. Pass the assembled CFLAGS and
LDFLAGS to runners on their command lines.

Build and copy runtime fixtures alongside runner compilation so module
builds do not delay runner startup. They are prerequisites of the
test_progs, test_progs-<flavor> and all goals rather than of the runner
binaries, so a goal spelled as a binary's path builds the binary alone.
Installation copies the default flavor's BPF objects, preserving the
previous result.

Generate prog_tests/tests.h and map_tests/tests.h through ordinary
recipes, avoiding generation during make -n. Signed skeletons explicitly
depend on the private key. The flavored runners' objects and the test
objects are targets of the sub-makes only, and the bare linked-object
names (make linked_funcs1.bpf.o) are no longer targets. Build-log
details change: skeleton messages adopt the common format and output
stream, the shared objects log as CC, the fixture copy prints no
EXT-COPY line and TEST-HDR carries no runner tag.

Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 501 ++++++------------
 .../testing/selftests/bpf/Makefile.buildvars  |  16 +-
 tools/testing/selftests/bpf/Makefile.runner   | 125 +++++
 tools/testing/selftests/bpf/Makefile.skel     | 139 +++++
 4 files changed, 428 insertions(+), 353 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100644 tools/testing/selftests/bpf/Makefile.skel

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 25a21247a1ba..afa589a27b15 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -10,9 +10,6 @@ SKIP_LLVM	?=
 SKIP_LIBBFD	?=
 SKIP_CRYPTO	?=
 
-# Some utility functions use LLVM libraries
-jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
-
 # Check whether bpf cpu=v4 is supported or not by clang
 ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
 CLANG_CPUV4 := 1
@@ -29,16 +26,6 @@ TEST_INST_SUBDIRS := no_alu32
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
@@ -150,6 +137,9 @@ ifeq ($(feature-llvm),1)
 endif
 endif
 
+# Some utility functions use LLVM libraries
+$(OUTPUT)/jit_disasm_helpers.o: CFLAGS += $(LLVM_CFLAGS)
+
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../../../vmlinux				\
@@ -168,7 +158,7 @@ $(notdir $(TEST_GEN_PROGS) $(TEST_KMODS)				\
 	 $(TEST_GEN_PROGS_EXTENDED)): %: $(OUTPUT)/% ;
 
 # sort removes libbpf duplicates when not cross-building
-MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	\
+MAKE_DIRS := $(sort $(OUTPUT) $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf \
 	       $(BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/bpftool		\
 	       $(HOST_BUILD_DIR)/resolve_btfids				\
 	       $(INCLUDE_DIR))
@@ -252,9 +242,27 @@ $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELP
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
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
+# Helper C files include headers installed to $(INCLUDE_DIR) by the
+# $(TRUNNER_BPFTOOL) and $(BPFOBJ) targets.
+RUNNER_OBJS := $(sort $(RUNNER_OBJS-test_progs) $(RUNNER_OBJS-test_maps))
+$(RUNNER_OBJS): $(VERIFY_SIG_HDR) $(BPFOBJ) $(TRUNNER_BPFTOOL)
+$(OUTPUT)/test_progs.o: prog_tests/tests.h
+$(OUTPUT)/test_maps.o: map_tests/tests.h
+
+# find_bit.c is the only runner source outside this directory, so it
+# needs a rule of its own.
+$(OUTPUT)/find_bit.o: $(TOOLSDIR)/lib/find_bit.c
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $< $(LDLIBS) -o $@
 
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
@@ -323,7 +331,7 @@ endif
 
 # vmlinux.h is first dumped to a temporary file and then compared to
 # the previous version. This helps to avoid unnecessary re-builds of
-# $(TRUNNER_BPF_OBJS)
+# BPF objects.
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 	$(call msg,GEN,,$@)
@@ -369,274 +377,6 @@ endif
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
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
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) $(VERIFICATION_CERT) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
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
 # genkey writes both outputs. Pattern rules group them even on make
 # versions before 4.3, preventing concurrent genkey invocations.
 # Restrict the pattern to *_key files because genkey uses fixed names.
@@ -682,78 +422,137 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
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
-		       $(wildcard progs/*.bpf.o)			\
-		       bpftool_btf_dump_sorted.expected			\
-		       bpftool_btf_dump_unsorted.expected
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
+# Share LLVM probe results with runners. Pass CC explicitly to
+# runners so it does not affect libbpf's compiler selection.
+export LLVM_LDLIBS LLVM_LDFLAGS
+
+# Pass assembled flags on the command line so runner assignments
+# cannot append them again.
+RUNNER_MAKE := $(MAKE) --no-print-directory -f Makefile.runner	\
+	       OUTPUT=$(OUTPUT) CC='$(CC)' CLANG='$(CLANG)'	\
+	       CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)'
+
+# Shared inputs prepared before runner sub-makes start.
+# Also build veristat, which test_veristat executes.
+RUNNER_PREREQS := $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
+		  $(TRUNNER_BPFTOOL) $(RESOLVE_BTFIDS)			\
+		  $(OUTPUT)/veristat					\
+		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
+		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
+		  prog_tests/tests.h map_tests/tests.h			\
+		  $(RUNNER_OBJS)
+
+# Runtime fixtures for each test_progs flavor.
+RUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
+		      $(OUTPUT)/liburandom_read.so			\
+		      $(OUTPUT)/xdp_synproxy				\
+		      $(OUTPUT)/sign-file				\
+		      $(OUTPUT)/uprobe_multi				\
+		      $(TEST_KMOD_TARGETS)				\
+		      ima_setup.sh					\
+		      $(VERIFY_SIG_SETUP)				\
+		      $(wildcard progs/btf_dump_test_case_*.c)		\
+		      $(wildcard progs/*.bpf.o)				\
+		      bpftool_btf_dump_sorted.expected			\
+		      bpftool_btf_dump_unsorted.expected
+
+# Prepare fixtures in parallel with runner compilation.
+# Copy into flavor and out-of-tree directories; the in-tree
+# default runner uses the originals.
+RUNNER_EXTRA_DIRS := $(addprefix $(OUTPUT)/,$(TEST_INST_SUBDIRS))
+ifneq ($(realpath $(OUTPUT)),$(CURDIR))
+RUNNER_EXTRA_DIRS += $(OUTPUT)
+test_progs: $(OUTPUT)/runner-extras
+else
+test_progs: $(RUNNER_EXTRA_FILES)
+endif
+RUNNER_EXTRAS := $(addsuffix /runner-extras,$(RUNNER_EXTRA_DIRS))
+
+.PHONY: $(RUNNER_EXTRAS)
+$(RUNNER_EXTRAS): $(RUNNER_EXTRA_FILES)
+	$(Q)mkdir -p $(@D)
+	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args)	\
+		$(RUNNER_EXTRA_FILES) $(@D)/
+
+all: $(RUNNER_EXTRAS)
+$(addprefix test_progs-,$(TEST_INST_SUBDIRS)): test_progs-%:		\
+	$(OUTPUT)/%/runner-extras
+
+# The main Makefile cannot tell whether $(OUTPUT)/test_progs is stale -
+# only the runner sub-make knows its full dependency graph. FORCE makes
+# the delegating rules below always run; their dependents still rebuild
+# on mtime only.
+FORCE:
+
+# Build default BPF outputs here for standalone consumers and install.
+# Standalone consumers depend on individual skeletons; unflavored
+# runners depend on the complete set before their sub-makes start.
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
+CLANG_RUNNER_ARGS := BPF_CC='$(CLANG)' BPF_CC_MSG=CLNG-BPF		\
+	BPF_SYS_INCLUDES='$(CLANG_SYS_INCLUDES)'
+
+$(OUTPUT)/test_progs: $(RUNNER_PREREQS) $(BPF_OBJS) $(ALL_SKELS) FORCE
+	+$(Q)$(RUNNER_MAKE) $(DEFAULT_RUNNER_ARGS)
+
+$(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=no_alu32 TESTS_DIR=prog_tests \
+		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v2'
+
 ifneq ($(CLANG_CPUV4),)
-TRUNNER_BPF_BUILD_RULE := CLANG_CPUV4_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
-$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
+$(OUTPUT)/test_progs-cpuv4: $(RUNNER_PREREQS) FORCE
+	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=cpuv4 TESTS_DIR=prog_tests \
+		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v4' \
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
index b7e4d7e678ac..d2a0c0031b87 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -2,8 +2,9 @@
 #
 # Toolchain, path and flag definitions for the BPF selftests build,
 # kept apart from the rules so that more than one makefile can include
-# them. Included after ../lib.mk - the note above the Makefile's include
-# explains how the flags are ordered around it.
+# them. Included by the Makefile after ../lib.mk and by Makefile.runner
+# in its place - the note above the Makefile's include explains how the
+# flags are ordered around it.
 
 TOOLSDIR := $(abspath ../../..)
 LIBDIR := $(TOOLSDIR)/lib
@@ -148,3 +149,14 @@ ifneq ($(CLANG_HAS_ARENA_ASAN),)
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
+	json_writer.o bpftool_helpers.o usdt_1.o usdt_2.o		\
+	find_bit.o)
+RUNNER_OBJS-test_maps := $(addprefix $(OUTPUT)/,			\
+	test_maps.o testing_helpers.o)
diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/selftests/bpf/Makefile.runner
new file mode 100644
index 000000000000..d266c4246888
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.runner
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Build one test_progs flavor or test_maps.
+# Invoked by the main Makefile after shared build inputs are ready.
+# Flavored outputs live in $(OUTPUT)/$(FLAVOR); unflavored outputs
+# share $(OUTPUT) with the main Makefile.
+#
+# Command-line parameters:
+#   OUTPUT         selftests output directory, resolved by lib.mk
+#   RUNNER         test_progs | test_maps
+#   FLAVOR         empty | no_alu32 | cpuv4 | bpf_gcc
+#   TESTS_DIR      prog_tests | map_tests
+#   BPF_*          see Makefile.skel; BPF_CC is empty for test_maps
+#   CC, CLANG      compilers resolved by the main Makefile
+#   CFLAGS, LDFLAGS assembled flags, including lib.mk's additions
+#
+# Exported by the main Makefile:
+#   LLVM_LDLIBS, LLVM_LDFLAGS: LLVM feature-probe results
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
+# Per-runner sources
+
+ifeq ($(RUNNER),test_progs)
+GENERATED_HDRS := $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)
+endif
+
+TEST_SRCS  := $(notdir $(wildcard $(TESTS_DIR)/*.c))
+TEST_OBJS  := $(patsubst %.c,$(RDIR)/%.test.o,$(TEST_SRCS))
+TEST_DEPS  := $(TEST_OBJS:.o=.d)
+
+# BPF objects and skeletons - rules shared with the main Makefile
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
+# Test objects and runner binary
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
+	$(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< $(LDLIBS) -o $(@F)) $(if \
+		$(PERMISSIVE_TESTS),$(call skip_on_fail,TEST))
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
+cmd_runner_link = $(CC) $(CFLAGS) \
+	$(if $(PERMISSIVE_TESTS),$(wildcard $(TEST_OBJS)) \
+		$(filter-out $(TEST_OBJS),$(filter %.a %.o,$^)), \
+		$(filter %.a %.o,$^)) \
+	$(LDLIBS) $(LLVM_LDLIBS) $(LDFLAGS) $(LLVM_LDFLAGS) -o $@
+
+# BPF objects are also needed at runtime.
+# In permissive mode, existing test objects are normal prerequisites
+# so edits trigger relinking. Order-only prerequisites attempt all
+# tests; the recipe links the objects that exist afterward.
+$(OUTPUT)/$(BINARY): $(if $(PERMISSIVE_TESTS),$(wildcard $(TEST_OBJS)),$(TEST_OBJS)) \
+		     $(RUNNER_OBJS-$(RUNNER)) $(BPFOBJ)			\
+		     $(TRUNNER_BPFTOOL)					\
+		     | $(BPF_OBJS)					\
+		     $(if $(PERMISSIVE_TESTS),$(TEST_OBJS))
+	$(call msg,BINARY,,$@)
+	$(Q)$(cmd_runner_link)
+	$(Q)ln -sf $(if $(FLAVOR),..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool $(RDIR)/bpftool
diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
new file mode 100644
index 000000000000..580d1d82c186
--- /dev/null
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0
+# BPF object and skeleton rules for one flavor.
+# Included by the main Makefile for default outputs and by runners
+# for their flavor. Unflavored runners require the default outputs first.
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
+
+# BPF objects and skeletons
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
+cmd_bpf_compile = $(BPF_CC) $(BPF_CFLAGS) $(BPF_SYS_INCLUDES) $(BPF_DEFINES) \
+	$($<-CFLAGS) $($<-$(FLAVOR)-CFLAGS) $(BPF_CC_FLAGS) -c $< -o $@ $(call skip_on_fail,BPF)
+
+$(BPF_OBJS): $(RDIR)/%.bpf.o: progs/%.c progs/*.h			\
+	     $(INCLUDE_DIR)/vmlinux.h $(HEADERS_FOR_BPF_OBJS)		\
+	     | $(RDIR) $(BPFOBJ)
+	$(call msg,$(BPF_CC_MSG),$(BINARY),$@)
+	$(Q)$(cmd_bpf_compile)
+
+GEN_SKEL := ./gen_bpf_skel.sh
+
+cmd_bpf_gen_skel = $(call skip_if_missing,SKEL,$<,$(@:.skel.h=.subskel.h))printf \
+	'  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) $(GEN_SKEL) --name $* \
+	--skel $@ --subskel $(@:.skel.h=.subskel.h) $< $(call \
+	skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+$(SKELS): $(RDIR)/%.skel.h: $(RDIR)/%.bpf.o $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(cmd_bpf_gen_skel)
+
+cmd_bpf_gen_lskel = $(call skip_if_missing,SKEL,$<)printf \
+	'  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) $(GEN_SKEL) --name $*_lskel --lskel \
+	--skel $@ $< $(call skip_on_fail,SKEL)
+
+$(LSKELS_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(cmd_bpf_gen_lskel)
+
+cmd_bpf_gen_signed_lskel = $(call skip_if_missing,SKEL,$<)printf \
+	'  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY) (signed)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) PRIVATE_KEY=$(PRIVATE_KEY) \
+	VERIFICATION_CERT=$(VERIFICATION_CERT) \
+	$(GEN_SKEL) --sign --name $*_lskel \
+	--skel $@ $< $(call skip_on_fail,SKEL)
+
+$(LSKELS_SIGNED_H): $(RDIR)/%.lskel.h: $(RDIR)/%.bpf.o $(BPFTOOL)	\
+		    $(GEN_SKEL) $(PRIVATE_KEY) $(VERIFICATION_CERT) | $(RDIR)
+	$(Q)$(cmd_bpf_gen_signed_lskel)
+
+cmd_bpf_link_skel = $(call skip_if_missing,SKEL,$(addprefix $(RDIR)/,\
+	$($*.skel.h-deps)),$(@:.skel.h=.subskel.h))printf \
+	'  %-8s%s %s\n' 'LINK-BPF' ' [$(BINARY)]' '$(notdir $(@:.skel.h=.bpf.o))'; \
+	printf '  %-8s%s %s\n' 'GEN-SKEL' ' [$(BINARY)]' '$(notdir $@)'; \
+	BPFTOOL=$(BPFTOOL) $(GEN_SKEL) --name $* \
+	--skel $@ --subskel $(@:.skel.h=.subskel.h) \
+	$(addprefix $(RDIR)/,$($*.skel.h-deps)) $(call \
+	skip_on_fail,SKEL,$(@:.skel.h=.subskel.h))
+
+# .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
+.SECONDEXPANSION:
+$(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps)) \
+		   $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
+	$(Q)$(cmd_bpf_link_skel)
+
+endif # BPF_CC
-- 
2.43.0

