Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96014883F
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985749; cv=none; b=EBGxmim+cgp85n6f2EYxBlQHJxurK666otnsQzj584mWCtol6cG2Rt52Z1M7QhHJ2HF+mm2/Kc+JifvsSvPxjsEsjDfYv2BZVB22cpx87/ZomyD0BFjUWkSc2jCab+ITot99S4RtJ7Z75Dh7hdPwq5kmP8cy5lqM8Nn7aes8/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985749; c=relaxed/simple;
	bh=OFbrWjzY3Y4ucpuujSi7QXkJRT7WCI4BLh+hDLpXV2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYS+9tPm8Gb4w0Y6AkXjR9E35Kpb7worsWIFcMJLw7Jv3CtwjjMEm3Jktn34zs0I0w2JCYlSo16yEJoaORK0Joiv9lwEn4wYj/URofraOHguNJz4VvsVrofv8+AR5PfQocWI2YyaMN1wjXOiTim/6vpBY8Pzp2RAzHElrou0AHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F/k5Clss; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F/k5Clss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xY
	QIE+QRPkR7RdDsWz6GhOtjQAIHsuppHC9BvG7tFDU=; b=F/k5ClssC1TXn0Bqm4
	WdS1OicmM6BWqp8BrpAhLkGW45QDPs9qRIojWUinQNIyRHHEP4sdT89+Ip1U0Yhg
	Jzr6bOhsXvFXzTqHozANno9thIbMNs+20ySIyalSyOlvWbFJDEMnjs4gumjTZEBu
	nrUsdyuF6tXGGyis9JniLiZyY=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHHsuiA7FqJ+caBw--.352S3;
	Mon, 21 Sep 2026 18:15:01 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Fix task work scheduling and callback race
Date: Mon, 21 Sep 2026 18:14:52 +0800
Message-ID: <20260921101453.69273-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921101453.69273-1-luyun_611@163.com>
References: <20260921101453.69273-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHHsuiA7FqJ+caBw--.352S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw4xWF1UCrWkXr4UCw4rXwb_yoWfJF18pr
	ZYvw1jyw4kWanFqF4avw4xAF1fKwsaya15Gr4kKr9Iyws8Xrn7Z348tF17tF4rCrs5JF1U
	Zr4qy3yI9r45Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY5lbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwXwv2qxA6X+LAAA3m

From: Yun Lu <luyun@kylinos.cn>

bpf_task_work_irq() publishes a task_work callback before changing the
context from SCHEDULING to SCHEDULED.  The callback can therefore run on
another CPU while the irq_work handler is still using the same scheduling
round.

Nothing currently orders the handler's use of ctx->task against
bpf_task_work_ctx_reset().  The callback can reset ctx->task and publish
STANDBY before the handler resumes, allowing map-value deletion to make the
handler pass NULL to task_work_cancel().  Publishing STANDBY this early
also allows a new round to reuse the context and irq_work while the old
handler is still running.

One concrete interleaving is:

  1. CPU 0 changes PENDING to SCHEDULING in bpf_task_work_irq() and
     successfully publishes ctx->work with task_work_add(), but has not yet
     attempted the SCHEDULING-to-SCHEDULED transition.

  2. The target task on CPU 1 runs the callback.  It changes SCHEDULING to
     RUNNING, executes the BPF subprogram, then bpf_task_work_ctx_reset()
     releases ctx->task and sets it to NULL.  The callback changes RUNNING
     to STANDBY and drops its ctx reference.

  3. CPU 2 deletes the map value.  bpf_task_work_cancel_and_free() changes
     STANDBY to FREED.  Since the old state is not SCHEDULED, it does not
     queue cancellation and drops the map's ctx reference.

  4. CPU 0 resumes.  Its SCHEDULING-to-SCHEDULED cmpxchg observes FREED, so
     bpf_task_work_cancel() calls task_work_cancel(NULL, &ctx->work).

If deletion changes the state to FREED before the callback runs, the
callback instead takes its FREED exit and may drop the last ctx reference.
The destroy path then resets ctx->task, producing the same NULL dereference
when CPU 0 resumes.

A controlled reproducer that delays CPU 0 between task_work_add() and the
state cmpxchg triggered the following fault on a v7.3-rc3 based x86-64 KVM
guest:

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

0x890 is the task_struct::task_works offset in that build.  It is read by
task_work_pending() through the NULL task argument.  The rcu_read_lock() in
bpf_task_work_irq() only keeps ctx memory alive; it does not retain
ctx->task.  A NULL check would still race with releasing the task
reference.

Fix this by making the callback claim RUNNING before synchronizing with the
scheduling irq_work.  RUNNING prevents map-value deletion from
reinitializing the irq_work for asynchronous cancellation, so
irq_work_sync() waits for the scheduling invocation that published the
callback.  Only after that invocation returns may the callback execute the
BPF subprogram, reset task/prog and publish STANDBY.

