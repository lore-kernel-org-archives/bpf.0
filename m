Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E1349AEC
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190451; cv=none; b=PVO5mzB6brIC4x3mI1MdbwFSE4V7FJkfcnVv5XWFRtjOyAkcAnHl94i2BIl7jp6f5jCvFPvI/ufhhAiiFkBIaDSklYbg3dPA4uMBfhfbFRL39Ez1xIM7NPpYdIWY7IIoX6ReSNHVTAX0s7+oJje8EMNy67XxCXJCUge1n9vTWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190451; c=relaxed/simple;
	bh=SylsWRMtUTdBhTRO3VNy8CMEkryA+GMR1gjJ4mL9B3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkG0T2YcgxN7lGkGYkZuyk/o/WQQ5ZpGY8ceFsQX21YxJLv+Qt1Tm5kRzEeG2VKTRcipNnLj0pTZkeZkbJJGjhW+AHhpB9rZg3VNbVMN6whopZk/P6z4+hVUAMk9twPtIPhhtJDvJ+qzOfbQIxP0IZ9EZd6vF2dGSnGDF4KCOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=c3sB4j94; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="c3sB4j94"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1004308a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190449; x=1775795249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1YzP1VSYfIrs/XU/0Qhq8Uxmu/ON3cpWZklOVmMn5E=;
        b=c3sB4j94SDnPkeVj4YO+WV9R1aou6ekCeUeWC7iopQ8mNi6EkeCvC+DNLqCjnX9P2y
         R0V+LzaztIM+jb/1aMiamSaH+p7wcmXzQd9FsiNetjdK91c77y7y8caXxRHOIhF3mj6X
         W6yjbczxz5kR+tCG3H5CePo8vgMnSSdl7WKUVl/7CEctyRkg8MeJVfegkEmS2vu8GJIR
         7jw7vb6ErzPYExOuJLMYAoNMyKYT6vfT4/cB88wzmA3q0Iud4iYvJ9eNUezzMLSnCwzh
         43wHh+vlt8XZgx8Mjn7jayY7jM9BKW6Ni20etox+WEDOaJyv/LIOyTAa1r6vI0AJhkTQ
         ebYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190449; x=1775795249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1YzP1VSYfIrs/XU/0Qhq8Uxmu/ON3cpWZklOVmMn5E=;
        b=PEnSbwWMS5NfTFP9jc+ztayUgPmUaEmRCpgBAMBg03gozMaF563JU5HeABYT81+CYq
         D/gBHAk1cx2HVPQEnDaYgpQkqqsVCWKoHEQulxcmOGlANorVehpmx134fATBK1o/gWpz
         xMRipovpxhYofHeeCj4ySWJJ0ZcNzS68vm2RG3BjaNK1cPYbKxj90JGmqqurJhWLJ+67
         g/rj+RxSyngfRkQroDdoFR+nEL2F1FDImw8EMmz0p1ocUeyrWGsGRn6dToetNttVLJB6
         245ld4T/WBD8tvlWljfcQuLbMWG8CeD+HNYUbtLE0JskCQnIbVUMnmqbAlvb6cbJ4WFa
         bozg==
X-Gm-Message-State: AOJu0YwrjjumlKhW9JUpW9YqszaTLYV+nSR0BDlgEYezoBjLvzpLjnvm
	/X8LGFdLXkHu1db6P/EFM5ROrMbAb5+sZA/jMRAZF+Be9IIDbENvcqdo1rAGTwwMlXDIoRovHCK
	iGWkqJR2xqg==
X-Gm-Gg: AeBDieuq8kujhiWV0DyFy9xgcktwjEO0Ej5vbLc9TjdfjxqFUNxwaUxvoOX/AGpBD0g
	v9JrlaZNzCO4/vyaAdiQLHgpQCAfHieAleWZd60hIjbvg0K0Z+qEg3ys8IV+CvRhXUkuqAonJ8d
	awq7xsl2baXVkghweOUV5sC2SumFhgWW/HubdEMoTKAAPQ2v9V1V9zLjfNzV91QAk1CzNJfBsNj
	BQCgLNGk2qNxFLYq/Qa4mTZoFP88Gfh5lfsyLkXL7e1QyKJ6Rc1RfilffkQuNmqPSUU/l23PdBX
	shyZ7+61vzUdZ6PoshDr0NZEGzUt0ZSWYVyI3V650t5lg9yXkD1TW0+6EVEsowEndExhGm24bNa
	9OxvEZpAcc5oWM54viFmMJQs3gb4sdAImlPtACU/D6shK9HurSylPob8NN7U36F1+tXEcM0OFXO
	EsVg==
X-Received: by 2002:a17:90b:4d10:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-35de6977b4emr1262522a91.25.1775190449052;
        Thu, 02 Apr 2026 21:27:29 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:28 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 7/9] selftests/bpf: Add ASAN support for libarena selftests
Date: Fri,  3 Apr 2026 00:27:18 -0400
Message-ID: <20260403042720.18862-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403042720.18862-1-emil@etsalapatis.com>
References: <20260403042720.18862-1-emil@etsalapatis.com>
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
 tools/testing/selftests/bpf/Makefile          | 16 ++++++-
 tools/testing/selftests/bpf/libarena/Makefile | 31 ++++++++++++-
 .../bpf/libarena/include/selftest_helpers.h   | 28 +++++++++++
 .../selftests/bpf/libarena/include/userapi.h  |  1 +
 .../bpf/libarena/selftests/selftest.c         | 27 ++++++++++-
 .../bpf/libarena/selftests/st_asan_common.h   | 46 +++++++++++++++++++
 7 files changed, 146 insertions(+), 4 deletions(-)
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
index 0d332c991023..3254ff81e52a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -751,6 +751,16 @@ LIBARENA_MAKE_ARGS = \
 		BPF_TARGET_ENDIAN="$(BPF_TARGET_ENDIAN)" \
 		Q="$(Q)"
 
+LIBARENA_SKELS := libarena/libarena.skel.h libarena/libarena_asan.skel.h
+
+# Use a stamp file so the submake is invoked only once for both skeletons.
+libarena/.libarena_skels_stamp: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena skeletons $(LIBARENA_MAKE_ARGS)
+	$(Q)touch $@
+
+$(LIBARENA_SKELS): libarena/.libarena_skels_stamp
+	@:
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -774,7 +784,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h	\
 			 bpftool_helpers.c	\
-			 usdt_1.c usdt_2.c
+			 usdt_1.c usdt_2.c	\
+			 $(LIBARENA_SKELS)
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
@@ -946,3 +957,6 @@ endef
 
 test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
 	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
+
+test_libarena_asan: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index 2ad643ad9652..3c143a67d4d9 100644
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
+	$(Q)$(CLANG) $(LDLIBS) $(CFLAGS) -DBPF_ARENA_ASAN $< $(BPFOBJ) -o $@
 
 test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
 	$(call msg,BINARY,libarena,$@)
 	$(Q)$(CLANG) $(CFLAGS) $< $(LDLIBS) $(BPFOBJ) -o $@
 
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
index 8adf92f3b799..8b82fcdc3b7f 100644
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
 		return -ENOENT;
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

