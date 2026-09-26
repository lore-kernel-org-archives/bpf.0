Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507139F184
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465713; cv=none; b=CkZt0j5RHekD8FbDqwq8+OmBlF8QtaeoYzjzEyUFJPDn6k9lrDxmj4rKotodWyS84NfySxdi8kP7k4rFLIFlbuoUvjC4AvCO+sM0+06k3W9C4JQ9eWNY6Eeq3G8DnPP601Os4tukadXOT7t4XfFDOXtO+UrrSk899g/PUOFgbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465713; c=relaxed/simple;
	bh=s3pGqiB8c30hfMwlxXbHuQ1SSxlM65OPDiyGMjh3lPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hskL4mTkR6IXItLU20hkZxMECPIcqO5HU9YppNI+X1NYOBz5UMZ9gFE1itLlF5HJ0+gS9o+nt+h0OzBa60Rs78VWUM3PJbUjZHGbKC0KvNVr+nqTSNES1baKGAhov0iQwf5isaKAZRu0ZeYsFwlvQ3MmnmkPgOVfph1bo3yuCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNBTgtZU; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNBTgtZU"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9e8b8e2so4379445e9.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465709; x=1791070509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aD7Y7KmxBkxbP/uaRSl/sZNtuYCWSUKIiwb509zaiOU=;
        b=nNBTgtZUBo5413gmsQzCOpAPZvJx955eH2B0uS6n6DAR49J7HebHqYEtdnDbQ2vYxI
         KNzBU1AuYj21XJxJEEgixWQ0yWu3CICFZt757ovG3C3/jq/ksaZzX07C35ABdMWHUZiH
         3tSMiyCtUmBv14vtKO5l0bNbCKm8hgfbOTS2PE08sfCYDojruxJqLjT6piwUjIU+rSdy
         1p+KFaspHpDgq0ykNnfafipjSoiS7jk60IdaQT1f+4kixEsZNYvPMKxWKuAP5wIhQCQf
         olZI+DNWbnCuk+I8CuICL1AejQwD3sg7RJF3H6cnfOXVKvil9KANVEtmDK7pDZIaSk/y
         JmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465709; x=1791070509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aD7Y7KmxBkxbP/uaRSl/sZNtuYCWSUKIiwb509zaiOU=;
        b=XFro6PL1iUhiTDbO681pLciKY4Qc43PjEMPi/oky7OSPoE0knNtU5i82fn7sIzqGl4
         QMUUNZvNdEQraghgOLtNekXlMLkbZ2/xJfxYjs+27g6V9i5c2QFVOkgO52RNKk/IR5Pf
         Fv9Zj2H9MNy+4vz5VT2uNLl8O8vktfp4RteYPXILmr/8A85gDCuw68pvqeYek62QZ2QV
         6GamgK7/OxrVEsA/u42lxuzj/PDNCSle43igFhl+3CV+psN5aJbxMmvgk+DV5gYIQhFN
         64e05EBY5a9gsyjJ7oo1qizno9kT8UAJG1LYtjH6si++cp/1Grj9lNCavGFOwpSOob2X
         vi+w==
X-Gm-Message-State: AFuF++mdqQvN0zmKLerZRWWNfQA3fXS821QUZE9yJ2iWCbiGjASued6H
	Z66+S8oBb4d4bbc/QUifmxh3XpRwKsXqUlRoffXLNb1Md0REPncniCDByTapho3Y
X-Gm-Gg: AYBFou0Q863JDRvTVa3L2UxjOSTUYl2rS6IBz74XCeTAILdfsg0/tnapmTLWnRm/oOO
	M91RYRioSpbCVwsSiWhBUEBPxPuOsbTMjkIG8y5+TBZwenqlA70sDP/rnSWjeBX0MZNmUaVVsmP
	hjpq05FVq34Awpb4K8qLmeSGyuw1LpyMezRHYPq0vR9OqrUOk4Cfde/MfK30VgXABh/GbaO5AcX
	9E3E3WJCDhGi5Hb+hLBZMMyhEjskOUTb86eZcTNma2QhexfTNJ2IH1XwAe46x8uuBEW59UjRVgn
	FCihnBJKW3f9KKq3KeaVqJWWjsbZSvl0fcLa5p7W746Z5tB9nQJSIIxSJgaAq1uXNQ+F812gmy0
	c6DlNDZivSRrYOxVK7G8x1XPqLHBOgvdfvolQXqxpNHBtVX5U9gT4k5gjXPifOUWS4/2HFQF8Vn
	KIpPv957itSU5sJBFIEXDTAQyBC8ZdZDerO5X2LATxR0M8BGGs8kmv9o4J87ldW+T6gbCQwIcGN
	eaoYsxzuw4vDDR3NCYjcknerE16T4TGt3m+2nAhlue+19zFruJ714Jb2FsmOMlZ25NDyxHlmMdF
	nEm3VutPt37xtN+9P8R8HXly+1PZsA3i/SsjgQ==
