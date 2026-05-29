Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBD4014A3
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086289; cv=none; b=q4swcjoPv97TCT5xbyumsFbL4OeFGhTdRyKnKHMVYREAtxMZGoGKNqozr/TM+Cg2beVi3IUFDEaKfBosPrz9Gnpu6EI5elLZ7s6e9fTBdO3sBaSs5fsyu5FH3maCR6oqoMMM94NlNLN5eiHDpTSsY0yh8ACb/hjNtUw/a8j4MN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086289; c=relaxed/simple;
	bh=LZz7or2tTv2ebMso8BR108opYKRFjWIOLPGjvC8SrxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO/2EPBzB7YeVF+Vwl5O4U1IcQFmqEv8RH9TNGzlpLd87A1+OviMdZ4xBXWkbFIW4EfifWOi6xOYo+OJa6674Y7+zAuxpOIVZ5fyOio/dmIFSNLgnkKhqAvkq2H34x3hm6b9W+fhtu3t4pvN4vkaxVea/5HZktppIzr7PuUwGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLJzelqa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLJzelqa"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-841513664bbso4680577b3a.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780086285; x=1780691085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oguaUT6+V1DypHAutD3qNEDdgfOr6liguLrL5/SdR+Y=;
        b=fLJzelqaZaXVZXx46/flyYSKQr7eq391FICKpIjiNVyj4fe2jUcTHz1Weup7kdAEBt
         UgLAHCe1CEnV+ZWblePSfcCSVDHgV8JyfNEUfrKlJhOdk5vikUaJnfOfPCuV9lb1uOjb
         fvtS3I5W7XQVJs3Y5d7QH0+zbWSp0IP8LQHOLRCQXWI3WbUg/O1zrJwk0qGlLvZsYf5e
         D0V9MN1Arxh7mzFcXqOJ4yi9OiDvtqN7t6S/X/MUh5j40ojsvJExDutLcF/JjYcq3XnM
         i5w98GpbCpV7Auvyd2ZiR7P9lnuX9++mXspfe1fm36Nn3lfTgC9qkA4vYLZG8FrQ2mCZ
         AGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086285; x=1780691085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oguaUT6+V1DypHAutD3qNEDdgfOr6liguLrL5/SdR+Y=;
        b=WPsNHbZJZhbBEFGA5GxoOws/cxi6jLUj/NcI0x/uTMwFP7WfIm27MOvoykVv0bwt88
         bJFCHd63Mw3sGbv8+RN0roa7qxAIwOziN+J1fkNAwRuiEKJcbCRIsC1584QOwfqNtKl9
         ZGe2Kfndm9zzlfzc3ZBLQI8+pjvVvSBPG3Z3iWswC7oL0pc4CVkG/uSKepY2KqdNhNli
         9jEzF3MKmAi4+SwBQh8L5BqDTuKjXLF7kzOCIuCqhOZsiuJxo+pq2C3jBzDstRwPqKs1
         tjB7Xyj3s2b7kHjh/+FeOLeE6D8sFuRdppOjbS8Wb8pQbH8OjWrg3Z4Jv3z4E5OHoLvn
         kdFg==
X-Gm-Message-State: AOJu0YyTET26Aad3ZiTMpfYZPNER58AvwlxnnQBSKlhkWXrxdytT+NNq
	xJyDIEcxzF6YMxwzvUxMkjtb68anreSBZRDqe6B2TgpzHNxKWjqgvvxdO5q1eA==
X-Gm-Gg: Acq92OHOayqLpQ9yiSGs+jIkYj14Yn2P4epiRpjUPIARAomY6vuDZ2myHHoRz88kgpz
	8saxSQTm+JkGw6t++tp+ifL0ZXDt4D+30sfkBJfFx8p93qZ4ApymI4HzMmJoUpYFnZOIrWcdDpX
	qLtr+qFAdLJkf3YWvFsXPOkmiiDTAUUa004Sw2hFESrgcF8oaPA71PJrl1DUYZ9ZHBWE6FX0z8y
	fTIj3Bcy1bmL/Mn86VkU36GNbHIdXH2AaIbwAhSrs936/EAzWRWLSf/+wEjL2AKQ39OrrfIkMxl
	d1/hHVieE3V0Me9aIPpq1NmNh85P0sOYYdRjpRJ1ssivAHsEcF+b9BDIJof/ANOk7w488kbYQi/
	AhiRXik7ibj1ug6JCp1LiBajkPUmrGUFZJOlZRWl2RqjJfNA7VJAl+Juc7l50cx4frcBOqYou6/
	gdiUUEie98znkNxOA/wgMaASDgZql5SNMVEthQf71KaZsw8eumnd7zlVXpIUrP4uCPbZ3hISi0L
	PzI0R68oYHk8Zb61pfxxa++EZBLmqrqHej57hBV9dVVLFnMTBGGxFwtp3c/tmJC9b+J//rg
X-Received: by 2002:a05:6a00:1798:b0:842:2082:5fa4 with SMTP id d2e1a72fcca58-842257b0543mr666943b3a.1.1780086285218;
        Fri, 29 May 2026 13:24:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b67b8asm2632846b3a.25.2026.05.29.13.24.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 13:24:43 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/4] slab: Introduce kmem_cache_alloc_nolock()
Date: Fri, 29 May 2026 13:24:34 -0700
Message-ID: <20260529202438.16408-2-alexei.starovoitov@gmail.com>
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

Add kmem_cache_alloc_nolock_noprof() and its kmem_cache_alloc_nolock()
alloc_hooks() wrapper, mirroring kmalloc_nolock(). Allocates one object
from a specific kmem_cache and is safe from any context, including NMI
and IRQ-off, returning NULL on transient trylock failure.

The new function is needed by the upcoming SLAB_BPF_ARENA kfunc path so
arena object allocation can run from BPF program context.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/slab.h |  5 +++++
 mm/slub.c            | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2b5ab488e96b..7ce9125a6a2c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -958,6 +958,11 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
 #define kmalloc_nolock(...)			alloc_hooks(kmalloc_nolock_noprof(__VA_ARGS__))
 
+void *kmem_cache_alloc_nolock_noprof(struct kmem_cache *s, gfp_t gfp_flags,
+				     int node);
+#define kmem_cache_alloc_nolock(...)		\
+	alloc_hooks(kmem_cache_alloc_nolock_noprof(__VA_ARGS__))
+
 /**
  * __alloc_objs - Allocate objects of a given type using
  * @KMALLOC: which size-based kmalloc wrapper to allocate with.
diff --git a/mm/slub.c b/mm/slub.c
index a2bf3756ca7d..601986aaebdf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5402,6 +5402,45 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 }
 EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);
 
+/**
+ * kmem_cache_alloc_nolock - Allocate one object from a specific cache,
+ * safe from any context (including NMI/IRQ-off), like kmalloc_nolock().
+ *
+ * Returns NULL on failure (including the trylock paths that may transiently
+ * fail under contention).
+ */
+void *kmem_cache_alloc_nolock_noprof(struct kmem_cache *s, gfp_t gfp_flags,
+				     int node)
+{
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
+	void *ret;
+
+	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
+				      __GFP_NO_OBJ_EXT));
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
+	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
+			     slab_want_init_on_alloc(alloc_gfp, s),
+			     s->object_size);
+	return kasan_kmalloc(s, ret, s->object_size, alloc_gfp);
+}
+EXPORT_SYMBOL_GPL(kmem_cache_alloc_nolock_noprof);
+
 void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags,
 					 int node, unsigned long caller)
 {
-- 
2.53.0-Meta

