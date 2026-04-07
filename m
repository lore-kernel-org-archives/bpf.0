Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59405372EC5
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537859; cv=none; b=dkVuG7TI5Ev11d7YSxdIoY1yWEWXZiqhfOfwfIDJvIOeKKIjkKdWvWM3G8eC7FVkbGj5zSfeUvJOT3U3jJeNsTkqIvUI1vrcIbEjMmDa03dbeVFJzEYoRgsqt0+2ZdLs/J9dAMXjPhjAxxETJGiRdxpMuy58tda93JoSg/6LfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537859; c=relaxed/simple;
	bh=le/JAiBruPOZD5YdkL75iMNC2UYJaAVczXyoMMVQh94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMxkcajsvJnbb1zZUZWoWHf1mCCCp6/PcT7l0/gH7NcC7akQuq75sItHT3htZ0xueT9e+VNgYgh5r/liyqv4k17DhYGHUjiQA6+b770j0vtOW/IoskR/PtmkCVTCiXSwMu4VSsjDFq4DDW0/2WRXzmakMr9voXI40hsmjxCtBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SrP553Ir; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SrP553Ir"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82cf96ca071so1984808b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537858; x=1776142658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwIwv4Qvf9Mpl01Cgqj+158gILtPziUeI5LYh7A7QEs=;
        b=SrP553IrLkOPKCNb2qmNAM1iW6zW7ygCEJP3nw3KGNjAFvAFU8rn09q9QvS3JCgcCA
         bPP6dA9OAhdy7GYdUBvCHgKUGgGzMtrLZILkjTllzecKx5ycWg4gJVS/uWcl/tNqaVHA
         YB1BwPKGsm5aPOac9GvOm4b2rPSgscav9Z+WVgPdkpy3epfP1lx6/HKoezuOSXy95Y+Y
         xLUPhXzx8FYQTrbBzF6zEkQoOdWzmVFKSJCtO9CLyVPmMt1CsdDWuRu0Nk6Zf/2dlJT3
         /gS+dFqTLjzFdrrxEPD0vdVNTPXZcDpMBtXyuqcHHp/mM8v2In00NRl6ZFwVaJHMw+Al
         JGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537858; x=1776142658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwIwv4Qvf9Mpl01Cgqj+158gILtPziUeI5LYh7A7QEs=;
        b=EI4mNZlDjAYItxWE6BVg9kD05D3RFBlcidZ7XUT5br7236v0CZZ6GdnwoFDR9+HeL9
         g46OzB8zWQiGUhPPXCRRkaGzOyOve5ntYYjS5ZveOzbJhLq4Ad3NZgRtivJ+I1YYeeoD
         qKkz+cmH8aW/TTllabocFjo0QrVPGbNs9LmoqMYr1+f+wVVBctxS81fXCu/g5/4BluLj
         bPVR21n5xEwWt4a8Qso/R7lINjOSz7yskCZKnFflE3pcdpfUfOBQDJoKVIT45xVcAn73
         1vtpyDIwLCB/P+3+XkFTs7SeMc6JUT8UiSZPPcm5h0ScP95FVNQgW5ytS90mO5seMBJH
         kK2w==
X-Gm-Message-State: AOJu0YyS6HcWiPrs0p7D3m948jNCZLi40e9Zih9ysM6BCJ2RsUDgFiBK
	JVM08TQraYR+pUcYw+hyS1qWINjTJUqqn7BoYEazSyO+N2uehBUC1ui7CYgyFgUJWmiiajAaUjd
	ZXRR6yajNUQ==
