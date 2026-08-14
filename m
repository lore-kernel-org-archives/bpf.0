Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217B625
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666018; cv=none; b=Upv615MY3wVhdrUNBojGRuvBdTDe8Gx/0mBdzZekuaFnc260zU/LGxi9L+fSwyG+PtMDrZT6GbquyCXSis/HDRV76hcLUPAFLU6ACxCcOz1fzzQR6bxBOgbIYxTrSqfX1pFB5DBXpiJQWjyT1cus5LSF0bPI+RdR0BvwYAFAb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666018; c=relaxed/simple;
	bh=7jlp7RM83vYyG9RlXD4RqxDx56F7R2f+WLzr65uT+I4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ha538ByunghTbKqexIkWxoNLGz7blcC+Sg+pE0k5ZjlfKua9gXFPVwwu7Ed77a2TzM/2/GKwevAMnTEUhCV1bitWgfTCD7YOePs+uUCKVPyMtXXydiiwhN1ZtBinZXBFPBG2JfJoTrUwsnRnogQ/dyzJGwVua4NHoe7X+Do4suw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwFnKBuJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwFnKBuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D89C1F000E9;
	Fri, 14 Aug 2026 00:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666016;
	bh=eFqckWtrqO4VYdIp1oWb7ouSFly0Dj1dTWYre9VzuqM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EwFnKBuJMzVjcG0XhnDhABIpOpCZQgQlLBMrdKav8Nu0xtgRN+ELbGIVGHPUydgpQ
	 4NZo8g9+GBpjOv1mnl14BXGHlBpwAeuBfSv/TrC+IwvjY/4fys1k9einFzS52FhTZd
	 hzpcixCfSEg/nU9y8O0B/3CMVCrIVxaFX5vnOec6yNvTxWkWIHEnWf9tJTqgSPkH98
	 obG3QXt3eJKXmz0WaCJ89M40l2ZHFPlFEzf7Wlr7YlF8sJMxEb3Cbb2kvIc6erJh6i
	 PA/h06nduTVwTJ3Wh2PAvdw3kmb8V5eZE8XhAe7ZMePif1B5UULSmJWCjWJ89znzIw
	 yFLpOn6UprhOA==
Content-Type: multipart/mixed; boundary="===============9017082847783117285=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbe52cb393027ac53874b2b54bcddc6fd5687be01895e678261c45a1b76f9a8e@mail.kernel.org>
In-Reply-To: <20260813224853.1436734-1-song@kernel.org>
References: <20260813224853.1436734-1-song@kernel.org>
Subject: Re: [PATCH v6 bpf-next] bpf: Populate mmap-able array map memory lazily
From: bot+bpf-ci@kernel.org
To: song@kernel.org,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 00:06:56 +0000 (UTC)

--===============9017082847783117285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git include/linux/bpf.h include/linux/bpf.h
> index f4e8d372253ac..04cadd9871696 100644
> --- include/linux/bpf.h
> +++ include/linux/bpf.h
> @@ -145,6 +145,7 @@ struct bpf_map_ops {
>  	int (*map_direct_value_meta)(const struct bpf_map *map,
>  				     u64 imm, u32 *off);
>  	int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
> +	vm_fault_t (*map_mmap_fault)(struct bpf_map *map, struct vm_fault *vmf);
>  	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
>  			     struct poll_table_struct *pts);
>  	unsigned long (*map_get_unmapped_area)(struct file *filep, unsigned long addr,
> diff --git kernel/bpf/arraymap.c kernel/bpf/arraymap.c
> index 34865701f7f75..a6e44428a6c52 100644
> --- kernel/bpf/arraymap.c
> +++ kernel/bpf/arraymap.c
> @@ -608,17 +608,37 @@ static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>  {
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
> -	pgoff_t pgoff = PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
>
>  	if (!(map->map_flags & BPF_F_MMAPABLE))
>  		return -EINVAL;
>
> -	if (vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
> +	/* use u64 math so the offset cannot overflow on 32-bit archs */
> +	if ((u64)vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
>  	    PAGE_ALIGN((u64)array->map.max_entries * array->elem_size))
>  		return -EINVAL;
>
> -	return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
> -				   vma->vm_pgoff + pgoff);
> +	/* pages are faulted in on demand by array_map_mmap_fault() */
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);

Should VM_MIXEDMAP be included here? The old path set this flag through
remap_vmalloc_range()->vm_insert_page():

mm/memory.c:vm_insert_page() {
    ...
    if (!(vma->vm_flags & VM_MIXEDMAP)) {
            BUG_ON(mmap_read_trylock(vma->vm_mm));
            BUG_ON(vma->vm_flags & VM_PFNMAP);
            vm_flags_set(vma, VM_MIXEDMAP);
    }
}

Without this flag, task_numa_work() no longer skips the VMA:

kernel/sched/fair.c:task_numa_work() {
    ...
    if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
            is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
            trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
            continue;
    }
}

