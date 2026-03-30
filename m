Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E8282F20
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881074; cv=none; b=QGs9ooDpOyqS1G83Dq6qiYaW5DrU+5sOfp/4rXfU6vgEACg5sV/czzOlo+2K5TcA6UtykIouXUJDO21Pwf9VI0Un16aLoC9+O0OXgCaeTVMuO4Qm2Rhmll6A8gVovw+VveM/dy+CY9IDIgmj7SXpsLNraFFHI8+WjMAL+69yifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881074; c=relaxed/simple;
	bh=bnBbRlTenAix/yOLsuLi2zgm1d0He5Qf8kUZ0BPi+6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4mtg8whBPj0MVnE0S3ixqSsBC7wb3jLt96KIkiNlfFsF1rzyCoHmia/QudYQ9mVct69QXdjL8blv6edaKAmCeEAbbRUwB48sVTYrgqQSeYyPYEbl8LotJYENrgB6trIASQ6Nd9dp9LmpsfISImHSsZWhMP+uxD8irs0g5vEVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqQPXUq+; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqQPXUq+"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-40974bf7781so4429137fac.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774881070; x=1775485870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y60MPJSl0ETCjEAGF4beWOWJyg3PunpEpCxZ9pS5PDU=;
        b=nqQPXUq+rvyfG9JcBQkg+kCstojLCcMjt4Xf5+pAvRtYPm++7EiDSHsNeGJAIrgVz/
         iHPUbBP5DFQzH5jpudpDr9HZXemvEv/To+PDBxPnWOmek01Luy9+T8t54tB22Zm9lxG6
         45QF6lO9GKN39489AwGE+wX4lui+/ObEzC8BDfu8z4TdqHM3Vy2zP+l5tCIe79eHMOW+
         3Z0CoIODfqibZ+R1EQpHnhJ1jleesJM8ZHSxaEmagxeY1dk+HXAHAhIKLkx8bZghtNPI
         Mj9pFFcTPv8Lti596lgg7gtDNWIdbsB/nblKEXLRybi7xrmGbGNSWRXHHvJXBWWm2XWq
         zVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881070; x=1775485870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y60MPJSl0ETCjEAGF4beWOWJyg3PunpEpCxZ9pS5PDU=;
        b=KuDURSFbXK6BpSqxLfRL+10lKUQmSMIWlt6uJjc2H+HsBj6fYnLjhDIAZUrHL8dimf
         CXBKD8ss2TKMioaW2qe73zM00XaR/Mt2jr7NoqQZ9Vhq366Ag7S8NT9f3/j7n2x0EZwY
         eufGaA0Eyogk3Y2PeAyi+SH9TUwNR/PEW0H0NTmZdNx/SitcB8BxwSpo7h9bMoyJDMWe
         BCEzTD5J41HSkICzGTE+pKs7MTN4lekcOvk+2e/TnfPr/l21s+UELQ66dWeGn3uvwLU6
         KZhLb9lrU6b3ASckPUserwqmtj0vV1wsYhamQ/KaYpkGrgUC8sHRX0i7DhSlS37W/NZq
         ja8A==
X-Gm-Message-State: AOJu0Yy36YpuN7UZIAgomY6ChCs3AfAnHgJeZm8Pq0rt5+ZptwXQki8r
	I+dWSGg7Ij6Ry0qWZhTkWf46Z4BTdoCdNX66iBTf8i6pVuYz7selDpckhyRNMLfw
X-Gm-Gg: ATEYQzzhMbNei6WQL9VI3xTABhqjC7TmN+7KNH2Z3FMQ+VS5U5MpUnGQf+C709ArI2z
	lR7Ka15/8D6RB82qeLHoX0InNPzBYUF3ei5keerQuIDoYKlFlPmO+VTua/3twNg3b71Su9zVB2r
	sRG9Tzhu4scz5JuqjqBxB56ldYyb0w1aEPEGTtbu6zs6yAwpp0c29eiBW21KaVYq47w8UpQKaZd
	oSo0wp3X1zaXT/nDZd4wTaKPTzEgZlWaw84Fdx9KRYsODHUcmUBZqKfVaM629SH3hDeNth7dSsb
	oQsO5SBu5OFKmpx6gI506RruczHPBg4b6S8a6st+PM9tGBxZ6gI+lgtthtqb6q8iMnLlfzV4vi7
	ax41+Xc6I/g36g9/44iR5P8edgyYHkjs+p+GsdB63jpN9xin8wCfkGhkz0ZcuEqYXfeycmEL0dD
	pHQORRaX0UCX4ByJj2T5ETV5ukRx+9hkO5de7VYsofEXc9
X-Received: by 2002:a05:6870:70a0:b0:41c:24f3:7851 with SMTP id 586e51a60fabf-41cd7a6ded0mr7404636fac.3.1774881069650;
        Mon, 30 Mar 2026 07:31:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d95bcasm5398826fac.17.2026.03.30.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:31:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 2/2] bpf: Retire rcu_trace_implies_rcu_gp()
Date: Mon, 30 Mar 2026 16:31:02 +0200
Message-ID: <20260330143102.1265391-3-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330143102.1265391-1-memxor@gmail.com>
References: <20260330143102.1265391-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8162; h=from:subject; bh=bnBbRlTenAix/yOLsuLi2zgm1d0He5Qf8kUZ0BPi+6M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfNUx84JPTuy5QQiS/tmuL1cmRfNsUHfhS8sQmWJstThZQcb 3l/oKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETkgxn+x2/nnF2nlrn84csi/ZR1j1 cd8dktfLNmidvHB23v3B6y6DH8z0iNavLgPq5px/nlQsuv0D/5B8JeHtKO9dkWJmQw708zHwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

RCU Tasks Trace grace period implies RCU grace period, and this
guarantee is expected to remain in the future. Only BPF is the user of
this predicate, hence retire the API and clean up all in-tree users.

RCU Tasks Trace is now implemented on SRCU-fast and its grace period
mechanism always has at least one call to synchronize_rcu() as it is
required for SRCU-fast's correctness (it replaces the smp_mb() that
SRCU-fast readers skip). So, RCU-tt GP will always imply RCU GP.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/rcupdate.h | 12 ------------
 kernel/bpf/core.c        | 10 ++++------
 kernel/bpf/helpers.c     |  2 +-
 kernel/bpf/memalloc.c    | 33 ++++++++++-----------------------
 kernel/bpf/syscall.c     | 24 ++++++------------------
 5 files changed, 21 insertions(+), 60 deletions(-)

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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6eb6c82ed2ee..a5a7961f68ec 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1272,7 +1272,7 @@ static void bpf_async_cb_rcu_tasks_trace_free(struct rcu_head *rcu)
 		return;
 	}
 
-	/* rcu_trace_implies_rcu_gp() is true and will remain so */
+	/* RCU Tasks Trace grace period implies RCU grace period. */
 	bpf_async_cb_rcu_free(rcu);
 }
 
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
index 89fa8f00adfa..e27573614f12 100644
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
@@ -3272,14 +3265,6 @@ static bool bpf_link_is_tracepoint(struct bpf_link *link)
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
@@ -3305,9 +3290,12 @@ static void bpf_link_free(struct bpf_link *link)
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

