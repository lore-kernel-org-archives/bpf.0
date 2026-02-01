Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D093EBF1F
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914451; cv=none; b=LI3aTkihLB2N4lbfFs6SF0SHimyUUDCukLa+IUFFl0iUsf2JRm9QIi207Gr8AYoAC3MXtjFAiNjwlvDYYhkyWVwuJEOJ3Qq1eWbhfeYX+GLMrPX32SsliG7cY1zqMYWwctAH0Zcgdi0qdpKEnALo8OHc8+W0Q6WoPzyfICTXRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914451; c=relaxed/simple;
	bh=JPOz4zHMpLMrod7NVD2Kv+vJU9gIDg7gbvIGmC9PZ68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laMav2P4isIcwoepDXGVsys8MgLCEEIm3NAlUbslCUBCdAWXOiK8pBZ+VEaBjFTp4zenzHdkQjwd6p91avZxkpF53DJGnd1tQSKRAd0Mel/JkWem/e4A8PcUaze5k+AyRbhiDTAktjJM9I1c14cI5bkG4m7+6rMTKOADheOl5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5Z/++pe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5Z/++pe"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f2676bb21so30866905ad.0
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914449; x=1770519249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWZI966aNXU/gEInQMovoyBTKaayu7U0DIgzeQuSiI0=;
        b=b5Z/++pe3A6Ev1pZ/5PniPKydLwEsY7ZOViCrtnKFnxqRvI66BnZAyLgJQIjGv8Z0k
         ZQhzc0y7lR6qbA2mH729LIpSCdBLfqW0wmJltQ2leWCfflNzMbeXqNFMXqBHwV55ZVri
         Iz541tPgDPjXZKKeJewkntIfAjF6O9gdraRpxNiS54hju28UgN2CKCkIIJUD8Qa9fIT3
         ShG1OXghBqhvj/janGaK6Hk5OmvZxCa+FSEC0os5JKTdcZVxN+hPY3GJp05OqCFFbg+y
         /SMrPmsNH5WQRNTRqL1gjLgfRC3WS0oCcSAiEv6rorWsovwOrfw0acyhwnmNYwYcUZK1
         oJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914449; x=1770519249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWZI966aNXU/gEInQMovoyBTKaayu7U0DIgzeQuSiI0=;
        b=W8utlOvWhqW2NPNfHwg2IidKzoiGT/wbwHfVhBFDBtEGSHY2CqkAH8XHfACko7pt2A
         G/yKTN2H89laYJJkpKB34AmFL2a63sgZxd2xeJUgDdDVsiAjAtmylAZNppl1ocsNNehh
         3X2yOt72k0+82mbnr/N7oK+nZxgxJEVhhON6PBMpPVDSF/FV4fJElpV2DwJ1FDVWkO3T
         5Ej2JNVC1Mb/o5oPtMnjP85E3XEjGx5RPM7jlmQq5EohIKYl9O673vPW1LZWcer6wJN9
         kY4S1xdBFvyNi0+SworwntSnEd+OdZUAe6MU9EKzPxr78+hoxiWW10YulqTTAEugWnNp
         tvEw==
X-Gm-Message-State: AOJu0YxrGSy+M8cbaHCoJWNGGDXMzUOuR1W/WxU4vCQLgXrGe7SOZ1Fd
	OCQNxlLTnagvJusiFtwGabqNIaa6h6580YyYMXd5a53TCZVCgG3KhGH9pBe12g==
