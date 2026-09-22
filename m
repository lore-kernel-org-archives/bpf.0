Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBD4ED1BC
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071334; cv=none; b=D41PUJh55Lxyr/RHqR/FkkUsOCjcRxV948DseI0WivORunguzw4nxnSABfbZg8UZgQnwlSAGmjpmn5x4RoDMw2luxfJdFTEjCSsn2zc+DOJrm/L5ymOvQOSDgmwBy0d1xLgieqKwTrqQwyr7e6tTSCC120Ruz+m4844STHu5e5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071334; c=relaxed/simple;
	bh=Lk28QcPcFGiEkk/m9SiJK4F7U8L/HpyNL62qB9fjwfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6rtaLPRxTgDBGMbl9swGqgyjNrAAMAWDPOlEzOJ+am4IXV4PA99HCupjedQw1coVflivoghP4ponxualCqoiIXaT2T5odMbIHJCHOrYRxdfDJUHhVqnd3R4/qdVffoXPJ1yOcaJhDEM1RchuXxYBOLmtF12+M0UfMXnZ5jLNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I8/f7D/R; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I8/f7D/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1A
	HsZc9G+RZ1mmIrOclpIdEIQ9bjedQBdK7OC08/r/4=; b=I8/f7D/RiCWy/HqTEv
	ZPs/+e/R7kghCaKjAbNCYEsrp3tcaeuRIcoVneVyBeICIIfG4CcVCvChFRWFeUjV
	QtlCbx5mj78ldQA0BqphYEUmr+db4PwXlOENX+KvcwxkKWFq23XTL5GhwEXR1BWy
	H60NyHRYRMF/hk1dYN7j/j1cg=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3HzLjUbJqDJOzAg--.12558S3;
	Tue, 22 Sep 2026 18:01:09 +0800 (CST)
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
Subject: [PATCH bpf-next v3 1/2] bpf: Fix task work scheduling and callback race
Date: Tue, 22 Sep 2026 18:00:41 +0800
Message-ID: <20260922100042.136818-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922100042.136818-1-luyun_611@163.com>
References: <20260922100042.136818-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3HzLjUbJqDJOzAg--.12558S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw4xWrW8KrykGrW7uryxGrg_yoWfWFy3pr
	sYvw1jyr4rW3ZFqF4avwsrAF1akwsayay5Gr4rKr9xKrZ8Xrn7Za48tF17tF4rGr4kJF1U
	Zr4qyrWxur4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY5lbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwXUo2qyUeVgYwAA3e

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

Fix this by taking a task reference in the scheduling irq_work before
publishing the callback.  Use the captured task for cancellation at the
handler tail, so the task remains valid even if the callback or destroy
path has reset ctx->task.  Release the reference on every add success and
failure path.

The asynchronous cancellation path is queued only after deletion wins
SCHEDULED-to-FREED.  In that case the callback observes FREED and cannot
reset ctx->task, while the map's transferred ctx reference prevents the
destroy path from doing so.  It can therefore safely pass ctx->task to the
same cancellation helper.  The two cancellation paths are mutually
exclusive: the scheduling handler handles deletion from SCHEDULING, and
the asynchronous path handles deletion from SCHEDULED.

The callback or add-failure path can publish STANDBY before the scheduling
irq_work returns.  Initialize irq_work when the context is created and
reject a new round while it is still BUSY.  This prevents the old handler
from consuming the new round's SCHEDULING state and publishing a false
SCHEDULED state, and prevents invocations on different CPUs from
overlapping on the same context.

This keeps the task-work callback non-blocking and adds no context fields
or states.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Reported-by: Jackie Liu <liuyun01@kylinos.cn>
Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..d8bea7538de5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4437,7 +4437,8 @@ static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
 	}
 }
 
-static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
+static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx,
+				 struct task_struct *task)
 {
 	/*
 	 * Scheduled task_work callback holds ctx ref, so if we successfully
@@ -4445,7 +4446,7 @@ static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
 	 * cancel, callback will inevitably run or has already completed
 	 * running, and it would have taken care of its ctx ref itself.
 	 */
-	if (task_work_cancel(ctx->task, &ctx->work))
+	if (task_work_cancel(task, &ctx->work))
 		bpf_task_work_ctx_put(ctx);
 }
 
@@ -4486,6 +4487,7 @@ static void bpf_task_work_callback(struct callback_head *cb)
 static void bpf_task_work_irq(struct irq_work *irq_work)
 {
 	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+	struct task_struct *task;
 	enum bpf_task_work_state state;
 	int err;
 
@@ -4496,7 +4498,8 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 		return;
 	}
 
-	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
+	task = get_task_struct(ctx->task);
+	err = task_work_add(task, &ctx->work, ctx->mode);
 	if (err) {
 		bpf_task_work_ctx_reset(ctx);
 		/*
@@ -4505,19 +4508,20 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 		 */
 		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
 		bpf_task_work_ctx_put(ctx);
+		put_task_struct(task);
 		return;
 	}
 
 	/*
-	 * It's technically possible for just scheduled task_work callback to
-	 * complete running by now, going SCHEDULING -> RUNNING and then
-	 * dropping its ctx refcount. Instead of capturing an extra ref just
-	 * to protect below ctx->state access, we rely on rcu_read_lock
-	 * above to prevent kfree_rcu from freeing ctx before we return.
+	 * The callback may have completed and reset ctx->task already. Keep the
+	 * captured task alive until this invocation is done with cancellation.
+	 * The RCU read-side section keeps ctx memory alive until then.
 	 */
 	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
 	if (state == BPF_TW_FREED)
-		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
+		bpf_task_work_cancel(ctx, task); /* clean up if we switched into FREED state */
+
+	put_task_struct(task);
 }
 
 static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *tw,
@@ -4537,6 +4541,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	memset(ctx, 0, sizeof(*ctx));
 	refcount_set(&ctx->refcnt, 1); /* map's own ref */
 	ctx->state = BPF_TW_STANDBY;
+	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
 
 	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
 	if (old_ctx) {
@@ -4579,6 +4584,18 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 		bpf_task_work_ctx_put(ctx);
 		return ERR_PTR(-EBUSY);
 	}
+	/*
+	 * The callback or add-failure path can publish STANDBY before the
+	 * scheduling irq_work returns. Do not let a new round reuse the context
+	 * until BUSY clears. Otherwise the old handler can consume the new
+	 * round's SCHEDULING state and publish a false SCHEDULED state, and two
+	 * invocations can overlap on different CPUs.
+	 */
+	if (unlikely(irq_work_is_busy(&ctx->irq_work))) {
+		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
+		bpf_task_work_ctx_put(ctx);
+		return ERR_PTR(-EBUSY);
+	}
 
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
@@ -4628,7 +4645,6 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 	ctx->map = map;
 	ctx->map_val = (void *)tw - map->record->task_work_off;
 	init_task_work(&ctx->work, bpf_task_work_callback);
-	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
 
 	irq_work_queue(&ctx->irq_work);
 	return 0;
@@ -4777,7 +4793,8 @@ static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
 {
 	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
 
-	bpf_task_work_cancel(ctx); /* this might put task_work callback's ref */
+	/* SCHEDULED -> FREED keeps ctx->task stable until this runs. */
+	bpf_task_work_cancel(ctx, ctx->task); /* this might put task_work callback's ref */
 	bpf_task_work_ctx_put(ctx); /* and here we put map's own ref that was transferred to us */
 }
 

-- 
2.43.0

