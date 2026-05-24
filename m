Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D93932C3
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779622996; cv=none; b=E3wcUuc5y5NPxjwu1WMkltcR5rptuTR1foBrjEDhpZTv6qZ+DbzknqwKFXXYAg0d7p8Dr8QvFXPWyqxU0LALBE1mjKdRouPM93HR64VeBuSKhVld3ntrZrIZgxz8XDYfw+s6vVEhc86sXadYXjFtC6pcU1d3sWBrmKriqZ/uf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779622996; c=relaxed/simple;
	bh=XGaNu7SgYVdyaX3ndSTc4PQLCv4QWQfl3nIO4oftQJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzDxKBUuCQkEiE7Bb2llRI6/Ey/FLSSCQduFZD5lLgBxQ84AjQxSv8eLvb0tydFfY8BRxwUU7tRaKhD5jRyvzYzzpHjMR8mvlSfq2qxeIu0e2HO6KPF3mxvNeDXpGHs7MjKDz4ck1ogTcgcK/fPBYPhzRt0hDiJdNeHHKSXrhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obUNq4l9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obUNq4l9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso15299625e9.1
        for <bpf@vger.kernel.org>; Sun, 24 May 2026 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779622993; x=1780227793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRurXpwEfwTN2fB8fdG+G2wFxewUTYz7K8ld4XqHEY8=;
        b=obUNq4l9AD38AmTLSlH3sLuuxakh/yjv8tnkGYPQgbVVEVDQtbyCk2g+xDzORcllue
         UJcFjdW6MV0jBjzR4q+gmD6FQ6Wh+ZdS4anNLhkP/JF33LqvprFrcqsu1lwXJui6Ey8w
         bYuy673fnWH7meAoETK1DLNeOIYVvfVqlzWpkEHIa4my1pJ1oOuakSocy888tQHLdMdo
         EkB8OdSGP+0CTVUWXsL5sQTavDaYYrtBHUTe9HSWdvUdLxWHarUgA37L4Tv/5rh2lxwX
         n2hZxg6vkuucDFX/dFoGHes+KUzWCF/wy4dBH3boiPaiOxWujzIzN7i4jUAr2yrg/RpF
         Bfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779622993; x=1780227793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRurXpwEfwTN2fB8fdG+G2wFxewUTYz7K8ld4XqHEY8=;
        b=dzjvbVo8ljSRUhHnd8ExsMq8WG98Cy2yF0MgdfdkdPmLHhmgKubwceeYzeNn9WADyl
         0M0IzTf4IwXFM95X8YsqpLP+feIn4k/lGohx1VnhtJR7gZmtT23DLcP2WKYv3fkRppNe
         BYJRwwrLPYRRP1x0xs35SnPAlKPHq4dNDMUbo8PBwy6PKqd0ohpiKaiTYl1ftihrvxjQ
         3bh9DG0Z6NjDyyf3Rl0dLmc9bqBvBHmy+wUVfJv28rJrPtIt9dhgd/BzuSGxZQAsy2il
         mUK25H7RpR91YNfiN2Fd6LtikmSVlLIpddrHXQPC3A9mn6QPN8aznCUDlMqLXGdldioH
         Vdbg==
X-Gm-Message-State: AOJu0Ywy6qvaWVQ67w6auNdR14NziRvShnf6Xs/4RlLE8BtmJqHjBNaU
	LBcUr7XBor+f29NqSz91zm9WYwnJ0Fk9WXLOMf3ybuWz24kOxWezO7bHl/WQ5oXYjGc=
X-Gm-Gg: Acq92OFlwmNT1ayBWgOHthi1nf8MkZW0tD+4Um/p6T86ba2QFw6OqdfBrhsOpRhcN3C
	X1WiFu0bDqKBn8zP8LPR010ZGZY+GOs9sGp+5BdXD11feAEtG9XuiSLJzwYX8gpvvrKjpVb5Fa/
	psP2zHIenPvdwsbVbiZLpCMgeMeufCGrbTZ8IgB8A9bXxdUguC3+JJCAptV7Voe9vYURp7oJBoA
	0fqoDeHzWN/d4U1Ahc/eLOG0wrqwjjnUsAlQUdoGYzeYg+X9vncK1gi/MOpeTUG9yDz2ninyTy1
	cMH2CuEBS7eP8I97HlHw3+FuMhDS3o6CtDXp2hWEoZJO/xMw4fMHBn+1PgZTcESYTLjJ/ht+zed
	f7k75jFafHTqCb+VnIZxkjkx9DTjQOEQT7TaNk4Vrzt6TzJO0xwJ6pXdap2gmF2U2F2fGBVN+d5
	G+i3+9Xcbs8WhypoTZAiSD8HyJ08Zi3+ojNu+wezDpDPxlrMuRvBnnRAEL/+Sb+oyE/a0qe30=
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-49044ebc2d5mr182436885e9.30.1779622992830;
        Sun, 24 May 2026 04:43:12 -0700 (PDT)
