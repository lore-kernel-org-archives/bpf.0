Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3D19F12D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511264; cv=none; b=N8Jmfa75SM122gmKUoWEm4LFPRF0eDVNF7bEm6lUdMXVEtmp/Rd8WEd96QWAsTlFFpugl28nySxTRr25lgrJIJalUcnXsauzugW33BP4i/vM6mTFztWUjCHF8AtGcJ8QbyL3T807h9N/5h+5SHnV/jrGvXOr5iTdiAfOWzWnrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511264; c=relaxed/simple;
	bh=N5E7jZiJTCevN76mr/hP/+KvRZ/Gch3q3ITrRja/ZT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXBQHRwm6d/NsPFQKbQsm0pLcodndrX/WWG0H4WY8TBjUXIwxO/DJ/5yHToJQ7lG6Z5qm2+DYpApyoWg4nwEcuV5uiyiM2WSDdj/Rrz5+Hl7qM8jBK/ltV9yTSpd2bXVcZyU1H1MxKcRm4DC5JkAz36OeogqdNtyJdlNMRMqDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SOM7Ib0l; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SOM7Ib0l"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304df7ff4c2so704153eec.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780511261; x=1781116061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBz1DaXT5E1ZPxpsAOgdhjp7hLLrpZNc5QEBGrfAnBY=;
        b=SOM7Ib0lKdBCEkaHL0JJscnkv5fmOzUqDl1yJ0UInWLrBLYD/zJn0N2RbNJIejWT3D
         4/OskEkDUKWbLE5YU6VDzX7+LnwiNlr/LS+JlQuh09KQbc+mmAkxWLkMAX477nZEQ8Xy
         LO1WBXhSDinyQfy6P9sD30YHE+26G2gjek55NZRxZO+gALSYjF/fosouBwC6TTKoyyMC
         QTygsunoFr4BfvtTcGjeIzkNFM+2TDNUcbxkEx9R1oM82qf1niW0WH0rkDDJi0FsUdkS
         2ofB9XfJKdVYTO22E8ujURd3C2TWIPBPzohCVQhdbIEnvqwD4yq24QZZE4EMOUvAntHi
         yVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511261; x=1781116061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBz1DaXT5E1ZPxpsAOgdhjp7hLLrpZNc5QEBGrfAnBY=;
        b=GTV2vfBoACyjH43almX0J0yCGKxWhFJhFG292FJGLnFgNNA8TZctHMlijtQRslBtqf
         7TLabHM8AQgow2jZOI+vSMeH7QPqLCx7EyzYyQmIhTt3+q3WtzNHhpLYvHLbtumctBY1
         86kOsOhSYNGw2tOC39Ow1IATm0IVwGQwaz00fJuKau4RAaJwHSqXLH6oUQPxoZUMthls
         T8XaY8/4ffUzszm63Vyh6DkhVzhWUZxLY6dsJjTl0MeIJ94YCOwwwLIWdBM+Rk9yuDaH
         bJDR7cu7couEE3109u2sP9WndJopRuodetPGAizoziSVrT46ML7a+2MvYp9v56GsX21U
         x3OQ==
X-Gm-Message-State: AOJu0YxT4xX1N6eyV9PptS4ml/DPLpyimGUNMSMiMUSJBm1D5Bh6hc4R
	e3ZeSeyBourDHpcoX8geL0puBAVyGVKJKGTzVdEPH9mrZNHe88gwllzA4I3nJRq2HVKDTDwB+cG
	fFO6ugCZxEzUi
X-Gm-Gg: Acq92OH7gHAx8xe6Vjdx7Vmj/f1ekJOn6dMBr1BZTiuhUfRZ+rMA/Mpka5IDxteIPul
	1UaZ8MTjZkWuUqpJ1K46lSyWTjt1IjLceoQIdPqPbX3epNafLlcm6TejZu/U6Zo1PL1CnwLz4HJ
	ZO9k2oiSkLT5/SQC1MmbTeS+tGE/1e/LqffnwW1HLZDHFEAA0kAVkPcjoZfvncx8TQ530t/X9SF
	2704EohRut454BVY1YBMD2fzj5PVm8lwtn1XQdV33+3vIcEeMSjVGipnFrsB5gjuI5OQrumAAJM
	dQhmz5uMB9vpFJChX3px4xm57eYebMVv9WOSO+Hnr+ueKRN9sSPHbI026tt8UqpwHqV6qglmamv
	VrPsWwG3mH11681HYKK3g9ddfh1tE5uOlaxChQXH7XvY+pvgQzc5PCkvye7BByuJecYkuXO0ufh
	SL6xTRRP/j81aWgSvh3JrczzQyUiFFmw==
