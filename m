Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959129;
	b=u3pgMmG8tVo+0zE1N/Eo9mN4V4v0YOMMJeuQiF+kzf0cL44gOTKHYpVul7DIVGUy+a9U
	 XO6B+Dh0YB4Fbcacd/SUZWOV6EceGghCsftFiWlKLcfIYdeRBRuIKsowW7DU+hvxCL/aj
	 jDUIVTYkC4z8om/dd6QndW6Ct+yU9Yn4zrmvDD2KULtEMRs8QEjlGsk+z/N7Gw4gdo+oU
	 KhafYZB4ckFtqO8FMiW/2rneDxfB9AcHpW53hYEC5viI+Va1VxV+4BJsonC+z9gN5hAvg
	 zo09iegS//LpbCQ+F9CKKyRsfzyeqNBNPff0cVKW5yAjwkNSDQedKEpbM4Nltka1AXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959129;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=+6tmkJDYTF5g6q6tdzrCWz2+zrrugUMX39/Us9yUCxE=;
	b=tLSCwh6m4nwW6RAtHJySLCWikULZUDDc56SdYNrEPaPtt8HSuR+7x7ZwkyMvoaj5YfZz
	 kV/nNo33w0NVt5tV4wydDBHjBE0istaEAKwy5ubexTel3NG+x4X8r98dhndJ5ofz5puRp
	 3N+w9XCUYAvjiBmnnxCdM5+VBuxOzuXO1RYVyp3u8k1u/u//woccPHNBxkvfX0hkNTsCz
	 ckwvB8HN1fSwHTw8Kly8YFfufduHPWg5NSH60ORoIvdggOVV0TujjW7rNGDuUeuxr38Zk
	 FOPP5l62ddEo2DA+u15Oa1Tkn6eerCa3htrsZiU6d/oY+VfzPimy3JNaoeNwfsTrEPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="NG1Lzm/E";
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0698606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0698606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NG1Lzm/E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+6
	tmkJDYTF5g6q6tdzrCWz2+zrrugUMX39/Us9yUCxE=; b=NG1Lzm/Epkxgoth/S1
	KVg1vo+4HUuIHoz/U1XaAHCEqYj8sldTl8Z26wcb81jp6h0+wNwjxIQuAXeAhlNc
	KH+EGjlA7janidP4yjiqL7bvoi1YRy3NAe8f0L/uhhFu+fIhBqh5Z30193Lar1p4
	Wd2L6HqDToGLWHf/2PMmGe9DU=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S9;
	Fri, 06 Nov 2026 17:58:01 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 7/8] bpf: Check bpf_timer value membership before use
Date: Fri,  6 Nov 2026 17:57:46 +0800
Message-ID: <20261106095747.471718-8-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106095747.471718-1-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S9
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cw4UJr4DuF1kWw15ZFyrZwb_yoW8Jw4fJo
	Z3urW5Ar1UGFyxWFyjk3s7KF13WFW8tFn8Ar1Y93yxXFW8CFyj9w17Gw47W34fZryrt3Z5
	Z3W5u3yxXFyfJF1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2CzuDUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wppOGrtpKrAmwAA3i

From: Yun Lu <luyun@kylinos.cn>

bpf_timer_init() can publish a new timer on a value retained across
deletion. The map can still have user references, so its usercnt check
does not reject the removed element. A later callback can outlive it:

  reader                       delete / reclamation     softirq
  retain value E
                               unlink E, cancel timer
  publish cb, set and arm
  leave read-side section
                               finish E's grace period
                                                        enter callback
                               cancel without waiting
                               free E
                                                        access E

The timer callback runs outside the waiting set of E's reclamation grace
period. Final cancellation does not wait for the running callback, and
keeping the timer's cb alive does not keep E alive.

Extend the shared init and setter membership checks to timers by removing
the WQ-only conditions. Look up the key after publication and compare the
returned pointer with cb->value: either deletion finds cb or lookup
rejects the removed value. Init cancels its local cb and returns -ENOENT
on mismatch. The setter returns -EINVAL, closing the window where another
CPU configures cb before init completes its checks.

