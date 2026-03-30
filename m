Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732140DFB4
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840895; cv=none; b=LgrNq1VXdF6eGOEjqUPXO/3cjHYy3T7HPm2SU4MS2tae8OYkUDalhTV1iMHTVa6FKAGif6FcV4h21uzwH6RvVS88Y+VSi3kUb9KKwLC0UyyVdNa6loCm3WhtmaxYdZuhQSZ8NQjpJ9Z7D6Rp1m78RVuGXHsLdfUmMgWcTJO9aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840895; c=relaxed/simple;
	bh=Hf3zkIKK+izGK8j/LvgqXAQqO/tDRDrD3XnJBCvy7fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdqNK7OJJJxbakgffI/hKnqEVn43tXGEGd/6tHwFc6+0RHZOIjjK2GrtiPATy7IrSi/hy5RBJLGht145ROyKUrminEEJO5ll5/5AkvejtqSDAIeHZhIRvq+GgCejvMXT8J+V6il+oNJoMggqsZnWKWafpQBYeSr6DkdCzEgcsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXY/jCb7; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXY/jCb7"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-40423dbe98bso1519367fac.2
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 20:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774840892; x=1775445692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXzDgKqGL12N3x19E8X5JLSSPmqb+Y9PJmrPfVj/Sew=;
        b=UXY/jCb79WX04ArcenIDYmhNHXa05WLbNrCBo6sgrFBQ3qsxp9qJfX/XOVbCrAl0MF
         9RNTh6Akk/+jeJNBNQaRYvtCwx2E0NVEoaLzGEQTe80Xq0Fj4d5g5oxbKxP+AiUykHlL
         wV2Soyf9nJ4ZFgmDty7LgkOipITqsl0ph49LIA+R4cswvJV0IhYlZyW1XxLtp8eQ2zWO
         bK50+B+57ljB+mVO851OPUpqhOrH5KDoAD9dR1xeU2KI7v3bNGOWT6i/O9T7IozewuwQ
         gVTvR9J47BYIGTkHH0u47gjSXbHWB6pHuzw14VGNExA87S1HBDpd0qXDAfky13ZM0VyS
         E/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774840892; x=1775445692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hXzDgKqGL12N3x19E8X5JLSSPmqb+Y9PJmrPfVj/Sew=;
        b=VRxQgkNY4hvvCpQJ2ZQtBMzDBaXfWvJQxMpUnuL5AdOmcLM1AJGP/1+2KcVy/8SI7w
         TDSqED2sPa157JXrWO8Qz9HU1DxyqhStioYm3c9wvka9F+HLh/gK3Dru8OXRqlyz5n1m
         8qyVdTk9hS/VuCJ+tFH2OKrXj7WDFZAEqEXMleeAkRityHbIdZJIYgNvqROTArkBLhL9
         gJpyAtFmRIGTtFASXtltsB0py44fOF1zvTbMVg6F4L4bv/dUwf5K5A+2mBAmPuI0YBEd
         OVKXIGFuG18zZAWXd0NIQ7kmso1SEnuRcVshmKqkBPMLAqQ2X+sSqP0+QKv8v3z8ewc4
         oAVA==
X-Gm-Message-State: AOJu0YyoCM90N8UIe7e4RAGWZtud8A8fHBjONC+Y/SrFCAjDyhe/0pC+
	k4V/AvWAoZpb9jq/9g7/ajHPcMcrdtv+f4RR8rubE+twtpWFKfodzd1koHbvEflS
