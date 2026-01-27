Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B56326940
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537792; cv=none; b=cb0CxRgI0Q/8ls9oKD3k63BHcuJpPyWjbOV/JtHO57npEZ+54Y5Aaaf6aOb62fR8t5wLefXNjDzv1JM+QtOb0O3sVKQHRIauUmkkoR8xCbdT1FZ2AhC1Nwjkgs23rDKgGD3GRI3S4VcwLN0tvKFxYP7lnVT4OW9SsnFUcxqPS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537792; c=relaxed/simple;
	bh=mH9hShTHZ7yzu4Brl/5Vwca2bIDchIwb5UYj4vMwPWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UctnBfnhlNpga+W0MDO2gp299bRQbh2lQDlBmEFZA9BAAlkSAGD4I7k1Q5A4W9TpLfpa998SfkILDTSvx1H+QK5AT0AU3vISls9BS13wSqqmrzDmUc/ARjr8ntDeDYeruRgRj0BcfnxDzrhQb05+1EvKldmIvL+ujAAwFYBWN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=PlhID585; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="PlhID585"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50145d27b4cso64114091cf.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537789; x=1770142589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX4/Q6l689oBML7eioejStw3QxOdNzlR4EUwv/hjeDs=;
        b=PlhID5856NhlKJyNtJH6wY5eqOsND51aKRsucUqvxMreNYZBFdJlLnbIfP8vSweb4W
         uS65taQdw5jr/mzSFWUuxcNmMAd21L65nWIxqY+zkCQH9lZfRPjt2S7G2GPzpNtF2wxX
         ZwQTm1rttyjnZAaVrZ07NgyrKafHjB5e0AdtVj5RqkkYhUqaDZ1OvpKePWlzfBCD/9dy
         YlhhKE2GROOycR+96Al6RBclSQOxCUFFE8321B391tDOc9EtTk3mS9YXsux00BnsTMYn
         FzSKMBg+x0fRRQcRyXg9E1zmJX6XoVqSvGaxl9dShBRDodHOMcEjoN6kqndyhFlh8OOt
         fF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537789; x=1770142589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MX4/Q6l689oBML7eioejStw3QxOdNzlR4EUwv/hjeDs=;
        b=CmOuYYK0TrtoiD1jUmJv/ivkbiDFnGKRer2GRifUwpWZGTZlcKOiDECVKYvAtwe5oe
         GEgzA2iWMgz2kPgTOhlLXHcweXQXN62hGCUQro17O0WTxzFCM6Ds3WFUGIAqyAzOtSQZ
         JLavBQRAtP2Zp4SujtQbSfXOdrxSGRthw2NPDIrgCVYAefawLby3ghCX5cmreo6iHeXw
         whcd0r/O+mpcwBhS3qsjxw27kD0UcMi7fGOQnA+iS/iWnIBuayInLgmJqk2zS3OTV4UH
         v0tkrDXpayoDSbTa8CcKhDFbrIPI1vvp6wk/lwHZ//hO/CitOYqCRS/L0prCWrt1A8bZ
         YiiA==
X-Gm-Message-State: AOJu0YyRhsfeKEImKQZYhUw58Osdhlg4MjXZxJP50VrFiBhM8Te/yR1W
	pJmvfCx3C5qbNf25DS36jbSq2Ssp1fo0yGyL1zomwtY+V1dET6MNz9ZMR7POTtrxaVAEqv+eSqb
	EgY66
X-Gm-Gg: AZuq6aJU6vOZb3HPRJZzP2CTxqEKambDeRlMy43cVqv34imdyqpCwSUuEzVNk3VtmOW
	A/kbBxWtdpxqmGNdmQTMOxJd55fJ5GpCmPih956np+OneG+VzTf4v0GBzuxzLTXNbqEWgHwRxOv
	BIeyUHiPq+OT80qIfGP7ftd49xc6GYwcCTvEFD1NnPR8szXskdKK6r9Vx48dRIKbjT2kaT7QGPs
	2D0ybz7t/+QUDcMFKfZ92eGqNAeMbACyz7+0KTZe9xKS4azaMIn1QPhyIR36NEj1yNJGTcxivvG
	zSCM2PtHMF7zWyw6NHqRjNs2+WCQt2IhHbPapcjFGad9JhaOuGKNMoIVv1yvzhakNCB3cATkMAi
	C2Y0RuoZ3R8esQ8+fu35n2msoecz6k/3Kr85rrPTkMNiOMnu5gm/RrGPbnr/XDQD+ABjGNs6S1d
	CRS4I+kcpavA==
