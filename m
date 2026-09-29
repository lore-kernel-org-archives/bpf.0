Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7E550DA8
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707175; cv=none; b=szhPPMQ5MJAPbRG8or5UyitLWAS2SZCYRM7IM34DgAj4VglTJ0tlCCMZ+ep69KIGih98luCpu8NTTpKmaJki1mqcHukKLybLkgmPZeadsqoW2eV+CkKupy9EnC8S126pvYn8k07qUyvB/sPrcfkn+ZSZ4hXqv9ZmboCUjfOKejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707175; c=relaxed/simple;
	bh=I6l4U3HL7UebPhuLD07LXQ8TIqxW3lFPmJwM11BX/vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxVT2OQk9josWZ3jvv+deT2FKHTui92MfpiGztzr6OXtsVk0glhJ6yycjatJ0SqeToXFH2YuMZGTyb/Oq2fI03CuoN7TnN6+6hTW1979y51PBDZxpyo5xxggFvcKr8CkZdRkonbbUACF8krLNwBEYihu5ZaSYXMvx21qzwBq2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bF1H4IEY; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bF1H4IEY"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso953679a91.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790707173; x=1791311973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=bF1H4IEYWQMwvDM3DxGNehwKQ2vUMmi3C0lZ+Go87/viizWTSTocHMwN1RefIoyBpJ
         bUN8+WR2iOJwRz/tu4VJysGEujI0KNz5/1afZfb58hw5dNVZT3s6QNDvQzBqc34925jv
         +HGUBRy+N4ly1OVU3vyWjXpBB8UIEly11fy+HPnwiNdM+pRb6ymjhxmk11Hp9upPxCVt
         Kx3iVVva6zZAwrMWtGVwsCI1dGuPl4feJHO8zpsPSktEYUac/zWnedua7AEkVDHXLiV1
         lLplryiL5DysK7Fh/GMRyOjNyAgdwl6J1l6fHFaZlrk3JyrsYZ6In8lvUDJUrETuoin8
         LTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707173; x=1791311973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=LQb0ninVC2dGwC4GBKb+lnlLqM6S/RavD+rrIGBHoyI9DLIfjUvtf+6oFSfCQUIggL
         PFF332IpwXJY9ecFvy1V4y4Qak/8zpC4/mzvIcqj0Zk4Tfrrod6de1TJ0+H5U+GkTfUp
         lvllWO/Kd4DY5M38GOH/N896QfzHK0l1bTfssFhPi/+j2qrKf3R7cLRvUQHxcWu/+Pvz
         pVI+L4IrW7V48jkHRb24l9B4V8Ev99uscCFwWmKggSCwjDYPobv6JpwfzbhZ4sAhN8Ve
         cxe+HjjpIfr02qUkkU9OkO2JIgy+KlFu7e56Bre8patLyVmvjpWjWfCsK5kAK9BmalZA
         vWhg==
X-Gm-Message-State: AFq9FYKLMUTYSp/fpITq65JJBJegS1huq6xf3vUyXyl5BsOfQ1zf66YW
	kw/TbZCrhHnr3Ko6xVDefpfDW5WPBgBGRrVSzCUmOqVGcKBpwbTNyGY4XIm9kRNNat3Xu7dr0i1
	CmVknZYk=
X-Gm-Gg: AYBFou23kCVsEAm/dq0xImFi4qpf4ZgHxNRVlQut9ZlfELF1cXdMcnroONZFlYOR2gL
	D/C+yWvz7iuNN/+KLw55teHHpV2gtx8K9ZfEBUWdsFtMoMyWEyKEotaqItkODL+MuFUHwahKoQp
	ll/WaOgbMpOxjOh4R03Q1IjILDjFHXzjQ07PjaxrjXb3GkSDrVnzgaoD2u6AMtrhl6INFqw1/hl
	zBP0C2M0AwVljgYXIciccUg46WuOF7/1E/xytDYe5tqik6pZS9UxWjQw9EI66Xfn0c4QSLxxkFi
	o6t23yIQ1eEnTTBKX1WSZAtwTNXTR2d2q1e3eDO10Tzy2+KhmC/TeUmXwPfFrBcTqN550/HlPrI
	H9nF5QryDmHbLHLHFZ++3DoscL60grVd6m2D5NysxQ1S4lDXix8OpNkbteKAs6LCQHjA/yXN44I
	HVBUlyEtKdHOJVqfY+xPlajuIg4V1J0Kna3w3pBw5Lewp5WnB2nrSC6M1xkcxtZwQqegoRX+wDb
	kjW/tGNIMEHtNQYGgDBLOAZcDUbr+CZeowUL+zIRg==
X-Received: by 2002:a17:90b:4fc7:b0:3a2:b0a1:456b with SMTP id 98e67ed59e1d1-3a4c00604cfmr161684a91.47.1790707173098;
        Tue, 29 Sep 2026 11:39:33 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858bf27sm6796494a91.4.2026.09.29.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:39:32 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 3/7] bpf: Add sleepable arena page allocation path
Date: Tue, 29 Sep 2026 18:39:24 +0000
Message-ID: <20260929183928.4896-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929183928.4896-1-emil@etsalapatis.com>
References: <20260929183928.4896-1-emil@etsalapatis.com>
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

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 73 +++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c556df7730c4..0ff707707da0 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -713,6 +713,27 @@ static u64 clear_lo32(u64 val)
 	return val & ~(u64)~0U;
 }
 
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
@@ -730,6 +751,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	unsigned long flags;
 	long pgoff = 0;
 	u32 uaddr32;
+	long addr = 0;
 	int ret;
 
 	if (node_id != NUMA_NO_NODE &&
@@ -747,8 +769,12 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			/* requested address will be outside of user VMA */
 			return 0;
 	}
-
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+
+	ret = bpf_alloc_pages(node_id, page_cnt, &pages, sleepable);
+	if (ret)
+		goto out_memcg;
+
 	data.arena = arena;
 	data.pages = &pages;
 	data.i = 0;
@@ -756,25 +782,14 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
@@ -787,26 +802,30 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
+	/* Error handling: Undo partial mappings. */
+	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (mapped) {
-		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
+	if (mapped)
 		arena_free_pages(arena, uaddr32, mapped, sleepable);
-	}
-	goto out_free_pages;
-out_unlock_free_pages:
-	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
 out_free_pages:
+	/* Error handling: Free back any unmapped pages. */
 	bpf_free_pages(&pages);
+
+out_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-	return 0;
+
+	return addr;
 }
 
 /*
-- 
2.52.0

