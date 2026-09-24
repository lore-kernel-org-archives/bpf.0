Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4E46D0AD
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267350; cv=none; b=Q8PCi0I014/IOkTQCHdCH0lnboq+pXmCsyrKs/W7P7vGRWK9zsX/ICqyMntU7ySfoUopcXoLu6+rbCWDfL8lBYX0Hi1l8LmiUVERSa//C+4ia9s4YVdNP6P5pHiYrVkqu3KxR4c5hOgZT2C/d3YU7+aEcFdvjC545CMYncldv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267350; c=relaxed/simple;
	bh=lw4u2JXa2q54QaAW65v3/Ap/sdbhtBFq9RUX2spt+uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPWqhViRDoMRNSockQhcv0GI+x+i57QltWqlLmBsQcz3WChq4QZnC70s+raRhivPAxBzm9/DyQOjNLvOXCVOmDStPn1+i3nVibj9zNBhwk6yKbUJmXi6Ztq9EKfjVVTn5Mv1uUQSptY18SYXuSf/r8+hEEIb+zuN2l3sotTdfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7Ht7SMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7Ht7SMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE44B1F000FF;
	Thu, 24 Sep 2026 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267348;
	bh=7XgvilLlUmLqFs0KdkrUfPA1Oq4fHguTCiMxh8XiDiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7Ht7SMStLdA0biI7GT9eS6PESxqwo5wi8uEH3vJRYrti0RdO141d42a31T0ioGo2
	 OenHHbWEvOuB4Mcebu14Ho0N8eTuyb6zMkKBu/J4RzGp1mqwibyOESeSyfDVnCu/jB
	 p+TmjsgbHXboeH3PQs+hQOKUvgOX3dgcZwEaO//z7ztIJnLnvLdkKYN5Yel7mt92Hv
	 mzAWUIjygDmrHxPaZeRGI07xJi748M02jwXYUb7mUEe8B7jLynLaY940foOB32Oc6V
	 a3fFRN2/a1FwU9Yvj9n5BBcWML+/oJ6yYVMX1oQ0jQKZlzIVM7bO/Z4+IUoxPAU4tv
	 aOGQbiyDZzWLA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 1/2] bpf: Support bpf_rcu_head in hash and LRU hash maps
Date: Thu, 24 Sep 2026 09:28:56 -0700
Message-ID: <20260924162858.2435106-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162858.2435106-1-puranjay@kernel.org>
References: <20260924162858.2435106-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_call_rcu() is restricted to arrays because an array element is never
freed while the map is alive. Hash elements are recycled, and an RCU
callback cannot be cancelled, so a delete racing a queued callback would
hand the element back to the allocator underneath it.

Keep the element alive until the callback has run. Before releasing an
element the map calls bpf_rcu_head_claim(), which marks the head dead and
reports whether a callback is queued or running. If one is, the element is
unlinked but not returned to the allocator; the callback does that through
a new map_release_elem(), since only the map knows whether that is a
freelist push or bpf_mem_cache_free(). The dead bit stops it being armed
again, so there is a definite last callback. Timers and friends in the
same value are still cancelled on delete.

The head and the element are busy for different spans: RCU dequeues a head
before invoking it, so it can be re-armed from inside the callback, while
the element has to live until the callback returns. ARMED covers the head,
RUNNING the element, and whoever clears the last of the two releases a dead
element. RUNNING is dropped under the read locks, so only one callback runs
on a head at a time.

The dead bit lives in the element, so alloc_htab_elem() and
prealloc_lru_pop() reset the head when they hand one out.

A preallocated htab stashes the old element in a per-CPU spare on update
rather than freeing it, which cannot be done to one with a queued callback,
so maps carrying a head take the freelist path instead.

