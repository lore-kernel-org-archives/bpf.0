Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26519F12D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511266; cv=none; b=hY6U4Di2Ah4QmyysuaeJ69NjhWpo8ucyGUhY9yuWKG93oVaBbkA0IumwgY5BTsFYGxPMi2EpKMF8kcgHUdeyIk5puomvuJES6XvBlTgdwRkCy/Xh/PPOIfPM9DnL6IVAimLF3JEWE4K0z/j8GovhUQrph3zXhcMjVHSqILZm4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511266; c=relaxed/simple;
	bh=9xUcpJn8j3H+Vx+9FydNtHAg7o1L/bHMVArndffPAKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNxvOzxbkqndwx3XEnOFInuSXnR8hoshPgM3tm1Pcx4jmmzjsgkCrLhEGkfpj5Xfuvm+eKw/M0ypfcNJe49xTMxyDhcN9vJOwM0rQnghGAQNXaPMRnrwgoYnm/Wf8RHUR12R1YwgtPaNtga+HKY208sFR9xYsIajC6Vp+AdU3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Y4spxR1Y; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Y4spxR1Y"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304d8362a58so750888eec.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780511264; x=1781116064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAAYEXTuGitWm9L3+qs+TCsIU+W/VZSBDLwhZAEjBNs=;
        b=Y4spxR1YNu3EDNTodZpuRTjflgZC8i3DM4Km/Qi8Je3IrYOX0cRedn2hGRtyrld5cq
         Mf6hwA5YVT6Gvdywv/OMC7oQHoaYf8Cnque4G08nA/3ba76Vj4YE4kH1o5dZQIls5Q2X
         d8c/O7aWpJ9FLqo3jr9bS6LRCvtW8ff4KVEObXdnfm+uomIh1LKuDMbWFgV9jz5hGbQL
         WDlDiR91ZczPzfGfAMrYiPziJ5+cAZYSoKc9B96n8UIFqIGnWwvOmY3biNcs7fJfJmOk
         Gjp5VrIA93o+bUx73b1ZVu3+poSTEiTH7AzxNB/QnmeJxCrzsTtdEyFXzDRoeX7X3Xzb
         66YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511264; x=1781116064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAAYEXTuGitWm9L3+qs+TCsIU+W/VZSBDLwhZAEjBNs=;
        b=Wyw9i+0I5solZ3GbjXAxg11TUKKG5ptOEHAXc8cltRnZ/vLxqeawwqMMHZLlgGuojs
         zkcw31vurZnWbEQvceEEzSif4VT6kWNOOVTWvQhTqOY9M7nG+CArGL/QbWQGJAYpKoVV
         R6SgR5pwBCdNGJbAmTvaSu0bH7Esx47xVus9wJUMd4sdWQxrUo/eSSP1nqZO4srDEXES
         H+Wd9rg8ROsslS+TpQ2iFGZ6xDIXHQw5oSLjXouUQxYySwSmebo3ffcirdni3QnWVr5Y
         3VxCtdjW9ifjpJTKT1iXmbsDXsKHv0YB5wEy8Ic/FdlpxZ3a5PAwVGdHb8+/GkBoYPSs
         QxIg==
X-Gm-Message-State: AOJu0YxfIH7FQzHIYpFXiVkQhNSOl2s50ftHC3LDjdTEs2ZfKUx7XW9K
	86LJIrioS16qGUbR7Ezw9Js72f8WA9ldwd8Y5fyVTXol1UnvGyg03tKjaNDk1KFVyqmB1gdsyhb
	u6BGGCG8WqsO6
X-Gm-Gg: Acq92OFg3LZfYUVBgC3P/gwLO7mtFxtxNzKpF7ES9eRpzobweFTU3QY88XJfdcKI7bo
	/Ljx2YhKxI/Lyt0l7H6k7QVyARptr3cQ2YXlgKGTcFdsupvZG14tnII4Pim5ZhLasM54DvROEK4
	ijunm24rWfuDTWQ5rR3qhNSeHGa53xY1iH1Tk/jEAc2ieLYWoDUylGX93N/xDRg+KhZvWqUmya3
	KxbPZ8yl38TcH+yLrv5JXdoD921t/rHRXT7rgXDdHDq5235gU0D+8nzXulVSgwfAxxGaY3LE/Zr
	uLPEx/bw4d/g93qPS2Y6MiefotDtIm6hDxMZP831fmkh6jU7oOmBBPqxMEIEcYrIWnHNWHqhqNl
	BauWVWExZ0P001O+TOfV0w/JnWv0AO2/DQgrtgCrcVbeA6JozOTcJCg+09pn90WhwIXYUtPr2gb
	iW5bl3bDIJXvWDYe70f2STAkyhk9uPTQ==
