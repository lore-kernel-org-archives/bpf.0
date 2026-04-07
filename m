Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1F342177
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537861; cv=none; b=MBy0nJ/hiyDi364Z4PI+3KwhqV3H753st2KP9McFGMEiS5XLb36mE2WAuJvupweBcNrPu2kwPxti06oSzO13YXR4DmESQ5QtZyX8dSeVjtiGhahnU0HhUW6bahN8YolPeLzH/3tAEXs6uTHFurV0sDFbCbS1dkNU3XGIRHFi17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537861; c=relaxed/simple;
	bh=R3HoKoWT/OeXnLwqcWIk/tVauAzJ9l1+dr26Kyk465s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz8ebaWfwx5SiQL7k1gn0IXiixQbX528cQX4yFM+23+cSxQQ3mVUpFJlsh2i2JqvC/Jhnwd1fFE+YpBzGmZoU1WiKq+PPMWd9FAw4/RMvtWVQBiYtSYAE0PcHojN65XcLAQj6S6PUzs3x3y61leZxArZTuZF2eVt6lMDcghQbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cdI9wDiK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cdI9wDiK"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a7539851fso2024000b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537859; x=1776142659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWf7YEXQufEbDM1laagvEtjFsgA3lKSNRkHmIB48xdc=;
        b=cdI9wDiKi+zGjk2kof3/Wbt1fahBr6MHgWq7EkXdfJSP23bSXMJ6qtVo1K2jKYVwcG
         LCWOv0LNOxoGAvHarRtkh6A966IBURZOPPW7H5hvm+e3wBZjTlf1P7yPg4YWrzxlm9Pb
         zR9+XvYWm5k0uL5EMV8Cl6WcPUkf82tnmOOCmULB5BFEyTQl5En04wGtKWaW5Dy3s89y
         iRD+XGiUVdUQ05KSFim/jyeBUV0gYf7o9mOwgQnwOPXBpY1kPR87gcVcOgoIIhArMNZt
         amEEyqgo08Mq72gaRXZwNmD6gC6SAG4mp7sjkbt2E3OxjwJ0GTK97nJV1Pik/g2Bpssl
         r5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537859; x=1776142659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWf7YEXQufEbDM1laagvEtjFsgA3lKSNRkHmIB48xdc=;
        b=qlxT3tMFBWXWab+ZUb9ORnUfn/XCirXhKlWUT1eTi1aKQy4QLSNdz2UP3wqQvRio3K
         X5GQ54WZjSYjUkGgX2uCpMevJSuPZKVAAsKtx2gmExE4z43ghTDpcyxAFEybkOD2Zmv4
         RBNjbZvIv73uLSFexqPc9UKUn3knrySU+MmGn7QXqA+b78FcTqyebgHYvU5A1UpbxBOF
         KSxBbWWOHMtJPirjCLNHGPBe1KZ1jt63xoWzGP7OTHITq/GCdOYe6AVYzFA6zmogpM75
         tmmQOHQH7HtvdNOVhDxamQa5Mpv5HCGocQlybXNamMdpkQIBjmHvDIx0VTKdanCn3HMY
         gb1Q==
X-Gm-Message-State: AOJu0YygdlgOgtDCnYocgbniip8B3MZxoPaCbr5gnfL8iDKyV6i5aPOR
	gB9UPy8nISyXIHNfdxjM/kfCb6TYsCVQfh/MoWwlUDWH19jpiImgL4kM5ux68noIaFFh2iayQS4
	8CLyEZSSnhw==
X-Gm-Gg: AeBDietMqFAWexQ+oAXFgOM+VMr+f6+mtvEMfDCTTcCe1PYvj5Kfb4j1kMzG7jjFGlJ
	Ww7Ztb8/ThiIQln1ZPe79MX9jWjTEtGgO1W0h7LsLnoYSUvqCovYsoRJquzdEJfT9dXyMvszq+U
	TkaaP6RAfwKBCo+MsqNC+Ur4ATZq+TdZIjghCvPSk2QfwhH8x9tlcfLcjO10UzDJ+FJXdGmeDVc
	sXty5GgD7L2RWnx3l+Fa68WBkFPmRoBhl0XxRxwXPkHQNTP/A3U8IP0TcUT4s1s86XIhzkSwlOg
	HzyAIvFKr4Qkw4AONdBPHoZZykLpKlr8d/ih4lb0M+13GAK5tqpd8res3bKGZspAh5rYM+sYa1W
	PyXaBLUzCsgCE21h8oM6fUYtjByYBz3Z09htoLeUstLx9eTLidV9FgQfQKtWG9PJJH+ttxqAk31
	JFxw==
X-Received: by 2002:a05:6a00:4fc6:b0:82c:dde3:f2ef with SMTP id d2e1a72fcca58-82d0dbc1be2mr14687781b3a.50.1775537859184;
        Mon, 06 Apr 2026 21:57:39 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:38 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 7/9] selftests/bpf: Add ASAN support for libarena selftests