X-Received: by 2002:a05:622a:50f:b0:502:9f86:ca31 with SMTP id d75a77b69052e-5032f8de061mr31672021cf.52.1769537789291;
        Tue, 27 Jan 2026 10:16:29 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:28 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 05/13] selftests: bpf: Add basic libarena scaffolding
Date: Tue, 27 Jan 2026 13:16:01 -0500
Message-ID: <20260127181610.86376-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Add initial code for an arena-based BPF library. The current commit
introduces a test runner and Makefile for the library. Library code
can be added just by including the source file in the library's src/
subdirectory. Future commits will introduce the library code itself.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  12 +
 tools/testing/selftests/bpf/libarena/Makefile |  47 ++++
 .../selftests/bpf/libarena/include/common.h   | 118 +++++++++
 .../selftests/bpf/libarena/include/userapi.h  |  22 ++
 .../bpf/libarena/selftests/selftest.c         | 243 ++++++++++++++++++
 .../bpf/libarena/selftests/selftest.h         |  17 ++
 7 files changed, 460 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.h

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index b8bf51b7a0b0..96b4a7e37427 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -48,3 +48,4 @@ verification_cert.h
 *.BTF
 *.BTF_ids
 *.BTF.base
+libarena/test_libarena
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9488d076c740..49b275a7bfa1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -915,3 +915,15 @@ override define INSTALL_RULE
 		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
 	done
 endef
