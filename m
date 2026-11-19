Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059110;
	b=AcnrRgRQXHnbzuZuxFK+Lv349TWjePknazQsi8lb9B0IRNSNHaU2vstfCZU2wLQvV6Ip
	 P6jMCYQ+lCWToHaLHOjd5YfzlxbG/faeGOb4DLCEUIGS79i6Wqa1yJwxYnZzfOhrxVPRC
	 USPbo0bO0HmxxI4+BH9HXMz22XwfUhOx53MlBc6FEpLWlTjHICoLqgrAluN9/vVnV+SNU
	 wFuVKt32qvxAljriAn8cmsNwZJOAJ7LgDy9qBvVOtSpttX8qua7hZxerDp6xxb2H7hpsJ
	 1xfAfpWDEf7vxQatLaxU9kGLfXiGjcOZm4MTte0EGDjrB8TaJa5FuLkn6BVVj8CDSPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059110;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=3FPKyBYFk8lcy3Z0WKdisCLfmQV/nc5CpqYBfY/L4GQ=;
	b=AAAk40wKY5bJRAK4w6UhvGH5ZqNyibr4b9L+4gpyeP6wH286Qkz42DanKiYG0sms5ztm
	 5YkBNFIV1cEweIjFzZLmSTffBsDrnAQScXTgIbZ5c+rtvMJ7pAP/MZPONuENSHIcGmwEI
	 o16cYAQ4ckCYnhU7DGcEycjwk/s/pIF3+1SoLMj68fMAYWom/MmC14ScK9ZaAhYkhvyhG
	 PyT75oO5fvAhQxCReWpUpARNFHXAf3Qds6B/OsnLBQPtfJM6Dfo4gGJOMda2AYPigwSfV
	 pHR6ncgqNguZ7zj0Ka1gYj08tGCmwrTCVB707mL0H1FCxI5t3lzv2gXsvF5uqRg4JMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NHe0B8DG;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC8606A32C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88DC8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NHe0B8DG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3F
	PKyBYFk8lcy3Z0WKdisCLfmQV/nc5CpqYBfY/L4GQ=; b=NHe0B8DGtvEHIrh5Cc
	7CEAZ6Es2SzW36OeYF8/RUHIVsnCic14DV5An/78yLR7/BcK73v0NvhRw5d1CPwa
	wC/Cx/Xl6wteac1MHyCg08c8a/0coVYiaOIi6Qh+xlZ3FkAHMY+QWIQIKxi1j3V4
	GQQH9ruHz9ivqKTHoZNPIUSFI=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Xzx1bf5qM8OwJA--.54798S7;
	Thu, 19 Nov 2026 11:31:08 +0800 (CST)
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
Subject: [PATCH bpf-next v4 5/6] bpf: Check async callback membership and user references
Date: Thu, 19 Nov 2026 11:30:50 +0800
Message-ID: <20261119033051.196177-6-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119033051.196177-1-luyun_611@163.com>
References: <20261119033051.196177-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wD3Xzx1bf5qM8OwJA--.54798S7
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWxtFy5tr1fWw13KFy7Awb_yoWfKFW5pa
	yfXry7Jr18XF42vr1Iqw4kCFyrXrs5Jry5GF9agr15ur42grn3JF1xKF15tFW3JrWkZFsa
	ya4Igr43Za4UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeuWLUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BzUo2r+bXwkCAAA3u

From: Yun Lu <luyun@kylinos.cn>

A BPF program can retain a value pointer across deletion, initialize a
new timer or workqueue object on it, and configure and start a callback.
That callback can run outside the grace period freeing the element and
access its freed key or value. Keeping the callback object alive does not
keep the element alive.

Check membership in __bpf_async_set_callback(), which installs cb->prog
and cb->callback_fn. Order the slot load before the lookup with a full
barrier. Return -ENOENT if the object was invalidated or the lookup no
longer returns cb->value.

An idle callback object can survive in an unlinked, cached element when
the last map user reference is released. A later insertion can reuse the
element and its callback object, so membership succeeds with usercnt at
zero. If the program holds a reference to the map, installing cb->prog
would form a reference cycle. The init-time usercnt check does not cover
this reuse. Reject it with -EPERM before taking a program reference.

The first smp_mb() orders the callback slot load before the lookup.
The second provides cumulative ordering between the observed insertion
and the usercnt read. A read barrier does not provide the cumulative
ordering needed here.

