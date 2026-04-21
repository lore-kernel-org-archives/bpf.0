Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8A37E2FA
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790256; cv=none; b=k/kF8z44eFsF163SEcKXgUzciTog9pRinWPuTd5Zh1yH6BZVyVAyc7yjUB85DmnCd/dppTJPz8fIN+M6j80Reu/1hH4uJShl1xAlAxoluuYIqYNpyl5PPVDV8j37j9lVXPuaBL0SiW2a6K42oj6aGCTveTuGwKtlTsOpyapG/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790256; c=relaxed/simple;
	bh=AUI2FVJ+K/ZC2xK3tIv2rXKY0BRbEl4apsOMaDkJL8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XToYGKDpUbfAQMs95xmgqGYgBD7X0PNLgnaG/s8P8liDpr9lSw83iHdYzCy4xPTx5ErQIC25bAEbHBVlJW2k5DEQ8urVQKj5wsXRmYSSFFO4otejwYC8mOjLkxApFO8jokvaBXqG7C0/SQ079uRSDW0tnoxUgNUlrEovVlE3zC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GsRLvX3X; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GsRLvX3X"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so6471459c88.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790252; x=1777395052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp0N2+tbCAeZWeluucf4owdIWervGqDRLwsP2bxn9hM=;
        b=GsRLvX3Xx2rsPt1Z+OBk0OfKHqzDPwkFhStrgComo8LEGLlcpRWYKvu+gFmsjCYKSJ
         zOh0KnnJRknSzfc6R8+K64D0079sRcTGourKkzGREk0VVnUeaGZZ7rZZtbMa8Wl74hsP
         IozhXV9PFSAzLB8rIAPO3+izbZeZR2j2TbonhJXd3+TOZ4owRZ9wY/HYRTRkqpZwpKDw
         KeIjRWHm5YMYCQ0xUjg95Z1oS1XBEHGeizga9sTovwAq+Ulq09Tho39UntUcDIuID/6G
         RBggiXzTOGT4f5sWqzZD4b7//saA4tfvFoB6JZhB8RU84SsfRSK4fbHdsB5J1gvp/XiI
         FF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790252; x=1777395052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rp0N2+tbCAeZWeluucf4owdIWervGqDRLwsP2bxn9hM=;
        b=OEIOWyNrxFfujipzpigLdS4eJDALJoMnaazeATHl6/VvfYue5hyIvAmuumOCcKKXO+
         T80W1pUzHFurT6FuVsW0qmoYfEII4+QTzDCxURjC2EynmH+MLYn5ocy/A5VPueDIvusm
         V5uW6SP3nxROqd5lbcvKCFf3Hrf+Qo3wDpDDm92A3Y/n7/ylRv0j7K2+jPnVOu6pFVPv
         6snVMk1Cgj0CCKbhvdJfB8XRv/oreA97MUtwSy34nSjjmjjCUKsI1h1AvDEL09RhdDLP
         sKmr8d1YpSPwN40g1TtfHzkEOf+tbrDlMKDabUvkV55GKSxL5Kz/asQCvuknPAGx67QJ
         alCQ==
X-Gm-Message-State: AOJu0YzVzAotDjJtsf0Tcd3lnLnq4+iK0tCgr8Xugfzg4AfmGBAETDEx
	21ETj+s4aIfWai8HAFqtxlJ3F2uVAlmZo4YtYRWcadmHwx65Me/Fo38mt/MvTA4i6+EvMbxBeXr
	bjkZh0ElzYyz8
X-Gm-Gg: AeBDieu9sNsA7u7VX3ii7fMnt+jDfvHzX7x1sEoI85BAwWOOX3CRn/Ls8FC+wN70p5M
	wltCH7HS1xc6yy66T0xtdCfAbLeWM6VbH0pb9++/NgsAOE+ZfFvx7hw94yyCFftIG7zNJekSRJ4
	L9ZIAYAhLa/mknc4yaEzhgqtTHnhAED3HIZWD/hQ3DjtbXRokktka4siUkvehpTYMYa+WtravDi
	kOws7MQk+yXZDvzOEwdmQ4sf1ElomzbPKTWvz50wqPVE8MCTDOOzWC0r3+cucltViVPxK61KUy1
	/IDePR8hmG/6Da5Ifxz7H9Ws97LTahIu9soRf9gjNKm2KbJuX+06GAI8fyID8u9Nca6eMB49O4Z
	rPqCH4TX0aA/mAH98+zI8klc9HaDaXCgtvb7/F986HbXRK5HxRlBN7DzjTNuFxWjHlb/5XVHr2y
	Dj/xIIwPpoooKP3n25VSnHIEv1xyz9Og==