X-Received: by 2002:a05:693c:2d97:b0:304:cd0d:9ea5 with SMTP id 5a478bee46e88-30761f3c6d5mr256124eec.7.1780511263701;
        Wed, 03 Jun 2026 11:27:43 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::ea8f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm4137860eec.5.2026.06.03.11.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:27:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: libarena: parallel test harness and spmc parallel selftest
Date: Wed,  3 Jun 2026 14:27:27 -0400
Message-ID: <20260603182727.3922-4-emil@etsalapatis.com>
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

Add a parallel test for the SPMC Lev-Chase workstealing queue. The queue
is built to be wait-free even when there are multiple consumers, and
the parallel selftest provides a signal on whether the queue behaves
correctly when stress tested.

To support the test, this patch includes a test harness for parallel
selftests. The spmc selftest acts as an example of the naming and other
conventions expected by the harness.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/userspace.h |   6 +
 .../selftests/test_parallel_spmc.bpf.c        | 659 ++++++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       | 157 +++++
 3 files changed, 822 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
index 88b68ac73cca..fc27a4bcf5d7 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
@@ -32,6 +32,12 @@ static inline bool libarena_is_asan_test_prog(const char *name)
 	return strstr(name, "asan_test") == name;
 }
 
+static inline bool libarena_is_parallel_test_prog(const char *name)
+{
+	return strstr(name, "parallel_test") == name;
+}
+
+
 static inline int libarena_run_prog_args(int prog_fd, void *args, size_t argsize)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
