Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7C20DD51
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992294; cv=none; b=uQwR7mHG9zreMSuEqi7mIuAJt+ehmdULKFTN5jHayc5m6kmafUtGZZt+CM2ie1gljhfxL/uX/4xRVpCCsbXDNJCkYUMk40jQZRKQeW7AHvx8IVkmHpkwlklrUMR/2zpc6kriIOK3vglO1/Fv+A8TfXl0ww+R+6OPGJR0SVNkgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992294; c=relaxed/simple;
	bh=hsD/Qs5312yqG0I7u1kNX/1JW78HsXkcVLsYHzspNok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T4p0MIpmrW45GWfiT3Kpp2I9996t6XTp4b4RyesUKOMt3QX6GHGS6pHhZ9lL1mHxQpXZOZTV3PbwTkj4aWVJ77OiTHYRh64brKciPvmYxhH4zYQCXswd6gZwzVPwl8XmLUSJSTJFfp3g62P/6Of0w9giWtUEcxId+qxeScwq7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaxyfFdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaxyfFdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7E61F000E9;
	Tue, 14 Jul 2026 01:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783992293;
	bh=mspRl3hp7xX88o73A1Y4fNuuvS9f5NucUWps5KJXTdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WaxyfFddfG5/ssxQJlmSpR8OIdfWgcdS8IWIZLDlaVXSJb9jtHBQCGnbDSmZ0RaDJ
	 OkI3sxyI44loYNh+JcNV4EhrZ5ybkoKsEOSKAnAQsQ1/9tccpADH3fM2gjc7IUfZWv
	 ofLhdynD6SZHiHD/OlFIOvbYB0wuAP6t3b2oOT5A47ZzuATv8TKGYSwclJ5l4w2b7+
	 8D0nk1ch3Yeksof0Zg+qccW+cTSUs72YM5hBS30qXK7VBlg3FDo4216YnspA0uAjp/
	 LmzKuGNjszBsKXTC9daN3E79UdGZZpZTxiwMbzuet+jsnoqbhJaigLKD7OBvyqvj9D
	 f1kE346SMncSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-3-755f60c55705@linux.intel.com>
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
 <20260713-cbpf-jit-spray-hardening-6-18-y-v1-3-755f60c55705@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:24:52 +0000
Message-Id: <20260714012452.EC7E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypass of Spectre v2 / Branch History Injection (BHI) mitigation f=
or unprivileged native eBPF programs.
--

--- Patch [3]: [PATCH 6.18.y 3/6] bpf: Restrict JIT predictor flush to cBPF=
 ---
commit 33a895ebe7da61c93f5b498141c865b22c5d29e7
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Restrict JIT predictor flush to cBPF

This commit modifies the BPF JIT allocator to only perform predictor flushes
on memory reuse for cBPF programs. It skips the flush for eBPF allocations
under the assumption that only cBPF programs can be loaded by unprivileged
users.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -939,7 +939,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  		 * safe because cBPF programs (the unprivileged attack surface)
>  		 * are bounded well below a pack size.
>  		 */
> -		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> +		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))

[Severity: High]
Does this inadvertently suppress the warning when unprivileged eBPF is
enabled?

If an administrator sets kernel.unprivileged_bpf_disabled =3D 0, unprivileg=
ed
users can load native eBPF programs (like BPF_PROG_TYPE_SOCKET_FILTER). For
these native eBPF programs, was_classic evaluates to false, which seems to
improperly suppress this warning for large allocations.

>  			pr_warn_once("BPF: Predictors not flushed for allocations greater tha=
n BPF_PROG_PACK_SIZE\n");
>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D bpf_jit_alloc_exec(size);
> @@ -971,7 +971,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  	pos =3D 0;
> =20
>  found_free_area:
> -	static_call_cond(bpf_arch_pred_flush)();
> +	/* Flush only for cBPF as it may contain a crafted gadget */
> +	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
> +		static_call_cond(bpf_arch_pred_flush)();

[Severity: High]
Can an unprivileged attacker use JIT spraying in native eBPF to execute a
speculative execution attack (Spectre v2 / BHI) here?

Since native eBPF programs loaded by an unprivileged user (when
kernel.unprivileged_bpf_disabled =3D 0) will have was_classic =3D=3D false,=
 the
predictor flush is entirely skipped. This appears to leave unprivileged
native eBPF exposed to JIT spraying attacks, as the mitigation is completely
bypassed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-cbpf-jit-s=
pray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com?part=3D3