X-Gm-Gg: AeBDiesC5/irSsPMzzBGxRu5TctKz94D6/cDihFQX8YsFaiKcKAksMo78p1Mjg9eUuw
	Eqn3/RM3STxCa97bVgWz5T0yowXEGFHB1MfRYn7eIWJirpnd/h9sxPOkzF0oBSare6v6y6Teb0P
	sj25F04k1SBv59Bwt94o1ep0NeXpV9VtIKf+RYklothfdpNAlnYa37p0V5k74BPZxUt8zwT7S9S
	Fo1KVKFR3ntD4rLlhd8M53/GlLBWTbfLHnAZZZuze+1LgfP4+n4IY2BiETNe1Wj5f4I3EhEBQRE
	AN2bw+8FOp1bpyjC/GtVdbCA3wgZSYGjTbrcDcOqEEVgXOr1cpLTnsz20abkl8bSd/URhtK9DaI
	V/uPVOyRGHMIk9FvnUaZMZ+GOetNEbXoJ0+n3pFAZhxmZso3HuqcONXHugiSjfhxmW8NiMwLSqs
	AwVQ==
X-Received: by 2002:a05:6a00:3902:b0:82c:7876:a027 with SMTP id d2e1a72fcca58-82d0da8edd7mr13871612b3a.18.1775537857553;
        Mon, 06 Apr 2026 21:57:37 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:37 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 5/9] selftests/bpf: Add basic libarena scaffolding
Date: Tue,  7 Apr 2026 00:57:26 -0400
Message-ID: <20260407045730.13359-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407045730.13359-1-emil@etsalapatis.com>
References: <20260407045730.13359-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial code for an arena-based BPF library. The current commit
introduces a test runner and Makefile for the library. Library code
can be added just by including the source file in the library's src/
subdirectory. Future commits will introduce the library code itself.

The current commit also includes a standalone test runner. This is
to keep libarena self-contained and testable even when copied out
of the kernel tree. Subsequent commits add integration with test_progs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  15 ++
 tools/testing/selftests/bpf/libarena/Makefile |  50 ++++++
 .../selftests/bpf/libarena/include/common.h   |  49 ++++++
 .../bpf/libarena/include/selftest_helpers.h   |  81 ++++++++++
 .../selftests/bpf/libarena/include/userapi.h  |  26 +++
 .../bpf/libarena/selftests/selftest.c         | 153 ++++++++++++++++++
 .../bpf/libarena/selftests/selftest.h         |  12 ++
 .../selftests/bpf/libarena/src/common.bpf.c   |  65 ++++++++
 9 files changed, 452 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index bfdc5518ecc8..7f1960d6b59e 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -49,3 +49,4 @@ verification_cert.h
 *.BTF.base
 usdt_1
 usdt_2
+libarena/test_libarena
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..0d332c991023 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -153,6 +153,7 @@ override define CLEAN
 	$(Q)$(RM) -r $(TEST_KMODS)
 	$(Q)$(RM) -r $(EXTRA_CLEAN)
 	$(Q)$(MAKE) -C test_kmods clean
+	$(Q)$(MAKE) -C libarena clean
 	$(Q)$(MAKE) docs-clean
 endef
 
@@ -739,6 +740,17 @@ $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 	 echo "};"; \
 	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
 
+LIBARENA_MAKE_ARGS = \
+		BPFTOOL="$(BPFTOOL)" \
+		INCLUDE_DIR="$(HOST_INCLUDE_DIR)" \
+		LIBBPF_INCLUDE="$(HOST_INCLUDE_DIR)" \
+		BPFOBJ="$(BPFOBJ)" \
+		LDLIBS="$(LDLIBS) -lzstd" \
+		CLANG="$(CLANG)" \
+		BPF_CFLAGS="$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
+		BPF_TARGET_ENDIAN="$(BPF_TARGET_ENDIAN)" \
+		Q="$(Q)"
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -931,3 +943,6 @@ override define INSTALL_RULE
 		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
 	done
 endef