Date: Tue,  7 Apr 2026 00:57:28 -0400
Message-ID: <20260407045730.13359-8-emil@etsalapatis.com>
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

Expand the arena library selftest infrastructure to support
address sanitization. Add the compiler flags necessary to
compile the library under ASAN when supported.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          | 13 +++++-
 tools/testing/selftests/bpf/libarena/Makefile | 31 ++++++++++++-
 .../bpf/libarena/include/selftest_helpers.h   | 28 +++++++++++
 .../selftests/bpf/libarena/include/userapi.h  |  1 +
 .../bpf/libarena/selftests/selftest.c         | 27 ++++++++++-
 .../bpf/libarena/selftests/st_asan_common.h   | 46 +++++++++++++++++++
 7 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 7f1960d6b59e..50fa79b2daac 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -50,3 +50,4 @@ verification_cert.h
 usdt_1
 usdt_2
 libarena/test_libarena
+libarena/test_libarena_asan
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0d332c991023..f10e865338f6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -751,6 +751,13 @@ LIBARENA_MAKE_ARGS = \
 		BPF_TARGET_ENDIAN="$(BPF_TARGET_ENDIAN)" \
 		Q="$(Q)"
 
+# libarena_asan.skel.h currently requires LLVM 22. For now,
+# only integrate the non-ASAN version with test_progs.
+LIBARENA_SKEL := libarena/libarena.skel.h
+
+$(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -774,7 +781,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h	\
 			 bpftool_helpers.c	\
-			 usdt_1.c usdt_2.c
+			 usdt_1.c usdt_2.c	\
+			 $(LIBARENA_SKEL)
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
@@ -946,3 +954,6 @@ endef
 
 test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
 	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
+
+test_libarena_asan: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index 151ab6d0509c..c988da56c863 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -8,6 +8,7 @@ LIBARENA=$(abspath .)
 
 LIBARENA_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LIBARENA)/selftests/*.bpf.c)
 LIBARENA_OBJECTS = $(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o))
+LIBARENA_OBJECTS_ASAN = $(notdir $(LIBARENA_SOURCES:.bpf.c=_asan.bpf.o))
 
 INCLUDES = -I$(LIBARENA)/include -I$(LIBARENA)/..
 ifneq ($(INCLUDE_DIR),)
@@ -17,6 +18,13 @@ ifneq ($(LIBBPF_INCLUDE),)
 INCLUDES += -I$(LIBBPF_INCLUDE)
 endif
 
+ASAN_FLAGS = -fsanitize=kernel-address -fno-stack-protector -fno-builtin
+ASAN_FLAGS += -mllvm -asan-instrument-address-spaces=1 -mllvm -asan-shadow-addr-space=1
+ASAN_FLAGS += -mllvm -asan-use-stack-safety=0 -mllvm -asan-stack=0
+ASAN_FLAGS += -mllvm -asan-kernel=1
+ASAN_FLAGS += -mllvm -asan-constructor-kind=none
+ASAN_FLAGS += -mllvm -asan-destructor-kind=none
+
 # ENABLE_ATOMICS_TESTS required because we use arena spinlocks
 override BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
 override BPF_CFLAGS += -O2 -Wno-incompatible-pointer-types-discards-qualifiers
@@ -28,23 +36,42 @@ CFLAGS += $(INCLUDES)
 vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
 vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
 
-all: test_libarena
+all: test_libarena test_libarena_asan
+
+test_libarena_asan: selftest.c $(BPFOBJ) libarena_asan.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(CFLAGS) -DBPF_ARENA_ASAN $< $(BPFOBJ) $(LDLIBS) -o $@
 
 test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
 	$(call msg,BINARY,libarena,$@)
 	$(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@
 
+skeletons: libarena.skel.h libarena_asan.skel.h
+.PHONY: skeletons
+
+libarena_asan.skel.h: main_asan.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "libarena_asan" > $@
+
 libarena.skel.h: main.bpf.o
 	$(call msg,GEN-SKEL,libarena,$@)
 	$(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
 
+main_asan.bpf.o: $(LIBARENA_OBJECTS_ASAN)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
 main.bpf.o: $(LIBARENA_OBJECTS)
 	$(call msg,GEN-OBJ,libarena,$@)
 	$(Q)$(BPFTOOL) gen object $@ $^
 
+%_asan.bpf.o: %.bpf.c
+	$(call msg,CLNG-BPF,libarena,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) $(ASAN_FLAGS) -DBPF_ARENA_ASAN $(BPF_TARGET_ENDIAN) -c $< -o $@
+
 %.bpf.o: %.bpf.c
 	$(call msg,CLNG-BPF,libarena,$@)
 	$(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
 
 clean:
-	$(Q)rm -f *.skel.h *.bpf.o test_libarena
+	$(Q)rm -f *.skel.h *.bpf.o *.linked*.o test_libarena test_libarena_asan
diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
index ee445d8f5b26..0cb3fdddd535 100644
--- a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -79,3 +79,31 @@ static inline int libarena_get_globals_pages(int arena_get_base_fd,
 	free(vec);
 	return 0;
 }
+
+static inline int libarena_asan_init(int arena_get_base_fd,
+				     int asan_init_fd,
+				     size_t arena_all_pages)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct asan_init_args args;
+	u64 globals_pages;
+	int ret;
+
+	ret = libarena_get_globals_pages(arena_get_base_fd,
+					 arena_all_pages, &globals_pages);
+	if (ret)
+		return ret;
+
+	args = (struct asan_init_args){
+		.arena_all_pages = arena_all_pages,
+		.arena_globals_pages = globals_pages,
+	};
+
+	opts.ctx_in = &args;
+	opts.ctx_size_in = sizeof(args);
+
+	ret = bpf_prog_test_run_opts(asan_init_fd, &opts);
+	if (ret)
+		return ret;
+	return opts.retval;
+}
diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/tools/testing/selftests/bpf/libarena/include/userapi.h
index b4ac6bc9bd79..5d3a851fb65a 100644
--- a/tools/testing/selftests/bpf/libarena/include/userapi.h
+++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
@@ -24,3 +24,4 @@ typedef int64_t s64;
 #define arena_spinlock_t u64
 
 #include "common.h"
+#include "asan.h"
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index b69adc7baaab..2bd8363ea614 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -18,6 +18,17 @@
 #include <userapi.h>
 #include <selftest_helpers.h>
 
+#include "selftest.h"
+
+#ifdef BPF_ARENA_ASAN
+#include "../libarena_asan.skel.h"
+typedef struct libarena_asan selftest;
+#define selftest__open libarena_asan__open
+#define selftest__open_and_load libarena_asan__open_and_load
+#define selftest__load libarena_asan__load
+#define selftest__attach libarena_asan__attach
+#define selftest__destroy libarena_asan__destroy
+#else
 #include "../libarena.skel.h"
 typedef struct libarena selftest;
 #define selftest__open libarena__open
@@ -25,6 +36,7 @@ typedef struct libarena selftest;
 #define selftest__load libarena__load
 #define selftest__attach libarena__attach
 #define selftest__destroy libarena__destroy
+#endif
 
 static bool verbose = false;
 static int testno = 1;
@@ -69,6 +81,7 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 
 int run_test(selftest *skel, const struct bpf_program *prog)
 {
+	size_t arena_pages = (1UL << 32) / sysconf(_SC_PAGESIZE);
 	int prog_fd;
 	int ret;
 
@@ -76,6 +89,15 @@ int run_test(selftest *skel, const struct bpf_program *prog)
 	if (ret)
 		return ret;
 
+#ifdef BPF_ARENA_ASAN
+	ret = libarena_asan_init(
+		bpf_program__fd(skel->progs.arena_get_base),
+		bpf_program__fd(skel->progs.asan_init),
+		arena_pages);
+	if (ret)
+		return ret;
+#endif
+
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0)
 		return prog_fd;
@@ -119,10 +141,13 @@ static void
 banner(const char *progpath)
 {
 	char *name = basename(progpath);
+	bool is_asan;
 
+	/* Check if our BPF programs are ASAN-capable using strstr on the prog name. */
 	printf("%s\n", name);
