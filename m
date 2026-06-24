Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75877344DAE
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328336; cv=none; b=L/+wKvzH+kL3MJy+fog02pfudHwz55/u4+442wsMJ0z7wFzEmibtQa8gA/oXsbDkHwsOPNuIHDq3tXVbLuQ1SPH3Q8ZKSR2J3yrpcKOPA7JkHK2gbU68wrjye6r/aTtVLMxxPOAjxH7J23sWD2uW/+XXKxbF78vkQZaR3Ja8GHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328336; c=relaxed/simple;
	bh=Gzz6w1aJS8b4msBP9vPDryUOJA2oKB0D7/qbW6mS9T0=;
	h=Cc:Subject:Date:Message-Id:To:From:Mime-Version:Content-Type; b=mRZ5shIOBXgKThipgtl6waa9Da4oroAvNBR8qRM3cRpi0M2VGtbnlRHGc8hy4j+XJTl1MYWHoSBh6+7w4unAmFm41H++pZE4X4UUM9CT0lDiKMPF7w0T1qHdQo/mz8hmMPml12YVBEiaSZwzP7ldenglvOCa7QjzSuFT2RR0fP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=CTl1W4Ro; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="CTl1W4Ro"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1782328321; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4IkWavopZlBOg1SKjRNuznM0oWnDWkWXmUJlhcMJCgs=;
 b=CTl1W4Rou/z4suyZzvMLUCE4CEwug2KAqMHWGFVMgS8eEEibUapFVSTmN7XLwnNcInS4Vc
 9T+pSaOTYPPWAxk3svMGOsA0uwe+4PkUGuL9U0apgsRA8kW+kOVChieMtv2RwplcbHLOGR
 9hgEwCt2BwjG4crXnWTSyKX+uls5XgIsxygvlhEk8Y5xRSDmIJ0GhJp3CxbSLX9xxI7XiP
 fGL2KRnAbw9GazWsnEhj01yU9HPNhoJsKaog4p5BcDUjAOoB1pzCn35kxA0ecXsTyYe9Lu
 ZqtscH0HE4kHtmbI220fVUDJb1h1HoO6xFcll6BYhWxNVPvSro6CDO+JD3FhyQ==
Content-Transfer-Encoding: 7bit
Cc: "Yao Zi" <me@ziyao.cc>, <bpf@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] bpf: Fix use-after-free in htab elem with bpf_task_work
Date: Thu, 25 Jun 2026 03:11:41 +0800
Message-Id: <20260625-bpf-htab-task-work-uaf-v1-1-31e711ccb159@cherr.cc>
X-Change-Id: 20260625-bpf-htab-task-work-uaf-4621a6b8d928
Received: from pve.cherr ([111.42.148.150]) by smtp.feishu.cn with ESMTPS; Thu, 25 Jun 2026 03:11:59 +0800
To: "Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>, 
	"Eduard Zingerman" <eddyz87@gmail.com>, 
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>, 
	"Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, 
	"Yonghong Song" <yonghong.song@linux.dev>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, 
	"Mykyta Yatsenko" <yatsenko@meta.com>
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-B4-Tracking: v=1; b=H4sIAOwrPGoC/x3M3QpAQBBA4VfRXJtiYsOryMUss0wK7foreXeby +/inAeCeJUATfKAl1ODrktEnibQT7yMgjpEA2VkMkMl2s3htLPFncOM1+pnPNhhYShnY6uhpgp ivHlxev/jtnvfDyVHORFoAAAA
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a3c2c00+8f52db+vger.kernel.org+me@cherr.cc>
X-Mailer: b4 0.14.2

Deleting a hash map element that embeds a bpf_task_work can trigger a
use-after-free.  After removal the element is still read under
rcu_read_lock_trace() -- by BPF programs holding a value pointer (e.g.
inside bpf_task_work_schedule) and by the task_work callback
(ctx->map_val) -- but it is recycled through bpf_mem_cache_free,
pcpu_freelist_push or bpf_lru_push_free with no grace period that waits
for rcu_read_lock_trace() readers.  Separately, cancel_and_free() clears
twk->ctx to NULL, the sentinel fetch_ctx() uses for "no ctx yet", which
lets a stale pointer schedule a new callback on the deleted element.

