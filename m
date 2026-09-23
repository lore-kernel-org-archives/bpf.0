Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDA57D21E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194327; cv=none; b=JPzL7A9nEPDOWgm2wJRXbUiJcZ2UhOeOKNAcF8Z2y4ZhWZuHqMuD8zIrbrRgkdGlZA5hXi/eEQA/MWGvJTQSsVGGkiHDR+9aEwy85g7Usn0LOBxuBm8hSYa3QgJZFjtpzx8XOBfJydfdng/Vt1RomYlY1zbB/nSkbQoh2fWEbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194327; c=relaxed/simple;
	bh=7o2ygIitizemDrOAjHPkNfFxcW7ve6OmuDXgjB1vmHg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jGBuF5951F4AlbodfnHh7aIHM/EqCY12iLKRpK8+oDvQVS/Xdh6xvgynj8bWusLbZ04XjnEzqoY1bfBS7UCN+uHpkYGtASyKZ0i5F/iD5EOGX+dOq1eYKL+NcyY0cznPoTxc8ICfTg2pxR3oozJjE96db4Abs6D9rvBBtuPv3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUCOKO7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUCOKO7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082CA1F000FF;
	Wed, 23 Sep 2026 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194319;
	bh=o7goffXq+PFJHNSHxqXFW4tAvuHqzADQkc7Afr439+8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VUCOKO7n0sJrmJM4HKvEH/DYYcX1MRw3tmXLJozMjAOS7C0GGsM4D1EBcF10Qli45
	 2AYQlLeaM+R3t/oju0NpFRVSZXo6EA1ltpbTcV+6Nz9nmUm2eiWMq9LUL3vKRUSOuT
	 3+w/gqnM6DRU6zx9cPD9al4WaBqi4+cD0S3WEg7YbL4q62nHXQ0eGlSkG/W5kfiLok
	 bAxAd69Xpzc0Rs2YDJin38FiiF8Y97DoaJObVsMa2zzqrSJ/gnrwZkItNo1owzA43+
	 EJNpOUHXfvuR/3DrgPlutjjbtyRpbWfb7MSq6tMZYtTerEmMxCn0xQGr0rOUFEc6VB
	 Gng9UUpTZHxQg==
Content-Type: multipart/mixed; boundary="===============0235665288643596036=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d6f1db7f84decff305118ffecd5ecd5bf0ccb6ba24a158567329cb3dc352336d@mail.kernel.org>
In-Reply-To: <20260923191125.5311-6-emil@etsalapatis.com>
References: <20260923191125.5311-6-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Atomically update PTE and range tree in arena VM fault handler
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 20:11:57 +0000 (UTC)

--===============0235665288643596036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")

Should the Fixes: tag point to commit b795379757eb ("bpf: Introduce
range_tree data structure and use it in bpf arena") instead? The commit
being fixed here uses a range tree, not the maple tree from
317460317a02. The range tree was introduced in b795379757eb (November
2024), and that commit contains the vulnerable pattern: clearing the
range from the tree and allocating a page under lock, but releasing the
lock before userspace PTE installation.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 69c8924f4c306..5438b68d269a8 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

>  	page = vmalloc_to_page((void *)kaddr);
> @@ -562,7 +565,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	/* If a range is unavailable, try again. */
>  	if (ret == -EAGAIN) {
>  		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -		goto retry;
> +		goto retry_memcg;
>  	} else if (ret) {
>  		fault_ret = VM_FAULT_SIGBUS;
>  		goto out_err_locked_memcg;
> @@ -583,12 +586,40 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	page = new_page;
>  	new_page = NULL;
>  out:
> -	page_ref_add(page, 1);
> +	/* Reserve the page while installing its user PTE without the arena lock. */
> +	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +	unavail_node = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
> +	bpf_map_memcg_exit(old_memcg, new_memcg);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	if (new_page)
> +
> +	if (new_page) {
>  		free_pages_nolock(new_page, 0);
> -	vmf->page = page;
> -	return 0;
> +		new_page = NULL;
> +	}
> +
> +	/* If we couldn't mark the page unavailable, retry. */
> +	if (IS_ERR(unavail_node)) {
> +		ret = PTR_ERR(unavail_node);
> +		if (ret == -EAGAIN)
> +			goto retry;
> +		return VM_FAULT_SIGBUS;
> +	}

Can faults on already-allocated pages now fail at memory.max? The
already-allocated case goes straight to out: after finding the page:

	page = vmalloc_to_page((void *)kaddr);
	if (page) {
		...
		/* already have a page vmap-ed */
		goto out;
	}

Before this patch, out: only did page_ref_add() and returned 0. Now out:
calls range_tree_set_unavail(), which goes through range_tree_set().

An allocated page has no node in the range tree, so range_tree_clear()
finds nothing, no merge happens for unavailable ranges, and the function
always reaches this allocation:

	left = kmalloc_nolock(sizeof(struct range_node),
			      __GFP_ACCOUNT, NUMA_NO_NODE);
	if (!left)
		return -ENOMEM;

This runs under bpf_map_memcg_enter(), so it is charged to the arena
map's memcg. kmalloc_nolock() cannot block, so try_charge_memcg()
cannot reclaim. Once the memcg is at memory.max, it returns -ENOMEM
unless __GFP_HIGH or __GFP_NOFAIL is set. range_tree_set_unavail()
returns ERR_PTR(-ENOMEM), and the code returns VM_FAULT_SIGBUS.

This means a process accessing a page the BPF program already allocated
gets killed with SIGBUS when memcg is at memory.max. Hitting memory.max
is routine (e.g. page cache from reading a file), so this would affect
ordinary workloads. Before this patch, the already-allocated case needed
no allocation at all.

Commit c7cd8be3d72f ("bpf: arena: Allocate the fault-in page outside
the lock") fixed this failure mode: "Once the memcg is at memory.max
that allocation just fails ... and the process gets a SIGSEGV on a
perfectly valid arena address. Hitting memory.max is routine, so this
kills innocent processes over memory that reclaim could have freed."
That commit also ensured "A lockless probe skips that preallocation when
a page is already mapped, so the common case wastes no allocation."

Could the range_node be allocated before arena->spinlock is taken, with
a reclaim-capable GFP_KERNEL_ACCOUNT allocation like the page
preallocation? This would keep a routine memcg limit from turning into a
SIGBUS on valid arena memory.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35908471084
--===============0235665288643596036==--