Leave __bpf_async_init() unchanged. An unconfigured object cannot start a
BPF callback. Document the setter errors and adjust rhash_timer to expect
-ENOENT while retaining its recycled timer-field check.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 include/uapi/linux/bpf.h                      |  2 ++
 kernel/bpf/helpers.c                          | 35 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  2 ++
 .../selftests/bpf/prog_tests/rhash_timer.c    | 24 +++++--------
 .../testing/selftests/bpf/progs/rhash_timer.c | 26 ++++----------
 5 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..0d0d56f87e09 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5478,6 +5478,8 @@ union bpf_attr {
  *	Return
  *		0 on success.
  *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
+ *		**-ENOENT** if the containing map element is no longer in the map
+ *		or the timer was invalidated by map cleanup.
  *		**-EPERM** if *timer* is in a map that doesn't have any user references.
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fa7e514ffd19..029f60b9e3df 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1552,11 +1552,34 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 				    struct bpf_prog *prog)
 {
 	struct bpf_async_cb *cb;
+	struct bpf_map *map;
 
 	cb = READ_ONCE(async->cb);
 	if (!cb)
 		return -EINVAL;
 
+	/*
+	 * The prog can still hold a value of an element that was deleted from the map.
+	 * bpf_async_cancel_and_free() is done with it and nothing stops a new callback
+	 * when the element is freed. cb is published at this point: either the lookup
+	 * doesn't find the element or bpf_async_cancel_and_free() finds cb.
+	 * Nothing runs without callback_fn. An idle cb stays in the element until the
+	 * element is reused or freed.
+	 */
+	smp_mb();
+	map = READ_ONCE(cb->map);
+	if (!map || !bpf_map_value_is_linked(map, cb->value))
+		return -ENOENT;
+	/*
+	 * Dropping the last user reference sets usercnt to zero before the cleanup walk.
+	 * The walk can miss a cached element that another CPU later reinserts. If our
+	 * lookup finds that element, the usercnt check must not see the old nonzero
+	 * count and allow a callback to be installed after cleanup.
+	 */
+	smp_mb();
+	if (!atomic64_read(&map->usercnt))
+		return -EPERM;
+
 	return bpf_async_update_prog_callback(cb, prog, callback_fn);
 }
 
@@ -3530,6 +3553,18 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	}
 }
 
