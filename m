Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727034D90D3
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535675; cv=none; b=qZVZxhp20ce0YbKDSJUZwcLKgoXnIqa6+pk/DbsWfvLVtQMCNPPVdFL8qIRnWmQm4bbn79OapAru0SlfhKYQ46xOOac1M3QkwArizOg2YNj6X30O/S6wscDPGvHNtA85BMk2w719plOAsU069kcEFV7xrlqR+2KHc73qtn+cOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535675; c=relaxed/simple;
	bh=7NeISZzt4oQa/2US5xwYYFU2PzMRIbNNjkcyx5Z1C8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzK0HQNcO7wlu/1SaQXNNdMRqGIzE5208V3O+xVSXcFBGlPb/s9iXXavFFKEcDrfHvBFgpDaBmJzve4nPaWvtpAszervU2F08ql9q8tN6rKiywLFnQQ4GiDjANrYo1lKzMiUXl6pF1fSMLUxohWhsvYuNV3o3I7oGJ0KQygCGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=lUZt6v16; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="lUZt6v16"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so11784940eec.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778535668; x=1779140468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJUDpNAJF6rDSeL7fcX6+x7cWsNvUlGl92a2dW3I9ro=;
        b=lUZt6v16dHJtn8rqRO9goBupCI4ih6VNsWQfiELHYflCq1q8hmSBImLQ+JHn5hH6L/
         MReddpxOgzBuDwGHWb4kQUr0g8sT6BIoukp2qKs52XEoXDTXTqUXCclByAl3w3XnHJyC
         TZyp391pdtdCkOOyV+uF1os99Srf1mfdoN34h8UlGcInjkc7hX6IB/pId5Mxg6mW7nlO
         VRjV9q20slwQ5W+bqEaIqHkqGHPvrq/DpURhGHEs0QTs6PLjBGxYPy6SnF0gCdDS65sg
         uaz4D6pJXrrqopxXNQsfoqie9/PoPVFYhQAZ9rDONfTD3izjytU6f5LUxqs44P/rZG0C
         LGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535668; x=1779140468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJUDpNAJF6rDSeL7fcX6+x7cWsNvUlGl92a2dW3I9ro=;
        b=UbFTkdUJ2Oz8v7JP+3KYAx3e4K0hXAISuMVbtbcT+mMJr9WlTE9fyvkGjeiLOaovoi
         ABz0UFRraD1mac+H5XBexdcCSlTeAfdroUS5BKByAldvgBpdj/oT78SrXs9nnrPSPZSo
         tvdIQVCmwGQsDj0E270q3Ft8RMlmUtrZoPfGi09tOhGOpWV/0h32zgzena8QYmCYKnSN
         i41c8za3Z+luS2Hz6oFqBkuVwybIyQq1B+7GAj2fPWZz1CBIygLA8HISEg/jrilP8QIa
         Sq7ABRlshT/L0+H6En4phUZD7wiRFOSMgkoeRF1khQx3Bj4FgvXdd8B4Z5eFVC7e16RU
         WH2Q==
X-Gm-Message-State: AOJu0YyWr9SB3UQljinrrCXs4rRoPye8qVSAcqYg6uz0u3vFEE/Ds2K1
	viYJHThOut74pIwmn7+kpNkpLYFAIrXTDOrXHZ9qGCf+LGj+2jIEzY5G/z3/ws7SamrnBiZOHUQ
	MT4IEUAqMlcjY
X-Gm-Gg: Acq92OGfpr83tl1ZeukBxn4MAuqXZrrVDQZU+FUgVvfFjQ4MiPoxT8cJ6nU6pSUO0Qt
	nTjOLgs+dy3A4By5slT/ZPaJ2aojCwdI7NXzFD7OAZzOwNHmNCgRUID5/xpKLr5pv7GLncfd1ne
	0yiE4xrJHMG+O8GT4gMNSWSJjERl8g2EiNbXDALHQOZzavnS7JavvIuBgQ2EANB+PVyVsUw67mw
	2yy47T5sjfUCE2NI+DGln1cv3A03C6Rt7wxx7EiTjg89QNCH/Ndy0SCj3dYMQXoU477ZCXsngM9
	liWhiumcVUwxrxvy2AOqKL/A9xbq3AkwXs0wk1hR0DNkf0hyE7AluNJJl+cWW9UQClUMmhreG8T
	OZC5P7bPHMQam8hgvMTx+LQho1TzE/EqwMKgnoVgiBEhRZTl4hqr+kOqBy24MwGOOptZsdJNluw
	nDQWFYKmR1uSsxeaQ8aA8=
