Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163120;
	b=wesB+NqyPFiCiAbdQBgvov1K8ynESt3VYMg0Wydz9TkklVtU107Inzie62uBYBZux3Qp
	 f70/SoQO3dRGpXXDRN+gbDutETwBh3nvgGFL2SnzMHNg2Do8PLdBTCkoZjWIwjw1CE0y9
	 1SJFYseu6Q767DnciwN26o2MVqBGMOvfJsc0cWGvID9NOd0+FUnxeqfUFohxsNvQnZvuS
	 qcVGOEXgu8e4RhWNRBHeKttN8qzKmTJfJNHQg2aOJ1SILGp2GJK8WvR3b4JE1SJpd8jhh
	 M/9FFki+pim5rMpSED1l9dMe8dm6DFz09EFlFiE5/Pa4rbAqgJViRTEyhAR8GB6Fmug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163120;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=xrzQ0c1uSYe+MWGbSRBKkPJVuC4OuhhgHHXtBRO7fAY=;
	b=RhDILGbn202n/KqedKkMJPQohOtExS+Z6R/9a+CygFfrliA2FlSu65RZiHK1nSVPKXh1
	 NXaXF1hx3rosloIK9qkb1WEVVwOqezD74elwK7/34qfmYH8O9pbR/2+Tnxv+DgQdqe1+z
	 WlJE8ro4sY+qv0jsmh94ERFeMN5Ppkf57pQ0HeRO4JsNZMAvbwHhTGnKXj4BN1E/45KJ4
	 LkOrq6zeIxk3srW1pYeSw6RM5m68t18eET8BI1BYsM2nBSE6+W2uuB2sTF0lgBsAIDg4Z
	 ng9sz5sWrrtd1FYWe8sPNUFv7Aeb+U4RbMFDc5vBvCWukp9tgRDrYW5zMac1CRqNzNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR9XZ3xl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4353606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR9XZ3xl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2010E1F000C4;
	Fri, 20 Nov 2026 08:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163120;
	bh=xrzQ0c1uSYe+MWGbSRBKkPJVuC4OuhhgHHXtBRO7fAY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nR9XZ3xlJokvhKlnBsgdBIRbc+55HjAgVKugz7HlydvnA71mcuThFLXB7+FLEmysb
	 2Yp2+KsJW3xh3/8+IPRQYm7RqskRTpLKR5La7RiGOw8nHrUZu9pqDgTwRyT2n7YOLy
	 s+NpbiXfBKFuZ9lAUgCuoN5VElgN9tksmeKI3pE+uNDevyk8IXuqGsg+6aOqCcogvn
	 MpjuIOjlBh4A08gZVLFih7vsdJAdDcLOeISNvdXGD1p0YRvOCpjYir49np2hJrrYJ1
	 9yUJmhglC5zPp8meblAsv/wR1qG5AI4wZf5hO6pPy0rnLeTasTSBF7pwQTPI4Uxu3I
	 EEQ++E4Afh+aA==
Content-Type: multipart/mixed; boundary="===============4406406765859651287=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7341af6e1588db0efe7da30b2d8945f345a87017a2474580710086c31b6ebc10@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-18-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-18-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 17/49] bpf: Keep a table of equations in each state
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:19 +0000 (UTC)

--===============4406406765859651287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep a table of equations in each state

TL;DR:
- Unused static helper equation_xreg_bounds() may fail the build with
  CONFIG_WERROR=y, breaking bisection
- Comment on equation count per insn looks inaccurate (nit)

> diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
> --- a/kernel/bpf/equation.c
> +++ b/kernel/bpf/equation.c

[ ... ]

> +/* An insn deletes the equations that it made before. So there are at most as many as insns. */
> +static bool append_sym_equation(struct bpf_verifier_env *env, struct bpf_equations *eqs,
> +				struct bpf_sym_equation sym_eq)
> +{
> +	if (env->no_mem)
> +		return false;
> +	if (sym_eq.insn_idx >= 0 && !env->eq_env->equation_added)
> +		forget_sym_equations(env, eqs, sym_eq.insn_idx);
> +	env->eq_env->equation_added = true;

This isn't a bug, but is the comment accurate about the bound?

forget_sym_equations() runs only on the first append of an insn visit, because
of the equation_added flag, so every later append in the same visit is kept.
Equations with insn_idx < 0 are never deleted this way.

With the later patch "bpf: Make equations from ALU, spill, fill and call
insns", one visit of w1 += w2 can append up to three equations:

  bpf_equations_after_insn() -> alu_scalar() -> alu_linear() -> alu_add()
    -> bpf_add_sym_equation()      /* sum sym2 = sym0 + sym1 */
  alu_add() -> expr_low_bits() -> add_divmod_equation()
    -> bpf_add_sym_equation()      /* rem = sym2 - 2^32 * quot */
  alu_scalar() -> bpf_add_op()     /* op rem = insn(sym0, sym1) */

The next visit of that insn deletes all three and adds new ones, so the bound
is a few per insn rather than one per insn.  Later patches also set
insn_idx = -1 on some sums, and those are limited by SUMS_PER_XREG instead.

Could the comment say "a few per insn", or explain that the equations of one
visit replace those of the previous visit?

[ ... ]

> +/* A pointer that became a scalar is another number */
> +static struct scalar *equation_xreg_bounds(struct bpf_verifier_env *env,
> +					   const struct bpf_verifier_state *st,
> +					   const struct bpf_xreg_equation *xreg_eq)
> +{

Is equation_xreg_bounds() used anywhere in this patch?  It is static and the
only occurrence of the name in equation.c is this definition, so gcc should
report:

  kernel/bpf/equation.c: warning: 'equation_xreg_bounds' defined but not used
  [-Wunused-function]

With CONFIG_WERROR=y this would fail the build at this commit and break
bisection.  The first callers are refine_sym_from_xreg(), refine_xreg() and
refine_from_reg() in the next patch, 969a062e4b35 ("bpf: Refine all related
numbers after a jump").

Could the helper be added in that patch together with its first user?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============4406406765859651287==--
