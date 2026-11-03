Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719240;
	b=aLUIfE/+/JqQ3gbGLCZJDDji4Pc/OQKnwfXks43DHTrrY/TIiAB9peJwII1m3uprK/C4
	 jmYpV8Eab4F4tdGYNyGsZBV2/7pFMLFwtg5E9q5Ic2tbdavaK1G5Zbfh3Jm57aNjWFBTi
	 WK4RfK4orw8ZwVYmjFo4bLVvyD7BTCF6v3kF0PbnzNFcUYaXnAePQDS623L/nxaE8qBY1
	 yvcWEpRIKaZY67pSJFdeghRyqGpf/MckFlcj3uZ/gbwHUoRCRgk7H94/56UIMgtpj6VJn
	 0cYduftTnVjYL3EPwOQFEytwMg3EtAdfffMivV2RYpLSjLFTQDifHp8KvG9con8ujwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719240;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=gtw/sugkp/MWiaPK/rLpw/XkK61yPsiTm3ZX08pe+ZY=;
	b=AvX6M/L1QyfGJvr9Mgu2aytupoExdcTo5NDktcKm5Mb7aUUE1WDsq8+aM6YI5PqDBkWI
	 /ds6DSuRBMxHeSs7tYsmkL1QHYpBCT5ufpLQ00z4i4dsLKXGAU/iKOavbS59pndJASViI
	 3qZrFah4DkrB5bnR2KZF1rlCLvD0tghEczdWV3d9QvqmdHIKoo7af2uxa+kWQ2jXObocs
	 Rl1CSoYXnqsDXdND/9J9JbXGw98oBuY2nxkUibHvrfYhq5JUydqeDfybpFKre4fI0s8AI
	 TDiugi7SFSexlXi4rAGlYQDRwkpgCg3fuAVv+cnemfmcfsTFcMPWqmVFI8YXf5+sAew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIxs5ECZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE1606A33F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIxs5ECZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21A71F01803;
	Tue,  3 Nov 2026 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719240;
	bh=gtw/sugkp/MWiaPK/rLpw/XkK61yPsiTm3ZX08pe+ZY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nIxs5ECZZtQaK2799cV3Lo0wU86GICCV13zbHlAy+JIOIf3PslR73QFkloI7wOQqW
	 cMDbC67GO5G7upLisQvxNmuFhrGz6emkGMaHq/PcGt0L4r/EPkPfaaP8JSabowTGxA
	 ZP2nYdPkPFKPiOzHCTYMYpnVqDnPV28ZtljGc5D0DSTpkzrvROWH6ZcUns3G0mdbT4
	 L6aZMCbjPuGM3g6GNAnPb7238FjEqqURDIEw0ZH7k9Ql0hLOAZASMFQ195IpwS6WLe
	 j/EugeQDgxdepakFm9fOZICy7e85hGHXm//av1mQKGWwPUngMONyug61nAjxyqOU3Q
	 hFAPvXENlpFuA==
Content-Type: multipart/mixed; boundary="===============4176742742805017085=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6b8e34ebc3beda0944ee423bd46fc152763dd323004dee87891d4ae3155d89de@mail.kernel.org>
In-Reply-To: <20261103142856.463063-2-puranjay@kernel.org>
References: <20261103142856.463063-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: Don't allocate and free prog pack memory with pack_mutex held
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,mykyta.yatsenko5@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 15:20:39 +0000 (UTC)

--===============4176742742805017085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't allocate and free prog pack memory with pack_mutex held

TL;DR:
- bpf_prog_pack_alloc() may return NULL without rescanning pack_list if its
  unlocked alloc fails while another allocator added a pack, so JIT or
  trampoline allocation could spuriously fail
- Commit message likely wrongly lists powerpc

> bpf: Don't allocate and free prog pack memory with pack_mutex held
>
>     bpf_prog_pack_free() frees an empty pack with pack_mutex held, and
>     alloc_new_pack() calls set_memory_rox() with it held. Both can end up in
>     __purge_vmap_area_lazy(), which queues purge_work on system_percpu_wq
>     and waits for it since commit 72210662c5a2 ("mm: vmalloc: offload
>     free_vmap_area_lock lock"). set_memory_rox() gets there through
>     vm_unmap_aliases() on arm64, x86 and powerpc.

Is the powerpc part of this correct?  On x86 and arm64 set_memory_rox()
reaches vm_unmap_aliases() via change_page_attr_set_clr() and
change_memory_common() respectively.

On powerpc, set_memory_rox() is change_memory_attr(), which only calls
apply_to_existing_page_range() with change_page_attr() and then
flush_tlb_kernel_range().  The only vm_unmap_aliases() call under
arch/powerpc is in the memory hot-remove path.

On powerpc only the free path (vfree() -> vm_reset_perms() ->
_vm_unmap_aliases()) seems to reach __purge_vmap_area_lazy().  Should
powerpc be dropped from that sentence, or should it say which path applies?

[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -1021,11 +1024,21 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
>  		goto found_free_area;
>  	}
>  
> -	pack = alloc_new_pack(bpf_fill_ill_insns);
> -	if (!pack)
> -		goto out;
> +	if (new_pack) {
> +		list_add_tail(&new_pack->list, &pack_list);
> +		pack = new_pack;
> +		new_pack = NULL;
> +		pos = 0;
> +		goto found_free_area;
> +	}
>  
> -	pos = 0;
> +	mutex_unlock(&pack_mutex);
> +	new_pack = alloc_new_pack(bpf_fill_ill_insns);
> +	if (!new_pack)
> +		return NULL;
> +
> +	mutex_lock(&pack_mutex);
> +	goto again;

Can this return NULL when another allocator has just added a pack with
free space?

The decision to allocate is made on a pack_list snapshot that is stale once
pack_mutex is dropped.  The success path re-checks pack_list after
re-locking, but the failure path returns NULL right away.

Suppose allocators A and B both find no room and both call
alloc_new_pack() without the mutex.  A succeeds and B fails, for example
because execmem_vmalloc() cannot find space.  On x86 the EXECMEM_BPF range
is the module area, about 1GB shared with modules, with no fallback range.
B returns NULL even though A's pack, added to pack_list moments later, has
BPF_PROG_CHUNK_COUNT free chunks.

Before this patch alloc_new_pack() ran under pack_mutex, so B would have
waited for the mutex, found room in A's pack and succeeded without
allocating.

This also seems to make such failures more likely.  Every concurrent
allocator that sees no room now allocates its own BPF_PROG_PACK_SIZE
(SZ_2M * num_possible_nodes()) region at the same time, before the extra
ones are freed.  On a large NUMA x86 host that transient demand could be
many tens of MB to hundreds of MB of module space, for example when many
seccomp or socket filters are JITed at once after the last pack was freed.

The NULL reaches bpf_jit_binary_pack_alloc() and then the arch JITs (the
x86 do_jit path does 'if (!header) goto out_addrs;'), so the program falls
back to the interpreter or fails to load with CONFIG_BPF_JIT_ALWAYS_ON.
Trampoline and struct_ops image allocation fail with -ENOMEM
(bpf_tramp_image_alloc(), bpf_struct_ops_image_alloc()).

Would it be better to re-take pack_mutex and scan pack_list once more when
alloc_new_pack() fails, before returning NULL?  The later commit
653557885326 ("bpf: Invalidate freed prog pack memory without holding
pack_mutex") in the series does not touch this path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41657960013
--===============4176742742805017085==--