X-Received: by 2002:a05:600c:198a:b0:49f:fbf1:3f7e with SMTP id 5b1f17b1804b1-49ffbf13ffbmr39630495e9.9.1790465708522;
        Sat, 26 Sep 2026 16:35:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a36189bsm16411745f8f.21.2026.09.26.16.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 02/16] bpf: Introduce BPF typed arenas
Date: Sun, 27 Sep 2026 01:34:40 +0200
Message-ID: <20260926233503.3114147-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19658; i=memxor@gmail.com; h=from:subject; bh=s3pGqiB8c30hfMwlxXbHuQ1SSxlM65OPDiyGMjh3lPI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWMxuJp6vq5+6TpyuWLJiYv11Zt0f03x3vbt+v/WNV VjuQjbWjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkzUFGhgPnklVk7i1+w3I1 cUnql2Nx4Rs7V6ub+WzafuJ1qHB/zV9Ghj+7fhveky2Iq1zjrvbm/TSpGGEJvavOUh8yOya4na/ M5QYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Objects with special fields cannot live in arena memory: user space maps the
arena and programs store arbitrary bytes into it, so the verifier trusts
nothing loaded from there, and a kptr field is a kernel pointer the kernel
must be able to trust. Give such objects a home next to the arena instead.

Reserve a typed arena region ahead of the arena's raw window, a kernel-only
4 GiB of virtual space user space never maps, and hand out one typed arena
per program-BTF struct with special fields: a power-of-two slice of the
region holding one object per power-of-two slot. Objects are reached through
native kernel pointers that the verifier constructs, so the region's memory
carries no user-visible representation and objects need no translation on
load or store; a later patch adds the instruction that turns any 64-bit value
into such a pointer, and another the fields the verifier trusts inside them.

The slice is aligned to its own size, which is what makes that cast a mask
and an add: masking a value with the slice's size less its slot lands on a
slot of the slice once the base is added, with no bounds check, no branch and
no subtraction. Alignment inside the region comes from placing a slice at a
multiple of its size, first-fit over the registry kept in address order, and
alignment of the region itself comes from reserving the arena's vm_area
aligned to the region with get_vm_area_align(), instead of over-reserving and
skipping slack in front. A slice is at most half the region, so that the mask
is a positive 32-bit immediate; the raw window and its guards keep their
layout and offset math, shifted behind the region.

The slot is the object's size rounded up to a power of two. That pads an
object by up to half its slot, the same trade the slab allocator makes for
its size classes, and it buys the four-instruction cast above: any denser
packing needs a reciprocal multiply to find an object boundary and a scratch
layout that repeats with the least common multiple of slot and page. Both
can be added later behind the same interface, since nothing about the slot
is visible to programs. The typed arena's size comes from the struct's
"typed_arena_size:" declaration tag, parsed by the verifier, with a 128 MiB
default; it decides how many objects the type can hold.

A typed arena is keyed by the BTF object and the type ID, so two programs
loaded from different objects get distinct slices even for structurally equal
structs, and it is registered at program load, where the verifier first meets
the type. A program whose load fails drops its references; a program that
loaded keeps the typed arena alive for the map's lifetime, so that objects
survive program reloads. The page tables of the whole slice are populated at
registration, because a fault on an unbacked typed page is recovered in
atomic context, which cannot allocate them then; they cost eight bytes per
page of the slice, 256 KiB for the default size, and are charged to the map
together with the two chunk bitmaps as memory fixed for the map's lifetime.

The chunk, the larger of the slot and a page, is the unit at which the slice
is backed: a chunk holds whole objects, so an object is never split between a
real page and a page backed some other way, and a chunk larger than a page is
one allocation of its order, so that a multi-page object is contiguous in the
direct map. Map teardown walks every slice, drops the special fields of the
objects of each real chunk through the arena mapping, still in place, and
frees the chunk's allocation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  62 ++++++++++
 kernel/bpf/arena.c  | 274 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 331 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4bae3796c42f..f06d138b1f57 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -45,6 +45,7 @@ struct bpf_prog;
 struct bpf_prog_aux;
 struct bpf_map;
 struct bpf_arena;