For LRU the eviction path asks bpf_rcu_head_busy() and declines, leaving
the element in the map.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h  |   5 ++
 kernel/bpf/hashtab.c | 104 +++++++++++++++++++++++++++++++++-----
 kernel/bpf/helpers.c | 117 ++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |  14 +++++-
 4 files changed, 214 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1e1ce2afe2ed8..91eee1d066a32 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -111,6 +111,8 @@ struct bpf_map_ops {
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
 	long (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
 	long (*map_delete_elem)(struct bpf_map *map, void *key);
+	/* Release an element a bpf_rcu_head callback was holding. */
+	void (*map_release_elem)(struct bpf_map *map, void *value);
 	long (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
 	long (*map_pop_elem)(struct bpf_map *map, void *value);
 	long (*map_peek_elem)(struct bpf_map *map, void *value);
@@ -665,6 +667,9 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 void bpf_timer_cancel_and_free(void *timer);
 void bpf_wq_cancel_and_free(void *timer);
 void bpf_task_work_cancel_and_free(void *timer);
+bool bpf_rcu_head_claim(struct bpf_map *map, void *value);
+bool bpf_rcu_head_busy(struct bpf_map *map, void *value);
+void bpf_rcu_head_reset(struct bpf_map *map, void *value);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
 void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f744a42bb8139..5e2f4cbe9d0f2 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -188,6 +188,11 @@ static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
 	return l->key + round_up(key_size, 8);
 }
 
+static inline struct htab_elem *htab_elem_from_value(void *value, u32 key_size)
+{
+	return value - round_up(key_size, 8) - offsetof(struct htab_elem, key);
+}
+
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
@@ -310,6 +315,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 		bpf_map_inc_elem_count(&htab->map);
 		l = container_of(node, struct htab_elem, lru_node);
 		memcpy(l->key, key, htab->map.key_size);
+		bpf_rcu_head_reset(&htab->map, htab_elem_value(l, htab->map.key_size));
 		return l;
 	}
 
@@ -904,6 +910,11 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	int ret;
 
 	tgt_l = container_of(node, struct htab_elem, lru_node);
+
+	/* An element a callback still needs cannot be evicted. */
+	if (bpf_rcu_head_busy(&htab->map, htab_elem_value(tgt_l, htab->map.key_size)))
+		return false;
+
 	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
@@ -914,15 +925,24 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
-			bpf_map_dec_elem_count(&htab->map);
 			break;
 		}
 
 	htab_unlock_bucket(b, flags);
 
-	if (l == tgt_l)
-		check_and_cancel_fields(htab, l);
-	return l == tgt_l;
+	if (l != tgt_l)
+		return false;
+
+	/*
+	 * An arm can land after the check above. The element is already unlinked
+	 * by now, so map_release_elem() finishes the handoff to the free list.
+	 */
+	if (bpf_rcu_head_claim(&htab->map, htab_elem_value(l, htab->map.key_size)))
+		return false;
+
+	bpf_map_dec_elem_count(&htab->map);
+	check_and_cancel_fields(htab, l);
+	return true;
 }
 
 /* Called from syscall */
@@ -1032,7 +1052,7 @@ static void dec_elem_count(struct bpf_htab *htab)
 		atomic_dec(&htab->count);
 }
 
-static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
+static void __free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 {
 	htab_put_fd_value(htab, l);
 
@@ -1046,6 +1066,25 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	}
 }
 
+/* The element is already unlinked; only the return to the allocator is left. */
+static void htab_map_release_elem(struct bpf_map *map, void *value)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+
+	__free_htab_elem(htab, htab_elem_from_value(value, htab->map.key_size));
+}
+
+static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
+{
+	if (bpf_rcu_head_claim(&htab->map, htab_elem_value(l, htab->map.key_size))) {
+		/* The element outlives the delete; its timer and friends do not. */
+		check_and_cancel_fields(htab, l);
+		return;
+	}
+
+	__free_htab_elem(htab, l);
+}
+
 static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 			    void *value, bool onallcpus, u64 map_flags)
 {
@@ -1107,6 +1146,17 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 	return is_fd_htab(htab) && BITS_PER_LONG == 64;
 }
 
