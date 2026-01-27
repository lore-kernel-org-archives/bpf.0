Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE3326D62
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537798; cv=none; b=uaX9y7Sig+CjhhKQ/8mATk8jWwo2KCQ3cH/Uw8LJLvdupRAXn5y9gcE3Ep8a7x97PNdMphK6LBHcD2cMPLTc18Bcy43PY6HNtF/IGfkKcgZ+I++xhe20t4bJa4j9QaxnHNy5o0MP6dKcJ4LjDQyiGQBiJqTgWMWDkm+++6oBTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537798; c=relaxed/simple;
	bh=VWeh4vlumF++6ONb77bWv81FTfS7J6oQ96YTx8izrU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRAli9pP13y3iicrt9PYGNSI7We7bkaLC+zFgMFrLlH/Ej1KeXHadn24+5VvnyJgzXH5A7LjcaTIeIrwC8i3muxVSpwAl5T0YjZuQxsi8pn5nnfVlkF/MtwvM0vf/xtiXqmDNeAgUbl+pNjimIjOL2v2Y5bgicSv6ZCNTcD/kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=LykkmEBm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="LykkmEBm"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50336cffef9so1119891cf.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537796; x=1770142596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FStNvZ89uWamYl9YJOKs07jNcrbsFJQuC7eAQC5G3I=;
        b=LykkmEBmlIHuqR0f3lps0fBSC8iWTH4vbnNUB+ZFBUF/sTifCklJGs2S8lXYAop3j8
         cCinF2l44AxDiG8Jn5MK43g2P7V7XMgjhEg3qJdX+1M2BQ/AVRdODZ9fwglSHMDPhvgB
         b4ShIc9f3ROtqYX4SBPtBZWw2DI/YPKGOD3ShnwhhRRhz8KIfbJi5IOvW5AWzxOZu9Yx
         Xucspqwf0/oNPboGNAtDHVH6ZUXeASW4dTATmBOgtu4IRACZsjcs/DFGb8MtySettlUk
         QJ6A9pt7sZKU36eq2KZ1ZdniKFaLNkIlCoISA3fU1pzorDGZDesTPOHKRuOdY2rlBDMv
         rNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537796; x=1770142596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FStNvZ89uWamYl9YJOKs07jNcrbsFJQuC7eAQC5G3I=;
        b=RuOj7Bt50TGR09lJB7NHIc4q5B9NrG2Xxci5IUmxRGwCl1YBT6zkvJNXNcfvOIGtFD
         ngqRdsz0oc0myL++yupuAY3QSifsKfa9Wkta2F2npC7lhnnLifUWjEfarbt4RJACyXzz
         Oy8mP83HXrd1xaj3xlFOJm7l69ZalpUG5QyozK+kEDs+LLmdXrtJpfCEZMK4JZd3YqrB
         RYVFd7BMAxHIReWXPyxN+tcn6s/ENJ4vhN2GDF7RcOJEnAoXWFfwbdeeornj15FYt+Hy
         f1p/4QmTYsXH8Ns6IkrX3pnNr8MlFkzXiEEl4hZDKGDS+c15dweSfHStZlwPHmJ9L4Jp
         m5vg==
X-Gm-Message-State: AOJu0Yx+yL/Pyfo+4OSSTMj56PB+XXICuR1LfTah9YIHB6i7FFyB/WFQ
	sW7+nsFLfabU86oS7EETOdXF/uATV+ZZc+5RdpLcDfGnbffPeJHkEWCkFSuFlfrQmmmPzGaxnND
	a3Cbb
X-Gm-Gg: AZuq6aKioKCQ9biHi6ICWyBd2EV8e7Fktsty42JGzE8TbPDr2sudPBH+pWsELcwj/Tr
	XZS10wULUCtBuAcTuidwtHfgaPBCMFKPYQuU7WbvkoDN7s1UeOnzikshrEEj6csONS8xfjik/rr
	ePpDtsxcdtng7frg4z/0hfJqtifxp75wvUi/ZiUi+qOlS1FBXUYA6xSDDzSKx+coG8caPyIJk7X
	+LzeziX+JdNe/NQd+aPtZ3P5g0/6bvtsnFhSwFp660UhqMePUB6fRd3wNnUBjV4nH5KbA7ukrqo
	aFCfwQ95tNC9RcROfhtb0aySNVker+wRQPzzqmVuqiWxUV3c19Jah9FoOObce6XCKMS52dxiPBn
	0IWJdrTOmx9ZPzTH6tK0NmdisCKM5dZP0PgkbMy26C5povSG5pricigl92lvkvtZcOYST7SV1C5
	7qmyY2Q4w7U8jHiWrEgkXM
X-Received: by 2002:a05:622a:343:b0:4f4:c104:8e9f with SMTP id d75a77b69052e-5032fc28cdbmr30991131cf.75.1769537795659;
        Tue, 27 Jan 2026 10:16:35 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:35 -0800 (PST)
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
Subject: [PATCH v2 13/13] selftests: bpf: Add selftests for the libarena buddy allocator
Date: Tue, 27 Jan 2026 13:16:09 -0500
Message-ID: <20260127181610.86376-14-emil@etsalapatis.com>
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

