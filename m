Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE64CF486
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177440; cv=none; b=KbkZnFnri5DemiR7iNCd5LNUWF70GESroX7CUdx3mI/3DbuzZ5KmDmO5CVxmLaO2KlXPpSJ1p79twzqyveiC+O4giO/PNdCTkqLn4D4+h/tZfUr/6rrlo6pu9P8/iA7Q1ddkZiyVXefcL9h/aFes9TK9+m5ywgTgqVptTYFfSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177440; c=relaxed/simple;
	bh=CNR3UIQNxlqmvX5B65WR7uFjGzYQQxpXAke8nIZwQF0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=Lb8zhrhiX0VekSKl1H5CgZWtEZqHAB598lY2uREpJA3iM8BPfMnBt0w71BNw9A6MTTgc5oSPaiToQxiUUavnQ+ffY1JWpRqWqKQIWE+A9hrK6ojLyoeySKZp5EirB77z/kmCMARjiB8xHf+e0dg/wKxEq8iBvlfuM493RgC5plY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P11FUoJ/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P11FUoJ/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso269327a91.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177438; x=1792782238; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eg4NAgHBFZjYuL0of6d/pCxaYmTsYg3jXuuUjSTZD8=;
        b=P11FUoJ/RqdTlVsf1umgC2H+cXJNwJqCDJ3wiL+Nk3x8C6G7J30z88ptYMVEATrqS1
         pstatL7tklG9IPYQPzcMJHGUBmmWIq5vkmzqu4aFt33ZZEWsiVwCtZRVcZ0k+eSN4UiJ
         WdViIpPSpnJD+4O+K08rLkaQCga+pVM56h7rEYVab4bmO3HclMHl1bD+eh2TEHaPcPS7
         qG16A2+opvIZlf1pe40c2KyI/nswbZxodaEgqlll7KbAgpr+jY7zMPrOULaB7b/LgwPC
         9GxYtqOQ3vAVR2eeMg4goQozrjjPKxzlT1LmUK7LGMnJcDJngE7lY0E4XQhoKa3/Mkz1
         cGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177438; x=1792782238;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eg4NAgHBFZjYuL0of6d/pCxaYmTsYg3jXuuUjSTZD8=;
        b=QbEpEuEpF4RAPgORO6fCwxttHZ8orwhhOC2GeSHP+8mwDHuL4alJ/6uq4tjEPKu2Kh
         poRp+1kgaAkbZg0LICKFUUToiNvo/juMqKh++pq3WNDjvhKcUz90gXSv7Y/QENCi26n8
         jRZAjDY88q/a+nJGY3OQW9m4zVCWoQGvYJDKL6P9uIZ2M/hMeORTIEwKrzXhKxbRx0K+
         ZGBiRVALDJSa72wgqmgC8llOxeq05rrPa5NSBky6F4u1vi7Qs7sy2io9l2w+JvyynS2c
         k/7+mWTKIV7SOv1yyzYgEVdh74ArENJoQ5WJ9z9nHoYdBSyFmvPG+4HXgAB/eVB9+r8J
         Mq4A==
X-Forwarded-Encrypted: i=1; AKwUvBwVi+DFlMa4YGKyNgLd4UrD0bgizDN/R9nXvUQy190sTcrAWqIQ9B3QNlmMFKC7ZKCLpWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaqUTZFvoh63u/C8Irrf5IEuUioIU48SsE7XCRysOx7EKu5gPE
	/U/KYk+C+TLnYeNgtEZ4NqITHQrlYh8Psp81M1qU47Wa4HduTY/+76Wp
