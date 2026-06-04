Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD32EEE69
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617027; cv=none; b=ukQCm5Qe7/i1NgV8PlldPS+VDcq2fmOnszFf73dqYdedC7DYWI4W2WKcxOfNllMW8GkcFEtssvtKFiu0EGnk7U8JiNM9srqnyiSmTKZ8zTfTRWP6BLz39Oyg0IjxovgvGDHmn/PLuZYa1xRJS3FHfKRa8O1xAyP1BU5nfX6IJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617027; c=relaxed/simple;
	bh=3XysXUDZvNRQbJYs6RWS+lcMLKEkxNYTg1uEdjlistY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQQ9CBRlx/SpZtPi8SnYpDhCOXavgf/2WmyMf6UEKQnImrhSmW60CFtaE6XIyg8ki1Ww5ceNmGeDIXTMlECe1Dop74fUEzwPxHl3PflFZe8bDHnjc6w+Lpd7El23FXEcVWZ6XQfAfsMKzer0L6iBfgjsuH9Q3Db75F891voGepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=kcCPSUZV; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="kcCPSUZV"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137dd5161feso1768202c88.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780617025; x=1781221825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgM3eu4+FVqBQIaJwMuiUgJho6F6yGVMiMMhWhs5Yj0=;
        b=kcCPSUZV81BFOEy9wXSOisWRfx/aC0s5kJl+zkdvtKClbyzj3ydAoGyvXT92GluJ5X
         nqTnltpM85vCCCZGg6PcN9sSCuxlTLpxL87LuOlsXOlEXjrJVmpbeCsZbMo2HhVeBSQ7
         R1bKGGtEpCZm2F8+7iTxSu+8woeAPSCqlcpK46c6hpJGzeDGm4mh6/eT/Mb496Anoxbi
         fakxr9QAL1LuM76fYcoix8ScA23dA3MEuYQ4+AYFJlrnMZwsO+rTqU3vHqtYpbksCoek
         dCBnPMZSzdOYPTK9BH+ZSW5uLIh+JKTMAF8rLKKBM/OBvKmUh3KkaeuzyhYxMDr8PHdA
         uVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780617025; x=1781221825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgM3eu4+FVqBQIaJwMuiUgJho6F6yGVMiMMhWhs5Yj0=;
        b=rMiBBU5Gotj+lPhojoEPn4yaVhJVvlM5T17v95/MDoRX5dh04s6xSurkN9mXRW7gH5
         xOk1vuOrEWsL1s2YcfnYPghsAis8/iepoxDmdNX776zdIBeBmnSQ+pGKmG03Rtptnk1f
         Naz9XDoGAEJE9yPhudQqXRzaRvvHxf1jvor0tNZNf7NhI6L8wXyARsAosdrtArKJYhz/
         esrvYZbb6iw7IJiBT45pIPncj7DteiQ8bz5x0u/7fngdsIZVdcSvZjEZJphGC2aWOG01
         L4CFT3v4MnTFx6/B6C66Tahpn/BmHHRLt71YBDehg7G/GJ1GpL8q7IOsEVlTy+18i76q
         lt8g==
X-Gm-Message-State: AOJu0YxXz3hw7X9Uc/Sdpc5jcZrZxV5u4hd1M0M4mj6398wWArpaf2oL
	qbjwoF6yved9Qj6H7XAM4o2Z4wIvXLJyK0iqNiorZ/v+yBqCybBWnmNWWhDXGTo3bAizRtGQpP2
	Psr4kZ5gZgWoZ
X-Gm-Gg: Acq92OGLhFXzdt9qUW2ZtLUIj82xQH+xlEDrz9vTFiCG6QsSLRxPYhAS8YYGoG42FkB
	RJsobDtUdlM7z5OpTd2711+JJy01k21SWU0CCOk38IiW+olD3Bppc/KtF7bMuXgARdmWSHSMSHF
	50F4cFn92nT7+ScttcZxfGVH8USBaI34ruLyFOYubu9cpCUyeF42RoSQb/lbir3+Ysxyl1V0ggL
	UcgnQq9xu3aHdIORKhIMwZ28DZxvxM/4dUa85nO1sFB9iX5QXCEDhsHr/DNo7JJnaFlqfV1OkT5
	B5d5u6ZhvLYkA4TnAMJUJ+OS5Nmu8KvsE3N3oGI2wTb6UkkFP6sfWK/TOKM+qIhxDJ0WisB1R1f
	tByOwN5YcMyXF9vY9QUszPVnyjv1AGJVyHhp1czZb6cnUZghHmVjiWIb+bK0q/NtYrHGvbyuBo5
	hY6N9i+Ip9dIJL2wK1H/LjJjoGxH1npw==
X-Received: by 2002:a05:7300:80c8:b0:307:37a4:15dd with SMTP id 5a478bee46e88-3077b26f364mr457378eec.26.1780617025016;
        Thu, 04 Jun 2026 16:50:25 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::39a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm6224412eec.24.2026.06.04.16.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:50:24 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: libarena: Add spmc queue data structure
Date: Thu,  4 Jun 2026 19:50:15 -0400
Message-ID: <20260604235016.20856-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604235016.20856-1-emil@etsalapatis.com>
References: <20260604235016.20856-1-emil@etsalapatis.com>
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

