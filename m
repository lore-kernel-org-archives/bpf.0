Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63B355F4D
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190456; cv=none; b=i5K8a5jne7Zv/xN2TXdehytm3od69iZIo/qzwA/LLtZFHB+mLBHIHhX11g9oMFiLJZEUQ1YfIlwM9Yc8scLTS7xBtXkC1k3AiYonGBpdFhZYMiJqiELX29NhWo02Dq0fsHXKBopqwfpeDj51bgSVJpZQ86CMhGi75FOoMTxXwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190456; c=relaxed/simple;
	bh=hcjskk/M9D9N4DvNnEmDf27t1gbyposNi1VR+FgGUog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2J9MuDMnNYTkZ5Jaaf8QEs2OHxi7q7wlECsUHqMp2rS1VnmhOoDHrPdHYQ87e/BYljCx9brHUe0Hl8C67EZzu1U14TG89t73cnNtnf+MySGjuP8JAplRQv2W/P7lr3tKRKHBLOAKuwtKn0LW15Hgvjn4KZBn+d+rynn1Ky8bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=AsxPxw4j; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="AsxPxw4j"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358ed696623so659080a91.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190451; x=1775795251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzIY3WsWpHamytxVmHfMitAFOIm41VDRJyizKd9Yuso=;
        b=AsxPxw4j9bewZRutENGW35D6HBkW3VgeO6/j2W+GpuoYfGiPfLAExhkvONG7EBB+82
         zJ2JOrOqE+9ed10a0+QXLM4nOg55q776l3O7tFJBT2meIcyZRgGYMGJYVIfZEHF4AeZO
         1uWgkqENnDKWSmlKr7PHMytDZHJ6Dd1Z/89qwV4JD9zp2YKnD0LkE3vedPBEu9urRh68
         hJ9Lo5t/NhcXTHAP2x4oKsFrjOE8UTmk9TDh86JxaJ3h5kjMXpZfcFzqlr5oHc6LeHQc
         r7ebWYvFcglKVxdwa3/uBrEHCEAAA9UobpCkKAoK/evMfst+FTxdypAmdZMj8933yrl+
         3rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190451; x=1775795251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzIY3WsWpHamytxVmHfMitAFOIm41VDRJyizKd9Yuso=;
        b=tDJEN3dIEADzSQ77jppJxxcuopUjRr4zSEJouaGlb00cLeY3B4Fzko9wcBMkdXnCH3
         bmhmmXWUPkQ036qattSPCL3lFo3wnEFWRZZatMBMpJ8B/cAxGre5FKBnVkI9Vq7q5QSK
         /LztkSOpSDTfX/SheEUGyRxVAGlrCPL1Agf/h37naGK3MU4E398J03sdaxZ55la/DOkn
         toadU0/H9GXh2kstkKw2gN0pa1bIDowk81OVTIHDWhvfBwVdX5pTdbHMssufpC81tpgF
         paeJ9KXCRZbHwNcy7X+RIr6jHlVuUCQ2aeEJgkLRSYRbIO0bM1AUF2Bt6ksg3LMTtp1R
         lODg==
X-Gm-Message-State: AOJu0YzxkqTtmZo8ZbbceqBrpM0+BAT3KU7rZqQikYbz1UwJ2WbedWfv
	pSs0Hx74CrtvepjJn8k2TtLITTGhmiem7VQfjvPdvCvr6YdoR0TWcZ90KzoJGLByD9rsMikOc12
	om3LCaWDApw==
X-Gm-Gg: AeBDies4MvJNyNgSuoXzCMJ/ZGAbBMxe8rKOJucY2XwEWwPnY+85F9RPRvUjzRP8ujd
	O7Z+0FwtJo9u/q3eA+fSC1RzXUUKWeIYrJhDaH/mBJoA2Ec3e8eUT7DDqDUfxBQXckPggyQnOGO
	NQ1/dXUyFlimy74xFttZydVl4uHMFFUsUjnB+AXNfwha4ftAYBdKRWmPc3oGO+Nu3gxX6VJ5MEd
	b8n/bvX5Lb1IKMGs7n88OJzTiC+e2Tmh2l+LPKEnssgHdIq+Ul3dHVJUm7u8eSOepIezHJ7AsrJ
	odtuSfZl7jqWV3vUoa032ppZklsF9vJUGiCd/OnvBUMhVTqt4OwXfRMOHHWhZWR2B5os6VoOMC7
	9NkUFraxy4k4WTvF1K3P1BV9ZJUb654paYYsKJWIZGlaXDMK6xCLV7oqSVICjwE0xYifisjAD2v
	eF/qnr8L4JlY/J
