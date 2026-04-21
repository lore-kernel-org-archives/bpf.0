Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E0F28504F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790252; cv=none; b=Q7XmaJvQT1QOyuUMrjYMuMsacdzmtBzQLw+5T0p3ZyD2tqzFQw7vch8xkSDMBgvlSq5q3t6ucQf6qaw2GV+HBPCnBq9WZBFE1krPLaiPHWnJGRBX7yKOEAXiNVD8/sq11TLkNOd0+UnMFjI0cWF6m+fB5rrrYi+R6WTInoqP/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790252; c=relaxed/simple;
	bh=fY1hIQfYTKr2/D9p0l+JXmaZWEhQYHR8cIzbrQKsE6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2c0OwmNHk2iGY15tnlHQUFWNCCFpbPpmgb0AUA8X0svvwanKG0bs1Ze9Rlov8z/6vPokm2988hlwpQdThMyOqDecTZ5Tc38HCrlAij5jWuzex+MIAmf8zTgEsYDJ3dHaTC45GZTiB6pysMjTQ38G1pa5rkpaLexCuoYK+B2RsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qWFyXJyX; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qWFyXJyX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5794544eec.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790249; x=1777395049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjlchzul3ZZYKjk6RCqP428e986SlJICwPb+UrWYWtg=;
        b=qWFyXJyX64+AU6lL0Vzqt3HqFhqDUMgWIe7b367CDF5vhqE2f/4X28YUPmN96liG5P
         ZLV0AdfBASfkfPJSOvune1LdFWkd/CchMkLcBgV02Nbw8DIJ6SUPpvL1v3aQqQELSraZ
         v7zLezVQeFdOU91a57zX9n16b/c7aSDoWxVDn8iEvZNyg+tV0HUqQI4fpOHJr4+amN9K
         j4oLl9LcpB1/9MxYDxUiDElAokapOt7+OFGgglHch5bbbTIOa7RobyiGQM5pUsZ17BB2
         6Y8MqIKmesOPTIcnWR0f+yQylKco7pUKipiNXVCTEFHoYxj8/DXMNzLaRE33xBADcgOu
         ZWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790249; x=1777395049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wjlchzul3ZZYKjk6RCqP428e986SlJICwPb+UrWYWtg=;
        b=JA+f+nInjnX0YmIJC7lTdvUepijl5b4uUc1HcseRkAYNVRT1pc0vtqSY0DULcBUI/s
         ELlL8LCERl0CKUX3PPXxWpW1OzK/+Tr9FRUCGC7Ix/5MCXJSH7YEsgk3JzMTlT+tX8my
         QLzeWtjHJFpQ0dzHt0VmPqfe5yy0NflnrNj+nSBp4+LxSbjcl5q6o3sArH5wFAhf8Uy7
         Z11gznn2WRMqJvgckzOJkRPl2rgMp1g7h036PYwj4Bz2ukbO1iQQWyNc0GIwbY6V1jkG
         YTIOjj8qwdrBDtGKOLGmgvpxTXKe7LnxbvFWieQ3Gb1qNPXmfiJns5UKdonFuWHwglvZ
         4+DA==
X-Gm-Message-State: AOJu0YwsjGNxkGVR0UKA9N3+7cEWUKwNifBiwZnVAe2jJA9JSCemxCuF
	lK1WUKA4RlOQoXtmD+p2WUkb+KJS45H5w+AHZOUxmCZb9VqIiduPAl4VDyqOtkTndXIheteZJz7
	vP7aPgYghGYh3
