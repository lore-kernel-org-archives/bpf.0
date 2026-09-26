Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE93A05C4
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465725; cv=none; b=iGpdQgzV2K8yw9r8UFCOn2eeMjOQ4B3ObMltu072Igu7jsxJ3oU1vZh4pgnn2JRlj7/Y/XueA07xYr36Xrf5qu4w4MEwzGI1AWZUShZfelEWNDO31qdWCF7VFJLjQzF43KvWGGiLMw/TBNX9+V+iKjQvuMxWRMRe0QVX8WGtVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465725; c=relaxed/simple;
	bh=aN5ruJd5HHNGYWBtCrPyBobLYiVAoPHy7iQbc+WwEnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riDqOLmTA18twLcC0+YR9pI73XtW6YPRF98mCHn190Hs8blGMC8tbSHCM8Lntprm7YzVfQb+TdR7ORUByFZG3livtpTv1ksXXhS7ShG7OY0KvbkND3/ap/WzDezdCkdcA6rda9j6M3L8D0JPDP+lhCqAG1OsdlcRtBC1AWsZNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKrrqiA8; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKrrqiA8"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9e8b8e2so4379655e9.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465721; x=1791070521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKynvoUVpqxeLm6hkkRE0jl4P0z6mDDrfOIPTHP7O+4=;
        b=JKrrqiA8nSSrVIPAzHXN+l2c480r79MAmsHFr1BjRLm7XRxaV0PQGeT1woSHJdm2Hd
         ZMapuKRrfxN9QMby3lBtPt21OyfB1dlweD79B7UXLFTozUztm3rQZu0//22vDVXl7T3B
         707Lv861qLLbpB3/rdG35ohnl2wkJVYd619aKDai1hTKOt+2W9lscLBKX7GORfZPQuHj
         zLmMsAUHTwCE7xCqOPFdpMEWzQmarNdfBeBHy27eaY11Q5nMQzdWJgE9Tg6CVieJ5cge
         UZ3BvJoB0GL8m7kE4tFspIY8MN2SIfYM1IBVMjtcEEmmIr5NgI0P3CwBH8o77roCqVgU
         Lo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465721; x=1791070521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKynvoUVpqxeLm6hkkRE0jl4P0z6mDDrfOIPTHP7O+4=;
        b=F1zeR11v+M6fXr8M/SoLo99OT0ZHEProJ1Zom5Xg1c07HlfRwpmBKj1irrqPJip5Ae
         lnzvDwPmeHWZk10NPbB0+8ZKMh8N4e2qDiqUvwiqWkGERqK8Skvo9NZXZOscTHUTsECm
         yFDva4rzJfZ7p3T3Z9io5kjLO5iTsuQvpspd8fi4y31MVkJ+LDDFYcNx1GkLKFsZjDVu
         9U8u3GTiJt1Im+qSvFASxEWdqDILQNQz9jBDvs+fTQuAguA6rXSt5Fa5nbaW2j55sUKR
         aHKkk+moL4Flw2i6vq3sxhkt3hpCe/tjQAcjqkOeknGmWCkEbsk8aMP3sRE76wRN1SnY
         kzlw==
X-Gm-Message-State: AFuF++kmHMxMUa+8oujRcxWgAtXR8sJCVAqW0xyfVPHhw17xD8xnVYJN
	371i+v5yApVhXAAzjsQvjNsQ/d2B3VtDTE+AmwF8SJFfvv6zzyrLw2QSIB1sexnm
