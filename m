Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2B3FDBF8
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762373; cv=none; b=WeGPLNwPAJuLZb1BQc3FcILl7FFzyIrIqYOyVrnz1x/MNFLlz6at9N19FmxuOb1mnDk8mGVtKLFKLvFv28yRmgHpL6ORn5iP7wSiaBlDWmztnxIullQBw4LmTrbW4yTAKbyZjE7584ILMYXsDoPOYJsqYM7b7hyhSnsVw3BSmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762373; c=relaxed/simple;
	bh=7GY5hpx8+EqQ76Ya5TuAsx3EImnLjqkiiq+Mw4OW2mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLw+oQG63dqvnS4KgqMUpbB1/gBfhDjjm9INhlZjL9A04a0YuUpbAjvZPs9BjFB4MnFbPR48Dqk1m9RZ7Q+FLW7534vdJSZGgdIxBwGRdsX13v/egLf7Ri2qY0A6vxa8HKcYF+quH00T3TLrioAtVvAN0KBz+yOx5g2erOdv7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq94YPEV; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq94YPEV"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d719d99dso5358075ad.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762369; x=1791367169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sH17az9uFZz38Kbg7AIU2pOP9EzlYK+1fmFZMjlzrxY=;
        b=aq94YPEVDQ7QqpJ3f5rc3m3GFHtqeiwcUH9xU6OPPP8NSSIFm5VEDE1bLFYFyx/UZn
         +gaw6oAxFL1IWe1dpJuRe1M7zbL9wQdvzewoST8DXTLZLa60fHeLkUFNzE9Lv0PDRwUX
         gp+FUDrsWDYZz8sErEiwBJc1szoHPM6FRPImpQeSH2ll0K6alifkXuEJNWEjj/eRmIl1
         CxprPTKDDzN8hpQjwrbkY5CvE71fRtE9pVwvYxV/W6u0ad2UG/1L7etvZrKvjJQm3/cd
         pCw1LmvyFHo2kEnme0ikX6WLJZfdGt6wgb7fGRGvkwOWEpdA9AqPdpoEfKbSHKtCOuNG
         reEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762369; x=1791367169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sH17az9uFZz38Kbg7AIU2pOP9EzlYK+1fmFZMjlzrxY=;
        b=dmbkz35eiI7rBYTRglqmN9tl80JHAbN9Ifg2lpwK9zvdKsrdFRD8xrni+pL2Kmn/qK
         Y8RP6vSb+CPCA4Mlzimsj+0NfhBjjEbYon1ziOFrRb6KoKeFuQvb9iZMDSOYMMUI8g3Z
         WNahWccOMh9LxmYh8d1+WTMf9ETYmiQ5bJ90upWCXHobgwc4MhIEOdNroYpBH+V8VLaZ
         uLCrxSPdz5XY+pD+cUnFFIEJ0OwCNN2+2ypAjv2FbqtGeQuRFHPOcD+1XWsW4hE0Tj43
         ePaMx4JOVgLtAqjhViTscjB/GN57zEaW5hGLqc8QvsLuW+7nXu9k/cySRLsgDMMVHXF0
         5arw==
X-Gm-Message-State: AFq9FYK5GKzwWrmB9j5p/XdVVsq7W5KmCEczdLHpvCzuXdTT2u7IHvtB
	ZTg1E9uc7OIGyiyUrrGbsOmUOSlyVqgk5/3+tqqW7uQFvkOHAsmkNU+uqcebV90E
X-Gm-Gg: AYBFou3DJKvBx/U0ALKBKSk1VYyVBOpFvdROFFg0dcdCKL25dQg11XE8I0QcV/cbo0X
	1A0fYNuGe5vhX420LQQpdfc/7GidyVdysATS7dN5t6tCcVJuJdc93jbOihTVcTNxPU7UGPcfeQd
	TjfMdVhTtLu5f1oq3VXpqPMlQvVP62CXRc1Ajk2tpeibexkT79EQxWe/mOP72+OPOFhxkJBiwYr
	3bLzR/1abS9kw28rqCD/ouX+7cDD6LjaxGZKiYD8UC3qrYX4PLh6++E6XNCUe5bVZZfrKlLRDcx
	UXg6NVFF13iKmEMuXuiI/9PxiQYkW/f1m6fxazRq8YZDhpwxZhvrrLh0HLRnG1ia17QTNCHWayV
	Xf9g9oq46UMApwnS80Mnx9O16dP1nbgLAdNMKGFvYeWFrLm7zTsVdlwDAyZ8EAQnBRgF5/cpsP5
	oskca8QU7f0bDjAFp+beRTMC+QKewoDeRdrghgSDKTrx3qTYIHDDXIRrfxmNY35q8w41zleKgTm
	lMT7pskn/oBcz3W5ttq89hXBuSikf1Qfrf9tdYWFd8pAnbskqt3EnYX/zAv/DIDG/+J4geL5dIV
	PUvdh1qyj/VlfUqTNV94ku4lfL/9k4dipLlUrC4uF4ZTjA==
