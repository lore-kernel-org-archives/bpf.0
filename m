Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698030;
	b=LIL8JGiLlR4LCytM1zI0xja94IXXB9d+GmzWi82GT2oQxtgK56uf17D+WOQnXPC1sZdl
	 LKumcz5OxrWYbkGldxVDLUDuxZ6Va7EVu0nd06Xx3P0/T6TIr67T26hX/KxhoVujNkmaw
	 6tF0JgQH85mDPBXW7fT9D0DovCaq3la362F1Zm2b5kH3QeC92ac+JrF5WTT8hJuYhPhB7
	 FXsShxQI5DoWSh91H8+37+7fRf7zDtZqjmoeK0sBrf3x1TrBIisI4LhcxYEIAyHYv/yEH
	 AlG7Fp0bb1IJ8keL4EMH/+nUyIiK7N+fdLWxaYWy1cbVv/Yq2xRi3CAiELtC6Yx3AgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698030;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=xK1dmiwOiwCwvPal98PfYAomkOaGUBrsIBmMKkwymV4=;
	b=XDCJMigu9rDKn9YHu5UE38e1GOr6meJh6p+bMIqfjlnq4qp9lPoAbkvix/+XmUrumt62
	 o0oXTNMe0sqFReHxYJfE8iD+SSLtN751o1ohzH8+NPZ6OVkFw4KI59C6NMdYdZaAplG/A
	 cBuuwPIM30lNc2DpivIMeMhZaoxgexOVDIze4R5WfTM3OaA64P139Ug8nR6UIaGH+Ft5o
	 2yR+wpPyVd1kVKKWkelXa5viEFlHE/pGtF49XXv6fWsthJ62m2pYeqlDbFDp0x8o/rftS
	 0VAKAxR13qEQUwgb0SEYeoBzCTAWazhZBOMqeEiq1h+VT/kPJIsmRSyVKV78R/zI87Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QoTwLEuh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78515606A334
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78515606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QoTwLEuh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xK1dmiwOiwCwvPal98PfYAomkOaGUBrsIBmMKkwymV4=;
	b=QoTwLEuhMQvsJdX5rkyOmBq9d/5fS7W1dyhTWlWVdGbbS3+ABHAJEd2WCgTgxx1l9PsR96
	ThGu/q3K7az7ulZnBzmftlHdIePhcYY8dVD3kpbr3WB1Ypvd82sXfa76vBpw070dyFigyp
	ed/Mx40tfxdpEqUYqkPxqFIDAXsXbo0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-tXTy4eL7PfON-gg1Dj3ErA-1; Thu,
 26 Nov 2026 13:00:24 +0000
X-MC-Unique: tXTy4eL7PfON-gg1Dj3ErA-1
X-Mimecast-MFC-AGG-ID: tXTy4eL7PfON-gg1Dj3ErA_1795698021
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA1831800876;
	Thu, 26 Nov 2026 13:00:20 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACA8B1800550;
	Thu, 26 Nov 2026 13:00:16 +0000 (UTC)
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
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 01/18] sched: Add task enqueue/dequeue trace points
Date: Thu, 26 Nov 2026 13:59:47 +0100
Message-ID: <20261126130004.127155-2-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
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
index 515b9d0353ce..69800a8dec05 100644
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
@@ -2184,6 +2186,9 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))
+		trace_call__sched_enqueue_tp(p, cpu_of(rq));
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -2210,6 +2215,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  */
 inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	bool ret;
+
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
 
@@ -2226,7 +2233,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
-	return p->sched_class->dequeue_task(rq, p, flags);
+	ret = p->sched_class->dequeue_task(rq, p, flags);
+	if (trace_sched_dequeue_tp_enabled() && !(flags & DEQUEUE_SLEEP))
+		trace_call__sched_dequeue_tp(p, cpu_of(rq));
+	return ret;
 }
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4e6696e3a51..d22e6c6d1b2d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3148,6 +3148,8 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 
 static inline void __block_task(struct rq *rq, struct task_struct *p)
 {
+	trace_sched_dequeue_tp(p, cpu_of(rq));
+
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible++;
 
-- 
2.56.1