Received: from ds-pc.. (host86-141-80-34.range86-141.btcentralplus.com. [86.141.80.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4cefsm62533065e9.14.2026.05.24.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 04:43:12 -0700 (PDT)
From: Dhiraj Shah <find.dhiraj@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	emil@etsalapatis.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Add kernel-doc for arena page kfuncs
Date: Sun, 24 May 2026 12:42:43 +0100
Message-ID: <20260524114243.259916-1-find.dhiraj@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521043553.199781-1-find.dhiraj@gmail.com>
References: <20260521043553.199781-1-find.dhiraj@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page-management kfuncs exposed by BPF arena -
bpf_arena_alloc_pages(), bpf_arena_free_pages() and
bpf_arena_reserve_pages() - are part of the BPF kfunc ABI but lack
rendered documentation. Their contracts (valid argument ranges,
sleepable-only context, and the set of error returns) are today only
discoverable by reading kernel/bpf/arena.c.

Add a kernel-doc comment block above each of the three kfuncs and
render them under a new "BPF arena kfuncs" subsection in
Documentation/bpf/kfuncs.rst, alongside the existing core kfunc
subsections.

No functional change.

Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
---
 Changes in v2:
  - Fix the return-value description for bpf_arena_alloc_pages(): the kfunc
    returns a user-space virtual address (translated by the BPF JIT for
    accesses from the BPF program), not a kernel pointer. Thanks to Alexei
    Starovoitov, Emil Tsalapatis and the AI reviewers for catching this.
  - Drop the "callable only from sleepable BPF programs" claims for
    bpf_arena_alloc_pages() and bpf_arena_free_pages(): the verifier
    rewrites these calls to their _non_sleepable variants when the calling
    program is non-sleepable, so callers do not need to care about this
    distinction. Thanks to Emil Tsalapatis.
  - Tighten the prose in Documentation/bpf/kfuncs.rst accordingly.

 v1: https://lore.kernel.org/bpf/20260521043553.199781-1-find.dhiraj@gmail.com/

 Documentation/bpf/kfuncs.rst | 26 ++++++++++++++++
 kernel/bpf/arena.c           | 59 ++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 75e6c078e0e7..28b6b477012a 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -732,3 +732,29 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
 destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-label`
 for more details.
+
+4.4 BPF arena kfuncs
+--------------------
+
+A BPF arena (``BPF_MAP_TYPE_ARENA``) is a sparsely-populated shared memory
+region that a BPF program and a user-space process can both address. The
+following kfuncs allow a BPF program to allocate, free, and reserve pages
+within an arena:
+
+.. kernel-doc:: kernel/bpf/arena.c
+   :identifiers: bpf_arena_alloc_pages bpf_arena_free_pages bpf_arena_reserve_pages
+
+A typical pattern is to allocate one or more pages, write to them from BPF,
+and let user space access the same pages through its mapping of the arena:
+
+.. code-block:: c
+
+	void __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page)
+		return -ENOMEM;
+
+	/* ... use the page from BPF; user space sees the same bytes ... */
+
+	bpf_arena_free_pages(&arena, page, 1);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 49a8f7b1beef..948a43159106 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -870,6 +870,31 @@ static void arena_free_irq(struct irq_work *iw)
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_arena_alloc_pages() - Allocate pages within a BPF arena.
+ * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
+ * @addr__ign: Page-aligned user-space address within the arena at which to
+ *	       place the allocation, or %NULL to let the kernel choose. When
+ *	       non-NULL the address must fall inside the arena's user VMA
+ *	       range; otherwise the allocation fails.
+ * @page_cnt: Number of pages to allocate. Must be non-zero and no greater
+ *	      than the arena's configured size in pages.
+ * @node_id: NUMA node hint for the backing pages, or %NUMA_NO_NODE.
+ * @flags: Reserved for future use; must be 0.
+ *
+ * Allocates @page_cnt pages and inserts them into the arena at the offset
+ * corresponding to @addr__ign (or at an arbitrary free offset when
+ * @addr__ign is %NULL). The pages become accessible to the BPF program
+ * immediately and to user space through the arena's mmap()ed region.
+ *
+ * Return:
+ * * The user-space virtual address of the start of the allocated region on
+ *   success. The BPF JIT translates this address for accesses from the BPF
+ *   program.
+ * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is zero
+ *   or exceeds the arena size, @addr__ign is misaligned or outside the
+ *   arena, @node_id is invalid, or the kernel is out of memory.
+ */
 __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
 					int node_id, u64 flags)
 {
@@ -893,6 +918,20 @@ void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 pag
 
 	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
 }
+
+/**
+ * bpf_arena_free_pages() - Free a range of pages within a BPF arena.
+ * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
+ * @ptr__ign: User-space virtual address of the first page to free, as
+ *	      returned by bpf_arena_alloc_pages().
+ * @page_cnt: Number of pages to free.
+ *
+ * Releases the backing pages and unmaps them from any user-space mapping
+ * of the arena.
+ *
+ * The call is a no-op when @p__map is not an arena, when @page_cnt is zero,
+ * or when @ptr__ign is %NULL.
+ */
 __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
@@ -913,6 +952,26 @@ void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_c
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
 }
 
+/**
+ * bpf_arena_reserve_pages() - Reserve a page range within a BPF arena.
+ * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
+ * @ptr__ign: Page-aligned user-space virtual address of the start of the
+ *	      range to reserve.
+ * @page_cnt: Number of pages to reserve. Zero is permitted and is a no-op.
+ *
+ * Marks @page_cnt pages starting at @ptr__ign as reserved so that subsequent
+ * bpf_arena_alloc_pages() calls will not place allocations in that range.
+ * No physical pages are allocated by this kfunc; the range is simply
+ * excluded from the arena's free space.
+ *
+ * Return:
+ * * 0 on success, or when @page_cnt is zero.
+ * * -EINVAL if @p__map is not an arena or the requested range falls outside
+ *   the arena's user VMA.
+ * * -EBUSY if any page in the requested range is already allocated, or if
+ *   contention on the arena's internal spinlock prevents the operation from
+ *   completing.
+ */
 __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
-- 
2.43.0

