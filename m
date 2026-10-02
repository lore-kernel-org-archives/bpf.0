Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7D47DD6E
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938348; cv=none; b=gZCyK6zPuQW1lU+rk5l/F41KnLm/33vsMFOQmw95N/mtCZplfiVYolY1G7hOr3E6h39IxZckapbr7/cSxuo5Axj0r5+ao4wBLnOe5OEkDg9BDrdXSDk++vozHHr3SQMiTj3um12zrZWQrxOTwN9XTdIdwiau5VxD69HD8rputDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938348; c=relaxed/simple;
	bh=I6l4U3HL7UebPhuLD07LXQ8TIqxW3lFPmJwM11BX/vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx9VhHWThKxKsYDmIyZQnAXNRmOlc5t1etFDAuKdkkDApIasvj4K2Qcm61Cw3KMPJNBTO4uSuSv99xQ2TEKlgoX/EX/9mRKNXjzLANVgoHE73gINNOXeoUtgjG12zrW1pyKSn3m50wI8tsl8TGwBk1NZiCc0uGH3imw7PTreob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=iyfq9i1j; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="iyfq9i1j"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so7996805e9.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938344; x=1791543144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=iyfq9i1j2IP2Vg9CRRSMzXEfBjjfcbOVQ1XhnBUL3+HNIRO0E5KBK8Z8pgbs2ZpdLJ
         Yu5LAMjF2B6gSn5xuHqE/IX3b1BL53BcvP5SuhTjVl8ghohi6q0wnR8BJxegttS645ML
         H70Loy5euq+iDBcIFgzQRaUj8Ym3ACntW94yxJ+tIutM3/sLbk0MhbTQawBKSudQp+KJ
         q31tbvhHNDEtkTPH6do4d/NFWx1bZSEgqvTiRmi5P0O20RGUelgcoMUrxqpjyX9N1n7Q
         aSaK8LthF7Sblv5qfmBU5kM/Y6r3uNHHQNsuXBJtNRn8K/LplZmThdptuaw1baDGjMYN
         sMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938344; x=1791543144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DHR/Zw+Vw00LORa4RDQjkCwSJ7NEI1Qv7hzM6KHmy4=;
        b=SdjgRdc7APBMmwJBobHIMkaAJiISoXgY5T9UZWo63QuoxDkqenq9wO9Mz/VCPaIgYe
         GPKN7Nd8rJchQS4eCmTS07zcKpv3pPxQld2nMU+KIpzFv+Jy8v4WgeYcQhYlwV6JmAa2
         MiW8gGCPIOkI53rAPYL6LREXXF0tqHh5sAWZBHTzBl453CMbuHxf8jUX441ZRK9dJn5g
         fHy2pZDXiDTAoUimjPE36llsuEAHlteefPxOsSa/dW1dRyIbHvQrxH4HOlSz+Jg/Mv9H
         h1CnMsynFnbFlyj/wtXfduaTACZrf8oRTUBX6KOCghHOrBx1lEnKE3vt8Nk8NP8drbyE
         3XKw==
X-Gm-Message-State: AFuF++lJXNlUv+kt9S0nAclmUEB0+PMDOYkmaxfE3nuJt6DE3jsJFzaa
	hAk7A2inXB0VfmMBTth7PB26qR3RoSaoNJM8OlT8PjTDBEzesU9Nqts5GQqd7UFf0qvZ8ZxQQJ4
	u7M6QUJE=
X-Gm-Gg: AYBFou3oHf4JmP0KJQC+mkma9Kb/znslijBrXlI7e8F9wQ80+WsBb6dsNHgOmiTc+Lz
	Y4OMdMo6n3nh6RfhxizNXJZW6500520KDSKql/Rm3ZLKULHdP3SfaDFTI3kpOtC6WudL2hJIawc
	tT7g/j6V2rSVG7g9Rx2V5L4cEPkMf/gRGt/ALVW/HnYuH/yIV+vdKFBuIbX41B+mueznJx1GsEy
	V3R9y+RbiYPmMiRtNcC0XOYXHBLPR9gkU5278jvQGyRkg5sRAPB8zVL+NzHhceTQte0Qjwt+csV
	6DpFN1iOLzgpEtevDDxEfspRKQaDPTRYxwr0akwHQWq1fp5bS84645Oz96umEVSV14Lw2i3BkAV
	BZFry+erob3X1tZhalvG8pjMfGpzvvR7jZMtWdpDbhyJyTh9shntkghonQmXTEUCfpEJ8owq8Ix
	MZZ3jPLU85dqRDmUlC4Bxm4UeovF/43MDd3OmMS4jsoLYkTwH2SdNPP+EOGA==
X-Received: by 2002:a05:600c:3490:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-4a02755f835mr39806495e9.5.1790938344233;
        Fri, 02 Oct 2026 03:52:24 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:23 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 3/7] bpf: Add sleepable arena page allocation path
Date: Fri,  2 Oct 2026 10:52:14 +0000
Message-ID: <20261002105218.6171-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002105218.6171-1-emil@etsalapatis.com>
References: <20261002105218.6171-1-emil@etsalapatis.com>
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