X-Gm-Gg: ATEYQzwFXKCsnSHfZK4qUin8SQRWBfTPHm0IFlZMeehc1UUgIKEMI2yK15ruVKAfUCz
	ES+bMTMFA5Sl8TrIgJeUSkzjNzExGAq5ydgCU0J7evtejGC1YcebKk7ONdGZKlSxU3/He1fK/nj
	GgGoNxrZ0h6UuJkEH8H2pV/uyvR1m4mCiSOzO5iXlruxZPw8aN/3o3tTvHkRLYAZeo1JPVQ6dym
	gjc3QY+Y2yfmKBZlztXk0/afUMR0PEtBkVKig/Ku+9dL0Mj1UW597vVM92162Tt3YuTAI4XoOPM
	cguXgsCb2ILLjERwo4JZ4Hk13GsNhJV/J1oaFQTqEyM63dap8EkeN3FUTvmVEEUs9xUm8Irm7HK
	x2b5pA4UViVH1DP9zCstYDaXCXdETClp2BM+729eaFLyRTAOojCK7txT6epTM7E3v/QQQpQJsZO
	snVPvEol4aF/jUDT6i6+05g6PftdQ2WMbAJPsFXnHZdAF+1IAeQ9sbUw==
X-Received: by 2002:a05:6870:3111:b0:417:2a17:285 with SMTP id 586e51a60fabf-41cec2ab328mr5634784fac.30.1774840892193;
        Sun, 29 Mar 2026 20:21:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d048e1984sm4402138fac.4.2026.03.29.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 20:21:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] bpf: Retire rcu_trace_implies_rcu_gp()
Date: Mon, 30 Mar 2026 05:21:23 +0200
Message-ID: <20260330032124.3141001-3-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330032124.3141001-1-memxor@gmail.com>
References: <20260330032124.3141001-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7316; h=from:subject; bh=Hf3zkIKK+izGK8j/LvgqXAQqO/tDRDrD3XnJBCvy7fQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPkG04vy2a3P+83dXF0Cu3ZcVTrlsX/TQ+8/3apHjSIKbdd IXGzo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJVWFkaFdos7fct+ln8JZpl3XCHv Wsrj3jEKHUzMEXUXt/zr2MCwz/E81LM5RLbfs4nXum829af3v/0t7fOgbF3gwPPrn8P/eSCwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

RCU Tasks Trace grace period implies RCU grace period, and this
guarantee is expected to remain in the future. Only BPF is the user of
this predicate, hence retire the API and clean up all in-tree users.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/rcupdate.h | 12 ------------
 kernel/bpf/core.c        | 10 ++++------
 kernel/bpf/memalloc.c    | 33 ++++++++++-----------------------
 kernel/bpf/syscall.c     | 24 ++++++------------------
 4 files changed, 20 insertions(+), 59 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 04f3f86a4145..bfa765132de8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,18 +205,6 @@ static inline void exit_tasks_rcu_start(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
-/**
- * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
- *
- * As an accident of implementation, an RCU Tasks Trace grace period also
- * acts as an RCU grace period.  However, this could change at any time.
- * Code relying on this accident must call this function to verify that
- * this accident is still happening.
- *
- * You have been warned!
- */
-static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
-
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7b675a451ec8..1984f061dcf4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2641,14 +2641,12 @@ static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
 {
 	struct bpf_prog_array *progs;
 
-	/* If RCU Tasks Trace grace period implies RCU grace period, there is
-	 * no need to call kfree_rcu(), just call kfree() directly.
+	/*
+	 * RCU Tasks Trace grace period implies RCU grace period, there is no
+	 * need to call kfree_rcu(), just call kfree() directly.
 	 */
 	progs = container_of(rcu, struct bpf_prog_array, rcu);
-	if (rcu_trace_implies_rcu_gp())
-		kfree(progs);
-	else
-		kfree_rcu(progs, rcu);
+	kfree(progs);
 }
 
 void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 682a9f34214b..e9662db7198f 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -284,17 +284,6 @@ static void __free_rcu(struct rcu_head *head)
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
-static void __free_rcu_tasks_trace(struct rcu_head *head)
-{
-	/* If RCU Tasks Trace grace period implies RCU grace period,
-	 * there is no need to invoke call_rcu().
-	 */
-	if (rcu_trace_implies_rcu_gp())
-		__free_rcu(head);
-	else
-		call_rcu(head, __free_rcu);
-}
-
 static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 {
 	struct llist_node *llnode = obj;
@@ -326,12 +315,12 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 		return;
 	}
 
-	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
-	 * If RCU Tasks Trace grace period implies RCU grace period, free
-	 * these elements directly, else use call_rcu() to wait for normal
-	 * progs to finish and finally do free_one() on each element.
+	/*
+	 * Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
+	 * RCU Tasks Trace grace period implies RCU grace period, so pass
+	 * __free_rcu directly as the callback.
 	 */
-	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
+	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu);
 }
 
 static void free_bulk(struct bpf_mem_cache *c)
