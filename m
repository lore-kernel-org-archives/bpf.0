Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB34119F4;
	Fri, 21 Aug 2026 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291951; cv=none; b=ubEIiJXrCf95RCe4FWOn9SSL7LHDMILQC30j/2d3w09kHElAWw3P53i4yEgTUFJhGhm6e5l2H0vP9pdLNnGKtD9ug2i9S9yAG8eWVFTFOr63BSehiwVurAgYMr93LMOO2lL6NqtRYBg/+zLL9pxpR6bneNA7Olclp8J3Q9IyZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291951; c=relaxed/simple;
	bh=GZEN3/4SCDPgBZ76gkXcCxBahI2EcOajzouuy3Y9xVs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E5QHL5PeELESOCCMLq7svCgyB3tmcuwaKM9StQvnABhGOQZQOHCVPMKpw5eQnNLFngLgd+yvSCg5aqmBFHIwajUsxvGj0pJs3NIRhovrNcJlL2B4rXrydnS4H4YW/95QmuqoEEQQAQlS2srahePss9n/tJTtKi9zqDs2Ddm0fnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4wNxyT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4wNxyT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F081F000E9;
	Fri, 21 Aug 2026 05:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787291950;
	bh=IQPTg0dopiefX+ceQgvRa3Xq7Ko0okmJeAh7+on8IeM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H4wNxyT9THaO3qStPOad6v7eG6qGV2t4SsxO9wkjUhs0rMHoZBDeDPJy5RCf8iwTQ
	 GQi/N4kQ4ymQrEG51JecESowP3iW9D/efIYqDzlS/dcrb22BtXBXpG0iQKgUoUR2yz
	 MPmPFxTuxvpMKs949xCuF1RYgmBkIOZZoVakdH2SzXmx68th895UMFIp2b92G1eD3N
	 hX+jyyNW89nmHoN9JVDYQiXp1MnL+fBWjdz+hNYP/GsB0IegVaDi3Wu+O/3e8dAVX6
	 ZLx86OBwjqsI58Ul8CflwiNB9QKm1qp4y/GEUJFm1XBrGWa1YeBCNRQ0/IsejqPKAS
	 /g2AxaBvX+76w==
Content-Type: multipart/mixed; boundary="===============3389001773132304324=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b951553281d4e1491647aad4c4c0a8fac03d6b78ecac351fd216888eaae6ce72@mail.kernel.org>
In-Reply-To: <20260821050631.39784-2-jiayuan.chen@linux.dev>
References: <20260821050631.39784-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: arena: allocate the fault-in page outside the lock
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 05:59:09 +0000 (UTC)

--===============3389001773132304324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..50dac9ba0f5e 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -489,59 +490,108 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>
> +	page = vmalloc_to_page((void *)kaddr);
> +	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
> +		/*
> +		 * We run in process context here, so preallocate the page
> +		 * outside the lock with an explicitly sleepable allocator. It
> +		 * can then go through reclaim (both memcg and global) and the
> +		 * OOM path, the way do_anonymous_page() does; under
> +		 * arena->spinlock only the non-blocking allocator is available,
> +		 * which never reclaims. That also decides the return value:
> +		 * VM_FAULT_OOM below is only meaningful if the OOM machinery was
> +		 * actually engaged, which the non-blocking allocator never does.
> +		 */
> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +		new_page = bpf_map_alloc_page_sleepable(map);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		if (!new_page)
> +			return VM_FAULT_OOM;
> +	}

Can this return VM_FAULT_OOM when the allocation is charged to a foreign
memcg?

The preallocation charges the arena creator's memcg, not current's:

    bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
    /* set_active_memcg(bpf_map_get_memcg(map)) */

    new_page = bpf_map_alloc_page_sleepable(map);
    /* GFP_KERNEL|__GFP_ZERO|__GFP_ACCOUNT|__GFP_NOWARN */

For an order-0 GFP_KERNEL allocation the only realistic NULL is a memcg
charge rejection. mem_cgroup_oom() calls out_of_memory() with oom_control
pointing at the arena owner's memcg, so the OOM killer can only select
victims inside that cgroup.

VM_FAULT_OOM reaches pagefault_out_of_memory() (mm/oom_kill.c:1180-1193),
which only resolves current->memcg_in_oom; otherwise it prints the
rate-limited "Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF"
message and returns. Because the over-limit memcg is foreign, killing
tasks there never makes fatal_signal_pending(current) true, so
try_charge_memcg()'s force-charge escape hatch never fires.

If the owner memcg's charge is dominated by memory its tasks cannot free
(for example the arena's own pages, which are only freed by the bpf program
or by map destruction and are unreclaimable), or if that cgroup has no
OOM-eligible tasks left, mem_cgroup_oom() returns false, try_charge_memcg()
returns -ENOMEM, and the instruction is retried in a loop.

This creates an unbounded fault/retry livelock burning CPU in the faulting
task plus dmesg spam, where the pre-image returned a bounded
VM_FAULT_SIGSEGV. Before this patch the in-lock allocator never engaged
reclaim or the OOM killer, so a user touching an arena page could not kill
anything. Now any task that can mmap the arena (the fd can be passed via
SCM_RIGHTS or a bpffs pin, so the faulting task need not be in the owner's
cgroup at all) can drive the memcg OOM killer in the owner's cgroup one
task at a time simply by faulting in pages.

VM_FAULT_OOM promises the caller that the OOM machinery was engaged on a
domain where retrying can succeed. The in-code comment acknowledges the
general point ("VM_FAULT_OOM below is only meaningful if the OOM machinery
was actually engaged") but not the foreign-memcg case. Would it make sense
to use a bounded status for the charge-failure case (VM_FAULT_SIGBUS, or
VM_FAULT_OOM only when the charged memcg == current's memcg)? That would
keep the fix's benefit (reclaim now runs, which is the routine memory.max
case the changelog cares about) without the unbounded retry.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32450158690
--===============3389001773132304324==--