X-Gm-Gg: AZuq6aI81+SkladqsM6PrbdX6zEf2v2LHz4AkSp75RGUpc1Cc0t6tj9xsbPaXNBDMiP
	8tnYr2loib1yy00qhOXpbYNVQbHWXRctDz0aWjYuwfaQ63iDzBVEfswlGCatpQ5nTEmCs8jwp0/
	0RyJB3NBlSOtOv/N7e+9aQNusw+Tzl0jAp/trOI4A1Fc4j+6BDCWwW6IT8k1t7jZorLc0Ppndx3
	rAAQ7yGs5yqX7eItfytDPcmnBVJHRQ/Yos/A9OEJPAPCdqdLcp6PeAZnVVsouzsArIYw+1QsDQk
	0rZOxAAr12h8y/1gZpjkqYe4dN/oW7102DUOkdt1TBGaT4rOy3bQqrRYTMm+FAkNR3ySSr4JugV
	jFYAZbeTDgipzVqwsEgDCR8j9aklHcZ+jkkVM/Df1h9xI8FutnTgDGKrYpIaFGyZ6TUw3DWILeY
	5pEdmwh4Rl4yvBFD5kPgUJns4t+qnG1GYGpuyOz5WyPAhJPAsXSiUjE8vRp+dPuBerV8mbzmbTJ
	Cg0B0PGp/NoaNtS4R9PUeki+i13qwwmvvBJjQMvz+AoPlYyXg==
X-Received: by 2002:a17:903:1b46:b0:2a7:a6fa:ede4 with SMTP id d9443c01a7336-2a8d993d4e2mr82440755ad.48.1769914448539;
        Sat, 31 Jan 2026 18:54:08 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef44sm113960175ad.11.2026.01.31.18.54.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 1/9] bpf: Enable bpf_timer and bpf_wq in any context
Date: Sat, 31 Jan 2026 18:53:55 -0800
Message-ID: <20260201025403.66625-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Refactor bpf_timer and bpf_wq to allow calling them from any context:
- add refcnt to bpf_async_cb
- map_delete_elem or map_free will drop refcnt to zero
  via bpf_async_cancel_and_free()
- once refcnt is zero timer/wq_start is not allowed to make sure
  that callback cannot rearm itself