X-Gm-Gg: AYBFou2idZ0wpo+P0YtmV2sCr8Q+CjaHL4y54KKsmwExZya+V5yNUoRBEBM3/+yVGnz
	vlQyfDZP4v7R3aOB9V3UfHWH3IASG0uFpdm3YPvmVyw3+pegPMEnHcWOC+j4c+rLV4xf7+ILhme
	dEj3wfXbklragNprsTznKwEV58EmmYGQZou7osad6eNEesiT4RT5dTSeU6Yo3S2g/JI9FHAdJTq
	xd9r7uEQAIDdHzHoefkP9ZLsNT7q+xHZ8H7k96cB3+4o/Au+P+4TIuQTuyEqofxu2bINQwJGUng
	i1KIMA6MTPAql0NJE0WggQnAJFzJ1xY5Oo7mrzJeuxB3+8qK6kbN08Ody8QcMpe2XmaV5ZUyGt8
	9twgWx3oQQRshrZLnO+651EuCeVDHycryEbr648oGqKYyAzrwTVC9vRS4SPfapQTIhLQFTpoykD
	yde+tgZahstKnuDoT+YTeYlsr7zn1s+o2JiUWyqiO4AdkrBSUJPqDLYMUAiM/LIk1sw1maPkqTu
	2vMHm4nWuxWq9Gi6vCDkGeoXbFZNEPa0ClreddPAvkY4DrvB5Z7iSAdLBLlpPuvNJFbXElm6fnX
	JDkvAqaPbX5jFf2i+lLh0t1WDpypa5ELq5J2jQ==
X-Received: by 2002:a05:600d:d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-49fe7726ee3mr144926535e9.32.1790465721042;
        Sat, 26 Sep 2026 16:35:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm19521505e9.15.2026.09.26.16.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 09/16] bpf: Add typed arena page allocation and release kfuncs
Date: Sun, 27 Sep 2026 01:34:47 +0200
Message-ID: <20260926233503.3114147-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25888; i=memxor@gmail.com; h=from:subject; bh=aN5ruJd5HHNGYWBtCrPyBobLYiVAoPHy7iQbc+WwEnY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWLy8A/eNvxsTXtrl7OiPD+FoNuDm1n817W/fl0JGw 79T2z53lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIa1xn++7rXtq3bpV3tqes4 bTnzw69l9t80Qvh1jLid0o4cdGFyZGSY/brsi8Hz/b1Lrvg6VyUrtp/Q7bknItbrqJZoWfGK0Zk BAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Give programs control over the memory behind a typed arena. So far every
chunk of one reads as the dummy objects of the scratch chunk once touched;
now a program can back a range with real objects and give it back:

  void *bpf_typed_arena_alloc_pages(void *map, u64 local_type_id__k,
                                    void *addr, u32 *page_cnt, int node_id);
  void bpf_typed_arena_free_pages(void *map, u64 local_type_id__k,
                                  void *ptr, u32 page_cnt);

The prototypes follow the raw page kfuncs, with the struct's local BTF type
ID naming the typed arena inside the map as a verifier-known constant, as
bpf_obj_new() takes its type. The verifier requires the program to have an
associated arena map and BTF, registers the typed arena for the struct as a
cast does, records it in the call's aux data, and refuses a call site that
two paths reach with two type IDs, since the fixup replaces the type ID
register with the typed arena once per call site: the kfunc receives the
registered typed arena and only checks that it belongs to the map it was
given. The address is a typed pointer naming the chunk of the first object,
NULL for any range, ignored by the verifier and validated by the kfunc; a
loaded, unsanitized pointer passed there is sanitized before the call like
any call argument. The request is in pages, like the raw allocator's, but
the unit of backing is the chunk, so the request is rounded up to whole
chunks and the count granted is written back through the pointer: an object
larger than a page is never half allocated, and a program learns how many
objects it got. The generic kfunc argument rules classify a pointer to a
scalar as writable fixed-size memory, so a spilled constant in that slot
does not survive the call as known. The allocator returns a typed pointer to
the first object of the range, or NULL, checked once and then used natively,
and the objects follow at slot strides. Both kfuncs are safe under a spin
lock: the allocator takes the arena's resilient spinlock and uses the
lock-free allocators, and the release only queues work. The flags argument
of the raw allocator is left out to stay within five arguments; a variant
can add it, kfuncs not being ABI.