+/*
+ * On update a preallocated htab stashes the old element in this CPU's spare
+ * instead of freeing it. An element with a queued callback cannot be reused
+ * that way, so those maps release it through free_htab_elem() instead.
+ */
+static bool htab_stashes_old_elem(const struct bpf_htab *htab)
+{
+	return htab_is_prealloc(htab) &&
+	       !btf_record_has_field(htab->map.record, BPF_RCU_HEAD);
+}
+
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 					 void *value, u32 key_size, u32 hash,
 					 bool percpu, bool onallcpus,
@@ -1118,7 +1168,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	void __percpu *pptr;
 
 	if (prealloc) {
-		if (old_elem) {
+		if (old_elem && htab_stashes_old_elem(htab)) {
 			/* if we're updating the existing element,
 			 * use per-cpu extra elems to avoid freelist_pop/push
 			 */
@@ -1129,9 +1179,18 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			struct pcpu_freelist_node *l;
 
 			l = __pcpu_freelist_pop(&htab->freelist);
-			if (!l)
-				return ERR_PTR(-E2BIG);
-			l_new = container_of(l, struct htab_elem, fnode);
+			if (l) {
+				l_new = container_of(l, struct htab_elem, fnode);
+			} else {
+				/* Spend the spare; freeing old_elem refills the freelist. */
+				if (!old_elem)
+					return ERR_PTR(-E2BIG);
+				pl_new = this_cpu_ptr(htab->extra_elems);
+				l_new = *pl_new;
+				if (!l_new)
+					return ERR_PTR(-E2BIG);
+				*pl_new = NULL;
+			}
 			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
@@ -1152,6 +1211,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	}
 
 	memcpy(l_new->key, key, key_size);
+	bpf_rcu_head_reset(&htab->map, htab_elem_value(l_new, key_size));
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
@@ -1293,11 +1353,11 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* l_old has already been stashed in htab->extra_elems, cancel
 		 * its reusable special fields before it is available for reuse.
 		 */
-		if (htab_is_prealloc(htab))
+		if (htab_stashes_old_elem(htab))
 			check_and_cancel_fields(htab, l_old);
 	}
 	htab_unlock_bucket(b, flags);
-	if (l_old && !htab_is_prealloc(htab))
+	if (l_old && !htab_stashes_old_elem(htab))
 		free_htab_elem(htab, l_old);
 	return 0;
 err:
@@ -1305,13 +1365,31 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	return ret;
 }
 
-static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
+static void __htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
 	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
