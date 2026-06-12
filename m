Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92587391846
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302026; cv=none; b=NxfSxU2HbhB8AVuEUpG/CQGH3O2UKGgT0nHC+ZhpTC8uAR5ViXEd3sGz1Pd7KJQ3rzouqxPOu8vpKmKN6DPNJcZjctB2S+SrtqcLaBywb6YmNz9lyzQkJFp/WvozjHfUtA2tapMqRUT9MR0Gap8VY6r6rR5ElAnEA8RyT2aunfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302026; c=relaxed/simple;
	bh=0wcKU796CkHk34R2e2geFofZQTyR4hJ9tqGB/S3bBxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBXE07N4xAjpIdGoPujMGMx997Vr/TpktCVItcMIpX/OtqBmvRZ+sjpip0MD3MOtLuh1SSj5oEhsnAs90U96LHZOTFfHK6dqkV/z50ehCFnhiQ4OwnhcJ04EaqqtaGPtlHiF/Zpjy+uGi9JGuz4MgPkEn89R9bD1aQGAZG7g1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QlCNVjUG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QlCNVjUG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781302022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ATUMdG+3DCMOOJvzkisoehUIS+VeDTtyeHORJNXV87E=;
	b=QlCNVjUGvwSzN+UjtNOFtbnB4QiHVWVwF6HOgHOlCxzQswk3NVYEPV4P0fCrvh/VryafH8
	Ym6KMh0SDMTSMbDGYe+ON2955wMK4aLjHL/pF7MrXBNiRvrYOxrxp7b8/SjxG10maqqtL1
	58zxsuXdNdb8QlRqm/TVO6k+ifLPsfE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] bpf: Better build_id caching in stack_map_get_build_id_offset()
Date: Fri, 12 Jun 2026 15:06:51 -0700
Message-ID: <20260612220651.2507843-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch is a follow up to recent implementation of
stack_map_get_build_id_offset_sleepable() [1].

stack_map_get_build_id_offset() and its sleepable variant each cached
only the last successfully resolved VMA, with separate bookkeeping in
each function. A run of IPs in a VMA with no usable build ID will
repeat the lookup for every frame: find_vma() in the non-sleepable
path, a VMA lock and a blocking build_id_parse_file() in the sleepable.

Factor the per-call cache into a shared struct stack_map_build_id_cache
with two independent slots [2][3], used by both functions:

  * resolved   - last VMA that produced a build ID (file, build_id and
                 range), reused to skip the lookup and the parse;
  * unresolved - last VMA with no usable build ID (range only), reused to
                 emit a raw IP without another lookup or parse.

Keeping the slots independent means a build-ID-less VMA no longer evicts
the last resolved build ID, so a trace alternating between a binary and a
region without one stops re-resolving the binary on every return.

The shared lookup tests [vm_start, vm_end), matching the sleepable path;
the non-sleepable path previously reused a build ID for ip == vm_end
(range_in_vma() is inclusive) and now re-resolves it correctly.

[1] https://lore.kernel.org/bpf/20260525223948.1920986-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-iWVUN3F06=g@mail.gmail.com/
[3] https://lore.kernel.org/bpf/CAEf4BzZXJFr=1iiVx937ht=4PYQkQHg=eFk810zhMDzXQG3ihw@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

v1->v2:
  * nits in attempt to de-claudify the diff (Alexei)
    * factor out local variables in stack_map_build_id_set_from_cache()
      to make the conditions more readable
    * make comments more concise
  * I am ignoring the issue flagged by sashiko, since it's unrelated
    to the patch

v1: https://lore.kernel.org/bpf/20260609210749.3448062-1-ihor.solodrai@linux.dev/

---
 kernel/bpf/stackmap.c | 175 +++++++++++++++++++++++++++++-------------
 1 file changed, 122 insertions(+), 53 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 77ba03216c09..822b5cb188ea 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -175,6 +175,88 @@ static inline void stack_map_build_id_set_valid(struct bpf_stack_build_id *id,
 		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
 }
 