X-Received: by 2002:a05:7301:3d19:b0:2d1:9b35:4ed3 with SMTP id 5a478bee46e88-2e4874ea1f2mr11201498eec.28.1776790251488;
        Tue, 21 Apr 2026 09:50:51 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:51 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 7/8] selftests/bpf: Add selftests for libarena buddy allocator
Date: Tue, 21 Apr 2026 12:50:36 -0400
Message-ID: <20260421165037.4736-8-emil@etsalapatis.com>
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

Introduce selftests for the buddy allocator with and without
ASAN. Add the libarena selftests both to the libarena test
runner and to test_progs, so that they are a) available when
libarena is pulled as a standalone library, and b) exercised
along with all other test programs in this directory.

ASAN for libarena requires LLVM 22. Add logic in the top-level
selftests Makefile to only compile the ASAN variant if the
compiler supports it, otherwise skip the test.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          |  17 +-
 .../bpf/libarena/include/selftest_helpers.h   |   7 +
 .../bpf/libarena/selftests/selftest.c         |   7 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 241 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 208 +++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       |  62 +++++
 .../selftests/bpf/prog_tests/libarena_asan.c  |  87 +++++++
 7 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena_asan.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a5743cfacc22..3efb26774a97 100644
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
@@ -765,6 +771,14 @@ LIBARENA_SKEL := libarena/libarena.skel.h
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
@@ -789,7 +803,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 ip_check_defrag_frags.h	\
 			 bpftool_helpers.c	\
 			 usdt_1.c usdt_2.c	\
-			 $(LIBARENA_SKEL)
+			 $(LIBARENA_SKEL)	\
+			 $(LIBARENA_ASAN_SKEL)
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
index 8fe8a65266e7..e9fb76d187f2 100644
--- a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -130,3 +130,10 @@ static inline int libarena_asan_init(int arena_get_base_fd,
 		return ret;
 	return opts.retval;
 }
