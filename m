Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E04A32
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718476; cv=none; b=iaxtExZfToeUOYRYDqOCoPv1B4AKmTilmIGU3oAKg9TMLSutOj8qJJz+9jJmd55MrjX78BN7mAZnB6aQXZOJcK82QalC8iEUfUOcr3lpw3DzaA6Pcr7XgXQVWZyR7+eQVKR8hEB5B/lOem0sFgbLozNTXsVDk1q13u3PfujXiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718476; c=relaxed/simple;
	bh=SguBMch3UPcnsRBLy4Fgf0S2PbdZJiAArERyHUCe5YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UphcykwaUpG7ZW2TPfAzg1UotMPsTcKAS0L9NOqv64hqWDY5ENXoEYFoz0g31fE9Qt2PwyrICkMgAh5cmE4OaCD+yBpG9UgeS+X/r9CdLPQIh3X+tOg5moRYS/kgOUxPVPch4BqVCDq1AweH/0wqj97Ffub/mnatWQ8+ZarDnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D6L2szSC; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D6L2szSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/Q
	GMmUYXiGcJrxZsgoct8i4WUwvg11Hj8RtMq5Obe0g=; b=D6L2szSC6RFSwkzSPh
	Z6Rqimdu3IeYUC8o7AYQJs2NvmoipwwMK577mN52NzKsN68wO9ko7Od2Qm530rJ9
	SRTE4A92CGMQOtVqDkCNir9+mV73wcrKNRm6JBq89Jdoei5GUwdmNuZNPPoAtMti
	ZukkvvMSGpp6lXO4/OCQxsINI=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHCk2O76xqG1U9AA--.7036S3;
	Fri, 18 Sep 2026 16:00:17 +0800 (CST)
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
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Fix task work round ownership during cancellation
Date: Fri, 18 Sep 2026 16:00:13 +0800
Message-ID: <20260918080014.54012-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918080014.54012-1-luyun_611@163.com>
References: <20260918080014.54012-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHCk2O76xqG1U9AA--.7036S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3Kr4fuF1kXw4kWFWrXFWrZrb_yoW8JFyxZo
	W0q34UXF4kWrZ2y3yxXa4vyF12va1v93Z7Xr4rWw4Yvw4FqryjkF1DGw13Aw1xWF4rKr17
	JFy8t3Z5CFW8Wa4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4l1vUUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwxHltGqs75FUTgAA3h

From: Yun Lu <luyun@kylinos.cn>

bpf_task_work_irq() reacts to observing BPF_TW_FREED after a successful
task_work_add() by calling bpf_task_work_cancel(), which dereferences
ctx->task unconditionally.  Nothing currently orders that dereference
against bpf_task_work_ctx_reset(), so it can pass NULL to
task_work_cancel().

The race requires the target task to run concurrently with the irq_work
scheduler, for example on a different CPU.  This is a supported use of
the bpf_task_work_schedule_*() kfuncs.  One concrete interleaving is:

  1. CPU 0 executes bpf_task_work_irq() and publishes ctx->work with
     task_work_add(), but has not yet attempted the
     SCHEDULING-to-SCHEDULED transition.

  2. The target task on CPU 1 returns to userspace and runs the callback.
     It changes SCHEDULING to RUNNING, executes the BPF subprogram, then
     bpf_task_work_ctx_reset() releases ctx->task and sets it to NULL.
     The callback changes RUNNING to STANDBY and drops its ctx reference.

  3. CPU 2 deletes the map value.  bpf_task_work_cancel_and_free()
     changes STANDBY to FREED.  Since the old state is not SCHEDULED, it
     does not queue cancellation and drops the map's ctx reference.

  4. CPU 0 resumes.  Its SCHEDULING-to-SCHEDULED cmpxchg observes FREED,
     so bpf_task_work_cancel() calls
     task_work_cancel(NULL, &ctx->work).

If deletion changes the state to FREED before the callback runs, the
callback instead takes its FREED exit and can release the last ctx
reference.  The original destroy path then resets ctx->task, producing
the same NULL dereference when CPU 0 resumes.

A controlled reproducer that delays CPU 0 between task_work_add() and
the state cmpxchg triggered the following fault on a v7.3-rc3 based
x86-64 KVM guest:

  BUG: kernel NULL pointer dereference, address: 0000000000000890
  #PF: supervisor read access in kernel mode
  RIP: task_work_cancel+0xd/0xa0
  RDI: 0000000000000000
  CR2: 0000000000000890
  Call Trace:
   <IRQ>
   bpf_task_work_irq+0x95/0x100
   irq_work_run_list+0x4f/0x90
   irq_work_run+0x18/0x50
   __sysvec_irq_work+0x18/0xb0
   sysvec_irq_work+0x66/0x80
   </IRQ>

0x890 is the task_struct::task_works offset in that build.  It is read
by task_work_pending() through the NULL task argument.

The rcu_read_lock() in bpf_task_work_irq() only keeps ctx memory alive;
it does not retain ctx->task.  A NULL check is insufficient as the task
reference could be released immediately after the check.  Delaying ctx
memory reclamation alone does not preserve the value of ctx->task
either.