+static void htab_lru_map_release_elem(struct bpf_map *map, void *value)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+
+	__htab_lru_push_free(htab, htab_elem_from_value(value, htab->map.key_size));
+}
+
+static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
+{
+	if (bpf_rcu_head_claim(&htab->map, htab_elem_value(elem, htab->map.key_size))) {
+		/* The element outlives the delete; its timer and friends do not. */
+		check_and_cancel_fields(htab, elem);
+		return;
+	}
+
+	__htab_lru_push_free(htab, elem);
+}
+
 static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 				     u64 map_flags)
 {
@@ -2399,6 +2477,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_lookup_elem = htab_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
+	.map_release_elem = htab_map_release_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_gen_lookup = htab_map_gen_lookup,
 	.map_seq_show_elem = htab_map_seq_show_elem,
@@ -2422,6 +2501,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
 	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
 	.map_update_elem = htab_lru_map_update_elem,
+	.map_release_elem = htab_lru_map_release_elem,
 	.map_delete_elem = htab_lru_map_delete_elem,
 	.map_gen_lookup = htab_lru_map_gen_lookup,
 	.map_seq_show_elem = htab_map_seq_show_elem,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 301b35bd85c8a..07bd782f38b9c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4807,15 +4807,30 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
 
 typedef int (*bpf_rcu_callback_t)(struct bpf_map *map, void *key, void *value);
 
+/* ARMED covers the head, RUNNING the element; a re-arming callback holds both. */
+#define RCU_HEAD_DEAD		BIT(0)		/* element is being released */
+#define RCU_HEAD_ARMED		BIT(1)		/* head is queued */
+#define RCU_HEAD_RUNNING	BIT(2)		/* callback has not returned */
+#define RCU_HEAD_BUSY		(RCU_HEAD_ARMED | RCU_HEAD_RUNNING)
+
 /* Actual type for struct bpf_rcu_head */
 struct bpf_rcu_head_kern {
 	struct rcu_head rcu;
 	bpf_callback_t callback_fn;
 	struct bpf_map *map;
 	struct bpf_prog *prog;
-	u32 armed;
+	atomic_t state;
 } __aligned(8);
 
+/* The record test also keeps the offset off a percpu map's pointer slot. */
+static struct bpf_rcu_head_kern *bpf_rcu_head_of(struct bpf_map *map, void *value)
+{
+	if (!btf_record_has_field(map->record, BPF_RCU_HEAD))
+		return NULL;
+
+	return value + map->record->rcu_head_off;
+}
+
 static void bpf_rcu_run_callback(struct rcu_head *rcu)
 {
 	struct bpf_rcu_head_kern *rh = container_of(rcu, struct bpf_rcu_head_kern, rcu);
@@ -4823,26 +4838,96 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
 	struct bpf_prog *prog = rh->prog;
 	struct bpf_map *map = rh->map;
 	void *value, *key;
+	int old, state;
 	u32 idx;
 
 	value = (void *)rh - map->record->rcu_head_off;
 	key = map_key_from_value(map, value, &idx);
 
-	/* Pairs with the arming cmpxchg(): rh may be re-armed as soon as this store lands. */
-	smp_store_release(&rh->armed, 0);
+	/*
+	 * Take RUNNING first, so a claim racing this always sees one of the two.
+	 * rh may be re-armed, and its fields overwritten, once ARMED is dropped.
+	 */
+	old = atomic_fetch_or(RCU_HEAD_RUNNING, &rh->state);
+	WARN_ON_ONCE(old & RCU_HEAD_RUNNING);
+	atomic_andnot(RCU_HEAD_ARMED, &rh->state);
 
+	/*
+	 * Drop RUNNING under the read locks, or a re-arm could be invoked while
+	 * this callback is still on the element. The callback picks the flavour,
+	 * so both locks are needed.
+	 */
+	rcu_read_lock_trace();
 	rcu_read_lock_dont_migrate();
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	state = atomic_fetch_andnot(RCU_HEAD_RUNNING, &rh->state) & ~RCU_HEAD_RUNNING;
 	rcu_read_unlock_migrate();
+	rcu_read_unlock_trace();
+
+	/* A live element is never dead, so this only fires after a claim. */
+	if (!(state & RCU_HEAD_BUSY) && (state & RCU_HEAD_DEAD))
+		map->ops->map_release_elem(map, value);
 
 	bpf_prog_put(prog);
 }
 
+/**
+ * bpf_rcu_head_claim - hand an element over to a queued callback, if any
+ * @map: map owning @value
+ * @value: the element being released
+ *
+ * An RCU callback cannot be cancelled, so an element with one outstanding has
+ * to stay alive until it has run; the callback releases it through
+ * map_release_elem(). Marking it dead also stops it being armed again.
+ *
+ * Return: true when a callback owns @value and the caller must not release it.
+ */
+bool bpf_rcu_head_claim(struct bpf_map *map, void *value)
+{
+	struct bpf_rcu_head_kern *rhk = bpf_rcu_head_of(map, value);
+
+	return rhk && (atomic_fetch_or(RCU_HEAD_DEAD, &rhk->state) & RCU_HEAD_BUSY);
+}
+
+/**
+ * bpf_rcu_head_busy - is a callback still using @value?
+ * @map: map owning @value
+ * @value: the element being looked at
+ *
+ * Unlike bpf_rcu_head_claim() this takes nothing, so a caller that can leave
+ * the element alone asks with this first.
+ *
+ * Return: true when a callback is queued on @value or running on it.
+ */
+bool bpf_rcu_head_busy(struct bpf_map *map, void *value)
+{
+	struct bpf_rcu_head_kern *rhk = bpf_rcu_head_of(map, value);
+
+	return rhk && (atomic_read(&rhk->state) & RCU_HEAD_BUSY);
+}
+
+/**
+ * bpf_rcu_head_reset - give a recycled element a clean head
+ * @map: map owning @value
+ * @value: the element being handed out again
+ *
+ * The dead bit lives in the element, so it outlasts the callback that set it.
+ * Without this a recycled element would refuse every later bpf_call_rcu().
+ */
+void bpf_rcu_head_reset(struct bpf_map *map, void *value)
+{
+	struct bpf_rcu_head_kern *rhk = bpf_rcu_head_of(map, value);
+
+	if (rhk)
+		atomic_set(&rhk->state, 0);
+}
+
 static int __bpf_call_rcu(struct bpf_rcu_head *rh, struct bpf_map *map, void *callback,
 			  struct bpf_prog_aux *aux, bool trace)
 {
 	struct bpf_rcu_head_kern *rhk = (void *)rh;
 	struct bpf_prog *prog;
+	int old;
 
 	BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf_rcu_head));
 	BUILD_BUG_ON(__alignof__(struct bpf_rcu_head_kern) != __alignof__(struct bpf_rcu_head));