Document the errors and update rhash_timer in the same commit. Its old
deleted-value init depended on allocator field preservation; require
-ENOENT instead and retain a live timer roundtrip. Normal cancellation
and restart of a linked timer are unchanged.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 include/uapi/linux/bpf.h                      |  5 +-
 kernel/bpf/helpers.c                          |  6 +-
 tools/include/uapi/linux/bpf.h                |  5 +-
 .../selftests/bpf/prog_tests/rhash_timer.c    | 98 ++++++++-----------
 .../testing/selftests/bpf/progs/rhash_timer.c | 94 +++++++++++-------
 5 files changed, 106 insertions(+), 102 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..46a102fc0834 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5468,6 +5468,8 @@ union bpf_attr {
  *		**-EBUSY** if *timer* is already initialized.
  *		**-EINVAL** if invalid *flags* are passed.
  *		**-EPERM** if *timer* is in a map that doesn't have any user references.
+ *		**-ENOENT** if the current map lookup does not return this value
+ *		when the membership check is reached.
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
  *		closed all timers in the map will be cancelled and freed.
@@ -5477,7 +5479,8 @@ union bpf_attr {
  *		Configure the timer to call *callback_fn* static function.
  *	Return
  *		0 on success.
- *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
+ *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier,
+ *		or if the value containing it is no longer linked in the map.
  *		**-EPERM** if *timer* is in a map that doesn't have any user references.
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7bcb66c92abd..7e91e8502a2e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1448,8 +1448,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		bpf_async_cancel_cb(async, cb);
 		return -EPERM;
 	}
-	if (type == BPF_ASYNC_TYPE_WQ &&
-	    !bpf_map_value_is_linked(map, cb->value)) {
+	if (!bpf_map_value_is_linked(map, cb->value)) {
 		bpf_async_cancel_cb(async, cb);
 		return -ENOENT;
 	}
@@ -1572,8 +1571,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		return -EINVAL;
 	if (!atomic64_read(&map->usercnt))
 		return -EPERM;
-	if (cb->type == BPF_ASYNC_TYPE_WQ &&
-	    !bpf_map_value_is_linked(map, cb->value))
+	if (!bpf_map_value_is_linked(map, cb->value))
 		return -EINVAL;
 
 	return bpf_async_update_prog_callback(cb, prog, callback_fn);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..46a102fc0834 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5468,6 +5468,8 @@ union bpf_attr {
  *		**-EBUSY** if *timer* is already initialized.
  *		**-EINVAL** if invalid *flags* are passed.
  *		**-EPERM** if *timer* is in a map that doesn't have any user references.
+ *		**-ENOENT** if the current map lookup does not return this value
+ *		when the membership check is reached.
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
  *		closed all timers in the map will be cancelled and freed.
@@ -5477,7 +5479,8 @@ union bpf_attr {
  *		Configure the timer to call *callback_fn* static function.
  *	Return
  *		0 on success.
- *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
+ *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier,
+ *		or if the value containing it is no longer linked in the map.
  *		**-EPERM** if *timer* is in a map that doesn't have any user references.
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
diff --git a/tools/testing/selftests/bpf/prog_tests/rhash_timer.c b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
index 3aad9fc02e06..a53275bc1175 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
@@ -6,9 +6,6 @@
 #include <test_progs.h>
 #include "rhash_timer.skel.h"
 
-#define MAX_ATTEMPTS 256
-#define RCU_SYNC_INTERVAL 64
-
 static int pin_to_first_cpu(cpu_set_t *old_mask)
 {
 	cpu_set_t new_mask;
@@ -52,10 +49,10 @@ void test_rhash_timer(void)
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct rhash_timer *skel = NULL;
 	cpu_set_t old_mask;
-	int map_fd = -1, arm_fd, cancel_fd;
+	int map_fd = -1, arm_del_fd, arm_live_fd, cancel_live_fd;
 	bool affinity_set = false;
-	__u64 key = 1;
-	int attempt, err;
+	__u64 key = 0, deadline;
+	int err;
 
 	err = pin_to_first_cpu(&old_mask);
 	if (!ASSERT_OK(err, "pin_to_first_cpu"))
@@ -69,69 +66,52 @@ void test_rhash_timer(void)
 	map_fd = bpf_map__fd(skel->maps.timer_map);
 	if (!ASSERT_GE(map_fd, 0, "timer_map fd"))
 		goto out;
-	arm_fd = bpf_program__fd(skel->progs.arm_deleted_timer);
-	if (!ASSERT_GE(arm_fd, 0, "arm_deleted_timer fd"))
+	arm_del_fd = bpf_program__fd(skel->progs.arm_deleted_timer);
+	if (!ASSERT_GE(arm_del_fd, 0, "arm_deleted_timer fd"))
 		goto out;
-	cancel_fd = bpf_program__fd(skel->progs.cancel_recycled_timer);
-	if (!ASSERT_GE(cancel_fd, 0, "cancel_recycled_timer fd"))
+	arm_live_fd = bpf_program__fd(skel->progs.live_arm_timer);
+	if (!ASSERT_GE(arm_live_fd, 0, "live_arm_timer fd"))
 		goto out;
-
-	err = update_timer_map(map_fd, key);
-	if (!ASSERT_OK(err, "seed_timer_map"))
+	cancel_live_fd = bpf_program__fd(skel->progs.cancel_live_timer);
+	if (!ASSERT_GE(cancel_live_fd, 0, "cancel_live_timer fd"))
 		goto out;
 
-	for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++) {
-		err = run_prog(arm_fd, &opts);
-		if (err) {
-			ASSERT_OK(err, "arm_deleted_timer");
-			goto out;
-		}
-		if (skel->bss->armed != attempt + 1) {
-			ASSERT_EQ(skel->bss->armed, attempt + 1, "armed");
-			goto out;
-		}
-		if (skel->bss->timer_init_err) {
-			ASSERT_OK(skel->bss->timer_init_err, "timer_init_err");
-			goto out;
-		}
-		if (skel->bss->timer_set_callback_err) {
-			ASSERT_OK(skel->bss->timer_set_callback_err,
-				  "timer_set_callback_err");
+	if (test__start_subtest("deleted_init_rejected")) {
+		err = update_timer_map(map_fd, key);
+		if (!ASSERT_OK(err, "seed_deleted"))
 			goto out;
-		}
-		if (skel->bss->timer_start_err) {
-			ASSERT_OK(skel->bss->timer_start_err, "timer_start_err");
+		err = run_prog(arm_del_fd, &opts);
+		if (!ASSERT_OK(err, "arm_deleted_timer"))
 			goto out;
-		}
-
-		if ((attempt + 1) % RCU_SYNC_INTERVAL == 0) {
-			err = kern_sync_rcu();
-			if (err) {
-				ASSERT_OK(err, "kern_sync_rcu");
-				goto out;
-			}
-		}
-
-		err = update_timer_map(map_fd, ++key);
-		if (err) {
-			ASSERT_OK(err, "replace_timer_map");
-			goto out;
-		}
+		ASSERT_EQ(skel->bss->timer_init_err, -ENOENT, "deleted_init_errno");
+	}
 
-		err = run_prog(cancel_fd, &opts);
-		if (err) {
-			ASSERT_OK(err, "cancel_recycled_timer");
+	if (test__start_subtest("live_timer_roundtrip")) {
+		err = update_timer_map(map_fd, key);
+		if (!ASSERT_OK(err, "seed_live"))
 			goto out;
-		}
-		if (skel->bss->timer_cancel_err) {
-			ASSERT_OK(skel->bss->timer_cancel_err, "timer_cancel_err");
+		err = run_prog(arm_live_fd, &opts);
+		if (!ASSERT_OK(err, "live_arm_timer"))
 			goto out;
-		}
-		if (skel->bss->cancelled)
-			break;
+		ASSERT_EQ(skel->bss->live_armed, 1, "live_armed");
+		ASSERT_EQ(skel->bss->live_init_err, 0, "live_init_err");
+		ASSERT_EQ(skel->bss->live_set_callback_err, 0,
+			  "live_set_callback_err");
+		ASSERT_EQ(skel->bss->live_start_err, 0, "live_start_err");
+
+		deadline = get_time_ns() + 2000000000ULL;
+		while (!__atomic_load_n(&skel->bss->live_cb_cnt, __ATOMIC_ACQUIRE) &&
+		       get_time_ns() < deadline)
+			usleep(1000);
+		ASSERT_GT(__atomic_load_n(&skel->bss->live_cb_cnt, __ATOMIC_ACQUIRE),
+			  0, "live_callback");
+
+		err = run_prog(cancel_live_fd, &opts);
+		if (!ASSERT_OK(err, "cancel_live_timer"))
+			goto out;
+		ASSERT_EQ(skel->bss->live_cancel_err, 0, "live_cancel_err");
+		ASSERT_GT(skel->bss->live_cancelled, 0, "live_cancelled");
 	}
-
-	ASSERT_GT(skel->bss->cancelled, 0, "preserved timer");
 out:
 	if (map_fd >= 0)
 		bpf_map_delete_elem(map_fd, &key);
diff --git a/tools/testing/selftests/bpf/progs/rhash_timer.c b/tools/testing/selftests/bpf/progs/rhash_timer.c
index 2e06a463c605..60793aa8b0fb 100644
--- a/tools/testing/selftests/bpf/progs/rhash_timer.c
+++ b/tools/testing/selftests/bpf/progs/rhash_timer.c
@@ -6,6 +6,7 @@
 
 #define CLOCK_MONOTONIC 1
 #define TIMER_NSEC (60ULL * 1000 * 1000 * 1000)
+#define LIVE_TIMER_NSEC 1000ULL
 
 struct timer_value {
 	struct bpf_timer timer;
@@ -20,18 +21,22 @@ struct {
 	__type(value, struct timer_value);
 } timer_map SEC(".maps");
 
-u64 armed;
-u64 cancelled;
+u64 live_armed;
+u64 live_cancelled;
+u64 live_cb_cnt;
 long timer_init_err;
-long timer_set_callback_err;
-long timer_start_err;
-long timer_cancel_err;
+long live_init_err;
+long live_set_callback_err;
+long live_start_err;
+long live_cancel_err;
 
 static int timer_cb(void *map, u64 *key, struct timer_value *value)
 {
+	__sync_fetch_and_add(&live_cb_cnt, 1);
 	return 0;
 }
 
+/* Initialize through a retained pointer after deleting the element. */
 static long arm_timer_cb(struct bpf_map *map, u64 *key,
 			 struct timer_value *value, void *ctx)
 {
@@ -43,55 +48,70 @@ static long arm_timer_cb(struct bpf_map *map, u64 *key,
 		return 1;
 
 	err = bpf_timer_init(&value->timer, map, CLOCK_MONOTONIC);
+	timer_init_err = err;
+	/* Do not configure or start the deleted value, even on an unfixed kernel. */
+	return 1;
+}
+
+SEC("syscall")
+int arm_deleted_timer(void *ctx)
+{
+	bpf_for_each_map_elem(&timer_map, arm_timer_cb, NULL, 0);
+	return 0;
+}
+
+/* Arm a live timer; the host waits for its callback before cancellation. */
+SEC("syscall")
+int live_arm_timer(void *ctx)
+{
+	struct timer_value *v;
+	u64 key = 0;
+	long err;
+
+	v = bpf_map_lookup_elem(&timer_map, &key);
+	if (!v)
+		return -EINVAL;
+
+	err = bpf_timer_init(&v->timer, &timer_map, CLOCK_MONOTONIC);
 	if (err) {
-		timer_init_err = err;
-		return 1;
+		live_init_err = err;
+		return err;
 	}
 
-	err = bpf_timer_set_callback(&value->timer, timer_cb);
+	err = bpf_timer_set_callback(&v->timer, timer_cb);
 	if (err) {
-		timer_set_callback_err = err;
-		return 1;
+		live_set_callback_err = err;
+		return err;
 	}
 
-	err = bpf_timer_start(&value->timer, TIMER_NSEC, BPF_F_TIMER_CPU_PIN);
+	err = bpf_timer_start(&v->timer, LIVE_TIMER_NSEC, 0);
 	if (err) {
-		timer_start_err = err;
-		return 1;
+		live_start_err = err;
+		return err;
 	}
 
-	__sync_fetch_and_add(&armed, 1);
-	return 1;
+	__sync_fetch_and_add(&live_armed, 1);
+	return 0;
 }
 
-static long cancel_timer_cb(struct bpf_map *map, u64 *key,
-			    struct timer_value *value, void *ctx)
+SEC("syscall")
+int cancel_live_timer(void *ctx)
 {
+	struct timer_value *v;
+	u64 key = 0;
 	long err;
 
-	err = bpf_timer_cancel(&value->timer);
-	if (err == -EINVAL)
-		return 1;
+	v = bpf_map_lookup_elem(&timer_map, &key);
+	if (!v)
+		return -EINVAL;
+
+	err = bpf_timer_cancel(&v->timer);
 	if (err < 0) {
-		timer_cancel_err = err;
-		return 1;
+		live_cancel_err = err;
+		return err;
 	}
 
-	__sync_fetch_and_add(&cancelled, 1);
-	return 1;
-}
-
-SEC("syscall")
-int arm_deleted_timer(void *ctx)
-{
-	bpf_for_each_map_elem(&timer_map, arm_timer_cb, NULL, 0);
-	return 0;
-}
-
-SEC("syscall")
-int cancel_recycled_timer(void *ctx)
-{
-	bpf_for_each_map_elem(&timer_map, cancel_timer_cb, NULL, 0);
+	__sync_fetch_and_add(&live_cancelled, 1);
 	return 0;
 }
 
-- 
2.43.0

