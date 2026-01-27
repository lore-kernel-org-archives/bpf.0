Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039002264AB
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537793; cv=none; b=OVHMwbDj5R7FVUvrZnporl2vR+6PPlKE2ry5edJ6sj6f1YcdfjxsEdg3t4SCg8PMT8s+nGr6pa6xvqWAdA4c7NUKEdPPnNJYlBmzouEagQswzykvU5dYPylfARYfVTj5K1yjx/uB5y7Q5FNdm62ooZpz79aDaFbpTsIYISaAchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537793; c=relaxed/simple;
	bh=PuvgkxkrSvF3P74YGbhFkuREEA9yVdstLjqtvKChAUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzEC3im6n/alBYTfizP/wLWrFGe8XmHR9u4p6zKPWVNW8hnzLSj5ZcwVz1xKOWvJ0zpskYVGrKYm58JseR8flcEeCgJYwSqTAeFtHPgZrnAu4hVgWg0ao9rTJ+VjIkOtZmAsWWD4Jxk46hVr5btTkaGfaWVU/kliVq/z6XDQgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=PHcIUOX2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="PHcIUOX2"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5032e15525aso10392411cf.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537791; x=1770142591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya4h/O0GXgJhSW22PucmH1ln4afrj40Q3ecYaRAvzhw=;
        b=PHcIUOX2ZyG/qOl67n16zCTHLqu8ui8h1xDHHRyGBvPdAbazabnFy7Zm1R/cxorvr/
         p9i5YcmbrXjdxYcQstZWeJeM0XIP3EbEMQSU6cg5G2BZ8bk8pzmU0BCFdrgJgj8QV5LP
         igg5nFspiOsivf5LQi+6Pvnf9GYA6QzcqBJdMEXsY6BzaG2Tn7np9vKtbBnVTlqDFbor
         Bo2EOgsKCDlcAbQQE48VW1faoLeFZM+IbPA3TZiOzlVMFIFQ98FWMrHgechm6BPM9Ucm
         1CLWP5cnjvsjBm/9brS7qDkLrEa7LBq/xj3+uqwHVIZ8jenSJeIXRbJB4sIi0Sru0f3b
         wfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537791; x=1770142591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ya4h/O0GXgJhSW22PucmH1ln4afrj40Q3ecYaRAvzhw=;
        b=a7PCQN3qTdCo3e/bi2ESml5H9tIb/Po4B58N0GIAFvDC+FAp1ANqAChNQSGTFwsrfX
         yXva7HCGnxNE+4lp+Fi3yzBP5xkgh32VF5W6QWmW8o+ZG6pBSQnDqHzQPcyZ7E8DFvDJ
         0DsJhx0NLZ9kax7VFOTnXL4Gwk7i2PmzX0UvRRfWuasHacI+XFS0lICQv/02ACwpkRD9
         Eh5ZIuEuWtG+xXCoTgCagTU8IE5reii3IdUTo7dsaeLSQKG8PaEq4ditvHMqZv7AEo0m
         a91eVw8xPqFkbiw8Uu5nza9zVmUYMHRA/9dwObDx1HVWaumuWKHGKoQsa13vUfNBQr+V
         dVlw==
X-Gm-Message-State: AOJu0YzkZRL2uHW4Cs2UTNY1AIjMAJPP0SnVT+D3DdmIwj0hDmNFyLde
	tEdLCgNGWC3qW937JAY3GupT2qM6zIi7yXzsWrsOicUhOL8WgqhxhcFp7jxtavoRIJm7iyIkTNY
	twsjw
X-Gm-Gg: AZuq6aLlEKZH2yR6arjzu+Bzm8VZ+5oCOTDntNbSy7QE5scBckJbgc9B0uma+2np6aL
	g5whF4/cvci5nRDjoB4MeYSeYOJroQmhAolHzdsOaKKtDkzUKUe2H+q8OBHLJtkHu45YWjWHkFi
	rUBVhelPcLn5TgqPoUV6eUarGTqrABMrUrdfk6zwiADsEDhiRgT0ZEDPHLOur7ZSeAYOEaglSX2
	fwt9kgbEE28Ux9k6PuuGfTSxOMhWzVDPigEhBoqDI6DBRIr0f8BHxRHWTatZWZ77zrr7egdUnFW
	JhvljS6/+9Ce3pIvesDAXLJL9vsGFbs7Wsgiyyk9JuuORZ42VpSCtlHU9UNRMY3T+nXSlaizpGx
	OemM9BIChDGOzkSQ2ZsqIoo1rIH/jaeaA8lo/Fq1fi0QD0Q8938AKrCW6osjt+JuDiiIvzscLj/
	2IWcdpQW97vQ==
