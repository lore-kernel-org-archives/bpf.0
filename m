Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8C3B530A
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533669; cv=none; b=OONFKQExG2d0HHcu5Fh5hhBO80rAgQt/HTvfAO8RezuHNTDYMfHn+zjnhtbTfJNRlY5Nc3iv7/d6Iv6+DHdTSMmXG4RjTji8fTG4DKMc4V9qi3jTLabrS263fmMtXIvXNr3GprYQMxIJ0qU2jGqQGVOH6pqeL4ipzuldrDJlRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533669; c=relaxed/simple;
	bh=7NeISZzt4oQa/2US5xwYYFU2PzMRIbNNjkcyx5Z1C8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQZkh61HiMVqSfOZumJwXnoDGzate/Cs/Sgl2q45Vqq+bw5jk+e7j4j+ssxiLLWe7oRNyNCjKTiw7/sJbg9mQrosjvWCM1RwElD8sjaycF2qoRU10Er5wmKEO30AzVT5MipMm/IuBiaX29hwYiFZmPuZb9TIPLQVRQDvVVrPug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ORZkHkhx; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ORZkHkhx"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3539268eec.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778533667; x=1779138467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJUDpNAJF6rDSeL7fcX6+x7cWsNvUlGl92a2dW3I9ro=;
        b=ORZkHkhxiY+2dY4R7jQ9oSP+4JM31TyEuFaCTjXhGHvZbI2ASmZf8zJmKxskockBfR
         aIm0mfRQ7spsbAYXw7z4uwuCQoywbx6ViyfrIekerLTljsM5g/ulxlv4VlaH7uzsSCGo
         J8gVd3b3u2YodLErisDFNJlQfwIEcuZLwc9Z2FlfR4Z9joAFwLCYaJWR/uFjoZ/ONqxb
         tmeNr1gK2TmnUUG4EmfeYlsp8BBFksOigssGEde8aQH1UZX4yHrf0OeTDhgw1pa1MUDm
         +Qalr9leXC4PW3U69VhDz5xta0/PukIr7Y9yYjr3bNnifZeHSVqXDm5BmqNYyzBFaTjS
         y4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533667; x=1779138467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJUDpNAJF6rDSeL7fcX6+x7cWsNvUlGl92a2dW3I9ro=;
        b=lP4hUx1BzMFYaC//rVl5qMAg7Uo5euZqUMhcFpImFkmWfA25sCpVpT5N11EIwH68HU
         1xmdgRUCna18eHOxhxfcjnobARAVVdNl7qKJwo4sUqlJBVNf/7NX8rum/MdFrIqGVyBM
         amC0sb355PfEMeoXkvfhJIb3mj1SNFQ8+uBxbp1rIv8dWpiCjSDawj+xUr6wX3fD6j0D
         ptxnVFPMc5Hmu1AwnGzD6I64K+DHP4wALRcK8xZ8K4PTN+Q3vNB3n0Zizzn6KXtgdfoD
         7XCov2ZgTwXZ2OQMd8ByA/gVqIMy+xwxkD7fC34PvhSr1iZ/ruInW/6UP+ILaTiHCizr
         fIjA==
X-Gm-Message-State: AOJu0YxfiANlu5pJYWuWxPvS0yDN4/oqe7tHBzSyCIK+zsHh9d9d54oF
	WBfPukWVVbQuao8JCjA5GyGFLe4MICsh007ughhOXr43p7v9Q2+jg3YqtKaDqmogVVFWnpFhfw8
	Bp/YcLM2W18ft
X-Gm-Gg: Acq92OGRVwPSeuabAYJN7Hi8Uq5lCLScxzARqhclY2IU/T49D3oFYaP/mHmuW45RKfV
	EhNhWvl4gh5EOe0JUpX2t7m7Umr+Qk/XIbpYrS64i/MYJYyqTyvTMfGh06DTn4WhhLYaTGbpCKQ
	hKysDd/pGDJmtRXYftkWW/kHrGGtXj2I8gYudY2GJs9xUXNAC3z/yLLXFIaHJca4BGM78tjDBLB
	zoHucnh0XcxuER1fmcwmoZGk0FPdlfBJWzRO8Rt/MnV8hE09jbU6gNi+Nf8Y9TmYqgUakViIi0y
	gqwiCBMwVnkyCM5lrhVfDahcMRA59RgrcctXDvXjCjIrZA4RL+UZcERlg9TR9gkBBybrjgKbxk1
	i3vESqTdGgG6Mzo+KhFvSwnJqZhbtpBa1sX6X+PGsg2bs3qR7kUdygiU53gFKgTJESrbJAMnSQo
	oyeVo7Mab9Gb1C4Av3Zo4=
X-Received: by 2002:a05:7300:8c9f:b0:2ef:1d11:18b0 with SMTP id 5a478bee46e88-2ff95d64cc0mr585982eec.17.1778533666877;
        Mon, 11 May 2026 14:07:46 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::7a4c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm20177293eec.31.2026.05.11.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:07:46 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobfrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: libarena: Add Lev-Chase queue data structure
Date: Mon, 11 May 2026 17:07:40 -0400
Message-ID: <20260511210740.5395-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511210740.5395-1-emil@etsalapatis.com>
References: <20260511210740.5395-1-emil@etsalapatis.com>
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