Add regular and ASAN testing for the buddy allocator. This tests
the allocator's correctness by itself and its integration with ASAN.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |   4 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 238 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 231 +++++++++++++++++
 3 files changed, 473 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 3e4b8754889f..268749c687a1 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -266,10 +266,12 @@ error:							\
 }
 
 TEST(bump_selftest);
+TEST(buddy_selftest);
 
 #ifdef BPF_ARENA_ASAN
 TEST(asan_test_bump);
 TEST(asan_test_stack);
+TEST(asan_test_buddy);
 #endif
 
 static void
@@ -314,10 +316,12 @@ int main(int argc, char *argv[])
 	libbpf_set_print(libbpf_print_fn);
 
 	run_bump_selftest();
+	run_buddy_selftest();
 
 #ifdef BPF_ARENA_ASAN
 	run_asan_test_bump();
 	run_asan_test_stack();
+	run_asan_test_buddy();
 #endif
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
new file mode 100644
index 000000000000..e3887a7c5d93
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,238 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
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
+		bpf_printk("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	bpf_for(i, 0, alloc_size) {
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
+static __always_inline int asan_test_buddy_uaf_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int i;
+
+	mem = buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!mem) {
+		bpf_printk("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	bpf_for(i, 0, alloc_size) {
+		mem[i] = 0xba;
+		ASAN_VALIDATE_ADDR(false, &mem[i]);
+	}
+
+	ASAN_VALIDATE();
+
+	buddy_free(&st_buddy_asan, mem);
+
+	bpf_for(i, 0, alloc_size) {
+		/* The header doesn't get poisoned. */
+		if (BUDDY_HEADER_OFF <= i &&
+		    i < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
+			continue;
+
+		mem[i] = 0xba;
+		ASAN_VALIDATE_ADDR(true, &mem[i]);
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
+		bpf_printk("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	bpf_for(i, 0, 7) {
+		ret = asan_test_buddy_oob_single(sizes[i]);
+		if (ret) {
+			bpf_printk("%s:%d Failed for size %lu", __func__,
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
+static __always_inline int asan_test_buddy_uaf(void)
+{
+	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 128, 1024, 16384 };
+	int ret, i;
+
+	ret = buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
+	if (ret) {
+		bpf_printk("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	bpf_for(i, 0, 7) {
+		ret = asan_test_buddy_uaf_single(sizes[i]);
+		if (ret) {
+			bpf_printk("%s:%d Failed for size %lu", __func__,
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
+		bpf_printk("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = 0; i < iters && can_loop; i++) {
+		ret = asan_test_buddy_blob_single();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
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
+		bpf_printk("%s:%d OOB test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_buddy_uaf();
+	if (ret) {
+		bpf_printk("%s:%d UAF test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_buddy_blob();
+	if (ret) {
+		bpf_printk("%s:%d blob test failed", __func__, __LINE__);
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
index 000000000000..256d9a865647
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,231 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
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
+static int buddy_selftest_create()
+{
+	const int iters = 10;
+	int ret, i;
+
+	for (i = 0; i < iters && can_loop; i++) {
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
+static int buddy_selftest_alloc()
+{
+	void __arena *mem;
+	int ret, i;
+
+	for (i = 0; i < 8 && can_loop; i++) {
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
+static int buddy_selftest_alloc_free()
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
+	bpf_for(i, 0, iters) {
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
+static int buddy_selftest_alloc_multiple()
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
+	bpf_for(i, 0, SEGARRLEN) {
+		sz = alloc_multiple_sizes[idx % 9];
+		poison = (u8)i;
+
+		mem = buddy_alloc(&st_buddy, sz);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			bpf_printk("%s:%d", __func__, __LINE__);
+			return -ENOMEM;
+		}
+
+		segarr[i].block = mem;
+		segarr[i].sz = sz;
+		segarr[i].poison = poison;
+
+		bpf_for(j, 0, sz) {
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
+	bpf_for(i, 10, SEGARRLEN) {
+		idx = (i * 17) % SEGARRLEN;
+
+		mem = segarr[idx].block;
+		sz = segarr[idx].sz;
+		poison = segarr[idx].poison;
+
+		bpf_for(j, 0, sz) {
+			if (mem[j] != poison) {
+				buddy_destroy(&st_buddy);
+				bpf_printk("%s:%d %lx %u vs %u", __func__,
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
+static int buddy_selftest_alignment()
+{
+	int ret, i;
+
+	ret = buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	/* Allocate various sizes and check alignment */
+	bpf_for(i, 0, 17) {
+		ptrs[i] = buddy_alloc(&st_buddy, alignment_sizes[i]);
+		if (!ptrs[i]) {
+			bpf_printk("alignment test: alloc failed for size %lu",
+				   alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		/* Check 8-byte alignment */
+		if ((u64)ptrs[i] & 0x7) {
+			bpf_printk(
+				"alignment test: ptr %llx not 8-byte aligned (size %lu)",
+				(u64)ptrs[i], alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -EINVAL;
+		}
+	}
+
+	/* Free all allocations */
+	bpf_for(i, 0, 17) {
+		buddy_free(&st_buddy, ptrs[i]);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+#define BUDDY_ALLOC_SELFTEST(suffix) ALLOC_SELFTEST(buddy_selftest_##suffix)
+
+SEC("syscall")
+__weak int buddy_selftest(void)
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
-- 
2.49.0