@@ -4852,14 +4937,18 @@ static int __bpf_call_rcu(struct bpf_rcu_head *rh, struct bpf_map *map, void *ca
 	if (!atomic64_read(&map->usercnt))
 		return -EPERM;
 
-	if (cmpxchg(&rhk->armed, 0, 1))
-		return -EBUSY;
-
+	/* Before arming, so a failure here leaves the head alone. */
 	prog = bpf_prog_inc_not_zero(aux->prog);
-	if (IS_ERR(prog)) {
-		WRITE_ONCE(rhk->armed, 0);
+	if (IS_ERR(prog))
 		return -EBADF;
-	}
+
+	old = atomic_read(&rhk->state);
+	do {
+		if (old & (RCU_HEAD_ARMED | RCU_HEAD_DEAD)) {
+			bpf_prog_put(prog);
+			return -EBUSY;
+		}
+	} while (!atomic_try_cmpxchg(&rhk->state, &old, old | RCU_HEAD_ARMED));
 
 	rhk->callback_fn = (bpf_callback_t)callback;
 	rhk->map = map;
@@ -4878,8 +4967,9 @@ static int __bpf_call_rcu(struct bpf_rcu_head *rh, struct bpf_map *map, void *ca
  * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
  * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
  *
- * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
- * nor bpffs, or -EBADF if the calling program is going away.
+ * Return: 0, -EBUSY if @rh is already queued or its element is being released,
+ * -EPERM if @map is held by neither a process nor bpffs, or -EBADF if the
+ * calling program is going away.
  */
 __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
 			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
@@ -4896,8 +4986,9 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
  *
  * Waits for sleepable BPF programs too.  The callback itself is not sleepable either way.
  *
- * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
- * nor bpffs, or -EBADF if the calling program is going away.
+ * Return: 0, -EBUSY if @rh is already queued or its element is being released,
+ * -EPERM if @map is held by neither a process nor bpffs, or -EBADF if the
+ * calling program is going away.
  */
 __bpf_kfunc int bpf_call_rcu_tasks_trace(struct bpf_rcu_head *rh, void *map__const_map,
 					 bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 74496fd716d3b..10c6575c53cee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1326,7 +1326,19 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				}
 				break;
 			case BPF_RCU_HEAD:
-				if (map->map_type != BPF_MAP_TYPE_ARRAY) {
+				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+				    map->map_type != BPF_MAP_TYPE_ARRAY) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				/*
+				 * Array elements are never released, so they are never
+				 * claimed either. Any other map has to be able to take
+				 * one back from a callback.
+				 */
+				if (map->map_type != BPF_MAP_TYPE_ARRAY &&
+				    !map->ops->map_release_elem) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
-- 
2.53.0-Meta

