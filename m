Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3F3DCDB1
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205909; cv=none; b=YPu8nituOThvJFM/9z/SvscjO//1HQ6AquA8aoTkYwns/UWat7TjlDr8oB1A6uHGRVsypBC5uz1xLQ484pLepbteVx5UZ/C/+LtLfJ5q+P0k6Ot1w8BFFPzJz8lxePbzTLrMpnimjuO5mV+9mmLnMCHH5fBb15RomGpEchiJSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205909; c=relaxed/simple;
	bh=Jg7K9kSIvFHLxceQivYVOUr6WHMYnoauW4kAaQFQFHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KJ1P61EQkGVSDhr5Ew53/zSZZtblSiDi8G1Vb7nRApTWZAeYBKf2eWxcS1m/yyxx+XN93/ZawdvPk/WgcZPV3Hylt6zXLPdrST77m/xn5LWhAH4Rk/YNsJeYH9Gbn+OvDXbIIgQG4Foz6bMYwqreT5tjY8i+zP4oG46Tb1EinJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuA973IH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuA973IH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAA21F000FF;
	Wed, 23 Sep 2026 23:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790205908;
	bh=vI+xEU/nQfNAiC5sLxYc0BmhSu0a4aVzSizEWpZBD4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kuA973IHUOIRJiSXKsAw06ihE7pA5sy9lJtEwBdpncDIAj6I4rSXae6AjZF+NtVtn
	 YZicYwK5I/jsEZcOLGRYZRzJZ7ke23C3OhKCFdh7bSVsR1/HVhLii79jWY0igO78VE
	 oidO4TsmHxzAnUbmIoaWC5cgor0anI+A3JWJJ9qy+6eJkv1EDcWjM7OHrAL0+hGZ+b
	 GvRHdf2MQHy88TT8X2ZGfeSDKR40UBRv1U2QMJfX8+FCrJi64JJa/zrie7xedzkCqY
	 LdBDED99deUq6pZ0XME/hMpYWqB224L+m+PCYdLl1kVfPVMRhxw1+c1g3B4e1drQlG
	 RJX8iPZcZIhSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf: Detect loops that never exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923223554.562379-5-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
 <20260923223554.562379-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:25:07 +0000
Message-Id: <20260923232508.0FAA21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: bpf_throw() in subprogram fails to mark caller's loop as exit=
ed
- [Medium] bpf: infinite loops bypass detection due to flawed branches =3D=
=3D 0 check
--

commit 62aaae8d61f9848eafade71feeeed8eb13c4f0d6
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Detect loops that never exit

This commit introduces detection of infinite loops in BPF programs by track=
ing
whether a loop was ever exited during verification. It adds state tracking =
via
visit->exited and marks states as exited using bpf_scc_mark_exit().

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 22987ce070e74..39e6052922e59 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
[ ... ]
> @@ -221,6 +232,32 @@ static int maybe_exit_scc(struct bpf_verifier_env *e=
nv, struct bpf_verifier_stat
>  	return propagate_backedges(env, visit);
>  }
> =20
> +/*
> + * @st left the loop that @insn_idx of its current frame is in. The loop=
 is
> + * left when the frame that bpf_scc_visit is for leaves it. Loops in cal=
lees
> + * of that frame are part of one trip around the loop of the caller.
> + */
> +void bpf_scc_mark_exit(struct bpf_verifier_env *env, struct bpf_verifier=
_state *st, int insn_idx)
> +{
> +	struct bpf_scc_callchain *callchain =3D &env->callchain_buf;
> +	struct bpf_scc_visit *visit;
> +	u32 i, callsite;
> +
> +	if (st->speculative || !env->insn_aux_data[insn_idx].scc)
> +		return;
> +	memset(callchain, 0, sizeof(*callchain));
> +	for (i =3D 0; i < st->curframe; i++) {
> +		callsite =3D bpf_frame_insn_idx(st, i);
> +		if (env->insn_aux_data[callsite].scc)
> +			return;

[Severity: High]
Does this early return prevent caller loops from being marked as exited dur=
ing
a global stack-unwinding event like bpf_throw()?=20

If a BPF program loop calls a subprogram, and the subprogram calls bpf_thro=
w(),
the verifier processes PROCESS_BPF_EXIT in do_check():

    } else if (err =3D=3D PROCESS_BPF_EXIT) {
        /* exit or bpf_throw() inside of a loop */
        if (env->widen_loops)
            bpf_scc_mark_exit(env, state, env->insn_idx);

This invokes bpf_scc_mark_exit() with the instruction index of bpf_throw().
However, since bpf_scc_mark_exit() returns early here if any caller frame
is in an SCC, it fails to mark the caller's loop as exited.

As a result, when the loop's entry state is fully explored, maybe_exit_scc()
finds visit->exited =3D=3D false and could falsely reject valid programs.

> +		callchain->callsites[i] =3D callsite;
> +	}
> +	callchain->scc =3D env->insn_aux_data[insn_idx].scc;
> +	visit =3D scc_visit_lookup(env, callchain);
> +	if (visit)
> +		visit->exited =3D true;
> +}
[ ... ]
> @@ -1462,6 +1499,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
>  		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT=
)) {
>  hit:
>  			sl->hit_cnt++;
> +			/* what follows the old state was seen, it may leave the loop */
> +			if (env->widen_loops && !sl->state.branches)
> +				bpf_scc_mark_exit(env, cur, insn_idx);

[Severity: Medium]
Does this logic correctly handle paths that only loop back and prune?

The assumption here seems to be that an explored state (branches =3D=3D 0) =
must
have successfully left the loop. However, a state can reach branches =3D=3D=
 0
simply because all its paths looped back to the widened loop head and prune=
d.

If an infinite loop explores such a path, and a subsequent path hits one of
the first path's intermediate states, this logic will prematurely set
visit->exited =3D true. Will this bypass the verifier's static infinite loop
detection and incorrectly accept the program?

> =20
>  			/* if previous state reached the exit with precision and
>  			 * current state is equivalent to it (except precision marks)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923223554.5623=
79-1-alexei.starovoitov@gmail.com?part=3D4