+struct bpf_typed_arena;
 struct sock;
 struct seq_file;
 struct btf;
@@ -275,6 +276,67 @@ struct btf_record {
 	struct btf_field fields[];
 };
 
+/*
+ * Typed arenas: kernel-only object storage next to an arena map. A program-BTF
+ * struct with special fields that a program casts to, or allocates, gets a
+ * typed arena: a power-of-two slice of the map's typed region, naturally
+ * aligned, holding one object per power-of-two slot. Objects are reached
+ * through native kernel pointers that the verifier constructs; a cast masks
+ * any 64-bit value into a slot of the slice, so every value names an object
+ * of the type. The chunk, max(slot, page), is the unit of backing: a chunk no
+ * program allocated reads as the zeroed scratch chunk, one dummy object per
+ * slot, once an access faults it in. The chunks bitmap marks every chunk that
+ * holds a mapping, real or scratch; pending marks the chunks whose release is
+ * queued, which stay mapped and marked until it has run. record is the
+ * struct's own special-field record, from the BTF that is retained here.
+ */
+#define BPF_TYPED_ARENA_SIZE_TAG "typed_arena_size:"
+#define BPF_TYPED_ARENA_DEFAULT_SIZE SZ_128M
+
+struct bpf_typed_arena {
+	struct list_head node;
+	struct bpf_map *map;
+	refcount_t refcnt;
+	struct btf *btf;
+	u32 btf_id;
+	u8 slot_shift;
+	u8 chunk_shift;
+	u8 size_shift;
+	void *base;
+	void *scratch;
+	struct page **scratch_pages;
+	unsigned long *chunks;
+	unsigned long *pending;
+	const struct btf_record *record;
+};
+
+static inline u64 bpf_typed_arena_size(const struct bpf_typed_arena *ta)
+{
+	return 1ull << ta->size_shift;
+}
+
+static inline u32 bpf_typed_arena_slot(const struct bpf_typed_arena *ta)
+{
+	return 1u << ta->slot_shift;
+}
+
+static inline u32 bpf_typed_arena_chunk(const struct bpf_typed_arena *ta)
+{
+	return 1u << ta->chunk_shift;
+}
+
+/* The cast mask keeps the slot index and drops the offset within the slot and the bits above the slice. */
+static inline u64 bpf_typed_arena_mask(const struct bpf_typed_arena *ta)
+{
+	return bpf_typed_arena_size(ta) - bpf_typed_arena_slot(ta);
+}
+
+struct bpf_typed_arena *bpf_typed_arena_get(struct bpf_map *map, struct btf *btf, u32 btf_id,
+					    const struct btf_record *record, u64 size);
+void bpf_typed_arena_put(struct bpf_map *map, struct bpf_typed_arena *ta);
+int bpf_typed_arena_cast_insns(const struct bpf_typed_arena *ta, u8 dst, u8 src,
+			       struct bpf_insn *buf);
+
 /* Non-opaque version of bpf_rb_node in uapi/linux/bpf.h */
 struct bpf_rb_node_kern {
 	struct rb_node rb_node;
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c6369ea5e208..9cd1b1ce434c 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -40,11 +40,33 @@
  * bpf program can allocate a page via bpf_arena_alloc_pages() kfunc
  * which will insert it into kernel vm_area.
  * The later fault-in from user space will populate that page into user vma.
+ *
+ * Ahead of the lower guard, the same vm_area holds the typed arena region, a
+ * kernel-only space user space never maps:
+ *
+ *   [ typed region 4 GiB ][ GUARD_SZ/2 ][ raw window 4 GiB ][ GUARD_SZ/2 ]
+ *   ^ kern_vm->addr                     ^ kern_vm_start
+ *
+ * A program-BTF struct with special fields that a program casts to gets a
+ * typed arena there: a power-of-two slice holding one object per power-of-two
+ * slot, reached through native kernel pointers. The region is aligned to its
+ * size and a slice sits at a multiple of its own size, so the slice is aligned
+ * to itself and a cast is a mask and an add: any 64-bit value masked with the
+ * slice's size less its slot, plus the base, is an object of the slice. Raw
+ * arena pointers and typed pointers never mix: a typed access is bounded by
+ * its slice, so the guard between the region and the window keeps it off the
+ * window, and the window's 32-bit offsets cannot reach the region.
  */
 
 /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
 #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
-#define KERN_VM_SZ (SZ_4G + GUARD_SZ)
+/*
+ * A slice is at most half the region: the cast masks with the slice's size
+ * less its slot, which must be a positive 32-bit immediate.
+ */
+#define TYPED_ARENA_REGION_SZ SZ_4G
+#define TYPED_ARENA_MAX_SZ SZ_2G
+#define KERN_VM_SZ (TYPED_ARENA_REGION_SZ + SZ_4G + GUARD_SZ)
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable);
 