X-Received: by 2002:a05:7300:dc88:b0:2c5:b23e:48a9 with SMTP id 5a478bee46e88-2ffd78e2352mr184052eec.25.1778535668406;
        Mon, 11 May 2026 14:41:08 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4b34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f885edb83fsm15052473eec.7.2026.05.11.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:41:08 -0700 (PDT)
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
Subject: [RESEND PATCH bpf-next 2/2] selftests/bpf: libarena: Add Lev-Chase queue data structure
Date: Mon, 11 May 2026 17:41:00 -0400
Message-ID: <20260511214100.9487-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511214100.9487-1-emil@etsalapatis.com>
References: <20260511214100.9487-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand libarena with a Lev-Chase deque data structure. This is a single
producer, multiple consumer lockless queue that permits efficient
work stealing. The structure is lock-free and wait-free to minimize
overhead.

The data structure exposes three main calls. two of them are available to
the thread owning the queue and one available to all threads in the program:

lvqueue_owner_push(): Push an item to the top of the lvqueue.
lvqueue_owner_pop(): Pop an item from the top of the lvqueue.
lvqueue_steal(): Steal a thread from the bottom of the lvqueue from
any thread.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/lvqueue.h   |  33 +++
 .../bpf/libarena/selftests/st_lvqueue.bpf.c   | 194 ++++++++++++++
 .../selftests/bpf/libarena/src/lvqueue.bpf.c  | 241 ++++++++++++++++++
 3 files changed, 468 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h b/tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h