X-Gm-Gg: AeBDievghYVuw3o9MUrgeqZBg6eiwk5TD9vkXs0ssBARI1QL+waL42B0uJFU/MGR73F
	qQnmKJAB0N3b2iL1c14iOZ4tafC90z5dFvkrjhOBpxMjQGZXXgXPfXXrguRjxRzVRCc3VPl+giW
	TDKej+3svY0yhWGhBKm1Wvm9Ti1dxvvW80OMWjkdSfrbMd8cC2njq0poobdZx+gmt5NZOxQvOHL
	ZKETkmf8PYuGGluYk22/rdcosQS9lafADWmsjwMQNdh9VH3S9WrV0bAo6YEb5mgd+xm7MQDlVYv
	tFJMlRoNS1+2gx+pCMWWlP3KzaXnECdXlZGef1qepwSN6hCdws1PpbBUr9Mw02WSA62M0dXC3EW
	ckzS+rtyPHGviq6WElezlHxtbM4F1wLgqV2MlpcngWMkgXk0yBYVY2FgNh1flm9t0a+IbxYMzHX
	axHv9hX3oVSLCE6Zbj6ltHLSNVv23EVQ==
X-Received: by 2002:a05:7300:4313:b0:2d2:96e8:1bf5 with SMTP id 5a478bee46e88-2e464eaa3ecmr9259079eec.3.1776790248759;
        Tue, 21 Apr 2026 09:50:48 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:48 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 5/8] selftests/bpf: Add ASAN support for libarena selftests
Date: Tue, 21 Apr 2026 12:50:34 -0400
Message-ID: <20260421165037.4736-6-emil@etsalapatis.com>
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

Expand the arena library selftest infrastructure to support
address sanitization. Add the compiler flags necessary to
compile the library under ASAN when supported.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          |  6 ++-
 tools/testing/selftests/bpf/libarena/Makefile | 29 +++++++++++-
 .../bpf/libarena/include/selftest_helpers.h   | 33 +++++++++++++
 .../bpf/libarena/selftests/selftest.c         | 40 ++++++++++++++--
 .../bpf/libarena/selftests/st_asan_common.h   | 47 +++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  2 +
 7 files changed, 153 insertions(+), 5 deletions(-)
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
index 9cf197c077f6..a5743cfacc22 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -788,7 +788,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h	\
 			 bpftool_helpers.c	\
-			 usdt_1.c usdt_2.c
+			 usdt_1.c usdt_2.c	\
+			 $(LIBARENA_SKEL)
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
@@ -960,3 +961,6 @@ endef
 
 test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
 	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
