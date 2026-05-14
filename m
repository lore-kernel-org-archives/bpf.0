Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1637F015
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803159; cv=none; b=eyGGOiMnLYq1FGheE7XUi6zVDNfe0H6SZ1PxmhFcUKBMg6v3NwFyAkyQGLnCek8psgD1StBTXjfBFSi993xQeu7+uyOaQV6kjdivQb32gVwolBq8cTM7MO6miaLuDqa4JACZCKpUXdNnCEdufqqwc0qIa3y4oTto1tzfY8xYVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803159; c=relaxed/simple;
	bh=rma+j5DMovVGBr/2qKK/beJSBDTRQXYhT1j6mSQs5qA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2QX0owrWt5JH9Mcvh/HP1e4enWJjNjC0MlfrFIFSLNuPAqdHoyyaMOlREXcj5k8CxXe0Lx5jTEU9pXjRZ864sTXiw8T6Mkojoo9Gvd4YRalvf8VAVl9uz3dvBdbH/cdIMqT3wn4oe0u6KA3+lKjcpCiV2Tl3MPPGpGdp9NLSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXvKGiKK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXvKGiKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA8DC2BCB3;
	Thu, 14 May 2026 23:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803158;
	bh=rma+j5DMovVGBr/2qKK/beJSBDTRQXYhT1j6mSQs5qA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lXvKGiKK/swZe7RbiU+5kbgnj34NqNiZcKuPsiodwP/gJD2fYQjozyo6QJNFgTuL1
	 4TvWyxqPeRH8P/wr9SDRtHgAGOeeMiBy87PM7ZuWLNgNNentKOBYV7tIFaialw5Vif
	 /6XNrzQ89StlbrDn0EidTu58MnIHyDGvxk/T8v8Wd5iYj39o7NpEoFE9QGgbGnOPWL
	 dRjIhQWImOINtbz1uXt3gGeRxB35Aovgi3HLDrWniNHArutcurspBbm4R7n7jTT/LC
	 Pt8+sSjR3Ep0t9rAT+f1FpHdvaFzQFj2sNdqf7GG78/RyeZ+crY+uHekKPNquM6FZB
	 aS63DHGKVbNGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 11/25] bpf: Reject stack arguments in
 non-JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045049.2390444-1-yonghong.song@linux.dev>
References: <20260513045049.2390444-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 23:59:18 +0000
Message-Id: <20260514235918.CAA8DC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The patch fails to prevent interpreter fallback if stack argum=
ents are used only in nested subprograms (e.g., Main -> Subprog A -> Subpro=
g B). This can lead to a kernel crash via an uninitialized R11 dereference.
- [Low] Standalone global functions with stack arguments are rejected with =
`-ENOTSUPP` without a verifier log, instead of `-EINVAL` with a descriptive=
 message.
--

commit 851a484e2b5b68983f11bc3764118f2bcba5acb0
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments in non-JITed programs

This patch attempts to reject programs that use stack arguments when runnin=
g in
the interpreter, as the interpreter does not support the BPF_REG_PARAMS (r1=
1)
register. It does this by checking for stack arguments in
__bpf_prog_select_runtime() and bpf_fixup_call_args().

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018df..958d86f0beac3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
>  		goto finalize;
> =20
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	    bpf_prog_has_kfunc_call(fp) || (env && env->subprog_info[0].stack_a=
rg_cnt))
>  		jit_needed =3D true;

Does this condition correctly catch stack arguments in nested subprograms?

env->subprog_info[0].stack_arg_cnt only tracks the main program's incoming
and direct outgoing stack arguments. If the main program calls Subprog A wi=
th
no stack arguments, and Subprog A calls Subprog B with more than 5 argument=
s,
the main program's stack_arg_cnt remains 0.

If bpf_prog_jit_compile() subsequently fails for the main program,
jit_needed evaluates to false and it falls back to the interpreter.

> =20
>  	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index ba86039789fdf..19056016eed8b 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1407,6 +1407,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
>  		verbose(env, "calling kernel functions are not allowed in non-JITed pr=
ograms\n");
>  		return -EINVAL;
>  	}

Is it possible for bpf_jit_subprogs() to succeed earlier in this function
and return 0, bypassing these new checks entirely?

If jit_requested is true, bpf_jit_subprogs() is called before this
point:

kernel/bpf/fixups.c:bpf_fixup_call_args() {
    ...
	if (env->prog->jit_requested &&
	    !bpf_prog_is_offloaded(env->prog->aux)) {
		err =3D bpf_jit_subprogs(env);
		if (err =3D=3D 0)
			return 0;
    ...
}

If it succeeds, the function returns 0 early, skipping the new loop.

Combined with the issue in __bpf_prog_select_runtime() above, the interpret=
er
could end up executing the main program and processing BPF_PSEUDO_CALL
instructions by jumping to the un-JITted instructions of the subprograms.=20

When Subprog A writes to outgoing stack slots via BPF_REG_PARAMS (r11), the
interpreter will use an uninitialized r11, potentially corrupting memory.

> +	for (i =3D 1; i < env->subprog_cnt; i++) {

Should this loop start at i =3D 0 to properly handle standalone global
functions?

For standalone global functions that are verified independently,
env->subprog_cnt is 1. Starting the loop at i =3D 1 skips the global
function entirely.

The program is still safely rejected later in __bpf_prog_select_runtime()
because env->subprog_info[0].stack_arg_cnt > 0 correctly sets
jit_needed =3D true, leading to an -ENOTSUPP return. However, starting at
i =3D 0 would emit the expected verifier log and return -EINVAL instead of
failing silently with -ENOTSUPP.

> +		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
> +			verbose(env, "stack args are not supported in non-JITed programs\n");
> +			return -EINVAL;
> +		}
> +	}
>  	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D11