X-Received: by 2002:ac8:5ad3:0:b0:501:1796:b10e with SMTP id d75a77b69052e-5032f76d867mr32874561cf.12.1769537790748;
        Tue, 27 Jan 2026 10:16:30 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:30 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 07/13] selftests: bpf: Add ASAN support for libarena selftests
Date: Tue, 27 Jan 2026 13:16:03 -0500
Message-ID: <20260127181610.86376-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Expand the arena library selftest infrastructure to support
address sanitization. Add the compiler flags necessary to
compile the library under ASAN when supported.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          | 14 +++-
 tools/testing/selftests/bpf/libarena/Makefile | 26 ++++++-
 .../selftests/bpf/libarena/include/userapi.h  |  1 +
 .../bpf/libarena/selftests/selftest.c         | 69 ++++++++++++++++++-
 .../bpf/libarena/selftests/st_asan_common.h   | 49 +++++++++++++
 5 files changed, 155 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 49b275a7bfa1..2b59a5c2235b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -917,7 +917,19 @@ override define INSTALL_RULE
 endef
 
 test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
-	+$(MAKE) -C libarena all \
+	+$(MAKE) -C libarena $@ \
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
+test_libarena_asan: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
+	+$(MAKE) -C libarena $@ \
 		BPFTOOL="$(BPFTOOL)" \
 		INCLUDE_DIR="$(HOST_INCLUDE_DIR)" \
 		LIBBPF_INCLUDE="$(HOST_INCLUDE_DIR)" \
diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index 70901bb5237f..1ec1a83c0c04 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -5,6 +5,7 @@ LIBARENA=$(abspath .)
 
 LIBARENA_SOURCES = $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LIBARENA)/selftests/*.bpf.c)
 LIBARENA_OBJECTS = $(notdir $(LIBARENA_SOURCES:.bpf.c=.bpf.o))
+LIBARENA_OBJECTS_ASAN = $(notdir $(LIBARENA_SOURCES:.bpf.c=_asan.bpf.o))
 
 INCLUDES = -I$(LIBARENA)/include -I$(LIBARENA)/..
 ifneq ($(INCLUDE_DIR),)
@@ -14,6 +15,13 @@ ifneq ($(LIBBPF_INCLUDE),)
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
@@ -25,23 +33,37 @@ CFLAGS += $(INCLUDES)
 vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
 vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
 
-all: test_libarena
+test_libarena_asan: selftest.c $(BPFOBJ) selftest_asan.skel.h
+	$(call msg,BINARY,libarena,$@)
+	$(Q)$(CLANG) $(LDLIBS) $(CFLAGS) -DBPF_ARENA_ASAN $< $(BPFOBJ) -o $@
 
 test_libarena: selftest.c $(BPFOBJ) selftest.skel.h
 	$(call msg,BINARY,libarena,$@)
 	$(Q)$(CLANG) $(LDLIBS) $(CFLAGS) $< $(BPFOBJ) -o $@
 
+selftest_asan.skel.h: main_asan.bpf.o
+	$(call msg,GEN-SKEL,libarena,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name "selftest_asan" > $@
+
 selftest.skel.h: main.bpf.o
 	$(call msg,GEN-SKEL,libarena,$@)
 	$(Q)$(BPFTOOL) gen skeleton $< name "selftest" > $@
 
+main_asan.bpf.o: $(LIBARENA_OBJECTS_ASAN)
+	$(call msg,GEN-OBJ,libarena,$@)
+	$(Q)$(BPFTOOL) gen object $@ $^
+
 main.bpf.o: $(LIBARENA_OBJECTS)
 	$(call msg,GEN-OBJ,libarena,$@)
 	$(Q)$(BPFTOOL) gen object $@ $^
 
+%_asan.bpf.o: %.bpf.c
+	$(call msg,CLNG-BPF,libarena,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) $(ASAN_FLAGS) -DBPF_ARENA_ASAN $(BPF_TARGET_ENDIAN) -c $< -mcpu=v3 -o $@
+
 %.bpf.o: %.bpf.c
 	$(call msg,CLNG-BPF,libarena,$@)
 	$(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
 
 clean:
-	$(Q)rm -f *.skel.h *.bpf.o test_libarena
+	$(Q)rm -f *.skel.h *.bpf.o test_libarena test_libarena_asan
diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/tools/testing/selftests/bpf/libarena/include/userapi.h
index bd5e7042a44f..c294b6818bed 100644
--- a/tools/testing/selftests/bpf/libarena/include/userapi.h
+++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
@@ -20,3 +20,4 @@ typedef int64_t s64;
 #define arena_spinlock_t u64
 
 #include "common.h"
+#include "asan.h"
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 5b8d8b94323e..f63324a1cdde 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -22,8 +22,20 @@
 
 #include "selftest.h"
 
+#include <asan.h>
+
+#ifdef BPF_ARENA_ASAN
+#include "../selftest_asan.skel.h"
+typedef struct selftest_asan selftest;
+#define selftest__open selftest_asan__open
+#define selftest__open_and_load selftest_asan__open_and_load
+#define selftest__load selftest_asan__load
+#define selftest__attach selftest_asan__attach
+#define selftest__destroy selftest_asan__destroy
+#else
 #include "../selftest.skel.h"
 typedef struct selftest selftest;
+#endif
 
 static bool verbose = false;
 static int testno = 1;
@@ -155,6 +167,48 @@ selftest_globals_pages(selftest *skel, size_t arena_all_pages, u64 *globals_page
 	return 0;
 }
 
+#if BPF_ARENA_ASAN
+static int
+selftest_asan_init(selftest *skel)
+{
+	struct bpf_test_run_opts opts;
+	size_t arena_all_pages = 1ULL << 20;
+	struct asan_init_args args;
+	u64 globals_pages;
+	int prog_fd;
+	int ret;
+
+	ret = selftest_globals_pages(skel, arena_all_pages, &globals_pages);
+	if (ret)
+		return ret;
+
+	/* Taken from the arena map header. */
+	args = (struct asan_init_args) {
+		.arena_all_pages = arena_all_pages,
+		.arena_globals_pages = globals_pages,
+	};
+
+	opts = (struct bpf_test_run_opts) {
+		.sz = sizeof(opts),
+		.ctx_in = &args,
+		.ctx_size_in = sizeof(args),
+	};
+
+	prog_fd = bpf_program__fd(skel->progs.asan_init);
+	assert(prog_fd >= 0 && "no program found");
+	return selftest_fd(prog_fd, &opts);
+}
+
+#else /* BPF_ARENA_ASAN */
+
+static int
+selftest_asan_init(selftest *skel)
+{
+	return 0;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 		const char *format, va_list args)
 {
@@ -172,6 +226,10 @@ int run_test(selftest *skel, const struct bpf_program *prog)
 	if (ret)
 		return ret;
 
+	ret = selftest_asan_init(skel);
+	if (ret)
+		return ret;
+
 	prog_fd = bpf_program__fd(prog);
 	if (!prog_fd)
 		return -ENOENT;
@@ -211,8 +269,17 @@ static void
 banner(const char *progpath)
 {
 	char *name = basename(progpath);
+	bool is_asan;
+
+	/* 
+	 * Check if our BPF programs are ASAN-capable by inspecting the prog name.
+	 * Command line arguments are guaranteed to be NULL-terminated, use strlen. 
+	 * Calculate the hardcoded name's length at compile time.
+	 */
+	printf("%s\n", name);
+	is_asan = strstr(name, "_asan");
 
-	printf("=== %s ===\n", "libarena selftests");
+	printf("=== %s %s===\n", "libarena selftests", is_asan ? "(asan) " : "");
 }
 
 int main(int argc, char *argv[])
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
new file mode 100644
index 000000000000..d8a6316bba47
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
@@ -0,0 +1,49 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#pragma once
+
+#define ST_PAGES 64
+
+#define ASAN_MAP_STATE(addr)                                                 \
+	do {                                                                 \
+		bpf_printk("%s:%d ASAN %lx -> (val: %x gran: %x set: [%s])", \
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
+			bpf_printk("%s:%d ASAN asan_violated %lx", __func__, \
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
+			bpf_printk("%s:%d Found ASAN violation at %lx", \
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
2.49.0

