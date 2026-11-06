Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939686;
	b=rf8yqauFSh4B0h6XPKkFxhHVcXgroxnDCYroKs9ijy18bU8RNEWjv9TFUcl5FB9LkFbj
	 N6twz4HKBOp53nl1IDpBL7LqQ52jIW3ww30d+w7+JrZ+mJXC/8aUSXaWETMJLOIMlNLQ9
	 BFdLfNcGW5OuFVw/70qf4EmNn0UPfjG+LR/kWbMZ+Zly2o/7ShfkLittYH3SXwdpp2Etc
	 axRKVveplGuejsUySD5Lbs/kPScIcLrPnwdYxKAXzo4MNpa/zQ4AvQHLgqDYtjSGpt/Te
	 gTlSMi3BZ6kphezl4oy67uRDH831fVAh0LfYFZOWCgET0tzD26elww9hmx7OMLcqrew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mOQrMiMrvYPxB4o63O1pdsi5gQP3q43je6D2ckl0Szs=;
	b=LWeKw9aAqc/Jl5/mz2UES8rpnyu4kppHSOmmHtJM1IkD4jB8zQ2JQpt+ib1RAejmkS7N
	 BWO68XuYGLMtMQs7jdqFYBKmhBUbkbRtsFGFekf26cv+3hI+yKk7ca8ASQp/rqnw1fhfJ
	 KhTPQLqDVmcmYq8cNDjFt5CIfyVLLZU/bs0v0O6VrJbNQoZ5JIg4UnEOizQyzO98ET+Om
	 aQwaNIYliTgnm0W47PmX6CDpFk2enY7FNp1DzAmr/W8lH0yx35Qp9vE/KKfLdHWNye1ae
	 7BpuBLuNcV6Jf50fykZBXV/Yc+o9zglXG+X7fjRXliggEz04Nco0iaYTSGMzDtc417g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jLgaJ+ew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F16606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jLgaJ+ew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB811F008A2;
	Fri,  6 Nov 2026 04:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939686;
	bh=mOQrMiMrvYPxB4o63O1pdsi5gQP3q43je6D2ckl0Szs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jLgaJ+eweHUuHc3RbO+k4TTe2lF0P0rirLV8vCsnEyFk7vk0844PJ1udf/rgZoTwT
	 WOtbUhVpmD5dAWPa+7hdhbCNqXraYXgwr6hDe1WLCnBYNYLdCR7hlJVWPTD9t0JGrr
	 JmPWPsB1Xz3EGikRrXLkVfmvMGDVJlHX3coejt+pMS6und7gzija4SelOYsMl2opZ3
	 limHBZvChWelfat6RM7d28hS6qh3puyxcECq/0g9jN41glvA+34atw/N9PixxSn2Gb
	 pUydhw70+kP76BdYICR/74xzB1EBszaZdHVdC98lQGtN5vDYT940pU1ZiNUnn6u0y4
	 B1+/PjQNRhHjg==
Message-ID: <sashiko-outbox-200735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 16/45] bpf: Make the state after a call from
 the caller's state and an exit state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-17-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-17-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:34:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing exit->speculative propagation in bpf_flow_return()
--

commit 7ddf7363f0596e710519469bc5585f001bf30b01
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Make the state after a call from the caller's state and an exit state

This commit introduces bpf_flow_return() and BPF_INHERITED_ID to construct
the caller's post-call verifier state from the waiting caller state and the
callee's exit state when verifying a static subprogram on its own. Held
reference IDs are mapped to positional names at subprog entry and restored
or refreshed upon return, falling back to caller-context verification if
inherited references or locks were released.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 07a9097e3d4e1..d8543eb8bb195 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11748,8 +11748,146 @@ static int push_callback_call(struct bpf_verifi=
er_env *env, struct bpf_insn *ins

[ ... ]

> +int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_st=
ate *caller,
> +		    const struct bpf_verifier_state *exit, int call_idx)
> +{
> +	struct bpf_func_state *frame =3D caller->frame[caller->curframe];
> +	const struct bpf_func_state *callee =3D exit->frame[0];
> +	struct bpf_idmap *idmap =3D &env->idmap_scratch;
> +	u32 caller_rcu =3D caller->active_rcu_locks, caller_preempt =3D caller-=
>active_preempt_locks;
> +	struct bpf_reference_state *held;
> +	struct bpf_reg_state *reg;
> +	u32 i, j, nregs, nheld, kept =3D 0, id;
> +	int err;
> +
> +	if (exit->unwound && !bpf_is_unwind_goto(&env->prog->insnsi[call_idx + =
1])) {
> +		verbose(env, "unwind_exit, but no unwind_goto after the call at insn %=
d\n",
> +			call_idx);
> +		return -EINVAL;
> +	}
> +	caller->unwound =3D exit->unwound;

[Severity: High]
Should bpf_flow_return() also propagate exit->speculative to
caller->speculative here?

When !env->bypass_spec_v1, a non-speculative caller entering a static
subprogram verified on its own has caller->speculative =3D=3D false. Inside=
 the
subprogram, a statically predicted conditional branch or pointer ALU
operation can spawn a speculative path via sanitize_speculative_path() ->
push_stack(..., true) with speculative =3D true.

When that speculative path reaches BPF_EXIT, process_bpf_exit_full() ->
exit_func_on_its_own() -> bpf_flow_exit() -> flow_apply_exit() calls
bpf_flow_return() with exit->speculative =3D=3D true and caller->speculativ=
e =3D=3D
false, and then delivers the resulting state to call_idx + 1 with
caller->speculative still false.

Because the post-call state loses its speculative flag:

1. sanitize_mark_insn_seen() marks instructions reached only along the
   callee's speculative exit path as seen, preventing sanitize_dead_code()
   from patching architecturally dead instructions after the call.

2. If the speculative return value in R0/R2 triggers an unsafe operation in
   the caller that would normally be recovered with a speculation barrier
   via error_recoverable_with_nospec(err) && state->speculative in
   do_check_block(), state->speculative is false, so no nospec barrier is
   inserted and the program is rejected.

3. flow_merge() and bpf_states_join() can join this speculative return state
   with the architectural return state, polluting the caller's architectural
   return register bounds with speculative values.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D16