@@ -60,7 +82,11 @@ struct bpf_arena {
 	/* number of pages currently populated in the arena */
 	u64 nr_pages;
 	struct list_head vma_list;
-	/* protects vma_list */
+	/* typed arenas in address order; mutated under lock, walked under RCU */
+	struct list_head typed_arenas;
+	/* memory of the typed arenas fixed at registration, for accounting */
+	u64 typed_arena_mem;
+	/* protects vma_list and typed_arenas */
 	struct mutex lock;
 	u64 zap_gen;
 	struct mutex zap_mutex;
@@ -78,9 +104,14 @@ struct arena_free_span {
 	u32 page_cnt;
 };
 
+static unsigned long typed_arena_region(struct bpf_arena *arena)
+{
+	return (unsigned long)arena->kern_vm->addr;
+}
+
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
 {
-	return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 : 0;
+	return arena ? typed_arena_region(arena) + TYPED_ARENA_REGION_SZ + GUARD_SZ / 2 : 0;
 }
 
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
@@ -263,6 +294,236 @@ static int populate_pgtable_except_pte(struct bpf_arena *arena)
 				   SZ_4G + GUARD_SZ / 2, apply_range_set_cb, NULL);
 }
 
+static unsigned long typed_arena_nr_chunks(const struct bpf_typed_arena *ta)
+{
+	return bpf_typed_arena_size(ta) >> ta->chunk_shift;
+}
+
+/* A chunk is one allocation of this order: a multi-page object is contiguous in the direct map. */
+static unsigned int typed_arena_chunk_order(const struct bpf_typed_arena *ta)
+{
+	return ta->chunk_shift - PAGE_SHIFT;
+}
+
+/*
+ * The memory a typed arena takes for the map's lifetime: a page table entry
+ * per page of the slice and the two chunk bitmaps.
+ */
+static u64 typed_arena_static_mem(const struct bpf_typed_arena *ta)
+{
+	return (bpf_typed_arena_size(ta) >> PAGE_SHIFT) * sizeof(pte_t) +
+	       2 * BITS_TO_LONGS(typed_arena_nr_chunks(ta)) * sizeof(long);
+}
+
+/*
+ * First-fit search for a slice of the region aligned to its own size. The
+ * registry is sorted by address, so its gaps are visited in order.
+ */
+static s64 typed_arena_find_slice(struct bpf_arena *arena, u64 size)
+{
+	unsigned long region = typed_arena_region(arena);
+	struct bpf_typed_arena *ta;
+	u64 off = 0, start;
+
+	list_for_each_entry(ta, &arena->typed_arenas, node) {
+		start = ALIGN(off, size);
+		if (start + size <= (unsigned long)ta->base - region)
+			return start;
+		off = (unsigned long)ta->base - region + bpf_typed_arena_size(ta);
+	}
+	start = ALIGN(off, size);
+	return start + size <= TYPED_ARENA_REGION_SZ ? start : -ENOSPC;
+}
+
+static void typed_arena_insert(struct bpf_arena *arena, struct bpf_typed_arena *ta)
+{
+	struct bpf_typed_arena *pos;
+
+	list_for_each_entry(pos, &arena->typed_arenas, node) {
+		if (pos->base > ta->base) {
+			list_add_tail_rcu(&ta->node, &pos->node);
+			return;
+		}
+	}
+	list_add_tail_rcu(&ta->node, &arena->typed_arenas);
+}
+
+/* Drop the special fields of every object of the chunk mapped at @chunk. */
+static void typed_arena_free_objects(const struct bpf_typed_arena *ta, void *chunk)
+{
+	u32 off;
+
+	for (off = 0; off < bpf_typed_arena_chunk(ta); off += bpf_typed_arena_slot(ta))
+		bpf_obj_free_fields(ta->record, chunk + off);
+}
+
+/*
+ * Free the real chunks of a typed arena at map teardown. A chunk is backed as
+ * a whole by one allocation of its order, so its first entry decides: the
+ * fields of its objects are dropped through the arena mapping, still in
+ * place, and the allocation is returned. The entries are not cleared;
+ * free_vm_area() does that for the whole area.
+ */
+static int typed_arena_teardown_cb(pte_t *ptep, unsigned long addr, void *data)
+{
+	struct bpf_typed_arena *ta = data;
+	pte_t pte = ptep_get(ptep);
+
+	if ((addr - (unsigned long)ta->base) & (bpf_typed_arena_chunk(ta) - 1))
+		return 0;
+	if (!pte_present(pte))
+		return 0;
+	typed_arena_free_objects(ta, (void *)addr);
+	__free_pages(pte_page(pte), typed_arena_chunk_order(ta));
+	return 0;
+}
+
+static void typed_arena_free(struct bpf_arena *arena, struct bpf_typed_arena *ta)
+{
+	WRITE_ONCE(arena->typed_arena_mem, arena->typed_arena_mem - typed_arena_static_mem(ta));
+	apply_to_existing_page_range(&init_mm, (unsigned long)ta->base, bpf_typed_arena_size(ta),
+				     typed_arena_teardown_cb, ta);
+	bitmap_free(ta->chunks);
+	bitmap_free(ta->pending);
+	btf_put(ta->btf);
+	kfree(ta);
+}
+
+/*
+ * Find or create the typed arena of a program-BTF struct. A typed arena is
+ * keyed by the BTF object and the type ID: two programs with different BTF
+ * objects get distinct slices even for structurally equal structs, and one
+ * BTF declares one size for a struct. The caller validated the record and
+ * parsed the size, a power of two between a page and TYPED_ARENA_MAX_SZ. The
+ * slot is the power of two covering the object, the chunk the larger of the
+ * slot and a page, so that a chunk holds whole objects and an object is never
+ * split between a real page and a scratch one. The page tables of the slice
+ * are populated here, in a sleepable context, because a fault on an unbacked
+ * typed page is recovered in atomic context, which cannot allocate them; they
+ * are charged to the map's memory, together with the bitmaps, for the map's
+ * lifetime. The reference returned is dropped with bpf_typed_arena_put().
+ */
+struct bpf_typed_arena *bpf_typed_arena_get(struct bpf_map *map, struct btf *btf, u32 btf_id,
+					    const struct btf_record *record, u64 size)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	const struct btf_type *t = btf_type_by_id(btf, btf_id);
+	struct bpf_typed_arena *ta;
+	u64 slot, chunk;
+	s64 off;
+	int err;
+
+	if (!t || !t->size || !record)
+		return ERR_PTR(-EINVAL);
+	if (!is_power_of_2(size) || size < PAGE_SIZE || size > TYPED_ARENA_MAX_SZ)
+		return ERR_PTR(-EINVAL);
+	slot = roundup_pow_of_two(t->size);
+	chunk = max_t(u64, slot, PAGE_SIZE);
+	if (slot > size || chunk > PAGE_SIZE << MAX_PAGE_ORDER)
+		return ERR_PTR(-E2BIG);
+
+	guard(mutex)(&arena->lock);
+
+	list_for_each_entry(ta, &arena->typed_arenas, node) {
+		if (ta->btf != btf || ta->btf_id != btf_id)
+			continue;
+		refcount_inc(&ta->refcnt);
+		return ta;
+	}
+
+	off = typed_arena_find_slice(arena, size);
+	if (off < 0)
+		return ERR_PTR(off);
+
+	ta = kzalloc(sizeof(*ta), GFP_KERNEL_ACCOUNT);
+	if (!ta)
+		return ERR_PTR(-ENOMEM);
+	ta->base = (void *)(typed_arena_region(arena) + off);
+	ta->size_shift = ilog2(size);
+	ta->slot_shift = ilog2(slot);
+	ta->chunk_shift = ilog2(chunk);
+	ta->chunks = bitmap_zalloc(typed_arena_nr_chunks(ta), GFP_KERNEL_ACCOUNT);
+	ta->pending = bitmap_zalloc(typed_arena_nr_chunks(ta), GFP_KERNEL_ACCOUNT);
+	if (!ta->chunks || !ta->pending) {
+		err = -ENOMEM;
+		goto free;
+	}
+	err = apply_to_page_range(&init_mm, (unsigned long)ta->base, size, apply_range_set_cb, NULL);
+	if (err)
+		goto free;
+	refcount_set(&ta->refcnt, 1);
+	ta->map = map;
+	btf_get(btf);
+	ta->btf = btf;
+	ta->btf_id = btf_id;
+	ta->record = record;
+	typed_arena_insert(arena, ta);
+	WRITE_ONCE(arena->typed_arena_mem, arena->typed_arena_mem + typed_arena_static_mem(ta));
+	return ta;
+
+free:
+	bitmap_free(ta->chunks);
+	bitmap_free(ta->pending);
+	kfree(ta);
+	return ERR_PTR(err);
+}
+
+/*
+ * Drop a reference taken by bpf_typed_arena_get(). Only a program whose load
+ * was rejected drops its references; a program that loaded keeps the typed
+ * arena alive for the map's lifetime, so that its objects survive program
+ * reloads. The last reference retracts the slice. Its page tables stay
+ * populated until the map is freed and serve the next slice placed there.
+ */
+void bpf_typed_arena_put(struct bpf_map *map, struct bpf_typed_arena *ta)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	guard(mutex)(&arena->lock);
+	if (!refcount_dec_and_test(&ta->refcnt))
+		return;
+	/*
+	 * No loaded program holds a pointer into a typed arena it did not
+	 * register, so nothing can fault in this slice; walkers of the registry
+	 * can still be stepping past this node.
+	 */
+	list_del_rcu(&ta->node);
+	synchronize_rcu();
+	typed_arena_free(arena, ta);
+}
+
+/*
+ * Lower a typed_arena_cast to plain BPF: dst = (src & mask) + base. The mask
+ * is the slice's size less its slot: it rounds any value down to a slot and,
+ * as a positive 64-bit AND, clears everything above the slice, so every input
+ * lands on an object of the type. The base is aligned to the slice's size, so
+ * nothing needs subtracting first. Return the number of instructions written.
+ */
+int bpf_typed_arena_cast_insns(const struct bpf_typed_arena *ta, u8 dst, u8 src,
+			       struct bpf_insn *buf)
+{
+	struct bpf_insn base[2] = { BPF_LD_IMM64(BPF_REG_AX, (unsigned long)ta->base) };
+	int cnt = 0;
+
+	if (dst != src)
+		buf[cnt++] = BPF_MOV64_REG(dst, src);
+	buf[cnt++] = BPF_ALU64_IMM(BPF_AND, dst, bpf_typed_arena_mask(ta));
+	buf[cnt++] = base[0];
+	buf[cnt++] = base[1];
+	buf[cnt++] = BPF_ALU64_REG(BPF_ADD, dst, BPF_REG_AX);
+	return cnt;
+}
+
+static void typed_arenas_free(struct bpf_arena *arena)
+{
+	struct bpf_typed_arena *ta, *tmp;
+
+	list_for_each_entry_safe(ta, tmp, &arena->typed_arenas, node) {
+		list_del(&ta->node);
+		typed_arena_free(arena, ta);
+	}
+}
+
 static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 {
 	struct vm_struct *kern_vm;
@@ -293,7 +554,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		/* user vma must not cross 32-bit boundary */
 		return ERR_PTR(-ERANGE);
 
-	kern_vm = get_vm_area(KERN_VM_SZ, VM_SPARSE | VM_USERMAP);
+	kern_vm = get_vm_area_align(KERN_VM_SZ, TYPED_ARENA_REGION_SZ, VM_SPARSE | VM_USERMAP);
 	if (!kern_vm)
 		return ERR_PTR(-ENOMEM);
 
@@ -307,6 +568,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		arena->user_vm_end = arena->user_vm_start + vm_range;
 
 	INIT_LIST_HEAD(&arena->vma_list);
+	INIT_LIST_HEAD(&arena->typed_arenas);
 	init_llist_head(&arena->free_spans);
 	init_irq_work(&arena->free_irq, arena_free_irq);
 	INIT_WORK(&arena->free_work, arena_free_worker);
@@ -392,6 +654,7 @@ static void arena_map_free(struct bpf_map *map)
 	 */
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
 				     SZ_4G + GUARD_SZ / 2, existing_page_cb, arena);
+	typed_arenas_free(arena);
 	free_vm_area(arena->kern_vm);
 	range_tree_destroy(&arena->rt);
 	__free_page(arena->scratch_page);
@@ -419,7 +682,8 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
-	return (u64)READ_ONCE(arena->nr_pages) << PAGE_SHIFT;
+	return ((u64)READ_ONCE(arena->nr_pages) << PAGE_SHIFT) +
+	       READ_ONCE(arena->typed_arena_mem);
 }
 
 struct vma_list {
-- 
2.53.0