+
+static inline bool libarena_must_setup_alloc(struct bpf_program *prog)
+{
+	const char *name = bpf_program__name(prog);
+
+	return !strstr(name, "test_buddy");
+}
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 4c95c36aa097..d1d37b8bf9e3 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -102,6 +102,13 @@ static int init_arena(selftest *skel)
 static int run_test(selftest *skel, struct bpf_program *prog)
 {
 	int prog_fd;
+	int ret;
+
+	if (libarena_must_setup_alloc(prog)) {
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+		if (ret)
+			return ret;
+	}
 
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0)
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
new file mode 100644
index 000000000000..4b995cce2730
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+extern buddy_t buddy;
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int ret, i;
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	mem = buddy_alloc(&buddy, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		mem[i] = 0xba;
+		ret = asan_validate_addr(false, &mem[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	mem[alloc_size] = 0xba;
+	ret = asan_validate_addr(true, &mem[alloc_size]);
+	if (ret < 0)
+		return ret;
+
+	buddy_free(&buddy, mem);
+
+	return 0;
+}
+
+/*
+ * Factored out because asan_validate_addr is complex enough to cause
+ * verification failures if verified with the rest of asan_test_buddy_uaf_single.
+ */
+__weak int asan_test_buddy_byte(u8 __arena __arg_arena *mem, int i, bool freed)
+{
+	int ret;
+
+	/* The header in freed blocks doesn't get poisoned. */
+	if (freed && BUDDY_HEADER_OFF <= i &&
+		i < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
+		return 0;
+
+	mem[i] = 0xba;
+	ret = asan_validate_addr(freed, &mem[i]);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+__weak int asan_test_buddy_uaf_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int ret;
+	int i;
+
+	mem = buddy_alloc(&buddy, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		ret = asan_test_buddy_byte(mem, i, false);
+		if (ret)
+			return ret;
+	}
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	buddy_free(&buddy, mem);
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		ret = asan_test_buddy_byte(mem, i, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct buddy_blob {
+	volatile u8 mem[48];
+	u8 oob;
+};
+
+static __always_inline int asan_test_buddy_blob_single(void)
+{
+	volatile struct buddy_blob __arena *blob;
+	const size_t alloc_size = sizeof(struct buddy_blob) - 1;
+	int ret;
+
+	blob = buddy_alloc(&buddy, alloc_size);
+	if (!blob)
+		return -ENOMEM;
+
+	blob->mem[0] = 0xba;
+	ret = asan_validate_addr(false, &blob->mem[0]);
+	if (ret < 0)
+		return ret;
+
+	blob->mem[47] = 0xba;
+	ret = asan_validate_addr(false, &blob->mem[47]);
+	if (ret < 0)
+		return ret;
+
+	blob->oob = 0;
+	ret = asan_validate_addr(true, &blob->oob);
+	if (ret < 0)
+		return ret;
+
+	buddy_free(&buddy, (void __arena *)blob);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int asan_test_buddy_oob(void)
+{
+	size_t sizes[] = {
+		7, 8, 17, 18, 64, 256, 317, 512, 1024,
+	};
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret) {
+		arena_stdout("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+		ret = asan_test_buddy_oob_single(sizes[i]);
+		if (ret) {
+			arena_stdout("%s:%d Failed for size %lu", __func__,
+				   __LINE__, sizes[i]);
+			buddy_destroy(&buddy);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&buddy);
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int asan_test_buddy_uaf(void)
+{
+	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 1024, 16384 };
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret) {
+		arena_stdout("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+		ret = asan_test_buddy_uaf_single(sizes[i]);
+		if (ret) {
+			arena_stdout("%s:%d Failed for size %lu", __func__,
+				   __LINE__, sizes[i]);
+			buddy_destroy(&buddy);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&buddy);
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int asan_test_buddy_blob(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret) {
+		arena_stdout("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = zero; i < iters && can_loop; i++) {
+		ret = asan_test_buddy_blob_single();
+		if (ret) {
+			arena_stdout("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			buddy_destroy(&buddy);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&buddy);
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+#endif
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
new file mode 100644
index 000000000000..b12d18790fa5
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+extern buddy_t buddy;
+
+struct segarr_entry {
+	u8 __arena *block;
+	size_t sz;
+	u8 poison;
+};
+
+#define SEGARRLEN (512)
+static struct segarr_entry __arena segarr[SEGARRLEN];
+static void __arena *ptrs[17];
+size_t __arena alloc_sizes[] = { 3, 17, 1025, 129, 16350, 333, 9, 517 };
+size_t __arena alloc_multiple_sizes[] = { 3, 17, 1025, 129, 16350, 333, 9, 517, 2099 };
+size_t __arena alloc_free_sizes[] = { 3, 17, 64, 129, 256, 333, 512, 517 };
+size_t __arena alignment_sizes[] = { 1, 3, 7, 8, 9, 15, 16, 17, 31,
+				     32, 64, 100, 128, 255, 256, 512, 1000 };
+
+SEC("syscall")
+__weak int test_buddy_create(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		ret = buddy_init(&buddy);
+		if (ret)
+			return ret;
+
+		ret = buddy_destroy(&buddy);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alloc(void)
+{
+	void __arena *mem;
+	int ret, i;
+
+	for (i = zero; i < 8 && can_loop; i++) {
+		ret = buddy_init(&buddy);
+		if (ret)
+			return ret;
+
+		mem = buddy_alloc(&buddy, alloc_sizes[i]);
+		if (!mem) {
+			buddy_destroy(&buddy);
+			return -ENOMEM;
+		}
+
+		buddy_destroy(&buddy);
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alloc_free(void)
+{
+	const int iters = 800;
+	void __arena *mem;
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		mem = buddy_alloc(&buddy, alloc_free_sizes[(i * 5) % 8]);
+		if (!mem) {
+			buddy_destroy(&buddy);
+			return -ENOMEM;
+		}
+
+		buddy_free(&buddy, mem);
+	}
+
+	buddy_destroy(&buddy);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alloc_multiple(void)
+{
+	int ret, j;
+	u32 i, idx;
+	u8 __arena *mem;
+	size_t sz;
+	u8 poison;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	/*
+	 * Cycle through each size, allocating an entry in the
+	 * segarr. Continue for SEGARRLEN iterations. For every
+	 * allocation write down the size, use the current index
+	 * as a poison value, and log it with the pointer in the
+	 * segarr entry. Use the poison value to poison the entire
+	 * allocated memory according to the size given.
+	 */
+	for (i = zero; i < SEGARRLEN && can_loop; i++) {
+		sz = alloc_multiple_sizes[i % 9];
+		poison = (u8)i;
+
+		mem = buddy_alloc(&buddy, sz);
+		if (!mem) {
+			buddy_destroy(&buddy);
+			arena_stdout("%s:%d", __func__, __LINE__);
+			return -ENOMEM;
+		}
+
+		segarr[i].block = mem;
+		segarr[i].sz = sz;
+		segarr[i].poison = poison;
+
+		for (j = zero; j < sz && can_loop; j++) {
+			mem[j] = poison;
+			if (mem[j] != poison) {
+				buddy_destroy(&buddy);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/*
+	 * Go to (i * 17) % SEGARRLEN, and free the block pointed to.
+	 * Before freeing, check all bytes have the poisoned value
+	 * corresponding to the element. If any values are unexpected,
+	 * return an error. Skip some elements to test destroying the
+	 * buddy allocator while data is still allocated.
+	 */
+	for (i = 10; i < SEGARRLEN && can_loop; i++) {
+		idx = (i * 17) % SEGARRLEN;
+
+		mem = segarr[idx].block;
+		sz = segarr[idx].sz;
+		poison = segarr[idx].poison;
+
+		for (j = zero; j < sz && can_loop; j++) {
+			if (mem[j] != poison) {
+				buddy_destroy(&buddy);
+				arena_stdout("%s:%d %lx %u vs %u", __func__,
+					   __LINE__, &mem[j], mem[j], poison);
+				return -EINVAL;
+			}
+		}
+
+		buddy_free(&buddy, mem);
+	}
+
+	buddy_destroy(&buddy);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alignment(void)
+{
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	/* Allocate various sizes and check alignment */
+	for (i = zero; i < 17 && can_loop; i++) {
+		ptrs[i] = buddy_alloc(&buddy, alignment_sizes[i]);
+		if (!ptrs[i]) {
+			arena_stdout("alignment test: alloc failed for size %lu",
+				   alignment_sizes[i]);
+			buddy_destroy(&buddy);
+			return -ENOMEM;
+		}
+
+		/* Check 8-byte alignment */
+		if ((u64)ptrs[i] & 0x7) {
+			arena_stdout(
+				"alignment test: ptr %llx not 8-byte aligned (size %lu)",
+				(u64)ptrs[i], alignment_sizes[i]);
+			buddy_destroy(&buddy);
+			return -EINVAL;
+		}
+	}
+
+	/* Free all allocations */
+	for (i = zero; i < 17 && can_loop; i++)
+		buddy_free(&buddy, ptrs[i]);
+
+	buddy_destroy(&buddy);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
new file mode 100644
index 000000000000..e051e2c3d2c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <unistd.h>
+
+#include "libarena/include/common.h"
+#include "libarena/include/asan.h"
+#include "libarena/include/buddy.h"
+#include "libarena/include/selftest_helpers.h"
+
+#include "libarena/libarena.skel.h"
+
+static void run_libarena_test(struct libarena *skel, struct bpf_program *prog,
+		const char *name)
+{
+	int ret;
+
+	if (libarena_must_setup_alloc(prog)) {
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+		if (!ASSERT_OK(ret, "arena_buddy_reset"))
+			return;
+	}
+
+	ret = libarena_run_prog(bpf_program__fd(prog));
+
+	ASSERT_OK(ret, name);
+
+}
+
+void test_libarena(void)
+{
+	struct libarena *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = libarena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	ret = libarena__attach(skel);
+	if (!ASSERT_OK(ret, "attach"))
+		goto out;
+
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	if (!ASSERT_OK(ret, "arena_alloc_reserve"))
+		goto out;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		const char *name = bpf_program__name(prog);
+
+		if (!libarena_is_test_prog(name))
+			continue;
+
+		if (!test__start_subtest(name))
+			continue;
+
+		run_libarena_test(skel, prog, name);
+	}
+
+out:
+	libarena__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
new file mode 100644
index 000000000000..4e54949b1e3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#ifdef HAS_BPF_ARENA_ASAN
+#include <unistd.h>
+
+#include "libarena/include/common.h"
+#include "libarena/include/asan.h"
+#include "libarena/include/buddy.h"
+#include "libarena/include/selftest_helpers.h"
+
+#include "libarena/libarena_asan.skel.h"
+
+static void run_libarena_asan_test(struct libarena_asan *skel,
+		struct bpf_program *prog, const char *name)
+{
+	int ret;
+
+	if (libarena_must_setup_alloc(prog)) {
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+		if (!ASSERT_OK(ret, "arena_buddy_reset"))
+			return;
+	}
+
+	ret = libarena_run_prog(bpf_program__fd(prog));
+	ASSERT_OK(ret, name);
+}
+
+static void run_test(void)
+{
+	struct libarena_asan *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = libarena_asan__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	ret = libarena_asan__attach(skel);
+	if (!ASSERT_OK(ret, "attach"))
+		goto out;
+
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	if (!ASSERT_OK(ret, "arena_alloc_reserve"))
+		goto out;
+
+	ret = libarena_asan_init(
+		bpf_program__fd(skel->progs.arena_get_base),
+		bpf_program__fd(skel->progs.asan_init),
+		(1ULL << 32) / sysconf(_SC_PAGESIZE));
+	if (!ASSERT_OK(ret, "libarena_asan_init"))
+		goto out;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		const char *name = bpf_program__name(prog);
+
+		if (!libarena_is_asan_test_prog(name))
+			continue;
+
+		if (!test__start_subtest(name))
+			continue;
+
+		run_libarena_asan_test(skel, prog, name);
+	}
+
+out:
+	libarena_asan__destroy(skel);
+}
+
+#endif /* HAS_BPF_ARENA_ASAN */
+
+/*
+ * Run the test depending on whether LLVM can compile arena ASAN
+ * programs.
+ */
+void test_libarena_asan(void)
+{
+#ifdef HAS_BPF_ARENA_ASAN
+	run_test();
+#else
+	test__skip();
+#endif
+
+	return;
+}
+
-- 
2.53.0

