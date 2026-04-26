Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C535F60A
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230183; cv=none; b=GP+RRBfCpS77Srl0DakWxWARB6yzpLiy8h+muRjoBWm3k71624dmCvmgvSyUnyuTHKCsoK8OcNGxBsSLbn8BnAoHyqBhXOMgBwonCobg1251EIaKsH+KsvXOsBDxRob9LjNWR6eHVctCWq1fGHWOTzEiJsc9M1BoZZ1j3U13GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230183; c=relaxed/simple;
	bh=9ZGVVrHahuo/zTHE4AB4nHjr1TfFf58eScXNbd7iPeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsRB3bIG+QJiWMKKs5CZN6Nz/zSiZ4DwJdIWedUjeYbFHkobrKsRdtAt3XsrBN7cZRBKymaMTjB9tTAPr9Osv1AkOkdQEmOPhjFQL/FYmeQTfebsIO8fpRQKCaJss2/331rrTArgN9wjd8ty5DeyroMS9js+yDQ9VOhCfOlMGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=LbioALS9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="LbioALS9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a8fba3f769so42094385ad.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230176; x=1777834976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWGNMCGfmvIv05u8MPuhR4TBTMU9izLPyHi6JNayx7M=;
        b=LbioALS9stFUOtZAGVATnPCSFJbfLEN2r0dw3YukKFX9LRhhx9tB9Tn5yG7ApapqTP
         ugQ/st/DYnRHFhOkVaqmGBtrPM8hdGae28U3lO8snpiJrS9IWvTMaX2wA387d95ojIvV
         TcWOC7jKA+gDBP2E2XfUo/5ezEl/cYdU99it4ZBFGovdqF77GQJZiymn3BfEaCzC82zg
         wewTJkrskMl7sO4cifVDhauPGIBpzlJO5KgkGcHHbQRNWaj9xxjjNzeV+ddIE/X0rQnB
         FCX7xPviLJgwWGFh+riUMiu8FWF59vKug6t3x5KLXp2hCqceH5iLKg0wnF92bdHQoNpQ
         UKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230176; x=1777834976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWGNMCGfmvIv05u8MPuhR4TBTMU9izLPyHi6JNayx7M=;
        b=hj7qLjx+zyAL1c2UkQs7DbnNEs9S50tGLpmcaR16cVg9mwlcpqVUWXNLIakIyF61nr
         P1SZKeQxthraK4J1XjLTPu7ZtaODLUeuvLZOu/UYFo4HA0x///TmqrKv6feHKdZZO77k
         Q10uCgDpQKwrIVQ+h2N1l2PPXjFf/iW+l7ucLajxFnsBrKMVIeqM7X1Q/LXVawbGuRdy
         Wx2tmDXS48DrZcEMO6h9QMWZ1DS2f5fdWFL/1245e0gmsESvFoNqA5cx8bcjtC+Ddwzy
         jcVdouKNYOeU16lr0CNRY0LcCxXOmFsL1/JPviMJHy97uffOtd+M1Mh9nOq7cA2TOEhX
         oYtA==
X-Gm-Message-State: AOJu0YyN+cSbZ1CxB+KuDElDuHcioBUtl6HI7985B+RjIA6UcPK80irP
	uRj6jq7HTW7Y9jE7ljmLCuwrV4AY+65/GIdn/JKELGnDT1D4txJ+n0EcT3qC3qMyVGzWJ/4zNOk
	r5HD0OwM=
X-Gm-Gg: AeBDieuTr4fGPsCqYeXlz6CoZkvlD1+78C+yAO1y+skzq8ldqc5E6T1YdHiQeIPr9MV
	OPUmyrbXz1N+TlfogG+QNNUwRxZnEP9Sw7Ts5u4QErTGTV3SVWF74CPceGXURU8Um/a2LvQnFla
	qprOLey9P10pTaDYTOkmw58Qyl+MZLocoktl0igqwssKKjYEwrJ3lrIaRV8tsJGFC/DDQBjMu0p
	DAMTxgThjjZJjnrwAvpjfJrh+IyNI4j7ubZuPrXVqEQALibV1SxmmQAuorbA6WPR+3ZKUkjKRL1
	ObuUQPJFI+QTDIZz4RGKXHnMDHr+LfBexSquFVclMOOq2HO3TxccVISfKAKaR5WDMrvkrolZ3lM
	jUaxp1orTxyQLioIB/pjmCPtVbE5rdiN+FPLgd9+ZRNxdzpiAS/uywTOU1mooAyMHH0mI1K6722
	oRWRiyr+yQF2HhNoip1J9pwCU=
X-Received: by 2002:a17:902:bf41:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2b5f9f5c1c5mr300063455ad.25.1777230175916;
        Sun, 26 Apr 2026 12:02:55 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caf1sm298935875ad.42.2026.04.26.12.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:02:55 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobfrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v9 2/8] selftests/bpf: Add basic libarena scaffolding