Defer the recycle through call_rcu_tasks_trace(), which waits for
rcu_read_lock_trace() readers; the RCU callback recycles the element
through htab_elem_recycle(), dispatching bpf_mem_cache_free,
pcpu_freelist_push or bpf_lru_push_free by map type.
(bpf_mem_cache_free_rcu() is insufficient: its regular RCU grace period
does not cover rcu_read_lock_trace() readers.)

For the second race, set twk->ctx to ERR_PTR(-EBUSY) instead of NULL, so
fetch_ctx() bails on IS_ERR() and a second cancel_and_free() returns on
IS_ERR_OR_NULL().  Add check_and_init_map_value() in alloc_htab_elem()
and prealloc_lru_pop() to zero the field, since copy_map_value() skips
btf_record fields and a recycled element would otherwise inherit a stale
ERR_PTR(-EBUSY).  In htab_map_free(), call rcu_barrier_tasks_trace()
before prealloc_destroy().

The LRU eviction path (htab_lru_map_delete_node) has the same issue but
needs eviction-algorithm changes and is out of scope.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
This fixes a use-after-free that occurs when a hash map element
embedding a bpf_task_work is deleted (or replaced) while a task_work
callback or a BPF program still holds a pointer into it under
rcu_read_lock_trace().

Why KASAN does not catch this on its own: the BPF per-CPU allocator
(bpf_mem_cache, kernel/bpf/memalloc.c) is a custom object pool layered
on top of the slab allocator.  Its fast free path, unit_free(), only
does __llist_add() onto a per-CPU free list, so the object is reused by
the next bpf_mem_cache_alloc() on the same CPU with no slab free and
therefore no KASAN quarantine or poisoning.  KASAN only re-observes the
object when the cache eventually drains it back to slab (irq_work ->
free_bulk -> __free_rcu, after a grace period), by which point the UAF
window has long since closed.  KASAN is thus structurally blind to UAFs
that fit inside the per-CPU free-list reuse window, and "KASAN does not
report it" is not evidence that the bug is absent.

The bug was confirmed by instrumenting the allocator: poison the object
on unit_free() (kasan_mempool_poison_object) and unpoison on
unit_alloc() (kasan_mempool_unpoison_object).  With that instrumentation
on the unpatched kernel, KASAN reports a slab-use-after-free in the
bpf_task_work_schedule path (allocated-from track points at htab element
allocation via htab_map_update_elem); on the patched kernel it reports
nothing.

On the fix: call_rcu_tasks_trace() is used directly rather than
bpf_mem_cache_free_rcu(), because the readers that must be covered --
the task_work callback and the BPF programs that access the value --
hold rcu_read_lock_trace(), which a regular RCU grace period does not
wait for.
---
 kernel/bpf/hashtab.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/helpers.c |  9 ++++--
 2 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e85be46fa5f12b6a5f5873e450e323..19fa61909e4fed354f754309bc7079b5347f9e01 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -310,6 +310,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 		bpf_map_inc_elem_count(&htab->map);
 		l = container_of(node, struct htab_elem, lru_node);
 		memcpy(l->key, key, htab->map.key_size);
+		check_and_init_map_value(&htab->map, htab_elem_value(l, htab->map.key_size));
 		return l;
 	}
 
@@ -950,12 +951,69 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	return -ENOENT;
 }
 
