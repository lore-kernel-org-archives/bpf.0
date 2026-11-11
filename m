Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365087;
	b=CfFOB8EAcCUcEHdes8f9NTtf0obGVS2q8zZTzXiJ7zaNBA4WsIgQQ5k3CJ1Nt3RQxvfS
	 HG9xYj2/yyR3vilHYK2ZG97OwaKFKhMrT8WW0WSboOBOCCMD5eNDqp8m/hg44KSeJZP70
	 O/4uyegI8TNpVhzmAV7HZ0imdt/vQqBua+9xqiZH0sfF+2HyHoEiFhBur5E2fyBL9z7gT
	 +1VE6WAX8ufkT1B3nd0t853UX2eAx4HO2yWNiSNKu11YKREqikzbxU/M9AZhK/w+Jgs8C
	 1v0yMQNKxv376qTPxAhHZRPg19xfCwZ/hO+tupSfLEx7qdVwV5MuOqNZFf3h+8Ybqcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365087;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Losz4g+y7NGr/MD2ahAHH3w+6XTp7SyulDblUEFDI4A=;
	b=iwrUSoSh7jiPZMX5i9WhnKDabC29cERKF7/BG2Gj8PfIUE2I4N8yyYvDNSX+HkHip1JS
	 TtBYeRxDdB+tNCaU2sIrxcxzmyp398q72s/B9Fu/6IcIJLxPVVxXFWGe4rgMRYwsrYqxh
	 SYWgeh4t/tg38BmH+77kioPzx3ho1V2abH6+EWhSTcNIvTLMej9E3U7H7qVw7f5+euOqQ
	 HfkTrq26u69dDKBRgNmAHYVzUQMQt3u7qh0kk07XQ4jC42sF61DKCthXwX85bmomp9vsq
	 PPIrcWx87YKHcDrlSNbOHCgu9I66YSAM2Mj1JUP/0TgsFnoFMxP09u+TjnNrkEZBezw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fJ5w5jmI;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955D606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1955D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fJ5w5jmI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lo
	sz4g+y7NGr/MD2ahAHH3w+6XTp7SyulDblUEFDI4A=; b=fJ5w5jmILzDnxGBMXb
	6gQUBcrDKXWry/Ol6UUjN1H/9pGIjFlT9jsZ5Hhz7uCSBsUjyIzmr9Dobevo/TVx
	iiTVVZAFr0CiQ/toqLXqPL0Ig72f7m/U0nWQqi88jH6MNG8sJ1INhsW7ssskm9jx
	SaI23oXu6IiTyBfGC1ORCgBCU=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgpq1vNqdIGjEw--.26036S7;
	Wed, 11 Nov 2026 10:43:58 +0800 (CST)
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
Subject: [PATCH bpf-next v3 5/6] bpf: Check async callback value membership in the setter
Date: Wed, 11 Nov 2026 10:43:32 +0800
Message-ID: <20261111024333.228633-6-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111024333.228633-1-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
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
X-CM-TRANSID:PSgvCgBXCgpq1vNqdIGjEw--.26036S7
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFW3uFyrCr4DCr1rXFyftFb_yoWfGFWrpa
	yfXry7Jr48XF47Zr1xtw4kCFyrXrs5XryUGF93Kr15CrnF9r97JF1IkF15tFW3JrWvvFsa
	ya4Igr43Aa4UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jexRhUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6w5oN2rz1m5Y4AAA3j

From: Yun Lu <luyun@kylinos.cn>

A BPF program can retain a value pointer across deletion, initialize a
new timer or workqueue object on it, and configure and start a callback.
That callback can run outside the grace period freeing the element and
access its freed key or value. Keeping the callback object alive does not
keep the element alive.

Only __bpf_async_set_callback() installs cb->prog and cb->callback_fn.
Check membership once there, ordering the slot load before the lookup
with a full barrier. Return -ENOENT if the object was invalidated or the
lookup no longer returns cb->value.

Leave __bpf_async_init() unchanged. The start helpers reject an object
without a program, so a rejected, newly initialized object stays idle
until normal cleanup. Document the setter error and adjust rhash_timer
to expect -ENOENT while retaining its recycled timer-field check.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
 include/uapi/linux/bpf.h                      |   2 ++
 kernel/bpf/helpers.c                          |  25 ++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |   2 ++
 ...ing/selftests/bpf/prog_tests/rhash_timer.c |  24 +++++++++--------------
 .../testing/selftests/bpf/progs/rhash_timer.c |  26 +++++++------------------
 5 files changed, 45 insertions(+), 34 deletions(-)

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
index 716be7a852b5..9fa75bcd5e77 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1552,11 +1552,25 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
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
+
 	return bpf_async_update_prog_callback(cb, prog, callback_fn);
 }
 
@@ -3530,6 +3544,17 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
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
+ * workqueue was invalidated by map cleanup, or another negative error.
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

