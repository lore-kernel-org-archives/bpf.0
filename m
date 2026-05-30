Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB507280A51
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103633; cv=none; b=kj2hDnYOPFKtcERS2H6WmxeGXNEid3v4Zunf5DnHejV0aQla5+5YYyPVa1A2kxsEm+9h2rdyu9QDct3Fx+k5FfIzSUTM30Dm0K/C+ETeSwNqDDh/HPIkZzOypHRnIAYmY9OSxtWmqJP0KL3KfsmIjngu73IRkhrkLaJJBQ48qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103633; c=relaxed/simple;
	bh=dfdOpza12MxvQrTDHav5RQdbF7Kl6c6DJkT6fvYfQN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdItEkH/zqPMHnWzx+rIphyYxR0RrM9nk9IZBRr2xfzI6R4r3iJaury/9liS3yWaGaEE0FIT8tjvWr7uFYWkxXAEAZLWrfMVePYzMCn31ToXtYoLQspHe2TRspYONDjmV4moFGkEDleP1Sg/p7XE7NIAadI3MYYw4xjC+kbYGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkA5xfET; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkA5xfET"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3664df32e91so16040725a91.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780103631; x=1780708431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fynmi7rwIFSu+oBdSJtvFLSS5oGz3SZ+v13+iDre5xg=;
        b=fkA5xfETM1mSOQAPHnWCiy94+MFA7oTiUMJcWTzrN7/Ox6pas5bBTSt6ORWWjWzygv
         VGJdqiwTCgHpEK0F2rffS89Er0I3VwVZSaKnUc2iNB3STeggrqc8tiIRCY8U7Z97DvoT
         LDw/ymwKe10OXCKW87htg5kVL3ZuZzt3FiLpu09kMizZVISySq20jFyQXLvE6UbBDvYn
         NmpDD9fieukXxYrrSh0ePbEdbE4dWZTCqLuT7BIu6MvxnN57pRVMr/kXz5aFpAFiQUzH
         TkuRJnyf2luLAHAsUYFJ8rDU7YzzbezXkWj3f5eDP9bXqFrQlU/M0MwpVKxHL94EwULR
         W6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780103631; x=1780708431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fynmi7rwIFSu+oBdSJtvFLSS5oGz3SZ+v13+iDre5xg=;
        b=eyZcDMPX7zLjwcL+cySgeRSto37zCuA/rzCOYgYDJwlQbAsnPyFY4jVYvm3Fj0QDWe
         +JnsYrofDxC2WzkS3IAtV0C16y5I65LRCpXPcmCfPDuwPbGCdO5YubRLlooWzx5l5e46
         cvSh4OkrvywNKlUmsvmLMBnBM5HhsX/NMfwy6nydVCpIrlreEmx7HZsvqZSWLeg0hmeI
         jp+OPLRV6i0lb0zBDJaErFqJ4KrCY6R8ijbeIkAGVIQ0z76nv2ihDz3mbbqoaXFMxi8A
         frmAZDZ/mVWI8jV7lwIEtcZsttn6dsKQKHv/rV4JbqkmWFljIhaQ6WFFFVYeZH8ZqERe
         d3VA==
X-Gm-Message-State: AOJu0YytAC0k5Zja1AA20oITz53UB3sFi7v1Fcl33f9ZrCFaBd/6xrtG
	W/rbqRV+1U4sOUT9CYOj+wdN3PnX9p4HX8gcvuB/RF7DqAcjtocCaZL+VHECeQ==
X-Gm-Gg: Acq92OFCXpsykbFa+GisD6hJByCFlnp/Y5vHtlIV0+ezotP0rHxZqFo7eBMubISjCJI
	O/J4E5bOvFtrffxa58WscP1o33xO0obs4qFNFHzgCv8et86nZ7O/7tnQoPpmGKegrc2+lPzuFLd
	FNVryLsLMYUHZYQxZvgT2noy2YINNxIekPaQ5Icf17hbPj1VEybiGpm+9yp77jEvu8RRGaIY6sY
	cm01+Q2nc3Bq3zGyKdtjD+htDSKCffqxS7dicXcxP4CJ5vXJjHVgTWtAYQE+eVZjwP7ITLbf9fg
	6uYBmzBWozgvXkGwrM/TQCtgNkscbrSjPuy17NR5nA+63gi8EnGceD8EuQogPxo+dnV1U1hS+jn
	TEkkHp5Uri4+iac7OHYuAyWyGXqaZkYS157f/yA5SfCIgvl4y4O+JSiKdU/uM5CddB8OoQ91uSt
	07PlNNQB8sRk88xacrrAHem4k6laFS0dcgGP8P4UEhsqVNssHRK4dgSzMOK3WTXE9bSWXXnBxxe
	Sh7D2AL5HneE0WklRINpVb1jDT87zozFiSuP/WfdKSV7hASoymNrb9SMhRmaWQEQT09SamI2bMC
	o1IGcoU=
X-Received: by 2002:a17:90b:5383:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-36c501ea53amr1511150a91.18.1780103630850;
        Fri, 29 May 2026 18:13:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6b4865csm3012878a91.13.2026.05.29.18.13.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 18:13:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	david@kernel.org,
	tj@kernel.org,
	roman.gushchin@linux.dev,
	peterz@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 bpf-next 1/4] slab: Introduce kmem_cache_alloc_arena_nolock and kfree_arena_nolock
