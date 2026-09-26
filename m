Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBC3115A2
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465714; cv=none; b=eH01cNVr95Nkjo8PrCIFXabaHzEgfLs/Efl3a4+4aRi75WcSKfnQxPLYVth8Yi45Hy5ze+ApDXRS8WG4XYf7rQwsfUjJltcArlIziLu9noTXlvB5zawXNI4H7nRRLAs8iDDbeT4eUfnW4HbGzHtn+QaBmlsQeZysyGv+Tx8up5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465714; c=relaxed/simple;
	bh=vbhtY1wb5Nt7OSfY6WRC7q53fIRx2Evs1p0LJr676BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq1yUG2WRNEt40mc/gxjvnmKu2B2AlZHJ76d0VqXHDmzloM2uON6jrqzrkCgCIBnbX/czvFHOSjeLpbuH90y7wCMxAgYOVtHVuXL+0vpGtN5erI4b9YB5qwyNHDd3tqvwvCUoRAg+2e0aPO2c8X7bdZwSpPz5ANRWs+iYABGAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoX89G5H; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoX89G5H"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48880f7a049so484810f8f.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465710; x=1791070510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRreVZGaMK7JzIdjbf813/C6NU70991qy9eB5NRfg+0=;
        b=MoX89G5H52/aX+MrN3V7lzL+qhpr+/tFje65BYDkTcltDB5smBJhC4ywJpj5x91TB+
         4reqxWAqpmNaM8zBSfyrbbV+t6jSPIBDNQqBJvuw1Ei5cyBImXPgxukfN+1MRMTu1n0q
         QiLDz4O8BgKNJhnjCj6FWSoN3e6BNtDeLL35FE3/FujdT7mufZKd2Oacc+8tDgCJfOZA
         mf5YwMPetV/TyAJMLIWLeX5Ll5jsUlCrOn2Wf1dK/Vyf9x2v1mukzNqZdsQJcH7dvIQt
         BOaglrLHQkrhkdJMo9glPbFfV/br/4umcBGz//Oh5+zwkrmQbS1FLPMpl6Y9v4yWmI3K
         UJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465710; x=1791070510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRreVZGaMK7JzIdjbf813/C6NU70991qy9eB5NRfg+0=;
        b=PPMQMWfJ+/XFRQ+dOGn6Qkujpf/d2hqAlO97dDV8dkGNfmhxApXeiXH4wCvjAL/0Nf
         9xmqqKsgnNUptyqhHXeqwzj8PpSdqfSEy8rs1p+oOjXOkQLKYZN5LkXmDg/aKyxV81Wr
         I+T8JHes4rKrigYy5etdlx45VAEGz+VZhrEsF5ZHAiLIuyhLCC5FBHkzOpka1uP6Q0XO
         RHOLiRFWvsNdP99k4qyD4T2JkYh6R2qy6/AaWyK82iRO/16bIWvI/f7l5byd2vP46vfY
         YVq+JoHkjTXJ1VHCDE0kzng7vING0R/kBhPGcl0sjP7LRMN3zVd/Ulp4JmuQkx1koO+f
         AdgQ==
X-Gm-Message-State: AFuF++neMOnC/XQkworQ1a0a5GWdxImob/Xx9fZe304ADwRQdwXl6+cM
	yTyfkoJcI83wYAw1a58AwXXr81gf7oS4gH4meUj9J4txZnwxf3mzwfcW67SGRJ2B
X-Gm-Gg: AYBFou3C1Egq0YWrCIzrBDVHfNc5jMoBMmnwed2VkkswKxAF/R9P3GOOwWZotr4Nai9
	+XRaZp0G3bMd8YKUzAztnvRKOyCUaGdYpyYI+ccS1Q1bkJT5cLc8VbMALN3syT4z4HI88xYgr0Y
	y6eV4b5cAGC7hM7YHfhnpaAvCLmcaqnaxLWxq6XC5pTltPOalA29+Awdh7+F0wTi+3ve8fh7r/5
	v9FzrNZKPYpwhD/1MWMXiZAPvhTXSP4K7Fp9xbeqbwQYiflNGG7EmihC2a3KCB1pWepDP+MNsem
	jKmPLHskjUNeNdV+8xwM2gWxGKVfbpUpuNYY3D6U9wZ1cwu0PxuVGSZ58J+cNEZ9GOcXZuKKEve
	xN0lzXEkGcQ38+V0XTc3sooAoThMr8LBztOCfVlTiTo3ZJ6edQfw3fFpyPifxz5l+OWXfjoYY64
	vQEIiNGyy2UgE4y1sJ8Vi1KMdvf1rPilXBSccuAJISEqZQzzsstpp+V9AVVnHIx1Bxzzeyn+8Xc
	1LWorsRi3p2cVmb/hKokxB8/rbmEDKWkgMJo82yocaZsJES790wPSGyaNJI81uvH41QrCa+UHEQ
	jgQt+I4TN9Yi/drpKAD87dA3r3nhA+LhcNH6ZH9OdI3df38M
