Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A12FFDF4
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105024; cv=none; b=pCyGgZ4IUy42CW/qaXEpv3ln6K0W4k3WLn1yPhVRMPXvZH2BCYxwRD76+xu9bFjiItGuuQSNszYAgC4cZVD68Sg7osBUTbgtWF94K4Gw+rX8J3RqRThekf9L7BWoNYMCnH303BTvusfQEYVo0kM9VPuNfMnCi3fIG0Zqe+8P3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105024; c=relaxed/simple;
	bh=bHZvSbs/s2SlS4rphrtjvXuO5hCE30c9ZGXkio5+chc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4Mhay7MzxbdUw0hgkl+ceOIGCFvx51Hmyc2p8nrSYOlIU3NnPhnc7M4N2Yc82Boq8uY0j/0vyLG0zhOY26myMu+pUgzzZ+cctGoMi5HUyZyWB+4YmPvjwkQ3RziUaqC+icZJ3FFBrZTXRPcN1GZJfJ2DHSGPjS0UhAUx+id0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhuWn/tu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhuWn/tu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47edffe5540so14676945e9.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105017; x=1769709817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNIOvVMvUTPXVRbKGlIBKJUZcgJaS9v0CufDRWmCfrs=;
        b=JhuWn/tup+WGeo1fPrE4GRhlViOmg8se41FErY/RASIj+FnCKkeknRvYNzbq879mS3
         dCd/BN/7l0iI4KflvavTBG5N0kw3yZAhLv678GC+NBmfJWzyg04rFFsMuBmxnLtxDI1U
         33hnzcJVm4KY4Lp2JCz2AbgocXjLeLekbDLtIBy1Y4FI3yGMwpexxHmbEOkFFSJPoly+
         Mo4Nd3Cr3/prJgjCMwj6ila6YaO7HVahjOR3qJku5QUvF25UJkeCsVKfrvE48Q9Y3cRZ
         291W0G6aWNstH5PEbBuhsjsNEC6t/qeOhw8Yq19jteL/zaPqKifqHb8PphK0qISdv2u8
         IfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105017; x=1769709817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNIOvVMvUTPXVRbKGlIBKJUZcgJaS9v0CufDRWmCfrs=;
        b=I0q+aRXCopr3ZpRzcQ+DdwVtNlUxnvTQPuf8JQqm9bSP4vatL9AfimLscS1vQLMwcL
         kmlzHZEi24AXu+2uz2WEtBh4kEV6AQO/KeQ78hpbstgV+lH05028SkY8QFZvLDx1rmuq
         zUY12SDuYZUqAcrOLkxMXXUgCIxK4AFJr0LCE++jOv0FSHqFrll8Ya9Yu9AKpQpTstmf
         ykSGJsQyaqyqQyv8LB493z81hbEHTe5rXXT51uKOjXmY7WTZMAAFxHRm2usuMNm13xYo
         VhtrbfZIPYH9WfR/l51lECl/VLP0aw1sxxFNVYgZGiCX78I9oHz3JY8aB25ulB5ND3iJ
         Ho4g==
X-Gm-Message-State: AOJu0YwmXBESFmF9vkNtWRVaa9Tuk4+JY5pXXHnHyEe1c6A6g5L55G8b
	PTMmMEEnRm9UJIc3Ie0dYkTpWX5Op9PU3gV2u8A/Mzc9/g/vv1SSXNxB
X-Gm-Gg: AZuq6aI2TsqsQ8LYq8t744GbbeGdDp2+PEusvlOn07/QCSZpU3wcyReK2U7VZL19yuq
	VPzQQGrYhx4bx0y77tX6oWPU2vSK32Hi2Lkn1+NGxJiVWF4UP6AFThdAR4om2Ju8E1p0UUer/xg
	5cI1kiWRUpPjR8YDvL0So98oYDxy87K4Oc9frpGv4RS0IGTGIkDXhZQlOC7pmn18a8Kg+CnaAMf
	vrm/ajQzvZx7yx0YAp2urJlaUtK3fHRQ5w7rTyjCmQ/o6ktah9B2iUXhvidqw6ZAIe7AU5wPp5J
	2anRbRNEqM9kQfDbj9S9CVobatI7KAg1Cn5qcmHtmHBE6cEG9GUetGrw+bM3N7V02qSN8ryOqAE
	reAraTw3qUv03Z1dYUyVIXVo6zRpx3kYThJOuVX4gAHpwYEb6hc7TElT62fhPmsNc1PZvx0mgHU
	6PpU21Jh2+iSq2oSkEWpQJnIw=