Date: Fri, 29 May 2026 18:13:41 -0700
Message-ID: <20260530011345.99342-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add kmem_cache_alloc_arena_nolock() and kfree_arena_nolock(), nolock
slub helpers tailored for SLAB_BPF_ARENA caches. They mirror the
existing kmalloc_nolock() / kfree_nolock() shape -- safe from any
context (NMI, IRQ-off), NULL on transient trylock failure -- with one
deliberate omission: the KASAN slab hooks are skipped.

The skip is the point. Arena objects are owned by untrusted BPF
programs: a BPF program may free the same pointer twice, free a
misaligned pointer, or otherwise misuse the allocator. The arena
layer detects and reports those as violations through
bpf_prog_report_arena_violation(); they must not surface as kernel
KASAN splats. Skipping kasan_slab_pre_free / kasan_slab_free on the
free side and slab_post_alloc_hook / kasan_kmalloc on the alloc side
keeps KASAN's per-object tracking out of the arena cache entirely,
so the BPF kfunc boundary is the single point that classifies arena
misuse.

The free path routes through __slab_free() (not defer_free()) since
arena freepointer slots are BPF-writable -- defer_free()'s in-object
llist chain could be redirected through a poisoned freepointer.

Used by the upcoming SLAB_BPF_ARENA kfunc path so arena object
alloc/free can run from BPF program context.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/slab.h |  3 ++
 mm/slub.c            | 82 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2b5ab488e96b..152ed0aefd89 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -512,6 +512,7 @@ void * __must_check krealloc_node_align_noprof(const void *objp, size_t new_size
 
 void kfree(const void *objp);
 void kfree_nolock(const void *objp);
+void kfree_arena_nolock(const void *objp);
 void kfree_sensitive(const void *objp);
 
 DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
@@ -958,6 +959,8 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
 #define kmalloc_nolock(...)			alloc_hooks(kmalloc_nolock_noprof(__VA_ARGS__))
 
+void *kmem_cache_alloc_arena_nolock(struct kmem_cache *s, int node);
+
 /**
  * __alloc_objs - Allocate objects of a given type using
  * @KMALLOC: which size-based kmalloc wrapper to allocate with.
diff --git a/mm/slub.c b/mm/slub.c
index a2bf3756ca7d..c3899cc1dd1d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5402,6 +5402,50 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 }
 EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);
 
+/**
+ * kmem_cache_alloc_arena_nolock - allocate one object from a SLAB_BPF_ARENA
+ * kmem_cache, safe from any context (including NMI / IRQ-off).
+ * @s:    the SLAB_BPF_ARENA kmem_cache to allocate from
+ * @node: NUMA node hint (NUMA_NO_NODE for any)
+ *
+ * Counterpart to kfree_arena_nolock(). The slab_post_alloc_hook() and
+ * kasan_kmalloc() steps that the regular alloc path runs are deliberately
+ * skipped: arena objects are user-controlled and a BPF program may double-
+ * free, free a misaligned pointer, etc. Those must be reported by the arena
+ * layer (bpf_prog_report_arena_violation()), never surface as kernel KASAN
+ * splats.
+ *
+ * __GFP_ACCOUNT is intentionally not supported. Arena pages are already
+ * memcg-charged by bpf_map_alloc_pages() at the page-allocator boundary;
+ * adding per-object accounting on top would double-count.
+ *
+ * Returns NULL on transient trylock failure.
+ */
+void *kmem_cache_alloc_arena_nolock(struct kmem_cache *s, int node)
+{
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC;
+	void *ret;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
+		return NULL;
+	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
+		return NULL;
+
+	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
+		return NULL;
+
+	ret = alloc_from_pcs(s, alloc_gfp, node);
+	if (!ret)
+		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_,
+					s->object_size);
+	if (!ret)
+		return NULL;
+
+	maybe_wipe_obj_freeptr(s, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kmem_cache_alloc_arena_nolock);
+
 void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags,
 					 int node, unsigned long caller)
 {
@@ -6635,6 +6679,44 @@ void kfree_nolock(const void *object)
 }
 EXPORT_SYMBOL_GPL(kfree_nolock);
 
+/*
+ * kfree_arena_nolock - free a SLAB_BPF_ARENA object, safe from any context.
+ *
+ * Counterpart to kmem_cache_alloc_arena_nolock(). The kasan_slab_pre_free()
+ * and kasan_slab_free() hooks that kfree_nolock() runs are deliberately
+ * skipped (see kmem_cache_alloc_arena_nolock() for the rationale). The
+ * memcg_slab_free_hook(), alloc_tagging_slab_free_hook() and kmsan_slab_free()
+ * hooks are skipped too: arena pages are memcg-charged at allocation by
+ * bpf_map_alloc_pages() (no per-object accounting), arena objects don't
+ * participate in alloc-tagging, and kmsan tracking on BPF-writable memory
+ * would be meaningless.
+ *
+ * The free is routed through __slab_free() because arena freepointer slots
+ * are BPF-writable and defer_free()'s in-object llist chain could be
+ * redirected through a poisoned freepointer.
+ */
+void kfree_arena_nolock(const void *object)
+{
+	struct slab *slab;
+	struct kmem_cache *s;
+	void *x = (void *)object;
+
+	if (unlikely(ZERO_OR_NULL_PTR(object)))
+		return;
+
+	slab = virt_to_slab(object);
+	if (unlikely(!slab))
+		return;
+
+	s = slab->slab_cache;
+
+	if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, x, false)))
+		return;
+
+	__slab_free(s, slab, x, x, 1, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(kfree_arena_nolock);
+
 static __always_inline __realloc_size(2) void *
 __do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
 {
-- 
2.53.0-Meta

