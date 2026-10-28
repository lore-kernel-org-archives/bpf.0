Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172994;
	b=raT33IVfvwPtWs4PiJaUw2fFHlY8hbvSUhCXkA1pG9yol8osIbY3aKx9RK1XAM5a5aY2
	 n+lMCQIENYB05uA0ZNItHqe2smXaEFTKFGx+ukwgCX3+hO31Ejujl/mVwym2JGL0IhBHV
	 QNgNHhsVw+EXkvlPV+WtSkNTE0zcOqgqAduXX/XWWEJUJIEgj80bHFDUcvtE9VNPK7IX1
	 oXOvMkt1E6A5gdaBH+JA/atKuKw32kgpT6+D9iu7H/Yt7Nd1JO7oho6er3uboc4oQqBZl
	 aEb4gfAH1c+7zX86IL959FpCObCfFNTe7icZdr9OY2YHOoABWIC8qbMXnApCl9Wdvrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172994;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lLhvvHSllPhZP2JlqaWEPrV2zX3eo59fAGPuXjv9J1A=;
	b=fQWZCEa2lRkVpZ1l7cz2SxUxUFYzol6qoUhD85Z44FjlrSmiwZm3vrHeketJ0jNFrGdE
	 zB257+Q3YOPZv+Sjhlke8Hat0a1dzDaC9tazTAKSyOrNi2maWQ6dQs6FbsYm727ZBKb+v
	 3iePRKw4ScHvC1uhW0K8gRI8sGFv1ZLxHfHtANG8JgBj/wO5JmK2DdBcp/zi7pHAhUFA/
	 TDPAbqyTmkELFNr2gTc2PArKXttp6ZQsCtDdWekigRzFOz7sIl/X+IOnf3G4M5fbcf2Rt
	 cEk3xc7Ku88DDBuctH3V7cTpacE8ZVteP0hxhHZAzpv2r3AQxlgeR9Av9aEilSsRJOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z9DK3qty;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9D606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 07:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z9DK3qty
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lL
	hvvHSllPhZP2JlqaWEPrV2zX3eo59fAGPuXjv9J1A=; b=Z9DK3qtysQCuw33ip5
	tMaUMSGEdZgVfL6xWRTQ8LSPu0T2DvG0r9kB+ZGTMFy6nx+JAzVGky0tgT4r+zxi
	tOXeCmZ91XzwC4mrgdScGjzaFNjZN89L0CHMAgjgbfLmUkPQkYX5O4G7e5iKUNwJ
	JhRaQA6ePV6Z/QJUfLo58iGeA=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnL1DDpeFqcENQDg--.35047S3;
	Wed, 28 Oct 2026 15:35:35 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: bpf@vger.kernel.org
Cc: Yun Lu <luyun@kylinos.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Retire task work before reclaiming hash elements
Date: Wed, 28 Oct 2026 15:35:24 +0800
Message-ID: <20261028073525.1035605-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028073525.1035605-1-luyun_611@163.com>
References: <20261028073525.1035605-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wDnL1DDpeFqcENQDg--.35047S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZFWfJw48ZFyfAFW3Gw4rXwb_yoW8JFyUWo
	WSgr4UGF18Jrykt34rAa4kC3Z8ur4vgwn8XF4Fgw45X3WFq34Y934UKw13A34fXF48KF17
	Aa48K34rCFWkJFyrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7iF4DUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wetfGrhpccsXQAA3l

From: Yun Lu <luyun@kylinos.cn>

bpf_task_work_cancel_and_free() clears the context pointer in a map value
to NULL. A BPF program can still hold that value across deletion within
its trace read-side critical section. Scheduling through the old pointer
can then install a new context on the deleted element.

The context reference protects the context, not the element referenced by
ctx->map_val. If the new callback is outside the waiting set of the trace
grace period freeing the element, it can outlive the element. The final
destructor marks a RUNNING context FREED and drops the map-owned context
reference, but does not wait for the callback before freeing the element.

One execution allowed by these lifetime rules is:

  1. A BPF program looks up element E and retains its value pointer in a
     trace read-side critical section.

  2. Another task deletes E, clears its task-work slot to NULL during
     cancellation, and returns E to the allocator's deferred free path.

  3. The original reader installs a new context C through the old value
     pointer, queues task work, and leaves its trace read-side section.

  4. The target task enters the callback's trace read-side section and
     changes C to RUNNING before the final destructor writes FREED. Its
     read-side section is not covered by the grace period freeing E.
     With SRCU-fast tasks trace, this can happen after the index flip.

  5. The allocator runs the final destructor and frees E. C remains alive
     through the callback reference, but the callback still accesses E's
     key or value through ctx->map_val.

