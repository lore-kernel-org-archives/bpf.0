Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE81471411
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758551; cv=none; b=sR53/qMVKIxQSareNTlaP6Dfw+lxvcqbRSHkjwC87cb/1Z84ujupqTEtVK2ArKkCCe8kdTKPVYD7ljtcbdPCWIuufgVrLqgsUmKXDPxaFNBxcvYCRSwovdQ2g49ed3a+x82Le/XxTCYYzj/N96uXMomCAgw84NlHTzU1pbuDJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758551; c=relaxed/simple;
	bh=sRbko7QEKDvUj0Llq+NNxl3HmqZk62o1qoLLu2PuN48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEFYmlgnH4jzhhy26rZWjKhw+8XgIFx8sc8wqPfUrgc134lX4Ey2GRhGPITh7zJJj82UdFyg6tqtbivt87pvDLW88I7EO/Mqnxa9n4AfeaCG8RC/7qLDQMoDhCUPTImI4YsUWiaTZfT2gQlzPDi9uyz0j0+qZZdG0PLjswk/u0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V9C4JdMh; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V9C4JdMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Fw
	bynjbJVIO/07dgoElnRMICedTITChVJRTgbI9rXlo=; b=V9C4JdMhyLiId8JA0E
	W/Nsda9AW5dQQsaseU4dYNKvU8H85MMQulWhIsgIIzpWoU6e1p5727hFs51k/V7p
	02VzRzlKMvLLcuoeUAvih25R84sB0Xrzf21ExP1f0tFvP56zvQwjd+wSFss1RKA9
	JWduKSf5RsEQXuihLUolmcZ0g=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnDapYzrxqRk3PCA--.39078S3;
	Wed, 30 Sep 2026 16:54:51 +0800 (CST)
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
Subject: [PATCH bpf-next v5 1/3] bpf: Fix NULL task dereference in task work cancellation
Date: Wed, 30 Sep 2026 16:54:15 +0800
Message-ID: <20260930085417.186729-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930085417.186729-1-luyun_611@163.com>
References: <20260930085417.186729-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnDapYzrxqRk3PCA--.39078S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFyrtF4kCw4kWFWUtr4DCFg_yoW3JF47pr
	Z0vw1jkr48WanFvF4aqanrAr1fWwsaya15Gr48Kr9Iyws8Xrn7tw18KF10qFWrCr1kJF17
	Zr4DtrWIgr4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY89tUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7ByUY2q8zlxpygAA3g

From: Yun Lu <luyun@kylinos.cn>

bpf_task_work_irq() publishes ctx->work with task_work_add() before
changing the context from SCHEDULING to SCHEDULED.  The target task can
run the callback on another CPU before the handler reaches its final
state transition.

The handler then reloads ctx->task for cancellation if its final cmpxchg
observes FREED.  By that point the callback or context destruction may
already have cleared ctx->task, causing task_work_cancel() to dereference
a NULL task pointer.

One concrete interleaving is:

  1. CPU 0 changes PENDING to SCHEDULING and successfully queues
     ctx->work with task_work_add(), but has not attempted the final
     state cmpxchg.

  2. The target task on CPU 1 runs the callback.  It changes SCHEDULING
     to RUNNING, executes the BPF subprogram, resets ctx->task,
     publishes STANDBY and drops the callback's context reference.

  3. CPU 2 deletes the map value.  It changes STANDBY to FREED and drops
     the map's context reference without queuing asynchronous
     cancellation.

  4. CPU 0 resumes.  Its SCHEDULING-to-SCHEDULED cmpxchg observes FREED,
     and the cancellation attempt passes NULL to task_work_cancel().

If deletion publishes FREED before the callback claims RUNNING, the
callback takes its FREED exit and drops its context reference.  Context
destruction can then clear ctx->task before CPU 0 attempts cancellation.

A controlled reproducer with a delay before the final cmpxchg triggered
the following fault on a v7.3-rc3 based x86-64 KVM guest:

  BUG: kernel NULL pointer dereference, address: 0000000000000890
  RIP: 0010:task_work_cancel+0xd/0xa0
  RDI: 0000000000000000
  CR2: 0000000000000890
  Call Trace:
   <IRQ>
   bpf_task_work_irq+0x95/0x100
   irq_work_run_list+0x4f/0x90
   irq_work_run+0x18/0x50
   </IRQ>

0x890 is the task_struct::task_works offset in that build, read through
the NULL task argument.