X-Gm-Gg: AYBFou1xT19t8j5wvNqBETHwhDL5n3QrPtTWDsYqs5i1CNQ/PztehN6NsJa+WcYDfUZ
	MGi2ePz4P+z2BVMiZTYFkb7tyMIONo/QK1R0eNXr2NsWnLSx/6spWeCrwTvXgSpeAlRQYpqRNM2
	ULStwwaUla2Tggc+K24rCwdeO201PMWDDThkSvN2QllguPbl+/RrD1tQHEHz6KOMlx4iXgHvGQo
	sIYByYYol22e66hifrLjac014rbKwJ4AIs4ibjMsdc2y0OwDK1C+JFSNfwtkJsHgtnS67Bty8Ir
	dLr7xETxA5hsxkn3atac69ax7rNT5fz2Frc0D4xCCrc5ufdgnOrTrCz3/ORcTqVcfPWq2xERUGr
	ehUgTzEhjooZG3fDhqWNmFW39MYXD4aOrTMNw/mtroXz+POtZcEfvgblna/W4VxPIsNbsgCodW5
	b4PUAYz3o/sCrtr2/jguKST5oJjn8JSWg+oyXS4k8NNPKjIXRUfOqSF6x9wixcdjqjv57w5yp4j
	t4aMYCLpy1tx6Dg/XqsSwELxe6ZmxifetOjyDAD7bcSQ6+GFw/l4aNwWQ83xpDUra/sKDgiYvSd
	qQc=
X-Received: by 2002:a17:90b:4ac6:b0:3ac:9e76:aa97 with SMTP id 98e67ed59e1d1-3acee277119mr717398a91.6.1792177437264;
        Fri, 16 Oct 2026 12:03:57 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3b16c2asm2137914a91.2.2026.10.16.12.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 12:03:56 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 19:03:55 +0000
Message-Id: <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs
 files
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Josh Don" <joshdon@google.com>, "Vineeth Pillai" <vineethrp@google.com>,
 "Balbir Singh" <balbirs@nvidia.com>, "Shameer Kolothum"
 <skolothumtho@nvidia.com>, "Himadri Chhaya-Shailesh"
 <himadrics@protonmail.com>, "NchangRoy" <royfru44@gmail.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20261010224902.1232178-1-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Oct 11, 2026 at 12:45 AM Andrea Righi <arighi@nvidia.com> wrote:
> The guest scheduler can create its own arena and allocate pages from
> that NUMA node. Those guest physical pages are backed by the host arena,
> so host and guest BPF programs can access the same memory through their
> respective arenas.

in addition to what Josh said...

That node is ordinary RAM for the guest.
When the guest scheduler exits arena_map_free() does __free_page() and
the page goes back to the guest's buddy allocator. Nobody tells the host.
The host prog keeps writing at that offset into whatever the guest
allocates there next.
NO_FREE in the guest doesn't help. It covers the kfunc only.

Patch 5 needs a 16M node (256M on ppc) to get one page into the guest
arena. Arena is 4G at most and it's one arena per prog, so that's
256 guests per host scheduler.

The NUMA node is a way to avoid teaching arena to use pages that it
didn't allocate. I think that's the missing piece in either model:
host allocates -> guest arena is populated from a BAR,
guest allocates -> host arena is populated from pinned guest pages.
As Josh said the BAR is needed for the doorbell anyway.

If arena can do that, can the host side take the pages from memfd
with memfd_pin_folios() like udmabuf does ?
VMM can map memfd at any address and offset already.
Then no need for NO_FREE, EXPORT, sized file in bpffs, 2nd kind of vma
in arena, etc.

The loader does memfd_create() or opens a file in tmpfs, calls
bpf_arena_import_memfd(&arena, addr, cnt, fd, off) from a syscall prog
and gives the same file to QEMU the way patch 5 does with the pin.
The imported pages stay until the arena is freed, so it's NO_FREE for
the shared part only. libarena keeps working in the rest of the arena.
arena_map_ext_pages() is what a BAR in the guest or pinned guest pages
in the pvsched model would call.
What is missing: user space has to mmap the memfd to see these pages.
The arena vma gives SIGBUS there.
Something like this (compile tested only):

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0ff707707da0..3a231e3e3073 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -4,6 +4,8 @@
 #include <linux/btf.h>
 #include <linux/cacheflush.h>
 #include <linux/err.h>
+#include <linux/file.h>
+#include <linux/memfd.h>
 #include <linux/irq_work.h>
 #include "linux/filter.h"
 #include <linux/llist.h>
