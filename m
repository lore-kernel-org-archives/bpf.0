Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC8374E5C
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230228; cv=none; b=AD+S+n0Ji3BLgfu2Sx69cxWYZskZ9Ob7aCJHUCQz3kIUjBBij4DzBg6vy2dqBRV+2BVOhRT8acOOYhBNTMK/aXjLat0QfY3vkMNPm6BNB5UYEencqQAQe/R56kWWVqInwXlfE2t2KFZN890LX95zNyOShZtbnU/y+Va+Dne+/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230228; c=relaxed/simple;
	bh=9ZGVVrHahuo/zTHE4AB4nHjr1TfFf58eScXNbd7iPeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl6o8bC5paL4Ph+2WDF5g1ewm7Iik6pB1nnHwXX28oFVOEnWJ1Q/J0cy8BHQsXM2zORuyo2Kn7EB+zR9i170M6x5nXujKLm2SR/Zmuw++SKWNxCyy8UE1Sfc4OaLtYD8Yad2MsBmHncnlvpfVGKYZuUsBkVgSuTC+B8fKtQUu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=V1G/IP8U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="V1G/IP8U"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad617d5b80so55300445ad.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230224; x=1777835024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWGNMCGfmvIv05u8MPuhR4TBTMU9izLPyHi6JNayx7M=;
        b=V1G/IP8Uilo+IVmeFmGsrWIr6HoqlAjvDwKbVuoKixGXV9LofxYc8m6A/9kUByoPzC
         3a9l3aWICqdY/dh2kdrTqOm4/LYVKQJ32YDMgGWrfyQsK7p6LAMJGjuuPstM4j2tEgMk
         4e4WqEvAy3aVsDWqU9yJ8swWQyeZ9/PosFKXAsfeWCTufzEVaorl32HGelv8cxFJ3pze
         E0dkDJEWMXvx5Aj0cyrSu/nRDZV0mUcTX3CvpG6MfLT7mQYtB7ymLH9DgCZB9wDVQyeM
         +SvxelGcKX1k1aO9O69RGbyFkr8x82vyUHM2zk/I6FcdIIc3mj5Pz/6KCy75IgrPnjBO
         4A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230224; x=1777835024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWGNMCGfmvIv05u8MPuhR4TBTMU9izLPyHi6JNayx7M=;
        b=XiivXHpMatB4QMQubzE5Wu5bU4oNVIm8cBOyOooFlWqKX6Y0pm+zo2IumSq9AEgUVZ
         2g41VGW0vjUCnTod5CV9utKJ5vZ23dXoudIzeqAvIIFEo8cB7LSS/0rCbobXhnytN2ph
         knfTzp9e2QEet9r4yga6yQxg3vDUCqfK9pjhXyyT58/y8mMHPWVsidnbWd6CItDolOcG
         f8bptpQm17qubskG2f6q04bSl4l8n35ScndPljfa56TV9rNSorhIzL8BmKNJfB84OVk3
         uIBxhyvKVZPmEUDVV4BUbqz7j0JYd4z68vqiI3j5vrn1QjgSm/S9EF30jjkxzM04AqyQ
         qIYg==
X-Gm-Message-State: AOJu0YxpkaWsZb6cfEzQg/AmbBLvwWRSx494LWJi7wraVaHsKFopAK6W
	6u7/4Whb2fq00bvMQ6RoPw1UZF2qQVCrYZIOC9tmblWqBdNJECW+t+l9qw1so2uEjbFJNbWgkF4
	zwp5EPn4=
X-Gm-Gg: AeBDieu5ZRHwwEH6TWEuRH4SGBI2n2HGCs/OV/PupAPBsZTi/MZh2ku9OZ1xx+jJ1WV
	y/wQJ+oQiNfTb2l1B/5pOh5l5CQKOQFQNekv0b/6mvdHL79m6614vnJfiZXx81/8w2XF/f9Gssg
	5gw/SCjwdUJeo0mo6Pxacq5dq7zMrtsansbQPT9ufkdiGQsjxk7to2FUPR39b739FKxTxPVHjSS
	KKFQt8rYW3Q+aTABnlZiHZFhfZKeZpUzh30Uj7f8rYLPreG74rtH2S9vPRPHWZKiKvhc4dLEUCF
	+SjQZYiafS3H057DGLm8CCBnLAj6Y6zptL1If4mV4JN6hBsdlKDwQQeKaaCCsG35HZDdbBoEvBt
	nT/vu3ICzo48x+58x8YcqlWCQhE/kl4fSKRr5GVIAF2D19ImBDdyZthBlgaQ2j15h4ZPIm8yOA5
	F5fzYeWX5N2nvg
X-Received: by 2002:a17:902:ce0a:b0:2b0:af2f:b27a with SMTP id d9443c01a7336-2b5f9ec3590mr390210425ad.11.1777230223646;
        Sun, 26 Apr 2026 12:03:43 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b7a9efd0f2sm107449965ad.31.2026.04.26.12.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:03:42 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v9 2/8] selftests/bpf: Add basic libarena scaffolding
Date: Sun, 26 Apr 2026 15:03:32 -0400
Message-ID: <20260426190338.4615-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426190338.4615-1-emil@etsalapatis.com>
References: <20260426190338.4615-1-emil@etsalapatis.com>
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

