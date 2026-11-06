Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959133;
	b=EGne/nqUDPWp1hNk67q2ejrs+qgXTY4H93ZvZCoVsjp6emDb4qHX9Yb/9b55Wij1kqnB
	 UesRzqqRduSBMAfGAOeX+9Vdc1vRHpDH4NEbf9sdPP7Q+LkGpJUyLmnjt1bhpbdYhW1DI
	 dFHzgLwcMsZZOjRqdDD53vGMvjF0m1FVEbIaWvjo9rnyws1Qjpl6W4pe3Ic2XXWayaiD5
	 CayFUP1h7Rmnt+nGrGpH4XdR5o+RxbIYzetfwt/Yh4TFUWH/TUj5nz1Bn1j+DnewVkhm0
	 W18ktKxQi30Q/x2JvKreogazzSY9e6t35HggYR4RtJNN24bfXGtHXnEwaNx5ooCWvfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=1kWbH5hW7jhWHC0YirGiVBt8LpGKkEF6ALimuMPXNfU=;
	b=zRk3v4hCjZGhVFkvOJ5M0GzchXoN+yONnZFrhhZsnze9I8ragH5TY53jR8FTAKYuWs0h
	 LEIZjcQNoNEHznwTqbyDbK/P/HG2w2tuo6KffO8/szBroKBYY+BR7/P9JnGbyriy+yRaT
	 2s/9YPDNN1B7uMm7ouQSsNVCRo/J6M2J7W9XkkkWX//v2iZfG+UUSr5wCGnUNBGfIyStW
	 riKh5e+KYhaiPd2gp6tKmI0Onq5kJ6ofw5Sz9kOkdrewnVu/5AhCUt0e87bXX2OWbgr7c
	 03/8G6OH+NS0lqim8nBd0cEkNKGnohymXTfRPaH6aaVetuIiv7Q/H5zDwEubBFNjB7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hjxyja8O;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3025606A33A
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3025606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hjxyja8O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1k
	WbH5hW7jhWHC0YirGiVBt8LpGKkEF6ALimuMPXNfU=; b=hjxyja8OJeDS3Y7KXy
	wJMT4jxo+eU6mVvafmCBXHk2ZIiAQzYVrChm2LFr6OhxBBe4iYaLvTcANk/7noIl
	PGvlNq1LWMeKjzDiwitnO9k4WnF8Rrx8gli/Icsm2gmjv4Q+LloqtzXH61SNfP4X
	7bDnsyI5yltchTtaf76Mh9suM=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S6;
	Fri, 06 Nov 2026 17:58:00 +0800 (CST)
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
Subject: [PATCH bpf-next v2 4/8] bpf: Order async callback admission and cancellation
Date: Fri,  6 Nov 2026 17:57:43 +0800
Message-ID: <20261106095747.471718-5-luyun_611@163.com>
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
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArWDZry5Kw4fGFWUJw1rtFb_yoWxCr1rpF
	43XFyakr4UWFs7Zwsaya1rC3WrArZ3Xa13Gr98G34SyrZ0qr1qyFyfWFyIyFZ8Zr48A3W2
	v3W8Kay3Wr1xC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5dbbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6whpOGrtpKjAUgAA3r

From: Yun Lu <luyun@kylinos.cn>

The shared wq/timer cancellation detaches cb before clearing cb->map.
Another canceller can observe the empty slot and return while that
callback object still allows the BPF callback to start:

  canceller A                  canceller B             callback
  xchg(slot, NULL) gets C
                               reads NULL, returns
                                                       reads C->map
                                                       calls BPF program
  WRITE_ONCE(C->map, NULL)

Clear cb->map before conditionally detaching cb. Only the successful
detacher clears fn/prog and consumes the map-owned reference. Keep cb
alive under regular RCU while the cancellers compete. Order unlink or
the last-user-reference drop before the slot read, including NULL, and
use an acquire load to observe the invalidation preceding another
canceller's detach.

Init failure currently rereads the slot to cancel it. Another canceller
may already have removed that init's cb and a new init may have installed
a replacement. Cancel the local cb instead, so failed cleanup cannot
terminate the replacement or consume its reference.

Publication also precedes init's usercnt check. A setter on another CPU
can otherwise configure cb before init rejects the last-user-reference
drop. Check cb->map and usercnt in the setter, returning -EINVAL for an
invalidated cb and -EPERM for zero usercnt. A full barrier orders these
checks after the publication observed by the setter, even when init ran
on a third CPU.