- if in_hardirq defer to start/cancel operations to irq_work

Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 408 ++++++++++++++++++++++++-------------------
 1 file changed, 225 insertions(+), 183 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b54ec0e945aa..2eb262d52232 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1095,16 +1095,34 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+enum bpf_async_type {
+	BPF_ASYNC_TYPE_TIMER = 0,
+	BPF_ASYNC_TYPE_WQ,
+};
+
+enum bpf_async_op {
+	BPF_ASYNC_START,
+	BPF_ASYNC_CANCEL
+};
+
+struct bpf_async_cmd {
+	struct llist_node node;
+	u64 nsec;
+	u32 mode;
+	enum bpf_async_op op;
+};
+
 struct bpf_async_cb {
 	struct bpf_map *map;
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
-	union {
-		struct rcu_head rcu;
-		struct work_struct delete_work;
-	};
+	struct rcu_head rcu;
 	u64 flags;
+	struct irq_work worker;
+	refcount_t refcnt;
+	enum bpf_async_type type;
+	struct llist_head async_cmds;
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
@@ -1132,7 +1150,6 @@ struct bpf_hrtimer {
 struct bpf_work {
 	struct bpf_async_cb cb;
 	struct work_struct work;
-	struct work_struct delete_work;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer and bpf_wq */
@@ -1142,20 +1159,12 @@ struct bpf_async_kern {
 		struct bpf_hrtimer *timer;
 		struct bpf_work *work;
 	};
-	/* bpf_spin_lock is used here instead of spinlock_t to make
-	 * sure that it always fits into space reserved by struct bpf_timer
-	 * regardless of LOCKDEP and spinlock debug flags.
-	 */
-	struct bpf_spin_lock lock;
 } __attribute__((aligned(8)));
 
-enum bpf_async_type {
-	BPF_ASYNC_TYPE_TIMER = 0,
-	BPF_ASYNC_TYPE_WQ,
-};
-
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
+static void bpf_async_refcount_put(struct bpf_async_cb *cb);
+
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
@@ -1219,45 +1228,73 @@ static void bpf_async_cb_rcu_free(struct rcu_head *rcu)
 {
 	struct bpf_async_cb *cb = container_of(rcu, struct bpf_async_cb, rcu);
 
+	/*
+	 * Drop the last reference to prog only after RCU GP, as set_callback()
+	 * may race with cancel_and_free()
+	 */
+	if (cb->prog)
+		bpf_prog_put(cb->prog);
+
 	kfree_nolock(cb);
 }
 
-static void bpf_wq_delete_work(struct work_struct *work)
+/* Callback from call_rcu_tasks_trace, chains to call_rcu for final free */
+static void bpf_async_cb_rcu_tasks_trace_free(struct rcu_head *rcu)
 {
-	struct bpf_work *w = container_of(work, struct bpf_work, delete_work);
+	struct bpf_async_cb *cb = container_of(rcu, struct bpf_async_cb, rcu);
+	struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
+	struct bpf_work *w = container_of(cb, struct bpf_work, cb);
+	bool retry = false;
 
-	cancel_work_sync(&w->work);
+	/*
+	 * bpf_async_cancel_and_free() tried to cancel timer/wq, but it
+	 * could have raced with timer/wq_start. Now refcnt is zero and
+	 * srcu/rcu GP completed. Cancel timer/wq again.
+	 */
+	switch (cb->type) {
+	case BPF_ASYNC_TYPE_TIMER:
+		if (hrtimer_try_to_cancel(&t->timer) < 0)
+			retry = true;
+		break;
+	case BPF_ASYNC_TYPE_WQ:
+		if (!cancel_work(&w->work))
+			retry = true;
+		break;
+	}
+	if (retry) {
+		/*
+		 * hrtimer or wq callback may still be running. It must be
+		 * in rcu_tasks_trace or rcu CS, so wait for GP again.
+		 * It won't retry forever, since refcnt zero prevents all
+		 * operations on timer/wq.
+		 */
+		call_rcu_tasks_trace(&cb->rcu, bpf_async_cb_rcu_tasks_trace_free);
+		return;
+	}
 
-	call_rcu(&w->cb.rcu, bpf_async_cb_rcu_free);
+	/* rcu_trace_implies_rcu_gp() is true and will remain so */
+	bpf_async_cb_rcu_free(rcu);
 }
 
-static void bpf_timer_delete_work(struct work_struct *work)
+static void bpf_async_refcount_put(struct bpf_async_cb *cb)
 {
-	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, cb.delete_work);
+	if (!refcount_dec_and_test(&cb->refcnt))
+		return;
 
-	/* Cancel the timer and wait for callback to complete if it was running.
-	 * If hrtimer_cancel() can be safely called it's safe to call
-	 * call_rcu() right after for both preallocated and non-preallocated
-	 * maps.  The async->cb = NULL was already done and no code path can see
-	 * address 't' anymore. Timer if armed for existing bpf_hrtimer before
-	 * bpf_timer_cancel_and_free will have been cancelled.
-	 */
-	hrtimer_cancel(&t->timer);
-	call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
+	call_rcu_tasks_trace(&cb->rcu, bpf_async_cb_rcu_tasks_trace_free);
 }
 
+static void bpf_async_cancel_and_free(struct bpf_async_kern *async);
+static void bpf_async_irq_worker(struct irq_work *work);
+
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
 			    enum bpf_async_type type)
 {
-	struct bpf_async_cb *cb;
+	struct bpf_async_cb *cb, *old_cb;
 	struct bpf_hrtimer *t;
 	struct bpf_work *w;
 	clockid_t clockid;
 	size_t size;
-	int ret = 0;
-
-	if (in_nmi())
-		return -EOPNOTSUPP;
 
 	switch (type) {
 	case BPF_ASYNC_TYPE_TIMER:
@@ -1270,18 +1307,13 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		return -EINVAL;
 	}
 
-	__bpf_spin_lock_irqsave(&async->lock);
-	t = async->timer;
-	if (t) {
-		ret = -EBUSY;
-		goto out;
-	}
+	old_cb = READ_ONCE(async->cb);
+	if (old_cb)
+		return -EBUSY;
 
 	cb = bpf_map_kmalloc_nolock(map, size, 0, map->numa_node);
-	if (!cb) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!cb)
+		return -ENOMEM;
 
 	switch (type) {
 	case BPF_ASYNC_TYPE_TIMER:
@@ -1289,7 +1321,6 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		t = (struct bpf_hrtimer *)cb;
 
 		atomic_set(&t->cancelling, 0);
-		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
 		hrtimer_setup(&t->timer, bpf_timer_cb, clockid, HRTIMER_MODE_REL_SOFT);
 		cb->value = (void *)async - map->record->timer_off;
 		break;
@@ -1297,16 +1328,24 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		w = (struct bpf_work *)cb;
 
 		INIT_WORK(&w->work, bpf_wq_work);
-		INIT_WORK(&w->delete_work, bpf_wq_delete_work);
 		cb->value = (void *)async - map->record->wq_off;
 		break;
 	}
 	cb->map = map;
 	cb->prog = NULL;
 	cb->flags = flags;
