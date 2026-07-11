Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204730EF64
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764167; cv=none; b=Gw/1Diwy54ZnKmbP5j5Pr6qZN6h2MAzqGoBXpiXMnbLbPfgEKQRItdZjbBflEofRJb6FVYrevcdK6ih79cKg537dnAixLXESBJJLtTXxmFEF7JiJ6fMicWJY5EK9obNf4Fv9L9xieRySXMGJevEVbDh+TYSprMiDhxP5IL6rp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764167; c=relaxed/simple;
	bh=igeufwQ4/+wCE0Tonsi8WKJoNs3DMFQlLwKDf8BbaW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EzNAD6Ik+/vmrUkTE5pW/9eu8wzuYB/QdQxSf2lKfxabt70/QUF1ZpUphaxBslTAIr/1JgmqCupg0scvnHCeNA57UWwgL/4Vs4GZZ2v1aTXUtOTO0EiaY6atQhO2rGQR5/f8MIZkqt8NiJ4RMbhFwhQ6G5jY6HStaeEtgijRbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9u/gLTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9u/gLTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331B21F000E9;
	Sat, 11 Jul 2026 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783764166;
	bh=wBreS0BCt/f/dPQx3mVVZKaXAQiSKoqRFr8UQUSk5M8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F9u/gLTJ6ovRq2esdQzdsTVMdo4lWmPas/7F3IgRGqPDeRTqpy4XGsiFz36b5cXJC
	 cxc4Z7mBZfn5/mSrxzFZ5KjBbAQX7cKOdUj9Mt4hw9UacGQZSrpGDRpwH93HghQXGt
	 +UE7fhECghu1CJ1ma7kGpBbnG7Ga9gNguBiZQbodW/M8ImUxguRGi7a5Dyr+s5ozsD
	 UNmybZ9DrwwqGvbf3fF49hcVSvBtXfhj87KExaQBRvGpv0TW4IVwxQOh5ZqzVnkVyh
	 qJivZn1GKbyYtjvExADidAYOoFpB/uL0zBwdeVfWogovXj8yyyK5ZPCJLGUg9cm+Ig
	 jLBFskHp+WkRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] bpf, x86: make sure allocation in
 arch_bpf_trampoline_size() is writable
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260711-execmem-x86-rox-bpf-v0-v2-4-bfd956d35119@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
 <20260711-execmem-x86-rox-bpf-v0-v2-4-bfd956d35119@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 10:02:45 +0000
Message-Id: <20260711100246.331B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unnecessary page table modifications and hugepage shattering dur=
ing trampoline size calculation.

Pre-existing issues:
- [High] Ignoring `execmem_restore_rox` failure leads to NX memory being ad=
ded to the ROX cache.
--

--- Patch [4]: [PATCH bpf-next v2 4/5] bpf, x86: make sure allocation in ar=
ch_bpf_trampoline_size() is writable ---
commit 837979675b78fb56749ec25f57d0084b1bf805ee
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable
   =20
arch_bpf_trampoline_size() allocates a buffer to get actual size required
for a trampoline.
   =20
This buffer must be in the module address space because
__arch_prepare_bpf_trampoline() calculates rel32 offsets relatively to
that buffer.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1beae..b2feec81e2312 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3703,13 +3703,12 @@ int arch_bpf_trampoline_size(const struct btf_fun=
c_model *m, u32 flags,
>  	int ret;
> =20
>  	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> -	 * This will NOT cause fragmentation in direct map, as we do not
> -	 * call set_memory_*() on this buffer.
>  	 *
>  	 * We cannot use kvmalloc here, because we need image to be in
>  	 * module memory range.
> +	 * Since it must be writable use bpf_jit_alloc_exec_rw().
>  	 */
> -	image =3D bpf_jit_alloc_exec(PAGE_SIZE);
> +	image =3D bpf_jit_alloc_exec_rw(PAGE_SIZE);

[Severity: Medium]
Does this allocation cause unnecessary page table modifications and hugepag=
e=20
shattering?

Allocating via bpf_jit_alloc_exec_rw() forces page table permission changes
(set_memory_nx and set_memory_rw), which triggers cross-CPU TLB flushes
and permanently splits 2MB hugepages in the ROX cache's direct map. When
the buffer is immediately freed, these operations are repeated.

Since arch_bpf_trampoline_size() only needs a dummy pointer in the module
memory range to satisfy relative jump offset checks during instruction
emission, could we pass func_addr as the dummy image pointer and use=20
kvmalloc() for rw_image instead?

>  	if (!image)
>  		return -ENOMEM;
> =20

[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1b89c18cf2461..e2076667b2451 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1128,6 +1128,11 @@ void *bpf_jit_alloc_exec(unsigned long size)
>  	return execmem_alloc(EXECMEM_BPF, size);
>  }
> =20
> +void *bpf_jit_alloc_exec_rw(unsigned long size)
> +{
> +	return execmem_alloc_rw(EXECMEM_BPF, size);
> +}
> +
>  void bpf_jit_free_exec(void *addr)
>  {
>  	execmem_free(addr);

[Severity: High]
This is a pre-existing issue, but there appears to be a flaw when freeing
memory to the ROX cache in __execmem_cache_free():

mm/execmem.c:__execmem_cache_free() {
...
	execmem_fill_trapping_insns(ptr, size);
	execmem_restore_rox(ptr, size);

	err =3D execmem_cache_add_locked(ptr, size, gfp_mask);
...
}

Does this ignore the return value of execmem_restore_rox()?

If execmem_restore_rox() fails (e.g., due to OOM when allocating page
tables), the memory remains Non-Executable (NX). Because the return value
is ignored, the NX memory is unconditionally added back to the ROX cache.

When subsequent allocations return this NX memory and the BPF JIT attempts
to execute code from it, will it trigger a fatal page fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-execmem-x8=
6-rox-bpf-v0-v2-0-bfd956d35119@kernel.org?part=3D4
