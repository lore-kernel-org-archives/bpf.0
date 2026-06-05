Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52836EA8F
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698028; cv=none; b=NItSxBDqRfHKUC44tprgLSg1L0/zYvD1Dan3wSEJW+opQgnbwXwOPdQtiCEe3luB5F/mYWI2wNy30zIaUSgumLYmNBOKPaTTfo5lmDgE7p8goxeaT10wvtwqh88Y0nHcRKtb9wLOC+dLxXg5QfAwuajIxF/1IBa3ATs8Ba6Fac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698028; c=relaxed/simple;
	bh=nAAqdEKRrp7xnegxcco2sppGDLIm9v51sXCntWJqcdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiuChQzVnTOlMl4gE+YS9XyekeD1dKbjTcaP44hkKUdWytZ5SkbStuyprDaVc7FD18QXNV1MzXx2wDoJ0MkRhrh40hWuIN7fcJ/2C7uL6l3OVTFXDjK94nFf5rCmOks5pzdIgVwCvgnRFMVnxTeLwskKK+tXd7iNIiCpx+DIWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=w4I74nFo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="w4I74nFo"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423f1e2f8eso1920219b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 15:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780698026; x=1781302826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFwvaowUbJcEMNkNvjJWBb80lYTWT2ajVXcwR3xwf+0=;
        b=w4I74nFoP4Rx87jVFGQkv9Svdbn22isO1ZQoAMH5utvpmsokonaQdrcFprfeTDV0zR
         aJfou5LyDf7cUte1McikHyUUPbQWTBHdlTmW+YxO7uqAQo4kep5OZi0rKU/ecJLeT73Y
         SBW3FyHSRjriDquMachzb3ZN3vc6gWLeqEfVYszHs2FaPVTxI8LyQBQvgxr/r0yW0oaD
         5kGA+8uz0JgRN3F71HYlE9tAFARW9sLaPquiE+ryFNYa5agQTz82FIEIhRL+zzA80Fg6
         xI1ALJY4+c7txW1Yqaj++XI2KuHOcMi3usQFPbxGV4EdEHYW7MRuWa0h8jXR1csvN2HQ
         yAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780698026; x=1781302826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFwvaowUbJcEMNkNvjJWBb80lYTWT2ajVXcwR3xwf+0=;
        b=DfP8JtA9qRFCY6qm2tZvwCZ7m6u/GjSWwVsOFVk4Xn3gS+HMvXnOy0oxq2T3mqmKWt
         xFQiLaKg2vUlXjZoBGb8L1o47gE10e82Z+7Dw+D+dd5E1E4/HBdGyJy/jgSLjiXBTzFk
         X3AZF5fmgdyDIBA3gfr+Bh0CQP6zIHvWiqSd2sFLo5kujFx0uS2DNvx3O3DnLlpZEJ3L
         6CJA37JD7wfT0L2mZNHBzgpCNCU3sw/1U+L2mMSAdXFnpOEuLH18J9TWf6Mtt1Ltee0m
         WNUlm1EEdqG57o7X6CRv5VhGeBSa1dIgziOl5c9Pb2kQ1upBLmQQVk01yrDyH9/7/Eif
         thyA==
X-Gm-Message-State: AOJu0YzKJs+vOU70i9TSuxqy6aXinQV26hhwWyYHgB8418GNhPuEKLK1
	MNjj6jNA/cN/fDBhzXE0+m/JhHs3haD7nNxzl+h77VTH/1y+y7XK631WzJAvuiJ3Ecmv9qk1cOS
	HG2oobP+NMnj/
X-Gm-Gg: Acq92OFDCZamijo0uctrYw7TIm7nM34zl9IHOrzeEgWxdvDK7XMNBxlFyGHmD4I/faa
	PavVW6ocRlXWtzsYX2ENDUdXTmwyUuYNyH/L/cIJzPzaRAoj/Vm0tBdue83LHJwig5kUW2217uR
	Fex/N2d0Gp3kmXqL3HCTPhZHgJaMCSu98JWXxCNT4GDtaUWQHvxrssOgOHVusVCetGvIQC8ZPpz
	L5E2sokaMWauYEPoBX/HJ3z4Yv8sLUpR2YdfZnoDpel0DM9waIA1ioSOH+ZXmMCwU4wb/gjo3Ad
	gDL7wu5h9jYD5gvMbzlSVhrmHCSqc6NE7G+FQ/0ndEhdyzxNaN3xOfAfX/McddpUjUkhz512e6Y
	kZYTOKYRiiafc9SfCQoriKz9+YzM1d1J02az/qChfF51yF00Lb4viBVqvnsAr1lmUzJrT5hNsM4
	og5t8x3qaKXDnY5T8ugiZk7QzcwgU4f/2qEDo=
X-Received: by 2002:a05:6a00:1304:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-842b0eb51e3mr5349958b3a.31.1780698026571;
        Fri, 05 Jun 2026 15:20:26 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372868sm11648844b3a.17.2026.06.05.15.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:20:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: libarena: Add spmc queue data structure
Date: Fri,  5 Jun 2026 18:20:19 -0400
Message-ID: <20260605222020.5231-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605222020.5231-1-emil@etsalapatis.com>
References: <20260605222020.5231-1-emil@etsalapatis.com>
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
 .../selftests/bpf/libarena/src/spmc.bpf.c     | 234 ++++++++++++++++++
 3 files changed, 455 insertions(+)
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
index 000000000000..4d7a520115d1
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
+			arena_stderr("%s:%d expected %llu found %llu\n", __func__, __LINE__, expected, newval);
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
+			arena_stderr("%s:%d expected %d found %llu\n", __func__, __LINE__, i, newval);
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
index 000000000000..42732b7d29a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/spmc.bpf.c
@@ -0,0 +1,234 @@
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
+	return SPMC_ARR_BASESZ << spmc_arr->order;
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
+	t = READ_ONCE(spmc->top);
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
+		arr = newarr;
+	}
+
+	spmc_arr_put(arr, b, val);
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
+	b = READ_ONCE(spmc->bottom) - 1;
+	WRITE_ONCE(spmc->bottom, b);
+	smp_mb();
+
+	t = READ_ONCE(spmc->top);
+	arr = READ_ONCE(spmc->cur);
+
+	sz = b - t;
+	if (sz < 0) {
+		WRITE_ONCE(spmc->bottom, t);
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
+	WRITE_ONCE(spmc->bottom, t + 1);
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
+
+	sz = b - t;
+	if (sz <= 0)
+		return -ENOENT;
+
+	arr = smp_load_acquire(&spmc->cur);
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
+	spmc->cur = &spmc->arr[0];
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