X-Received: by 2002:a17:902:ce84:b0:2df:99e6:9448 with SMTP id d9443c01a7336-2e2e4ba8328mr6522355ad.61.1790762368604;
        Wed, 30 Sep 2026 02:59:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5bf40f6sm4661875ad.59.2026.09.30.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:59:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 2/3] bpf: Fix objects stuck in free_by_rcu_ttrace
Date: Wed, 30 Sep 2026 09:59:19 +0000
Message-ID: <20260930095920.601738-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
References: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

do_call_rcu_ttrace() returns early when call_rcu_ttrace_in_progress is set
and leaves the objects in free_by_rcu_ttrace. __free_rcu() frees
waiting_for_gp_ttrace only and clears the flag. Hence the objects that
free_bulk() or __free_by_rcu() added while RCU tasks trace GP was in flight
stay in free_by_rcu_ttrace until free_bulk() or alloc_bulk() is called for
the same bpf_mem_cache again, which may never happen. The number of such
objects is not bounded.

Turn call_rcu_ttrace_in_progress into three states:
0 - idle
1 - __free_rcu() is queued
2 - __free_rcu() is queued and free_by_rcu_ttrace got more objects since

do_call_rcu_ttrace() sets 2. __free_rcu() does cmpxchg(1 -> 0) and starts
the next GP when it fails. It cannot clear the flag first and check
free_by_rcu_ttrace later, since bpf_mem_alloc_destroy() frees bpf_mem_cache
without waiting for RCU callbacks when the flag is zero.

Now __free_rcu() queues itself, so the one that didn't see 'draining' may
do call_rcu_tasks_trace() after rcu_barrier_tasks_trace() in
free_mem_alloc(). Queue it under rcu_read_lock() and do synchronize_rcu()
before the barriers. Calling rcu_barrier_tasks_trace() twice works too, but
creating and destroying hash maps in a loop on many cpus slows down to one
free_mem_alloc() per GP and kworkers pile up.

Fixes: 8d5a8011b35d ("bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 08e4dde66cd5..15684d0fc883 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -118,6 +118,11 @@ struct bpf_mem_cache {
 	struct llist_head free_by_rcu_ttrace;
 	struct llist_head waiting_for_gp_ttrace;
 	struct rcu_head rcu_ttrace;
+	/*
+	 * 0 - idle
+	 * 1 - __free_rcu() is queued
+	 * 2 - __free_rcu() is queued and free_by_rcu_ttrace got more objects since
+	 */
 	atomic_t call_rcu_ttrace_in_progress;
 	raw_spinlock_t lock;
 };
@@ -276,6 +281,8 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
 	return cnt;
 }
 
+static void __do_call_rcu_ttrace(struct bpf_mem_cache *c);
+
 static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
@@ -285,7 +292,19 @@ static void __free_rcu(struct rcu_head *head)
 		llnode = llist_del_all(&c->waiting_for_gp_ttrace);
 
 	free_all(c, llnode, !!c->percpu_size);
-	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
+
+	/*
+	 * do_call_rcu_ttrace() that ran while GP was in flight left its objects
+	 * in free_by_rcu_ttrace. This cache may never free or alloc in bulk
+	 * again, so start the next GP from here.
+	 * 'c' can be freed as soon as call_rcu_ttrace_in_progress is zero.
+	 */
+	if (atomic_cmpxchg(&c->call_rcu_ttrace_in_progress, 1, 0) == 1)
+		return;
+
+	/* Pairs with synchronize_rcu() in free_mem_alloc() */
+	guard(rcu)();
+	__do_call_rcu_ttrace(c);
 }
 
 static void enque_to_free(struct bpf_mem_cache *c, void *obj)
@@ -302,6 +321,12 @@ static void __do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
+	/*
+	 * Must be done before llist_del_all(). Objects that it misses were
+	 * added by do_call_rcu_ttrace() that will set 2 after this store.
+	 */
+	atomic_set(&c->call_rcu_ttrace_in_progress, 1);
+
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
 		llist_add(llnode, &c->waiting_for_gp_ttrace);
@@ -323,7 +348,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode;
 
-	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
+	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 2)) {
 		if (unlikely(READ_ONCE(c->draining))) {
 			scoped_guard(raw_spinlock_irqsave, &c->lock)
 				llnode = llist_del_all(&c->free_by_rcu_ttrace);
@@ -707,7 +732,12 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
 	 * to wait for the pending __free_by_rcu(), and __free_rcu(). RCU Tasks
 	 * Trace grace period implies RCU grace period, so all __free_rcu don't
 	 * need extra call_rcu() (and thus extra rcu_barrier() here).
+	 *
+	 * __free_rcu() queues itself again unless it sees 'draining'. After
+	 * synchronize_rcu() it either did that already or will not do it, so
+	 * rcu_barrier_tasks_trace() cannot miss it.
 	 */
+	synchronize_rcu();
 	rcu_barrier(); /* wait for __free_by_rcu */
 	rcu_barrier_tasks_trace(); /* wait for __free_rcu */
 	free_mem_alloc_no_barrier(ma);
-- 
2.55.0

