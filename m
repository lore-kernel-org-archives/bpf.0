Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D724EE873
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368788; cv=none; b=qkJTi+4LH32fyB3mK7livrihp1vxBzbLnfH/6Npy8Tp3VRi2VVRacpkv7V9yZpk3PZUaKmoypWbZFRRS2nQ9ejVgE7Ph39oRUo1SZgUitlrdwtiPsptoIn3QUdOdMBLy36rJdws8s38S5BcxGiNC1KkkO1/QkHbnwLkveaZGie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368788; c=relaxed/simple;
	bh=7uwIiiei7kNPRFH41o5MvXD1D9RJjbkGTqJuFnGD79E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7SWn1l+TdsU6X1ltrWYdYz7+Zqa5vv3zXI1HI2zydurUV0EI1fmXDoPCtu2HxO8OR/HecK2toWHeKX8gr8sf0EnyVujz51EjLN2EaW76D3rqd3UcvXA++mBV3C8Zf+YnBsa22B8y+LnlP4clv+hFp3bs11MzuIXTHwX4xLAJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=01/SA18S; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="01/SA18S"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0aa9d356eso1053059a91.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790368786; x=1790973586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbOBGD0hVAljTJaUxG5qD4DKfpHQkCJVw1IDi+J/+dU=;
        b=01/SA18SAo9WFTs/JVV3zdvvZG7n/Moa5y9MxtD5hLw+4VKnQ/KQC4eiv76BjxqD0g
         pdNhoyiqn0rUB3aoHa7+qoVItOcn2N/oHviWkmx3jHJFR79UebFiL90ZqpxuSlPk3/TO
         s8Lp/fsjLTKIJNM+nvNWaI2RT25Ji7pDMmC1kEjhVQGNqnmnY4qlmtpzHYIEC0JUjngS
         eYth8Xf0lO79utsx/g5RCHCNQCS4gLQJTH2K5ynWcmepKaTUEzeT/2ea2fNR6dfz95UA
         ZpsnvU49cdsqnIFynq5RKJACie/QU7qKqcXI2fXIwCtJtvJHTwSmfCSvGn8kfvv6yovT
         oAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368786; x=1790973586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbOBGD0hVAljTJaUxG5qD4DKfpHQkCJVw1IDi+J/+dU=;
        b=oPAfYOmr/KLwDIIral+dUbGndygOLCNCxyXafzAQNRrap05MdwbWYJsa8CNAtj2vE8
         HMTO95GFApfGD1yiCAitUx3FBdGrC9AYSYI/gxKbGaHo21J1tSxPiEvlOtkePI3EDvvF
         P7zvxFbaUZst1N7VDzER33SoWAfWcHdVV0yo25xT9heVqERG9s4/NDBPk5dKYV83rmPW
         E5JSIYlAQknlWxUQl0VPQDdTiS0rhKRycSLFWINRJwheeO2GTHoQy39/77GsoTc44Ghj
         t2qRXiqP7I9T2mwem49dDRdoYQa7piV9CYqZJDEUFoSsn9n5UF0SmV4sviHuogQ2+hSo
         o0pQ==
X-Gm-Message-State: AFuF++kgbc7qRN1GRPw3Ai/QL0zUxbzRrLkg8iL2wTvY4eGNrMm2ecKB
	zPkmawPMo3e7zyOHkFBTHz1nsjVMCI/cYQlI6Ly7swCcFeGea1vexaFmMLCRUT6vQ2+uNKmFwnB
	HRnFvZWw=
X-Gm-Gg: AYBFou2rsf0ybJy4MziyGgHddNYX/juuR97sDoYG1d83wORP1SqNj8M+X2dozOTFoiF
	amF7AMBYm4AJ7BCZ7m8A89VB84G29oU4W92F4yYJJzXGmgnHTDp58r+7S73q+byYdXGsP2cvLNp
	tt7DVxDf6BvzQrEM4cZCgKXutYwxf/Mn9RtJOJMFijSy1OMz1IMnQJ3xnKXrHRdfFKQp222n6Vf
	Bu+hnbwA6mXTnhZfyNo8aWiPYxcJ4vOva5SRMcVhCImrgm0pUiJ7w2TVWqhyQ7IjJFt0yhdHxfq
	EURrP8h8A3hHC9AqbqjrKc7xer8DvGVSKhQtSnXHIFPhIDWhwAokuLGV+JFtZuxSZ0nDMAKk/Za
	K33gXr8mJnsBxNja19QOaQGswZbdQ+T0sw0Kl9pLd5g0Gk7ujvrjr6UeUkE5CqNjswySE4XpFOV
	PA+8vzfdrI1OWltMyYW8sQ9HuJT3LegbBKPhroFGybmqPAi5v3nzyH06BcJF7IxykGdDiylLbTP
	A/k0ESEZolGH/D5gSq4i77QJox019gbY3tI0UStEA==
X-Received: by 2002:a17:90b:4b12:b0:3a0:b959:4479 with SMTP id 98e67ed59e1d1-3a0b959478fmr3164782a91.38.1790368786568;
        Fri, 25 Sep 2026 13:39:46 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm5955125a91.8.2026.09.25.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:39:46 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 3/7] bpf: Add sleepable arena page allocation path
