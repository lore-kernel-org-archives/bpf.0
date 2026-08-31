Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACB3D9541
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167228; cv=none; b=WBp6Os/0HjE57FitumNv4EQRLGJTeoDaTe+j7Qh+0IUsqeyLvctf9FHc5gN0rY5Z4PY+1u/tUW+Bm7Kd+xauGa8+CQ20ld78EURW2zDL4sAd4b6jgwd2DzuGI+Y1ELlRCa23flDJM2vzv9Sro0wSSwfb9Sgkm3WxkWRA1JsQqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167228; c=relaxed/simple;
	bh=j9Bk+0pj2/24u8T6/SP13Tt6ikszrpnpvXPCcD/6MLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajkUn6/j8eNXTzwFozViY7cUwFD6kE9DeQvKRIi3ud1De9y8AvzPRbzAx4VpzQP6z1CoLqciTnyHcmPqbu+teB0CsGVhWAR49AElpnrsa1XHQgNSbLIii4/f0g52pnzpVpb51CrxZcBWeV8Dl/xTdyBi3aG1Z7KBGnDXjdl+f/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwPiLMqQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwPiLMqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jsHCsFIe83xcZRq1DwfLWv9aF61ZEwjfkBd6QeliCQ=;
	b=fwPiLMqQ+KTc9drDsy0XeoFPhjja2Yf2mn0zi+kmm70i86RxmeldYyc+U9Bt4AsO1fO8WR
	xafLYDfywupK+VTyT3aBLYXXZqEU3PJcOa8lJQBLstvCkP3FrXuwSBOTHFpGgf03Uv/E49
	fVUYeBTXFKHewlk1aDjaatiKDpNoD88=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-3GBh1lUkPE2U7wQ8A-ui3Q-1; Mon,
 31 Aug 2026 05:07:00 -0400
X-MC-Unique: 3GBh1lUkPE2U7wQ8A-ui3Q-1
X-Mimecast-MFC-AGG-ID: 3GBh1lUkPE2U7wQ8A-ui3Q_1788167219
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB240182E6B4;
	Mon, 31 Aug 2026 09:06:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C234C18005BB;
	Mon, 31 Aug 2026 09:06:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Nam Cao <namcao@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 01/20] sched: Add task enqueue/dequeue trace points
Date: Mon, 31 Aug 2026 11:05:05 +0200
Message-ID: <20260831090524.106845-2-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Nam Cao <namcao@linutronix.de>

Add trace points into enqueue_task() and dequeue_task().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/events/sched.h |  8 ++++++++
 kernel/sched/core.c          | 12 +++++++++++-
 kernel/sched/sched.h         |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 535860581f15..d6e41edc25d2 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,14 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+DECLARE_TRACE(sched_enqueue,
+	TP_PROTO(struct task_struct *tsk, int cpu),
+	TP_ARGS(tsk, cpu));
+
+DECLARE_TRACE(sched_dequeue,
+	TP_PROTO(struct task_struct *tsk, int cpu),
+	TP_ARGS(tsk, cpu));
+
 #define DL_OTHER 0
 #define DL_TASK 1
 #define DL_SERVER_FAIR 2
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f78275192036..8561ca324943 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -121,6 +121,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_enqueue_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dequeue_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_update_tp);
@@ -2181,6 +2183,9 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))
+		trace_sched_enqueue_tp(p, cpu_of(rq));
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -2207,6 +2212,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  */
 inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	bool ret;
+
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
 
@@ -2223,7 +2230,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
-	return p->sched_class->dequeue_task(rq, p, flags);
+	ret = p->sched_class->dequeue_task(rq, p, flags);
+	if (trace_sched_dequeue_tp_enabled() && !(flags & DEQUEUE_SLEEP))
+		trace_sched_dequeue_tp(p, cpu_of(rq));
+	return ret;
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..a2cb06beafe6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3070,6 +3070,8 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 
 static inline void __block_task(struct rq *rq, struct task_struct *p)
 {
+	trace_sched_dequeue_tp(p, cpu_of(rq));
+
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible++;
 
-- 
2.55.0