+/*
+ * Per stack_map_get_build_id_offset() call cache of the last VMA with a build ID
+ * resolved and the last VMA with no usable build ID.
+ * Adjacent stack frames tend to land in the same VMA or the same backing file,
+ * so caching the last result of each kind lets us skip unnecessary VMA lookups
+ * and build ID parse calls.
+ * A zero vm_end marks a slot as empty.
+ * resolved.build_id aliases the id_offs[] entry.
+ */
+struct stack_map_build_id_cache {
+	struct {
+		struct file *file;	/* pinned in the sleepable path; NULL otherwise */
+		const unsigned char *build_id;
+		unsigned long vm_start;
+		unsigned long vm_end;
+		unsigned long vm_pgoff;
+	} resolved;
+	struct {
+		unsigned long vm_start;
+		unsigned long vm_end;
+	} unresolved;
+};
+
+/*
+ * Fill @id from a cached range covering @ip. On a hit this writes @id (resolved
+ * range -> build ID + offset, unresolved range -> raw ip) and returns 0; on a
+ * miss it leaves @id untouched and returns -ENOENT.
+ */
+static int stack_map_build_id_set_from_cache(struct stack_map_build_id_cache *cache,
+					     struct bpf_stack_build_id *id, u64 ip)
+{
+	unsigned long vm_start, vm_end, vm_pgoff;
+	u64 offset;
+
+	vm_start = cache->resolved.vm_start;
+	vm_end = cache->resolved.vm_end;
+	if (vm_end && ip >= vm_start && ip < vm_end) {
+		vm_pgoff = cache->resolved.vm_pgoff;
+		offset = stack_map_build_id_offset(vm_pgoff, vm_start, ip);
+		stack_map_build_id_set_valid(id, offset, cache->resolved.build_id);
+		return 0;
+	}
+
+	vm_start = cache->unresolved.vm_start;
+	vm_end = cache->unresolved.vm_end;
+	if (vm_end && ip >= vm_start && ip < vm_end) {
+		stack_map_build_id_set_ip(id);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * Record @vma's build ID as the last resolved one. @file is the pinned backing
+ * file in the sleepable path (released when evicted), or NULL otherwise.
+ */
+static void stack_map_build_id_cache_set_resolved(struct stack_map_build_id_cache *cache,
+						  struct file *file,
+						  const unsigned char *build_id,
+						  unsigned long vm_start,
+						  unsigned long vm_end,
+						  unsigned long vm_pgoff)
+{
+	if (cache->resolved.file)
+		fput(cache->resolved.file);
+	cache->resolved.file = file;
+	cache->resolved.build_id = build_id;
+	cache->resolved.vm_start = vm_start;
+	cache->resolved.vm_end = vm_end;
+	cache->resolved.vm_pgoff = vm_pgoff;
+}
+
+/* Record [vm_start, vm_end) as a range with no usable build ID. */
+static void stack_map_build_id_cache_set_unresolved(struct stack_map_build_id_cache *cache,
+						    unsigned long vm_start,
+						    unsigned long vm_end)
+{
+	cache->unresolved.vm_start = vm_start;
+	cache->unresolved.vm_end = vm_end;
+}
+
 struct stack_map_vma_lock {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
@@ -244,15 +326,8 @@ static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
 static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
 						    u32 trace_nr)
 {
-	struct mm_struct *mm = current->mm;
-	struct stack_map_vma_lock lock = { .mm = mm };
-	struct {
-		struct file *file;
-		const unsigned char *build_id;
-		unsigned long vm_start;
-		unsigned long vm_end;
-		unsigned long vm_pgoff;
-	} cache = {};
+	struct stack_map_vma_lock lock = { .mm = current->mm };
+	struct stack_map_build_id_cache cache = {};
 	unsigned long vm_pgoff, vm_start, vm_end;
 	struct vm_area_struct *vma;
 	struct file *file;
@@ -262,44 +337,40 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 	for (u32 i = 0; i < trace_nr; i++) {
 		ip = READ_ONCE(id_offs[i].ip);
 
-		/*
-		 * Range cache fast path: if ip falls within the previously
-		 * resolved VMA range, reuse the cache build_id without
-		 * re-acquiring the VMA lock.
-		 */
-		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
-			offset = stack_map_build_id_offset(cache.vm_pgoff, cache.vm_start, ip);
-			stack_map_build_id_set_valid(&id_offs[i], offset, cache.build_id);
+		if (!stack_map_build_id_set_from_cache(&cache, &id_offs[i], ip))
 			continue;
-		}
 
 		vma = stack_map_lock_vma(&lock, ip);
 		if (!vma) {
 			stack_map_build_id_set_ip(&id_offs[i]);
 			continue;
 		}
+
+		vm_pgoff = vma->vm_pgoff;
+		vm_start = vma->vm_start;
+		vm_end = vma->vm_end;
+
 		if (vma_is_anonymous(vma) || !vma->vm_file) {
-			stack_map_build_id_set_ip(&id_offs[i]);
 			stack_map_unlock_vma(&lock);
+			stack_map_build_id_set_ip(&id_offs[i]);
+			stack_map_build_id_cache_set_unresolved(&cache, vm_start, vm_end);
 			continue;
 		}
 
 		file = vma->vm_file;
-		vm_pgoff = vma->vm_pgoff;
-		vm_start = vma->vm_start;
-		vm_end = vma->vm_end;
 		offset = stack_map_build_id_offset(vm_pgoff, vm_start, ip);
 
 		/*
-		 * Same backing file as previous (e.g. different VMAs
-		 * of the same ELF binary). Reuse the cache build_id.
+		 * Same backing file as the last resolved VMA (another mapping
+		 * of the same ELF binary): reuse its build_id without re-parsing.
 		 */
-		if (file == cache.file) {
+		if (file == cache.resolved.file) {
 			stack_map_unlock_vma(&lock);
-			stack_map_build_id_set_valid(&id_offs[i], offset, cache.build_id);
-			cache.vm_start = vm_start;
-			cache.vm_end = vm_end;
-			cache.vm_pgoff = vm_pgoff;
+			stack_map_build_id_set_valid(&id_offs[i], offset,
+						     cache.resolved.build_id);
+			cache.resolved.vm_start = vm_start;
+			cache.resolved.vm_end = vm_end;
+			cache.resolved.vm_pgoff = vm_pgoff;
 			continue;
 		}
 
@@ -310,21 +381,17 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
 			stack_map_build_id_set_ip(&id_offs[i]);
 			fput(file);
+			stack_map_build_id_cache_set_unresolved(&cache, vm_start, vm_end);
 			continue;
 		}
 
 		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
-		if (cache.file)
-			fput(cache.file);
-		cache.file = file;
-		cache.build_id = id_offs[i].build_id;
-		cache.vm_start = vm_start;
-		cache.vm_end = vm_end;
-		cache.vm_pgoff = vm_pgoff;
+		stack_map_build_id_cache_set_resolved(&cache, file, id_offs[i].build_id,
+						      vm_start, vm_end, vm_pgoff);
 	}
 
-	if (cache.file)
-		fput(cache.file);
+	if (cache.resolved.file)
+		fput(cache.resolved.file);
 }
 
 /*
@@ -343,8 +410,8 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
 	bool has_user_ctx = user && current && current->mm;
-	struct vm_area_struct *vma, *prev_vma = NULL;
-	const unsigned char *prev_build_id = NULL;
+	struct stack_map_build_id_cache cache = {};
+	struct vm_area_struct *vma;
 	int i;
 
 	if (may_fault && has_user_ctx) {
@@ -365,27 +432,29 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 
 	for (i = 0; i < trace_nr; i++) {
 		u64 ip = READ_ONCE(id_offs[i].ip);
-		u64 offset;
 
-		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
-			vma = prev_vma;
-			offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
-			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
+		if (!stack_map_build_id_set_from_cache(&cache, &id_offs[i], ip))
 			continue;
-		}
+
 		vma = find_vma(current->mm, ip);
 		if (!vma || vma_is_anonymous(vma) ||
 		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
-			/* per entry fall back to ips */
+			/* per entry fall back to ips; cache build-ID-less range */
 			stack_map_build_id_set_ip(&id_offs[i]);
-			prev_vma = vma;
-			prev_build_id = NULL;
+			if (vma)
+				stack_map_build_id_cache_set_unresolved(&cache,
+						vma->vm_start, vma->vm_end);
 			continue;
 		}
-		offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
-		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
-		prev_vma = vma;
-		prev_build_id = id_offs[i].build_id;
+		/* mmap_lock is held for the whole loop, so the cached VMA
+		 * fields stay valid; no file pinning is needed here.
+		 */
+		stack_map_build_id_set_valid(&id_offs[i],
+			stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip),
+			id_offs[i].build_id);
+		stack_map_build_id_cache_set_resolved(&cache, NULL, id_offs[i].build_id,
+						      vma->vm_start, vma->vm_end,
+						      vma->vm_pgoff);
 	}
 	bpf_mmap_unlock_mm(work, current->mm);
 }
-- 
2.54.0

