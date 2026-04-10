Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10E3DC4DA
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838671; cv=none; b=Vy/ClylZNilpMsUI0JGYj+eV1mtUwOy842Pfu9G88pY+tvtaCMztFZHfvdiwLRbX204u3bK2G/Ozfib+bJt2HiZ7qHuQ5j+scOhXUrLfT6S2NJ7iHsKrSd9i48TOzaC4N1M0S1C+zoFmetWYp1xeYcKnOxrR3ufdaYl/wZ/k5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838671; c=relaxed/simple;
	bh=giS/xpDS29EDbW9A6kZNdzNQXwgOSFaq4qGwlla0L/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyZU1lZNhXtfKPE/vxHSeqDVZ+aMPTPMy0AcMsZY5+ecIeLG9XLxV3NtuPkEC/JZRhtVTqVvtL4NhV8C+XugDLW3AiY+AIo3l91ODqCW3plHfmg2R/07BO/sVaxWj817OKrRfXoFDsGV6U8Vg1nZzONjruIZEJKY0CgHVoGY8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uuNcIU0d; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uuNcIU0d"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ce22328930so3327355eec.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775838669; x=1776443469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpDdhZ8XJ1OXLzoQXyZF8PfmyKHNpRUOhKOgVgGj7XM=;
        b=uuNcIU0dCVBt0PK7P/uMsMGbhFxkViWCbjN0HlvMN+8ncIxJWHCXLQmqHUwJcVnJOj
         6LTv0fqYrB29re5gD186wwdUcvMOSaHLATFzK57je4wjWb+DS6P2/r8sv6dC2akY0PhN
         TIV5+ru4fO6lk6DkeRALumhOt+6wa4sNJQ2CeQ96IDdHQyuuGCANz2dy2bTBWparh9H5
         dMyD4vEk7XO1uFJYEePqFMo9v7ZJcPUaD6djIpgix+RJrS1zGb59quH6V0/BYmGoghB2
         13PM4f/7ndODPzje4lh40srB1g8Nwi2lp+Iz1jN7iDZdzkR4gdBr5wH6zfB7XEDuXLCt
         hFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838669; x=1776443469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YpDdhZ8XJ1OXLzoQXyZF8PfmyKHNpRUOhKOgVgGj7XM=;
        b=iLdCZJDWw8Xg1oNdT3Kh1FJnLSDmo5kvez6eIBgLxsWbKn6Y6mW1+OcYoUXzNTGrvS
         9yZUrxE8hmvf14ya/K2nx61/EB3Icl5zTrc2PoaGkmhtCQksjwTD7shLD6mIEALI934u
         0dHrkPPMfhpttwz2lymBnPprsYnxejmQhH/QI6Df0ewk+h45eXX4LuU7IbMwxQRGN2dQ
         hGLTI2MGRpMG9I5mydepWL6aBpw9JYUrm8S0Z5YFx1T4T4GNKifgQWLxcvlibL4sr382
         3fHzjhtIjjzX607+MI5hz1GzZkwZ39AKYefLWqFEU02nbvW9PA8ngsxXmp0JCEN7ed9e
         evnw==
X-Gm-Message-State: AOJu0YxLYHlgQ+fayoDyB3cP1ffDLpT/+94qX27Cfx4/XC0sbPiQZeev
	kGNVptYuA0Yrh9odd4Ho3a0GM7vfOImzJfpNf4KPyQmJaVZB4mmd3l0Am9OiZKFV0QaMAXrrVw4
	IKFuLG8o=
X-Gm-Gg: AeBDiesoSmpyzHvSKknwi+LYRQLhdBBwWxM1VciXCrc+k06ykSjXWwM9jNW6Y7LLah3
	SIu/EV3lGVxvUaVhnvTMCVkGvQVJEPqWFLN3lSMpFJCXMCFiTE8e3aFmRXs+uC6fAddorQvTKRG
	nEi4NYtDnMYrn6f7COD2KIXbUg3YGaP3tV5CUHOJCPKm9ZRZrlm959aEijvatusjhiamrMP7uKG
	5sB6Mrd/8J3LYOy3A61TgsUxNVt2CTAWhX8pEi+4idfA17xa8g5oRJUJ6CIN+gJisSyHc5a0fz+
	uIrxMCohIri7OnsR+4DbKKXmGvgSjxKb0H/jq2cqNIL0cv2iRSXY4AdKV3Q7JSC3TJnvIpD/Ea3
	d5jDROu3+XLUCEw3sZgNeSJn9Xr7uhaRmPzgcWZeey1hZ34lrrWPrV+sITyUZW71X3f8++K0Jqp
	gUDRPF+kEpzyKVSSiMLY8=
X-Received: by 2002:a05:693c:2c96:b0:2c5:50fe:c771 with SMTP id 5a478bee46e88-2d58aa833b4mr2744323eec.29.1775838668609;
        Fri, 10 Apr 2026 09:31:08 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::6eaf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5642619eec.3.2026.04.10.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:31:08 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 7/9] selftests/bpf: Add ASAN support for libarena selftests
Date: Fri, 10 Apr 2026 12:30:39 -0400
Message-ID: <20260410163041.8063-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163041.8063-1-emil@etsalapatis.com>
References: <20260410163041.8063-1-emil@etsalapatis.com>
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
index da70648968d4..45ab1ac0ef78 100644
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
@@ -116,7 +150,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	ret = init_arena(skel);
 	if (ret) {
 		fprintf(stderr, "Failed to initialize arena: %d\n", ret);
 		selftest__destroy(skel);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
new file mode 100644
index 000000000000..346e89dce172
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
+	arena_stdout("%s:%d ASAN %lx -> (val: %x gran: %x set: [%s])",
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

