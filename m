Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467F3CCFA8;
	Mon, 27 Jul 2026 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134579; cv=none; b=tKEOu9D3Y/TlFjrznLdaF/CfPaubrZHkeAzB4efXw2RcCwVTSdQO/r0SqY0ZQvAf8vG5x2aKaPU+AsUHSf4IM92K5hTfAx25d3PEHqMHXP+EkxQe8DVZlKexIHPnOMYcipnsRPP3PIjfY7INkCHWKLKn1toYwPgg0sp7iYUvyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134579; c=relaxed/simple;
	bh=gSEwSlOZCOa4il4qf8oOvr3QR5iPqOV9oIf7Qn+Nx0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WHAJsBGzQH0LoeNzjbbA8Ap3//uXGeSO337t5JepZsg7FQN3Vz/Ebz5oH+X048SZAYRCOOx9nfsymE9mvlCGpShQdA89YA54IcQBCkZXrGz/4gLw6xlPsrUpkO9IC9ddjfUslEZTIXgaeyYjK7iLd3u1bEiHwLuNEok1LDC8EB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0fUeYXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0fUeYXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BD81F000E9;
	Mon, 27 Jul 2026 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785134577;
	bh=1SEACZXvvYUeZWcn1NqzzGQ8WAd8S0O+WtLv0hx+3/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f0fUeYXBKgCHZnAIA6HguMBI93cdYs+zoKWuBuSAZjAq/S41yc423rMkEyR2M0+NL
	 2x73Tf3BKBexrFRReVyZKZcQLy6R9rMZk9iF3+szM1Nhg54jOKDNFLlNfbKdyuKkOU
	 59y9X6Yck9AI7UBYvVWlAExOD7/ZIwNvAUxhPTjjWAfTCdqaOl3kYmyTcUPtM0dZLE
	 melG2DoSvvx0rvD+ObnT9XKOKEaaUS/PR9uzvon83/Z9TBrkUxOyGGuxbMKKu5FupA
	 VRbk8QlO16HBqWwGb1xNI8CfhXSfXz33mM104nRM9vM4K6iyhQsP2TPpeYVQw4pc5G
	 LNlgA/swREOxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page
 outside the lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260727062521.376231-3-jiayuan.chen@linux.dev>
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 06:42:56 +0000
Message-Id: <20260727064257.01BD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unnecessary sleepable memory allocation introduces a Denial of Ser=
vice and OOM vector when BPF_F_SEGV_ON_FAULT is set.

Pre-existing issues:
- [High] Missing lock release before returning VM_FAULT_RETRY causes a lock=
 leak and deadlocks.
--

--- Patch [2]: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page =
outside the lock ---
commit 618b434e77e16e8a5277e1b3cc85c17fc5ef5e7a
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: arena: allocate the fault-in page outside the lock

arena_vm_fault() allocated the page while holding arena->spinlock, so it
could only use the non-blocking allocator. Once the memcg is at
memory.max that allocation just fails, the fault turns into
VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
arena address. Hitting memory.max is routine (e.g. page cache from
reading a big file), so this kills innocent processes.

Preallocate the page before taking the lock, like do_anonymous_page()
does, so the allocation can sleep and go through reclaim and the OOM
path, and return VM_FAULT_OOM on failure so the memcg OOM handler runs
instead of a fake segfault. Also tidy up the error labels.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 34f023a537fe6..22a41e3c53b81 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -481,7 +481,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	struct bpf_map *map =3D vmf->vma->vm_file->private_data;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>  	struct mem_cgroup *new_memcg, *old_memcg;
> -	struct page *page;
> +	struct page *page, *new_page =3D NULL;
> +	vm_fault_t fault_ret;
>  	long kbase, kaddr;
>  	unsigned long flags;
>  	int ret;
> @@ -489,55 +490,97 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
>  	kbase =3D bpf_arena_get_kern_vm_start(arena);
>  	kaddr =3D kbase + (u32)(vmf->address);
> =20
> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +	page =3D vmalloc_to_page((void *)kaddr);
> +	if (!page) {
> +		/*
> +		 * Preallocate outside the lock so the allocation can sleep and go
> +		 * through reclaim (both memcg and global), the way do_anonymous_page()
> +		 * does. Under arena->spinlock only the non-blocking allocator is
> +		 * available, which never reclaims.
> +		 *
> +		 * This has to be the sleepable variant: VM_FAULT_OOM below is only
> +		 * meaningful if the OOM machinery was actually engaged. A failure
> +		 * from the non-blocking allocator engages nothing, so the fault
> +		 * would be retried forever.
> +		 */
> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +		new_page =3D bpf_map_alloc_page_sleepable(map, NUMA_NO_NODE);

[Severity: High]
Is there a potential Denial of Service vector when BPF_F_SEGV_ON_FAULT is s=
et?

This unconditionally preallocates a page using
bpf_map_alloc_page_sleepable() before checking the BPF_F_SEGV_ON_FAULT
flag later in the function.

This allocation can block, trigger direct memory reclaim, and invoke the
OOM killer. Only after this expensive allocation does the code lock, check
the flag, return VM_FAULT_SIGSEGV, and discard the page.

Could this allow an unprivileged user to force severe memory pressure by
repeatedly triggering page faults on unallocated addresses?

> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		if (!new_page)
> +			return VM_FAULT_OOM;
> +	}
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>  		/* Make a reasonable effort to address impossible case */
> -		return VM_FAULT_RETRY;
> +		fault_ret =3D VM_FAULT_RETRY;
> +		goto out_err;
> +	}

[Severity: High]
This is a pre-existing issue, but does returning VM_FAULT_RETRY here
without releasing the fault lock cause a lock leak?

The memory management subsystem strictly assumes the lock was released
if VM_FAULT_RETRY is returned. Retrying the fault will leak the read lock
reference, and if any thread subsequently attempts to acquire the mmap_lock
for writing, the system could permanently deadlock.

>  	page =3D vmalloc_to_page((void *)kaddr);
>  	if (page) {
> -		if (page =3D=3D arena->scratch_page)
> +		if (page =3D=3D arena->scratch_page) {
>  			/* BPF triggered scratch here; don't lazy-alloc over it */
> -			goto out_sigsegv;
> +			fault_ret =3D VM_FAULT_SIGSEGV;
> +			goto out_err_locked;
> +		}
>  		/* already have a page vmap-ed */
>  		goto out;
>  	}
> =20
> +	/*
> +	 * The lockless probe was racy: it saw a page, so nothing was
> +	 * preallocated, but the re-check under the lock finds it gone - a
> +	 * concurrent free must have run in between. There is nothing to
> +	 * install and we cannot allocate under the lock, so retry the fault
> +	 * and preallocate next time.
> +	 */
> +	if (!new_page) {
> +		fault_ret =3D VM_FAULT_RETRY;
> +		goto out_err_locked;
> +	}

[Severity: High]
Could returning VM_FAULT_RETRY here in this new race handling path also
leak the fault lock and risk deadlocks, similar to the lock acquisition
failure above?

> +
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> =20
> -	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> +	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
>  		/* User space requested to segfault when page is not allocated by bpf =
prog */
> -		goto out_sigsegv_memcg;
> +		fault_ret =3D VM_FAULT_SIGSEGV;
> +		goto out_err_locked_memcg;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727062521.3762=
31-1-jiayuan.chen@linux.dev?part=3D2
