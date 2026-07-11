Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C033CE9A
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763952; cv=none; b=u6mta2BDsAuxYVxJHdoLbNclRymFIXrAJPV8Yq9B3ZkmbMqXy4+2emjcygQ3bs920SNNnr4eYlJqcWuqoTduianQUGbYS3SmCNaFypyEk8dbkstyhFW8cpwGHI45kmtAngPLM6lLg1FjF+/t/Ei+yxeTfP0+q4LsAUyy8M1zFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763952; c=relaxed/simple;
	bh=t2Ow8JTesmu+qZN+miiSPiYY/k2cOZhURzEiekkNAvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bUd95ZlZFdXc44UdXmxF+B9m+PMuLg363kaday8VqqK/PpC0BvYhvn147oiQPFfBd6kAdA0FVY5xe+/NdVzeh62PkO/k83STDOoJJGuO4MUWz14URRSn7i7dEihBkTzgRh2Qej+4YDl/lZnA0jLES1zjHGHk+B08eO+972xp7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eblOKLk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eblOKLk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271A31F000E9;
	Sat, 11 Jul 2026 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783763951;
	bh=gNygZJ2Z3Hyldt3AmyhXzkK30veoDEbvSKfq1hYeYuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eblOKLk2TV3rOxOm94tPoRYzJcKlrrCi+lG9GxG6WiSThlu24Ue33R1D43vI0BKbL
	 MV6tI0iLhCLSbQGnpK4gkXZeHAy13ik9mITS6IoavE7qTJcj+h7DsUSJGacl7Rjt5M
	 ir6QmR7oi36GhkWpGNTlmTC4yMTJtUVKOwXEOcCVWnfJ1Fhwm4vapAZCtT4H7PvFrK
	 t/5qapfHtvWpSrbM/b7bd3gvAORa3HaNEPrqORc7bl8vqGAjtWBttYwhnQ+367yShi
	 J7EnQPNvxydNu5A5p5d3RnwlPOdGNiTHGi39dS1QeDI8C0bHOm/ba+B764HuxDu1Yu
	 RYNZo3ZKp+k8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for
 BPF allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260711-execmem-x86-rox-bpf-v0-v2-5-bfd956d35119@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
 <20260711-execmem-x86-rox-bpf-v0-v2-5-bfd956d35119@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 09:59:10 +0000
Message-Id: <20260711095911.271A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized kernel memory from vmalloc/kvmalloc is copied into e=
xecutable ROX BPF images (dispatcher and trampoline), causing an informatio=
n leak and a wild execution risk.
--

--- Patch [5]: [PATCH bpf-next v2 5/5] x86/bpf: enable EXECMEM_ROX_CACHE fo=
r BPF allocations ---
commit 12eba9f58f961b936cd08cfa17b30375eb214d2a
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

bpf: dispatcher: allocate bpf_dispatcher->rw_image with vmalloc()

This commit changes the allocation of bpf_dispatcher->rw_image to use
vmalloc() instead of bpf_jit_alloc_exec(), avoiding a permissions dance
when EXECMEM_BPF is backed by ROX caches. It relies on the fact that rel32
offsets are calculated against the actual ROX image, so the temporary
buffer does not need to reside in the module address range.

> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index ea2d60dc1feeb..d85b3e8ad2e4e 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatche=
r *d, struct bpf_prog *from,
>  		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zer=
o, false);
>  		if (!d->image)
>  			goto out;
> -		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);
> +		/* d->rw_image doesn't need to be in module memory range, so we
> +		 * can use vmalloc.
> +		 */
> +		d->rw_image =3D vmalloc(PAGE_SIZE);

[Severity: High]
Does this code leak uninitialized kernel memory into the executable ROX BPF
image?

By changing the allocation to vmalloc() without zeroing, any trailing bytes
beyond the emitted instructions are left uninitialized.

When this buffer is later used in bpf_dispatcher_update(), a full 2048 bytes
are copied:

kernel/bpf/dispatcher.c:bpf_dispatcher_update() {
	if (bpf_dispatcher_prepare(d, new, tmp))
		return;
	if (IS_ERR(bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2)))
		return;
}

Because the uninitialized bytes (which can decode into random executable
gadgets) replace the intended trap or padding instructions (e.g., INT3 or
zeroes), does this also create a wild execution risk if execution falls
through past the generated code?

This is a pre-existing issue, but the same pattern appears in
arch_prepare_bpf_trampoline():

arch/x86/net/bpf_jit_comp.c:arch_prepare_bpf_trampoline() {
	/* rw_image doesn't need to be in module memory range, so we can
	 * use kvmalloc.
	 */
	rw_image =3D kvmalloc(size, GFP_KERNEL);
	if (!rw_image)
		return -ENOMEM;

	ret =3D __arch_prepare_bpf_trampoline(im, rw_image, rw_image + size, image=
, m,
					    flags, tnodes, func_addr);
	if (ret < 0)
		goto out;

	tmp =3D bpf_arch_text_copy(image, rw_image, size);
}

Because kvmalloc() does not zero-initialize the memory, is BPF_INSN_SAFETY
padding left uninitialized before being unconditionally copied to the ROX
image?

>  		if (!d->rw_image) {
>  			bpf_prog_pack_free(d->image, PAGE_SIZE);
>  			d->image =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-execmem-x8=
6-rox-bpf-v0-v2-0-bfd956d35119@kernel.org?part=3D5