new file mode 100644
index 000000000000..c4091387c7a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause */
+
+#pragma once
+
+struct lv_arr;
+
+#define LV_ARR_BASESZ 128
+#define LV_ARR_ORDERS 10
+
+struct lv_arr {
+	u64 __arena *data;
+	u64 order;
+};
+
+typedef volatile struct lv_arr __arena lv_arr_t;
+
+struct lv_queue {
+	lv_arr_t *cur;
+	volatile u64 top;
+	volatile u64 bottom;
+	struct lv_arr arr[LV_ARR_ORDERS];
+};
+
+typedef struct lv_queue __arena lv_queue_t;
+
+int lvq_owner_push(lv_queue_t *lvq, u64 val);
+int lvq_owner_pop(lv_queue_t *lvq, u64 *val);
+int lvq_steal(lv_queue_t *lvq, u64 *val);
+
+u64 lvq_create_internal(void);
+#define lvq_create() ((lv_queue_t *)lvq_create_internal())
+
+int lvq_destroy(lv_queue_t *lvq);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bpf.c
new file mode 100644
index 000000000000..d53416d22f0a
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_lvqueue.bpf.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/lvqueue.h>
+
+/*
+ * NOTE: These selftests only test for the single-threaded use case, which for
+ * Lev-Chase queues is obviously the simplest one. Still, it is important to
+ * exercise the API to ensure it passes verification and basic checks.
+ */
+
+SEC("syscall")
+int test_lvqueue_pop_empty(void)
+{
+	u64 val;
+	int ret;
+
+	lv_queue_t *lvq = lvq_create();
+
+	if (!lvq)
+		return 1;
+
+	ret = lvq_owner_pop(lvq, &val);
+	if (ret != -ENOENT)
+		return 1;
+
+	lvq_destroy(lvq);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_lvqueue_steal_empty(void)
+{
+	u64 val;
+	int ret;
+
+	lv_queue_t *lvq = lvq_create();
+
+	if (!lvq)
+		return 1;
+
+	ret = lvq_steal(lvq, &val);
+	if (ret != -ENOENT)
+		return 1;
+
+	lvq_destroy(lvq);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_lvqueue_steal_one(void)
+{
+	u64 val, newval;
+	int ret, i;
+
+	lv_queue_t *lvq = lvq_create();
+
+	if (!lvq)
+		return 1;
+
+	for (i = 0; i < 10 && can_loop; i++) {
+		val = i;
+
+		ret = lvq_owner_push(lvq, val);
+		if (ret)
+			return 1;
+
+		ret = lvq_steal(lvq, &newval);
+		if (ret)
+			return 2;
+
+		if (val != newval)
+			return 3;
+	}
+
+	lvq_destroy(lvq);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_lvqueue_pop_one(void)
+{
+	u64 val, newval;
+	int ret, i;
+
+	lv_queue_t *lvq = lvq_create();
+
+	if (!lvq)
+		return 1;
+
+	for (i = 0; i < 10 && can_loop; i++) {
+		val = i;
+
+		ret = lvq_owner_push(lvq, val);
+		if (ret)
+			return 1;
+
+		ret = lvq_owner_pop(lvq, &newval);
+		if (ret)
+			return 2;
+
+		if (val != newval)
+			return 3;
+	}
+
+	lvq_destroy(lvq);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_lvqueue_pop_many(void)
+{
+	u64 val, newval;
+	int ret, i;
+	u64 expected;
+
+	lv_queue_t *lvq = lvq_create();
+
+	if (!lvq)
+		return 1;
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		val = i;
+
+		ret = lvq_owner_push(lvq, val);
+		if (ret) {
+			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		ret = lvq_owner_pop(lvq, &newval);
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
+	lvq_destroy(lvq);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_lvqueue_steal_many(void)
+{
+	u64 val, newval;
+	int ret, i;
+
+	lv_queue_t *lvq = lvq_create();
+
+	if (!lvq)
+		return 1;
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		val = i;
+
+		ret = lvq_owner_push(lvq, val);
+		if (ret) {
+			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
+			return 1;
+		}
+	}
+
+	for (i = 0; i < 500 && can_loop; i++) {
+		ret = lvq_steal(lvq, &newval);
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
+	lvq_destroy(lvq);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c b/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
new file mode 100644
index 000000000000..b93c4f9d1c92
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
@@ -0,0 +1,241 @@
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
+#include <libarena/lvqueue.h>
+
+static inline
+u64 lv_arr_size(lv_arr_t *lv_arr)
+{
+	return LV_ARR_BASESZ << READ_ONCE(lv_arr->order);
+}
+
+static inline
+u64 lv_arr_get(lv_arr_t *lv_arr, u64 ind)
+{
+	u64 ret = READ_ONCE(lv_arr->data[ind % lv_arr_size(lv_arr)]);
+
+	return ret;
+}
+
+static inline
+void lv_arr_put(lv_arr_t *lv_arr, u64 ind, u64 value)
+{
+	WRITE_ONCE(lv_arr->data[ind % lv_arr_size(lv_arr)], value);
+}
+
+static inline
+void lv_arr_copy(lv_arr_t *dst, lv_arr_t *src, u64 b, u64 t)
+{
+	u64 i;
+
+	for (i = t; i < b && can_loop; i++)
+		lv_arr_put(dst, i, lv_arr_get(src, i));
+}
+
+static inline
+int lvq_order_init(lv_queue_t *lvq __arg_arena, int order)
+{
+	lv_arr_t *arr = &lvq->arr[order];
+
+	if (unlikely(!lvq))
+		return -EINVAL;
+
+	if (order >= LV_ARR_ORDERS)
+		return -E2BIG;
+
+	/* Already allocated? */
+	if (arr->data)
+		return 0;
+
+	arr->data = (u64 __arena *)malloc((LV_ARR_BASESZ << order) * sizeof(*arr->data));
+	if (!arr->data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+__weak
+int lvq_owner_push(lv_queue_t *lvq __arg_arena, u64 val)
+{
+	volatile u64 b, t;
+	lv_arr_t *newarr;
+	lv_arr_t *arr;
+	ssize_t sz;
+	int ret;
+
+	if (unlikely(!lvq))
+		return -EINVAL;
+
+	b = smp_load_acquire(&lvq->bottom);
+
+	/*
+	 * In this call, loads from bottom and top should be
+	 * in this order specifically (also see lvq_steal()).
+	 */
+	smp_rmb();
+
+	t = READ_ONCE(lvq->top);
+	arr = READ_ONCE(lvq->cur);
+
+	sz = b - t;
+	if (sz >= lv_arr_size(arr) - 1) {
+		ret = lvq_order_init(lvq, arr->order + 1);
+		if (ret)
+			return ret;
+
+		newarr = &lvq->arr[arr->order + 1];
+
+		lv_arr_copy(newarr, arr, b, t);
+		smp_store_release(&lvq->cur, newarr);
+	}
+
+	lv_arr_put(lvq->cur, b, val);
+	smp_store_release(&lvq->bottom, b + 1);
+
+	return 0;
+}
+
+
+__weak
+int lvq_owner_pop(lv_queue_t *lvq __arg_arena, u64 *val)
+{
+	lv_arr_t *arr;
+	volatile u64 b, t;
+	int ret = 0;
+	ssize_t sz;
+	u64 value;
+
+	if (unlikely(!lvq || !val))
+		return -EINVAL;
+
+	arr = smp_load_acquire(&lvq->cur);
+
+	b = READ_ONCE(lvq->bottom);
+	b -= 1;
+
+	WRITE_ONCE(lvq->bottom, b);
+
+	smp_mb();
+
+	t = READ_ONCE(lvq->top);
+	sz = b - t;
+	if (sz < 0) {
+		smp_store_release(&lvq->bottom, t);
+		return -ENOENT;
+	}
+
+	value = lv_arr_get(arr, b);
+	if (sz > 0) {
+		*val = value;
+		return 0;
+	}
+
+	if (cmpxchg(&lvq->top, t, t + 1) != t)
+		ret = -EAGAIN;
+
+	smp_store_release(&lvq->bottom, t + 1);
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
+int lvq_steal(lv_queue_t *lvq __arg_arena, u64 *val)
+{
+	volatile u64 b, t;
+	lv_arr_t *arr;
+	ssize_t sz;
+	u64 value;
+
+	if (unlikely(!lvq || !val))
+		return -EINVAL;
+
+	t = smp_load_acquire(&lvq->top);
+
+	/*
+	 * It is important that t is read before b for
+	 * stealers to avoid racing with the owner.
+	 * Races between stealers are dealt with using
+	 * CAS to increment the top value below.
+	 */
+	smp_rmb();
+
+	b = READ_ONCE(lvq->bottom);
+	arr = READ_ONCE(lvq->cur);
+
+	sz = b - t;
+	if (sz <= 0)
+		return -ENOENT;
+
+	value = lv_arr_get(arr, t);
+
+	if (cmpxchg(&lvq->top, t, t + 1) != t)
+		return -EAGAIN;
+
+	smp_store_release(val, value);
+
+	return 0;
+}
+
+
+__weak
+u64 lvq_create_internal(void)
+{
+	/*
+	 * Marked as volatile because otherwise the array
+	 * reference in the internal loop gets demoted to
+	 * scalar and the program fails verification.
+	 */
+	volatile lv_queue_t *lvq;
+	int ret, i;
+
+	lvq = malloc(sizeof(*lvq));
+	if (!lvq)
+		return (u64)NULL;
+
+	WRITE_ONCE(lvq->bottom, 0);
+	WRITE_ONCE(lvq->top, 0);
+
+	for (i = 0; i < LV_ARR_ORDERS && can_loop; i++) {
+		lvq->arr[i].data = NULL;
+		lvq->arr[i].order = i;
+	}
+
+	ret = lvq_order_init((lv_queue_t *)lvq, 0);
+	if (ret) {
+		free(lvq);
+		return (u64)NULL;
+	}
+
+	smp_store_release(&lvq->cur, &lvq->arr[0]);
+
+	return (u64)(lvq);
+}
+
+__weak
+int lvq_destroy(lv_queue_t *lvq __arg_arena)
+{
+	int i;
+
+	if (unlikely(!lvq))
+		return -EINVAL;
+
+	for (i = 0; i < LV_ARR_ORDERS && can_loop; i++)
+		free(lvq->arr[i].data);
+
+	free(lvq);
+
+	return 0;
+}
-- 
2.54.0

