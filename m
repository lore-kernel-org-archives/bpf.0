Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431393;
	b=KreGz/yx5dp0NuByRh1Nd5nOLMi6b+cc7eos+izoKs3U8KRYU9RtOKdIj5E9VBB9x4/v
	 dhnOamYr3M2NXCf4A1HE5Ti5JXDEovFHmhHTTt1wGtlbD9srH+BDeC83sYsUUk16CDtO4
	 hrYEeeJkjvawmLYRU7d8h55RAf2Gtkl/OFN/P7ZxLle8Jf+B+x5snEDVqMstLtlWlHfo5
	 G4amS5Fl5b2aih92+87yE3aXStG3FUQez3MyOk8sGSRCzEEmbxvap68pIjyvHHpeE+Mmz
	 Dq3HecshcVzzh8wh/idLmA2DDPvqER9Mz4jcS8KBHBa6kGR3xTbZZeyqO7rcfaZMzog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431393;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=dluC4t6SqsRHAXEQ6Opy03ucV9bSsnnkCYowye1ziwI=;
	b=oDxDLINrEu3z357J7hoitgQEkS+89ixY4j8jEonMtT2fb6fyvDwTwJOUHNkjj8YEqq80
	 H6HVZv2Gli3R+m2uuP/0qIi98UMztII4v/OyXXpLHhfrq0DQgJaFyYfRRWsSBR1F4dwHE
	 VrzYTQRutLbhB3MpCJZafIWlgE3zmLgdF2PB70t60JqvdKuw7Ot8SnbnCVzzKYAhk/is0
	 450Yk96em6kkr4cZej+uCe2BpDIhzQrdfWcZvGF7Yk/G48HtqSa4cUBgq9q+GSdbaSflW
	 fvCYm5Qx9U+KnRrmSCv1JlO16HuMxrSVO8VqjyhJzxVYJ/pzBBGAOq0ptr/RGtcPK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gG/TfZfQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729ED606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gG/TfZfQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748651F00A05;
	Wed, 11 Nov 2026 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431393;
	bh=dluC4t6SqsRHAXEQ6Opy03ucV9bSsnnkCYowye1ziwI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gG/TfZfQRvHnx3pc1S4yZ9oECq2EXp3ISNdT5I+z/iF6YeSb5EVphpAX7mXeGlWtP
	 x4G/oDLSz6WbCNek8sp0E330la170AYAngiYAJ14zFmShrPdAnrKeZRZ/A+eHSJTGm
	 RDOTFIMbJQzF9Mwe9HB1mx3dnnfAzJCc5mUX2dYcqTkyHYrHtpi//utakzEjPfp0Ix
	 +z7knoLhKGY2sx2aX4rC1wdKG9XYsw3/iC8Pv/yHWj0BbP0F+bkm9leYH55rkoS5Fd
	 F87Vzz2Y4Y7mIWW/h0dzUvLxNU5GBBgytbvwNuNe8n4t94YXHLdaxMWdJFIkDS67ZL
	 izI3TUe70Ov0Q==
Content-Type: multipart/mixed; boundary="===============2727080254659733244=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <93ce5635b051a3da7eafe43dfc3708240c5cbd0ebf0680dc178d3c664e3e4b9e@mail.kernel.org>
In-Reply-To: <20261111164950.2674588-6-alexei.starovoitov@gmail.com>
References: <20261111164950.2674588-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Count a '!=' latch if the step divides the distance
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 21:09:52 +0000 (UTC)

--===============2727080254659733244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Count a '!=' latch if the step divides the distance

TL;DR: The new gcd congruence in linear_bounds() may let a 32-bit refinement
contradict it, so the next insn can trip the WARN in
reg_bounds_sanity_check(); a loadable program could panic with
panic_on_warn=1.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -4225,16 +4295,18 @@ static void linear_bounds(const struct scalar *reg, u32 max_header_count,
>  		r32 = cnum32_union(reg->r32, r32);
>  	}
>  	/*
> [ ... ]
>  	 */
> -	if (cnum64_is_const(reg->r64) && !overflow) {
> [ ... ]
> +	out->step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
> +	out->base = 0;
> +	konst = cnum64_is_const(reg->r64);
> +	step = gcd(konst ? 0 : reg->step, slope_abs);
> +	if (!overflow && step > out->step && !(step % out->step)) {
> +		out->step = step;
> +		out->base = konst ? imod(cnum64_smin(reg->r64), step) : reg->base % step;
>  	}

Can this new congruence trip the WARN in reg_bounds_sanity_check()?

linear_bounds() can now give a widened induction variable a step that is
not a power of two.  For example, 'r8 = 8 * x + 17' stepping by -4 gets
step 4, base 1, where before this patch it got step 1.  bpf_widen_scev_regs()
and bpf_clamp_scev_regs() install it with bpf_set_reg_range().

reg_bounds_sync() checks base/step only against r64, through
__update_bounds_from_step() -> cnum64_intersect_linear().  It does not
check them against r32, and the tnum that var_off gets from them (from
the trailing zeros of base/step) cannot express 'low bits are 01'.

So a 32-bit refinement that rules out every value with that congruence,
such as 'if w8 > 0xfffffffd', still looks feasible to the branch
simulation.  As the commit message says, the next insn on that path then
fails reg_bounds_sanity_check():

  "the next insn on that infeasible path trips the WARN of
  reg_bounds_sanity_check(): REG INVARIANTS VIOLATION."

That calls verifier_bug() -> BPF_WARN_ONCE() -> WARN_ONCE(), and any
program with that loop shape can reach it.  Documentation/process/
coding-style.rst says WARN*() should not be used for conditions that user
space can trigger easily, and with panic_on_warn=1 loading such a program
panics the kernel.  With BPF_F_TEST_REG_INVARIANTS the same program fails
with -EFAULT and does not load.

Could the gcd congruence be dropped, or reconciled with r32, in cases where
the latch's 32-bit refinement can contradict it?  Or should this case skip
verifier_bug() instead of raising a WARN?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43092816183
--===============2727080254659733244==--
