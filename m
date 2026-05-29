Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3903403E8D
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086293; cv=none; b=TZKCgL5wizHJb/fYCbV6RJkN5HA4WhPzjIl54WYYkKg5XoLHY1J0MUwsyZu3u57pmds5/zyIWqdHKIIFtkcYfcyjGOKTrOVo5N2pTzpAnP1a2Pg6SBKWTQ6uMiBdHMd6T3PUCfe97nWg/Bpt5nMVykQh3pS9NZfeNltMVNs3J0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086293; c=relaxed/simple;
	bh=0KEA5WiJ3HvpFSbqGcqdtEn1FGLEzw3xcASxMUA9qfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVysdF4S5W9jVh0osyo3pfh96xEOrZR8m2/4xMPtRPB8K/MJEiDzHhqfHsWqQdu7nxI8t8A4Y5znJlt8cO3kBVQho3A7FvUvyWrL2GhT3Qdz28+Dbbbm9ieCH6fGH0jgfZFbG25PhJP9atW9paCAYed+SzDDussh8RF6Heiknlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/7ZWWs1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/7ZWWs1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf20f6be6bso6488635ad.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780086289; x=1780691089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evn50r5ng9H9NfR/F7shpk5eakICeNR87P7QydzAfto=;
        b=S/7ZWWs1qxjVGCiIx23eChhkD5NAR/mPFcLD58MCvYVmXBVXx1RlrtJjdGySne0OIt
         G2guppi91+1zYRfVbt2vhYFs9wRelcDeF6h364lJc4dZfuexPGnmnirOwI4onFldhV8x
         QN77Fe0EEzHF7BubBya+GqWcwq4ErF+QIxoLiMbuhx1YaPbT8e2DSDpZjzj06JqZZVaR
         JQUfYeqMz1cF/QTLn/lqqoNG7EuHwPY9q2shIkyAWeRWV1a1vUTxPfzPkXD9AVQ62c/J
         rKMh1lvQMGjN0n93Lv+77i8KEy4tgo2QeJ7Op0QZr+4S7lk8nwdpESmiNL6PzO+ZyPI9
         5YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086289; x=1780691089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evn50r5ng9H9NfR/F7shpk5eakICeNR87P7QydzAfto=;
        b=lmhrqoEMz3hjrenytFyQ10WgVnJbmLN68YYCtkc5oVX92jNRM0N9M+RxrMEH4dngWf
         ENuOExXISPgEfBZNMgVP6su+gV6x7c2MfxM3WWnySzN1bIHVW0nKOsSzpIECvFukUjjz
         FIZw4a24lwQGWjtSaImnVQJjt9YQfDzl5WBz5lGNXVvnCcBVeKBrunB+KOhKOFxPbtzK
         6+CKE4Ezvq20l4XOm76MX8/7DIBQnZ2Cjw8qEersRZZhKEz+Q/br8cRjUQfWqhdQCOt0
         XwIEZuP3lqxESpD2rZ6H7o1MMcJXTy5mIs47H5DPNLGcTEPu5RW0FtgVk09jf0/XUJzI
         miEg==
X-Gm-Message-State: AOJu0Yx/X4j/Aw3P4SMPw480gT32Q3Ky9vOCwFFloiKQ+YS4a6ehB72+
	OlrEnJfqt/IxTi8t18cDbmr4TWGdcqcftQ2IXgbqtshIPDkYVsA4uUbslZ4oCA==
X-Gm-Gg: Acq92OEqXru9BlacJyBIAa7O4RR6VJ0HrKIMFCPyUgLakzA55hDtSaNymj4cTUBj9qU
	W1hzhZ6AUr+zKTOq9azXQjmq7KKA2KNAcoZDwHA5uQ5Gq51j0ttTRPEiFFA0KkFg1SYDY/hLsPz
	P83qojX3hPdFpAPWnTsu8b1tDAFNsLa7nvHcGDhp5hJtYEGEiHJHX0Y3gh+DlEDVQ2N2W4psPEO
	vn7RQvMn/uHFat7m/9uwWbaKTyWDrH0z6Il2Ie6faYHHT58X7FoM8cLhUmfY1SfWYFHG4aOHEwX
	4JpFpRUisVW4pHs6mkw07s0hnwAqQCSNyEmuZ9GKtVYID4Ws9D0AtqXkYNxUEwO1f7Azzqk27AJ
	cJXsLNxZ2TUpKkV3x3REZfsXEzTn7Zfu3M1CvXUeFIerTZpZo18qsJsFP81JUP+eJ3ZV3lP1X96
	/AkRhjRXGFvAVaROLgY1cStb+6rqajhqewVdNT+l7ltSAezX7eCoTR6JD+7L7nufcsNGfWKm2PU
	ClNbno75pOiC4ApiNSZbIbXDrsoNfju0HJCgWmyDD+L/lilnCf8dQx9kPpa/ZgBmIB+e4ix
X-Received: by 2002:a17:902:f78b:b0:2bf:9760:b963 with SMTP id d9443c01a7336-2bf9760bc96mr8152055ad.26.1780086288619;
        Fri, 29 May 2026 13:24:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm28681335ad.78.2026.05.29.13.24.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 13:24:47 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/4] slub: Pass kmem_cache to alloc_slab_page()
Date: Fri, 29 May 2026 13:24:35 -0700
Message-ID: <20260529202438.16408-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260529202438.16408-1-alexei.starovoitov@gmail.com>
References: <20260529202438.16408-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a struct kmem_cache *s parameter to alloc_slab_page() and update
the two call sites in allocate_slab(). No functional change.

This is a preparatory step for the upcoming SLAB_BPF_ARENA support,
where alloc_slab_page() needs to consult cache-specific state to route
arena caches through bpf_arena_alloc_slab_page() instead of the page
allocator.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 601986aaebdf..1daa89105e04 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3261,7 +3261,8 @@ static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
 /*
  * Slab allocation and freeing
  */
-static inline struct slab *alloc_slab_page(gfp_t flags, int node,
+static inline struct slab *alloc_slab_page(struct kmem_cache *s, gfp_t flags,
+					   int node,
 					   struct kmem_cache_order_objects oo,
 					   bool allow_spin)
 {
@@ -3464,7 +3465,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	 * __GFP_RECLAIM could be cleared on the first allocation attempt,
 	 * so pass allow_spin flag directly.
 	 */
-	slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
+	slab = alloc_slab_page(s, alloc_gfp, node, oo, allow_spin);
 	if (unlikely(!slab)) {
 		oo = s->min;
 		alloc_gfp = flags;
@@ -3472,7 +3473,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
+		slab = alloc_slab_page(s, alloc_gfp, node, oo, allow_spin);
 		if (unlikely(!slab))
 			return NULL;
 		stat(s, ORDER_FALLBACK);
-- 
2.53.0-Meta

