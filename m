Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3629BDBD
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956749; cv=none; b=RupoJb5b1lP0iylty5p/e3CHT0hxKapNKJurP/2MFKecEr5QfLd6qPhWJpsHZDSwzy0uEaOjsbhjX0wywaMiyVMWsbsFr7LKWOavwIZ2iQM6LoS+Re7SXq3lYKS4vHF/OWOWzKa3wSPInFZq88I6z8wh/Oqd0m7AtXrKdO1Fxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956749; c=relaxed/simple;
	bh=xay7t3n0k+MRpx1FWgpo75WcVzCnnSOn7HBRO6SeEKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad903qx6d0+pmuMVezOohPDrIatpOqjv1aBX9LfXy9SoWdrRGYQTdB2T533Q6TU46eEko3u+sVq3C0U7oATjp0GgQLdVeREUKB9xLJSxxg834P5cInLh+JYnWtEzpEgl61lgd6TxvTJfCO/ARG1NPsIvmkn1gUMCYjIExAbLSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uqnWe/tK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uqnWe/tK"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso520105b3a.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775956748; x=1776561548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMklEmQsEXsXkRCe2Pd5aeqI8BKjptEmXzhEaHAWzyA=;
        b=uqnWe/tKQQeK7kWgMJFYnXqUkdikFpeH5xXyFCPlkkVtfeLg10GsEM+smnS0jwaJoY
         XKKyMJI98vPaCTbWHYuXgfWSBpKElnEJmAv5yMWmHiyvcV52V9rn9RGATvQjanxfQ0WK
         fTNAFFiaGSIQC/JwV54a130PDRsuIEVuEDB5BfTbOHaLvfmV7rnvdteOUeAhha2BrV3U
         n83JYbnUssEDwShitKOtYSyOvgCMch3skG3tljxMOEiBkWJ5WeNrrTQfDN/zHpPArENo
         vU6N507Rc0f+fOIOsfuQERN6GTQumkr3oxd8Rgku6q8Uzw2MkEtpqubSvJ1/9PHywoCT
         L28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956748; x=1776561548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMklEmQsEXsXkRCe2Pd5aeqI8BKjptEmXzhEaHAWzyA=;
        b=APEnL1asDQ7C1TI7zZzTI7mrvAv8AZAaq2OQ4ytgvx62TXvTEjePz/ICAGMWBdPBsR
         0u3r3pqJ9eN/Tn/H9Q7Ste1LmtDjYb741NhSCxgaNOADOqJb6GbJGlf9WcEgVqsE0/1U
         HYH2C3ol46M26aSjMqvNQ1rJ8DEzlTJq5/kMPxtFkH+lwMktxuWyjNYw2fOADoLoqBSS
         wBCUnvQ6N5ZuYtX1/EjS6XwZTEisSC/5ri2Y2rBQibOvUFmsXpzJ46LYPm4GHNuNK83W
         7epNc6z7GeLAer3NZ++VaxdG4e6ZJC8vWPFDkfW3xKqfoaRccVy2xzSeUv5FS+1iuEfQ
         yV8Q==
X-Gm-Message-State: AOJu0Yzb84e4YN4ZwDTu38Fybiz2df01KShfW/mb2KDyOgQdkqZCNcBz
	cAZzHlhqsynWTNM7S3Qg9ER58h1w+Ftnzz2yuD2AVNfXqg149zeMRlx4ugRcvKYDkoTPUxkk5AI
	Q7zPSAPE=
X-Gm-Gg: AeBDietT6sFWsbfD1db8VTlMH1sTaOEL5v+NxyXaXe2TlnJaldVGfmof51fWiZJ1oM1
	fwF4EsCjQJ9mSC2yfcCN1XBaTcKdZJ0OSZEe6oJ6+mTQDv6xDXAdvMt0MvKTlDskLDJYdxoyLDW
	b85RCasLPt6psIuh7bWMzAuYsgYabkhLNul28M8Au63FRS3CABL0pfN18q8p7H6u049OEabxsBw
	DLuTtAvvazzXCyb4NHASpY+X6ZTBdJjZIOQhmNY7Vd0b7td+9q8ze58GIlh9SpiO4ZRbnv08Cxo
	KoiMpWSfdsB5UAeKHVAgUpEBo+YiNiTP9nTIjqNZo9luu//Z/bX03RXkGMWl0XfTigoFf89OPLx
	EVOJqOo8pnTJ9N1k9ai6GLUQVLaeesOHo5M3jaw+BRqIQcY81rMuXYL0Ai0WO2NoA8Nw09zkfGw
	53Lg==
X-Received: by 2002:a05:6a20:7d9d:b0:39f:4d08:7555 with SMTP id adf61e73a8af0-39fe3c64bfemr8891324637.5.1775956747627;
        Sat, 11 Apr 2026 18:19:07 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa72sm6569310a12.6.2026.04.11.18.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:06 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 7/9] selftests/bpf: Add ASAN support for libarena selftests
Date: Sat, 11 Apr 2026 21:18:55 -0400
Message-ID: <20260412011857.3387-8-emil@etsalapatis.com>
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

Expand the arena library selftest infrastructure to support
address sanitization. Add the compiler flags necessary to
compile the library under ASAN when supported.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          | 13 ++++-
 tools/testing/selftests/bpf/libarena/Makefile | 31 +++++++++++-
 .../bpf/libarena/include/selftest_helpers.h   | 28 +++++++++++
 .../bpf/libarena/selftests/selftest.c         | 38 ++++++++++++++-
 .../bpf/libarena/selftests/st_asan_common.h   | 47 +++++++++++++++++++
 6 files changed, 153 insertions(+), 5 deletions(-)
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
index 78db8bc0fc67..36e4f36ae8e6 100644
--- a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -84,3 +84,31 @@ static inline int libarena_get_globals_pages(int arena_get_base_fd,
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
index c692e20ea7b1..3639cfe41217 100644
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
@@ -117,7 +151,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	ret = init_arena(skel);
 	if (ret) {
 		fprintf(stderr, "Failed to initialize arena: %d\n", ret);
 		selftest__destroy(skel);
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
-- 
2.53.0

