Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235350C28F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379346; cv=none; b=gUJlgYBxzptZLK3NbkoSxpew4hReQDnArQza586sM4gskgZSQWpNysNhsRgkYeiNdqF90PMf3vloEGecKogSd1C87X4haNFInTCcVPH+vCfS0NPveu5Wn/a2gRKCo5IRBb6+mRFLDzkfYgpO2yhZOzd8hAZqRndrImwwIZw0sCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379346; c=relaxed/simple;
	bh=I6l4U3HL7UebPhuLD07LXQ8TIqxW3lFPmJwM11BX/vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4TF0KzYvGk4c8xFh+CG9LW1FZZB3C8GzyZVO7TVZCEZlhomG4Mb3NZf/bCjWAinjmf8Z/BYdMi9J4MD2sOMGXbQdns9ySX4nY2M5Vv/fNPB7dZ68KJ7ROwS8krkT2MEP4MtZU/mk2H0JdK1SEO2hqjBoODSgjaRuboS5+Bp4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=POTkxsO5; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="POTkxsO5"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e69so294667a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790379345; x=1790984145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=POTkxsO56boZXC6tAsMMro8v2Am+HMxG7oSy3tgKcx/P1r18JqKmZovFwlEvttEOdX
         P7Bg4TY6BScqDhxXnBucOV7/F7EIpOrExsLkSOxmtkf0MvAcEig/0xMcoOa4bsxvb/kH
         r0XCYNlrFDuXfu5Qjb5OPgo0id37ETvRoNqqFwe03X5tMEFqA2HEy5nRCPTMCqB88QJv
         X2aMyZTc+oQsiqCiCGfgo3qZMdkGJsU3fztzPT+KcEh+mRKxYy9EyT2gVrkQOcn1mi8c
         yX7WIlIien+/SNRLhNbUPk7iznwf/fB4emCFDbxsYhuGi8uFQ9o3RVaWeVzpJ+J9cKPZ
         x8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379345; x=1790984145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=Bd6vuqwD4sHSPCQiXdxV8DfKseE4hut1DXAMmcQ/1jOL3pIwhLTctA0zx1AlrrfpYN
         lFMoWrQCy3X7RZeW9tzrqO5/gZXjlCvAiRLfwbcZG5se8wAreQNes46gP1WzL1+P1+Cf
         t3GBmLHK1JkWg67eZYn2sUZbxKsR7eL91pPZDv4S1We3szoxRnGTRXEhlFz7Osk3ZCKo
         EIM9ZE4tibVV9SNrQbKX94H1NpRmzDM+NrrWTjLg6S9ut+r/pz6/TTJlievro50fb04Y
         Tbxa7+jAT8RAYIGfLt36LRI+zEURJkJyQsKEq9okUhe2wMUrrUo0jTBPmgAM/6FMxhDi
         Gd7Q==
X-Gm-Message-State: AFuF++n83Jd1GQOENfb62oXx/qGxwxq2Nr5x3JmdHiF7LiyYQzr2lyBt
	1Q2Uy2WLh5cxzMxw1e0nXo76pBM+XrIipoLb1jMMRc5swiK1gdfvsL0YqILO+A23/h4UAq8snC4
	hckT7E58=
X-Gm-Gg: AYBFou1SG/HCVMajeIi4bD7LCV2ypZd9V+MfedGMAb4xm8Kc1BLOvbbdH2XVFfyHseo
	qW3Jc1HqaH/1FcalugNSoP49ivTgeBiCIqmYqwRuS0+sYROBCmINTFPT40khkczw89geQzFYAR5
	lr514PJshbVnMQawVEOvi3sez7neks5YbMlD5V2UxWAkiKHGmu2ocL1+RtmlJ0F25D7bLXwivCP
	Vu3B4ii8ju8v9HsQV6EfRMxQ/ehTM8Sdgfw6JKkGGXRgYsMgUiEa6fcFHRUTRqlrUEBGHZmuxdK
	rnsjWX4TjfSEjBZgyjqsDG/0ytaabwxQ7FC8TTQIo6X8ae0nnxqijVORUefb5LdfgvYq1oE5VNU
	DyhG9Na7IXdpTpgSXern2le0Is6BwH/GBrAdkaGbCMH6thtP0cjg8B296wNeywSa+bwLuwEG5Sk
	kzE7CwNZf3gXWoo6thwMWxbSfpW+ZArY9sq1U0FRzHPYHFucFJPFqnu2A5Nne/D/MaN5pDgzVrr
	70lIOYNfXED1DsnjQdxCA085nMSAHl9CiOvpV3jE++csF8tr27jVG1fW7cQ8pE=
X-Received: by 2002:a17:90b:2dc5:b0:3a0:22bd:6ee5 with SMTP id 98e67ed59e1d1-3a098570ea3mr5463262a91.14.1790379344510;
        Fri, 25 Sep 2026 16:35:44 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm5790436a91.15.2026.09.25.16.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:35:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 3/7] bpf: Add sleepable arena page allocation path
Date: Fri, 25 Sep 2026 23:35:34 +0000
Message-ID: <20260925233538.5708-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925233538.5708-1-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com>
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