X-Received: by 2002:a05:600c:4688:b0:49b:96a0:5c00 with SMTP id 5b1f17b1804b1-49fe66c61fcmr182360785e9.13.1790465710262;
        Sat, 26 Sep 2026 16:35:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017998dbsm17488425e9.14.2026.09.26.16.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 03/16] bpf: Back typed arena chunks with scratch on demand
Date: Sun, 27 Sep 2026 01:34:41 +0200
Message-ID: <20260926233503.3114147-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11507; i=memxor@gmail.com; h=from:subject; bh=vbhtY1wb5Nt7OSfY6WRC7q53fIRx2Evs1p0LJr676BM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWGz0ldY8vdL68/pLzJgXZ7s7tqzJ8WL8l//z7RzjH XurPyV0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgF4CazMPyP6p0XI/gxumab3fEv j2eZ6Okdqlli3+EU86kjjuFS6kQGhl9Ma3sOsjxXX6U5+1mGQV0qh0R//Lk3f1Z5/JOsuHfddCU TAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The cast that produces a typed arena pointer never fails: it masks any value
into a slot of the slice, so a program can reach every object the slice
could hold, whether or not anything allocated it. Every such pointer must
still denote a valid object of the type, or the native accesses through it
would fault, and a kptr exchange would write a kernel pointer into unbacked
memory. So back the slice on demand: an access to an unbacked page of the
slice faults, and the kernel fault recovery of the arena, reached through
bpf_arena_handle_page_fault(), installs scratch memory there and resumes
the access, reporting it on the program's stderr stream as a use of an
unallocated object.

The scratch memory is one zeroed chunk per typed arena, and the page of the
scratch chunk installed at a faulting page is the one at the same position in
the chunk. A chunk holds whole objects laid out from its start, so the dummy
objects a program sees are laid out exactly like real ones: a kptr field of
one dummy object never aliases a scalar field of another, which matters
because a kptr stored through one pointer must not be readable as a scalar
through another, and the special fields of the dummy objects can be dropped
at map teardown by walking the scratch chunk like a real one. This is why
the chunk, rather than the page, is the unit of backing, and why the slot is
a power of two: with objects straddling pages at arbitrary offsets the
layout would differ from page to page, and the scratch memory would have to
grow to the period at which it repeats. The scratch chunk is shared by every
unallocated chunk of the slice, so the dummy objects behave as one sink: a
program that writes through a stray pointer sees its writes through every
other stray pointer to the same position, and a kptr it leaves there lives
until the map is freed.

The fault path marks the chunk taken in the bitmap before installing the
page, with an atomic bit set because a program can fault in any context it
runs in, including NMI, and the allocator, added next, only backs chunks
that are not marked. A real page never replaces a scratch page either: a
program may be in the middle of using the dummy object, nothing can wait for
that use to end because the next stray access faults the scratch page right
back in, and the effect of the mapping changing under a kernel operation on
the object has not been reasoned through. The raw arena can replace its
scratch page because its contents are raw data. A chunk the fault path took
is given back with the release kfunc like any other, after which it can be
allocated or faulted again.

Refuse to register typed arenas on architectures that do not provide the
atomic PTE installer, since those do not wire up the arena fault path and a
typed access there would oops. The guard between the region and the raw
window stays outside recovery: a typed access is bounded by its slice and
cannot reach it, so a fault there is still a bug to oops on.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/arena.c | 115 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 9cd1b1ce434c..c757c1932360 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -67,6 +67,16 @@
 #define TYPED_ARENA_REGION_SZ SZ_4G
 #define TYPED_ARENA_MAX_SZ SZ_2G
 #define KERN_VM_SZ (TYPED_ARENA_REGION_SZ + SZ_4G + GUARD_SZ)
+/*
+ * Typed accesses are native loads and stores, so a fault on an unbacked typed
+ * page can only be recovered where the arena's kernel fault path is wired up,
+ * which is where the architecture provides an atomic PTE installer.
+ */
+#ifdef ptep_try_set
+#define TYPED_ARENA_SUPPORTED true
+#else
+#define TYPED_ARENA_SUPPORTED false
+#endif
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable);
 