+
+test_libarena_asan: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index 304197e8a22f..cbd23c928e53 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -30,6 +30,7 @@ LIBBPF_INCLUDE ?= $(INCLUDE_DIR)
 # Scan src/ and selftests/ to generate the final binaries
 LIBARENA_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LIBARENA)/selftests/*.bpf.c)
 LIBARENA_OBJECTS = $(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o))
+LIBARENA_OBJECTS_ASAN = $(notdir $(LIBARENA_SOURCES:.bpf.c=_asan.bpf.o))
 
 INCLUDES = -I$(LIBARENA)/include -I$(BPFDIR)
 ifneq ($(INCLUDE_DIR),)
@@ -39,6 +40,13 @@ ifneq ($(LIBBPF_INCLUDE),)
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
 override BPF_CFLAGS += -O2 -g
@@ -55,21 +63,40 @@ vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
 
 all: test_libarena
 
+test_libarena_asan: selftest.c $(BPFOBJ) libarena_asan.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(CFLAGS) -DBPF_ARENA_ASAN $< $(BPFOBJ) $(LDLIBS) -o $@
+
 test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
 	$(call msg,BINARY,libarena,$@)
 	$(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@
 
+skeletons: libarena.skel.h libarena_asan.skel.h
+.PHONY: skeletons
+
+libarena_asan.skel.h: libarena_asan.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "libarena_asan" > $@
+
 libarena.skel.h: libarena.bpf.o
 	$(call msg,GEN-SKEL,libarena,$@)
 	$(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
 
+libarena_asan.bpf.o: $(LIBARENA_OBJECTS_ASAN)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
 libarena.bpf.o: $(LIBARENA_OBJECTS)
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
index 92e580ea80de..8fe8a65266e7 100644
--- a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -27,6 +27,11 @@ static inline bool libarena_is_test_prog(const char *name)
 	return strstr(name, "test_") == name;
 }
 
+static inline bool libarena_is_asan_test_prog(const char *name)
+{
+	return strstr(name, "asan_test") == name;
+}
+
 static inline int libarena_run_prog_args(int prog_fd, void *args, size_t argsize)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
@@ -97,3 +102,31 @@ static inline int libarena_get_globals_pages(int arena_get_base_fd,
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
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index bd6527c9ca72..d1377d8073ef 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -16,8 +16,18 @@
 #include <sys/sysinfo.h>
 
 #include <common.h>
+#include <asan.h>
 #include <selftest_helpers.h>
 
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
@@ -25,6 +35,7 @@ typedef struct libarena selftest;
 #define selftest__load libarena__load
 #define selftest__attach libarena__attach
 #define selftest__destroy libarena__destroy
+#endif
 
 static bool verbose;
 static int testno = 1;
@@ -67,6 +78,26 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 	return vfprintf(stderr, format, args);
 }
 
+static int init_arena(selftest *skel)
+{
+	int ret;
+
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	if (ret)
+		return ret;
+
+#ifdef BPF_ARENA_ASAN
+	ret = libarena_asan_init(
+		bpf_program__fd(skel->progs.arena_get_base),
+		bpf_program__fd(skel->progs.asan_init),
+		(1ULL << 32) / sysconf(_SC_PAGESIZE));
+	if (ret)
+		return ret;
+#endif
+
+	return 0;
+}
+
 static int run_test(selftest *skel, struct bpf_program *prog)
 {
 	int prog_fd;
@@ -82,10 +113,13 @@ static void
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
@@ -125,7 +159,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	ret = init_arena(skel);
 	if (ret) {
 		fprintf(stderr, "Failed to initialize arena: %d\n", ret);
 		selftest__destroy(skel);
@@ -135,7 +169,7 @@ int main(int argc, char *argv[])
 	bpf_object__for_each_program(prog, skel->obj) {
 		const char *name = bpf_program__name(prog);
 
-		if (!libarena_is_test_prog(name))
+		if (!libarena_is_test_prog(name) && !libarena_is_asan_test_prog(name))
 			continue;
 
 		ret = run_test(skel, prog);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
new file mode 100644
index 000000000000..58b1b0ae6a77
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#pragma once
+
+#define ST_PAGES 64
+
+static inline void print_asan_map_state(void __arena *addr)
+{
+	arena_stdout("%s:%d ASAN %p -> (val: %x gran: %x set: [%s])",
+			__func__, __LINE__, addr,
+			*(s8a *)(addr), ASAN_GRANULE(addr),
+			asan_shadow_set(addr) ? "yes" : "no");
+}
+
+/*
+ * Emit an error and force the current function to exit if the ASAN
+ * violation state is unexpected. Reset the violation state after.
+ */
+static inline int asan_validate_addr(bool cond, void __arena *addr)
+{
+	if ((asan_violated != 0) == cond) {
+		asan_violated = 0;
+		return 0;
+	}
+
+	arena_stdout("%s:%d ASAN asan_violated %lx", __func__, __LINE__,
+			(u64)asan_violated);
+	print_asan_map_state(addr);
+	return -EINVAL;
+}
+
+static inline int asan_validate(void)
+{
+	if (!asan_violated)
+		return 0;
+
+	arena_stdout("%s:%d Found ASAN violation at %lx", __func__, __LINE__,
+			asan_violated);
+
+	return -EINVAL;
+}
+
+struct blob {
+	volatile u8 mem[59];
+	u8 oob;
+};
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index db6dd8a011ae..1c185b75d799 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <common.h>
 
+#include <asan.h>
+
 const volatile u32 zero = 0;
 
 /* How many pages do we reserve at the beginning of the arena segment? */
-- 
2.53.0