Date: Sun, 26 Apr 2026 15:02:45 -0400
Message-ID: <20260426190251.4456-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426190251.4456-1-emil@etsalapatis.com>
References: <20260426190251.4456-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial code and a Makefile for an arena-based BPF library. Modules
can be added just by including the source file in the library's src/
subdirectory. Future commits will introduce the library code itself.

The code includes workarounds that are removed in subsequent patches
that ensure bisectability.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          | 27 +++++
 tools/testing/selftests/bpf/libarena/Makefile | 69 +++++++++++++
 .../bpf/libarena/include/libarena/common.h    | 79 +++++++++++++++
 .../bpf/libarena/include/libarena/userspace.h | 99 +++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   | 29 ++++++
 5 files changed, 303 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6ef6872adbc3..5855064e7f9c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -153,6 +153,7 @@ override define CLEAN
 	$(Q)$(RM) -r $(TEST_KMODS)
 	$(Q)$(RM) -r $(EXTRA_CLEAN)
 	$(Q)$(MAKE) -C test_kmods clean
+	$(Q)$(MAKE) -C libarena clean
 	$(Q)$(MAKE) docs-clean
 endef
 
@@ -525,6 +526,7 @@ LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
 
 HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
+			$(wildcard $(CURDIR)/libarena/include/*.[ch])	\
 			$(addprefix $(BPFDIR)/,	bpf_core_read.h	\
 			                        bpf_endian.h	\
 						bpf_helpers.h	\
@@ -740,6 +742,29 @@ $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 	 echo "};"; \
 	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
 
+LIBARENA_MAKE_ARGS = \
+		BPFTOOL="$(BPFTOOL)" \
+		INCLUDE_DIR="$(INCLUDE_DIR)" \
+		LIBBPF_INCLUDE="$(HOST_INCLUDE_DIR)" \
+		BPFOBJ="$(BPFOBJ)" \
+		LDLIBS="$(LDLIBS) -lzstd" \
+		CLANG="$(CLANG)" \
+		BPF_CFLAGS="$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
+		BPF_TARGET_ENDIAN="$(BPF_TARGET_ENDIAN)" \
+		Q="$(Q)"
+
+LIBARENA_BPF_DEPS := $(wildcard libarena/Makefile		\
+				 libarena/include/*		\
+				 libarena/include/libarena/*	\
+				 libarena/src/*			\
+				 libarena/selftests/*		\
+				 libarena/*.bpf.o)
+
+LIBARENA_SKEL := libarena/libarena.skel.h
+
+$(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
+	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -933,3 +958,5 @@ override define INSTALL_RULE
 		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
 	done
 endef
+
+libarena: $(LIBARENA_SKEL)
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
new file mode 100644
index 000000000000..e85b3ad96890
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+
+.PHONY: clean
+
+# Defaults for standalone builds
+
+CLANG ?= clang
+BPFTOOL ?= bpftool
+LDLIBS ?= -lbpf -lelf -lz -lrt -lpthread -lzstd
+
+ifeq ($(V),1)
+Q =
+msg =
+else
+Q ?= @
+msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
+endif
+
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+BPF_TARGET_ENDIAN ?= $(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
+
+LIBARENA=$(abspath .)
+BPFDIR=$(abspath $(LIBARENA)/..)
+
+INCLUDE_DIR ?= $(BPFDIR)/tools/include
+LIBBPF_INCLUDE ?= $(INCLUDE_DIR)
+
+# Scan src/ and selftests/ to generate the final binaries
+LIBARENA_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LIBARENA)/selftests/*.bpf.c)
+LIBARENA_OBJECTS = $(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o))
+
+INCLUDES = -I$(LIBARENA)/include -I$(BPFDIR)
+ifneq ($(INCLUDE_DIR),)
+INCLUDES += -I$(INCLUDE_DIR)
+endif
+ifneq ($(LIBBPF_INCLUDE),)
+INCLUDES += -I$(LIBBPF_INCLUDE)
+endif
+
+# ENABLE_ATOMICS_TESTS required because we use arena spinlocks
+override BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
+override BPF_CFLAGS += -O2 -g
+override BPF_CFLAGS += -Wno-incompatible-pointer-types-discards-qualifiers
+# Required for suppressing harmless vmlinux.h-related warnings.
+override BPF_CFLAGS += -Wno-missing-declarations
+override BPF_CFLAGS += $(INCLUDES)
+
+CFLAGS = -O2 -no-pie
+CFLAGS += $(INCLUDES)
+
+vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
+vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
+
+libarena.skel.h: libarena.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
+
+libarena.bpf.o: $(LIBARENA_OBJECTS)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
+%.bpf.o: %.bpf.c
+	$(call msg,CLNG-BPF,libarena,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
+
+clean:
+	$(Q)rm -f *.skel.h *.bpf.o
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
new file mode 100644
index 000000000000..92b67b20ed15
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifdef __BPF__
+
+#include <vmlinux.h>
+
+#include "../../bpf_arena_common.h"
+#include "../../progs/bpf_arena_spin_lock.h"
+
+#include <asm-generic/errno.h>
+
+#ifndef __BPF_FEATURE_ADDR_SPACE_CAST
+#error "Arena allocators require bpf_addr_space_cast feature"
+#endif
+
+#define arena_stdout(fmt, ...) bpf_stream_printk(1, (fmt), ##__VA_ARGS__)
+#define arena_stderr(fmt, ...) bpf_stream_printk(2, (fmt), ##__VA_ARGS__)
+
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+#define ARENA_PAGES (1UL << (32 - __builtin_ffs(__PAGE_SIZE) + 1))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES); /* number of pages */
+#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+	__ulong(map_extra, (1ull << 32)); /* start of mmap() region */
+#else
+	__ulong(map_extra, (1ull << 44)); /* start of mmap() region */
+#endif
+} arena __weak SEC(".maps");
+
+/*
+ * This is a variable used to aid verification. The may_goto directive
+ * permits open-coded for loops, but requires that the index variable is
+ * imprecise. To force the variable to be imprecise, initialize it with
+ * the opaque volatile variable 0 instead of the constant 0.
+ */
+extern const volatile u32 zero;
+
+int arena_fls(__u64 word);
+
+#else /* ! __BPF__ */
+
+#include <stdint.h>
+
+#define __arena
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+typedef int8_t s8;
+typedef int16_t s16;
+typedef int32_t s32;
+typedef int64_t s64;
+
+/* Dummy "definition" for userspace. */
+#define arena_spinlock_t int
+
+#endif /* __BPF__ */
+
+struct arena_get_info_args {
+	void __arena *arena_base;
+};
+
+struct arena_alloc_reserve_args {
+	u64 nr_pages;
+};
+
+/* Reasonable default number of pages reserved by arena_alloc_reserve. */
+#define ARENA_RESERVE_PAGES_DFL (8)
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
new file mode 100644
index 000000000000..0438a751d5fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+
+static inline int libarena_run_prog(int prog_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int ret;
+
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (ret)
+		return ret;
+
+	return opts.retval;
+}
+
+static inline bool libarena_is_test_prog(const char *name)
+{
+	return strstr(name, "test_") == name;
+}
+
+static inline int libarena_run_prog_args(int prog_fd, void *args, size_t argsize)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int ret;
+
+	opts.ctx_in = args;
+	opts.ctx_size_in = argsize;
+
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+
+	return ret ?: opts.retval;
+}
+
+static inline int libarena_get_arena_base(int arena_get_info_fd,
+					  void **arena_base)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_get_info_args args = { .arena_base = NULL };
+	int ret;
+
+	opts.ctx_in = &args;
+	opts.ctx_size_in = sizeof(args);
+
+	ret = bpf_prog_test_run_opts(arena_get_info_fd, &opts);
+	if (ret)
+		return ret;
+	if (opts.retval)
+		return opts.retval;
+
+	*arena_base = args.arena_base;
+	return 0;
+}
+
+static inline int libarena_get_globals_pages(int arena_get_globals_fd,
+					     size_t arena_all_pages,
+					     u64 *globals_pages)
+{
+	size_t pgsize = sysconf(_SC_PAGESIZE);
+	void *arena_base;
+	ssize_t i;
+	u8 *vec;
+	int ret;
+
+	ret = libarena_get_arena_base(arena_get_globals_fd, &arena_base);
+	if (ret)
+		return ret;
+
+	if (!arena_base)
+		return -EINVAL;
+
+	vec = calloc(arena_all_pages, sizeof(*vec));
+	if (!vec)
+		return -ENOMEM;
+
+	if (mincore(arena_base, arena_all_pages * pgsize, vec) < 0) {
+		ret = -errno;
+		free(vec);
+		return ret;
+	}
+
+	*globals_pages = 0;
+	for (i = arena_all_pages - 1; i >= 0; i--) {
+		if (!(vec[i] & 0x1))
+			break;
+		*globals_pages += 1;
+	}
+
+	free(vec);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
new file mode 100644
index 000000000000..659ccead5624
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <libarena/common.h>
+
+const volatile u32 zero = 0;
+
+int arena_fls(__u64 word)
+{
+	if (!word)
+		return 0;
+
+	return 64 - __builtin_clzll(word);
+}
+
+SEC("syscall")
+__weak int arena_get_info(struct arena_get_info_args *args)
+{
+	args->arena_base = arena_base(&arena);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int arena_alloc_reserve(struct arena_alloc_reserve_args *args)
+{
+	return bpf_arena_reserve_pages(&arena, NULL, args->nr_pages);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

