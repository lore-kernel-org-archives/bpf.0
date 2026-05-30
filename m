Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385A2F8EAD
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103636; cv=none; b=ZE6X+rcK6eQSmyC8bcTFl6UjP0cvC6xi+OWJtRPpIvod85CcLvfFCaq88ITzgH06hlZNeEBkhlAJYVyLbtuFlORn7KPI1rvbi21pLToileVjY02D9k0/keB3+9Nux6pFC/J50qWRYVGAQaaKCrMjSLMQp0snXrxukQF6zVnlLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103636; c=relaxed/simple;
	bh=5yV5iWk3GuonLhLhmsxyeCR+D0hZUzPLAlJa+KeeK4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5sCdfZZDRsmoQU3Ls7c4bgVE0NVfa/C6k9jPjpeIFdPu2gOk2BFYT30xDsfuAqaaR+E39Ch0xbcZbVTaKyxorpI/nNXgo597jj1u/YgvukMHOy+BqyOt3DHOdrHXzYKWI+FfFxHwxk1NF/r1YzuXuL4RVD3kPuD4DV+6LjOwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuNVlo6p; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuNVlo6p"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bd9c3b550aso99071865ad.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780103634; x=1780708434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUCi6apnDaYquXe57OZzeZfrFZn6x9QqO0qDPXuYS0A=;
        b=ZuNVlo6pbb3E6mEq+5jSi6q1+6QimcP0VgJSUa9nr1qlGVvgqgDBTUB8lCspa8FNiX
         g95XwwZecpb8PD6doMSBftLsUHxXGVLTFoKZF8zQleJYG9nFwarJOGSisd/YPPKBpY8m
         u97bEbk2LJZBFxgbuLL6aDJL8C3DJKhnFJfcLIN4r2jsETeN8ILohkLUi/NYccD+DdbV
         PHHjgnl1IpA4dyxbyAISlCF/GmxzWDta4zgghs2V/VGUbNpwCOoqocRCcq5ikegD4SnT
         R2pcYeWTjhioFRrS0ItCUhTPWYDzrPSUQJb12es+JLPQTygLBQ9cMVxMHroKdNV8zAPz
         sW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780103634; x=1780708434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUCi6apnDaYquXe57OZzeZfrFZn6x9QqO0qDPXuYS0A=;
        b=c+IREOgSTrjLiPz9jDJuNo+P8DAlU/gwXuQPFQ5uVnKicFSIJlwmOl/AWlH4FSmfoo
         sC3BTJftSQLrXNGopryDc8g433GPbcfHSRpaBeg+qojoECT39LpdGPORt+LmZymBmyam
         gvGz+nysNuOS6MCIKU5BP2QJRhWi48iXSFKB/XEuXWnnSdva8EobER5Y43JqbPieJC4H
         L4eX019s2PcCwq9WdXS+KNarEtE0igFa5pFxj+Xzs1vdEjvdFWAdq17iLZrJlXyGqOgv
         lhvri+0GpEYQWbvKe33laccEHab8tTGGqQjfkvv27N7YQL305c+IW6JipQka3w7l/UOj
         LuHg==
X-Gm-Message-State: AOJu0YyZxOE0eVf1ybWfyvfGbO5IntdtOOOH7uhTs+efvCJhtvZA32IA
	KtdFru/ISK2P1PNf9fL9/n6n18zLNal/kzhqPIzwv/GF3vBn1rzrkDOYB/uZqA==
X-Gm-Gg: Acq92OHS02WtfW7Tohvmca52h3XAnJ9NN6nKul+W1apKyo1vV7gONnQvwIrzoU2fd+Y
	oITu11FUaNdE5G9Jw0bZM7YwtBpl/D2UcvykH5oFSfw0QJHJ2pYBI3kQBKEXiN9l8JrxQSfB4lq
	UwT4Ro0/ntCozT/o7PeHnjZfizRFANWcksfxJOhN15e12q5+03/+xzq7yRTKfTIM5jIlwHIaHSj
	kKi8RZAQQ7MvfyRzfaK800Ksd92h+qZhqmkLY1AIACEwbjslCZLY0X7f47Z5xEcQBTv6zPabqz8
	02WExa24Q7uRsQiIG7GAhaNbzavDl4u+JQ9inMsefsjII79Z7b4WRMHslX0hZzrnGfb1L6QPDfG
	LdVONaOSMtInwyFQBjQG43lG9i8qIxp3uk37ySh4X3htedzftS8CaRY/peZ9JsXK8nFPL2ozUVK
	UnvXqq87RTWkvxPghSr8LqLsSQnLFYhLXOTMyQ39Zx4paesOMa1asTaA/39PJsW96uPM7TEY7EU
	TFkvLNnEoM2kB3XAURhlwP/uouGcAyuQH5SQiGJGvAK5Jp0oOBKgPA9Mxprw6hk/+Y9zRdS
X-Received: by 2002:a17:902:f60d:b0:2b0:6a22:5165 with SMTP id d9443c01a7336-2bf36793657mr23140475ad.7.1780103633930;
        Fri, 29 May 2026 18:13:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf369c790esm10775925ad.56.2026.05.29.18.13.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 18:13:53 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/4] slub: Pass kmem_cache to alloc_slab_page()
Date: Fri, 29 May 2026 18:13:42 -0700
Message-ID: <20260530011345.99342-3-alexei.starovoitov@gmail.com>
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
index c3899cc1dd1d..82862d57c0cd 100644
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