A controlled reproducer on an x86-64 KVM guest running this series'
base commit with KASAN reported the following fault. The reproducer
keeps a value pointer across deletion as in the interleaving above;
its task-work callback passes the freed value and key bytes to
bpf_map_update_elem() and bpf_map_delete_elem(), whose kernel-side
reads are KASAN-instrumented regardless of BPF JIT state. A production
callback dereferencing ctx->map_val reads the same freed bytes:

  BUG: KASAN: slab-use-after-free in array_map_update_elem+0x4b8/0x7f0
  Read of size 8 at addr ffff88800e61be98 by task uaf_repro/91
  Call Trace:
   __asan_memcpy+0x23/0x60
   array_map_update_elem+0x4b8/0x7f0
   bpf_prog_976f3fa6d36fbef6_cb_probe_step+0xaf/0xe5
   bpf_prog_ac7215eae4609044_process_work_cb+0x12c/0x234
   bpf_task_work_callback+0x351/0x970
   task_work_run+0x116/0x200

  Allocated by task 90:
   alloc_bulk+0x238/0x360
   bpf_mem_alloc_init+0x2fd/0x930
   rhtab_map_alloc+0x352/0x430

  Freed by task 9:
   kfree+0x1b8/0x550
   free_all.isra.0+0x5b/0x110
   __free_rcu+0x87/0x1b0
   srcu_invoke_callbacks+0x360/0x5c0

The fault reproduced on all three boots. With this patch applied, the
same reproducer observes scheduling through the stale pointer rejected
with -ENOENT, no callback entry on the deleted element, and no KASAN
reports across three boots.

Leave ERR_PTR(-ENOENT) in task-work slots before returning non-preallocated
HASH and RHASH elements to the allocator. The existing fetch/acquire error
path rejects the retired slot. Reopen it only when the allocator acquires
the storage again. Also retire a reinitialized RHASH candidate abandoned
after insertion finds an existing element or fails: a reader of a previous
incarnation can still hold its value pointer and install a context there.

Ordinary cancellation must mark the context FREED before detaching it, so
retirement cannot miss a detached context that can still enter RUNNING.
Use a conditional slot update to preserve DEAD or a context installed
after reuse. Protect competing cancellers with regular RCU, and let only
the first FREED transition dispose of the map-owned context reference.
Drop or transfer that reference only after the slot no longer publishes
the context; otherwise late readers could obtain it after reclamation was
already submitted.

A callback now either loses to FREED or establishes its trace read-side
section before retirement completes and the element is submitted for
reclamation. The existing trace grace period therefore covers callbacks
that can access the element. No element reference, additional grace
period or synchronous wait is needed. Preallocated HASH/LRU slots retain
their existing cancellation semantics, as do live updates and uref
cleanup. A retired slot returns -ENOENT until its storage is allocated
again; a scheduling attempt racing with retirement may still succeed and
then be cancelled.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Link: https://sashiko.dev/#/patchset/20261012061915.231254-1-luyun_611@163.com?part=3
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/hashtab.c |  7 ++++
 kernel/bpf/helpers.c | 80 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 580f89c450b5..8e0b2652b56d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -667,6 +667,8 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 void bpf_timer_cancel_and_free(void *timer);
 void bpf_wq_cancel_and_free(void *timer);
 void bpf_task_work_cancel_and_free(void *timer);
+void bpf_task_work_free(struct bpf_map *map, void *value);
+void bpf_task_work_init(struct bpf_map *map, void *value);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
 void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bf78e09f4d51..1b90f0854bbe 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1142,6 +1142,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
+	bpf_task_work_free(&htab->map, htab_elem_value(l, htab->map.key_size));
 	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
@@ -1317,6 +1318,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			goto dec_count;
 		}
 		l_new = container + htab->elem_offset;
+		bpf_task_work_init(&htab->map, htab_elem_value(l_new, key_size));
 	}
 
 	if (htab_has_hash(htab))
@@ -3105,6 +3107,7 @@ static void rhtab_free_elem(void *ptr, void *arg)
 	struct bpf_rhtab *rhtab = arg;
 	struct rhtab_elem *elem = ptr;
 