+
+test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
new file mode 100644
index 000000000000..151ab6d0509c
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+
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
+test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@
+
+libarena.skel.h: main.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
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
index 000000000000..544a398a0d1e
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifdef __BPF__
+
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
+        __ulong(map_extra, (1ull << 32)); /* start of mmap() region */
+#else
+        __ulong(map_extra, (1ull << 44)); /* start of mmap() region */
+#endif
+} arena __weak SEC(".maps");
+
+extern const volatile u32 zero;
+
+int arena_fls(__u64 word);
+
+#endif /* __BPF__ */
+
+struct arena_get_base_args {
+	void __arena *arena_base;
+};
diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
new file mode 100644
index 000000000000..ee445d8f5b26
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -0,0 +1,81 @@
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
+static inline int libarena_get_arena_base(int arena_get_base_fd,
+					  void **arena_base)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_get_base_args args = { .arena_base = NULL };
+	int ret;
+
+	opts.ctx_in = &args;
+	opts.ctx_size_in = sizeof(args);
+
+	ret = bpf_prog_test_run_opts(arena_get_base_fd, &opts);
+	if (ret)
+		return ret;
+	if (opts.retval)
+		return opts.retval;
+
+	*arena_base = args.arena_base;
+	return 0;
+}
+
+static inline int libarena_get_globals_pages(int arena_get_base_fd,
+					     size_t arena_all_pages,
+					     u64 *globals_pages)
+{
+	size_t pgsize = sysconf(_SC_PAGESIZE);
+	void *arena_base;
+	ssize_t i;
+	u8 *vec;
+	int ret;
+
+	ret = libarena_get_arena_base(arena_get_base_fd, &arena_base);
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
diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/tools/testing/selftests/bpf/libarena/include/userapi.h
new file mode 100644
index 000000000000..b4ac6bc9bd79
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#include <stdint.h>
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
index 000000000000..b69adc7baaab
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
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
+#include <selftest_helpers.h>
+
+#include "../libarena.skel.h"
+typedef struct libarena selftest;
+#define selftest__open libarena__open
+#define selftest__open_and_load libarena__open_and_load
+#define selftest__load libarena__load
+#define selftest__attach libarena__attach
+#define selftest__destroy libarena__destroy
+
+static bool verbose = false;
+static int testno = 1;
+
+static int
+run_prog_verbose(int prog_fd)
+{
+	char buf[1024];
+	int ret, err;
+
+	ret = libarena_run_prog(prog_fd);
+
+	if (ret)
+		fprintf(stderr, "error %d in %s\n", ret, __func__);
+
+	if (verbose) {
+		printf("BPF stdout:\n");
+		while ((err = bpf_prog_stream_read(prog_fd, 1, buf, 1024, NULL)) > 0)
+			printf("%.*s", err, buf);
+
+		if (err)
+			return err;
+
+		printf("BPF stderr:\n");
+		while ((err = bpf_prog_stream_read(prog_fd, 2, buf, 1024, NULL)) > 0)
+			printf("%.*s", err, buf);
+
+		if (err)
+			return err;
+	}
+
+	return ret;
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
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	if (ret)
+		return ret;
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0)
+		return prog_fd;
+
+	return run_prog_verbose(prog_fd);
+}
+
+#define TEST(__test)					\
+int run_##__test(void)					\
+{							\
+	selftest *skel;					\
+	int ret;					\
+							\
+	skel = selftest__open_and_load();		\
+	if (!skel) {					\
+		ret = -EINVAL;				\
+		goto error_no_destroy;			\
+	}						\
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
+	selftest__destroy(skel);			\
+error_no_destroy:					\
+	printf("not ok %d - %s\n", testno++, #__test);	\
+	return ret;					\
+}
+
+static void
+banner(const char *progpath)
+{
+	char *name = basename(progpath);
+
+	printf("%s\n", name);
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
index 000000000000..b1cbff4d343b
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#define ALLOC_SELFTEST(func, ...)		\
+	do {				\
+		int ret = func(__VA_ARGS__);	\
+		if (ret) {		\
+			arena_stderr("SELFTEST %s FAIL: %d", #func, ret);	\
+			return ret;	\
+		}			\
+	} while (0)
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
new file mode 100644
index 000000000000..cbb729290d3c
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <common.h>
+
+const volatile u32 zero = 0;
+
+/* How many pages do we reserve at the beginning of the arena segment? */
+#define RESERVE_ALLOC (8)
+
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
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

