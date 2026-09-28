Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F154F7CA1
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627213; cv=none; b=JeUkzzb1AkSCXZg7xOte2hn1gFbUJ0MWHsmZ8Sr8eboytqtxKuLmSyKO3g0XtGwTDtTGsNpDvRA7Vg/OcXmEBL5DUj/4fqJkeDh3ZTNTXKu+dfWA+sBl3GbJmbBjkEpSOvtzfBpXZ1YlaVQHE2Kp+ADfSLPNV4cKjsrueSN5npM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627213; c=relaxed/simple;
	bh=I6l4U3HL7UebPhuLD07LXQ8TIqxW3lFPmJwM11BX/vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvU2HounWUFAJcIWiGX7pWJ8U41FN8lhqV3ZSQJ67pLJj7eqHLt3O9lY/t40KTIdqKKo4zkldnsrgX1Pqk/OvA/2sIcS0Do34Ix8I4cVuICui1VMQqztWneS4BVKMaZrxQM1TrN/8BNPKPr+g9kmmYx0X3Xu9AHZh/o429mnvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XFvVuU5T; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="XFvVuU5T"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso117201a91.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790627211; x=1791232011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=XFvVuU5T+TidoxjCo91amyiruZaowI9rn3zZOybGFaVgQXOG51UHK3HpTRX+kBGoJT
         Yk8ficDqLZ+k4l7mGeIk56zUqhjjtb4A5f+fNTJRUxYiakbqX2kdrNk9EH+Hewv/IKsZ
         yqddhzA2yphoAZl5fB+kYIMHZJlbkE3xwVV5I95f+La0BMx6Lf81DOus+HSXck+5PiMh
         TWHj4iwyH+kE/rHF70M8aWdX+uVfGDxT9ZQ6DsWzvPI4szKyqNdR3MlEGbdqItGqVKrX
         VbBMBKHoZlCIRP2qex0TAd2gqbHOlyFks4HzYFKYgbtOdz84OvmQ17lYXpIGFx7BzpXL
         9inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627211; x=1791232011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=PECCWqxA6YcLY6zjTQB9OuAfrK55mIbi+xDegd0+pJosp5d6NGG/5x2tDOXpatg7FC
         8HGZJpMxnpaxUC9rqZp1zOTqypbA63zMIyIdYN/rCHBi5t2k/9H7q5iOLuFt/jk8hNrU
         RbrgxTmCuwlEISV7eurhcoea20uQ/0o2ilRKSn1xLmQ+MsyWI9zjKFfliNxJwURfJ9AA
         JJcSqTnr/BAaT57h3Px5XP27+QsKnWHgqg0JW0oRzLoyIlDB7xOMHNjikn9UZrQLbx1G
         TYJZ5nWjSJ8EXMXubDEO/a/uv7eIvhdcJvGHpYYsSR2YqMDy4EubFiGbSOLfBEXpBQ4B
         5bUw==
X-Gm-Message-State: AFq9FYJQ7OyS27EOy3LFcIloPwQtS6E139luGROfdJRqT0FjR/7Wbt0g
	hip8VY+2uFpVJ4cv66nRd+R8FW2hQHO83afIcKasRVsjH7RGlbpsfPNVbPjZgptPvK6fQRTy9CO
	HuMMqolk=
X-Gm-Gg: AYBFou1er2c6ryhKBjUsv1Tzs/y7LMv7CV8gp8s5vGW0HXSWiVGzeYemi3n+/3i4hNW
	dACFdu1IkZLigSh9Uyh1BcFSkgrUg1/KjwucUGnU+YpVyMLu00r8wORo2eB276TAMfEmRwR5EQk
	IaO7BmfpQwI2hQjSda10RlD91nBSpSp3VK8vqBH0EXGb7dYF0evaoDRZigG5EZKqob9RYYe9H3V
	Y9lnnfqxluZy8vIrxKBfWfZLGKw/95nR1Z1/BUb93QAMv+xl6EGONhhkH+wfPjVAGBynCpXAKjW
	B2V5qJlCTLBnbRd1PffRRIVfzhsdVImCnx3Ak+n/OzdRP2jEQv9EeTDkaWRmQ5x9NzhEgaFHRva
	CvS1hHTCQUxNPt/ngk9sOJVTIKuk3ByVFPzJ/IYpG+ffYT8FH/7bYZd1uQs3XjAyY9Q2V6WTp/e
	A9YKMgbG8qKsrwjzAGflc3m+BUIbSxX0HjP1V/PXmD+46BqwgjzZHHQQBb3tmoqFwi6EWuHeu3D
	jY1QORob8/xBahn3Q3cyuUsE73uOh+orkpLVmOw2A==
X-Received: by 2002:a17:90b:2d8c:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3a4967c70d5mr500097a91.21.1790627210822;
        Mon, 28 Sep 2026 13:26:50 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492ea04b1sm975193a91.4.2026.09.28.13.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:26:50 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 3/7] bpf: Add sleepable arena page allocation path
Date: Mon, 28 Sep 2026 20:26:39 +0000
Message-ID: <20260928202643.9114-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928202643.9114-1-emil@etsalapatis.com>
References: <20260928202643.9114-1-emil@etsalapatis.com>
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

