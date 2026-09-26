Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34044547065
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790399744; cv=none; b=dNVZNSl50lnlctplehKHOnKbrGk+pGFNTcE4X5VnkI4nkLipUc8Bp2vnVMI/x3JIqjeVPerWrlzFGn3ts+hFFt7Ntt2pBDJXymrfDJ5VrT0uJYOWEWmng457BUgv7Bs5QP50/bjc5LDEj8N91soq52vu+P4eAB3p29B76rafK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790399744; c=relaxed/simple;
	bh=heuJzIPkHz/n0SsHcOi8Hdin5MuEhwZLPRLiOWvbtPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tr2JIZNJR5VtbcruU87Z6NCY8rQgHrKs+w4A3Jxu9I4WQrCp5A6Mfm4WsT6HbM65SFw/5ArNVt0wN5BYGzjRVcpI2BvFo+fE3WrYt88tHgr3/aFJtbCPtdB9XVujKTHD+JuWfJhq6zyg1czgFi82Ili3zqT8ckkTg8SNzNNDVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAC5U9rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAC5U9rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B111F00893;
	Sat, 26 Sep 2026 05:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790399742;
	bh=UoeSmYz1dPkFsr5T00g8BT7KrZmZ0SaORqTtd4S4i/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAC5U9rkzqLxSaiTJPhvyEj752+TNQ6jEXyfEoL9jT+XqcX1gcFFQK15UnPkS/egP
	 K4cM4viKbloaIaAmLrHxDnyyiTCQlm7+snSlVCR7s7jMXUI6I8us+zCUpi6JwuuYdn
	 25ieTD2FzQbn47AmpPWBvFYZ7YyAcOx8/bgATN/L76MeHIFWKerP3djAIqcdZLiB3c
	 4S6cqBS55vQKAsn4fR0DCMepLEWeMLF6uk0Cisunjn23Tb7XA28Hcwwx0CaAWNT3iy
	 oooLahHrLe7zU2fZ2TuPEstH0CZActmnzBgdPoZDduHt5B0UpSAUWl6jjulJjMntlP
	 PG4YpmNoLp18A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 07/21] bpf: Resume a covered call at its
 landing pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926050042.2216692-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050042.2216692-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:15:42 +0000
Message-Id: <20260926051542.D2B111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf: verifier bypass of resource leaks on unwinding without pad
- [High] bpf: double free via bpf_unwind_resume returning to normal path in=
 verifier
- [Medium] bpf: precision tracking corruption when backtracking through bpf=
_unwind_resume
- [Medium] bpf: CFG and liveness graph mismatch for bpf_unwind_resume
--

commit c4ed3d378ed3f7a547e662e1b6885fb3e54fef13
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Resume a covered call at its landing pad

This patch introduces the ability for a BPF program to resume execution at a
landing pad after an unwinding operation. It updates the verifier's control
flow and state management to correctly account for these transitions, treat=
ing
the landing pad as an ordinary second successor in the same frame.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 0e38b9575328c..57665c67e66b3 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
[ ... ]
> @@ -434,8 +435,24 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
> =20
> +			if (bpf_exc_pad_of_call(env, idx) =3D=3D subseq_idx) {
> +				/*
> +				 * We came from this call's landing pad, which
> +				 * runs in the caller's frame: on that path the
> +				 * callee's frame was never entered, so there is
> +				 * no frame to leave. The call clobbered r0-r5;
> +				 * r6-r9 and the stack are the caller's own and
> +				 * keep going back from here.
> +				 */
> +				bt_clear_reg(bt, BPF_REG_0);
> +				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> +					verifier_bug(env, "landing pad unexpected regs %x",
> +						     bt_reg_mask(bt));
> +					return -EFAULT;
> +				}
> +				return 0;

[Severity: Medium]
Does the BPF_CALL backtracking logic correctly handle bpf_unwind_resume()?

When backtracking from a caller's instruction into a callee's pad and
encountering bpf_unwind_resume(), it looks like backtrack_insn() processes =
it
as a standard call without transitioning the backtrack frame (like
bt_subprog_enter() does for BPF_EXIT).

Could this leave the backtrack frame in the caller's context while traversi=
ng
the callee, leading to precision tracking corruption?

>  			/* callx calls static subprogs only */
> -			if (subprog >=3D 0 && bpf_subprog_is_global(env, subprog)) {
> +			} else if (subprog >=3D 0 && bpf_subprog_is_global(env, subprog)) {
[ ... ]
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 4e2b6985bc964..cfd4fe4049cae 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
[ ... ]
> @@ -678,6 +687,8 @@ static int visit_insn(int t, struct bpf_verifier_env =
*env)
>  				mark_subprog_changes_pkt_data(env, t);
>  			if (ret =3D=3D 0 && bpf_is_throw_kfunc(insn))
>  				mark_subprog_might_throw(env, t);
> +			if (ret =3D=3D 0 && bpf_is_unwind_kfunc(insn))
> +				mark_subprog_might_unwind(env, t);
>  		}
>  		return visit_func_call_insn(t, insns, env, insn->src_reg =3D=3D BPF_PS=
EUDO_CALL);