A setter that passed the checks can still race with cancellation. It
cannot restore cb->map, so the existing callback NULL check and read-side
protection continue to handle late fn/prog updates. Membership checks
for deleted values follow separately.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 77 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a2c199aed893..1227debd3e8a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1374,7 +1374,8 @@ static void bpf_async_refcount_put(struct bpf_async_cb *cb)
 	}
 }
 
-static void bpf_async_cancel_and_free(struct bpf_async_kern *async);
+static void bpf_async_cancel_cb(struct bpf_async_kern *async,
+				struct bpf_async_cb *cb);
 static void bpf_async_irq_worker(struct irq_work *work);
 
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
@@ -1436,17 +1437,15 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		kfree_nolock(cb);
 		return -EBUSY;
 	}
-	/* Guarantee the order between async->cb and map->usercnt. So
-	 * when there are concurrent uref release and bpf timer init, either
-	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
-	 * timer or atomic64_read() below returns a zero usercnt.
+	/*
+	 * Pair with uref cancellation: it sees cb or init sees usercnt=0.
 	 */
 	smp_mb();
 	if (!atomic64_read(&map->usercnt)) {
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		bpf_async_cancel_and_free(async);
+		bpf_async_cancel_cb(async, cb);
 		return -EPERM;
 	}
 
@@ -1553,10 +1552,21 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 				    struct bpf_prog *prog)
 {
 	struct bpf_async_cb *cb;
+	struct bpf_map *map;
 
 	cb = READ_ONCE(async->cb);
 	if (!cb)
 		return -EINVAL;
+	/*
+	 * Pair with cancellation even if another CPU published cb and has
+	 * not finished its init checks.
+	 */
+	smp_mb();
+	map = READ_ONCE(cb->map);
+	if (!map)
+		return -EINVAL;
+	if (!atomic64_read(&map->usercnt))
+		return -EPERM;
 
 	return bpf_async_update_prog_callback(cb, prog, callback_fn);
 }
@@ -1744,19 +1754,16 @@ static void bpf_async_irq_worker(struct irq_work *work)
 	this_cpu_write(async_cb_running, NULL);
 }
 
-static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
+/* The caller's read-side section must keep cb alive. */
+static void bpf_async_cancel_cb(struct bpf_async_kern *async,
+				struct bpf_async_cb *cb)
 {
-	struct bpf_async_cb *cb;
-
-	if (!READ_ONCE(async->cb))
-		return;
-
-	cb = xchg(&async->cb, NULL);
-	if (!cb)
+	/* Make cb unusable before detaching it. */
+	WRITE_ONCE(cb->map, NULL);
+	/* Only the successful detacher consumes the slot's reference. */
+	if (cmpxchg(&async->cb, cb, NULL) != cb)
 		return;
 
-	/* Callbacks that run after this see NULL and return. */
-	WRITE_ONCE(cb->map, NULL);
 	bpf_async_update_prog_callback(cb, NULL, NULL);
 	/*
 	 * No refcount_inc_not_zero(&cb->refcnt) here. Dropping the last
@@ -1776,6 +1783,19 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 	}
 }
 
+static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
+{
+	struct bpf_async_cb *cb;
+
+	guard(rcu)();
+	/* Order unlink/uref release before the slot read, including NULL. */
+	smp_mb();
+	/* Pair with the detach following cb->map = NULL. */
+	cb = smp_load_acquire(&async->cb);
+	if (cb)
+		bpf_async_cancel_cb(async, cb);
+}
+
 /*
  * This function is called by map_delete/update_elem for individual element and
  * by ops->map_release_uref when the user space reference to a map reaches zero.
@@ -3490,6 +3510,18 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+/**
+ * bpf_wq_init - Initialize a bpf_wq inside a map value.
+ * @wq: pointer to the bpf_wq field
+ * @p__const_map: the map containing @wq
+ * @flags: must be zero
+ *
+ * Success does not prevent concurrent cancellation.
+ *
+ * Return: 0 on success; -EINVAL for invalid flags; -EBUSY if already
+ * initialized; -ENOMEM on allocation failure; -EPERM if the map has no user
+ * reference.
+ */
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsigned int flags)
 {
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
@@ -3528,6 +3560,19 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	}
 }
 
+/**
+ * bpf_wq_set_callback - Configure the callback of a bpf_wq.
+ * @wq: pointer to the bpf_wq field
+ * @callback_fn: callback function
+ * @flags: must be zero
+ * @aux: implicit program argument
+ *
+ * Success does not prevent concurrent cancellation.
+ *
+ * Return: 0 on success; -EINVAL for invalid flags, if @wq was not initialized,
+ * or if its containing value was already invalidated; -EPERM if the map has
+ * no user references.
+ */
 __bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
 				    int (callback_fn)(void *map, int *key, void *value),
 				    unsigned int flags,
-- 
2.43.0

