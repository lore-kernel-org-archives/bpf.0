Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3AA3793BD
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230231; cv=none; b=nQiSFjoIwlHj9eZ0cGYVnC0F05pIvPMcmrZlCJIOTFCydRA8dA1EuSC5zlY5csU+9tFOvBquRLCdu3ZBxOVpzg0ihVVZRMIA3JCpB0f9UR37L8ajmYAHrcKRqhdRIZucvuu+4MvOs3NoFhcp7mL0Gq/5sWa4KIbH4UdBWNJTa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230231; c=relaxed/simple;
	bh=9z4dAv5GqHIgrSquznIziCMl/dhLEnARu4MCpJCJlAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryoEvnNjwJxYECHTAOhxzN4TbySZsMzDPiUN42drghj9JCvynNbDm1rvRVA9iLngKmleDeh+8Ye1RMVDz1uYWY7l1Y0blhhb1PBB6gZY9lpX3MtBkD4SmI1Sjt2LfEDLSeF2YZMe4N7piNL80MFuxu0pWz3/IbeD8nKRS6tWLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=rDgHGEwf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="rDgHGEwf"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3614826eca4so8385864a91.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230226; x=1777835026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Y/JNU1qJXXhK+nMMrXWJeyJW/vq8z2nIthRMk8EgM=;
        b=rDgHGEwffwUfLq1Z285i2+E20E6s7ATPAvXZVxq7vE8oBQbqz6r2CkE2aTWquujz2Q
         ys+uibPvUY7GFri+MQLHsZbJXXrqKE/4uFpTQF/WcS3M90N8k2rdErO/nuYO6DvhRkaV
         wWdTO+e9ErtTO2lHPnsJRbAN1EMXzFIwm9P4ZWkhHl3Y1GwyzZPipGdFC+y/OAuwenOY
         2soNCRQoXzTFZij0hNIl5ytTTi3zg73nBulmvszC2kmSDcGrXRjayEDpXoAFCJpaMSAC
         Z8NdV+Ztohoq4jcWi0YGjQ8ZDh2wdCj0NlDHIn+TRn67tPi99iusFtxusRaFzgygoVP4
         f2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230226; x=1777835026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4Y/JNU1qJXXhK+nMMrXWJeyJW/vq8z2nIthRMk8EgM=;
        b=e/9YHm0q+x+4e7SdsQYn4B1cLk2qo7VuC7m9sNJgGlP1VhQ09mCbSXSGfkvYbKflQN
         G6pKcQwAqFo2lrwgUZwbJmTLSffVLj66Pyimn0rNRoqmTjGRlkQ/J1z9IvlWpE+KNuL3
         NTlsFbW3eRDCYSYReXbRucx1ATCITjXNOhFAVqx76o8hKq3PNH7Xg0puI7014tc1jCnc
         DRQhnQtOD67CST3/tjoqxPSVmf4Ga2uOhI0FGXUjmyrzIrkvT9mBAd1/gvUnVIBGMRG/
         DXL2n8LHkliRaKlMg8UYn3SshHM09axDIPgkwZJVic3I5ziwXOxW44hBuUkk2Sgcv/dq
         IO5g==
X-Gm-Message-State: AOJu0Yzq/Ax7JYdTOFpiBUMP4v7ZFbPFq+o7w5LY3fLMAsvVb0OHvvf2
	+q+HI4uYP+GRWnVYpp0Y8dwptiCrE3oDBCXPhp1LslhJRDJ+q2TmE9+jMrLotrfa8XI7KhNB7+v
	6DeX0tWc=
X-Gm-Gg: AeBDiet29y+NK1cn7DydNAM+9CgyeN5nH4HnztI/2A732rprII2Q4Ebdn1dWlFNjR2i
	ySM8dY9vrZYbORftGCt8o7LpSJNnB52DkJNoGGycor6jx7TMhm9vpsqCfPLmEb7CkhKkYKY9zO4
	TLpLyVE3AWU3WAIajrkPlQla63T7EEKSn5f6bcJoCuaeTqIhC8ivkNKFSbaozZSztMPGjJmvpU3
	ArZVg4viHk6JsMKgPkexLG5V/JlOLIAznUoIlypB2NsvtgutyDhuHumiibgwzRLblH0XLSKFGaX
	qiAcR7ixlcmCaSAo4JqAP/MSidzJo7fUJtzso9Xl/q/pbWmeKJDwOEmtSCTFeAcKk55r5bSJQyR
	HEXgzRy3Z0DfahOOSRTVdGKSz/s1kK966E+Zji+iXAatw+yKR6SQT5cjcfFMQlBD20TxjMbPRvW
	w+oLc8GgbqC1KO8H6NMhE4Acg=
