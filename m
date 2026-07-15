Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937E340A6A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152612; cv=none; b=EXyBiT7aaU1wRIWjEEv8FNv4K3B/gPkf7/2JCwbcnvV170XMet5slHu8XNIkOVe8U8E9SMJ2E19nB0TRtIF0dj6rvvgUbimETDiGGSJqDtZawf9J9kXSay5tUCfSaPNat+W8cg23sLUxRc0+NRlcAfB0aWdXOYwXlyzLiG+V8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152612; c=relaxed/simple;
	bh=mPaRn588Zuz5Wnb0rd8ba/3QEIdVaU5K01dOeepFTTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HncaqIPNZW8d93pdqFYigybRuzFwjM9sB3CxplwEWu6oWpzYzln9KpiggI4uYRPsGKyAEbRz3Z0maEG+r1J0Ah6Nam9fkdbdv/YQAk/ex3sbNUphnHFjxU16xa0262xBLHOTu01WZth6dTVQ+nq4n3vLJPLZ/Gb6Rv05qz25lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq7eEr4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq7eEr4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98FA1F000E9;
	Wed, 15 Jul 2026 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152611;
	bh=UBMXh1mjNCTW2DTh/1gVeiYPVPDtg/gMjIhTGbBbjTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bq7eEr4TbrJlC3at42DoCcovzweZsi2v14shGm+RSXAD7qmrEthMfjmWRflWTy2Tu
	 DYSFqH9EBlC99JYw5uxi4+fT7+nZFMadopaGZCpsKRhyURtXvEh7an7LwWlxc5Zo2c
	 ozOqfpGbFV7Gj+urTVUD0Qilgx0bwLBTjPVI6yMpSDY0n6unubYbnAJTmgSpof2xAH
	 1uKoyy0z41q7gXrs48ImJY75MDWiohutirh0p9TSNYO/sq0qmrV8V8jpqQ6QLuYN2y
	 e77Pr27gZh5hBvswWHb05nVKfjDgoK3diO6dmB2dsKctXAqhGSYSSXHmWqWwSYgB+o
	 dkR5ZKlzHj47A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-3-d8585a9aed80@linux.intel.com>
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
 <20260715-cbpf-jit-spray-hardening-6-12-y-v1-3-d8585a9aed80@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:56:50 +0000
Message-Id: <20260715215650.E98FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Restricting the JIT predictor flush to only cBPF programs breaks t=
he BHI / Spectre v2 memory-reuse mitigation for privileged victim programs.
- [High] JIT predictor flush is skipped for unprivileged native eBPF progra=
ms, bypassing JIT spraying and BTB hardening when `kernel.unprivileged_bpf_=
disabled=3D0`.
- [Medium] The `pr_warn_once` warning for missing predictor flushes on larg=
e allocations is dead code and masks a violation of the security assumption.
--

--- Patch [3]: [PATCH 6.12.y 3/6] bpf: Restrict JIT predictor flush to cBPF=
 ---
commit 0786ec970d8b751f7c4716434c9231f6d505e991
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Restrict JIT predictor flush to cBPF

This patch restricts the BPF JIT predictor flush on memory reuse to only
cBPF programs. It assumes that only cBPF programs can be loaded by
unprivileged users, skipping the flush for eBPF allocations, trampolines,
and dispatchers to improve performance.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8cbc26081bdb2..4304596c8fddd 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -3206,7 +3206,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
> =20
>  void *arch_alloc_bpf_trampoline(unsigned int size)
>  {
> -	return bpf_prog_pack_alloc(size, jit_fill_hole);
> +	return bpf_prog_pack_alloc(size, jit_fill_hole, false);

[Severity: High]
Does hardcoding was_classic to false here leave trampoline allocations
vulnerable to BTB poisoning on memory reuse?=20

If an unprivileged attacker previously poisoned the BTB for this virtual
address, skipping the flush could cause the highly privileged trampoline to
inherit the poisoned BTB.

>  }
> =20
>  void arch_free_bpf_trampoline(void *image, unsigned int size)

[ ... ]
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5f676320c53be..29d39092c4577 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -967,7 +967,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  		 * safe because cBPF programs (the unprivileged attack surface)
>  		 * are bounded well below a pack size.
>  		 */
> -		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> +		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))
>  			pr_warn_once("BPF: Predictors not flushed for allocations greater tha=
n BPF_PROG_PACK_SIZE\n");

[Severity: Medium]
Is this condition logically possible? Since cBPF programs are strictly
limited to 4096 instructions, they can never generate a JIT image exceeding
the BPF_PROG_PACK_SIZE (typically 2MB).=20

Additionally, if unprivileged native eBPF programs are enabled, they could
exceed the pack size but would silently bypass this warning because
was_classic is false, potentially masking that the unprivileged attack
surface is not bounded below a pack size.

>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D bpf_jit_alloc_exec(size);
> @@ -999,7 +999,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  	pos =3D 0;
> =20
>  found_free_area:
> -	static_call_cond(bpf_arch_pred_flush)();
> +	/* Flush only for cBPF as it may contain a crafted gadget */
> +	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
> +		static_call_cond(bpf_arch_pred_flush)();

[Severity: High]
Does skipping the flush for eBPF allocations defeat the BHI / Spectre v2
mitigation for privileged victim programs?

If an unprivileged attacker loads a cBPF program, poisons the BTB for its
virtual addresses, and frees it, the predictor flush is required to protect
the subsequent program allocated at the same address. By skipping the
flush when the new allocation is eBPF, the privileged victim program
might inherit the attacker's poisoned BTB.

[Severity: High]
Also, does this leave native eBPF programs vulnerable to JIT spraying when
kernel.unprivileged_bpf_disabled=3D0?=20

Native eBPF programs loaded by unprivileged users will evaluate to false
for bpf_prog_was_classic() in include/linux/filter.h. This causes the
allocator to skip the predictor flush, potentially bypassing the JIT sprayi=
ng
and BTB hardening for unprivileged native eBPF programs.

>  	bitmap_set(pack->bitmap, pos, nbits);
>  	ptr =3D (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
> =20
[ ... ]
> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index b77db7413f8c7..ea2d60dc1feeb 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -145,7 +145,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher=
 *d, struct bpf_prog *from,
> =20
>  	mutex_lock(&d->mutex);
>  	if (!d->image) {
> -		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zer=
o);
> +		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zer=
o, false);

[Severity: High]
Does hardcoding was_classic to false here introduce the same mitigation byp=
ass
for dispatchers as seen with the trampoline allocations?

Dispatcher allocations are highly privileged and contain indirect branches.
Skipping the flush on memory reuse might allow them to inherit a poisoned B=
TB.

>  		if (!d->image)
>  			goto out;
>  		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-cbpf-jit-s=
pray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com?part=3D3