X-Received: by 2002:a05:7300:2301:b0:302:b44b:b64a with SMTP id 5a478bee46e88-30761ea7a05mr283531eec.1.1780511261342;
        Wed, 03 Jun 2026 11:27:41 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::ea8f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm4137860eec.5.2026.06.03.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:27:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: libarena: Add spmc queue data structure
Date: Wed,  3 Jun 2026 14:27:26 -0400
Message-ID: <20260603182727.3922-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603182727.3922-1-emil@etsalapatis.com>
References: <20260603182727.3922-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand libarena with a single producer multiple consumer deque data
structure. This is a single producer, multiple consumer lockless structure
that permits efficient work stealing. The structure is a Lev-Chase queue,
so it is lock-free and wait-free.

The data structure exposes three main calls. two of them are available to
the thread owning the queue and one available to all threads in the program:

spmc_owner_push(): Push an item to the top of the queue.
spmc_owner_pop(): Pop an item from the top of the queue.
spmc_steal(): Steal a thread from the bottom of the queue from
any thread.

Note that the queue is not really FIFO for all consumers, since
non-owners of the queue can only work steal from the bottom.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/spmc.h      |  27 ++
 .../bpf/libarena/selftests/test_spmc.bpf.c    | 194 +++++++++++++++
 .../selftests/bpf/libarena/src/spmc.bpf.c     | 232 ++++++++++++++++++
 3 files changed, 453 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/spmc.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/spmc.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/spmc.h b/tools/testing/selftests/bpf/libarena/include/libarena/spmc.h