+	cb->worker = IRQ_WORK_INIT(bpf_async_irq_worker);
+	init_llist_head(&cb->async_cmds);
+	refcount_set(&cb->refcnt, 1); /* map's reference */
+	cb->type = type;
 	rcu_assign_pointer(cb->callback_fn, NULL);
 
-	WRITE_ONCE(async->cb, cb);
+	old_cb = cmpxchg(&async->cb, NULL, cb);
+	if (old_cb) {
+		/* Lost the race to initialize this bpf_async_kern, drop the allocated object */
+		kfree_nolock(cb);
+		return -EBUSY;
+	}
 	/* Guarantee the order between async->cb and map->usercnt. So
 	 * when there are concurrent uref release and bpf timer init, either
 	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
@@ -1317,13 +1356,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		WRITE_ONCE(async->cb, NULL);
-		kfree_nolock(cb);
-		ret = -EPERM;
+		bpf_async_cancel_and_free(async);
+		return -EPERM;
 	}
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+
+	return 0;
 }
 
 BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
@@ -1354,8 +1391,9 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callback_fn,
-					  struct bpf_prog *prog)
+static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
+					  struct bpf_prog *prog,
+					  void *callback_fn)
 {
 	struct bpf_prog *prev;
 
@@ -1380,7 +1418,8 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callbac
 		if (prev)
 			bpf_prog_put(prev);
 
-	} while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
+	} while (READ_ONCE(cb->prog) != prog ||
+		 (void __force *)READ_ONCE(cb->callback_fn) != callback_fn);
 
 	if (prog)
 		bpf_prog_put(prog);
@@ -1388,33 +1427,36 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callbac
 	return 0;
 }
 
+static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
+				 u64 nsec, u32 timer_mode)
+{
+	WARN_ON_ONCE(!in_hardirq());
+
+	struct bpf_async_cmd *cmd = kmalloc_nolock(sizeof(*cmd), 0, NUMA_NO_NODE);
+
+	if (!cmd) {
+		bpf_async_refcount_put(cb);
+		return -ENOMEM;
+	}
+	init_llist_node(&cmd->node);
+	cmd->nsec = nsec;
+	cmd->mode = timer_mode;
+	cmd->op = op;
+	if (llist_add(&cmd->node, &cb->async_cmds))
+		irq_work_queue(&cb->worker);
+	return 0;
+}
+
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
 				    struct bpf_prog *prog)
 {
 	struct bpf_async_cb *cb;
-	int ret = 0;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
-	__bpf_spin_lock_irqsave(&async->lock);
-	cb = async->cb;
-	if (!cb) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (!atomic64_read(&cb->map->usercnt)) {
-		/* maps with timers must be either held by user space
-		 * or pinned in bpffs. Otherwise timer might still be
-		 * running even when bpf prog is detached and user space
-		 * is gone, since map_release_uref won't ever be called.
-		 */
-		ret = -EPERM;
-		goto out;
-	}
-	ret = bpf_async_update_prog_callback(cb, callback_fn, prog);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_update_prog_callback(cb, prog, callback_fn);
 }
 
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
@@ -1431,22 +1473,17 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
-BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
+BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
-	int ret = 0;
-	enum hrtimer_mode mode;
+	u32 mode;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
 	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
 		return -EINVAL;
-	__bpf_spin_lock_irqsave(&timer->lock);
-	t = timer->timer;
-	if (!t || !t->cb.prog) {
-		ret = -EINVAL;
-		goto out;
-	}
+
+	t = READ_ONCE(async->timer);
+	if (!t || !READ_ONCE(t->cb.prog))
+		return -EINVAL;
 
 	if (flags & BPF_F_TIMER_ABS)
 		mode = HRTIMER_MODE_ABS_SOFT;
