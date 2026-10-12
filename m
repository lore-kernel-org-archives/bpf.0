Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955782DECD3
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786024; cv=none; b=XNbErwz3qceykKFGxCOHBId0w+MC3lxQvSxfC5AVXaC7cNeULCzlDw0MsSsI271BWMR0jD+UGRlDtsWXJghDsONJUHSl0FJyXW7dSBWLw5hZxcnrtiVDSMOuBPLepgfeFzxxYJIHrUwfPQr4ooL29UARVoeG+Wss2Qdt24z/vDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786024; c=relaxed/simple;
	bh=j7urMgsgnBksXSHrWxk9aYyVKCwyAhtRqG4r3Q8wN5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH2YJDDEp+7vnSkfddZX4aqjmC+bHmgrB/orX1izWC3VP219Q8+a0ziuiTzGArz97AW/uady8LZgv19R5wUik/3mB8mq/x89Y8qMLka29z8l4q8vYirmPH6lqmtiTx2yLWYSHZnOZYmUURepzkKYe5oMBugZnEQZLAl5HC1/WnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NS/c5MQJ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NS/c5MQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Zf
	5alV1JBS/WT5NeVvza6S38FqoOlQU61sav9p7r3OI=; b=NS/c5MQJE0AopaXeSi
	ZyBowjXOPYwASz7Ldq91kKQ2D/VQj7mTI3iJkQowomd2Wlk6HCLc+84ysIYoaBam
	IpfNXDRyLoYd1ayIvwG25DD2PgS5mBmVjiPA3E7mxANXjUy/ltVkGMI19vsOgIui
	HzW7Sb6JVejLET8XXrdSMbL5E=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_8bte8xqryiFEA--.37995S5;
	Mon, 12 Oct 2026 14:19:32 +0800 (CST)
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
Subject: [PATCH bpf-next v7 3/4] bpf: Prevent task work context reuse while irq_work is busy
Date: Mon, 12 Oct 2026 14:19:14 +0800
Message-ID: <20261012061915.231254-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012061915.231254-1-luyun_611@163.com>
References: <20261012061915.231254-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_8bte8xqryiFEA--.37995S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF48Gw48tF1UKw15XF43ZFb_yoWrWr1xpF
	WFvw1jyw4kW3Zrt3WYvw4xKa4akwn3tay5Cr4kKr9Iyrs8Xrn7Z34UK3WjqFWrJrWkJF15
	Zr4qya97ur45ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyVbkUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xTpuGrMe-TLugAA32

From: Yun Lu <luyun@kylinos.cn>

A bpf_task_work context can return to STANDBY before its scheduling
irq_work handler returns.  Both callback completion and task_work_add()
failure can publish STANDBY while the irq_work is still BUSY.  A new
round can then reinitialize and queue the same irq_work on another CPU
while the old handler is still running.

One concrete interleaving is:

  1. CPU 0 successfully queues ctx->work with task_work_add() and pauses
     before its SCHEDULING-to-SCHEDULED cmpxchg.

  2. The target task on CPU 1 completes the callback, resets ctx->task
     and publishes STANDBY.

  3. CPU 2 starts a new round, changes STANDBY to PENDING and queues the
     same irq_work.  The new handler changes PENDING to SCHEDULING, but
     task_work_add() returns -ESRCH because its target task has exited.
     The handler has not yet reset the context or rolled back the state.

  4. CPU 0 resumes and changes the new round's SCHEDULING to SCHEDULED,
     even though no task work was queued for that round.

  5. The new handler resets ctx->task, but its SCHEDULING-to-STANDBY
     cmpxchg fails.  The context remains SCHEDULED with a NULL task, and
     subsequent attempts to acquire this context fail with -EBUSY.

  6. Map-value deletion observes SCHEDULED and queues asynchronous
     cancellation, which passes the NULL ctx->task to task_work_cancel().

Overlapping invocations also share one BUSY bit.  An invocation can clear
that bit while the other invocation is still running.

Initialize the scheduling irq_work when the context is created and stop
reinitializing it for each round.  After claiming the context with the
STANDBY-to-PENDING cmpxchg, check BUSY and reject reuse with -EBUSY if a
previous invocation is still in progress.  Checking after the cmpxchg
orders the BUSY read after the STANDBY publication.

No irq_work has been queued for the attempted round at this point, so
the rejection can roll PENDING back to STANDBY.  Use cmpxchg for that
rollback to preserve FREED if a concurrent deletion has published it.
Once BUSY clears, scheduling can be retried.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 028fc6796b59..350269b8646e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4553,6 +4553,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	memset(ctx, 0, sizeof(*ctx));
 	refcount_set(&ctx->refcnt, 1); /* map's own ref */
 	ctx->state = BPF_TW_STANDBY;
+	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
 
 	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
 	if (old_ctx) {
@@ -4595,6 +4596,18 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 		bpf_task_work_ctx_put(ctx);
 		return ERR_PTR(-EBUSY);
 	}
+	/*
+	 * STANDBY can be published before the previous scheduling irq_work
+	 * returns. Claim PENDING before checking BUSY to order the check after
+	 * that publication. No irq_work has been queued for this attempt yet,
+	 * so reject reuse and roll back to STANDBY while BUSY is set. Preserve
+	 * FREED if deletion wins the rollback race.
+	 */
+	if (unlikely(irq_work_is_busy(&ctx->irq_work))) {
+		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
+		bpf_task_work_ctx_put(ctx);
+		return ERR_PTR(-EBUSY);
+	}
 
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
@@ -4644,7 +4657,6 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 	ctx->map = map;
 	ctx->map_val = (void *)tw - map->record->task_work_off;
 	init_task_work(&ctx->work, bpf_task_work_callback);
-	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
 
 	irq_work_queue(&ctx->irq_work);
 	return 0;
-- 
2.43.0

