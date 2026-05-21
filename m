Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3841760
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338186; cv=none; b=ad9hutJ4BITlweAWtGnqyImhhDE8PIbMgsZwUU613zGedszdFmNEx4e5e6Tz/wARvC137pXTM4p6Vg5tvyL8DatDu+ObcPXrI3Vf2ZcJdAoCajyqdXDvoNh08KSPkWybAjeAXnlssIth5PXpjVjh0UOPdrjew+N87PQqq+ryzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338186; c=relaxed/simple;
	bh=C2bcxia+RzIq6VwX3Iqc8sIBkaQ3Nw5dYPHjeN2Ba34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+BbQQ9+z2dab65cdxUxCNe0zpffxiOnPMaY0SOv+EgJHj9Ypk3CNemaxYSsXqpH48hTGjKPiskp1J7+RkP+xMPVBNHTGgvwwXAiqfX9szP9LCJJhAjo+/ENqecyh0sfkI2TZPsHFBkcd+PZh925WErloMzovkayyzRv1SqS+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON4RGCNr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON4RGCNr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490229aa522so22161255e9.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 21:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779338183; x=1779942983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0l6Y+cSVP8EYJCr5270r/xmwOSYiPyih1GwoM0BYiM=;
        b=ON4RGCNr4eILQJw+hT0b2iztp4oXud7My+Oxl+qSFx6fYvi+uaWU1/Ru5S4fYiYYLb
         sKNQS/egD5v6xhieisyWABao37gjpgoRmS4PUvR7ZYYbNr26tlQfU6GhS1DSYi7gIBPx
         oDzKUpnX2TEhxI04ER0UBmsN0lmGINvjLnNn1ldvNzgICc+NWaLeq14umbd8C9h41OwU
         zV8FgZL/v+zgRV+7E/GkwSd19kgkspq1kJMC+pRhbkEn7kcK4HRx7/6iQReKwIDzAYHO
         /XybP5uetf+b16fC2TB+wiwnAlvsb3YLOhm67vQA4Brv0sTiZ2CBC591t/mOMcwm46bk
         F9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779338183; x=1779942983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0l6Y+cSVP8EYJCr5270r/xmwOSYiPyih1GwoM0BYiM=;
        b=Vd5w7uFUZw/hvXoJwkAUBSLLrS1nFOMEzPtnOS7W7kg1bt5vEXOdyIbRJb+GA9cA5/
         pt4CLcGZdtaYA9waKwSQgasVWK3WxBq2wCTHWPXoJOER5KdKQJcVtMKmk2rK169CjEdV
         vxeDBZKKZrslyJ1NkQ4pbZKw6PwK1Ways1nH+YUYXFcFkODNBkHUP/Zm6/7awGocFspr
         Rz6qzQv7VFfzH/rROCfNFYXkPsRktCiUWXxboeoCdMN6oLXkN+hxqrqASs2Qwx7/bFL3
         acUWcMiB9Gs3FLZQEDCEjZo46fm2TvPG7nMxCU7Ioet0a7EZvl9/NDzezS3DD6l6Pe92
         7/4Q==
X-Gm-Message-State: AOJu0YypgvzWTk3iPuBrunIsdYaj3WbVp6WnJ0D0gcriyP4xdLDN6qR+
	ku1AuNamiIiY3/bGZ7vDiLUVVTeGX5P+lcmLDZOMwGoNlLk642A4W8xeOzPZOM50ipU=