@@ -1456,10 +1493,20 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 	if (flags & BPF_F_TIMER_CPU_PIN)
 		mode |= HRTIMER_MODE_PINNED;
 
-	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
-	return ret;
+	/*
+	 * bpf_async_cancel_and_free() could have dropped refcnt to zero. In
+	 * such case BPF progs are not allowed to arm the timer to prevent UAF.
+	 */
+	if (!refcount_inc_not_zero(&t->cb.refcnt))
+		return -ENOENT;
+
+	if (!in_hardirq()) {
+		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
+		bpf_async_refcount_put(&t->cb);
+		return 0;
+	} else {
+		return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);
+	}
 }
 
 static const struct bpf_func_proto bpf_timer_start_proto = {
@@ -1477,11 +1524,9 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 	bool inc = false;
 	int ret = 0;
 
-	if (in_nmi())
+	if (in_hardirq())
 		return -EOPNOTSUPP;
 
-	guard(rcu)();
-
 	t = READ_ONCE(async->timer);
 	if (!t)
 		return -EINVAL;
@@ -1536,78 +1581,85 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
 	.arg1_type	= ARG_PTR_TO_TIMER,
 };
 
-static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
+static void bpf_async_process_op(struct bpf_async_cb *cb, u32 op,
+				 u64 timer_nsec, u32 timer_mode)
+{
+	switch (cb->type) {
+	case BPF_ASYNC_TYPE_TIMER: {
+		struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
+
+		switch (op) {
+		case BPF_ASYNC_START:
+			hrtimer_start(&t->timer, ns_to_ktime(timer_nsec), timer_mode);
+			break;
+		case BPF_ASYNC_CANCEL:
+			hrtimer_try_to_cancel(&t->timer);
+			break;
+		}
+		break;
+	}
+	case BPF_ASYNC_TYPE_WQ: {
+		struct bpf_work *w = container_of(cb, struct bpf_work, cb);
+
+		switch (op) {
+		case BPF_ASYNC_START:
+			schedule_work(&w->work);
+			break;
+		case BPF_ASYNC_CANCEL:
+			cancel_work(&w->work);
+			break;
+		}
+		break;
+	}
+	}
+	bpf_async_refcount_put(cb);
+}
+
+static void bpf_async_irq_worker(struct irq_work *work)
+{
+	struct bpf_async_cb *cb = container_of(work, struct bpf_async_cb, worker);
+	struct llist_node *pos, *n, *list;
+
+	list = llist_del_all(&cb->async_cmds);
+	if (!list)
+		return;
+
+	list = llist_reverse_order(list);
+	llist_for_each_safe(pos, n, list) {
+		struct bpf_async_cmd *cmd;
+
+		cmd = container_of(pos, struct bpf_async_cmd, node);
+		bpf_async_process_op(cb, cmd->op, cmd->nsec, cmd->mode);
+		kfree_nolock(cmd);
+	}
+}
+
+static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
-	/* Performance optimization: read async->cb without lock first. */
 	if (!READ_ONCE(async->cb))
-		return NULL;
+		return;
 
-	__bpf_spin_lock_irqsave(&async->lock);
-	/* re-read it under lock */
-	cb = async->cb;
+	cb = xchg(&async->cb, NULL);
 	if (!cb)
-		goto out;
-	bpf_async_update_prog_callback(cb, NULL, NULL);
-	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
-	 * this timer, since it won't be initialized.
-	 */
-	WRITE_ONCE(async->cb, NULL);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return cb;
-}
+		return;
 
