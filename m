Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C22356D9
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152004; cv=none; b=kkj8r+qIUH10xWhUwJ0sc/O+jqnOyqjThpn4fD7xJgPh5A23i2MI6XuiPNb2IDtk0wVwy1RTnt3T7T+Jikeezcx5rdvn4EYdXMozck87NcPeiFmXadjBy+l+Cf8aTFRxnj/4JIO9PJ8DDhOZsnQeJNQfhJtg37StXuJoCVqhi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152004; c=relaxed/simple;
	bh=jlQU3rkwzcGWUbsPL3DpLL7eDUIIas0fmsL8Cvnbc+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7aLTTQCmIHe2OApUEqmjEKdcEbJwOjUj9gxeL4KlgZRTwZiO42RQAkhwDitI9ASGoUy4S8xJX9fZigwPsJLjgjDwSVpcDeYfjNtv+uLc+lAYT+ySd8O334SUneyycCO0BX8Nwg/gnIMMH0fnD/tCZfK5b72eqK0gfImJ7UdhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1jYFM+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1jYFM+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE01F000E9;
	Wed, 15 Jul 2026 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152003;
	bh=Wd61CyD7h11bWj4VM7FMtDnv+/cEYT9Jl4tWyIARuRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1jYFM+zR6V7ptze13t67T0TNXHw9MZYCtfRUFwbzAs2t64rYPu7RHLhVMN7eQ6Jf
	 aqNsAVfFeSTeVHhNk6nVg/uQwISDOv+ZdaJHrNSCIF8puDpAxAYuXKKlFk1GLDJind
	 I1h5Xo8xN7tKD343Qq+6G05oJXGR5zTNS0y3moVYhbO4kz+0XCijed9NDO/y1TGUU1
	 ri8Xo2FcsaVqjjRjEVGq4T5IJzTKtr9lP1Bg1Lakgb+ItbYHbcFXOvtByiShA2Rgsk
	 h1rM8uuYjizjeBO3hMywEiAfWWRZlrTc8DgXmzKslH6qr9LvGDRxwAV6CLlU7LaTTe
	 5QJ+bvVmDXJ7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 1/6] bpf: Support for hardening against JIT
 spraying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-1-d8585a9aed80@linux.intel.com>
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
 <20260715-cbpf-jit-spray-hardening-6-12-y-v1-1-d8585a9aed80@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:46:41 +0000
Message-Id: <20260715214641.BDDE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypass of JIT spraying mitigation for large BPF allocations and tr=
ampolines due to shared virtual address pools.
- [High] Local-only branch predictor flush fails to protect against cross-C=
PU Spectre v2 attacks on SMP systems.
--

--- Patch [1]: [PATCH 6.12.y 1/6] bpf: Support for hardening against JIT sp=
raying ---
commit e0ddacc731d8368cbba4bdc358a8403f702c92da
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Support for hardening against JIT spraying

This commit introduces a branch predictor flush mechanism before reusing
JIT memory to mitigate indirect jump prediction poisoning. It adds a static
call for architectures to define their flush routine and skips flushing
for allocations larger than a single pack size.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -951,6 +961,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hol=
e_t bpf_fill_ill_insns)
> =20
>  	mutex_lock(&pack_mutex);
>  	if (size > BPF_PROG_PACK_SIZE) {
> +		/*
> +		 * Allocations larger than a pack get their own pages, and
> +		 * predictors are not flushed for such allocation. This is only
> +		 * safe because cBPF programs (the unprivileged attack surface)
> +		 * are bounded well below a pack size.
> +		 */
> +		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> +			pr_warn_once("BPF: Predictors not flushed for allocations greater tha=
n BPF_PROG_PACK_SIZE\n");

[Severity: High]
Does skipping the flush for allocations larger than a pack leave them
vulnerable to poisoning?

Since all BPF allocations and trampolines share the same global virtual
address pool, could an attacker load a small unprivileged program to poison
the branch predictors for that virtual address, and then free it?

Once the empty pack is freed and its virtual addresses return to the
global pool, it seems a large privileged BPF program or trampoline could
be allocated that exact same virtual address range. Because large allocatio=
ns
explicitly skip the flush here, would the privileged program end up executi=
ng
using the attacker's poisoned branch targets?

>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D bpf_jit_alloc_exec(size);
>  		if (ptr) {

[ ... ]

> @@ -981,6 +999,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  	pos =3D 0;
> =20
>  found_free_area:
> +	static_call_cond(bpf_arch_pred_flush)();

[Severity: High]
Is a local-only flush sufficient to protect against cross-CPU attacks on
SMP systems?

Branch target buffers are typically per-CPU. If an attacker executes a
program and poisons the predictors on CPU B, and a new privileged program
is subsequently allocated and flushes on CPU A, it appears CPU B's
predictors would remain poisoned.

If the victim program later executes on CPU B, for instance via a network
packet in softirq context, could it reuse the poisoned predictions left
behind by the attacker?

>  	bitmap_set(pack->bitmap, pos, nbits);
>  	ptr =3D (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-cbpf-jit-s=
pray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com?part=3D1