@@ -305,13 +315,28 @@ static unsigned int typed_arena_chunk_order(const struct bpf_typed_arena *ta)
 	return ta->chunk_shift - PAGE_SHIFT;
 }
 
+static u32 typed_arena_chunk_pages(const struct bpf_typed_arena *ta)
+{
+	return bpf_typed_arena_chunk(ta) >> PAGE_SHIFT;
+}
+
+/* The page of the scratch chunk that backs the page at @addr while its chunk is unallocated. */
+static struct page *typed_arena_scratch_page(const struct bpf_typed_arena *ta, unsigned long addr)
+{
+	unsigned long off = addr - (unsigned long)ta->base;
+
+	return ta->scratch_pages[(off & (bpf_typed_arena_chunk(ta) - 1)) >> PAGE_SHIFT];
+}
+
 /*
  * The memory a typed arena takes for the map's lifetime: a page table entry
- * per page of the slice and the two chunk bitmaps.
+ * per page of the slice, the scratch chunk with its page array, and the two
+ * chunk bitmaps.
  */
 static u64 typed_arena_static_mem(const struct bpf_typed_arena *ta)
 {
 	return (bpf_typed_arena_size(ta) >> PAGE_SHIFT) * sizeof(pte_t) +
+	       bpf_typed_arena_chunk(ta) + typed_arena_chunk_pages(ta) * sizeof(struct page *) +
 	       2 * BITS_TO_LONGS(typed_arena_nr_chunks(ta)) * sizeof(long);
 }
 
@@ -371,7 +396,7 @@ static int typed_arena_teardown_cb(pte_t *ptep, unsigned long addr, void *data)
 
 	if ((addr - (unsigned long)ta->base) & (bpf_typed_arena_chunk(ta) - 1))
 		return 0;
-	if (!pte_present(pte))
+	if (!pte_present(pte) || pte_page(pte) == typed_arena_scratch_page(ta, addr))
 		return 0;
 	typed_arena_free_objects(ta, (void *)addr);
 	__free_pages(pte_page(pte), typed_arena_chunk_order(ta));