X-Received: by 2002:a17:90a:509:b0:362:e7ea:244e with SMTP id 98e67ed59e1d1-362e7ea261dmr7199644a91.16.1777230225969;
        Sun, 26 Apr 2026 12:03:45 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b7a9efd0f2sm107449965ad.31.2026.04.26.12.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:03:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 5/8] selftests/bpf: Add ASAN support for libarena selftests
Date: Sun, 26 Apr 2026 15:03:35 -0400
Message-ID: <20260426190338.4615-6-emil@etsalapatis.com>
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

Expand the arena library selftest infrastructure to support
address sanitization. Add the compiler flags necessary to
compile the library under ASAN when supported.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          | 22 +++++++-
 tools/testing/selftests/bpf/libarena/Makefile | 25 ++++++++-
 .../bpf/libarena/include/libarena/userspace.h | 33 ++++++++++++
 .../bpf/libarena/selftests/st_asan_common.h   | 52 +++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  2 +
 5 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 13959c449893..8f694131118c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -79,6 +79,12 @@ ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
 CLANG_CPUV4 := 1
 endif
 
+# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
+CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
+	$(CLANG) --target=bpf -fsanitize=kernel-address \
+	-mllvm -asan-shadow-addr-space=1 \
+	-x c -c - -o /dev/null 2>/dev/null && echo 1)
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
 	test_sockmap \
@@ -767,6 +773,14 @@ LIBARENA_SKEL := libarena/libarena.skel.h
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
 
+ifneq ($(CLANG_HAS_ARENA_ASAN),)
+LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
+CFLAGS += -DHAS_BPF_ARENA_ASAN
+
+$(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
+	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
+endif
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -791,7 +805,9 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h	\
 			 bpftool_helpers.c	\
-			 usdt_1.c usdt_2.c
+			 usdt_1.c usdt_2.c	\
+			 $(LIBARENA_SKEL)	\
+			 $(LIBARENA_ASAN_SKEL)
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
@@ -962,3 +978,7 @@ override define INSTALL_RULE
 endef
 
 libarena: $(LIBARENA_SKEL)
+
+ifneq ($(CLANG_HAS_ARENA_ASAN),)
+libarena_asan: $(LIBARENA_ASAN_SKEL)
+endif
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index e85b3ad96890..5e2ab514805e 100644
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
@@ -53,17 +61,32 @@ CFLAGS += $(INCLUDES)
 vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
 vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
 
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
-	$(Q)rm -f *.skel.h *.bpf.o
+	$(Q)rm -f *.skel.h *.bpf.o *.linked*.o
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
index 0438a751d5fd..88b68ac73cca 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
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
@@ -97,3 +102,31 @@ static inline int libarena_get_globals_pages(int arena_get_globals_fd,
 	free(vec);
 	return 0;
 }
+
+static inline int libarena_asan_init(int arena_asan_init_fd,
+				     int asan_init_fd,
+				     size_t arena_all_pages)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct asan_init_args args;
+	u64 globals_pages;
+	int ret;
+
+	ret = libarena_get_globals_pages(arena_asan_init_fd,
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
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
new file mode 100644
index 000000000000..1d3edc4372ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
@@ -0,0 +1,52 @@
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
+
+	asan_violated = 0;
+
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
+	asan_violated = 0;
+
+	return -EINVAL;
+}
+
+struct blob {
+	volatile u8 mem[59];
+	u8 oob;
+};
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 659ccead5624..84e8a8b7d42e 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <libarena/common.h>
 
+#include <libarena/asan.h>
+
 const volatile u32 zero = 0;
 
 int arena_fls(__u64 word)
-- 
2.53.0