Date: Fri, 25 Sep 2026 20:39:35 +0000
Message-ID: <20260925203939.4105-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925203939.4105-1-emil@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_arena_alloc_pages() function currently only allocates pages
inside a spinlock critical section with IRQs off. This forces the use of
alloc_pages_nolock() in the BPF allocator, even when the caller is a
sleepable BPF function. This in turn causes allocation failures even in
cases where falling into the allocator slow path and possibly sleeping
would eventually succeed. This can be triggered consistently by heavy
BPF arena users like scx.

Allocate the arena pages before taking the critical section and pass
whether the caller can sleep to bpf_alloc_pages(). This lets sleepable
callers use the blocking allocator while non-sleepable callers retain
the no-lock allocation behavior.

Since allocation now happens before range-tree arbitration, concurrent
callers can allocate pages for competing requests. Bound the aggregate
number of pages in this pre-arbitration window to the configured maximum
size of the arena.

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 99 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c556df7730c4..3301445deebb 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -59,6 +59,8 @@ struct bpf_arena {
 	rqspinlock_t spinlock;
 	/* number of pages currently populated in the arena */
 	u64 nr_pages;
+	/* number of pages being allocated before range-tree arbitration */
+	atomic_long_t nr_pages_inflight;
 	struct list_head vma_list;
 	/* protects vma_list */
 	struct mutex lock;
@@ -316,6 +318,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	init_irq_work(&arena->free_irq, arena_free_irq);
 	INIT_WORK(&arena->free_work, arena_free_worker);
 	bpf_map_init_from_attr(&arena->map, attr);
+	atomic_long_set(&arena->nr_pages_inflight, 0);
 
 	arena->scratch_page = bpf_alloc_page(NUMA_NO_NODE, true);
 	if (!arena->scratch_page)
@@ -713,6 +716,48 @@ static u64 clear_lo32(u64 val)
 	return val & ~(u64)~0U;
 }
 
+static bool arena_reserve_inflight_pages(struct bpf_arena *arena, long page_cnt)
+{
+	long limit = arena->map.max_entries;
+	long old;
+
+	old = atomic_long_read(&arena->nr_pages_inflight);
+	do {
+		if (old > limit || page_cnt > limit - old)
+			return false;
+	} while (!atomic_long_try_cmpxchg(&arena->nr_pages_inflight, &old,
+					 old + page_cnt));
+
+	return true;
+}
+
+static void arena_release_inflight_pages(struct bpf_arena *arena, long page_cnt)
+{
+	WARN_ON_ONCE(atomic_long_sub_return(page_cnt,
+					    &arena->nr_pages_inflight) < 0);
+}
+
+static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt, long *pgoff)
+{
+	int ret;
+
+	/* Special case where user is requesting specific range. */
+	if (uaddr) {
+		ret = is_range_tree_set(&arena->rt, *pgoff, page_cnt);
+		if (ret)
+			return ret;
+		return range_tree_clear(&arena->rt, *pgoff, page_cnt);
+	}
+
+	ret = range_tree_find(&arena->rt, page_cnt);
+	if (ret < 0)
+		return ret;
+
+	*pgoff = ret;
+
+	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
+}
+
 /*
  * Allocate pages and vmap them into kernel vmalloc area.
  * Later the pages will be mmaped into user space vma.
@@ -730,6 +775,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	unsigned long flags;
 	long pgoff = 0;
 	u32 uaddr32;
+	long addr = 0;
 	int ret;
 
 	if (node_id != NUMA_NO_NODE &&
@@ -747,8 +793,15 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			/* requested address will be outside of user VMA */
 			return 0;
 	}
+	if (!arena_reserve_inflight_pages(arena, page_cnt))
+		return 0;
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+
+	ret = bpf_alloc_pages(node_id, page_cnt, &pages, sleepable);
+	if (ret)
+		goto out_memcg;
+
 	data.arena = arena;
 	data.pages = &pages;
 	data.i = 0;
@@ -756,25 +809,14 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
 		goto out_free_pages;
 
-	if (uaddr) {
-		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
-		if (ret)
-			goto out_unlock_free_pages;
-		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
-	} else {
-		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
-		if (pgoff >= 0)
-			ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
+	if (ret) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		goto out_free_pages;
 	}
-	if (ret)
-		goto out_unlock_free_pages;
 
 	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
 
-	ret = bpf_alloc_pages(node_id, page_cnt, &pages, false);
-	if (ret)
-		goto out;
-
 	/*
 	 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
 	 * will not overflow 32-bit. Lower 32-bit need to represent
@@ -787,26 +829,33 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
 	mapped = data.i;
 	if (ret)
-		goto out;
+		goto out_unmap;
 
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	bpf_map_memcg_exit(old_memcg, new_memcg);
-	return clear_lo32(arena->user_vm_start) + uaddr32;
-out:
+
+	addr = clear_lo32(arena->user_vm_start) + uaddr32;
+	goto out_memcg;
+
+out_unmap:
+	if (sleepable)
+		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (mapped) {
-		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
+	if (mapped || sleepable) {
+		if (!sleepable)
+			flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 		arena_free_pages(arena, uaddr32, mapped, sleepable);
 	}
-	goto out_free_pages;
-out_unlock_free_pages:
-	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
 out_free_pages:
 	bpf_free_pages(&pages);
+
+out_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-	return 0;
+	arena_release_inflight_pages(arena, page_cnt);
+
+	return addr;
 }
 
 /*
-- 
2.52.0

