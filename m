Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163214;
	b=3sp6GCHpG4GFsYmJ/US8zWPJv8eXKiQ1eCuXgBzxn8v1ijRCrL0TgvX8jZS+O7cvINTc
	 xA9et6SztNmrIrrwoipX7fq913goX3DyWD9l8oS50eY9O74Q4awp7B1nT/o2TM6sHHIPx
	 EMuSShpR4UcuMms0N6e9On9OKMRofamszF2HX5lVVtDuO8R3S7NYz5Vtoi8yvPUoaPMvl
	 9eWzwJqpf4nO639v0JZJ4djKY13LFqsB3AQpI3XUBaTzu/laI3w1eWGW8TDiVXkPlVKdb
	 ci4XB5YEz8bI37AhTU9ZzpdI8FJ31YM/qlvK1lzQaa2aHGLQ+lFs8AEthQ6aQ6TEK6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163214;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QORGPcpehUnX9X5Mjlkd6U6JAomCt5z7Uj3PtsvPQB4=;
	b=vKPWJZbXQ2LiDt0Ab9cDp3+5hYysRNozwk0wYO5UOVZi6pVzjGWu5X90JETHTQCCPM0z
	 +Ckq4uLl0wKMoExMht8R2JI3v7sj4pyOrQ/CGw7EHpXkr4o/0di81479xx0kc5fb4XqUg
	 bW1jz21RT60eb3nkhKqSmjtAfd8vuD7q5geUYodNbix6yXIO0XDQmPhoPR007vcupTp/o
	 YATpjfOtmYp/dSrwZrSTj3gzxvmJIr8C29Q6c0/jvBUAju9bDRVnGNf9devUiW+3lGjTG
	 qDpKJzjZLAYrWRmrDvP+OXBD31W2H3OB3C4Q5KF+U/FerVgOMOszV51K3agdvYcS8OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jafwbvdr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936EB60A2613
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jafwbvdr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B261F000E6;
	Fri, 20 Nov 2026 08:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163214;
	bh=QORGPcpehUnX9X5Mjlkd6U6JAomCt5z7Uj3PtsvPQB4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jafwbvdrRcRXhNd5IOwW7X7y7A5uSQ9UUVwwdYFffNS2p9plVCEe6KynyHMx67sFG
	 P7GCXCFyN1aB1t2Xg8rhGQb+DwbveY02fXrUVHPSfwZSXwm4+zVYrHdoyzlkrSXsjo
	 yy9+ajM3bUQrdy8PIOs17OjsveRcGu/o1ys/Cjnq2njWVT0F4XFZWVzs08G3AFZ2gG
	 hnhmxCgOwGbyI4h3S4SK/dVDmSJVg6IWabu1rs9LwL7uDAC2w5oEMM357Dc9t0pL+8
	 YhI6eilVHAcXdhEmuunHTnNz0G20spU88dEYzYlNkg8DU3KjeMice5Z63HNYeQUAf1
	 hmVuwGbsc5SSA==
Message-ID: <sashiko-outbox-224730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 19/49] bpf: Make equations from ALU, spill,
 fill and call insns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-20-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-20-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:26:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf: undeclared bpf_equations_clean() in
  bpf_equations_before_insn()
- [High] bpf: undeclared loop variable i in add_divmod_equation()
--

commit 2ecfa437c292398a3fbabc9325d501e57c299c72
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Make equations from ALU, spill, fill and call insns

This commit records and updates verifier equations across ALU operations,
stack spills and fills, and subprogram or helper calls, and uses argument
equations to bound memory access sizes at the maximum pointer offset.

> diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
> index 16b50253a6e10..5c9a3df8ce428 100644
> --- a/kernel/bpf/equation.c
> +++ b/kernel/bpf/equation.c
> @@ -1039,6 +1039,541 @@ void bpf_equations_jump(struct bpf_verifier_env *=
env, struct bpf_verifier_state
[ ... ]
> +/* Note the operands. Delete the equations of the registers that the ins=
n writes. */
> +void bpf_equations_before_insn(struct bpf_verifier_env *env)
> +{
> +	const struct bpf_insn *insn =3D &env->prog->insnsi[env->insn_idx];
> +	u8 class =3D BPF_CLASS(insn->code), op =3D BPF_OP(insn->code);
> +	bool src_is_reg =3D BPF_SRC(insn->code) =3D=3D BPF_X && op !=3D BPF_END;
> +	bool alu =3D class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64;
> +	struct bpf_verifier_state *st =3D env->cur_state;
> +	struct bpf_equation_env *eq_env =3D env->eq_env;
> +	u32 def =3D env->insn_aux_data[env->insn_idx].def_regs, fr =3D st->curf=
rame, i, r;
> +	struct bpf_equations *eqs =3D &st->equations;
> +	bool is_ptr;
> +
> +	if (!eq_env)
> +		return;
> +	if (st->speculative || eqs->sym_cnt > 2 * eqs->clean_sym_cnt + MAX_BPF_=
REG)
> +		bpf_equations_clean(env, st);

[Severity: High]
Does this break the build with CONFIG_BPF_SYSCALL=3Dy?  At this commit,
struct bpf_equations has no clean_sym_cnt member and bpf_equations_clean()
is not declared or defined until commit "bpf: Delete the equations that
say nothing" later in the series, breaking git bisect.

[ ... ]

> +/* @expr =3D @divisor * quot + rem. Returns the expr of a new sym: @quot=
 or @rem. */
> +static bool add_divmod_equation(struct bpf_verifier_env *env, struct exp=
r *expr, u64 divisor,
> +				const struct scalar *quot, const struct scalar *rem, bool want_quot)
> +{
> +	struct bpf_equations *eqs =3D &env->cur_state->equations;
> +	struct bpf_sym_equation sym_eq =3D { { -1, expr->coef, -divisor }, { 0,=
 expr->var },
> +					     env->eq_env->insn_idx, expr->off };
> +
> +	sym_eq.sym[0] =3D bpf_new_sym(env, eqs, rem);
> +	sym_eq.sym[2] =3D bpf_new_sym(env, eqs, quot);
> +	*expr =3D sym_expr(1, sym_eq.sym[want_quot ? 2 : 0], 0);
> +	env->eq_env->divided =3D true;
> +	if (!bpf_add_sym_equation(env, eqs, sym_eq))
> +		return false;
> +	refine_syms_by_equation(env, env->cur_state,
> +				&eqs->sym_equations[eqs->sym_equation_cnt - 1], 0);
> +	for (i =3D 0; i < 3; i++)
> +		if (sym_eq.coef[i])
> +			env->eq_env->scratch[sym_eq.sym[i]].refined_sweep =3D 0;
> +	return true;
> +}

[Severity: High]
Is the loop variable i declared in add_divmod_equation()?  Without a local
declaration, this fails to compile until commit "bpf: Delete the equations
that say nothing" adds int i later in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D19