Fix the ownership of a scheduling round.  The irq_work scheduler, the
published callback and an asynchronous canceller each hold round_refs
while they can use the round's task, prog or work.  The
STANDBY-to-PENDING transition is the exclusive zero-to-one gate for a
new round.  Its winner initializes the scheduler reference only after
the previous round has reset the context and published STANDBY.

Take the callback reference before task_work_add() publishes the work.
If task_work_add() fails, the scheduler releases the untransferred
callback reference.  The last round user resets task/prog before making
the context reusable.

Map-value deletion publishes FREED first.  If the previous state was
SCHEDULED, refcount_inc_not_zero() either pins the active round for
cancellation or loses to the last put after cleanup has started.  A
successful task_work_cancel() releases exactly one callback round and
ctx reference on its behalf.  If cancellation fails, the actual
callback releases them.

Use separate irq_work objects for scheduling, cancellation and deferred
destruction.  This avoids reinitializing an irq_work that can still be
queued or running.  The deletion path remains atomic-only for NMI
callers, and FREED remains terminal.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 123 +++++++++++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..ff66a30cd04a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4380,8 +4380,15 @@ enum bpf_task_work_state {
 struct bpf_task_work_ctx {
 	enum bpf_task_work_state state;
 	refcount_t refcnt;
+	/*
+	 * References to task/prog/work in the current scheduling round.  The
+	 * STANDBY -> PENDING transition serializes initialization from zero.
+	 */
+	refcount_t round_refs;
 	struct callback_head work;
 	struct irq_work irq_work;
+	struct irq_work cancel_irq_work;
+	struct irq_work destroy_irq_work;
 	/* bpf_prog that schedules task work */
 	struct bpf_prog *prog;
 	/* task for which callback is scheduled */
@@ -4416,11 +4423,55 @@ static bool bpf_task_work_ctx_tryget(struct bpf_task_work_ctx *ctx)
 	return refcount_inc_not_zero(&ctx->refcnt);
 }
 
-static void bpf_task_work_destroy(struct irq_work *irq_work)
+static void bpf_task_work_round_get(struct bpf_task_work_ctx *ctx)
 {
-	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+	refcount_inc(&ctx->round_refs);
+}
+
+/*
+ * Pin an active round for cancellation without reviving a round whose last
+ * user has already started resetting the context.
+ */
+static bool bpf_task_work_round_tryget(struct bpf_task_work_ctx *ctx)
+{
+	return refcount_inc_not_zero(&ctx->round_refs);
+}
+
+/*
+ * Once the last reference reaches zero, a canceller cannot join this round.
+ * Reset task/prog before publishing STANDBY, which is the only state from
+ * which a new scheduler can initialize the next round's first reference.
+ */
+static void bpf_task_work_round_put(struct bpf_task_work_ctx *ctx)
+{
+	enum bpf_task_work_state state, old_state;
+
+	if (!refcount_dec_and_test(&ctx->round_refs))
+		return;
 
 	bpf_task_work_ctx_reset(ctx);
+
+	/* FREED is terminal; leave the round permanently closed. */
+	state = READ_ONCE(ctx->state);
+	if (state == BPF_TW_FREED)
+		return;
+	if (WARN_ON_ONCE(state != BPF_TW_PENDING &&
+			 state != BPF_TW_SCHEDULING &&
+			 state != BPF_TW_RUNNING))
+		return;
+
+	old_state = cmpxchg(&ctx->state, state, BPF_TW_STANDBY);
+	if (old_state == BPF_TW_FREED)
+		return;
+	if (WARN_ON_ONCE(old_state != state))
+		return;
+}
+
+static void bpf_task_work_destroy(struct irq_work *irq_work)
+{
+	struct bpf_task_work_ctx *ctx;
+
+	ctx = container_of(irq_work, struct bpf_task_work_ctx, destroy_irq_work);
 	kfree_rcu(ctx, rcu);
 }
 
@@ -4430,23 +4481,24 @@ static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
 		return;
 
 	if (irqs_disabled()) {
-		ctx->irq_work = IRQ_WORK_INIT(bpf_task_work_destroy);
-		irq_work_queue(&ctx->irq_work);
+		ctx->destroy_irq_work = IRQ_WORK_INIT(bpf_task_work_destroy);
+		irq_work_queue(&ctx->destroy_irq_work);
 	} else {
-		bpf_task_work_destroy(&ctx->irq_work);
+		bpf_task_work_destroy(&ctx->destroy_irq_work);
 	}
 }
 
 static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
 {
 	/*
-	 * Scheduled task_work callback holds ctx ref, so if we successfully
-	 * cancelled, we put that ref on callback's behalf. If we couldn't
-	 * cancel, callback will inevitably run or has already completed
-	 * running, and it would have taken care of its ctx ref itself.
+	 * The scheduled callback holds both a ctx ref and a round reference.
+	 * Successful cancellation releases both on its behalf.  If the
+	 * work was already claimed, the callback releases them itself.
 	 */
-	if (task_work_cancel(ctx->task, &ctx->work))
+	if (task_work_cancel(ctx->task, &ctx->work)) {
+		bpf_task_work_round_put(ctx);
 		bpf_task_work_ctx_put(ctx);
+	}
 }
 
 static void bpf_task_work_callback(struct callback_head *cb)