[Severity: Medium]
Is there a mismatch between the control flow graph and liveness tracking he=
re?

In visit_insn(), bpf_unwind_resume is processed as a standard kfunc call,
which pushes a fallthrough edge into the CFG via visit_func_call_insn().

However, in bpf_insn_successors() in liveness.c, it correctly acts as an ex=
it:

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 4e0273a8ceee4..c9ee4f10f7255 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -364,6 +364,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx)
>  		return jt;
>  	}
> =20
> +	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
> +		return succ;
> +
>  	opcode_info =3D &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->c=
ode)];

Could this mismatch, where the CFG considers the path reachable but liveness
sees 0 successors, violate verifier graph invariants?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fc3df452de2e4..77176250f866c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -19167,6 +19167,40 @@ enum {
>  	INSN_IDX_UPDATED =3D 2,
>  };
> =20
> +static int push_cleanup_pad_branch(struct bpf_verifier_env *env, int ins=
n_idx)
> +{
> +	struct bpf_verifier_state *branch;
> +	struct bpf_func_state *frame;
> +	int pad =3D bpf_exc_pad_of_call(env, insn_idx);
> +
> +	if (pad < 0)
> +		return 0;
> +	branch =3D push_stack(env, pad, insn_idx, false);
> +	if (IS_ERR(branch))
> +		return PTR_ERR(branch);
> +	frame =3D branch->frame[branch->curframe];
> +	/*
> +	 * The state at that call with the caller-saved registers gone: the
> +	 * callee's epilogue put r6-r9 and the stack back on the way out.
> +	 */
> +	clear_caller_saved_regs(env, frame->regs);
> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
> +	return 0;
> +}
> +
> +static int process_bpf_unwind(struct bpf_verifier_env *env, int *insn_id=
x)
> +{
> +	struct bpf_func_state *frame =3D cur_func(env);
> +	int pad =3D bpf_exc_pad_of_call(env, *insn_idx);
> +
> +	if (pad < 0)
> +		return PROCESS_BPF_EXIT;

[Severity: High]
Could returning PROCESS_BPF_EXIT here bypass resource leak and lock checks?

If a BPF program acquires a resource like a spinlock and calls bpf_unwind()
without a covering landing pad, pad < 0 evaluates to true. The verifier then
pops the state and terminates the branch without invoking check_resource_le=
ak()
as process_bpf_exit_full() would normally do.

Since do_check_insn() evaluates this kfunc before the active_locks check, c=
ould
this allow the program to unwind while holding a spinlock, causing a kernel
memory leak or deadlock at runtime?

> +	clear_caller_saved_regs(env, frame->regs);
> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
> +	*insn_idx =3D pad;
> +	return INSN_IDX_UPDATED;
> +}
[ ... ]
> @@ -19404,6 +19438,20 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
> =20
>  		env->jmps_processed++;
>  		if (opcode =3D=3D BPF_CALL) {
> +			if (bpf_is_unwind_kfunc(insn))
> +				return process_bpf_unwind(env, &env->insn_idx);
> +			if (bpf_is_unwind_resume_kfunc(insn)) {
> +				/*
> +				 * Mark r0 a known zero -- unknown first, as
> +				 * the known-zero helper keeps the type it
> +				 * finds, which here is NOT_INIT. The fixups
> +				 * lower this to 'r0 =3D 0; exit', so the frame
> +				 * returns a real zero.
> +				 */
> +				mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
> +				mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
> +				return process_bpf_exit_full(env, do_print_state, false);
> +			}

[Severity: High]
Could this simulate a normal return from the subprogram and lead to a doubl=
e=20
free vulnerability?

Here, bpf_unwind_resume is handled by calling process_bpf_exit_full() with
exception_exit =3D false, returning to the normal instruction after the cal=
l.

However, earlier in push_cleanup_pad_branch(), the caller's landing pad bra=
nch
was already pushed using the pre-call state.

At runtime, the callee's pad actually jumps to the caller's pad, not the
instruction after the call. If a callee's pad frees a resource, the verifier
will check the caller's pad using the pre-call state (where the resource was
still allocated).

Could this allow the caller's pad to free the same resource a second time,
resulting in a use-after-free or double free vulnerability?

>  			if (env->cur_state->active_locks) {
>  				/* similar to static subprog calls callx is allowed under a lock */
>  				if (!bpf_is_callx(insn) &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926050006.2213=
110-1-yonghong.song@linux.dev?part=3D7