+
+test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena all \
+		BPFTOOL="$(BPFTOOL)" \
+		INCLUDE_DIR="$(HOST_INCLUDE_DIR)" \
+		LIBBPF_INCLUDE="$(HOST_INCLUDE_DIR)" \
+		BPFOBJ="$(BPFOBJ)" \
+		LDLIBS="$(LDLIBS) -lzstd" \
+		CLANG="$(CLANG)" \
+		BPF_CFLAGS="$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
+		BPF_TARGET_ENDIAN="$(BPF_TARGET_ENDIAN)" \
+		Q="$(Q)"
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
new file mode 100644
index 000000000000..70901bb5237f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -0,0 +1,47 @@
+.PHONY: clean
+
+LIBARENA=$(abspath .)
+
+
+LIBARENA_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LIBARENA)/selftests/*.bpf.c)
+LIBARENA_OBJECTS = $(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o))
+
+INCLUDES = -I$(LIBARENA)/include -I$(LIBARENA)/..
+ifneq ($(INCLUDE_DIR),)
+INCLUDES += -I$(INCLUDE_DIR)
+endif
+ifneq ($(LIBBPF_INCLUDE),)
+INCLUDES += -I$(LIBBPF_INCLUDE)
+endif
+
+# ENABLE_ATOMICS_TESTS required because we use arena spinlocks
+override BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
+override BPF_CFLAGS += -O2 -Wno-incompatible-pointer-types-discards-qualifiers
+override BPF_CFLAGS += $(INCLUDES)
+
+CFLAGS = -O2 -no-pie
+CFLAGS += $(INCLUDES)
+
+vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
+vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
+
+all: test_libarena
+
+test_libarena: selftest.c $(BPFOBJ) selftest.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(LDLIBS) $(CFLAGS) $< $(BPFOBJ) -o $@
+
+selftest.skel.h: main.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "selftest" > $@
+
+main.bpf.o: $(LIBARENA_OBJECTS)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
+%.bpf.o: %.bpf.c
+	$(call msg,CLNG-BPF,libarena,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
+
+clean:
+	$(Q)rm -f *.skel.h *.bpf.o test_libarena
diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tools/testing/selftests/bpf/libarena/include/common.h
new file mode 100644
index 000000000000..12fab01d60f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -0,0 +1,118 @@
+#pragma once
+
+#ifdef __BPF__
+
+/* Suppresses definition conflicts between bpf_experimental.h and vmlinux.h. */
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+#include "bpf_arena_spin_lock.h"
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
+extern volatile u64 asan_violated;
+
+#ifndef div_round_up
+#define div_round_up(a, b) (((a) + (b) - 1) / (b))
+#endif
+
+#ifndef round_up
+#define round_up(a, b) ((((a) + (b) - 1) / (b)) * b)
+#endif
+
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+/* How many pages do we reserve at the beginning of the arena segment? */
+#define RESERVE_ALLOC (8)
+
+#define ARENA_PAGES (1UL << (32 - __builtin_ffs(__PAGE_SIZE) + 1))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES); /* number of pages */
+#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+        __ulong(map_extra, (1ull << 32)); /* start of mmap() region */
+#else
+        __ulong(map_extra, (1ull << 44)); /* start of mmap() region */
+#endif
+} arena __weak SEC(".maps");
+
+#endif /* __BPF__ */
+
+struct arena_get_base_args {
+	void __arena *arena_base;
+};
+
+#ifdef __BPF__
+
+static inline
+int arena_fls(__u64 word)
+{
+	unsigned int num = 0;
+
+	if (word & 0xffffffff00000000ULL) {
+		num += 32;
+		word >>= 32;
+	}
+
+	if (word & 0xffff0000) {
+		num += 16;
+		word >>= 16;
+	}
+
+	if (word & 0xff00) {
+		num += 8;
+		word >>= 8;
+	}
+
+	if (word & 0xf0) {
+		num += 4;
+		word >>= 4;
+	}
+
+	if (word & 0xc) {
+		num += 2;
+		word >>= 2;
+	}
+
+	if (word & 0x2) {
+		num += 1;
+	}
+
+	return num;
+}
+
+/*
+ * Userspace API, required for setting up the arena 
+ * address space before starting the allocator.
+ */
+
+SEC("syscall") __weak
+int arena_get_base(struct arena_get_base_args *args)
+{
+	args->arena_base = arena_base(&arena);
+
+	return 0;
+}
+
+SEC("syscall") __weak
+int arena_alloc_reserve(void)
+{
+	return bpf_arena_reserve_pages(&arena, NULL, RESERVE_ALLOC);
+}
+
+#endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/tools/testing/selftests/bpf/libarena/include/userapi.h
new file mode 100644
index 000000000000..bd5e7042a44f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
@@ -0,0 +1,22 @@
+#pragma once
+
+/* 
+ * Header for the userspace C programs that load
+ * and initialize the BPF code.
+ */
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
+#define arena_spinlock_t u64
+
+#include "common.h"
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
new file mode 100644
index 000000000000..5b8d8b94323e
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -0,0 +1,243 @@
+/*
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ *
+ * This software may be used and distributed according to the terms of the
+ * GNU General Public License version 2.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <sys/sysinfo.h>
+
+#include <userapi.h>
+
+#include "selftest.h"
+
+#include "../selftest.skel.h"
+typedef struct selftest selftest;
+
+static bool verbose = false;
+static int testno = 1;
+
+typedef int (*selftest_func)(selftest *);
+
+static int
+selftest_fd(int prog_fd, struct bpf_test_run_opts *calleropts)
+{
+	struct bpf_test_run_opts opts, *argopts;
+	char buf[1024];
+	int progret;
+	int ret;
+
+	argopts = calleropts;
+	if (!argopts) {
+		memset(&opts, 0, sizeof(opts));
+		opts.sz = sizeof(opts);
+		argopts = &opts;
+	}
+
+	ret = bpf_prog_test_run_opts(prog_fd, argopts);
+	if (ret)
+		return ret;
+
+	if (argopts->retval)
+		fprintf(stderr, "error %d in %s\n", argopts->retval, __func__);
+
+	if (verbose) {
+	printf("BPF stdout:\n");
+		while ((ret = bpf_prog_stream_read(prog_fd, 1, buf, 1024, NULL)) > 0)
+			printf("%.*s", ret, buf);
+
+		if (ret)
+			return ret;
+
+		printf("BPF stderr:\n");
+		while ((ret = bpf_prog_stream_read(prog_fd, 2, buf, 1024, NULL)) > 0)
+			printf("%.*s", ret, buf);
+	}
+
+	return argopts->retval;
+}
+
+static int
+selftest_arena_alloc_reserve(selftest *skel)
+{
+	int prog_fd;
+	int ret;
+
+	prog_fd = bpf_program__fd(skel->progs.arena_alloc_reserve);
+	if (!prog_fd)
+		return -ENOENT;
+
+	return selftest_fd(prog_fd, NULL);
+}
+
+static int
+selftest_arena_base(selftest *skel, void **arena_base)
+{
+	struct bpf_test_run_opts opts;
+	struct arena_get_base_args args;
+	u64 globals_pages;
+	int prog_fd;
+	int ret;
+
+	args = (struct arena_get_base_args) {
+		.arena_base = NULL
+	};
+
+	opts = (struct bpf_test_run_opts) {
+		.sz = sizeof(opts),
+		.ctx_in = &args,
+		.ctx_size_in = sizeof(args),
+	};
+
+	prog_fd = bpf_program__fd(skel->progs.arena_get_base);
+	assert(prog_fd >= 0 && "no program found");
+
+	ret = selftest_fd(prog_fd, &opts);
+	if (ret)
+		return ret;
+
+	*arena_base = args.arena_base;
+
+	return 0;
+}
+
+static int
+selftest_globals_pages(selftest *skel, size_t arena_all_pages, u64 *globals_pages)
+{
+	size_t pgsize = sysconf(_SC_PAGESIZE);
+	void *arena_base;
+	u64 pages;
+	u8 *vec;
+	int ret;
+	int i;
+
+	ret = selftest_arena_base(skel, &arena_base);
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
+	if (mincore(arena_base, arena_all_pages * pgsize, vec)) {
+		perror("mincore");
+		free(vec);
+		return -1;
+	}
+
+	/* Find the first nonresident page. */
+	pages = 0;
+	for (i = arena_all_pages - 1; i >= 0; i--) {
+		if (!(vec[i] & 0x1))
+			break;
+
+		pages += 1;
+	}
+
+	free(vec);
+
+	*globals_pages = pages;
+
+	return 0;
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level,
+		const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+int run_test(selftest *skel, const struct bpf_program *prog)
+{
+	int prog_fd;
+	int ret;
+
+	ret = selftest_arena_alloc_reserve(skel);
+	if (ret)
+		return ret;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!prog_fd)
+		return -ENOENT;
+
+	return selftest_fd(prog_fd, NULL);
+}
+
+#define TEST(__test)					\
+int run_##__test(void)					\
+{							\
+	selftest *skel;					\
+	int ret;					\
+							\
+	skel = selftest__open_and_load();		\
+	if (!skel)					\
+		goto error;				\
+							\
+	ret = selftest__attach(skel);			\
+	if (ret)					\
+		goto error;				\
+							\
+	ret = run_test(skel, skel->progs.__test);	\
+	if (ret)					\
+		goto error;				\
+							\
+	selftest__destroy(skel);			\
+							\
+	printf("ok %d - %s\n", testno++, #__test);	\
+	return 0;					\
+							\
+error:							\
+	printf("not ok %d - %s\n", testno++, #__test);	\
+	return ret;					\
+}
+
+static void
+banner(const char *progpath)
+{
+	char *name = basename(progpath);
+
+	printf("=== %s ===\n", "libarena selftests");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	struct rlimit rlim = {
+		.rlim_cur = RLIM_INFINITY,
+		.rlim_max = RLIM_INFINITY,
+	};
+
+	banner(argv[0]);
+
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--verbose") == 0)
+			verbose = true;
+	}
+
+	ret = setrlimit(RLIMIT_MEMLOCK, &rlim);
+	if (ret) {
+		perror("setrlimit");
+		return ret;
+	}
+
+	libbpf_set_print(libbpf_print_fn);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.h b/tools/testing/selftests/bpf/libarena/selftests/selftest.h
new file mode 100644
index 000000000000..6580b23355d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.h
@@ -0,0 +1,17 @@
+#pragma once
+
+#define ALLOC_SELFTEST(func, ...)		\
+	do {				\
+		int ret = func(__VA_ARGS__);	\
+		if (ret) {		\
+			bpf_printk("SELFTEST %s FAIL: %d", #func, ret);	\
+			return ret;	\
+		}			\
+	} while (0)
+
+#ifndef __BPF__
+
+/* Dummy "definition" for userspace. */
+#define arena_spinlock_t u64
+
+#endif /* __BPF__ */
-- 
2.49.0