Allocation claims the chunk range in the type's bitmap under the spinlock
and installs each chunk as one allocation of its order into empty entries
only: a chunk the fault path faulted to scratch is skipped by a search or
fails a fixed request, because a scratch page is never replaced by a real
one. The fault path marks its chunk without the lock, so it can still slip
in between the claim and the install; the chunks installed so far are then
backed out under the lock, the chunk it took keeps its mark, and a search
retries a few times while a fixed request fails. The bits are set one at a
time so that a word-wide update cannot undo the fault path's atomic mark.
One allocation per chunk also removes the array of pages the raw allocator
sizes against the lock-free kmalloc limit, and makes a multi-page object
contiguous in the direct map, which is what lets its special fields be
dropped after its mapping is gone.

Release is always deferred. The chunks stay mapped and marked until a worker
has waited for an RCU and an RCU-tasks-trace grace period, so every
invocation that started before the release keeps valid objects, sleepable
ones included. The worker then clears the entries and the marks under the
spinlock, flushes the TLB, drops the special fields of every object of each
real chunk from its block, and frees it. A range is released once: the
release marks its chunks pending under the spinlock, and a further release of
any of them is refused until the worker has cleared the marks, since a second
release queued behind the first would run after the first has let the range
be claimed again and take it away from its new owner. An invocation that
casts into the range after the release was requested is racing with it: it
stays memory safe, and it sees the real objects before the clear and the
dummy object after. Releasing a chunk that the fault path took only clears
its entries, after which it can be claimed or faulted again. A release that
cannot queue its work in a non-sleepable context leaves the chunks allocated
until the map is freed. Map teardown flushes the worker.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/arena.c    | 391 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  60 +++++++
 2 files changed, 451 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c757c1932360..0b8edfda3c1a 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <asm/tlbflush.h>
+#include <linux/rcupdate_wait.h>
 #include "range_tree.h"
 
 /*
@@ -103,6 +104,9 @@ struct bpf_arena {
 	struct irq_work     free_irq;
 	struct work_struct  free_work;
 	struct llist_head   free_spans;
+	struct irq_work     typed_free_irq;
+	struct work_struct  typed_free_work;
+	struct llist_head   typed_free_spans;
 };
 
 static void arena_free_worker(struct work_struct *work);
@@ -114,6 +118,17 @@ struct arena_free_span {
 	u32 page_cnt;
 };
 
+static void typed_arena_free_worker(struct work_struct *work);
+static void typed_arena_free_irq(struct irq_work *iw);
+
+/* A chunk range of a typed arena whose release is queued. */
+struct typed_arena_free_span {
+	struct llist_node node;
+	struct bpf_typed_arena *ta;
+	u32 coff;
+	u32 chunk_cnt;
+};
+
 static unsigned long typed_arena_region(struct bpf_arena *arena)
 {
 	return (unsigned long)arena->kern_vm->addr;
@@ -565,6 +580,347 @@ static void typed_arenas_free(struct bpf_arena *arena)
 	}
 }
 
