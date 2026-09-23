Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBE349B19
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207313; cv=none; b=noixlrdycLby92s8iqNOZWqFMEAxvszTcho3ZHg5wEPwV8d4KIgzrBVnm7oxMGBtY1PsVEo+b1B+Aj7e5jfNqri2t8G3SsOYIF+saOjUX6Aqvmeij1bpsmrkhnncy31XDF6dmyk3Q59GqsMOcpzpIL8kRllYskQLPvJIoNx1pDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207313; c=relaxed/simple;
	bh=PqfjZAuYS/bumMEv9INpMTe5IB6+ox+WIXhs8fZN98I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VchVURMzTW+rUuTPeFwh2OdrBqpLlKxnHEFpbTBMhhsx3mxkqKDR4egyDBWvjC3zd0zsEpVK5lPmHLmE+FRE8kA7L+jU0/pU/Ni0HjenRn/lm1cLcISS6BeGSR3ro0+6JCyOFExnWOZRikrUtXBSGz2G1zOdcUkdQDfZeexgrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TohOG2er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TohOG2er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7083F1F000FF;
	Wed, 23 Sep 2026 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207312;
	bh=vlnyXk5C2ZjNpYyq5qSmUKSRon4Lo9S9+fGsQrtCocY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TohOG2erFnnzgxibyZ1rm7Ohu8Pe/6FLntk1bR4xfCzrTbcno5/ZdF+39uMLUjPqN
	 I+ynpHNl5AtWksfZMwqtq5WdjAMC0wwSH1IiTTgFMEKxZeg348t1nGD5emxD+uehSt
	 bl5pEvPUInERZBCNrc8wbIyHRNFlC1YAJUxHJLNaLGX7NpTxL3CeIZmyINN6mY7gy5
	 92CEozLYK0NHSzNkNDzCzpHbzCBphqx4ywgr3UmqN4vtXj9oYkLWCEnuUi4Ik7FTi2
	 vP9dVAAQYoN1d9d0T6mfeh+xvhPJ4nQIjOMTXLZacHXtLt3wrXPYg3wnIs7Xs22kK5
	 sljDDIo9eYXlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/8] bpf: Add may_goto to loops that are not
 walked to the end
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923223554.562379-6-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
 <20260923223554.562379-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:48:32 +0000
Message-Id: <20260923234832.7083F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: kernel panic via interpreter fallback for unbounded loops
--

commit a389d24a8c603adc4356e3e547a38f623577782d
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add may_goto to loops that are not walked to the end

This commit bounds BPF loop iterations at runtime by injecting a may_goto
instruction on the back-edges of loops that are not fully walked. If the
loop budget is exhausted, execution aborts by terminating in bpf_throw().

[ ... ]
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 2add8001c3ec3..2b965fa4bacc0 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -1537,6 +1537,143 @@ static int add_hidden_subprog(struct bpf_verifier=
_env *env, struct bpf_insn *pat
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> +/*
> + * The walk with widened loops is done. Loops where some state came back=
 to
> + * a state that was still walked were not walked to the end and have to =
be
> + * bounded at run time.
> + */
> +int bpf_commit_loop_guards(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	int i;
> +
> +	for (i =3D 0; i < env->prog->len; i++) {
> +		if (!aux[i].scc || !test_bit(aux[i].scc, env->scc_converged))
> +			continue;
> +		if (aux[i].guard_impossible) {
> +			verbose(env, "loop with back-edge at insn %d cannot be bounded\n", i);
> +			return -E2BIG;
> +		}
> +		if (aux[i].guard_pending) {
> +			aux[i].loop_guard =3D true;
> +			env->seen_exception =3D true;

[Severity: Critical]
Does this sequence allow a kernel panic if the BPF program falls back to the
interpreter?

When the verifier implicitly injects a bpf_throw call as a runtime loop gua=
rd
by setting env->seen_exception =3D true here, it doesn't appear to set
env->prog->jit_required =3D 1.

If the system falls back to the BPF interpreter, for example due to memory
constraints or program size, the interpreter will hit the loop guard and
execute bpf_throw(). When this happens, arch_bpf_stack_walk() cannot find a=
ny
BPF JIT frames, returning without setting ctx.aux and leaving it NULL.
bpf_throw() then unconditionally dereferences ctx.aux, which triggers a NULL
pointer dereference.

Should env->prog->jit_required =3D 1 be set here, similar to what happens f=
or
explicit bpf_throw kfunc calls, to prevent this fallback crash?

> +		}
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923223554.5623=
79-1-alexei.starovoitov@gmail.com?part=3D5
