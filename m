Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D9355F5F
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617030; cv=none; b=XfznU7BJR059sunV9EnprtCxlw8E2Bwt7+8KdTbJ9Jv61hQd3J5NAtE11XyWSs+CGsTObl+rRPmMy1nZs62zgmRPD5V3x0TIbYrSCznI+tFloC81GN4ic+r2evrllF1iHeztvIObzngpFSuw85R+3LFYKFreJ/Emil9HXKed2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617030; c=relaxed/simple;
	bh=xPBsIrCp3Ghga/SWucPnnc1rYviL4kN7//uVocQV0tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo8yo1QLg7dtgYTaP/zDn0L0gyfDuxD2yaFot9RpjD0bbjI5kevd6iursmL6qYZwh/31u87dtJVOrBy/nX4QxCF3nKbppkgtMPrIbbnvU8FjIv/TtVpKM7pb/G/a0IEUSTlar1rOknKdKMCyujRqqAgNqBtr/m5g+tw05Swxv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=reeBS3O8; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="reeBS3O8"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304545f5206so1578946eec.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780617027; x=1781221827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqQoM2tVYz7VNSWnSxYZbJuOk8tuTbS+sr2zb4cTEnA=;
        b=reeBS3O8WVfcJY5yQpzNNZsMqm8z7FzhR07OI2jnOfbf1hX15BEopC2qCKusr6+LAK
         IxG7eoLBuqQ+UH6tbTTlP3HjlwGn7PnUEb1yWf/FQiG6UEAP1v0ebZraVilS8M4hGCmn
         ik9E2rJvzsuxDY+4t0Se0hBKCUtW8y9Ux3oFXpiS5glI+GUDfC98QsDKy7W6avwOIFjr
         NX4CwNpZUm3kIVAxybyCINWUmx30UC8q81EaavdZ0QRrZEBsfSBzHPu4fxe2MUvc62ZJ
         zKjPiFkOB4I8JG6dr6BHCjlHiSTZQh/0/l53cyxjnRyUV8owQdrT9hSPdfcE6U9aG2hs
         Fzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780617027; x=1781221827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqQoM2tVYz7VNSWnSxYZbJuOk8tuTbS+sr2zb4cTEnA=;
        b=TxqWCt9nB9Aw8IKmy/wm47Qv8t1tVJ3njQMXaQYu9an/A2a1S+jdnN/AVTUxsQuxSb
         ODF2kyHWt5tDsu3SUYaFLuQ8IDV0R5hkfWkQhcj+zUhgJ3lEJa3+5xkuC5Taw9E0hMpC
         XaRjxRlO7E8n0Oekej5BUIUBuql7ZVXCpwy5pTxfnvER+HNGLU4vjjRDpznjI/A88A0Y
         RKJYetq+FKsoYj5ZtPOtNvoE+XkDvTwkD7V3+iz+HH5qd95RrnrzIivreB4vQwEahPhG
         RYzkVklfUuhijMt2TfNEc1U96zwplQ6FV/fIWAQ0rFigHmEyZdQWjbmNM5fesi/Ncp3b
         H6Gw==
X-Gm-Message-State: AOJu0YyZi12t0+N2AKO/kUWHM51GkfhlftwFkFPC3/u34OMX3+VvD/9y
	d8bRn35B7nV/y2ERxOpB+tMhUq3agfUq362DAws5W+XyKJFB8/r5eSnxGKunwlYL2VlwL+1Zw99
	cMQ/q8Eb8ltBf
X-Gm-Gg: Acq92OEJa+ZJHhUg5oi4IuTBfN18YfeNUx1fsRhXttR+LlRuKneqqZnCC1a3oi+vtl8
	tvSQjEp9/wxD3kJjlDJLd0FNLj+N3qjtH6ATuH24ltGd4Nsh1Cvx+GQgFe94dB15ZglqCmgl5aR
	ilaIUJnwyp3lwVxoGcm+hGBkYnA2n7bkshIavILRK2SP+s8ZDDW0bNtohLNSYDrItUy2BvwZ5ua
	U/awWPXUZCSdRps1qv2wQtuPGVPbed8o7cpBYmAacOOjuqhVKQ1Lt7KtXuCyxpZS/UglVc2beWk
	oFkvxNAfghPiUS56dMnGGdkEhkoy172ZvcJD2oPlfyQgX6AGB1Nsyd6760JISLcbHiRNf+F9HHQ
	WiolQZZCqSlLFDYSMzPP0TpZdq9PBmNdz2S5w8vvNYRlij4M5crRTlKijgOURjDajgakPOEHnS6
	MJDDBT9ulmVxzTrkpzBKGnnxSMXE46Rw==
X-Received: by 2002:a05:7301:2b07:b0:307:43ff:f32e with SMTP id 5a478bee46e88-3077b36f7b6mr430439eec.32.1780617027000;
        Thu, 04 Jun 2026 16:50:27 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::39a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm6224412eec.24.2026.06.04.16.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:50:26 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: libarena: parallel test harness and spmc parallel selftest
Date: Thu,  4 Jun 2026 19:50:16 -0400
Message-ID: <20260604235016.20856-4-emil@etsalapatis.com>
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
 .../selftests/test_parallel_spmc.bpf.c        | 664 ++++++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       | 157 +++++
 3 files changed, 827 insertions(+)
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
index 000000000000..a703479f478f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
@@ -0,0 +1,664 @@
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
+		if (test_abort)
+			return -EINTR;
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
+			return -EINTR;
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
+	if (ret == -EINTR)
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
+			if (test_abort)
+				return -EINTR;
+
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