+	bpf_task_work_free(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 }
@@ -3177,6 +3180,7 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
+	bpf_task_work_free(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_obj_cancel_fields(&rhtab->map,
 			      rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
@@ -3277,6 +3281,7 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 	if (!elem)
 		return -ENOMEM;
 
+	bpf_task_work_init(map, rhtab_elem_value(elem, map->key_size));
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
 
@@ -3291,6 +3296,8 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 	bpf_enable_instrumentation();
 
 	if (tmp) {
+		/* A reader of a previous incarnation can still hold this value. */
+		bpf_task_work_free(map, rhtab_elem_value(elem, map->key_size));
 		bpf_mem_cache_free(&rhtab->ma, elem);
 		if (IS_ERR(tmp))
 			return PTR_ERR(tmp);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..741877b99b02 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4531,6 +4531,8 @@ struct bpf_task_work_kern {
 	struct bpf_task_work_ctx *ctx;
 };
 
+#define BPF_TASK_WORK_DEAD ERR_PTR(-ENOENT)
+
 static void bpf_task_work_ctx_reset(struct bpf_task_work_ctx *ctx)
 {
 	if (ctx->prog) {
@@ -4809,7 +4811,13 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * After deletion completes, a non-preallocated HASH/RHASH element rejects
+ * new context acquisition until its storage is allocated again. Replacing
+ * a non-preallocated HASH element has the same effect. Scheduling racing
+ * with retirement may succeed and then be cancelled.
+ *
+ * Return: 0 if scheduling irq_work was queued, -ENOENT for a retired slot,
+ * or another negative error code on failure.
  */
 __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
@@ -4827,7 +4835,10 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * See bpf_task_work_schedule_signal() for retired-element handling.
+ *
+ * Return: 0 if scheduling irq_work was queued, -ENOENT for a retired slot,
+ * or another negative error code on failure.
  */
 __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
@@ -5047,25 +5058,74 @@ static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
 	bpf_task_work_ctx_put(ctx); /* and here we put map's own ref that was transferred to us */
 }
 
+/* ctx must no longer be published in its map value's slot. */
+static void bpf_task_work_finish_cancel(struct bpf_task_work_ctx *ctx,
+					enum bpf_task_work_state state)
+{
+	/* The first canceller owns the map's reference. */
+	if (state == BPF_TW_FREED)
+		return;
+	if (state == BPF_TW_SCHEDULED) {
+		/* run in irq_work to avoid locks in NMI */
+		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
+		irq_work_queue(&ctx->irq_work);
+		return;
+	}
+
+	bpf_task_work_ctx_put(ctx); /* put bpf map's ref */
+}
+
 void bpf_task_work_cancel_and_free(void *val)
 {
 	struct bpf_task_work_kern *twk = val;
 	struct bpf_task_work_ctx *ctx;
 	enum bpf_task_work_state state;
 
-	ctx = xchg(&twk->ctx, NULL);
-	if (!ctx)
+	/* Another canceller can drop the map's reference. */
+	guard(rcu)();
+	ctx = READ_ONCE(twk->ctx);
+	if (IS_ERR_OR_NULL(ctx))
 		return;
 
+	/*
+	 * Stop new callbacks before detaching the context, so deletion cannot
+	 * miss a context that can still enter RUNNING. Preserve a concurrent
+	 * deletion's marker, or a context installed after element reuse.
+	 */
 	state = xchg(&ctx->state, BPF_TW_FREED);
-	if (state == BPF_TW_SCHEDULED) {
-		/* run in irq_work to avoid locks in NMI */
-		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
-		irq_work_queue(&ctx->irq_work);
+	(void)cmpxchg(&twk->ctx, ctx, NULL);
+	/* A failed CAS also means ctx was detached. Only now may it be freed. */
+	bpf_task_work_finish_cancel(ctx, state);
+}
+
+/* Called before returning an element to the allocator. */
+void bpf_task_work_free(struct bpf_map *map, void *value)
+{
+	struct bpf_task_work_kern *twk;
+	struct bpf_task_work_ctx *ctx;
+	enum bpf_task_work_state state;
+
+	if (!btf_record_has_field(map->record, BPF_TASK_WORK))
 		return;
-	}
+	twk = value + map->record->task_work_off;
 
-	bpf_task_work_ctx_put(ctx); /* put bpf map's ref */
+	guard(rcu)();
+	ctx = xchg(&twk->ctx, BPF_TASK_WORK_DEAD);
+	if (IS_ERR_OR_NULL(ctx))
+		return;
+	state = xchg(&ctx->state, BPF_TW_FREED);
+	bpf_task_work_finish_cancel(ctx, state);
+}
+
+/* Only allocator acquisition may reopen a retired task-work slot. */
+void bpf_task_work_init(struct bpf_map *map, void *value)
+{
+	struct bpf_task_work_kern *twk;
+
+	if (!btf_record_has_field(map->record, BPF_TASK_WORK))
+		return;
+	twk = value + map->record->task_work_off;
+	(void)cmpxchg(&twk->ctx, BPF_TASK_WORK_DEAD, NULL);
 }
 
 BTF_KFUNCS_START(generic_btf_ids)
-- 
2.43.0

