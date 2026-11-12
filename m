Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499302;
	b=cI8TdWvbCQl1jYf+rjzHVEEMN0F81HtVVzvuWj/WiqBYUMGHwhXCKaqhWV31ql7Toi4T
	 KglPw4oC/eWM38IrQrGK6Ixpx/ovE8xZlE3DXo59x6pqbFyZzi55EeIYkWPpsV5H27dXe
	 7cK/S3gC6diVt13wgFMkuoyLa4qQ2ZwQQbDiNd2io+WZK+Vkv+ORGMb2BQQIUudMN1BeG
	 rSblrBdrgwDyRT6m02I7h+Ql0SivputkekhbMjsGI5kzQ9cp64OY0O2Qs1y+oQ9QlQ1gE
	 JIeZDP45yf8IZQfyhlGgb3mthqVKZzwkLwiqCcSWZLVcictGed+Mmqtv98b6gRkm3ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499302;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kjiQ212yf1PFzgc0XMcYedCjf1x/Z7XdUe85fS5QUeM=;
	b=DcsVPBDk8nYt+1dglhRruZgsDC3gffzeUJeUePx7mX2SiYXbgvl3/AOLiFJxRMbuCzz7
	 PoYjuJIcDGwIUnDcuuWIsWOfI5OO65NiQmQXaGfdPvr+PbcnO7GzRakD1hyZdrK5S8plE
	 PsUXMYgz5M1ZgVytGYgTYt+QnlZpKIO+hko+zXw/BihRGfzY6qZ0uu3ltEimBBVe5+Y1e
	 ctJ6fvDEpql463eMfJRscZ1nuefJrFu8fWU6PdOHITsf8BNgQTz2+N2rXQW0kRCTZJQ54
	 8g/U6SpkjI5Wy3e52lkwmM2rY7ToGmhLmqWcXFXRvyiX8bcjeTSZP4sfMsojuMLSrpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JakJZCtG;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1A606A327;
	Thu, 12 Nov 2026 16:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B1A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JakJZCtG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kjiQ212yf1PFzgc0XMcYedCjf1x/Z7XdUe85fS5QUeM=; b=JakJZCtGHFNweWgQDckDwc0f5Z
	gsEb4L65dV9gyPS6dxEOn6flj6hHJf0j9l0KfYyRTX3FB56NwnktQDJxy5EzK7QjlVIuYsB4voQdX
	wf6IXeLZ+Y7Zmh2/hMxOkA9JHeunIixny+YI819lSOor57L6jqA6D4owpapY9dAqUw+66ZmJ8/mal
	cE3oGap/WnkYIumfG6du72z4m3sc2fp0SgEeK+sIqNN2b0v3xSRGWEzKVgcGjixJ7fNXi6LhMYz3u
	lf57jd1GfuVYO8KixWLbVQO659mxDvVJR0vWB6kj890Qwrf+pVEXfviobjk6mL1rg7r9Re9lyng9C
	FEO6xd8g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXF3-00000008iFE-0mpe;
	Thu, 12 Nov 2026 16:01:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30AD33005AF; Thu, 12 Nov 2026 17:01:36 +0100 (CET)
Date: Thu, 12 Nov 2026 17:01:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost
 routes it back to sched_ext
Message-ID: <20261112160136.GF1922751@noisy.programming.kicks-ass.net>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-3-cui.tao@linux.dev>
 <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112152118.GD1813469@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 04:21:18PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 12, 2026 at 10:49:35PM +0800, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> > 
> > rt_mutex_setprio() is the only entry path into sched_ext that does not
> > block a retained donor: an ext task PI-boosted by an rt waiter can
> > block on a second kernel mutex while boosted, and on deboost is routed
> > back to sched_ext carrying the queued+blocked state that
> > scx_prepare_setscheduler() promises never happens; every PI cycle
> > hands the BPF scheduler a queued+blocked donor it never admitted.
> > 
> > Call scx_prepare_task_sched_change() before the sched_change guard when
> > the class change routes the task back to sched_ext, which performs the
> > missing sched_proxy_block_task() (plus an update_rq_clock() that is
> > harmless here: the clock was already advanced, so the second advance
> > only applies a small delta). The boost direction (ext -> rt) needs no
> > handling.
> 
> I can't understand this. And I take a very dim view of sprinking magic
> hooks like this. So no.