Capture ctx->task before task_work_add() publishes the callback and use
that pointer for the handler's cancellation attempt.  The round still
holds its task reference when the pointer is captured.  Releasing that
reference uses bpf_task_release(), which calls put_task_struct_rcu_user(),
so the handler's existing RCU read-side section keeps the captured task
alive even if ctx->task is subsequently cleared.

The asynchronous cancellation path reads ctx->task directly, which is
safe there: queuing it requires deletion to observe SCHEDULED, and that
xchg wins against the callback's transition to RUNNING, so the callback
takes its FREED exit without resetting ctx->task, while the map
reference transferred to the cancellation handler prevents context
destruction until cancellation completes.

The handler-tail and asynchronous cancellation attempts are mutually
exclusive: asynchronous cancellation is queued only if deletion observes
SCHEDULED after the scheduling handler's final cmpxchg has succeeded.
If that cmpxchg instead observes FREED, the scheduling handler attempts
cancellation with the captured pointer.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Reported-by: Jackie Liu <liuyun01@kylinos.cn>
Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..028fc6796b59 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4437,15 +4437,21 @@ static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
 	}
 }
 
-static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
+static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx,
+				 struct task_struct *task)
 {
 	/*
 	 * Scheduled task_work callback holds ctx ref, so if we successfully
 	 * cancelled, we put that ref on callback's behalf. If we couldn't
 	 * cancel, callback will inevitably run or has already completed
 	 * running, and it would have taken care of its ctx ref itself.
+	 *
+	 * The caller passes the task explicitly: the scheduling handler must
+	 * not read ctx->task after the work is published (the callback may
+	 * have reset it), while in the asynchronous cancellation path
+	 * ctx->task is stable, see bpf_task_work_cancel_scheduled().
 	 */
-	if (task_work_cancel(ctx->task, &ctx->work))
+	if (task_work_cancel(task, &ctx->work))
 		bpf_task_work_ctx_put(ctx);
 }
 
@@ -4486,6 +4492,7 @@ static void bpf_task_work_callback(struct callback_head *cb)
 static void bpf_task_work_irq(struct irq_work *irq_work)
 {
 	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+	struct task_struct *task;
 	enum bpf_task_work_state state;
 	int err;
 
@@ -4496,7 +4503,16 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 		return;
 	}
 
-	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
+	/*
+	 * Capture the task pointer before the work is published: once the
+	 * callback runs, it may reset ctx->task. The capture happens while
+	 * this round's task reference is held, and every path that can
+	 * release it runs after this handler entered its rcu read-side
+	 * section. bpf_task_release() is put_task_struct_rcu_user(), so the
+	 * task_struct itself cannot be freed before this section ends.
+	 */
+	task = ctx->task;
+	err = task_work_add(task, &ctx->work, ctx->mode);
 	if (err) {
 		bpf_task_work_ctx_reset(ctx);
 		/*
@@ -4510,14 +4526,14 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 
 	/*
 	 * It's technically possible for just scheduled task_work callback to
-	 * complete running by now, going SCHEDULING -> RUNNING and then
-	 * dropping its ctx refcount. Instead of capturing an extra ref just
-	 * to protect below ctx->state access, we rely on rcu_read_lock
-	 * above to prevent kfree_rcu from freeing ctx before we return.
+	 * complete running by now, going SCHEDULING -> RUNNING, resetting
+	 * ctx->task and dropping its ctx refcount. The rcu read-side section
+	 * above keeps both the ctx memory and the captured task pointer
+	 * valid until this handler returns.
 	 */
 	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
 	if (state == BPF_TW_FREED)
-		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
+		bpf_task_work_cancel(ctx, task); /* clean up if we switched into FREED state */
 }
 
 static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *tw,
@@ -4777,7 +4793,13 @@ static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
 {
 	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
 
-	bpf_task_work_cancel(ctx); /* this might put task_work callback's ref */
+	/*
+	 * Deletion observed SCHEDULED and won against the callback's
+	 * transition to RUNNING. The callback takes its FREED exit without
+	 * resetting ctx->task, and the transferred map reference prevents
+	 * destruction until cancellation completes.
+	 */
+	bpf_task_work_cancel(ctx, ctx->task); /* this might put task_work callback's ref */
 	bpf_task_work_ctx_put(ctx); /* and here we put map's own ref that was transferred to us */
 }
 
-- 
2.43.0