@@ -696,20 +685,18 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
+	/*
+	 * waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
 	 * might still execute. Wait for them.
 	 *
 	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
 	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
-	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
-	 * so if call_rcu(head, __free_rcu) is skipped due to
-	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
-	 * using rcu_trace_implies_rcu_gp() as well.
+	 * to wait for the pending __free_by_rcu(), and __free_rcu(). RCU Tasks
+	 * Trace grace period implies RCU grace period, so all __free_rcu don't
+	 * need extra call_rcu() (and thus extra rcu_barrier() here).
 	 */
 	rcu_barrier(); /* wait for __free_by_rcu */
 	rcu_barrier_tasks_trace(); /* wait for __free_rcu */
-	if (!rcu_trace_implies_rcu_gp())
-		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ab61a5ce35af..dbba0a5fa96e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -941,14 +941,6 @@ static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
 	bpf_map_free_in_work(container_of(rcu, struct bpf_map, rcu));
 }
 
-static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
-{
-	if (rcu_trace_implies_rcu_gp())
-		bpf_map_free_rcu_gp(rcu);
-	else
-		call_rcu(rcu, bpf_map_free_rcu_gp);
-}
-
 /* decrement map refcnt and schedule it for freeing via workqueue
  * (underlying map implementation ops->map_free() might sleep)
  */
@@ -959,8 +951,9 @@ void bpf_map_put(struct bpf_map *map)
 		bpf_map_free_id(map);
 
 		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
+		/* RCU tasks trace grace period implies RCU grace period. */
 		if (READ_ONCE(map->free_after_mult_rcu_gp))
-			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
+			call_rcu_tasks_trace(&map->rcu, bpf_map_free_rcu_gp);
 		else if (READ_ONCE(map->free_after_rcu_gp))
 			call_rcu(&map->rcu, bpf_map_free_rcu_gp);
 		else
@@ -3268,14 +3261,6 @@ static bool bpf_link_is_tracepoint(struct bpf_link *link)
 	       (link->type == BPF_LINK_TYPE_TRACING && link->attach_type == BPF_TRACE_RAW_TP);
 }
 
-static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
-{
-	if (rcu_trace_implies_rcu_gp())
-		bpf_link_defer_dealloc_rcu_gp(rcu);
-	else
-		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
-}
-
 /* bpf_link_free is guaranteed to be called from process context */
 static void bpf_link_free(struct bpf_link *link)
 {
@@ -3301,9 +3286,12 @@ static void bpf_link_free(struct bpf_link *link)
 		 * period wait instead when non-faultable tracepoint is used. We
 		 * don't need to chain SRCU grace period waits, however, for the
 		 * faultable case, since it exclusively uses RCU Tasks Trace.
+		 *
+		 * RCU Tasks Trace grace period implies RCU grace period, hence
+		 * pass bpf_link_defer_dealloc_rcu_gp as callback directly.
 		 */
 		if (link->sleepable || (link->prog && link->prog->sleepable))
-			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
+			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
 		/* We need to do a SRCU grace period wait for tracepoint-based BPF links. */
 		else if (bpf_link_is_tracepoint(link) && tp_srcu)
 			call_srcu(tp_srcu, &link->rcu, bpf_link_defer_dealloc_rcu_gp);
-- 
2.52.0