X-Received: by 2002:a05:600c:a015:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-4804c947cfdmr7930075e9.6.1769105016792;
        Thu, 22 Jan 2026 10:03:36 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c0179bsm408185f8f.1.2026.01.22.10.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:36 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:14 +0000
Subject: [PATCH bpf-next v7 1/8] bpf: Enable bpf timer and workqueue use in
 NMI
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-1-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105012; l=21240;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=Tl3xtP35eEOO+UXokX1fPSZFWLZdp5x+oftq4sKmtAM=;
 b=IxMmsx2YR6Om+gq+mSG2Q0BjkLCO7J1xacdJzIFnemFKTY2VvED6M/WSC0hLwOJm3E7SNek1e
 D9uxb1JVLoHCxxSHTJmP8bqWWrHtrQ7T6svM+5KfF/Pl4XG1T+vlBmd
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor bpf timer and workqueue helpers to allow calling them from NMI
context by making all operations lock-free and deferring NMI-unsafe
work to irq_work.

Previously, bpf_timer_start(), and bpf_wq_start()
could not be called from NMI context because they acquired
bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
patch removes these limitations.

Key changes:
 * Remove bpf_spin_lock from struct bpf_async_kern.
 * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
   atomically.
 * Add per-bpf_async_cb irq_work to defer NMI-unsafe
   operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
   NMI to softirq context.
 * Use the lock-free seqcount_latch_t to pass operation
   commands (start/cancel/free) and parameters
   from NMI-safe callers to the irq_work handler.
 * Add reference counting to bpf_async_cb to ensure the object stays
   alive until all scheduled irq_work completes.
 * Move bpf_prog_put() to RCU callback to handle races between
   set_callback() and cancel_and_free().
 * Modify cancel_and_free() path:
   * Detach bpf_async_cb.
   * Signal destruction to irq_work side via setting last_seq to
     BPF_ASYNC_DESTROY.
   * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
 * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
   task trace grace periods before freeing the bpf_async_cb. Removed
   unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
   task trace lock.

This enables BPF programs attached to NMI-context hooks (perf
events) to use timers and workqueues for deferred processing.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 434 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 252 insertions(+), 182 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 637677815365fdd0f7aa568d4fb36ec17c8a2bff..1514683d260d3b8c3193caa7ba1c4a1cfb86d64d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/seqlock.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1095,16 +1096,41 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
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
+enum bpf_async_seq_state {
+	BPF_ASYNC_DESTROY = (u64)U32_MAX + 1,
+	BPF_ASYNC_DESTROYED = (u64)U32_MAX + 2,
+};
+
+struct bpf_async_cmd {
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
+	atomic_t writer;
+	seqcount_latch_t latch;
+	struct bpf_async_cmd cmd[2];
+	atomic64_t last_seq;
+	refcount_t refcnt;
+	enum bpf_async_type type;
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
@@ -1132,7 +1158,6 @@ struct bpf_hrtimer {
 struct bpf_work {
 	struct bpf_async_cb cb;
 	struct work_struct work;
-	struct work_struct delete_work;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer and bpf_wq */
@@ -1142,18 +1167,9 @@ struct bpf_async_kern {
 		struct bpf_hrtimer *timer;
 		struct bpf_work *work;
 	};
-	/* bpf_spin_lock is used here instead of spinlock_t to make
-	 * sure that it always fits into space reserved by struct bpf_timer
-	 * regardless of LOCKDEP and spinlock debug flags.
-	 */
-	struct bpf_spin_lock lock;
+	u32 __pad; /* Left for binary compatibility, previously stored spinlock */
 } __attribute__((aligned(8)));
 
-enum bpf_async_type {
-	BPF_ASYNC_TYPE_TIMER = 0,
-	BPF_ASYNC_TYPE_WQ,
-};
-
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
@@ -1219,45 +1235,54 @@ static void bpf_async_cb_rcu_free(struct rcu_head *rcu)
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
-
-	cancel_work_sync(&w->work);
-
-	call_rcu(&w->cb.rcu, bpf_async_cb_rcu_free);
+	/*
+	 * If RCU Tasks Trace grace period implies RCU grace period,
+	 * there is no need to invoke call_rcu().
+	 */
+	if (rcu_trace_implies_rcu_gp())
+		bpf_async_cb_rcu_free(rcu);
+	else
+		call_rcu(rcu, bpf_async_cb_rcu_free);
 }
 
-static void bpf_timer_delete_work(struct work_struct *work)
+/*
+ * Decrement refcount and if it reaches zero, schedule deferred cleanup
+ * through call_rcu_tasks_trace() -> call_rcu() -> bpf_prog_put()/kfree()
+ */
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
+	/* Both timer and wq callbacks run under RCU lock, UAF should not be possible there */
+	call_rcu_tasks_trace(&cb->rcu, bpf_async_cb_rcu_tasks_trace_free);
 }
 