@@ -4466,6 +4518,7 @@ static void bpf_task_work_callback(struct callback_head *cb)
 	if (state == BPF_TW_SCHEDULED)
 		state = cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_RUNNING);
 	if (state == BPF_TW_FREED) {
+		bpf_task_work_round_put(ctx);
 		bpf_task_work_ctx_put(ctx);
 		return;
 	}
@@ -4477,9 +4530,7 @@ static void bpf_task_work_callback(struct callback_head *cb)
 			 (u64)(long)ctx->map_val, 0, 0);
 	migrate_enable();
 
-	bpf_task_work_ctx_reset(ctx);
-	(void)cmpxchg(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
-
+	bpf_task_work_round_put(ctx);
 	bpf_task_work_ctx_put(ctx);
 }
 
@@ -4492,18 +4543,17 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 	guard(rcu)();
 
 	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) != BPF_TW_PENDING) {
+		bpf_task_work_round_put(ctx);
 		bpf_task_work_ctx_put(ctx);
 		return;
 	}
 
+	/* Publish the callback's reference before task_work_add(). */
+	bpf_task_work_round_get(ctx);
 	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
 	if (err) {
-		bpf_task_work_ctx_reset(ctx);
-		/*
-		 * try to switch back to STANDBY for another task_work reuse, but we might have
-		 * gone to FREED already, which is fine as we already cleaned up after ourselves
-		 */
-		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
+		bpf_task_work_round_put(ctx);
+		bpf_task_work_round_put(ctx);
 		bpf_task_work_ctx_put(ctx);
 		return;
 	}
@@ -4518,6 +4568,8 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
 	if (state == BPF_TW_FREED)
 		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
+
+	bpf_task_work_round_put(ctx);
 }
 
 static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *tw,
@@ -4536,6 +4588,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 
 	memset(ctx, 0, sizeof(*ctx));
 	refcount_set(&ctx->refcnt, 1); /* map's own ref */
+	refcount_set(&ctx->round_refs, 0);
 	ctx->state = BPF_TW_STANDBY;
 
 	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
@@ -4575,10 +4628,11 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 	}
 
 	if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
-		/* lost acquiring race or map_release_uref() stole it from us, put ref and bail */
+		/* Lost the acquiring race or map deletion made FREED terminal. */
 		bpf_task_work_ctx_put(ctx);
 		return ERR_PTR(-EBUSY);
 	}
+	refcount_set(&ctx->round_refs, 1); /* scheduler's reference */
 
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
@@ -4586,6 +4640,7 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 	 * choice: dropping user references should stop everything.
 	 */
 	if (!atomic64_read(&map->usercnt)) {
+		bpf_task_work_round_put(ctx);
 		/* drop ref we just got for task_work callback itself */
 		bpf_task_work_ctx_put(ctx);
 		/* transfer map's ref into cancel_and_free() */
@@ -4773,12 +4828,14 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 
 __bpf_kfunc_end_defs();
 
-static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
+static void bpf_task_work_cancel_freed(struct irq_work *irq_work)
 {
-	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+	struct bpf_task_work_ctx *ctx;
 
-	bpf_task_work_cancel(ctx); /* this might put task_work callback's ref */
-	bpf_task_work_ctx_put(ctx); /* and here we put map's own ref that was transferred to us */
+	ctx = container_of(irq_work, struct bpf_task_work_ctx, cancel_irq_work);
+	bpf_task_work_cancel(ctx);
+	bpf_task_work_round_put(ctx);
+	bpf_task_work_ctx_put(ctx); /* put the map's ref transferred to us */
 }
 
 void bpf_task_work_cancel_and_free(void *val)
@@ -4792,10 +4849,20 @@ void bpf_task_work_cancel_and_free(void *val)
 		return;
 
 	state = xchg(&ctx->state, BPF_TW_FREED);
-	if (state == BPF_TW_SCHEDULED) {
-		/* run in irq_work to avoid locks in NMI */
-		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
-		irq_work_queue(&ctx->irq_work);
+	/*
+	 * SCHEDULED guarantees a callback round user.  After publishing FREED,
+	 * either add the cancellation user before the callback leaves, or lose
+	 * to the last put after the callback has already claimed/completed work.
+	 */
+	if (state == BPF_TW_SCHEDULED &&
+	    bpf_task_work_round_tryget(ctx)) {
+		/*
+		 * A separate irq_work keeps the NMI deletion path atomic-only and
+		 * avoids reinitializing the scheduler's irq_work while it is queued
+		 * or running.  Holding the map ref keeps ctx alive until this runs.
+		 */
+		init_irq_work(&ctx->cancel_irq_work, bpf_task_work_cancel_freed);
+		WARN_ON_ONCE(!irq_work_queue(&ctx->cancel_irq_work));
 		return;
 	}
 
-- 
2.43.0

