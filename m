Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCD4499A4
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636539; cv=none; b=raxtPpXXw4DawOpo5gRVkp4owDsfKfiSvF2ckdWAufDsn2gLo0tJxhm2XSNk7u4YZEJJRcHYfs19v5uNmB4ZcTdRFDVOe8xrF3Vn5M/H+RmoagZIhh3AzPORcfdaSK/hnXhRrFDsJozqXVyLDYTgLGlNSlRNJwkrwMBX33jW7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636539; c=relaxed/simple;
	bh=b4T8f4Zm+2DMsfYCshoe3irI5zfsmjwIarYoJf1mz4I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uYpDLAdS7vt2+Erg7hqa4qi0nrqlj23bt947yPnZGD0osLzKqrWpVNbtgmCQBccfzwejfnxq5gxvMJXb7M/gAizBnDC1hVyDe86A4JzAOMPOHZ037ZmqKNyTig4qIH3R+t/mdQEK6jS/qvG3rdgWeACotHCV0WV3uwyKw8WHA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBKxUwRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBKxUwRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D189A1F000E9;
	Thu,  9 Jul 2026 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636538;
	bh=7DUjyHkRG0XL05owURiwbMhi0FFrY7SmZqFH0Djc/RM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBKxUwRvdIUh7mu6FKfI22NAZey7NDf5axuWHMAeipJsHDJitCDyzzm7VRl+P9PQo
	 rLRX17q0Xykt/019ZX21JKrOy2UMnLNYiMoHEhG5/un71WM2iYkxHm+lAqLHBqd2Vg
	 MieNNAxuSGBNTHUG4bOOYEcOor/gganwF0bvYL3+DdR9lnSWCfvjv/m0nC/d+Q9DRV
	 eISgmYYuZZOIzqQJ03cOJcYZu+r4B9CMMmrzDuQ8O4N+GDExZ917qfQEJ/8jiFiLto
	 cBUQl4q0VUMl1o2jT9Mw8HPoKRQTfzcfIVBtdWIi5QHh8IPB9sOgYOQGT5jmOCR4UL
	 vrM6mYUrWrUEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.1.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-3-5ac5a2d6797f@linux.intel.com>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
 <20260709-cbpf-jit-spray-hardening-7-1-y-v1-3-5ac5a2d6797f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:35:37 +0000
Message-Id: <20260709223537.D189A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Restricting JIT predictor flush to cBPF bypasses Spectre v2 mitiga=
tions for unprivileged native eBPF programs.
--

--- Patch [3]: [PATCH 7.1.y 3/6] bpf: Restrict JIT predictor flush to cBPF =
---
commit 96d12fd545f6cf1b750e18b7bd03c2fd3abf27be
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Restrict JIT predictor flush to cBPF

This commit restricts the branch predictor flush on BPF JIT memory reuse to
only execute for cBPF programs. The rationale provided is that only cBPF
programs can be loaded by an unprivileged user, whereas eBPF is privileged
by default.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index f49b9b23f95e6..1b7e74e63bd4b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -957,7 +957,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  		 * safe because cBPF programs (the unprivileged attack surface)
>  		 * are bounded well below a pack size.
>  		 */
> -		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> +		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))
>  			pr_warn_once("BPF: Predictors not flushed for allocations greater tha=
n BPF_PROG_PACK_SIZE\n");
>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D bpf_jit_alloc_exec(size);

[Severity: High]
Does this bypass the Spectre v2 mitigations for unprivileged native eBPF
programs?

If kernel.unprivileged_bpf_disabled=3D0 (which is the default when
CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set), unprivileged users can load nati=
ve
eBPF programs such as BPF_PROG_TYPE_SOCKET_FILTER. Since these are not cBPF,
was_classic is false, and the warning logic for large allocations explicitly
bypasses the check in bpf_prog_pack_alloc().

[ ... ]
> @@ -989,7 +989,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  	pos =3D 0;
> =20
>  found_free_area:
> -	static_call_cond(bpf_arch_pred_flush)();
> +	/* Flush only for cBPF as it may contain a crafted gadget */
> +	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
> +		static_call_cond(bpf_arch_pred_flush)();
>  	bitmap_set(pack->bitmap, pos, nbits);
>  	ptr =3D (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);

[Severity: High]
For unprivileged native eBPF programs, the predictor flush during memory pa=
ck
reuse is also skipped here. Could this allow an unprivileged attacker to lo=
ad
a crafted JIT gadget into a reused memory chunk and exploit leftover branch
predictor state from previously executed privileged BPF programs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-cbpf-jit-s=
pray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com?part=3D3