+/* Deferred htab_elem free for bpf_task_work maps.  cancel_and_free()
+ * returns while the task_work callback may still be accessing map_val;
+ * the callback holds guard(rcu_tasks_trace), so deferring the recycle
+ * through call_rcu_tasks_trace() waits for it (and, since a tasks trace
+ * GP implies a regular RCU GP, for BPF value readers too) before the
+ * element is reused.  A callback that enters after the GP finds the ctx
+ * already FREED and bails out.
+ */
+struct htab_elem_free_rcu {
+	struct rcu_head rcu;
+	struct bpf_htab *htab;
+	struct htab_elem *elem;
+};
+
+/* Return an htab_elem to its map's free pool: bpf_mem_cache_free for
+ * non-prealloc, pcpu_freelist_push for prealloc, bpf_lru_push_free for
+ * prealloc LRU.
+ */
+static void htab_elem_recycle(struct bpf_htab *htab, struct htab_elem *l)
+{
+	if (htab_is_prealloc(htab)) {
+		if (htab_is_lru(htab))
+			bpf_lru_push_free(&htab->lru, &l->lru_node);
+		else
+			pcpu_freelist_push(&htab->freelist, &l->fnode);
+	} else {
+		bpf_mem_cache_free(&htab->ma, l);
+	}
+}
+
+static void htab_elem_free_rcu_cb(struct rcu_head *head)
+{
+	struct htab_elem_free_rcu *fr = container_of(head, struct htab_elem_free_rcu, rcu);
+
+	htab_elem_recycle(fr->htab, fr->elem);
+	kfree(fr);
+}
+
+static void htab_elem_defer_free(struct bpf_htab *htab, struct htab_elem *l)
+{
+	struct htab_elem_free_rcu *fr;
+
+	fr = kmalloc_obj(*fr, GFP_ATOMIC);
+	if (WARN_ON_ONCE(!fr)) {
+		/* Fallback: immediate recycle, small UAF risk */
+		htab_elem_recycle(htab, l);
+		return;
+	}
+	fr->htab = htab;
+	fr->elem = l;
+	call_rcu_tasks_trace(&fr->rcu, htab_elem_free_rcu_cb);
+}
+
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
+	if (btf_record_has_field(htab->map.record, BPF_TASK_WORK)) {
+		htab_elem_defer_free(htab, l);
+		return;
+	}
 	bpf_mem_cache_free(&htab->ma, l);
 }
 
@@ -1006,6 +1064,10 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab_is_prealloc(htab)) {
 		bpf_map_dec_elem_count(&htab->map);
 		check_and_cancel_fields(htab, l);
+		if (btf_record_has_field(htab->map.record, BPF_TASK_WORK)) {
+			htab_elem_defer_free(htab, l);
+			return;
+		}
 		pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
@@ -1118,6 +1180,11 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	}
 
 	memcpy(l_new->key, key, key_size);
+	/* Re-initialize special fields for recycled elements.  copy_map_value()
+	 * skips btf_record fields, so a stale ERR_PTR(-EBUSY) left by
+	 * bpf_task_work_cancel_and_free would persist and block new scheduling.
+	 */
+	check_and_init_map_value(&htab->map, htab_elem_value(l_new, key_size));
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
@@ -1275,6 +1342,10 @@ static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
 	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
+	if (btf_record_has_field(htab->map.record, BPF_TASK_WORK)) {
+		htab_elem_defer_free(htab, elem);
+		return;
+	}
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
@@ -1641,9 +1712,19 @@ static void htab_map_free(struct bpf_map *map)
 		delete_all_elements(htab);
 	} else {
 		htab_free_prealloced_fields(htab);
-		prealloc_destroy(htab);
 	}
 
+	/* For bpf_task_work maps, element frees defer recycling through
+	 * call_rcu_tasks_trace() so running callbacks finish before reuse.
+	 * Wait for any in-flight deferred recycles here, before the
+	 * freelist/LRU and element memory are torn down.
+	 */
+	if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
+		rcu_barrier_tasks_trace();
+
+	if (htab_is_prealloc(htab))
+		prealloc_destroy(htab);
+
 	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee4cd864bdb4f2d1a526f2ab0c54f6..07088ac1f0b2d95f1e790cfc4db779bc5acbf8db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4454,7 +4454,10 @@ static void bpf_task_work_callback(struct callback_head *cb)
 	u32 idx;
 	void *key;
 
-	/* Read lock is needed to protect ctx and map key/value access */
+	/* Hold rcu_read_lock_trace so that call_rcu_tasks_trace() in
+	 * htab_elem_defer_free() waits for this callback to finish before
+	 * recycling the htab_elem.
+	 */
 	guard(rcu_tasks_trace)();
 	/*
 	 * This callback may start running before bpf_task_work_irq() switched to
@@ -4784,8 +4787,8 @@ void bpf_task_work_cancel_and_free(void *val)
 	struct bpf_task_work_ctx *ctx;
 	enum bpf_task_work_state state;
 
-	ctx = xchg(&twk->ctx, NULL);
-	if (!ctx)
+	ctx = xchg(&twk->ctx, ERR_PTR(-EBUSY));
+	if (IS_ERR_OR_NULL(ctx))
 		return;
 
 	state = xchg(&ctx->state, BPF_TW_FREED);

---
base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
change-id: 20260625-bpf-htab-task-work-uaf-4621a6b8d928

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