X-Gm-Gg: Acq92OG7Zrd+gH8u6JDn4Z6NvxlyNErr4FquqPUhludcHZk5bPZyeP5ha6mLdWHjifJ
	iJNO9oXXMPwlwE71/uyyFzk0IEGdm0keIVjL5/MWECWVbaSbjGcvTuWCODYg7JAa9QIGLRfJ1AC
	DRjWBeVARNXcjCI6ac5J6YDUQVU6j9JAV1Nb63GJhZ7qhvaw24dUkju0nVNLwoSZaaVhVaV/CJn
	mvrCZF0ttzdBjVzhpr9SmZtE2V1wA4ndpDnXRN07cLemO8JSmnAXF4oqd/A33VoeUiozPFKWrCL
	UttNgiaSgsFY82Bi88ZkBJk12WV50StS8Xfgp8grmdyRKDfT6bdLFpHren7hxPTltqWXV4JHtzs
	6RYDf3kiwHKFewea2CbVvFeEYbR6dc22D4oauHovd45jA6avnDv4NDH/ITDCaUMLEjwUlheZYqO
	unjad8aMdkP+W0erSUXytE6OWV7DFALzbxZDaci/JHpmSWWmhUODZeXtx6LST857LqMAqPdBJ4C
	A==
X-Received: by 2002:a05:600c:2b06:b0:48f:d1c0:5cd3 with SMTP id 5b1f17b1804b1-490360830d1mr9060555e9.13.1779338182648;
        Wed, 20 May 2026 21:36:22 -0700 (PDT)
Received: from ds-pc.. (host86-149-62-231.range86-149.btcentralplus.com. [86.149.62.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035f52a0dsm6631635e9.24.2026.05.20.21.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 21:36:22 -0700 (PDT)
From: Dhiraj Shah <find.dhiraj@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Add kernel-doc for arena page kfuncs
Date: Thu, 21 May 2026 05:35:53 +0100
Message-ID: <20260521043553.199781-1-find.dhiraj@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 Documentation/bpf/kfuncs.rst | 27 +++++++++++++++
 kernel/bpf/arena.c           | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 75e6c078e0e7..fe0df1e16453 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -732,3 +732,30 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
 destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-label`
 for more details.
+
+4.4 BPF arena kfuncs
+--------------------
+
+A BPF arena (``BPF_MAP_TYPE_ARENA``) is a sparsely-populated shared memory
+region that a BPF program and a user-space process can both address. The
+following kfuncs allow a sleepable BPF program to allocate, free, and reserve
+pages within an arena:
+
+.. kernel-doc:: kernel/bpf/arena.c
+   :identifiers: bpf_arena_alloc_pages bpf_arena_free_pages bpf_arena_reserve_pages
+
+A typical pattern is to allocate one or more pages, write to them from BPF,
+and let user space observe the same memory after a page fault populates its
+VMA:
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
index 49a8f7b1beef..b8ec2953dee6 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -870,6 +870,33 @@ static void arena_free_irq(struct irq_work *iw)
 
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
+ * Allocates @page_cnt physically-backed pages and inserts them into the
+ * arena's kernel VMA at the offset corresponding to @addr__ign (or at an
+ * arbitrary free offset when @addr__ign is %NULL). A subsequent user-space
+ * page fault on the matching user address populates the user VMA with the
+ * same pages, giving BPF and user space a shared view of the region.
+ *
+ * The underlying allocator may sleep, so this kfunc is only callable from
+ * sleepable BPF programs.
+ *
+ * Return:
+ * * Kernel pointer to the start of the allocated region on success.
+ * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is zero
+ *   or exceeds the arena size, @addr__ign is misaligned or outside the
+ *   arena, @node_id is invalid, or the kernel is out of memory.
+ */
 __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
 					int node_id, u64 flags)
 {
@@ -893,6 +920,23 @@ void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 pag
 
 	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
 }
+
+/**
+ * bpf_arena_free_pages() - Free a range of pages within a BPF arena.
+ * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
+ * @ptr__ign: User-space virtual address of the first page to free, as used
+ *	      to address the arena from BPF and user space. Typically the
+ *	      same address that was previously returned (in user-space form)
+ *	      by bpf_arena_alloc_pages().
+ * @page_cnt: Number of pages to free.
+ *
+ * Releases the backing pages, unmapping them from the arena's kernel VMA
+ * and from any user-space VMA that previously faulted them in. May sleep,
+ * so the kfunc is callable only from sleepable BPF programs.
+ *
+ * The call is a no-op when @p__map is not an arena, when @page_cnt is zero,
+ * or when @ptr__ign is %NULL.
+ */
 __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
@@ -913,6 +957,26 @@ void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_c
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