@@ -55,12 +57,15 @@ struct bpf_arena {
 	struct vm_struct *kern_vm;
 	struct page *scratch_page;
 	struct range_tree rt;
-	/* protects rt and nr_pages */
+	/* set where the arena owns the pages, clear where they came from outside */
+	struct range_tree rt_own;
+	/* protects rt, rt_own and nr_pages */
 	rqspinlock_t spinlock;
 	/* number of pages currently populated in the arena */
 	u64 nr_pages;
 	struct list_head vma_list;
-	/* protects vma_list */
+	struct list_head imports;
+	/* protects vma_list and imports */
 	struct mutex lock;
 	u64 zap_gen;
 	struct mutex zap_mutex;
@@ -72,6 +77,13 @@ struct bpf_arena {
 static void arena_free_worker(struct work_struct *work);
 static void arena_free_irq(struct irq_work *iw);
 
+/* folios pinned by one bpf_arena_import_memfd() */
+struct arena_import {
+	struct list_head head;
+	struct folio **folios;
+	long nr_folios;
+};
+
 struct arena_free_span {
 	struct llist_node node;
 	unsigned long uaddr;
@@ -147,6 +159,8 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 struct apply_range_data {
 	struct bpf_arena *arena;
 	struct llist_head *pages;
+	/* pages that are on LRU cannot be linked via pcp_llist */
+	struct page **ext_pages;
 	int i;
 };
 
@@ -158,17 +172,21 @@ struct clear_range_data {
 static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 {
 	struct apply_range_data *d = data;
-	struct llist_node *node;
+	struct llist_node *node = NULL;
 	struct page *page;
 	pte_t pteval;
 
 	if (!data)
 		return 0;
 
-	node = READ_ONCE(d->pages->first);
-	if (WARN_ON_ONCE(!node))
-		return -EINVAL;
-	page = llist_entry(node, struct page, pcp_llist);
+	if (d->ext_pages) {
+		page = d->ext_pages[d->i];
+	} else {
+		node = READ_ONCE(d->pages->first);
+		if (WARN_ON_ONCE(!node))
+			return -EINVAL;
+		page = llist_entry(node, struct page, pcp_llist);
+	}
 	/* paranoia, similar to vmap_pages_pte_range() */
 	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
 		return -EINVAL;
@@ -201,7 +219,8 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 		return -EBUSY;
 	set_pte_at(&init_mm, addr, pte, pteval);
 #endif
-	WARN_ON_ONCE(llist_del_first(d->pages) != node);
+	if (node)
+		WARN_ON_ONCE(llist_del_first(d->pages) != node);
 	d->i++;
 	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages + 1);
 	return 0;
@@ -312,6 +331,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		arena->user_vm_end = arena->user_vm_start + vm_range;
 
 	INIT_LIST_HEAD(&arena->vma_list);
+	INIT_LIST_HEAD(&arena->imports);
 	init_llist_head(&arena->free_spans);
 	init_irq_work(&arena->free_irq, arena_free_irq);
 	INIT_WORK(&arena->free_work, arena_free_worker);
@@ -322,9 +342,12 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err_free_arena;
 
 	range_tree_init(&arena->rt);
+	range_tree_init(&arena->rt_own);
 	err = range_tree_set(&arena->rt, 0, attr->max_entries);
+	if (!err)
+		err = range_tree_set(&arena->rt_own, 0, attr->max_entries);
 	if (err)
-		goto err_free_scratch;
+		goto err_destroy_rt;
 	mutex_init(&arena->lock);
 	mutex_init(&arena->zap_mutex);
 	raw_res_spin_lock_init(&arena->spinlock);
@@ -336,7 +359,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 
 err_destroy_rt:
 	range_tree_destroy(&arena->rt);
-err_free_scratch:
+	range_tree_destroy(&arena->rt_own);
 	__free_page(arena->scratch_page);
 err_free_arena:
 	bpf_map_area_free(arena);
@@ -361,6 +384,10 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 	 */
 	if (page == arena->scratch_page)
 		return 0;
+	/* Not ours. arena_map_free() unpins them. */
+	if (is_range_tree_set(&arena->rt_own,
+			      compute_pgoff(arena, addr - bpf_arena_get_kern_vm_start(arena)), 1))
+		return 0;
 	/*
 	 * We do not update pte here:
 	 * 1. Nobody should be accessing bpf_arena's range outside of a kernel bug
@@ -375,6 +402,7 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 static void arena_map_free(struct bpf_map *map)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct arena_import *imp, *tmp;
 
 	/*
 	 * Check that user vma-s are not around when bpf map is freed.
@@ -398,7 +426,13 @@ static void arena_map_free(struct bpf_map *map)
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
 				     SZ_4G + GUARD_SZ / 2, existing_page_cb, arena);
 	free_vm_area(arena->kern_vm);
+	list_for_each_entry_safe(imp, tmp, &arena->imports, head) {
+		unpin_folios(imp->folios, imp->nr_folios);
+		kvfree(imp->folios);
+		kfree(imp);
+	}
 	range_tree_destroy(&arena->rt);
+	range_tree_destroy(&arena->rt_own);
 	__free_page(arena->scratch_page);
 	bpf_map_area_free(arena);
 }
@@ -488,7 +522,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct mem_cgroup *new_memcg, *old_memcg;
 	LLIST_HEAD(pages);
 	struct page *page, *new_page = NULL;
-	struct apply_range_data data;
+	struct apply_range_data data = {};
 	vm_fault_t fault_ret;
 	long kbase, kaddr;
 	unsigned long flags;
@@ -530,6 +564,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 				    ? VM_FAULT_SIGSEGV : VM_FAULT_SIGBUS;
 			goto out_err_locked;
 		}
+		if (is_range_tree_set(&arena->rt_own, vmf->pgoff, 1)) {
+			/*
+			 * It's a page cache page of another file. Its rmap won't
+			 * find this vma. User space has to mmap that file.
+			 */
+			fault_ret = VM_FAULT_SIGBUS;
+			goto out_err_locked;
+		}
 		/* already have a page vmap-ed */
 		goto out;
 	}
@@ -745,7 +787,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct apply_range_data data;
+	struct apply_range_data data = {};
 	LLIST_HEAD(pages);
 	long mapped = 0;
 	unsigned long flags;
@@ -928,6 +970,13 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
+	/* Imported pages stay where they are until the arena is freed */
+	if (is_range_tree_set(&arena->rt_own, pgoff, page_cnt)) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
+
 	range_tree_set(&arena->rt, pgoff, page_cnt);
 
 	init_llist_head(&free_pages);
@@ -1017,6 +1066,104 @@ static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt
 	return ret;
 }
 
+/*
+ * Map pages that the arena didn't allocate at uaddr. The caller keeps them alive
+ * until arena_map_free(). A memfd is the first supplier. Pages of a guest pinned
+ * by the host or a BAR with struct pages in the guest can be the next.
+ */
+static int arena_map_ext_pages(struct bpf_arena *arena, long uaddr, struct page **pages,
+			       long page_cnt)
+{
+	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	struct apply_range_data data = { .arena = arena, .ext_pages = pages };
+	struct mem_cgroup *new_memcg, *old_memcg;
+	unsigned long flags;
+	long kaddr, pgoff;
+	int ret;
+
+	if (!uaddr || (uaddr & ~PAGE_MASK) || page_cnt > page_cnt_max)
+		return -EINVAL;
+	pgoff = compute_pgoff(arena, uaddr);
+	if (pgoff > page_cnt_max - page_cnt)
+		return -EINVAL;
+	kaddr = bpf_arena_get_kern_vm_start(arena) + (u32)uaddr;
+
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		return -EBUSY;
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
+	if (ret)
+		goto out;
+	ret = range_tree_clear(&arena->rt_own, pgoff, page_cnt);
+	if (ret) {
+		range_tree_set(&arena->rt, pgoff, page_cnt);
+		goto out;
+	}
+	/* Page tables are there. It cannot fail in a range that was free. */
+	WARN_ON_ONCE(apply_to_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
+					 apply_range_set_cb, &data));
+	flush_vmap_cache(kaddr, page_cnt << PAGE_SHIFT);
+out:
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	return ret;
+}
+
+static int arena_import_memfd(struct bpf_arena *arena, long uaddr, u32 page_cnt, int fd, u64 off)
+{
+	struct page **pages = NULL;
+	struct arena_import *imp;
+	long i, cnt = 0;
+	pgoff_t pgoff;
+	int seals, ret = -ENOMEM;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+	/* bpf progs are going to write into it */
+	seals = memfd_get_seals(fd_file(f));
+	if (!(fd_file(f)->f_mode & FMODE_WRITE) ||
+	    (seals > 0 && (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))))
+		return -EPERM;
+	if (off & ~PAGE_MASK)
+		return -EINVAL;
+
+	imp = kzalloc_obj(*imp, GFP_KERNEL_ACCOUNT);
+	if (!imp)
+		return -ENOMEM;
+	imp->folios = kvmalloc_objs(*imp->folios, page_cnt, GFP_KERNEL_ACCOUNT);
+	pages = kvmalloc_objs(*pages, page_cnt, GFP_KERNEL);
+	if (!imp->folios || !pages)
+		goto err;
+
+	/* takes shmem and hugetlb files only, allocates what is not there yet */
+	imp->nr_folios = memfd_pin_folios(fd_file(f), off, off + ((u64)page_cnt << PAGE_SHIFT) - 1,
+					  imp->folios, page_cnt, &pgoff);
+	if (imp->nr_folios <= 0) {
+		ret = imp->nr_folios ?: -EINVAL;
+		goto err;
+	}
+	for (i = 0; i < imp->nr_folios; i++, pgoff = 0)
+		for (; pgoff < folio_size(imp->folios[i]) && cnt < page_cnt; pgoff += PAGE_SIZE)
+			pages[cnt++] = folio_page(imp->folios[i], pgoff >> PAGE_SHIFT);
+
+	ret = cnt == page_cnt ? arena_map_ext_pages(arena, uaddr, pages, page_cnt) : -EINVAL;
+	if (ret) {
+		unpin_folios(imp->folios, imp->nr_folios);
+		goto err;
+	}
+	mutex_lock(&arena->lock);
+	list_add(&imp->head, &arena->imports);
+	mutex_unlock(&arena->lock);
+	kvfree(pages);
+	return 0;
+err:
+	kvfree(pages);
+	kvfree(imp->folios);
+	kfree(imp);
+	return ret;
+}
+
 static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