+/**
+ * bpf_wq_set_callback - Set the callback of a BPF workqueue
+ * @wq: pointer to the bpf_wq field
+ * @callback_fn: callback function
+ * @flags: must be zero
+ * @aux: implicit program metadata
+ *
+ * Return: 0 on success, -EINVAL for invalid flags or an uninitialized @wq,
+ * -ENOENT if the containing map element is no longer in the map or the
+ * workqueue was invalidated by map cleanup, -EPERM if the map has no user
+ * references, or another negative error.
+ */
 __bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
 				    int (callback_fn)(void *map, int *key, void *value),
 				    unsigned int flags,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..0d0d56f87e09 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5478,6 +5478,8 @@ union bpf_attr {
  *	Return
  *		0 on success.
  *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
+ *		**-ENOENT** if the containing map element is no longer in the map
+ *		or the timer was invalidated by map cleanup.
  *		**-EPERM** if *timer* is in a map that doesn't have any user references.
  *		The user space should either hold a file descriptor to a map with timers
  *		or pin such map in bpffs. When map is unpinned or file descriptor is
diff --git a/tools/testing/selftests/bpf/prog_tests/rhash_timer.c b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
index 3aad9fc02e06..87287e038a98 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
@@ -52,7 +52,7 @@ void test_rhash_timer(void)
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct rhash_timer *skel = NULL;
 	cpu_set_t old_mask;
-	int map_fd = -1, arm_fd, cancel_fd;
+	int map_fd = -1, init_fd, cancel_fd;
 	bool affinity_set = false;
 	__u64 key = 1;
 	int attempt, err;
@@ -69,8 +69,8 @@ void test_rhash_timer(void)
 	map_fd = bpf_map__fd(skel->maps.timer_map);
 	if (!ASSERT_GE(map_fd, 0, "timer_map fd"))
 		goto out;
-	arm_fd = bpf_program__fd(skel->progs.arm_deleted_timer);
-	if (!ASSERT_GE(arm_fd, 0, "arm_deleted_timer fd"))
+	init_fd = bpf_program__fd(skel->progs.init_deleted_timer);
+	if (!ASSERT_GE(init_fd, 0, "init_deleted_timer fd"))
 		goto out;
 	cancel_fd = bpf_program__fd(skel->progs.cancel_recycled_timer);
 	if (!ASSERT_GE(cancel_fd, 0, "cancel_recycled_timer fd"))
@@ -81,28 +81,22 @@ void test_rhash_timer(void)
 		goto out;
 
 	for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++) {
-		err = run_prog(arm_fd, &opts);
+		err = run_prog(init_fd, &opts);
 		if (err) {
-			ASSERT_OK(err, "arm_deleted_timer");
+			ASSERT_OK(err, "init_deleted_timer");
 			goto out;
 		}
-		if (skel->bss->armed != attempt + 1) {
-			ASSERT_EQ(skel->bss->armed, attempt + 1, "armed");
+		if (skel->bss->initialized != attempt + 1) {
+			ASSERT_EQ(skel->bss->initialized, attempt + 1, "initialized");
 			goto out;
 		}
 		if (skel->bss->timer_init_err) {
 			ASSERT_OK(skel->bss->timer_init_err, "timer_init_err");
 			goto out;
 		}
-		if (skel->bss->timer_set_callback_err) {
-			ASSERT_OK(skel->bss->timer_set_callback_err,
-				  "timer_set_callback_err");
+		if (!ASSERT_EQ(skel->bss->timer_set_callback_err, -ENOENT,
+			       "deleted setter rejected"))
 			goto out;
-		}
-		if (skel->bss->timer_start_err) {
-			ASSERT_OK(skel->bss->timer_start_err, "timer_start_err");
-			goto out;
-		}
 
 		if ((attempt + 1) % RCU_SYNC_INTERVAL == 0) {
 			err = kern_sync_rcu();
diff --git a/tools/testing/selftests/bpf/progs/rhash_timer.c b/tools/testing/selftests/bpf/progs/rhash_timer.c
index 2e06a463c605..49bc3602fa12 100644
--- a/tools/testing/selftests/bpf/progs/rhash_timer.c
+++ b/tools/testing/selftests/bpf/progs/rhash_timer.c
@@ -5,7 +5,6 @@
 #include <bpf/bpf_helpers.h>
 
 #define CLOCK_MONOTONIC 1
-#define TIMER_NSEC (60ULL * 1000 * 1000 * 1000)
 
 struct timer_value {
 	struct bpf_timer timer;
@@ -20,11 +19,10 @@ struct {
 	__type(value, struct timer_value);
 } timer_map SEC(".maps");
 
-u64 armed;
+u64 initialized;
 u64 cancelled;
 long timer_init_err;
 long timer_set_callback_err;
-long timer_start_err;
 long timer_cancel_err;
 
 static int timer_cb(void *map, u64 *key, struct timer_value *value)
@@ -32,8 +30,8 @@ static int timer_cb(void *map, u64 *key, struct timer_value *value)
 	return 0;
 }
 
-static long arm_timer_cb(struct bpf_map *map, u64 *key,
-			 struct timer_value *value, void *ctx)
+static long init_timer_cb(struct bpf_map *map, u64 *key,
+			  struct timer_value *value, void *ctx)
 {
 	u64 key_copy = *key;
 	long err;
@@ -48,19 +46,9 @@ static long arm_timer_cb(struct bpf_map *map, u64 *key,
 		return 1;
 	}
 
-	err = bpf_timer_set_callback(&value->timer, timer_cb);
-	if (err) {
-		timer_set_callback_err = err;
-		return 1;
-	}
-
-	err = bpf_timer_start(&value->timer, TIMER_NSEC, BPF_F_TIMER_CPU_PIN);
-	if (err) {
-		timer_start_err = err;
-		return 1;
-	}
+	timer_set_callback_err = bpf_timer_set_callback(&value->timer, timer_cb);
 
-	__sync_fetch_and_add(&armed, 1);
+	__sync_fetch_and_add(&initialized, 1);
 	return 1;
 }
 
@@ -82,9 +70,9 @@ static long cancel_timer_cb(struct bpf_map *map, u64 *key,
 }
 
 SEC("syscall")
-int arm_deleted_timer(void *ctx)
+int init_deleted_timer(void *ctx)
 {
-	bpf_for_each_map_elem(&timer_map, arm_timer_cb, NULL, 0);
+	bpf_for_each_map_elem(&timer_map, init_timer_cb, NULL, 0);
 	return 0;
 }
 
-- 
2.43.0

