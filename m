Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA03FCB3D;
	Fri, 18 Sep 2026 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725100; cv=none; b=QiLsrMnuK+zgaSk17pS92T8NjORolLjfLanzosjixmAJ59rnmUYll6cp/u/uUHpmZeR9InpLTKgCjDBoXFtKqd8MdQXJZFjBmtzOCVnR+zT1KhXr8Ei1JXwSs+N0oLWWx7Tv6ir729VWF9MIjiVCLFVbqRNYJ71uyM/RIVuHhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725100; c=relaxed/simple;
	bh=Ap44lbM4H0d5i6d9TTif8rcALcODXGrK6BA7mAJhPR0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SkwWTaNI9oudFQdpgXO99jNoAbyMjJ0MxjrcMmGAe+eOci6eBQbok5QzUWXGEW7SaJJwo45xYJhqEiipqRG69jOFCTTnb5qlv7WujpDa9mJRAHnHVaCu2je0sjyJBNo7SslofYtpfeMrjSHnD42BVr6BjN69XG5EPmcFXC2HPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjtpKzLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjtpKzLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9008B1F000FF;
	Fri, 18 Sep 2026 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725098;
	bh=pIeSjUP6pelSiOVn9QZc67xovoxMXQZc3F1Y0h1vU2Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YjtpKzLDubYhkAosaf7zfaAOoLO/yyOjsazOlYBqOyb3ThMWK7PmM4dwudRUyR/Og
	 LuGCF/SNG0hU2uzZlPi80kfnVfAqxRj2OfoJMsHtfAX+EgQCD/ffX3itxKoX2rDyu/
	 c9OvSl7NBjICbo8NN3kfy0HqwiihXrGiW5wj5YaFP5BKKhdxI+BV5sSa7MYCqUQHS3
	 5HO92sGfnhWwBF0qBdHfzQwQDBx3Zt/+KghZyPwSfHwdDC3MtNnQz/EmxG/7kNfRGS
	 RE1DwUkD/IkB9UBabeUhLuVesVu1ts4JvVWxp50MJEBg6JrNJ1SPd7c2bEf7CQgjtl
	 SKgPqMeKMvlLA==
Content-Type: multipart/mixed; boundary="===============7454123760235835643=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <437383abef881a965c3ad04222c851a7958b9f5b931927d23b0514aa09db24ca@mail.kernel.org>
In-Reply-To: <20260918084123.39477-2-jiayuan.chen@linux.dev>
References: <20260918084123.39477-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v8 1/3] bpf: arena: allocate the fault-in page outside the lock
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 09:51:37 +0000 (UTC)

--===============7454123760235835643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> arena_vm_fault() allocated the page while holding arena->spinlock, so it
> could only use the non-blocking allocator, which never reclaims. Once the
> memcg is at memory.max that allocation just fails, the fault turns into
> VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
> arena address. Hitting memory.max is routine (e.g. page cache from
> reading a big file), so this kills innocent processes over memory that
> reclaim could have freed.
>
> Rework the fault handler:
>
> - Preallocate the page before taking the lock, like do_anonymous_page()
>   does, so it can sleep and reclaim, instead of turning a routine
>   memory.max into a fake segfault. The allocation uses
>   __GFP_RETRY_MAYFAIL so it never invokes the OOM killer: the page is
>   charged to the map's memcg, which need not be the faulting task's, so
>   an OOM there could kill unrelated tasks in the map's cgroup while a
>   foreign faulter could never be its victim. Like the other bpf map
>   allocators it places the page on the map's numa_node rather than
>   following the task's mempolicy; arena memory is shared, so the map's
>   node is the right placement policy.

This isn't a bug, but since arena_map_alloc() rejects BPF_F_NUMA_NODE,
map->numa_node is always NUMA_NO_NODE here. Is the numa_node rationale in
the changelog saying more than 'unchanged, still the local node'?

> - On allocation failure fall through to the locked recheck rather than
>   failing right away: a page a concurrent allocator installed meanwhile
>   is used, otherwise the non-blocking fallback fails and we return
>   VM_FAULT_SIGBUS. Not VM_FAULT_OOM: nothing ran the OOM killer, and the
>   fault path would just retry it forever.
>
> - A lockless probe skips that preallocation when a page is already mapped
>   (e.g. allocated by the bpf program), so the common case wastes no
>   allocation. The rare race where such a page is freed before we take the
>   lock falls back to the non-blocking allocator under the lock.
>
> - Return VM_FAULT_SIGBUS for the other non-recoverable errors (lock
>   failure, range-tree and page-table failures) instead of
>   VM_FAULT_SIGSEGV; only BPF_F_SEGV_ON_FAULT, and a scratch-page hole
>   under that flag, is a real user addressing error and keeps
>   VM_FAULT_SIGSEGV.

Small changelog nit: the lock-failure path already returned VM_FAULT_SIGBUS
before this patch -- would it be clearer to list only the range-tree/
page-table/allocation failures as the ones changing from VM_FAULT_SIGSEGV?

> - Tidy up the error labels.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..2d0efc0232afd 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -489,59 +490,108 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>
> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +	page = vmalloc_to_page((void *)kaddr);
> +	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
> +		/*
> +		 * Preallocate outside the lock so the allocation can sleep and
> +		 * reclaim, which the non-blocking allocator under
> +		 * arena->spinlock cannot. __GFP_RETRY_MAYFAIL: reclaim, but
> +		 * never OOM-kill in the map's memcg, which need not be the
> +		 * faulting task's. On failure, fallthrough: the locked
> +		 * recheck below picks up a page a concurrent allocator may
> +		 * have installed meanwhile, and otherwise the non-blocking
> +		 * fallback fails and we return VM_FAULT_SIGBUS. Not
> +		 * VM_FAULT_OOM: nothing ran the OOM killer, and the fault path
> +		 * would just retry it forever.
> +		 */
> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +		new_page = alloc_pages_node(map->numa_node,
> +					    GFP_KERNEL | __GFP_ZERO |
> +					    __GFP_ACCOUNT | __GFP_NOWARN |
> +					    __GFP_RETRY_MAYFAIL, 0);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +	}
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>  		/*
>  		 * A failed lock means a possible deadlock was detected. Don't
>  		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
>  		 * the fault path would re-take it on retry and deadlock. Fail.
>  		 */
> +		if (new_page)
> +			free_pages_nolock(new_page, 0);
>  		return VM_FAULT_SIGBUS;
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35327041280
--===============7454123760235835643==--