new file mode 100644
index 000000000000..21e40999f1e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+
+#include <bpf_atomic.h>
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/spmc.h>
+
+#define TEST_SPMC_THREADS 4
+#define TEST_SPMC_STEALERS (TEST_SPMC_THREADS - 1)
+
+/* 
+ * The test requires the stealers/owners to sometimes quiesce
+ * before continuing the benchmark. Normally we'd use something
+ * like a condition variable, but since the benchmark is short-lived
+ * and operations are wait-free we just spin around the quiescence
+ * point instead. If we time out, we just fail the benchmark.
+ */
+#define TEST_SPMC_SYNC_SPINS (1U << 18)
+
+/*
+ * We track all the values we retrieve from the queue
+ * to get some guarantee we're, not corrupting data,
+ * e.g., accidentally reusing a past value from a slot.
+ */
+#define TEST_SPMC_MAX_VALUES (1024)
+static u64 __arena seen[TEST_SPMC_MAX_VALUES];
+
+/* The single spmc queue for the benchmark. */
+static struct spmc __arena *spmc;
+
+/* Owner and stealer epochs. We define the , */
+static volatile u64 owner_epoch;
+static volatile u64 stealer_epoch;
+
+/* Map owner epochs to stealer epochs (simply scale by # of stealers). */
+#define STEALER_EPOCH(owner_epoch) ((owner_epoch) * TEST_SPMC_STEALERS)
+
+/* Global abort switch. If any thread fails, all others exit ASAP. */
+static volatile bool test_abort;
+
+/* 
+ * Counters useful for ensuring conservation of pushes/pops of unique values
+ * (we're not stealing/popping more/fewer items than were pushed).
+ */
+static volatile u64 expected_total;
+static volatile u64 total_seen;
+
+/* Measure how many pops and steals we've made (irrespective of retrieved value). */
+static volatile u64 pops;
+static volatile u64 steals;
+
+/* Used for the resize selftest, see below. */
+static volatile u64 stealers_started;
+
+/* Used for the mixed selftest, see below. */
+static volatile u64 round_steals;
+
+/*
+ * We have multiple stealers and a single owner. We sometimes want the owner
+ * to successfully outproduce the stealers, we add a busy loop in them.
+ */
+#define TEST_SPMC_WASTE_ROUNDS (1024)
+
+/*
+ * Scaffolding for each parallel test. Each test has setup/teardown,
+ * a single owner thread that owns the queue, and TEST_SPMC_STEALER
+ * threads that try to steal.
+ */
+#define DEFINE_PARALLEL_SPMC_TEST(prefix, expected_total)		\
+	SEC("syscall") int parallel_test_spmc_##prefix##__init(void)	\
+	{								\
+		return spmc_common_init(expected_total);		\
+	}								\
+	SEC("syscall") int parallel_test_spmc_##prefix##__fini(void)	\
+	{								\
+		return spmc_common_fini();				\
+	}								\
+	SEC("syscall") int parallel_test_spmc_##prefix##__0(void)	\
+	{								\
+		return spmc_##prefix##_owner();				\
+	}								\
+	SEC("syscall") int parallel_test_spmc_##prefix##__1(void)	\
+	{								\
+		return spmc_##prefix##_stealer();					\
+	}								\
+	SEC("syscall") int parallel_test_spmc_##prefix##__2(void)	\
+	{								\
+		return spmc_##prefix##_stealer();					\
+	}								\
+	SEC("syscall") int parallel_test_spmc_##prefix##__3(void)	\
+	{								\
+		return spmc_##prefix##_stealer();					\
+	}
+
+static int spmc_common_init(u64 total)
+{
+	u64 i;
+
+	if (total > TEST_SPMC_MAX_VALUES)
+		return -E2BIG;
+
+	owner_epoch = 0;
+	stealer_epoch = 0;
+	test_abort = false;
+	expected_total = total;
+	total_seen = 0;
+	pops = 0;
+	steals = 0;
+	stealers_started = 0;
+	round_steals = 0;
+
+	for (i = zero; i < TEST_SPMC_MAX_VALUES && can_loop; i++)
+		seen[i] = 0;
+
+	spmc = spmc_create();
+	if (!spmc)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int spmc_common_fini(void)
+{
+	int ret;
+
+	ret = spmc_destroy(spmc);
+	spmc = NULL;
+
+	return ret;
+}
+
+__weak
+int spmc_quiesce_on_owner(u64 epoch)
+{
+	u64 i;
+
+	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+		if (test_abort)
+			return -EINTR;
+		if (smp_load_acquire(&owner_epoch) >= epoch)
+			return 0;
+	}
+
+	test_abort = true;
+
+	return -ETIMEDOUT;
+}
+
+__weak
+int spmc_quiesce_on_stealer(u64 epoch)
+{
+	u64 target, cur;
+	unsigned int i;
+	int err = -ETIMEDOUT;
+
+	target = STEALER_EPOCH(epoch);
+	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+
+		if (test_abort) {
+			err = -EINTR;
+			break;
+		}
+
+		cur = smp_load_acquire(&stealer_epoch);
+		if (cur > target) {
+			err = -EINVAL;
+			test_abort = true;
+			break;
+		}
+
+		if (cur == target)
+			return 0;
+	}
+
+	test_abort = true;
+
+	return err;
+}
+
+static int spmc_update_stats(u64 val, bool owner)
+{
+	u64 total;
+
+	total = expected_total;
+	if (val >= total || val >= TEST_SPMC_MAX_VALUES) {
+		test_abort = true;
+		return -EINVAL;
+	}
+
+	if (__sync_fetch_and_add(&seen[val], 1) != 0) {
+		test_abort = true;
+		return -EINVAL;
+	}
+
+	__sync_fetch_and_add(&total_seen, 1);
+	if (owner)
+		__sync_fetch_and_add(&pops, 1);
+	else
+		__sync_fetch_and_add(&steals, 1);
+
+	return 0;
+}
+
+static int spmc_validate_owner_empty(void)
+{
+	u64 val;
+	int ret;
+
+	ret = spmc_owned_remove(spmc, &val);
+	if (ret != -ENOENT) {
+		test_abort = true;
+		/* Change a 0 return value into -EINVAL. */
+		return ret ?: -EINVAL;
+	}
+
+	return 0;
+}
+
+__weak
+int spmc_validate_all_seen(void)
+{
+	u64 i, total;
+
+	total = expected_total;
+	if (total_seen != total)
+		goto err;
+
+	if (pops + steals != total)
+		goto err;
+
+	for (i = zero; i < total && can_loop; i++) {
+		if (seen[i % TEST_SPMC_MAX_VALUES] != 1)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	test_abort = true;
+
+	return -EINVAL;
+}
+
+/*
+ * Single value benchmark. The owner adds an item then races with
+ * the stealers for it. This way directly race between owner and
+ * stealers on the same slot.
+ */
+
+
+#define TEST_SPMC_SINGLEVAL_ITERS (64)
+
+__weak
+int spmc_singleval_tryconsume(u64 expected, bool steal)
+{
+	u64 val;
+	int ret;
+
+	while (can_loop) {
+		if (steal)
+			ret = spmc_steal(spmc, &val);
+		else
+			ret = spmc_owned_remove(spmc, &val);
+
+		/* Success. Update and validate. */
+		if (!ret) {
+			if (val != expected)
+				return -EINVAL;
+
+			ret = spmc_update_stats(val, !steal);
+			if (ret)
+				return ret;
+
+			return 0;
+		}
+
+		/*
+		 * If we got -ENOENT, the queue is empty
+		 * and we're good to go.
+		 */
+		if (ret != -EAGAIN)
+			return (ret == -ENOENT) ? 0 : ret;
+	}
+
+	/* Impossible. */
+	return -EINVAL;
+}
+
+static int spmc_singleval_owner(void)
+{
+	int ret;
+	u64 i;
+
+	for (i = zero; i < TEST_SPMC_SINGLEVAL_ITERS && can_loop; i++) {
+		ret = spmc_quiesce_on_stealer(i);
+		if (ret)
+			goto err;
+
+		ret = spmc_owned_add(spmc, i);
+		if (ret)
+			goto err;
+
+		__sync_fetch_and_add(&owner_epoch, 1);
+
+		spmc_singleval_tryconsume(i, false);
+
+		ret = spmc_quiesce_on_stealer(i + 1);
+		if (ret)
+			goto err;
+	}
+
+	ret = spmc_validate_owner_empty();
+	if (ret)
+		return ret;
+
+	return spmc_validate_all_seen();
+
+err:
+	test_abort = true;
+	return -EINVAL;
+}
+
+static int spmc_singleval_stealer(void)
+{
+	int ret;
+	u64 i;
+
+	for (i = zero; i < TEST_SPMC_SINGLEVAL_ITERS && can_loop; i++) {
+		ret = spmc_quiesce_on_owner(i + 1);
+		if (ret)
+			goto err;
+
+		ret = spmc_singleval_tryconsume(i, true);
+		if (ret)
+			goto err;
+
+		__sync_fetch_and_add(&stealer_epoch, 1);
+	}
+
+	return 0;
+
+err:
+	test_abort = true;
+	return -EINVAL;
+}
+
+DEFINE_PARALLEL_SPMC_TEST(singleval, TEST_SPMC_SINGLEVAL_ITERS)
+
+/*
+ * The resize test. Force a resize from the owner even while the stealers
+ * are trying to consume. Then make sure the queue is still consistent
+ * after the resize.
+ *
+ * The owner _doesn't_ consume from the queue. The test makes sure that
+ * switching the array from underneath the stealers works.
+ */
+
+/* Force 2 resizes (since the rate of resize is logarithmic). */
+#define TEST_SPMC_RESIZE_ORDER (2)
+#define TEST_SPMC_RESIZE_PREFILL ((SPMC_ARR_BASESZ << TEST_SPMC_RESIZE_ORDER) - 1)
+
+/* */
+#define TEST_SPMC_RESIZE_TAIL (SPMC_ARR_BASESZ << TEST_SPMC_RESIZE_ORDER)
+#define TEST_SPMC_RESIZE_TOTAL (TEST_SPMC_RESIZE_PREFILL + TEST_SPMC_RESIZE_TAIL)
+
+__weak
+int spmc_wait_for_stealers_to_start(u64 target)
+{
+	u64 i;
+
+	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+		if (test_abort)
+			return -EINTR;
+		if (READ_ONCE(stealers_started) >= target)
+			return 0;
+	}
+
+	test_abort = true;
+
+	return -ETIMEDOUT;
+}
+
+__weak
+void spmc_waste_time(void)
+{
+	int i;
+	int j;
+
+	for (i = zero; i < TEST_SPMC_WASTE_ROUNDS && can_loop; i++) {
+		/* Random computation. */
+		WRITE_ONCE(j, i * 17 + 23);
+	}
+}
+
+__weak
+int spmc_wait_for_steals(u64 target)
+{
+	u64 i;
+
+	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+		if (test_abort)
+			return -EINTR;
+		if (READ_ONCE(steals) >= target)
+			return 0;
+	}
+
+	test_abort = true;
+
+	return -ETIMEDOUT;
+}
+
+static int spmc_resize_owner(void)
+{
+	bool resized = false;
+	u64 i;
+	int ret;
+
+	/* Get a head start vs the consumers. */
+	for (i = zero; i < TEST_SPMC_RESIZE_PREFILL && can_loop; i++) {
+		ret = spmc_owned_add(spmc, i);
+		if (ret) {
+			test_abort = true;
+			return ret;
+		}
+	}
+
+	__sync_fetch_and_add(&owner_epoch, 1);
+
+	/* Wait for stealers to start then start racing. */
+	ret = spmc_wait_for_stealers_to_start(TEST_SPMC_STEALERS);
+	if (ret)
+		return ret;
+
+	for (i = TEST_SPMC_RESIZE_PREFILL; i < TEST_SPMC_RESIZE_TOTAL && can_loop; i++) {
+		ret = spmc_owned_add(spmc, i);
+		if (ret) {
+			test_abort = true;
+			return ret;
+		}
+
+		if (spmc->cur->order > TEST_SPMC_RESIZE_ORDER)
+			resized = true;
+	}
+
+	/* Did we get to resize while racing/ */
+	if (!resized) {
+		test_abort = true;
+		return -153;
+	}
+
+	/* 
+	 * Wait for the stealers to drain and make sure
+	 * we didn't lose any items along the way.
+	 */
+	__sync_fetch_and_add(&owner_epoch, 1);
+
+	ret = spmc_quiesce_on_stealer(1);
+	if (ret)
+		return ret;
+
+	ret = spmc_validate_owner_empty();
+	if (ret)
+		return ret;
+
+	return spmc_validate_all_seen();
+}
+
+static int spmc_resize_stealer(void)
+{
+	u64 val;
+	int ret;
+
+	arena_subprog_init();
+
+	ret = spmc_quiesce_on_owner(1);
+	if (ret)
+		return ret;
+
+	__sync_fetch_and_add(&stealers_started, 1);
+
+	while (can_loop) {
+		spmc_waste_time();
+
+		ret = spmc_steal(spmc, &val);
+		if (!ret) {
+			ret = spmc_update_stats(val, false);
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		if (ret == -EAGAIN)
+			continue;
+
+		/* Only break if this was the last resize. */
+		if (ret == -ENOENT) {
+			if (READ_ONCE(owner_epoch) >= 2)
+				break;
+			continue;
+		}
+
+		test_abort = true;
+		return ret;
+	}
+
+	__sync_fetch_and_add(&stealer_epoch, 1);
+
+	return 0;
+}
+
+DEFINE_PARALLEL_SPMC_TEST(resize, TEST_SPMC_RESIZE_TOTAL)
+
+/*
+ * The burst benchmark. The owner generates data all at once,
+ * then waits for the stealers to steal half then starts removing 
+ * items until the queue empties. The owner also makes sure the
+ * item order is not jumbled.
+ */
+
+#define TEST_SPMC_BURST_ROUNDS (4)
+#define TEST_SPMC_BURST_BURST (64)
+#define TEST_SPMC_BURST_TOTAL (TEST_SPMC_BURST_ROUNDS * TEST_SPMC_BURST_BURST)
+#define TEST_SPMC_BURST_STEAL_TARGET (TEST_SPMC_BURST_BURST / 2)
+
+static int spmc_wait_for_round_steals(u64 target)
+{
+	u64 i;
+
+	arena_subprog_init();
+
+	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+		if (test_abort)
+			return test_abort;
+		if (round_steals >= target)
+			return 0;
+	}
+
+	test_abort = true;
+
+	return -ETIMEDOUT;
+}
+
+__weak int
+spmc_burst_owner_round(u64 round)
+{
+	u64 i, base, stolen, expected, val;
+	int ret;
+
+	base = round * TEST_SPMC_BURST_BURST;
+	round_steals = 0;
+
+	for (i = zero; i < TEST_SPMC_BURST_BURST && can_loop; i++) {
+		ret = spmc_owned_add(spmc, base + i);
+		if (ret)
+			return ret;
+	}
+
+	__sync_fetch_and_add(&owner_epoch, 1);
+
+	ret = spmc_wait_for_round_steals(TEST_SPMC_BURST_STEAL_TARGET);
+	if (ret)
+		return ret;
+
+	__sync_fetch_and_add(&owner_epoch, 1);
+
+	ret = spmc_quiesce_on_stealer(round + 1);
+	if (ret)
+		return ret;
+
+	stolen = round_steals;
+	if (stolen > TEST_SPMC_BURST_BURST)
+		return -EINVAL;
+
+	for (i = zero; i < TEST_SPMC_BURST_BURST - stolen && can_loop; i++) {
+		ret = spmc_owned_remove(spmc, &val);
+		if (ret)
+			return ret;
+
+		expected = base + TEST_SPMC_BURST_BURST - 1 - i;
+		if (val != expected)
+			return -EINVAL;
+
+		ret = spmc_update_stats(val, true);
+		if (ret) {
+			test_abort = true;
+			return -EINVAL;
+		}
+	}
+
+	ret = spmc_validate_owner_empty();
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int spmc_burst_owner(void)
+{
+	u64 round;
+	int ret;
+
+	arena_subprog_init();
+
+	for (round = zero; round < TEST_SPMC_BURST_ROUNDS && can_loop; round++) {
+		ret = spmc_burst_owner_round(round);
+		if (ret)
+			goto err;
+	}
+
+	return spmc_validate_all_seen();
+
+err:
+	test_abort = true;
+	return -EINVAL;
+}
+
+static int spmc_burst_stealer(void)
+{
+	u64 round, val, active_epoch;
+	int ret;
+
+	arena_subprog_init();
+
+	for (round = zero; round < TEST_SPMC_BURST_ROUNDS && can_loop; round++) {
+		active_epoch = round * 2 + 1;
+
+		/* 
+		 * Wait till the owner prefills the queue then
+		 * start stealing.
+		 */
+		ret = spmc_quiesce_on_owner(active_epoch);
+		if (ret)
+			return ret;
+
+		while (owner_epoch == active_epoch && can_loop) {
+			ret = spmc_steal(spmc, &val);
+			if (!ret) {
+				ret = spmc_update_stats(val, false);
+				if (ret)
+					return ret;
+				__sync_fetch_and_add(&round_steals, 1);
+				continue;
+			}
+			if (ret == -EAGAIN || ret == -ENOENT)
+				continue;
+
+			test_abort = true;
+			return ret;
+		}
+
+		__sync_fetch_and_add(&stealer_epoch, 1);
+	}
+
+	return 0;
+}
+
+DEFINE_PARALLEL_SPMC_TEST(burst, TEST_SPMC_BURST_TOTAL)
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
index 81bdb084c271..03348a95fb5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -27,6 +27,147 @@ static void run_libarena_test(struct libarena *skel, struct bpf_program *prog,
 
 }
 
+static void *run_libarena_parallel_prog(void *arg)
+{
+	struct bpf_program *prog = arg;
+
+	return (void *)(long)libarena_run_prog(bpf_program__fd(prog));
+}
+
+/* Max suffix is ceil((lg 2^32) / (lg 10)) + sizeof("__") = 10 + 2 = 12. */
+#define MAX_PARTEST_SUFFIX (12)
+#define MAX_PARTEST_NAME (1024)
+#define MAX_PARTEST_PREFIX (MAX_PARTEST_NAME - MAX_PARTEST_SUFFIX)
+
+static int run_libarena_parallel_fini(struct libarena *skel, const char *name,
+				      size_t prefixlen)
+{
+	char tdname[MAX_PARTEST_NAME];
+	struct bpf_program *fini_prog;
+	int ret;
+
+	ret = snprintf(tdname, sizeof(tdname), "%.*s__fini", (int)prefixlen, name);
+	if (!ASSERT_LT(ret, sizeof(tdname), "partest fini name"))
+		return -ENAMETOOLONG;
+
+	fini_prog = bpf_object__find_program_by_name(skel->obj, tdname);
+	if (!ASSERT_TRUE(fini_prog, "partest fini prog"))
+		return -ENOENT;
+
+	ret = libarena_run_prog(bpf_program__fd(fini_prog));
+	ASSERT_OK(ret, tdname);
+
+	return ret;
+}
+
+static int run_libarena_parallel_test_workers(struct libarena *skel,
+		const char *name, size_t prefixlen)
+{
+	pthread_t *threads = NULL, *tmp_threads;
+	char tdname[MAX_PARTEST_NAME];
+	struct bpf_program *tdprog;
+	uint32_t nthreads;
+	void *thread_ret;
+	int ret, err = 0;
+	int i;
+
+	for (nthreads = 0; nthreads < UINT_MAX; nthreads++) {
+		ret = snprintf(tdname, sizeof(tdname), "%.*s__%u", (int)prefixlen,
+			       name, nthreads);
+		if (!ASSERT_LT(ret, sizeof(tdname), "test worker name")) {
+			err = -ENAMETOOLONG;
+			break;
+		}
+
+		/* 
+		 * We enumerate the worker threads for a given test with __0, __1,
+		 * and so on. The suffixes always start from 0 and are contiguous,
+		 * so if we don't find a program with the requested name we have
+		 * discovered all available worker programs.
+		 */
+		tdprog = bpf_object__find_program_by_name(skel->obj, tdname);
+		if (!tdprog)
+			break;
+
+		/* Bump the alloc array to accommodate the new thread. */
+		tmp_threads = realloc(threads, (nthreads + 1) * sizeof(*threads));
+		if (!ASSERT_TRUE(tmp_threads, "realloc")) {
+			err = -ENOMEM;
+			break;
+		}
+		threads = tmp_threads;
+
+		ret = pthread_create(&threads[nthreads], NULL,
+				     run_libarena_parallel_prog,
+				     tdprog);
+		if (!ASSERT_OK(ret, "pthread_create")) {
+			err = ret;
+			break;
+		}
+	}
+
+
+	for (i = 0; i < nthreads; i++) {
+		ret = pthread_join(threads[i], &thread_ret);
+		if (!ASSERT_OK(ret, "pthread_join")) {
+			err = err ?: ret;
+			continue;
+		}
+
+		err = err ?: (long)thread_ret;
+	}
+
+	free(threads);
+
+	return err;
+}
+
+static void run_libarena_parallel_test(struct libarena *skel, struct bpf_program *prog,
+		const char *name)
+{
+	char testname[MAX_PARTEST_NAME];
+	size_t prefixlen;
+	const char *pos;
+	int ret;
+
+	/*
+	 * We annotate the initialization prog with __init. If the current prog does
+	 * not match, it is one of the parallel threads instead and is ignored.
+	 *
+	 * We assume the test writer knows what they are doing and do not add __init
+	 * randomly in the middle of a test name.
+	 */
+	pos = strstr(name, "__init");
+	if (!pos)
+		return;
+
+	prefixlen = pos - name;
+	if (!ASSERT_LT(prefixlen, MAX_PARTEST_PREFIX, "partest prefix too long"))
+		return;
+
+	/* The name of the test without the __init suffix. Looks nicer in the test log. */
+	ret = snprintf(testname, sizeof(testname), "%.*s", (int)prefixlen, name);
+	if (!ASSERT_LT(ret, sizeof(testname), "partest test name"))
+		return;
+
+	if (!test__start_subtest(testname))
+		return;
+
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+	if (!ASSERT_OK(ret, "arena_buddy_reset"))
+		return;
+
+	ret = libarena_run_prog(bpf_program__fd(prog));
+	if (!ASSERT_OK(ret, testname))
+		return;
+
+	ret = run_libarena_parallel_test_workers(skel, name, prefixlen);
+
+	ASSERT_OK(ret, testname);
+
+	run_libarena_parallel_fini(skel, name, prefixlen);
+}
+
 void test_libarena(void)
 {
 	struct arena_alloc_reserve_args args;
@@ -52,6 +193,22 @@ void test_libarena(void)
 	bpf_object__for_each_program(prog, skel->obj) {
 		const char *name = bpf_program__name(prog);
 
+		/*
+		 * Handle parallel test progs separately. For those
+		 * progs it's not a matter of test/skip, because each
+		 * parallel test prog includes an initialization prog
+		 * and a set of progs to be run in parallel. For the
+		 * latter we do not record them as skipped or run,
+		 * because we run them all at once when we come across
+		 * the initialization prog. For more details on how we
+		 * discover the progs see the comment on
+		 * run_libarena_parallel_test.
+		 */
+		if (libarena_is_parallel_test_prog(name)) {
+			run_libarena_parallel_test(skel, prog, name);
+			continue;
+		}
+
 		if (!libarena_is_test_prog(name))
 			continue;
 
-- 
2.54.0

