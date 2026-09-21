Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633093CC32E
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025659; cv=none; b=Oo3AbKkpxlC5g/ibnCEwgkGftfDWCAhVZXy3UnSq2eQnO831bU2n5u6eIgQU+YyAGWIdK+hFL1AXOnhs7eeQKzgNVsgvJJvfrhtV/gjDl6caSpamXyjV9XkPiFGS/6RdcD771xoRjs7YJ7qMPUYPZ/sjZvq4gkkqKe+p2rf3bMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025659; c=relaxed/simple;
	bh=ZksmvrZCmevSMarXX4eH25EiNs+9539ADZ4qvMRjGfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c344NuK6u6uneY+S7KB+t7xy74tydxnyvaH3xW6YFFwU2FQJ/01zgrLLG37YWhTfCn636qXGGDhr4LQKN1BB56wdK7tHCAwFVrhsVqS0Fos5JmOGHMvKP4fWHusihyvZM62wRswoHE23eb4eVfBnCI9VrNnhAHQHwvV4dHUJVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjwcqUzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjwcqUzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23021F000FF;
	Mon, 21 Sep 2026 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025658;
	bh=ncAJyelRRbA2dnFp3xTGkqxyVnSfZqAcIQtOin6CAOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjwcqUzRDw6GlWyedPMWsbxqZkK/O/pPSR4nGVAarceI44ubSK1RA5mKWwzZZjsMl
	 fMIEyRQnMtaLjiwh+7COAtJUgRLM+PENU5Y+S5XhcfWqAuKdkk9/ID1+BwVgTh+SiX
	 BjqoYMgY/O2PLjXfHmuzu10UWysv/xF6tzp7gBS958YD8mQS02iz084QYyf6wLgN5G
	 nFZcitP7EY7KDpv4JH2UXtq8mMQYFVD1ymvQIeAd6kiZHNOhH2I6QZjHeIuqXzxD1H
	 WwkBCCkvSauFZNN+4THry0QjodgMyJ7gbi+4RiJ7VlIROoeAePuKpoOD4BzWhGlbhh
	 zXHSZBo81nKOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921210109.1719713-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210109.1719713-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:20:57 +0000
Message-Id: <20260921212057.D23021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: kernel stack leak via >5 arg BPF-to-BPF calls in exception pa=
ds
--

commit 961251cb485953d7f6bd99ead3712d0e8268b8eb
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Refuse exception cleanup shapes bpf_throw() cannot dispatch

This commit adds verification logic to reject specific control flow shapes=
=20
that bpf_throw() and the exception cleanup handling cannot safely dispatch.=
=20
It performs post-CFG checks using bpf_check_cleanup_exceptions() to inspect=
=20
pad reachability, catch pads, and unwinding safety.

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 67af78baa558d..da8fa6eb7e4b9 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c

[ ... ]

> +static int cleanup_check_pad_insn(struct bpf_verifier_env *env, u32 i)
> +{
> +	struct bpf_insn *insn =3D &env->prog->insnsi[i];
> +
> +	if (bpf_helper_call(insn) && insn->imm =3D=3D BPF_FUNC_tail_call) {
> +		verbose(env,
> +			"bpf_tail_call() at insn %u is in an exception cleanup landing pad\n",
> +			i);
> +		return -EINVAL;
> +	}
> +	/* A BPF_LD_[ABS|IND] can leave the frame through its epilogue. */
> +	if (BPF_CLASS(insn->code) =3D=3D BPF_LD &&
> +	    (BPF_MODE(insn->code) =3D=3D BPF_ABS || BPF_MODE(insn->code) =3D=3D=
 BPF_IND)) {
> +		verbose(env,
> +			"BPF_LD_[ABS|IND] at insn %u is in an exception cleanup landing pad\n=
",
> +			i);
> +		return -EINVAL;
> +	}
> +	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
> +		verbose(env,
> +			"insn %u passes an on-stack call argument in an exception cleanup lan=
ding pad\n",
> +			i);
> +		return -EINVAL;
> +	}
> +	if (bpf_pseudo_kfunc_call(insn)) {
> +		struct bpf_call_summary cs;
> +
> +		if (bpf_get_call_summary(env, insn, &cs) &&
> +		    cs.arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS) {

[Severity: High]
Does this omit checking BPF-to-BPF calls (bpf_pseudo_call) for on-stack
arguments?

The JIT executes exception cleanup landing pads on the unwinder's stack (rs=
p),
while rbp points to the BPF frame. This check restricts kfuncs from passing
arguments on the stack, but seems to miss BPF subprograms because
bpf_get_call_summary() returns false for them.

If a pad calls a BPF subprogram requiring more than 5 arguments, could the
callee read uninitialized kernel stack memory belonging to the unwinder's
caller?

> +			verbose(env,
> +				"insn %u passes an on-stack call argument in an exception cleanup la=
nding pad\n",
> +				i);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}

[ ... ]

> +static int cleanup_mark_pad_bodies(struct cleanup_ctx *ctx)
> +{
> +	struct bpf_verifier_env *env =3D ctx->env;
> +	u32 i, sp =3D 0;
> +	int ret;

[ ... ]

> +	while (sp) {
> +		u32 j =3D ctx->stack[--sp];
> +		enum cleanup_insn_kind kind;
> +		int next, target, sub;
> +		u32 start, end;
> +
> +		ret =3D cleanup_check_pad_insn(env, j);
> +		if (ret)
> +			return ret;
> +
> +		sub =3D cleanup_subprog_of(env, j);
> +		start =3D env->subprog_info[sub].start;
> +		end =3D env->subprog_info[sub + 1].start;
> +		kind =3D cleanup_succ(env, j, start, end, &next, &target);
> +
> +		if (kind =3D=3D CLEANUP_INSN_CALL) {
> +			/* check_subprogs() registered every call target. */
> +			int callee =3D cleanup_subprog_of(env, j + env->prog->insnsi[j].imm +=
 1);
> +
> +			if (env->subprog_info[callee].might_throw) {

[Severity: High]
Since cleanup_mark_pad_bodies() allows BPF-to-BPF calls in landing pads as
long as they don't throw, should it also verify that the callee does not
take on-stack arguments?

For example, by checking if env->subprog_info[callee].arg_slot_cnt <=3D
MAX_BPF_FUNC_REG_ARGS?

Without this check, a subprogram requiring more than 5 arguments could be
called, potentially leading to the kernel stack data leak mentioned above.

> +				verbose(env,
> +					"cleanup landing pad calls subprog %d at insn %u, which can throw w=
hile an exception is in flight\n",
> +					callee, j);
> +				return -EINVAL;
> +			}
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921210033.1715=
000-1-yonghong.song@linux.dev?part=3D7
