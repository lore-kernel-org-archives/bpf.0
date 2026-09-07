Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C542E41A
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781559; cv=none; b=iuemSEnsHDnnE/pSndYtRWR0bBSoUggndN+eiOsIAJMOzzTz+xrXn0sQWe7gHfAzP/uzmDqujWxddlCN5Ibb4E9ABhOCJd3bm8EKYy/etI9Af6xVv6k4kXhNzJo9h88j3miu9FP0t241Se4rfvIK83/rGd1OfAAP1ZvYJp49/x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781559; c=relaxed/simple;
	bh=TJBkE75MeXEJDthG7qgF/nmQvDMGwopsgXMG+uDk7KU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHR21FP52uUzI2ceXGQgfxxqoVLxiC1Rn2nDsGzUTMl0mnF47pEhW+SeLgK/OWZ9hn0K8t1FCsniMcHYKFqaCWSy1+ULcXgLa0+8KzcSfVIDMREvr7q7FzvbtY7DcMAfvwNdCGHdq1Y9BmNUkxH15PCsx46uR3QXJ8T2eExb+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc6yzd0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc6yzd0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4114A1F00A3A;
	Mon,  7 Sep 2026 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781557;
	bh=oUjht/Hhr5L+skrQQfvNCbxpAeB7O+O9gi+NI5A30Os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bc6yzd0fZIfDXeqKycF2mMr8jP9vh23dDbm1DlZ0d+tnwI5TwoY6RpnKnCPSQ86HY
	 QwZw6tgSBkOAUchRg3Ewb/p/xFQP9/RnFDXE53l8wkjmWodGyLiqJlGysmpHBndhPi
	 qdv6ClngFJDw60cojbKp1okEDnJkXsb+SUzc6hGltgFD4FKb21spmynkF08JXihIhG
	 Dj8okTwD99zvEK9Xr10riWcuVosXj/mciN+XCRe93QkbIQpLdpqYrhZ+rM+5Xg71vW
	 SkMSs0vHtE4up+qUaXHtxQFVZ6f5mcNGHc1xf+OmjQaeXw61aHrqH3/s0XsmJWpz6j
	 vTnla2rWUx/Lw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, nickolay.lysenko@gmail.com, Emil
 Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: Atomically update PTE and range tree
 in arena VM fault handler
In-Reply-To: <20260902070239.16968-5-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
 <20260902070239.16968-5-emil@etsalapatis.com>
Date: Mon, 07 Sep 2026 12:45:52 +0100
Message-ID: <m2fqzlqo7j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emil Tsalapatis <emil@etsalapatis.com> writes:

> The arena allocation code currently has a race in the fault handler
> that can cause userspace threads to write to the wrong arena page.
>
> a) The fault handler removes a range from the range tree to mark the
> addresses as allocated, then installs a page A into the kernel page
> tables.
>
> b) A concurrent free/reallocation removes A and installs a page B.
>
> c) The fault handler still goes ahead with installing page A in the
> page table. The kernel sees page B, while userspace sees page A.
>
> There is no way to protect the PTE installation and the range tree
> modification simultaneously, because we cannot nest the synchronization
> primitives for their respective critical sections. PTE allocation
> may require allocations due to PTE reclamation, and its spinlock
> becomes sleepable under PREEMPT_RT. Thus we cannot do this operation
> while holding the range tree spinlock. There is no public API for
> manually taking this spinlock, so we nest the range tree operation
> inside it.
>
> Solve this issue by adjusting the range tree in two steps. First,
> mark the address of the page being allocated as unavailable. Then
> drop the range spinlock, insert the PTE, take the range spinlock
> again, and fully remove it from the range tree. Concurrent free
> operations get serialized to before the fault handler, while
> it is not possible to allocate the page once it has been reserved.
> Concurrent page fault handler calls retry until the page is fully
> allocated by the original call.
>
> Also return VM_FAULT_RETRY for transient allocation failures. These
> are a) faulting on pages that are temporarily marked unavailable in
> the range tree and b) rqspinlock acquisition failures.
>
> Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/arena.c      | 56 ++++++++++++++++++++++++++++++++---------
>  kernel/bpf/range_tree.c | 14 +++++++++++
>  kernel/bpf/range_tree.h |  1 +
>  3 files changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index d22b71a791db..d7006cdb9899 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -485,18 +485,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	struct page *page;
>  	long kbase, kaddr;
>  	unsigned long flags;
> +	vm_fault_t ret_fault;
>  	int ret;
>  
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>  
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> -		/*
> -		 * A failed lock means a possible deadlock was detected. Don't
> -		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
> -		 * the fault path would re-take it on retry and deadlock. Fail.
> -		 */
> -		return VM_FAULT_SIGBUS;
> +		goto retry;
>  
>  	page = vmalloc_to_page((void *)kaddr);
>  	if (page) {
> @@ -514,6 +510,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  		goto out_sigsegv_memcg;
>  
>  	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
> +	/* If a range is unavailable, try again. */
> +	if (ret == -EAGAIN) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +
> +		goto retry;
> +	}
> +
>  	if (ret)
>  		goto out_sigsegv_memcg;
>  
> @@ -534,15 +538,41 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	flush_vmap_cache(kaddr, PAGE_SIZE);
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
>  out:
> -	page_ref_add(page, 1);
> +	/* Reserve the page while installing its user PTE without the arena lock. */
> +	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +	ret = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
> +	bpf_map_memcg_exit(old_memcg, new_memcg);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	vmf->page = page;
> -	return 0;
> +	if (ret) {
> +		if (ret == -EAGAIN)
> +			goto retry;
> +		return VM_FAULT_OOM;
> +	}
> +
> +	ret_fault = vmf_insert_page(vmf->vma, vmf->address, page);
> +
> +	while (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +		cond_resched();

Should we keep retrying if raw_res_spin_lock_irqsave() returns -EDEADLK?

> +	ret = range_tree_remove_unavail(&arena->rt, vmf->pgoff, 1);
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	WARN_ON_ONCE(ret);
> +	return ret_fault;
>  out_sigsegv_memcg:
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
>  out_sigsegv:
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	return VM_FAULT_SIGSEGV;
> +
> +retry:
> +
> +	/* Only for special cases (GUP/device drivers). */
> +	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
> +		return VM_FAULT_SIGBUS;
> +
> +	if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +		release_fault_lock(vmf);
> +
> +	return VM_FAULT_RETRY;
>  }
>  
>  static const struct vm_operations_struct arena_vm_ops = {
> @@ -622,7 +652,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>  	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
>  	 * being copied into the child process on fork.
>  	 */
> -	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY | VM_MIXEDMAP);
>  	vma->vm_ops = &arena_vm_ops;
>  	return 0;
>  }
> @@ -888,7 +918,9 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>  		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  		if (ret == -ENOMEM)
>  			goto defer;
> -		WARN_ON_ONCE(ret);
> +		/* An overlapping fault reserves the range before installing its PTE. */
> +		if (ret != -EAGAIN)
> +			WARN_ON_ONCE(ret);
>  		bpf_map_memcg_exit(old_memcg, new_memcg);
>  		return;
>  	}
> @@ -1043,7 +1075,7 @@ static void arena_free_worker(struct work_struct *work)
>  			 * the defer: path of arena_free_pages(). Do not treat
>  			 * the leak as a bug.
>  			 */
> -			if (ret != -ENOMEM)
> +			if (ret != -ENOMEM && ret != -EAGAIN)
>  				WARN_ON_ONCE(ret);
>  
>  			kfree_nolock(s);
> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 515e72f054f5..1c23937041a6 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -378,6 +378,20 @@ int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
>  	return range_tree_set(rt, start, len, false);
>  }
>  
> +int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len)
> +{
> +	u32 last = start + len - 1;
> +	struct range_node *rn;
> +
> +	rn = range_it_iter_first(rt, start, last);
> +	if (!rn || rn->available || rn->rn_start != start || rn->rn_last != last)
> +		return -EINVAL;
> +
> +	range_it_remove(rn, rt);
> +	kfree_nolock(rn);
> +	return 0;
> +}
> +
>  void range_tree_destroy(struct range_tree *rt)
>  {
>  	struct range_node *rn;
> diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
> index aa27edf451bc..4b12ef51cc0b 100644
> --- a/kernel/bpf/range_tree.h
> +++ b/kernel/bpf/range_tree.h
> @@ -16,6 +16,7 @@ void range_tree_destroy(struct range_tree *rt);
>  int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
>  int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
>  int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
> +int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len);
>  int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
>  int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
>  s64 range_tree_find(struct range_tree *rt, u32 len);
> -- 
> 2.55.0
