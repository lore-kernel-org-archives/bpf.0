Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA33F6C58;
	Tue, 25 Aug 2026 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653945; cv=none; b=LZUXalQluNO6IbpQxq5O0jjll04LlV6pNzYW7c1chCBcdAz6vhcj426KmM8wfgW0h1f9I5wsU5yG+c+8z4wo9RjRSb2FCciMZ1Ae2qp30HL5GR1ZOXgyxvzk5TWim4orJy55vAGCyL3oNcjTlnFhbb9D8EHx6K/g6SCAHP/3Zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653945; c=relaxed/simple;
	bh=txCNM/BTJt1CvC/PY+iyRQfcxKKuZt8SWVWscnq48ys=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=REayCKJY0it3Z1SkZ2/vSdxkVdx2v9n1whdrWH6JV1I3XXAK1woPL5Ey4nvFhSj/fAM1D1++hOUtzKiDPFz+6dZX+gbLrhdIOgnBi0YV+Tb/QG7A9zW13Mu/j/vJV3dBvuZGFjx+nTnKz7W4wMQbypTdOr4Ml3HKl3G1TRqaQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMFWPBCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMFWPBCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6A61F000E9;
	Tue, 25 Aug 2026 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787653944;
	bh=ZypfUMpyaY3OdpOdh93KJiTd39eV1yVMHJprkkoSrU8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TMFWPBCcmno9Mw4nlG+taXffxfOf6aWWwJaD+BgigutrerzyNaBnBMLffVU+aSmVm
	 2n2KxPMK6/aVMy/8OaDp9cA541THRIaV/EAC7rkfI0CtoFMWsw5PwyAZi+bALxPPJ9
	 VpfmQJLBd61p4mRAMrCdDs62YLJrf6aKg4Z2byECFFK/g6iPT1TLLTQR1cJ43iXeME
	 2lQtBAbz/uQnD3n8BSb2IOh8utNiXV38WazG6A//wXfSoc8IkXoybGzR3ckaPjZjYb
	 QvtQPkJ9YWwcmBY9/qDKAnbtjev7qkEjAogcejo0wbQ32E4MYI2+2YRhFzVHrpemF9
	 SRNk/W8jjJLgA==
Content-Type: multipart/mixed; boundary="===============3740373577458984524=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5f41e657ec9cb6af7cb831c58fdf3f999cfae0702066005692e3c96fb8a1e542@mail.kernel.org>
In-Reply-To: <20260825094955.83240-3-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-3-ahemadkhawar123@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/4] bpf: arena: allocate the fault-in page outside the lock
From: bot+bpf-ci@kernel.org
To: ahemadkhawar123@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,jiayuan.chen@linux.dev,emil@etsalapatis.com,ahemadkhawar123@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 10:32:23 +0000 (UTC)

--===============3740373577458984524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..fa462a0ff1ad 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -481,7 +481,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	struct bpf_map *map = vmf->vma->vm_file->private_data;
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>  	struct mem_cgroup *new_memcg, *old_memcg;
> -	struct page *page;
> +	struct page *page, *new_page = NULL;
> +	vm_fault_t fault_ret;
>  	long kbase, kaddr;
>  	unsigned long flags;
>  	int ret;
> @@ -489,59 +490,106 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>
> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +	page = vmalloc_to_page((void *)kaddr);
> +	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
> +		/*
> +		 * Preallocate outside the lock with a sleepable allocator so it
> +		 * can reclaim and run the memcg OOM killer, which the
> +		 * non-blocking allocator under arena->spinlock cannot. A NULL
> +		 * return is non-recoverable, so fail with VM_FAULT_SIGBUS;
> +		 * VM_FAULT_OOM would be retried by the fault path and can
> +		 * livelock when the charged memcg is not the faulting task's.
> +		 */
> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +		new_page = bpf_map_alloc_page_sleepable(map);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		if (!new_page)
> +			return VM_FAULT_SIGBUS;
> +	}
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {

A subsystem pattern flags this as potentially concerning: the lockless
probe at vmalloc_to_page() reads the arena's kernel page table before
arena->spinlock is taken. The result of this probe decides whether to
preallocate with the sleepable allocator. Could the probe's observation
go stale between the check and the lock acquisition?

Looking at the code flow, if the probe sees a mapped page but that page
is freed (by arena_free_pages(), arena_free_worker(), or a concurrent
bpf_arena_free_pages() clearing a scratch PTE) before the lock is taken,
the code reaches the fallback path:

> +	if (!new_page) {
> +		/*
> +		 * Very rare race: the bpf program had allocated a page here, so
> +		 * the lockless probe saw it and we skipped preallocation, but it
> +		 * freed the page before we took the lock. Now we do need one;
> +		 * sleeping is not allowed here, so fall back to the non-blocking
> +		 * allocator and give up if it fails.
> +		 */
> +		ret = bpf_map_alloc_pages(map, map->numa_node, 1, &new_page);
> +		if (ret) {
> +			fault_ret = VM_FAULT_SIGBUS;
> +			goto out_err_locked_memcg;
> +		}
> +	}

This fallback uses the non-blocking allocator inside arena_vm_fault()
where IRQs are disabled. In bpf_map_alloc_pages() -> __bpf_alloc_page()
-> can_alloc_pages() (kernel/bpf/syscall.c), the IRQ-disabled context
means the non-blocking path is taken with alloc_pages_nolock().

Doesn't this reintroduce the exact problem the patch aims to solve? When
the memcg is at memory.max, the non-blocking allocator returns NULL,
which turns into VM_FAULT_SIGBUS on a valid arena address. The commit
message says the patch prevents "a routine memory.max into a fake
segfault," but this race window leaves that scenario possible when:

(a) the lockless probe sees a bpf-program page and arena_free_pages() or
arena_free_worker() clears the PTE before the lock is taken, or

(b) the lockless probe sees arena->scratch_page and
apply_range_clear_cb() in bpf_arena_free_pages() clears that PTE (it
does ptep_get_and_clear() unconditionally and only skips freeing the
scratch page itself).

Is there a reason the lockless probe cannot be moved inside the locked
region, or is this residual race acceptable for the optimization?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32835197153
--===============3740373577458984524==--