-static void bpf_timer_delete(struct bpf_hrtimer *t)
-{
 	/*
-	 * We check that bpf_map_delete/update_elem() was called from timer
-	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
-	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
-	 * just return -1). Though callback_fn is still running on this cpu it's
-	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
-	 * from 't'. The bpf subprog callback_fn won't be able to access 't',
-	 * since async->cb = NULL was already done. The timer will be
-	 * effectively cancelled because bpf_timer_cb() will return
-	 * HRTIMER_NORESTART.
-	 *
-	 * However, it is possible the timer callback_fn calling us armed the
-	 * timer _before_ calling us, such that failing to cancel it here will
-	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
-	 * Therefore, we _need_ to cancel any outstanding timers before we do
-	 * call_rcu, even though no more timers can be armed.
-	 *
-	 * Moreover, we need to schedule work even if timer does not belong to
-	 * the calling callback_fn, as on two different CPUs, we can end up in a
-	 * situation where both sides run in parallel, try to cancel one
-	 * another, and we end up waiting on both sides in hrtimer_cancel
-	 * without making forward progress, since timer1 depends on time2
-	 * callback to finish, and vice versa.
-	 *
-	 *  CPU 1 (timer1_cb)			CPU 2 (timer2_cb)
-	 *  bpf_timer_cancel_and_free(timer2)	bpf_timer_cancel_and_free(timer1)
-	 *
-	 * To avoid these issues, punt to workqueue context when we are in a
-	 * timer callback.
+	 * No refcount_inc_not_zero(&cb->refcnt) here. Dropping the last
+	 * refcnt. Either synchronously or asynchronously in irq_work.
 	 */
-	if (this_cpu_read(hrtimer_running)) {
-		queue_work(system_dfl_wq, &t->cb.delete_work);
-		return;
-	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		/* If the timer is running on other CPU, also use a kworker to
-		 * wait for the completion of the timer instead of trying to
-		 * acquire a sleepable lock in hrtimer_cancel() to wait for its
-		 * completion.
-		 */
-		if (hrtimer_try_to_cancel(&t->timer) >= 0)
-			call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
-		else
-			queue_work(system_dfl_wq, &t->cb.delete_work);
+	if (!in_hardirq()) {
+		bpf_async_process_op(cb, BPF_ASYNC_CANCEL, 0, 0);
 	} else {
-		bpf_timer_delete_work(&t->cb.delete_work);
+		(void)bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+		/*
+		 * bpf_async_schedule_op() either enqueues allocated cmd into llist
+		 * or fails with ENOMEM and drop the last refcnt.
+		 * This is unlikely, but safe, since bpf_async_cb_rcu_tasks_trace_free()
+		 * callback will do additional timer/wq_cancel due to races anyway.
+		 */
 	}
 }
 
@@ -1617,33 +1669,16 @@ static void bpf_timer_delete(struct bpf_hrtimer *t)
  */
 void bpf_timer_cancel_and_free(void *val)
 {
-	struct bpf_hrtimer *t;
-
-	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
-	if (!t)
-		return;
-
-	bpf_timer_delete(t);
+	bpf_async_cancel_and_free(val);
 }
 
-/* This function is called by map_delete/update_elem for individual element and
+/*
+ * This function is called by map_delete/update_elem for individual element and
  * by ops->map_release_uref when the user space reference to a map reaches zero.
  */
 void bpf_wq_cancel_and_free(void *val)
 {
-	struct bpf_work *work;
-
-	BTF_TYPE_EMIT(struct bpf_wq);
-
-	work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
-	if (!work)
-		return;
-	/* Trigger cancel of the sleepable work, but *do not* wait for
-	 * it to finish if it was running as we might not be in a
-	 * sleepable context.
-	 * kfree will be called once the work has finished.
-	 */
-	schedule_work(&work->delete_work);
+	bpf_async_cancel_and_free(val);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
@@ -3116,16 +3151,23 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
 	struct bpf_work *w;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
 	if (flags)
 		return -EINVAL;
+
 	w = READ_ONCE(async->work);
 	if (!w || !READ_ONCE(w->cb.prog))
 		return -EINVAL;
 
-	schedule_work(&w->work);
-	return 0;
+	if (!refcount_inc_not_zero(&w->cb.refcnt))
+		return -ENOENT;
+
+	if (!in_hardirq()) {
+		schedule_work(&w->work);
+		bpf_async_refcount_put(&w->cb);
+		return 0;
+	} else {
+		return bpf_async_schedule_op(&w->cb, BPF_ASYNC_START, 0, 0);
+	}
 }
 
 __bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
-- 
2.47.3