Pin the context with one temporary reference held by the scheduling
handler.  If deletion wins and the callback takes its FREED exit first,
this reference prevents destruction from resetting ctx->task before the
handler completes its cancellation attempt.

An add failure has no callback to perform the synchronization.  Initialize
the scheduling irq_work when the context is created and reject a new round
while the failed invocation remains BUSY.  This prevents overlapping
invocations from sharing the single BUSY bit and making a later
irq_work_sync() return before its scheduling handler has finished.

The callback runs in task context after task_work_run() has released
task->pi_lock, and existing task_work callbacks such as ____fput() may
sleep.  Keep the Tasks Trace RCU read-side section across irq_work_sync()
so the map value remains live until the callback finishes.  No context
fields or states are added, and the existing cancellation and destruction
paths are retained.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 46 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..e5d5683626ea 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4469,6 +4469,14 @@ static void bpf_task_work_callback(struct callback_head *cb)
 		bpf_task_work_ctx_put(ctx);
 		return;
 	}
+	if (WARN_ON_ONCE(state != BPF_TW_SCHEDULING &&
+			 state != BPF_TW_SCHEDULED)) {
+		bpf_task_work_ctx_put(ctx);
+		return;
+	}
+
+	/* Do not release this round's resources until its scheduler is done. */
+	irq_work_sync(&ctx->irq_work);
 
 	key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
 
@@ -4495,6 +4503,12 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 		bpf_task_work_ctx_put(ctx);
 		return;
 	}
+	/*
+	 * Pin the ctx until this handler is done. The callback may observe
+	 * FREED and drop its ref first, and destroy must not reset ctx->task
+	 * before the cancellation attempt below.
+	 */
+	refcount_inc(&ctx->refcnt);
 
 	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
 	if (err) {
@@ -4504,20 +4518,26 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 		 * gone to FREED already, which is fine as we already cleaned up after ourselves
 		 */
 		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
+		/*
+		 * No callback was published, so drop both refs owned by this
+		 * failed round: the callback ref and the scheduler's temporary ref.
+		 */
+		bpf_task_work_ctx_put(ctx);
 		bpf_task_work_ctx_put(ctx);
 		return;
 	}
 
 	/*
-	 * It's technically possible for just scheduled task_work callback to
-	 * complete running by now, going SCHEDULING -> RUNNING and then
-	 * dropping its ctx refcount. Instead of capturing an extra ref just
-	 * to protect below ctx->state access, we rely on rcu_read_lock
-	 * above to prevent kfree_rcu from freeing ctx before we return.
+	 * The callback may already be running on the target task's CPU, but
+	 * it waits for this invocation to finish before resetting task/prog
+	 * or publishing STANDBY, and the temporary reference above keeps the
+	 * ctx alive no matter how the other references are dropped here.
 	 */
 	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
 	if (state == BPF_TW_FREED)
 		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
+
+	bpf_task_work_ctx_put(ctx);
 }
 
 static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *tw,
@@ -4537,6 +4557,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	memset(ctx, 0, sizeof(*ctx));
 	refcount_set(&ctx->refcnt, 1); /* map's own ref */
 	ctx->state = BPF_TW_STANDBY;
+	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
 
 	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
 	if (old_ctx) {
@@ -4555,6 +4576,7 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 							   struct bpf_map *map)
 {
 	struct bpf_task_work_ctx *ctx;
+	enum bpf_task_work_state state;
 
 	/*
 	 * Sleepable BPF programs hold rcu_read_lock_trace but not
@@ -4579,6 +4601,19 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 		bpf_task_work_ctx_put(ctx);
 		return ERR_PTR(-EBUSY);
 	}
+	/*
+	 * An add failure publishes STANDBY before its irq_work handler
+	 * returns. Do not let a new round requeue the same irq_work until that
+	 * handler has cleared BUSY. Otherwise two invocations can overlap on
+	 * different CPUs; either tail can clear the shared BUSY bit and let a
+	 * later irq_work_sync() return while the other invocation still runs.
+	 */
+	if (unlikely(irq_work_is_busy(&ctx->irq_work))) {
+		state = cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
+		WARN_ON_ONCE(state != BPF_TW_PENDING && state != BPF_TW_FREED);
+		bpf_task_work_ctx_put(ctx);
+		return ERR_PTR(-EBUSY);
+	}
 
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
@@ -4628,7 +4663,6 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 	ctx->map = map;
 	ctx->map_val = (void *)tw - map->record->task_work_off;
 	init_task_work(&ctx->work, bpf_task_work_callback);
-	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
 
 	irq_work_queue(&ctx->irq_work);
 	return 0;
-- 
2.43.0

