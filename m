Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FE54723
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764033; cv=none; b=TXxXxPvjbEcip4Qhfa9DQ/y0NX5TdIpMeto3Hr9140oF5IUzoQ6oHLgqhOaS7J8XeLqJRwlqtHTMjqqqQNE6iBOnMwds75SdNeOhcyvD9HB4q3UJTOkqHrrJQLXupqM23pDhTMxNTXTooqRPp2dZnfZ0prqddgicJjwCw8jlCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764033; c=relaxed/simple;
	bh=u3K3TY5P40xjrkDtYeSeBnT9oqhL1oX8/d29WkdJWY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nxSwKkXSrGcgjBgTCCfsndEvDTLqwsemWoCYQ08RtO7CZ27F20p5gCSNWoIKIOCiYdnOqDcRht541bzlBjdDRDLRzugNmO6jwPDjaCu1EvzKDmvFHHJoC8EsGu07t+ZjxWDwwjkqki1ieZMXywizN2GMeDoBqokT3HuUCNPt+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aShSCTWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aShSCTWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B1C1F000E9;
	Sat, 11 Jul 2026 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783764032;
	bh=O6vSS8bRUF1H8QmkFyHLeD+RadqH0bOMO8BJzVICNVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aShSCTWShd1ZGDf4GdJhMpwVoc8/LtDWIPBBb2kTrcENURgvD6xftypjvQpyUWtff
	 jiuwFRuQhe+URcY3iQVbCnLtM9rQatTIkaT7UTWduq5xw9E4ECIHSPy/7aAsBE0AGr
	 0GU4vI3/RSVvQ34/weV0yoDj4wozDRTNGA1SSXfo4nN+pyTVkjKvgbTE3RMmm13t08
	 RiOp0QFpm7JrOoNVT6CMLrk1+Pu9kFuKTHhq3kPxSAQgvrPdY7tQDMlW9CeXNDUzQW
	 1hhGQlPBvTlbt2/aSmWsZH2sQ6K4UFPMU0SWetyTFCUgfklAL7OHIWYaQXPQTUcgBC
	 wflAznDIywTIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/5] bpf: alloc_prog_pack(): skip ROX
 management for already ROX memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260711-execmem-x86-rox-bpf-v0-v2-3-bfd956d35119@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
 <20260711-execmem-x86-rox-bpf-v0-v2-3-bfd956d35119@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 10:00:31 +0000
Message-Id: <20260711100032.58B1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] BPF trampolines and non-pack JIT binary allocators will crash du=
e to writing directly to ROX memory when EXECMEM_ROX_CACHE is enabled.
--

--- Patch [3]: [PATCH bpf-next v2 3/5] bpf: alloc_prog_pack(): skip ROX man=
agement for already ROX memory ---
commit 81282c502cc862cd297ba34160f028b0565526c2
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

bpf: alloc_prog_pack(): skip ROX management for already ROX memory

execmem_alloc() can return ROX memory that is already filled with
architecture defined trapping instructions.

In preparation for enabling this mode for BPF on x86, make sure that there
is no redundant management of the ROX memory.

There is no need to fill allocated memory with trapping instructions, to
request permissions reset on free and to set ROX permissions as this all
is handled by execmem_alloc().

Add bpf_jit_mem_is_rox() wrapper for execmem_is_rox(), use it to check if
execmem_alloc() returns ROX memory and skip the redundant steps in that
case.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fc75625dc9513..1b89c18cf2461 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -916,6 +916,11 @@ static LIST_HEAD(pack_list);
> =20
>  #define BPF_PROG_CHUNK_COUNT (BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
> =20
> +static bool bpf_jit_mem_is_rox(void)
> +{
> +	return execmem_is_rox(EXECMEM_BPF);
> +}
> +

[ ... ]

> @@ -965,7 +972,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns, bool
>  			pr_warn_once("BPF: Predictors not flushed for allocations greater tha=
n BPF_PROG_PACK_SIZE\n");
>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D bpf_jit_alloc_exec(size);
> -		if (ptr) {
> +		if (ptr && !bpf_jit_mem_is_rox()) {
>  			int err;
> =20
>  			bpf_fill_ill_insns(ptr, size);

[Severity: Medium]
Since this patch protects bpf_prog_pack_alloc() and alloc_new_pack() from
writing to memory that might already be ROX, does it also need to protect
other callers of bpf_jit_alloc_exec() that write directly to the allocated
memory?

For example, bpf_jit_binary_alloc() allocates memory and directly writes
illegal instructions:

kernel/bpf/core.c:bpf_jit_binary_alloc() {
    ...
    hdr =3D bpf_jit_alloc_exec(size);
    if (!hdr) {
        bpf_jit_uncharge_modmem(size);
        return NULL;
    }

    /* Fill space with illegal/arch-dep instructions. */
    bpf_fill_ill_insns(hdr, size);
    ...
}

Similarly, on x86, arch_bpf_trampoline_size() allocates memory and passes
it as a read-write buffer:

arch/x86/net/bpf_jit_comp.c:arch_bpf_trampoline_size() {
    ...
    image =3D bpf_jit_alloc_exec(PAGE_SIZE);
    if (!image)
        return -ENOMEM;

    ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, im=
age,
                                        m, flags, tnodes, func_addr);
    ...
}

Could these paths cause a page fault when EXECMEM_ROX_CACHE is enabled,
since they attempt to write directly to the read-only memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-execmem-x8=
6-rox-bpf-v0-v2-0-bfd956d35119@kernel.org?part=3D3
