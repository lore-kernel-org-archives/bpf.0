Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5835BDBB
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578958; cv=none; b=mQcvcBlef4+WS7VALF8su3MvKrwfmv5fzEKmMiyhKF7IK/QXXl4yqoZ8fDtCU8lt6mxZ/i9m14cDocsVQlitDje3Kxi3TCRpq+hOmnL2ie4RT7XvqpyCzswBmyAxqwBemsQk7YgapcPtio1QAEqZghENq2EN1cScqm7bF3SQAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578958; c=relaxed/simple;
	bh=1ppX9zTzk/l8pjaTQicO4S9//r51PescVaHTbBANGjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNOynNUv9xP1HaCUc35O+CVBxWllPsDS/OZ7hLc/gNiaWKxjHHAIoRu0ybVEWKOC2V0LnhThyCm9MzCavXjqASj4xLnq6gwN7RkDQOoJiUcU6WnOcOXrhSvEkHRpLiVhYQ8C+wfRoCbDv+rlAkaPdViZ27AK1LN5GUD1/zhxDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N86u06Ia; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N86u06Ia"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-471618e202bso594123b6e.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578956; x=1776183756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqW+UgHO3ec8zYYj4bXDHKV/YxRZbKU/iv20k+F5TFc=;
        b=N86u06Ia4YLFuAFh7XVQH/LnvowGNZiF23HTDEeGCsA/yF530EsQRc5ewlx2p630hc
         aIznWEjC8NyW8upLcSc5ErGobdRoqqHgqohsjqLWVwIW1RbaQlsvpDsQxeG2o5kXhaaR
         ZNap1x4iROCTOjQEs6xxBHCkH02AlphnhgXbGq15Ynqluh/QRaStnSnRcN/utIvba6sY
         TNk0BrUnnyI47y1hSXS4pux7mNeosiEtfbE5MppeiYyVVjmz3/z7QS0nefp6uZf+6dUh
         DmwcGdFbajxPzhIJeqNjlZWp8X/uTAalvmeJZqr6TfqIiJ6gqpsX42FE4RM6LaYyDga7
         o/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578956; x=1776183756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqW+UgHO3ec8zYYj4bXDHKV/YxRZbKU/iv20k+F5TFc=;
        b=f03HQrDvd2uk5h5e1YBWKfGPg5IUnMczQ5T0JVUmwXR127dfKhLUCzOX2ZqvOksEd5
         9L/qmBFg8Nf9DAZjtHy8KTFjK3qPN4DIr58pqiUztOZv7DDRzc8Ez8/L7KOsFSkH7fjY
         D9CEXeHrtDJn3wfXd2alQQBec+7diqU0kbB/X38kwA8v1VCR66SI8i3MeRg/BTUJfRSw
         8qgPX60NdSesNJJH00KUPV405VjLKQQoyhDH4vqvzm0uBsf1LEOk4CLS58cf9aGfuvOT
         ZvBrvrpvGoh59RWwE5amEUUI7m0/k8At+WU2bWz72Q+Uk+XGPE+o6ZSNeHJVEadSHjo6
         yT8A==
X-Gm-Message-State: AOJu0Yyf8w7KT6TFEe/eYBFrXSsJM33F1n3n/BhyRspIERzTFvvhKzXA
	FlKpmSTtDXEMksCXs6jjjaw14Ns4/2KYwmcS4okM5wWgITk3BNfaz3cir3yGJWFigwY=
X-Gm-Gg: AeBDietXVXgqL1qAlTPneY2PMLFGQ9ROhFnHT3jrqEKfE6P+KcUpTrDiShT2om+z5pB
	t5SZYOMlUqNImJ1KS7jIheq+IpNv54zX0WCDizu65LtMg2C53+y85lb/ZU5TtWOmxhj5H/FpWZz
	1u62Q9/E2Z7GvzdGZSIsZfgCi+IIlJ8C2KSkCsOGTFvJbfNveB3wWAcQlQYUOK8snczeklGEQRH
	HBDUiY7JafOer4CXTXnK6NlzbIdiSj8THR/a0YZsMPqFLDm0De/FkqeVTYDE/mTktRIqwC4zr2u
	15ABGsTjE63tRn27xGA6WhZbZ/NK8H81LDNTx4vVeI7Ven5Ydx/trHMtiwJgTijVMa4OkguoYE0
	uVDWaaFr0Cf8jRAwFLg+5Lph/vfHDyRl35+NpJ0SB3TsGwHWTN6jP0ZW4EXw937ZbY+B0KMvMYM
	ts3fmnuHSK2ReM09944b7bllFY+fjGXx7feyzF4KsvraPNMsdatEg31PY=
X-Received: by 2002:a05:6808:1511:b0:467:3f4:9073 with SMTP id 5614622812f47-46ef59f3b78mr8992123b6e.16.1775578955724;
        Tue, 07 Apr 2026 09:22:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d92a534f4sm10482281b6e.9.2026.04.07.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:22:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] bpf: Retire rcu_trace_implies_rcu_gp()
Date: Tue,  7 Apr 2026 18:22:33 +0200
Message-ID: <20260407162234.785270-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7960; h=from:subject; bh=mGlRdjvJNTsJ/pQirnBdRA7O/Wai58NLhhi1S3DwQg0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfOqvjC35foT7++LdVbd5pvNEvHgvBGHq2Lfl/4JLf2r3sg8 uFzVUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkcymD47zOzZsPk8zsn3hWc+fymyn YnjZzle+euOXAqxrWuXoelOJDhv3fSWrdrgT0di/ek+Qgd0TimcLma583W9LmcNmfnx+Td4wcA
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
 kernel/bpf/syscall.c     | 22 ++++------------------
 5 files changed, 19 insertions(+), 60 deletions(-)

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
index ee632f41bd83..89b89f55415c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2644,14 +2644,12 @@ static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
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
index 8352b7ee0f4d..bb95e287b0dc 100644
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
index f1044ab9b03b..b73b25c63073 100644
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
@@ -3273,14 +3266,6 @@ static bool bpf_link_is_tracepoint(struct bpf_link *link)
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
@@ -3306,7 +3291,8 @@ static void bpf_link_free(struct bpf_link *link)
 		 * faultable case, since it exclusively uses RCU Tasks Trace.
 		 */
 		if (link->sleepable || (link->prog && link->prog->sleepable))
-			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
+			/* RCU Tasks Trace grace period implies RCU grace period. */
+			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
 		/* We need to do a SRCU grace period wait for non-faultable tracepoint BPF links. */
 		else if (bpf_link_is_tracepoint(link))
 			call_tracepoint_unregister_atomic(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
--
2.52.0