+	is_asan = strstr(name, "_asan");
 
-	printf("=== %s ===\n", "libarena selftests");
+	printf("=== %s %s===\n", "libarena selftests", is_asan ? "(asan) " : "");
 }
 
 int main(int argc, char *argv[])
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
new file mode 100644
index 000000000000..a907c9b45651
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#pragma once
+
+#define ST_PAGES 64
+
+#define ASAN_MAP_STATE(addr)                                                 \
+	do {                                                                 \
+		arena_stdout("%s:%d ASAN %lx -> (val: %x gran: %x set: [%s])", \
+			   __func__, __LINE__, addr,                         \
+			   asan_shadow_value((addr)), ASAN_GRANULE(addr),    \
+			   asan_shadow_set((addr)) ? "yes" : "no");          \
+	} while (0)
+
+/*
+ * Emit an error and force the current function to exit if the ASAN
+ * violation state is unexpected. Reset the violation state after.
+ */
+#define ASAN_VALIDATE_ADDR(cond, addr)                                       \
+	do {                                                                 \
+		asm volatile("" ::: "memory");                               \
+		if ((asan_violated != 0) != (cond)) {                        \
+			arena_stdout("%s:%d ASAN asan_violated %lx", __func__, \
+				   __LINE__, (u64)asan_violated);            \
+			ASAN_MAP_STATE((addr));                              \
+			return -EINVAL;                                      \
+		}                                                            \
+		asan_violated = 0;                                           \
+	} while (0)
+
+#define ASAN_VALIDATE()                                                 \
+	do {                                                            \
+		if ((asan_violated)) {                                  \
+			arena_stdout("%s:%d Found ASAN violation at %lx", \
+				   __func__, __LINE__, asan_violated);  \
+			return -EINVAL;                                 \
+		}                                                       \
+	} while (0)
+
+struct blob {
+	volatile u8 mem[59];
+	u8 oob;
+};
+
+
-- 
2.53.0