+static void __bpf_async_cancel_and_free(struct bpf_async_kern *async);
+static void bpf_async_irq_worker(struct irq_work *work);
+static int bpf_async_process(struct bpf_async_cb *cb);
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
@@ -1270,18 +1295,13 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
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
@@ -1289,7 +1309,6 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		t = (struct bpf_hrtimer *)cb;
 
 		atomic_set(&t->cancelling, 0);
-		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
 		hrtimer_setup(&t->timer, bpf_timer_cb, clockid, HRTIMER_MODE_REL_SOFT);
 		cb->value = (void *)async - map->record->timer_off;
 		break;
@@ -1297,16 +1316,26 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
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
+	seqcount_latch_init(&cb->latch);
+	atomic_set(&cb->writer, 0);
+	refcount_set(&cb->refcnt, 1); /* map's reference */
+	atomic64_set(&cb->last_seq, 0);
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
@@ -1317,13 +1346,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		/* maps with timers must be either held by user space
 		 * or pinned in bpffs.
 		 */
-		WRITE_ONCE(async->cb, NULL);
-		kfree_nolock(cb);
-		ret = -EPERM;
+		__bpf_async_cancel_and_free(async);
+		return -EPERM;
 	}
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+
+	return 0;
 }
 
 BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
@@ -1354,8 +1381,9 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callback_fn,
-					  struct bpf_prog *prog)
+static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
+					  struct bpf_prog *prog,
+					  void *callback_fn)
 {
 	struct bpf_prog *prev;
 
@@ -1380,7 +1408,8 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callbac
 		if (prev)
 			bpf_prog_put(prev);
 
-	} while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
+	} while (READ_ONCE(cb->prog) != prog ||
+		 (void __force *)READ_ONCE(cb->callback_fn) != callback_fn);
 
 	if (prog)
 		bpf_prog_put(prog);
@@ -1388,33 +1417,93 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb, void *callbac
 	return 0;
 }
 
+static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
+				 u64 nsec, u32 timer_mode)
+{
+	/* Acquire active writer */
+	if (atomic_cmpxchg_acquire(&cb->writer, 0, 1))
+		return -EBUSY;
+
+	write_seqcount_latch_begin(&cb->latch);
+	cb->cmd[0].nsec = nsec;
+	cb->cmd[0].mode = timer_mode;
+	cb->cmd[0].op = op;
+	write_seqcount_latch(&cb->latch);
+	cb->cmd[1].nsec = nsec;
+	cb->cmd[1].mode = timer_mode;
+	cb->cmd[1].op = op;
+	write_seqcount_latch_end(&cb->latch);
+
+	atomic_set_release(&cb->writer, 0);
+
+	if (!in_nmi())
+		return bpf_async_process(cb);
+
+	/* NMI path: defer to irq_work with refcount protection */
+	if (!refcount_inc_not_zero(&cb->refcnt))
+		return -EBUSY;
+
+	if (!irq_work_queue(&cb->worker))
+		bpf_async_refcount_put(cb);
+
+	return 0;
+}
+
+static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op *op,
+			     u64 *nsec, u32 *flags)
+{
+	u32 seq, idx;
+	s64 last_seq;
+
+	while (true) {
+		last_seq = atomic64_read_acquire(&cb->last_seq);
+		if (unlikely(last_seq > U32_MAX)) { /* Check if terminal seq num has been set */
+			s64 expected = BPF_ASYNC_DESTROY;
+
+			if (last_seq != BPF_ASYNC_DESTROY)
+				return -EBUSY;
+
+			if (!atomic64_try_cmpxchg_release(&cb->last_seq,
+							  &expected,
+							  BPF_ASYNC_DESTROYED))
+				return -EBUSY; /* Someone else set it to DESTROYED, bail */
+
+			*op = BPF_ASYNC_CANCEL;
+			return 0;
+		}
+
+		seq = raw_read_seqcount_latch(&cb->latch);
+
+		/* Return -EBUSY if current seq is consumed by another reader */
+		if (seq == last_seq)
+			return -EBUSY;
+
+		idx = seq & 1;
+		*nsec = cb->cmd[idx].nsec;
+		*flags = cb->cmd[idx].mode;
+		*op = cb->cmd[idx].op;
+
+		if (raw_read_seqcount_latch_retry(&cb->latch, seq))
+			continue;
+
+		/* Commit read sequence number, own snapshot exclusively */
+		if (atomic64_try_cmpxchg_release(&cb->last_seq, &last_seq, seq))
+			break;
+	}
+
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
@@ -1431,22 +1520,17 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
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
@@ -1456,10 +1540,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
 	if (flags & BPF_F_TIMER_CPU_PIN)
 		mode |= HRTIMER_MODE_PINNED;
 
-	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
-out:
-	__bpf_spin_unlock_irqrestore(&timer->lock);
-	return ret;
+	return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);
 }
 
 static const struct bpf_func_proto bpf_timer_start_proto = {
@@ -1480,8 +1561,6 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 	if (in_nmi())
 		return -EOPNOTSUPP;
 
-	guard(rcu)();
-
 	t = READ_ONCE(async->timer);
 	if (!t)
 		return -EINVAL;
@@ -1536,94 +1615,99 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
 	.arg1_type	= ARG_PTR_TO_TIMER,
 };
 
