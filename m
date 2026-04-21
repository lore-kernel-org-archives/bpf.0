Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F537C90B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790247; cv=none; b=OpWjX6my5pDOyHYLnvNb7kOzjn6sBvHXSSnu8XpBii2jhyxez9vSJzhUlLhxkRWNcX9C6DLGNTRJ/pAQaDpor1jCDB7jSnwuzv7CNPn65oNFqx4nPKWqIp33ZMQhNcvfZxF2oJrpmjDCAdD5p9OSWFP/oPBoyU7sivdomCZeSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790247; c=relaxed/simple;
	bh=HX10ylmtl5hs6zlsodrS4Tpc/RoPeIbIkoYvm4+Hs70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMy6xXh3e4PLBv+usccMJYXZi5Aa4W7Gs9fHMPwxqEFaBu6AY7abt1mZ5a30cFDY9FtFXvLZ93FY76UirjooUChMFXgOgsMZjV9mqyukY3zCcuKxG52MYa1ZMCAx62AWpEmXVpmiElE7jMd68b7//LSFCWvsjTOFZYkqC1ZCqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=m2QzP2rZ; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="m2QzP2rZ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c19d23b19so5736356c88.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790245; x=1777395045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQzbsGVQxpmnw6kORouZU/zUCRTZOP6L9qdbkJbnEaY=;
        b=m2QzP2rZCyehMKDZbLwdHzOWWpSMWx9kZHNDzukjkeNvmsij4DlbWd9AgCB/geoztI
         UtkobWtNE8ALn1eltwDaIW6bDSUO0/4QMd2UnO4HkSr2Zv/S+htTOlWJIwWqKeayarLy
         FfFWBDPI95vYiK/vK5vu6lz/ZQ+PRxM4G4RDswER8ZdQ3n4JuXygF6EBoOVwgqJq7oqv
         nK0rXkMDbC4iCRwY3eNAZGqrjU9A8ChsGI9ID5zJjcBA82HvYtivwtjegzu/4RYldBml
         3G/0MuboSyxsCtSAZWvBCytrHKyGN0q3eaMOtqlgd2IAtZ3hHuuP5YbDYF7nHgQjKNBy
         UNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790245; x=1777395045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQzbsGVQxpmnw6kORouZU/zUCRTZOP6L9qdbkJbnEaY=;
        b=Bw/AWyCHYDibKeuVDGB8IXoy4nDKJ9yKuPx8vgryCIpfHRpPAnKQu0MTMFbQqIkl8J
         dnGqjSHlvDzsCmnlEgCjbSlPc+A0Ng8Ge7MDJCD0y3W53zYJSfVZ3l8LwhD5jfEqdN/a
         TDTQGXTuT2Fe83i6IW4tQxIlewc7VJBUHUNImmNfaHu2M9Ett5VycOQM4llUvLz5lCOz
         L0G9zyjCUIs9+xLu6jNtl7YHPODtcrZ/g1ASbq54UWaq22FK8j13Y/k9LF1adLqCNS7K
         522XgQu/tV4/Uu6VHDtLdfHFm9yd21/M+HmoampV/c0H1VbvRp3n1o5gfH+XUF78NshM
         aA0Q==
X-Gm-Message-State: AOJu0YwAF0qwoddwQRtOGBFw8XRDONoZS65or1pL6aF1bkuLnkYalfzI
	pkWoy8KJ+Dk585UiFCV/BQ0TPeB9Z1ow8wWK+QSaP9N3OajtrN1Aa6IV2bPuAeD1E7t7idp+0DQ
	UFNi11cSNm1t7
X-Gm-Gg: AeBDieuHvxq9IjlhKKrF43M3GdYpDGrQjxMEtE4NKBxxQ5W8AJC3dapjJqDTRA7eqj/
	NpjRSWJuNPD+7eJbFONCW26+p4bXiHXGBproeMW0t3nt8wOzGyp+dVsd/D+7jd+JKacHnVyK5/g
	+GLzlDIZrVI7dn3hXH5JXCgk63GkslXN+ovHB1L8GdE4x3ZAbooVIZRCzjslNe4O0dtgxGbYw5E
	I5l6Gqh2tZ97vpsfY0z5D253GKeeJ/0OzAO59/cm2AJLRUhuZH7ntn4ZIY5zeuD0TfY0IlDI0CK
	55OSzfbp8S2N8+dfyFTr8+7+aWmyzNBIouBBFZDZfaOBinX5sgZAXiNAo6nkBfN54Joriraa5mk
	M9gcnK3mi4aUEMDVCe6qRlaSxE0drL6ok0a98BrCqwCpDUc9remCnE0GmHQLRtfFhW+UuTWIivc
	cwFuVjiI8kPKp6fTUCOEZ1hpNiuorKGw==
X-Received: by 2002:a05:7301:6793:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2e464dafc32mr9775519eec.5.1776790244409;
        Tue, 21 Apr 2026 09:50:44 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 2/8] selftests/bpf: Add basic libarena scaffolding
Date: Tue, 21 Apr 2026 12:50:31 -0400
Message-ID: <20260421165037.4736-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421165037.4736-1-emil@etsalapatis.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
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

The code includes workarounds that are removed in subsequent patches,
like the qnode definitions for selftest.c. This is to ensure
bisectability.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  27 +++
 tools/testing/selftests/bpf/libarena/Makefile |  75 ++++++++
 .../selftests/bpf/libarena/include/common.h   |  66 ++++++++
 .../bpf/libarena/include/selftest_helpers.h   |  99 +++++++++++
 .../bpf/libarena/selftests/selftest.c         | 160 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  62 +++++++
 7 files changed, 490 insertions(+)
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
index f75c4f52c028..a8d94f23a9c6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -153,6 +153,7 @@ override define CLEAN
 	$(Q)$(RM) -r $(TEST_KMODS)
 	$(Q)$(RM) -r $(EXTRA_CLEAN)
 	$(Q)$(MAKE) -C test_kmods clean
+	$(Q)$(MAKE) -C libarena clean
 	$(Q)$(MAKE) docs-clean
 endef
 
@@ -524,6 +525,7 @@ LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
 
 HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
+			$(wildcard $(CURDIR)/libarena/include/*.[ch])	\
 			$(addprefix $(BPFDIR)/,	bpf_core_read.h	\
 			                        bpf_endian.h	\
 						bpf_helpers.h	\
@@ -739,6 +741,28 @@ $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
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
@@ -931,3 +955,6 @@ override define INSTALL_RULE
 		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
 	done
 endef
+
+test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
new file mode 100644
index 000000000000..304197e8a22f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -0,0 +1,75 @@
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
+all: test_libarena
+
+test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@
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
+	$(Q)rm -f *.skel.h *.bpf.o test_libarena
diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tools/testing/selftests/bpf/libarena/include/common.h
new file mode 100644
index 000000000000..338a5b4b19e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -0,0 +1,66 @@
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
index 000000000000..92e580ea80de
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
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
index 000000000000..bd4794be18fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -0,0 +1,160 @@
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
+struct arena_qnode {
+	unsigned long next;
+	int count;
+	int locked;
+};
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
+		if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--verbose") == 0) {
+			verbose = true;
+			continue;
+		}
+
+		fprintf(stderr, "usage: ./%s [-v] [--verbose]\n", argv[0]);
+		fprintf(stderr, "verbose option prints out BPF streams,"
+				" including ASAN stacks when applicable\n");
+
+		return -EINVAL;
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