+static bool typed_arena_chunks_free(const struct bpf_typed_arena *ta, unsigned long coff,
+				    unsigned long cnt)
+{
+	return find_next_bit(ta->chunks, coff + cnt, coff) >= coff + cnt;
+}
+
+static bool typed_arena_chunks_taken(const struct bpf_typed_arena *ta, unsigned long coff,
+				     unsigned long cnt)
+{
+	return find_next_zero_bit(ta->chunks, coff + cnt, coff) >= coff + cnt;
+}
+
+static bool typed_arena_chunks_pending(const struct bpf_typed_arena *ta, unsigned long coff,
+				       unsigned long cnt)
+{
+	return find_next_bit(ta->pending, coff + cnt, coff) < coff + cnt;
+}
+
+/*
+ * The bits are set one at a time: the fault path marks a chunk it faults to
+ * scratch with an atomic set from any context, and a word-wide update here
+ * could undo that mark.
+ */
+static void typed_arena_chunks_mark(struct bpf_typed_arena *ta, unsigned long coff,
+				    unsigned long cnt, bool taken)
+{
+	unsigned long i;
+
+	for (i = coff; i < coff + cnt; i++) {
+		if (taken)
+			set_bit(i, ta->chunks);
+		else
+			clear_bit(i, ta->chunks);
+	}
+}
+
+struct typed_install_data {
+	struct bpf_arena *arena;
+	struct page *head;
+	unsigned long start;
+	int i;
+};
+
+/*
+ * The typed arena installer maps the pages of one chunk's allocation and only
+ * fills empty entries: a scratch page is never replaced, see
+ * typed_arena_handle_page_fault(). Pairs with the atomic scratch installer.
+ */
+static int apply_range_set_typed_cb(pte_t *pte, unsigned long addr, void *data)
+{
+	struct typed_install_data *d = data;
+	struct page *page = d->head + ((addr - d->start) >> PAGE_SHIFT);
+
+	if (!ptep_try_set(pte, mk_pte(page, PAGE_KERNEL)))
+		return -EBUSY;
+	d->i++;
+	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages + 1);
+	return 0;
+}
+
+struct typed_clear_data {
+	struct bpf_arena *arena;
+	const struct bpf_typed_arena *ta;
+	struct page *head;
+};
+
+/*
+ * Clear the entries of one chunk. A real chunk is one allocation, so the page
+ * at the chunk's first entry is its head, which is reported for freeing once
+ * the mapping is gone; scratch pages are left to the scratch chunk.
+ */
+static int apply_range_clear_typed_cb(pte_t *pte, unsigned long addr, void *data)
+{
+	struct typed_clear_data *d = data;
+	pte_t old_pte;
+	struct page *page;
+
+	old_pte = ptep_get_and_clear(&init_mm, addr, pte);
+	if (pte_none(old_pte) || !pte_present(old_pte))
+		return 0;
+	page = pte_page(old_pte);
+	if (page == typed_arena_scratch_page(d->ta, addr))
+		return 0;
+	if (!((addr - (unsigned long)d->ta->base) & (bpf_typed_arena_chunk(d->ta) - 1)))
+		d->head = page;
+	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages - 1);
+	return 0;
+}
+
+/*
+ * Back a chunk range of a typed arena with zeroed objects and return the
+ * address of its first object, or 0. @addr names the chunk of the first
+ * object, or is 0 for any range; *@page_cnt is the request in pages, rounded
+ * up to whole chunks, and receives the count granted. The range is claimed in
+ * the chunk bitmap under the arena's spinlock before anything is installed, so
+ * a chunk the fault path faulted to scratch is skipped by a search, or fails a
+ * fixed request. The fault path marks its chunk without the lock, so it can
+ * still win the race between the claim and the install; the chunks installed
+ * so far are then backed out, the chunk it took stays taken, and a search is
+ * retried a few times while a fixed request fails. Each chunk is one
+ * allocation of its order from the lock-free allocator, which the kfunc needs
+ * because it may run under a spin lock; there is no array of pages to size.
+ */
+static unsigned long typed_arena_alloc_pages(struct bpf_typed_arena *ta, unsigned long addr,
+					     u32 *page_cnt, int node_id)
+{
+	unsigned long base = (unsigned long)ta->base, nr_chunks = typed_arena_nr_chunks(ta);
+	struct bpf_arena *arena = container_of(ta->map, struct bpf_arena, map);
+	unsigned int order = typed_arena_chunk_order(ta);
+	unsigned long chunk = bpf_typed_arena_chunk(ta);
+	struct mem_cgroup *new_memcg, *old_memcg;
+	unsigned long chunk_cnt, coff = 0, start, done, i;
+	struct typed_install_data data;
+	struct typed_clear_data cdata;
+	struct llist_node *pos, *t;
+	struct llist_head freed;
+	unsigned long flags;
+	struct page *head;
+	int ret, attempt = 0;
+
+	if (node_id != NUMA_NO_NODE &&
+	    ((unsigned int)node_id >= nr_node_ids || !node_online(node_id)))
+		return 0;
+	if (!*page_cnt)
+		return 0;
+	chunk_cnt = DIV_ROUND_UP((unsigned long)*page_cnt, typed_arena_chunk_pages(ta));
+	if (chunk_cnt > nr_chunks)
+		return 0;
+	if (addr) {
+		if (addr - base >= bpf_typed_arena_size(ta))
+			return 0;
+		coff = (addr - base) >> ta->chunk_shift;
+		if (chunk_cnt > nr_chunks - coff)
+			return 0;
+	}
+
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+retry:
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		goto out;
+
+	if (addr) {
+		if (!typed_arena_chunks_free(ta, coff, chunk_cnt))
+			goto out_unlock;
+	} else {
+		coff = bitmap_find_next_zero_area(ta->chunks, nr_chunks, 0, chunk_cnt, 0);
+		if (coff >= nr_chunks)
+			goto out_unlock;
+	}
+	typed_arena_chunks_mark(ta, coff, chunk_cnt, true);
+	start = base + (coff << ta->chunk_shift);
+
+	data.arena = arena;
+	for (done = 0; done < chunk_cnt; done++) {
+		head = alloc_pages_nolock(__GFP_ACCOUNT, node_id, order);
+		if (!head) {
+			ret = -ENOMEM;
+			goto back_out;
+		}
+		data.head = head;
+		data.start = start + (done << ta->chunk_shift);
+		data.i = 0;
+		ret = apply_to_page_range(&init_mm, data.start, chunk, apply_range_set_typed_cb,
+					  &data);
+		if (ret) {
+			/* The fault path took this chunk: give back the allocation whole. */
+			cdata.arena = arena;
+			cdata.ta = ta;
+			if (data.i)
+				apply_to_existing_page_range(&init_mm, data.start,
+							     (unsigned long)data.i << PAGE_SHIFT,
+							     apply_range_clear_typed_cb, &cdata);
+			free_pages_nolock(head, order);
+			goto back_out;
+		}
+	}
+	flush_vmap_cache(start, chunk_cnt << ta->chunk_shift);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+	*page_cnt = chunk_cnt * typed_arena_chunk_pages(ta);
+	return start;
+
+back_out:
+	/*
+	 * Back out the chunks installed before the one that failed. On -EBUSY
+	 * that chunk is the one the fault path took, and it keeps its mark.
+	 */
+	init_llist_head(&freed);
+	cdata.arena = arena;
+	cdata.ta = ta;
+	for (i = 0; i < chunk_cnt; i++)
+		if (ret != -EBUSY || i != done)
+			clear_bit(coff + i, ta->chunks);
+	for (i = 0; i < done; i++) {
+		cdata.head = NULL;
+		apply_to_existing_page_range(&init_mm, start + (i << ta->chunk_shift), chunk,
+					     apply_range_clear_typed_cb, &cdata);
+		if (cdata.head)
+			__llist_add(&cdata.head->pcp_llist, &freed);
+	}
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	flush_tlb_kernel_range(start, start + (chunk_cnt << ta->chunk_shift));
+	llist_for_each_safe(pos, t, __llist_del_all(&freed))
+		free_pages_nolock(llist_entry(pos, struct page, pcp_llist), order);
+	if (ret == -EBUSY && !addr && ++attempt < 3)
+		goto retry;
+	goto out;
+
+out_unlock:
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+out:
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+	return 0;
+}
+
+/*
+ * Queue the release of the chunks covering a page range of a typed arena. The
+ * chunks stay mapped and marked until the worker has waited for the grace
+ * periods, so that every invocation that started before this call keeps its
+ * objects. Every chunk of the range must be taken, by real pages or by the
+ * fault path, and none of them may have a release queued already: a second
+ * release of a chunk would run after the first has let it be claimed again,
+ * and take it away from its new owner. Releasing a chunk the fault path took
+ * clears its entries, after which it can be claimed or faulted again.
+ */
+static void typed_arena_free_pages(struct bpf_typed_arena *ta, unsigned long addr, u32 page_cnt)
+{
+	unsigned long base = (unsigned long)ta->base, size = bpf_typed_arena_size(ta);
+	struct bpf_arena *arena = container_of(ta->map, struct bpf_arena, map);
+	unsigned long off, first, last, flags;
+	struct typed_arena_free_span *s;
+
+	if (!page_cnt || addr - base >= size)
+		return;
+	off = addr - base;
+	if (page_cnt > (size - off) >> PAGE_SHIFT)
+		return;
+	first = off >> ta->chunk_shift;
+	last = (off + ((unsigned long)page_cnt << PAGE_SHIFT) - 1) >> ta->chunk_shift;
+
+	s = kmalloc_nolock(sizeof(*s), __GFP_ACCOUNT, NUMA_NO_NODE);
+	if (!s)
+		/*
+		 * The chunks stay allocated until the map is freed; nothing can
+		 * be retried from here.
+		 */
+		return;
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		goto free_span;
+	if (!typed_arena_chunks_taken(ta, first, last - first + 1) ||
+	    typed_arena_chunks_pending(ta, first, last - first + 1)) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		goto free_span;
+	}
+	/* Only this path and the worker touch the pending bits, both under the lock. */
+	bitmap_set(ta->pending, first, last - first + 1);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	s->ta = ta;
+	s->coff = first;
+	s->chunk_cnt = last - first + 1;
+	llist_add(&s->node, &arena->typed_free_spans);
+	irq_work_queue(&arena->typed_free_irq);
+	return;
+
+free_span:
+	kfree_nolock(s);
+}
+
+/*
+ * Release the queued chunk ranges once every invocation that started before
+ * a release was requested is done with its objects: after an RCU and an RCU
+ * tasks trace grace period, since sleepable programs run under the latter.
+ * The entries are cleared and the marks dropped under the spinlock, chunk by
+ * chunk, then the TLB is flushed and each real chunk's allocation, one
+ * contiguous block, has the special fields of its objects dropped and is
+ * freed. An invocation that casts into the range after the release was
+ * requested races with it: it stays memory safe, and sees the real objects
+ * before the clear and the dummy object after.
+ */
+static void typed_arena_free_worker(struct work_struct *work)
+{
+	struct bpf_arena *arena = container_of(work, struct bpf_arena, typed_free_work);
+	struct mem_cgroup *new_memcg, *old_memcg;
+	struct llist_node *list, *pos, *t, *p, *pn;
+	struct typed_arena_free_span *s;
+	struct typed_clear_data cdata;
+	struct bpf_typed_arena *ta;
+	struct llist_head heads;
+	unsigned long flags, start, i;
+	struct page *head;
+
+	list = llist_del_all(&arena->typed_free_spans);
+	if (!list)
+		return;
+
+	synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
+
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	llist_for_each_safe(pos, t, list) {
+		s = llist_entry(pos, struct typed_arena_free_span, node);
+		ta = s->ta;
+		start = (unsigned long)ta->base + ((unsigned long)s->coff << ta->chunk_shift);
+
+		init_llist_head(&heads);
+		cdata.arena = arena;
+		cdata.ta = ta;
+
+		while (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+			cpu_relax();
+		for (i = 0; i < s->chunk_cnt; i++) {
+			cdata.head = NULL;
+			apply_to_existing_page_range(&init_mm, start + (i << ta->chunk_shift),
+						     bpf_typed_arena_chunk(ta),
+						     apply_range_clear_typed_cb, &cdata);
+			if (cdata.head)
+				__llist_add(&cdata.head->pcp_llist, &heads);
+		}
+		typed_arena_chunks_mark(ta, s->coff, s->chunk_cnt, false);
+		bitmap_clear(ta->pending, s->coff, s->chunk_cnt);
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+		flush_tlb_kernel_range(start,
+				       start + ((unsigned long)s->chunk_cnt << ta->chunk_shift));
+		llist_for_each_safe(p, pn, __llist_del_all(&heads)) {
+			head = llist_entry(p, struct page, pcp_llist);
+			typed_arena_free_objects(ta, page_address(head));
+			__free_pages(head, typed_arena_chunk_order(ta));
+		}
+		kfree_nolock(s);
+	}
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+}
+
+static void typed_arena_free_irq(struct irq_work *iw)
+{
+	struct bpf_arena *arena = container_of(iw, struct bpf_arena, typed_free_irq);
+
+	schedule_work(&arena->typed_free_work);
+}
+
 static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 {
 	struct vm_struct *kern_vm;
@@ -613,6 +969,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	init_llist_head(&arena->free_spans);
 	init_irq_work(&arena->free_irq, arena_free_irq);
 	INIT_WORK(&arena->free_work, arena_free_worker);
+	init_llist_head(&arena->typed_free_spans);
+	init_irq_work(&arena->typed_free_irq, typed_arena_free_irq);
+	INIT_WORK(&arena->typed_free_work, typed_arena_free_worker);
 	bpf_map_init_from_attr(&arena->map, attr);
 
 	err = bpf_map_alloc_pages(&arena->map, NUMA_NO_NODE, 1, &arena->scratch_page);
@@ -686,6 +1045,8 @@ static void arena_map_free(struct bpf_map *map)
 	/* Ensure no pending deferred frees */
 	irq_work_sync(&arena->free_irq);
 	flush_work(&arena->free_work);
+	irq_work_sync(&arena->typed_free_irq);
+	flush_work(&arena->typed_free_work);
 
 	/*
 	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
@@ -1463,12 +1824,42 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 
 	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
 }
+
+/*
+ * The verifier registers the typed arena of local_type_id__k at load, checks
+ * that the map is the program's arena, and replaces the type ID register with
+ * the registered typed arena before the call. addr__ign is a typed pointer
+ * into that arena naming the chunk of the first object, or NULL for any
+ * range; *page_cnt is the request in pages and receives the count granted,
+ * rounded up to whole objects.
+ */
+__bpf_kfunc void *bpf_typed_arena_alloc_pages(void *p__map, u64 local_type_id__k, void *addr__ign,
+					      u32 *page_cnt, int node_id)
+{
+	struct bpf_typed_arena *ta = (struct bpf_typed_arena *)local_type_id__k;
+
+	if (ta->map != p__map)
+		return NULL;
+	return (void *)typed_arena_alloc_pages(ta, (unsigned long)addr__ign, page_cnt, node_id);
+}
+
+__bpf_kfunc void bpf_typed_arena_free_pages(void *p__map, u64 local_type_id__k, void *ptr__ign,
+					    u32 page_cnt)
+{
+	struct bpf_typed_arena *ta = (struct bpf_typed_arena *)local_type_id__k;
+
+	if (ta->map != p__map)
+		return;
+	typed_arena_free_pages(ta, (unsigned long)ptr__ign, page_cnt);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
 BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_typed_arena_alloc_pages, KF_RET_NULL | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_typed_arena_free_pages, KF_SPINLOCK_SAFE)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2d406034556e..b85d99f81ef5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -216,6 +216,7 @@ static bool is_tracing_prog_type(enum bpf_prog_type type);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
+static struct bpf_typed_arena *typed_arena_register(struct bpf_verifier_env *env, u32 btf_id);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
@@ -13334,6 +13335,8 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_typed_arena_alloc_pages,
+	KF_bpf_typed_arena_free_pages,
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
@@ -13429,6 +13432,8 @@ BTF_ID(func, bpf_call_rcu_tasks_trace)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+BTF_ID(func, bpf_typed_arena_alloc_pages)
+BTF_ID(func, bpf_typed_arena_free_pages)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_is_return)
 #else
@@ -13458,6 +13463,12 @@ static bool is_bpf_obj_new_kfunc(u32 func_id)
 	       func_id == special_kfunc_list[KF_bpf_obj_new_impl];
 }
 