@@ -1051,6 +1198,9 @@ static void arena_free_worker(struct work_struct *work)
 		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
 
+		if (is_range_tree_set(&arena->rt_own, pgoff, page_cnt))
+			continue;
+
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
@@ -1162,6 +1312,22 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 
 	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
 }
+
+/*
+ * Back page_cnt pages of the arena at addr with the pages of a memfd or a file
+ * in tmpfs starting at off. 'fd' belongs to the task that does BPF_PROG_RUN.
+ */
+__bpf_kfunc int bpf_arena_import_memfd(void *p__map, void *addr__ign, u32 page_cnt,
+				       int fd, u64 off)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || page_cnt > map->max_entries)
+		return -EINVAL;
+
+	return arena_import_memfd(arena, (long)addr__ign, page_cnt, fd, off);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
@@ -1175,9 +1341,19 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 	.set   = &arena_kfuncs,
 };
 
+BTF_KFUNCS_START(arena_syscall_kfuncs)
+BTF_ID_FLAGS(func, bpf_arena_import_memfd, KF_ARENA_ARG2 | KF_SLEEPABLE)
+BTF_KFUNCS_END(arena_syscall_kfuncs)
+
+static const struct btf_kfunc_id_set syscall_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &arena_syscall_kfuncs,
+};
+
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set) ?:
+	       register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &syscall_kfunc_set);
 }
 late_initcall(kfunc_init);
 
---
pw-bot: cr