The VMA now passes all the checks when numa_balancing is enabled, so the
region gets periodically PROT_NONE'd by change_prot_numa() and re-faulted
through do_numa_page(). The migration attempt always fails because
folio_isolate_lru() returns -EAGAIN on vmalloc pages, but the scanning
overhead (extra minor faults, TLB flushes, and cpupid writes to kernel
vmalloc page flags) is still paid. Is this intentional?

> +
> +	return 0;
> +}
> +
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +				       struct vm_fault *vmf)
> +{
> +	struct bpf_array *array = container_of(map, struct bpf_array, map);
> +	struct page *page;
> +
> +	page = vmalloc_to_page(array->value + ((u64)vmf->pgoff << PAGE_SHIFT));
> +	if (!page)
> +		return VM_FAULT_SIGBUS;
> +
> +	/* the eager remap_vmalloc_range() flushed via vm_insert_page() */
> +	flush_dcache_folio(page_folio(page));
> +	get_page(page);
> +	vmf->page = page;
> +
> +	return 0;
>  }

[ ... ]

> diff --git kernel/bpf/syscall.c kernel/bpf/syscall.c
> index 7d8c3e8e6d62e..9e5e65e73dfa4 100644
> --- kernel/bpf/syscall.c
> +++ kernel/bpf/syscall.c
> @@ -1076,9 +1076,21 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
>  		bpf_map_write_active_dec(map);
>  }
>
> +/* Called for maps that populate their memory-mapped region lazily. */
> +static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
> +{
> +	struct bpf_map *map = vmf->vma->vm_private_data;
> +
> +	if (!map->ops->map_mmap_fault)
> +		return VM_FAULT_SIGBUS;
> +
> +	return map->ops->map_mmap_fault(map, vmf);
> +}
> +
>  static const struct vm_operations_struct bpf_map_default_vmops = {
>  	.open		= bpf_map_mmap_open,
>  	.close		= bpf_map_mmap_close,
> +	.fault		= bpf_map_mmap_fault,
>  };

Can this affect ringbuf maps? Both ringbuf_map_ops and user_ringbuf_map_ops
provide .map_mmap but not .map_mmap_fault, and neither overrides vm_ops, so
they now use bpf_map_default_vmops.fault. Before this patch a fault on
their VMAs had no .fault handler, which let do_fault() take the path that
re-checks the PTE under the PTL:

mm/memory.c:do_fault() {
    if (!vma->vm_ops->fault) {
            vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
                                           vmf->address, &vmf->ptl);
            ...
            if (unlikely(pte_none(ptep_get(vmf->pte))))
                    ret = VM_FAULT_SIGBUS;
            else
                    ret = VM_FAULT_NOPAGE;
    ...
}

That re-check exists so a fault racing the zero-PTE window of a
read/modify/write update (like change_pte_range() for mprotect() or
clear_soft_dirty() for /proc/pid/clear_refs) sees the updated entry and
returns VM_FAULT_NOPAGE instead of SIGBUS.

After this patch bpf_map_mmap_fault() returns VM_FAULT_SIGBUS immediately
when map_mmap_fault is NULL, so the PTL re-check never happens. Could this
send SIGBUS to a userspace thread reading a ring buffer while another
thread calls mprotect() on the same mapping?

The comment says the handler is "Called for maps that populate their
memory-mapped region lazily," but it is installed on the shared vm_ops and
actually called for all mmap-able maps, including the eagerly-populated
ringbufs.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31752145119
--===============9017082847783117285==--
