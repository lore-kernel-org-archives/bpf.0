Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A9178372
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956747; cv=none; b=OLrsN+QefNckyk1d1Xn3Zzg+YIEW3iQzu0nQZKIVapL9qo3UejHshEG68tm1krV/NGMjRn93RsCypH1uAi+rS1J/JDpkuAryBE0whdktMrNoPG0QPbZTdgos1H0EKihdsykhQk2gS88lHZM//UzbuF/bjho92i3td4ogFXXjUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956747; c=relaxed/simple;
	bh=6JlYhuqrH/kvBrJtfDs/4tBr94saMR3jOTGfc2zwuZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnLPJG8t/rdmwo8vuMXorERxoGWvtQNaDl8BKKa4suo4aBEbW0WR1mYA7sTreUkJLIoREdXzccCzo+GdjL412GXC1PK7XJdwuHFweZfmjCRu82PNKBEeFro7hQK5S6t6MWaxZ4Us+wZbK3efHE8o9D+xC75QBwF7GyrV5/DR614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cR7WFAxz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cR7WFAxz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3134799a91.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775956746; x=1776561546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhBEXuuaE8/Pqn+fJjPMK0E7wdGtXvyW6ffYZASjHh0=;
        b=cR7WFAxz7AKx8VgfExQtoj0KGCXn/M4SdzbsTpOQSZtYt/Ey7/0GUbywx4iLfn/sIK
         GCsXrgI1AqXnoA2Gv7hf4GMzrkTW+dVokgE95gwzPk7Ct7lrMEnHDcSDx1Ry5GtT/ZU/
         uGzKF9rs3wt0TLvt/lAndlanqR+nyhOWz9wAqhrsNPHYvcmB8hFEG32IKpt+vzk4RnH+
         F/RalEmC1MxX6pdbZZNpZLMXAk2iRoXEamNSo6U0G5ZEVMaqrN/YdrLkcZ9mDzGS8phW
         XW8BLtskMov/0WXBTlfDjbJW+XpnF4RYqIo4nDPmoy8wbP6fPCDnBttJTdiKWPWo/UQn
         /FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956746; x=1776561546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JhBEXuuaE8/Pqn+fJjPMK0E7wdGtXvyW6ffYZASjHh0=;
        b=NjX6erMFjcrhLabp5WbdO1ROqGMLj34zv+hZAHEoOE/6iNo73YGra7S7O0lYhBbWbY
         bnXVqIrMlhq73mn9mow5WIJUUaAyd6pBYlCX0DMFSHDjrdi/KBC19U4A+eXk4IGATlcg
         pVW+CvV8rqHIi06IlYHiHDFvmdZiZkW66PKHTKZQ1P3xVkMJeJsI44NX4ef+H6ylwf/1
         dq2dltG5b90YcILWS7hjPDHDc7zyRLj0Zv+NLHHhJuhPSZAp8ET6x29c7Uc+AUqSLj6l
         RcUI5O52H25mBRAEGBP50/+bTt9ZJOgr84bAvAChQrl6XbiGzODZypyNUFmMuwXCIg8H
         uFfQ==
X-Gm-Message-State: AOJu0Yz6W/elfbyNwef/Uzd1rUxPLBU+N9tVnFJk9T8zDIOP4Ii8JgLb
	g9FHcp6QsPmUJRqak0cOMs3h2dxERm6pu5XRToYmbOpwT82bE84Tin3qzCM0EQ5DpTiIb6MvV9B
	/8y6hWZg=
X-Gm-Gg: AeBDiev8UqEU+eRHwWF134tXfgl4qt7sDpuKBanMnubrQQIhTyGhDWAvEaADDLfICIF
	XmecR7jJMI6VtdKazCWB0pe46mA7E05SLUNXykEBpot/oc0DhMeoXs09Ums83wdAAC6jNTKyGkG
	yVeN803fY9nxkO55giVP4Ng3SB7mGqZB5v1+PR1ZcjcZRixGlE68WxdXEulHF1VdKm57T2Stu1l
	2lTUATGntlWEyg/uHxa+SZiteMr4+hhSqSLkHSEgJvC4A7sxFsUE+qkx8deFFq4p+yIn+PP8evr
	dn1KkrL5SR8cKbw90cqHS+ZZNwWIDymDE+RyCt5r0LT7Bn9aJ5O8ggE0FvNmsmBDfr5cB1A4jGH
	hH1D5y5ZFZwoZzbVTFjQetBBgY+0qLgQbx2Uh+TFeoMe6G1JlKVoPdI5Ti+H/UmOgUr0DCD6uYM
	yvkQLTGKiJIub5