@@ -383,6 +408,10 @@ static void typed_arena_free(struct bpf_arena *arena, struct bpf_typed_arena *ta
 	WRITE_ONCE(arena->typed_arena_mem, arena->typed_arena_mem - typed_arena_static_mem(ta));
 	apply_to_existing_page_range(&init_mm, (unsigned long)ta->base, bpf_typed_arena_size(ta),
 				     typed_arena_teardown_cb, ta);
+	/* Programs may have stored kptrs into the dummy objects. */
+	typed_arena_free_objects(ta, ta->scratch);
+	vfree(ta->scratch);
+	kfree(ta->scratch_pages);
 	bitmap_free(ta->chunks);
 	bitmap_free(ta->pending);
 	btf_put(ta->btf);
@@ -408,11 +437,14 @@ struct bpf_typed_arena *bpf_typed_arena_get(struct bpf_map *map, struct btf *btf
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	const struct btf_type *t = btf_type_by_id(btf, btf_id);
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct bpf_typed_arena *ta;
 	u64 slot, chunk;
 	s64 off;
-	int err;
+	int err, i;
 
+	if (!TYPED_ARENA_SUPPORTED)
+		return ERR_PTR(-EOPNOTSUPP);
 	if (!t || !t->size || !record)
 		return ERR_PTR(-EINVAL);
 	if (!is_power_of_2(size) || size < PAGE_SIZE || size > TYPED_ARENA_MAX_SZ)
@@ -444,10 +476,17 @@ struct bpf_typed_arena *bpf_typed_arena_get(struct bpf_map *map, struct btf *btf
 	ta->chunk_shift = ilog2(chunk);
 	ta->chunks = bitmap_zalloc(typed_arena_nr_chunks(ta), GFP_KERNEL_ACCOUNT);
 	ta->pending = bitmap_zalloc(typed_arena_nr_chunks(ta), GFP_KERNEL_ACCOUNT);
-	if (!ta->chunks || !ta->pending) {
+	ta->scratch_pages = kcalloc(typed_arena_chunk_pages(ta), sizeof(*ta->scratch_pages),
+				    GFP_KERNEL_ACCOUNT);
+	bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
+	ta->scratch = __vmalloc(chunk, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+	if (!ta->chunks || !ta->pending || !ta->scratch_pages || !ta->scratch) {
 		err = -ENOMEM;
 		goto free;
 	}
+	for (i = 0; i < typed_arena_chunk_pages(ta); i++)
+		ta->scratch_pages[i] = vmalloc_to_page(ta->scratch + i * PAGE_SIZE);
 	err = apply_to_page_range(&init_mm, (unsigned long)ta->base, size, apply_range_set_cb, NULL);
 	if (err)
 		goto free;
@@ -462,6 +501,8 @@ struct bpf_typed_arena *bpf_typed_arena_get(struct bpf_map *map, struct btf *btf
 	return ta;
 
 free:
+	vfree(ta->scratch);
+	kfree(ta->scratch_pages);
 	bitmap_free(ta->chunks);
 	bitmap_free(ta->pending);
 	kfree(ta);
@@ -1460,6 +1501,64 @@ static void __bpf_prog_report_arena_violation(struct bpf_prog *prog, bool write,
 	}));
 }
 
+static struct bpf_typed_arena *typed_arena_lookup(struct bpf_arena *arena, unsigned long addr)
+{
+	struct bpf_typed_arena *ta;
+
+	list_for_each_entry_rcu(ta, &arena->typed_arenas, node)
+		if (addr - (unsigned long)ta->base < bpf_typed_arena_size(ta))
+			return ta;
+	return NULL;
+}
+
+static void __bpf_prog_report_typed_arena_violation(struct bpf_prog *prog,
+						    const struct bpf_typed_arena *ta,
+						    bool write, unsigned long addr)
+{
+	const struct btf_type *t = btf_type_by_id(ta->btf, ta->btf_id);
+	struct bpf_stream_stage ss;
+
+	/* Use main prog for stream access */
+	prog = prog->aux->main_prog_aux->prog;
+
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Typed arena %s access to unallocated struct %s at 0x%lx\n",
+				  write ? "WRITE" : "READ", btf_name_by_offset(ta->btf, t->name_off),
+				  addr & ~((unsigned long)bpf_typed_arena_slot(ta) - 1));
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
+/*
+ * A typed access reached an unbacked page, so the program used a pointer to an
+ * object nobody allocated, which the cast permits by design. The pointer must
+ * still denote an object of the type: back the page with the page of the
+ * scratch chunk at the same position, so that the dummy objects the program
+ * sees are laid out like real ones and a kptr field of one never aliases a
+ * scalar field of another. Mark the chunk taken first, so that the allocator
+ * never puts real pages where a program may be in the middle of using the
+ * dummy object; nothing could wait for that use to end, since the next stray
+ * access would fault the scratch page right back in. The mark is an atomic
+ * bit because the fault can happen in any context a program runs in.
+ */
+static bool typed_arena_handle_page_fault(struct bpf_arena *arena, struct bpf_prog *prog,
+					  unsigned long addr, bool is_write)
+{
+	unsigned long page_addr = addr & PAGE_MASK;
+	struct bpf_typed_arena *ta;
+
+	guard(rcu)();
+	ta = typed_arena_lookup(arena, page_addr);
+	if (!ta)
+		return false;
+	set_bit((page_addr - (unsigned long)ta->base) >> ta->chunk_shift, ta->chunks);
+	apply_to_page_range(&init_mm, page_addr, PAGE_SIZE, apply_range_set_scratch_cb,
+			    typed_arena_scratch_page(ta, page_addr));
+	flush_vmap_cache(page_addr, PAGE_SIZE);
+	__bpf_prog_report_typed_arena_violation(prog, ta, is_write, addr);
+	return true;
+}
+
 bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write, unsigned long fault_ip)
 {
 	struct bpf_arena *arena;
@@ -1476,12 +1575,16 @@ bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write, unsigned lon
 	if (!arena)
 		return false;
 
+	if (page_addr - typed_arena_region(arena) < TYPED_ARENA_REGION_SZ)
+		return typed_arena_handle_page_fault(arena, prog, addr, is_write);
+
 	kbase = bpf_arena_get_kern_vm_start(arena);
 
 	/*
 	 * Recovery covers the 4 GiB mappable band plus the upper half-guard.
-	 * Lower guard is unreachable from kfuncs; an address there indicates
-	 * a different bug class - leave it to the regular kernel oops path.
+	 * Lower guard is unreachable from typed accesses and from kfuncs; an
+	 * address there indicates a different bug class - leave it to the
+	 * regular kernel oops path.
 	 */
 	if (page_addr < kbase || page_addr >= kbase + SZ_4G + GUARD_SZ / 2)
 		return false;
-- 
2.53.0