X-Received: by 2002:a17:90b:4ac7:b0:35d:a2aa:3b05 with SMTP id 98e67ed59e1d1-35de678f96fmr1482987a91.5.1775190450826;
        Thu, 02 Apr 2026 21:27:30 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:30 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <etsal@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Add selftests for libarena buddy allocator
Date: Fri,  3 Apr 2026 00:27:20 -0400
Message-ID: <20260403042720.18862-10-emil@etsalapatis.com>
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

From: Emil Tsalapatis <etsal@meta.com>

Introduce selftests for the buddy allocator with and without
ASAN. Add the libarena selftests both to the libarena test
runner and to test_progs, so that they are a) available when
libarena is pulled as a standalone library, and b) exercised
along with all other test programs in this directory.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |  12 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 251 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 229 ++++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       |  79 ++++++
 4 files changed, 571 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 8b82fcdc3b7f..25af3aae868f 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -137,6 +137,12 @@ error_no_destroy:					\
 	return ret;					\
 }
 
+TEST(test_buddy);
+
+#ifdef BPF_ARENA_ASAN
+TEST(asan_test_buddy);
+#endif
+
 static void
 banner(const char *progpath)
 {
@@ -174,5 +180,11 @@ int main(int argc, char *argv[])
 
 	libbpf_set_print(libbpf_print_fn);
 
+	run_test_buddy();
+
+#ifdef BPF_ARENA_ASAN
+	run_asan_test_buddy();
+#endif
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
new file mode 100644
index 000000000000..8d81b06b5362
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
+
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+private(ST_BUDDY) struct buddy st_buddy_asan;
+
+u64 __arena st_asan_buddy_lock;
+
+static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int i;
+
+	ASAN_VALIDATE();
+
+	mem = buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		mem[i] = 0xba;
+		ASAN_VALIDATE_ADDR(false, &mem[i]);
+	}
+
+	mem[alloc_size] = 0xba;
+	ASAN_VALIDATE_ADDR(true, &mem[alloc_size]);
+
+	buddy_free(&st_buddy_asan, mem);
+
+	return 0;
+}
+
+/*
+ * Factored out because ASAN_VALIDATE_ADDR is complex enough to cause
+ * verification failures if verified with the rest of asan_test_buddy_uaf_single.
+ */
+__weak int asan_test_buddy_byte(u8 __arena __arg_arena *mem, int i, bool freed)
+{
+	/* The header in freed blocks doesn't get poisoned. */
+	if (freed && BUDDY_HEADER_OFF <= i &&
+		i < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
+		return 0;
+
+	mem[i] = 0xba;
+	ASAN_VALIDATE_ADDR(freed, &mem[i]);
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
+	mem = buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		ret = asan_test_buddy_byte(mem, i, false);
+		if (ret)
+			return ret;
+	}
+
+	ASAN_VALIDATE();
+
+	buddy_free(&st_buddy_asan, mem);
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
+
+	blob = buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!blob)
+		return -ENOMEM;
+
+	blob->mem[0] = 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[0]);
+
+	blob->mem[47] = 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[47]);
+
+	blob->oob = 0;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	buddy_free(&st_buddy_asan, (void __arena *)blob);
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_oob(void)
+{
+	size_t sizes[] = {
+		7, 8, 17, 18, 64, 256, 317, 512, 1024,
+	};
+	int ret, i;
+
+	ret = buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
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
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+__weak int asan_test_buddy_uaf(void)
+{
+	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 128, 1024, 16384 };
+	int ret, i;
+
+	ret = buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
+	if (ret) {
+		arena_stdout("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = zero; i < 7 && can_loop; i++) {
+		ret = asan_test_buddy_uaf_single(sizes[i]);
+		if (ret) {
+			arena_stdout("%s:%d Failed for size %lu", __func__,
+				   __LINE__, sizes[i]);
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_blob(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	ret = buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
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
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+SEC("syscall")
+int asan_test_buddy(void)
+{
+	int ret;
+
+	ret = asan_test_buddy_oob();
+	if (ret) {
+		arena_stdout("%s:%d OOB test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_buddy_uaf();
+	if (ret) {
+		arena_stdout("%s:%d UAF test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_buddy_blob();
+	if (ret) {
+		arena_stdout("%s:%d blob test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	return 0;
+}
+
+#else
+
+SEC("syscall")
+int asan_test_buddy(void)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
new file mode 100644
index 000000000000..19d036ae83c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
+
+
+private(ST_BUDDY) struct buddy st_buddy;
+static u64 __arena st_buddy_lock;
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
+static int test_buddy_create(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		ret = buddy_init(
+			&st_buddy, (arena_spinlock_t __arena *)&st_buddy_lock);
+		if (ret)
+			return ret;
+
+		ret = buddy_destroy(&st_buddy);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int test_buddy_alloc(void)
+{
+	void __arena *mem;
+	int ret, i;
+
+	for (i = zero; i < 8 && can_loop; i++) {
+		ret = buddy_init(
+			&st_buddy, (arena_spinlock_t __arena *)&st_buddy_lock);
+		if (ret)
+			return ret;
+
+		mem = buddy_alloc(&st_buddy, alloc_sizes[i]);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		buddy_destroy(&st_buddy);
+	}
+
+	return 0;
+}
+
+static int test_buddy_alloc_free(void)
+{
+	const int iters = 800;
+	void __arena *mem;
+	int ret, i;
+
+	ret = buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		mem = buddy_alloc(&st_buddy, alloc_free_sizes[(i * 5) % 8]);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		buddy_free(&st_buddy, mem);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+static int test_buddy_alloc_multiple(void)
+{
+	int ret, j;
+	u32 i, idx;
+	u8 __arena *mem;
+	size_t sz;
+	u8 poison;
+
+	ret = buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
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
+		mem = buddy_alloc(&st_buddy, sz);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
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
+				buddy_destroy(&st_buddy);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/*
+	 * For SEGARRLEN iterations, go to (i * 17) % SEGARRLEN, and free
+	 * the block pointed to. Before freeing, check all bytes have the
+	 * poisoned value corresponding to the element. If any values
+	 * are unexpected, return an error.
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
+				buddy_destroy(&st_buddy);
+				arena_stdout("%s:%d %lx %u vs %u", __func__,
+					   __LINE__, &mem[j], mem[j], poison);
+				return -EINVAL;
+			}
+		}
+
+		buddy_free(&st_buddy, mem);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+static int test_buddy_alignment(void)
+{
+	int ret, i;
+
+	ret = buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	/* Allocate various sizes and check alignment */
+	for (i = zero; i < 17 && can_loop; i++) {
+		ptrs[i] = buddy_alloc(&st_buddy, alignment_sizes[i]);
+		if (!ptrs[i]) {
+			arena_stdout("alignment test: alloc failed for size %lu",
+				   alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		/* Check 8-byte alignment */
+		if ((u64)ptrs[i] & 0x7) {
+			arena_stdout(
+				"alignment test: ptr %llx not 8-byte aligned (size %lu)",
+				(u64)ptrs[i], alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -EINVAL;
+		}
+	}
+
+	/* Free all allocations */
+	for (i = zero; i < 17 && can_loop; i++) {
+		buddy_free(&st_buddy, ptrs[i]);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+#define BUDDY_ALLOC_SELFTEST(suffix) ALLOC_SELFTEST(test_buddy_##suffix)
+
+SEC("syscall")
+__weak int test_buddy(void)
+{
+	BUDDY_ALLOC_SELFTEST(create);
+	BUDDY_ALLOC_SELFTEST(alloc);
+	BUDDY_ALLOC_SELFTEST(alloc_free);
+	BUDDY_ALLOC_SELFTEST(alloc_multiple);
+	BUDDY_ALLOC_SELFTEST(alignment);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
new file mode 100644
index 000000000000..4e56f388c43a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <unistd.h>
+
+#define __arena
+typedef uint64_t u64;
+typedef uint8_t u8;
+
+#include "libarena/include/common.h"
+#include "libarena/include/asan.h"
+#include "libarena/include/selftest_helpers.h"
+
+#include "libarena/libarena.skel.h"
+#include "libarena/libarena_asan.skel.h"
+
+static void test_libarena_buddy(void)
+{
+	struct libarena *skel;
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
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.test_buddy));
+	ASSERT_OK(ret, "test_buddy");
+
+out:
+	libarena__destroy(skel);
+}
+
+static void test_libarena_asan_buddy(void)
+{
+	struct libarena_asan *skel;
+	size_t arena_pages = (1UL << 32) / sysconf(_SC_PAGESIZE);
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
+		arena_pages);
+	if (!ASSERT_OK(ret, "asan_init"))
+		goto out;
+
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.asan_test_buddy));
+	ASSERT_OK(ret, "asan_test_buddy");
+
+out:
+	libarena_asan__destroy(skel);
+}
+
+void test_libarena(void)
+{
+	if (test__start_subtest("buddy"))
+		test_libarena_buddy();
+	if (test__start_subtest("asan_buddy"))
+		test_libarena_asan_buddy();
+}
-- 
2.53.0