+static bool is_typed_arena_pages_kfunc(u32 func_id)
+{
+	return func_id == special_kfunc_list[KF_bpf_typed_arena_alloc_pages] ||
+	       func_id == special_kfunc_list[KF_bpf_typed_arena_free_pages];
+}
+
 static bool is_bpf_percpu_obj_new_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_percpu_obj_new] ||
@@ -14800,6 +14811,11 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 
 		insn_aux->obj_new_size = ret_t->size;
 		insn_aux->kptr_struct_meta = struct_meta;
+	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_typed_arena_alloc_pages])) {
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ARENA;
+		regs[BPF_REG_0].btf = env->prog->aux->btf;
+		regs[BPF_REG_0].btf_id = insn_aux->typed_arena->btf_id;
 	} else if (is_bpf_refcount_acquire_kfunc(meta->func_id)) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
@@ -15130,6 +15146,38 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ref_convert_owning_non_owning(env, id);
 	}
 
+	if (meta.btf == btf_vmlinux && is_typed_arena_pages_kfunc(meta.func_id)) {
+		struct bpf_typed_arena *ta;
+
+		if (!env->prog->aux->arena) {
+			verbose(env, "kfunc %s can only be used in a program that has an associated arena\n",
+				func_name);
+			return -EINVAL;
+		}
+		if (!env->prog->aux->btf) {
+			verbose(env, "kfunc %s requires program BTF\n", func_name);
+			return -EINVAL;
+		}
+		if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
+			verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
+			return -EINVAL;
+		}
+		ta = typed_arena_register(env, meta.arg_constant.value);
+		if (IS_ERR(ta))
+			return PTR_ERR(ta);
+		/*
+		 * The type ID is a register value, so it may differ between
+		 * paths; the fixup replaces it with the typed arena once per
+		 * call site, and the allocator's return value is typed by it.
+		 */
+		if (insn_aux->typed_arena && insn_aux->typed_arena != ta) {
+			verbose(env, "kfunc %s at insn %d is called with different types on different paths\n",
+				func_name, insn_idx);
+			return -EINVAL;
+		}
+		insn_aux->typed_arena = ta;
+	}
+
 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
 		if (!bpf_jit_supports_exceptions()) {
 			verbose(env, "JIT does not support calling kfunc %s#%d\n",
@@ -22493,6 +22541,18 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[2] = addr[1];
 		insn_buf[3] = *insn;
 		*cnt = 4;
+	} else if (is_typed_arena_pages_kfunc(desc->func_id)) {
+		struct bpf_typed_arena *ta = env->insn_aux_data[insn_idx].typed_arena;
+		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)ta) };
+
+		if (!ta) {
+			verifier_bug(env, "typed arena kfunc at insn %d has no typed arena", insn_idx);
+			return -EFAULT;
+		}
+		insn_buf[0] = addr[0];
+		insn_buf[1] = addr[1];
+		insn_buf[2] = *insn;
+		*cnt = 3;
 	} else if (is_bpf_obj_drop_kfunc(desc->func_id) ||
 		   is_bpf_percpu_obj_drop_kfunc(desc->func_id) ||
 		   is_bpf_refcount_acquire_kfunc(desc->func_id)) {
-- 
2.53.0

