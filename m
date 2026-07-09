Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFF3B6354
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636640; cv=none; b=PU6PkFf1rOq02t6a4BsnCbtL/9iGB1NiAT+GnBQ8qXatolIXPt1l5D/MgHTjP2rra+vleHLVlSsWs75ngN6KCnr9sOOn2ngLCoLsoLJ1ROaUMV5MKC7ScwSJ0BhnO2P/kIKFaDXgVjC21kW33GvLu5b7pnkrMeJ+3vKKc6eDz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636640; c=relaxed/simple;
	bh=c4cGBRKEM9VXzwB6u9iE+Uyo++Qrnn4fMvGHWydzuE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGbaKLhmPRvHFeV6A1F+pf4l8Hw9NQJfGvo4ddpupfmcYwgjiLprqt4kKGVClett4ia2e6CizGnEPoGf5OJ0/oo1CWBcBVRs5Mf//8nkUwOYxeH3TAZxBMnkCvc2GviIbkpGFUqYfHrks8Mo+6MLcSAcrPGPLfJMjJevteJW6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOkYiWfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOkYiWfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6291F00A3F;
	Thu,  9 Jul 2026 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636637;
	bh=w8ZxxBzqDzuAlymX9PQPzpS1o0vgaTLnf0ehnqVLvHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOkYiWfoZIG3uqvqTfy7IoY+1W4009ampMMrpwIiI2WdP3fDjuUO5Jmd+RekiXHwR
	 V+AX0j3sjMXd8QhN0J7P43EK4W5NCGiwRoUnoRLRVZOnL+F0KeB2lFPfR5rxk7c/x+
	 Hl71du+OTQ+W4iBiJvENNSfRH9RIJA8KipdCvbTFb1wmuCMxCsRfSgMh+o8LikXwrU
	 d+dUUYckIhudmRd90SpEZUWK81+73i3J3RV69xd+3PLpNIj4QTyqudmQpUbLVwni+5
	 0Ip+2pczHNTTqsogzr7u04O5GtNqRIIMEwZoW6HMBRYUvvxWeElhQSniS94K3YpCpD
	 XVbUXzQo9spEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT
 spraying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
 <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:37:15 +0000
Message-Id: <20260709223717.3C6291F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Security Mitigation Bypass: Indirect branch predictor flush is ski=
pped for large BPF allocations and when packs are freed to the system pool.
--

--- Patch [1]: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spr=
aying ---
commit 3f99052f0f28956849dd13889694d621bc46be60
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Support for hardening against JIT spraying

This patch introduces the bpf_arch_pred_flush mechanism to flush indirect
branch predictors before reusing JIT memory. This aims to protect new BPF
programs from using branch predictions left behind by previous programs that
occupied the same space. However, it intentionally skips flushing for large
allocations and when returning packs to the system pool.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 6aa2a8b240306..f49b9b23f95e6 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -941,6 +951,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hol=
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
>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D bpf_jit_alloc_exec(size);

[Severity: High]
Does skipping the flush for allocations larger than BPF_PROG_PACK_SIZE leave
large BPF programs and Kernel Modules vulnerable to poisoned predictions?

If an unprivileged attacker loads cBPF programs to fill a BPF pack and trai=
ns
the indirect branch predictor, they leave poisoned predictions for that mem=
ory.

When the attacker unloads the cBPF programs, the BPF pack is freed. If a
privileged user subsequently allocates a large BPF program, this new
allocation might reuse the freed memory.

Since bpf_prog_pack_alloc() explicitly skips bpf_arch_pred_flush() for these
allocations, wouldn't the privileged victim program inherit the attacker's
poisoned predictions?

Additionally, does freeing an empty pack back to the system pool bypass the
mitigation completely?

When a pack is fully emptied in bpf_prog_pack_free(), it is returned to the
system pool without a predictor flush:

kernel/bpf/core.c:bpf_prog_pack_free() {
	...
	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
				       BPF_PROG_CHUNK_COUNT, 0) =3D=3D 0) {
		list_del(&pack->list);
		bpf_jit_free_exec(pack->ptr);
		kfree(pack);
	}
	...
}

Could Kernel Modules or large BPF programs that subsequently allocate this
memory via execmem inherit these poisoned predictions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-cbpf-jit-s=
pray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com?part=3D1