Ooh, is this the thing from here:

  https://patch.msgid.link/20260924075925.GE4121620%40noisy.programming.kicks-ass.net

where you need to block a task because ext doesn't want to support
proxy-exec?

Why can't anybody search email these days..

Something like so? Although I note the scx_block_proxy_donor() thing has
gotten more complicated, so perhaps this needs a little more?

Andrea?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a088d4576f5..1c1e669473a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11252,8 +11252,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
 	 */
 	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
 
-	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
-		p->sched_class->switching_to(rq, p);
+	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
+		bool block = p->sched_class->switching_to(rq, p);
+		if (block && p->is_blocked && ctx->queued) {
+			block_task(rq, p, READ_ONCE(p->__state));
+			ctx->queued = false;
+		}
+	}
 
 	if (ctx->queued)
 		enqueue_task(rq, p, ctx->flags);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca..4440e32236b3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -46,21 +46,6 @@ bool __scx_allow_proxy_exec(const struct task_struct *p)
 	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
 }
 
-/*
- * End retained proxy execution before changing @p's BPF scheduler ownership.
- * Called with @p's pi and rq locks held immediately before
- * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
- * is updated only once.
- */
-void scx_prepare_task_sched_change(struct task_struct *p)
-{
-	lockdep_assert_held(&p->pi_lock);
-	lockdep_assert_rq_held(task_rq(p));
-
-	update_rq_clock(task_rq(p));
-	scx_block_proxy_donor(task_rq(p), p);
-}
-
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -5004,12 +4989,12 @@ static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 }
 
-static void switching_to_scx(struct rq *rq, struct task_struct *p)
+static bool switching_to_scx(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (task_dead_and_done(p))
-		return;
+		return false;
 
 	scx_enable_task(sch, p);
 
@@ -5020,6 +5005,8 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 */
 	if (!scx_is_cid_type() && SCX_HAS_OP(sch, set_cpumask))
 		scx_call_op_set_cpumask(sch, rq, p, (struct cpumask *)p->cpus_ptr);
+
+	return !scx_allow_proxy_exec(p);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
@@ -8947,10 +8934,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
-		if (new_class == &ext_sched_class) {
-			scx_prepare_task_sched_change(p);
+		if (new_class == &ext_sched_class)
 			queue_flags |= DEQUEUE_NOCLOCK;
-		}
 
 		scoped_guard (sched_change, p, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index ff0a3d508533..961694e4c27c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2300,7 +2300,6 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
 bool scx_set_task_slice(struct task_struct *p, u64 slice);
 void scx_task_slice_ended(struct rq *rq, struct task_struct *p);
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
-void scx_prepare_task_sched_change(struct task_struct *p);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index b5d92d89629b..e73f3474d685 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1647,7 +1647,6 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p,
 		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
@@ -1680,7 +1679,6 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p,
 		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
@@ -2459,7 +2457,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scx_prepare_task_sched_change(p);
 		scoped_guard (sched_change, p,
 			      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 			/*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e0c10a5dbda2..cda367bd92af 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -547,7 +547,7 @@ static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 	update_curr_idle(rq);
 }
 
-static void switching_to_idle(struct rq *rq, struct task_struct *p)
+static bool switching_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d76950dbb0a..979c520034b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2782,7 +2782,7 @@ struct sched_class {
 	 */
 	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
-	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
+	bool (*switching_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
 	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 1e0109ec36b3..b7541bb7b593 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,7 +78,7 @@ static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
 {
 }
 
-static void switching_to_stop(struct rq *rq, struct task_struct *p)
+static bool switching_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
 }
