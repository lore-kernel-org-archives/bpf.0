Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF642BF3F4
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956751; cv=none; b=pe9fD6B45ABa3oUYz7YkgVEOGgHXvqMcSvmrL8cLhViXABh4lddzAqT+HER3Ge02JGSByU4hxMXEQE1o/Y3Vehh/2f02FPJDAtvDJwXFURvM6PnEC5fisc0wrJuaXlKsSX0BDwtOxwF91FiSD2ATTOfHCwZOVwqDpbejObxB4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956751; c=relaxed/simple;
	bh=cT/wKNmPcL8uwZGas2fiGcSynh7OzxfpY5TJfHGtp/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvjsAPn9NST5xzpTLe6Sdw+YN2KIXfehV807HOO0dbiRQvRzDT3icCAgawVS3QcHWUMqmQ3rrioKZ8cEeT0YTtAV2LjByc3uw4p48Oa+YcZEwPPh+5vpTaQ0w+K01JxSCoyQ5e7iRolTH2TIUWp2t7TF2t0LX2WX4/1DbbMtAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OlIv5OtP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OlIv5OtP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f37c09352so7365b3a.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775956750; x=1776561550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWw6Js2OMofECZ1RujUWCnG3yOrSPVxH1G6O2SAL/B8=;
        b=OlIv5OtPPZFK8+bC2MeNtAZPhSrSvW2nl42vtQJJLpP+lmk6xFSuBqfujYha55a4TI
         kJ+qOk8iqV2eXEPBVNgnaLgQ4CWQ3p8JQ+thsuDCcNcAGDha50T8VRurKlbnLOFzuK1t
         xkfQzSG3x2tDCZvtzg54A4gkjJEYFa13F+JIsFThAYBT6/huRypu0fGuKbipDYh31VS6
         BqOwBhP64xgZGqTlELDhtE1UbqKlEIPz27dslGiOuBBy7kxfWDS8SBwSk46TPaeSi+VK
         FKD7qO7ijecnV7Hrv0NtT0L2czMkFgIoaw1wMlh3jJHjN9OQkHKu2LFC2Fa+QMrv0lK0
         PFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956750; x=1776561550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWw6Js2OMofECZ1RujUWCnG3yOrSPVxH1G6O2SAL/B8=;
        b=i4Hn7APtH/9OVntiTFhg7lJ5OfHpuY703gyvOlNGmJ5ysL7wxWv1Ajkq8DOz+9E76T
         h/6Mv29YNoACxiUPYnts816ihvjSvzC2KYljvkKQvqd2EUJRkZ6K7TBYFfECeIMGPXhK
         jtFuhxueCUK/99aic+vDDL2+oIMlII+kjNNIdMBaYf69MssovD8Y3g0Z8wLoy80zYer8
         feYztqfpa8GIqjnApk/iJGoHOsptDILM1x6xN2nu2Zyi7cvD5yW++zjPEw42LupRqP7E
         QPHPIKOUEa2T/+ndn3Bz2ThbYnZdjwP4cWq1Y1El9fvLwcn019JdQNjsHJi0KF568Bke
         q9Uw==
X-Gm-Message-State: AOJu0Yzjju4eDGmmetzaOxACQKdsZz10N0+hCbo6WLVr/nASiE4zrkuF
	g7rLab/TiG0Fr8N8J+LefyokIDIZ8+04S4PpEQXBULY4SB9jmcMxr600iTPQFlKphe1Xo1EfmmS
	Np3Z+r4A=
X-Gm-Gg: AeBDietUn5w2pZW0slSjtFiMROVGcT1dWl2M5B5rHHGTAIvbz2jJ/4i7dJks79/Zir1
	yFEunXHb5J2abkbzesJgPD1KBQEYBGXru+bwAVKfFbCs+yUknMoYGgK3rF1hjXZYEG5/awpOsRT
	K+ylPFr3FLP7goFj5aWacBJ+6scJ43qV88V+D9IZFiEUHHmLMt0zDv7WZUQs8j8BSw7jhtIhnGE
	Ra5FprqkUGvs/Mwj15POV1+XFgTbzIa5WlbwBycz2GE3Jy7pQSuq91MdLDdguHF2AwnNqIBeTI/
	2vJY+BNvfoQPjo9U7jTztjFp5QMa7A+1N6nI9RhqtogMINFHeghevqixOs8AWTALjzs9uN5wZph
	dZ7OZEcADUqo6alQe39X4n42oMShVYVOksW/9/tDva8HxVVZdCG/MAspPSinSgIt74snkx9W8E7
	2cNw==
X-Received: by 2002:a05:6a21:6da7:b0:39b:92ea:d182 with SMTP id adf61e73a8af0-39fc930822dmr13261064637.10.1775956749453;
        Sat, 11 Apr 2026 18:19:09 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa72sm6569310a12.6.2026.04.11.18.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:09 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 9/9] selftests/bpf: Add selftests for libarena buddy allocator
Date: Sat, 11 Apr 2026 21:18:57 -0400
Message-ID: <20260412011857.3387-10-emil@etsalapatis.com>
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

Introduce selftests for the buddy allocator without ASAN.
Add the libarena selftests both to the libarena test
runner and to test_progs, so that they are a) available when
libarena is pulled as a standalone library, and b) exercised
along with all other test programs in this directory.

Currently ASAN for libarena requires LLVM 22, which is not
available in the CI. Delay testing the ASAN case directly
through test_progs until that is the case. The ASAN version
is available for testing on demand through the library's own
harness.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/selftest_helpers.h   |   7 +
 .../bpf/libarena/selftests/selftest.c         |   8 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 243 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 211 +++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       |  62 +++++
 5 files changed, 531 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c

diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
index 36e4f36ae8e6..cb8bf9b7cd71 100644
--- a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -112,3 +112,10 @@ static inline int libarena_asan_init(int arena_get_base_fd,
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
index 3639cfe41217..cfa435027b73 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -17,6 +17,7 @@
 
 #include <common.h>
 #include <asan.h>
+#include <buddy.h>
 #include <selftest_helpers.h>
 
 #ifdef BPF_ARENA_ASAN
@@ -101,6 +102,13 @@ static int init_arena(selftest *skel)
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
index 000000000000..21e811f60003
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,243 @@
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
+u64 __arena st_asan_buddy_lock;
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
+	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 128, 1024, 16384 };
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
index 000000000000..82afdeb49496
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,211 @@
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
+typedef struct segarr_entry __arena segarr_entry_t;
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
+	idx = 0;
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
-- 
2.53.0