new file mode 100644
index 000000000000..75611276ce13
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/spmc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause */
+
+#pragma once
+
+struct spmc_arr;
+
+#define SPMC_ARR_BASESZ 128
+#define SPMC_ARR_ORDERS 10
+
+struct spmc_arr {
+	u64 __arena *data;
+	u64 order;
+};
+
+struct spmc {
+	volatile struct spmc_arr __arena *cur;
+	volatile u64 top;
+	volatile u64 bottom;
+	struct spmc_arr arr[SPMC_ARR_ORDERS];
+};
+
+int spmc_owned_add(struct spmc __arena *spmc, u64 val);
+int spmc_owned_remove(struct spmc __arena *spmc, u64 *val);
+int spmc_steal(struct spmc __arena *spmc, u64 *val);
+
+struct spmc __arena *spmc_create(void);
+int spmc_destroy(struct spmc __arena *spmc);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
new file mode 100644
index 000000000000..e458dd330906
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/spmc.h>
+
+/*
+ * NOTE: These selftests only test for the single-threaded use case, which for
+ * Lev-Chase queues is obviously the simplest one. Still, it is important to
+ * exercise the API to ensure it passes verification and basic checks.
+ */
+
+SEC("syscall")
+int test_spmc_remove_empty(void)
+{
+	u64 val;
+	int ret;
+
+	struct spmc __arena *spmc = spmc_create();
+
+	if (!spmc)
+		return 1;
+
+	ret = spmc_owned_remove(spmc, &val);
+	if (ret != -ENOENT)
+		return 1;
+
+	spmc_destroy(spmc);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_spmc_steal_empty(void)
+{
+	u64 val;
+	int ret;
+
+	struct spmc __arena *spmc = spmc_create();
+
+	if (!spmc)
+		return 1;
+
+	ret = spmc_steal(spmc, &val);
+	if (ret != -ENOENT)
+		return 1;
+
+	spmc_destroy(spmc);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_spmc_steal_one(void)
+{
+	u64 val, newval;
+	int ret, i;
+
+	struct spmc __arena *spmc = spmc_create();
+
+	if (!spmc)
+		return 1;
+
+	for (i = 0; i < 10 && can_loop; i++) {
+		val = i;
+
+		ret = spmc_owned_add(spmc, val);
+		if (ret)
+			return 1;
+
+		ret = spmc_steal(spmc, &newval);
+		if (ret)
+			return 2;
+
+		if (val != newval)
+			return 3;
+	}
+
+	spmc_destroy(spmc);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_spmc_remove_one(void)
+{
+	u64 val, newval;
+	int ret, i;
+
+	struct spmc __arena *spmc = spmc_create();
+
+	if (!spmc)
+		return 1;
+
+	for (i = 0; i < 10 && can_loop; i++) {
+		val = i;
+
+		ret = spmc_owned_add(spmc, val);
+		if (ret)
+			return 1;
+
+		ret = spmc_owned_remove(spmc, &newval);
+		if (ret)
+			return 2;
+
+		if (val != newval)
+			return 3;
+	}
+
+	spmc_destroy(spmc);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_spmc_remove_many(void)
+{
+	u64 val, newval;
+	int ret, i;
+	u64 expected;
+
+	struct spmc __arena *spmc = spmc_create();
+
+	if (!spmc)
+		return 1;
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		val = i;
+
+		ret = spmc_owned_add(spmc, val);
+		if (ret) {
+			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		ret = spmc_owned_remove(spmc, &newval);
+		if (ret) {
+			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
+			return 1;
+		}
+
+		expected = 500 - 1 - i;
+		if (newval != expected) {
+			arena_stderr("%s:%d expected %lu found %lu\n", __func__, __LINE__, expected, newval);
+			return 1;
+		}
+	}
+
+	spmc_destroy(spmc);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_spmc_steal_many(void)
+{
+	u64 val, newval;
+	int ret, i;
+
+	struct spmc __arena *spmc = spmc_create();
+
+	if (!spmc)
+		return 1;
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		val = i;
+
+		ret = spmc_owned_add(spmc, val);
+		if (ret) {
+			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		ret = spmc_steal(spmc, &newval);
+		if (ret) {
+			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
+			return 1;
+		}
+
+		if (newval != i) {
+			arena_stderr("%s:%d expected %lu found %lu\n", __func__, __LINE__, i, newval);
+			return 1;
+		}
+	}
+
+	spmc_destroy(spmc);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/libarena/src/spmc.bpf.c b/tools/testing/selftests/bpf/libarena/src/spmc.bpf.c
new file mode 100644
index 000000000000..93773c371d03
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/spmc.bpf.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/*
+ * Copyright (c) 2025-2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025-2026 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <bpf_atomic.h>
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/spmc.h>
+
+static inline
+u64 spmc_arr_size(volatile struct spmc_arr __arena *spmc_arr)
+{
+	return SPMC_ARR_BASESZ << READ_ONCE(spmc_arr->order);
+}
+
+static inline
+u64 spmc_arr_get(volatile struct spmc_arr __arena *spmc_arr, u64 ind)
+{
+	u64 ret = READ_ONCE(spmc_arr->data[ind % spmc_arr_size(spmc_arr)]);
+
+	return ret;
+}
+
+static inline
+void spmc_arr_put(volatile struct spmc_arr __arena *spmc_arr, u64 ind, u64 value)
+{
+	WRITE_ONCE(spmc_arr->data[ind % spmc_arr_size(spmc_arr)], value);
+}
+
+static inline
+void spmc_arr_copy(volatile struct spmc_arr __arena *dst,
+		   volatile struct spmc_arr __arena *src, u64 b, u64 t)
+{
+	u64 i;
+
+	for (i = t; i < b && can_loop; i++)
+		spmc_arr_put(dst, i, spmc_arr_get(src, i));
+}
+
+static inline
+int spmc_order_init(struct spmc __arena *spmc, int order)
+{
+	volatile struct spmc_arr __arena *arr = &spmc->arr[order];
+
+	if (unlikely(!spmc))
+		return -EINVAL;
+
+	if (order >= SPMC_ARR_ORDERS)
+		return -E2BIG;
+
+	/* Already allocated? */
+	if (arr->data)
+		return 0;
+
+	arr->data = arena_malloc((SPMC_ARR_BASESZ << order) * sizeof(*arr->data));
+	if (!arr->data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+__weak
+int spmc_owned_add(struct spmc __arena *spmc, u64 val)
+{
+	volatile struct spmc_arr __arena *newarr;
+	volatile struct spmc_arr __arena *arr;
+	ssize_t sz;
+	u64 b, t;
+	int ret;
+
+	if (unlikely(!spmc))
+		return -EINVAL;
+
+	/* 
+	 * Bottom must always be read first, also
+	 * see spmc_steal().
+	 */
+	b = smp_load_acquire(&spmc->bottom);
+	t = smp_load_acquire(&spmc->top);
+	arr = READ_ONCE(spmc->cur);
+
+	sz = b - t;
+	if (sz >= spmc_arr_size(arr) - 1) {
+		ret = spmc_order_init(spmc, arr->order + 1);
+		if (ret)
+			return ret;
+
+		newarr = &spmc->arr[arr->order + 1];
+
+		spmc_arr_copy(newarr, arr, b, t);
+		smp_store_release(&spmc->cur, newarr);
+	}
+
+	spmc_arr_put(spmc->cur, b, val);
+	smp_store_release(&spmc->bottom, b + 1);
+
+	return 0;
+}
+
+
+__weak
+int spmc_owned_remove(struct spmc __arena *spmc, u64 *val)
+{
+	volatile struct spmc_arr __arena *arr;
+	int ret = 0;
+	ssize_t sz;
+	u64 value;
+	u64 b, t;
+
+	if (unlikely(!spmc || !val))
+		return -EINVAL;
+
+	b = smp_load_acquire(&spmc->bottom) - 1;
+	t = smp_load_acquire(&spmc->top);
+	arr = READ_ONCE(spmc->cur);
+
+	smp_store_release(&spmc->bottom, b);
+
+	sz = b - t;
+	if (sz < 0) {
+		smp_store_release(&spmc->bottom, t);
+		return -ENOENT;
+	}
+
+	value = spmc_arr_get(arr, b);
+	if (sz > 0) {
+		*val = value;
+		return 0;
+	}
+
+	if (cmpxchg(&spmc->top, t, t + 1) != t)
+		ret = -EAGAIN;
+
+	smp_store_release(&spmc->bottom, t + 1);
+
+	if (ret)
+		return ret;
+
+	*val = value;
+
+	return 0;
+}
+
+__weak
+int spmc_steal(struct spmc __arena *spmc, u64 *val)
+{
+	volatile struct spmc_arr __arena *arr;
+	ssize_t sz;
+	u64 value;
+	u64 b, t;
+
+	if (unlikely(!spmc || !val))
+		return -EINVAL;
+
+	/*
+	 * It is important that t is read before b for
+	 * stealers to avoid racing with the owner.
+	 * Races between stealers are dealt with using
+	 * CAS to increment the top value below.
+	 */
+	t = smp_load_acquire(&spmc->top);
+	b = smp_load_acquire(&spmc->bottom);
+	arr = READ_ONCE(spmc->cur);
+
+	sz = b - t;
+	if (sz <= 0)
+		return -ENOENT;
+
+	value = spmc_arr_get(arr, t);
+
+	if (cmpxchg(&spmc->top, t, t + 1) != t)
+		return -EAGAIN;
+
+	*val = value;
+
+	return 0;
+}
+
+
+__weak
+struct spmc __arena *spmc_create(void)
+{
+	/*
+	 * Marked as volatile because otherwise the array
+	 * reference in the internal loop gets demoted to
+	 * scalar and the program fails verification.
+	 */
+	struct spmc __arena *volatile spmc;
+	int ret, i;
+
+	spmc = arena_malloc(sizeof(*spmc));
+	if (!spmc)
+		return NULL;
+
+	spmc->bottom = 0;
+	spmc->top = 0;
+
+	for (i = 0; i < SPMC_ARR_ORDERS && can_loop; i++) {
+		spmc->arr[i].data = NULL;
+		spmc->arr[i].order = i;
+	}
+
+	ret = spmc_order_init((struct spmc __arena *)spmc, 0);
+	if (ret) {
+		arena_free(spmc);
+		return NULL;
+	}
+
+	smp_store_release(&spmc->cur, &spmc->arr[0]);
+
+	return (struct spmc __arena *)spmc;
+}
+
+__weak
+int spmc_destroy(struct spmc __arena *spmc)
+{
+	int i;
+
+	if (unlikely(!spmc))
+		return -EINVAL;
+
+	for (i = 0; i < SPMC_ARR_ORDERS && can_loop; i++)
+		arena_free(spmc->arr[i].data);
+
+	arena_free(spmc);
+
+	return 0;
+}
-- 
2.54.0