X-Received: by 2002:a05:6a20:7485:b0:398:a33a:71c9 with SMTP id adf61e73a8af0-39fe3ff141bmr9503171637.43.1775956745497;
        Sat, 11 Apr 2026 18:19:05 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa72sm6569310a12.6.2026.04.11.18.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:05 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 5/9] selftests/bpf: Add basic libarena scaffolding
Date: Sat, 11 Apr 2026 21:18:53 -0400
Message-ID: <20260412011857.3387-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412011857.3387-1-emil@etsalapatis.com>
References: <20260412011857.3387-1-emil@etsalapatis.com>
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
 .../selftests/bpf/libarena/include/common.h   |  67 ++++++++
 .../bpf/libarena/include/selftest_helpers.h   |  86 +++++++++++
 .../bpf/libarena/selftests/selftest.c         | 146 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  62 ++++++++
 7 files changed, 427 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
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
index 000000000000..5acf9b994943
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -0,0 +1,67 @@
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
+	__ulong(map_extra, (1ull << 32)); /* start of mmap() region */
+#else
+	__ulong(map_extra, (1ull << 44)); /* start of mmap() region */
+#endif
+} arena __weak SEC(".maps");
+
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
+struct arena_get_base_args {
+	void __arena *arena_base;
+};
diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
new file mode 100644
index 000000000000..78db8bc0fc67
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -0,0 +1,86 @@
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
+	return strstr(name, "test_") != NULL;
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
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
new file mode 100644
index 000000000000..c692e20ea7b1
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -0,0 +1,146 @@
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
+#include <common.h>
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
+static bool verbose;
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
+static int run_test(selftest *skel, struct bpf_program *prog)
+{
+	int prog_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0)
+		return prog_fd;
+
+	return run_prog_verbose(prog_fd);
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
+	struct bpf_program *prog;
+	selftest *skel;
+	int err = 0;
+	int ret;
+
+	banner(argv[0]);
+
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--verbose") == 0)
+			verbose = true;
+	}
+
+	libbpf_set_print(libbpf_print_fn);
+
+	skel = selftest__open_and_load();
+	if (!skel) {
+		fprintf(stderr, "Failed to open and load skeleton\n");
+		return 1;
+	}
+
+	ret = selftest__attach(skel);
+	if (ret) {
+		fprintf(stderr, "Failed to attach skeleton\n");
+		selftest__destroy(skel);
+		return 1;
+	}
+
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	if (ret) {
+		fprintf(stderr, "Failed to initialize arena: %d\n", ret);
+		selftest__destroy(skel);
+		return 1;
+	}
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		const char *name = bpf_program__name(prog);
+
+		if (!libarena_is_test_prog(name))
+			continue;
+
+		ret = run_test(skel, prog);
+		if (ret)
+			printf("not ok %d - %s\n", testno++, name);
+		else
+			printf("ok %d - %s\n", testno++, name);
+
+		if (ret)
+			err = -EINVAL;
+	}
+
+	selftest__destroy(skel);
+
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
new file mode 100644
index 000000000000..db6dd8a011ae
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -0,0 +1,62 @@
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
+	if (!word)
+		return 0;
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
+	if (word & 0x2)
+		num += 1;
+
+	return num + 1;
+}
+
+SEC("syscall")
+__weak int arena_get_base(struct arena_get_base_args *args)
+{
+	args->arena_base = arena_base(&arena);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int arena_alloc_reserve(void)
+{
+	return bpf_arena_reserve_pages(&arena, NULL, RESERVE_ALLOC);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