-static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
+static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
 	/* Performance optimization: read async->cb without lock first. */
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
+		return;
+
+	atomic64_set(&cb->last_seq, BPF_ASYNC_DESTROY);
+	if (!in_nmi()) {
+		bpf_async_refcount_put(cb);
+		bpf_async_process(cb);
+		return;
+	}
+	/*
+	 * Attempt to pass our initial map's reference to
+	 * irq_work callback, if we fail to schedule it (meaning it is
+	 * already scheduled by someone else having their own ref), we have to
+	 * put that ref here.
 	 */
-	WRITE_ONCE(async->cb, NULL);
-out:
-	__bpf_spin_unlock_irqrestore(&async->lock);
-	return cb;
+	if (!irq_work_queue(&cb->worker))
+		bpf_async_refcount_put(cb);
 }
 
-static void bpf_timer_delete(struct bpf_hrtimer *t)
+static void bpf_async_process_op(struct bpf_async_cb *cb, u32 op,
+				 u64 timer_nsec, u32 timer_mode)
 {
-	/*
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
-	 */
-	if (this_cpu_read(hrtimer_running)) {
-		queue_work(system_dfl_wq, &t->cb.delete_work);
-		return;
-	}
+	switch (cb->type) {
+	case BPF_ASYNC_TYPE_TIMER: {
+		struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
 
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
-	} else {
-		bpf_timer_delete_work(&t->cb.delete_work);
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
+			/* Use non-blocking cancel, safe in irq_work context.
+			 * RCU grace period ensures callback completes before free.
+			 */
+			cancel_work(&w->work);
+			break;
+		}
+		break;
+	}
 	}
 }
 
+static int bpf_async_process(struct bpf_async_cb *cb)
+{
+	u32 op, timer_mode;
+	u64 nsec;
+	int err;
+
+	err = bpf_async_read_op(cb, &op, &nsec, &timer_mode);
+	if (err)
+		return err;
+
+	bpf_async_process_op(cb, op, nsec, timer_mode);
+	return 0;
+}
+
+static void bpf_async_irq_worker(struct irq_work *work)
+{
+	struct bpf_async_cb *cb = container_of(work, struct bpf_async_cb, worker);
+
+	bpf_async_process(cb);
+	bpf_async_refcount_put(cb);
+}
+
 /*
  * This function is called by map_delete/update_elem for individual element and
  * by ops->map_release_uref when the user space reference to a map reaches zero.
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
+	__bpf_async_cancel_and_free(val);
 }
 
 /* This function is called by map_delete/update_elem for individual element and
@@ -1631,19 +1715,7 @@ void bpf_timer_cancel_and_free(void *val)
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
+	__bpf_async_cancel_and_free(val);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
@@ -3116,16 +3188,14 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
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
+	return bpf_async_schedule_op(&w->cb, BPF_ASYNC_START, 0, 0);
 }
 
 __bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,

-- 
2.52.0

