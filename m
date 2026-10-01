Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83045263F5D
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862625; cv=none; b=hT2qpUGswW6jp8aKZwCKTL6RpQwQFkSZnDC9yCJR4flkFqO6Kv/Y6gzuJaZL+VPsabaK43ioWpdF7dlO6Anx07d7K/Q4p9Rtpqv/d8Zee6o7BiHgcRfHsCmRL+unyft4IqIP/fye/3uUXXY403oIVzftoi3XzZGHvS1ixofYknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862625; c=relaxed/simple;
	bh=HvOfafIGDznwtXydBrBXehzaqaIvOsBIEPNmB+BNgyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4cnoyXqd3Daxne+VJbRI75wyFbbpu50IHOP5eWxrCFgPIhN+BWamVbipNO7R7vT37aNoIMJPCj6VUsotMLA1bcArsMene80xr6OaxWKHxMWl2/g3rbEZC1jkVPFwybeYRUyc4ekWTLM4Gi53MmGX8k9c7dxK3TEbizOKm77804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5fj/pAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5fj/pAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F561F00898;
	Thu,  1 Oct 2026 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862624;
	bh=0sBTOaxbNBbtCNeFaWS/Uv4EbmCzyWTPar2Uu/rSUjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5fj/pAls8s8IjuL5fdYsxqT6tD56xGoIz/Jh/IdCDQiX2FfFYnYrjsbAY9N4joWQ
	 VCvVirLbY1V8sxyfjJrrT8yXkukSutcqj5obSP2dUTgYu3Kh1o62LJj9ekkYxQFy+b
	 +kOJfcCrX/DSEeN7Jw1bzfyjktEwv68n7XnhkdDz4iLNDvH0so+Fy51NNUwI0Vg3Wf
	 hhzV7kIZkmrYLVImSbNwYS/n0o0hvM2rLVQ2mGC8jptBzi0AmfXmidpx4WfHsH6twR
	 b8KJVwhguwb0ZPHWxqSF3r9DA/EicBxlcdKBAkywmpmc2FE7YLpdJHzC2Xwq/tTxUH
	 Ilc3PYtXMQVTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 07/22] bpf: Follow an unwind to its landing
 pad in the verifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001133042.1339539-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133042.1339539-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:50:23 +0000
Message-Id: <20261001135024.39F561F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: verifier skips unwind paths when global subprog might thr=
ow
- [Critical] bpf: missing restriction for bpf_unwind in callbacks leads to =
verifier divergence
--

commit d554473b8011fe90d6322a255220e23a4d7500d5
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Follow an unwind to its landing pad in the verifier

This patch updates the BPF verifier to follow unwind operations to their
landing pads. It handles how an unwind rewrites return addresses of frames
and evaluates the proper precision backtracking.

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -19126,6 +19145,127 @@ enum {
>  	INSN_IDX_UPDATED =3D 2,
>  };
> =20
> +/*
> + * The current frame is leaving through an unwind. Its caller's saved re=
turn
> + * address now points at the pad covering the call, or, with none, at the
> + * caller's epilogue, and so on down. Follow that from the state the fra=
me
> + * leaves in -- anything it wrote into its callers' stacks included -- t=
o the
> + * first pad, or to the main program's frame returning.
> + */
> +static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_st=
ate)
> +{
> +	struct bpf_verifier_state *state =3D env->cur_state;
> +	u32 frameno =3D state->curframe;
> +	struct bpf_func_state *callee, *caller;
> +	int err, pad;
> +
> +	while (state->curframe) {
> +		callee =3D cur_func(env);
> +		caller =3D state->frame[state->curframe - 1];
> +		pad =3D bpf_exc_pad_of_call(env, callee->callsite);
> +		/* The caller is at its call now, not at this frame's insn. */
> +		state->insn_idx =3D callee->callsite;
> +		account_processed_insns(env, callee, caller);
> +		free_func_state(callee);
> +		state->frame[state->curframe--] =3D NULL;
> +		invalidate_outgoing_stack_args(env, caller);
> +		if (pad < 0)
> +			continue;

[Severity: Critical]
If a callback subprogram (such as one passed to bpf_loop()) calls
bpf_unwind(), does this loop incorrectly pop frames in the verifier state p=
ast
the C helper?

It appears bpf_unwind() and bpf_unwind_resume() lack the callback restricti=
on
that bpf_throw() has in do_check_subprogs().

At runtime, the exception unwinder stops unwinding when it encounters the
non-BPF C helper frame and returns. The callback returns 0, the C helper
resumes, and it returns normally to the BPF program.

However, if the verifier simulates an unwind through the C helper to the
caller's landing pad, it marks the normal execution path as dead code
and replaces it with a ja -1.

Could this divergence between verifier state and runtime execution cause an
infinite loop and hang the kernel?

[ ... ]
> @@ -19380,13 +19520,32 @@ static int do_check_insn(struct bpf_verifier_en=
v *env, bool *do_print_state)
>  					return -EINVAL;
>  				}
>  			}
> +			if (bpf_is_unwind_kfunc(insn) || bpf_is_unwind_resume_kfunc(insn)) {
> +				err =3D check_kfunc_allowed_only(env, insn, env->insn_idx);
> +				if (err)
> +					return err;
> +				if (bpf_is_unwind_kfunc(insn))
> +					return process_bpf_unwind(env, &env->insn_idx,
> +								  do_print_state);
> +				/*
> +				 * The fixups lower this to 'r0 =3D 0; exit', and
> +				 * the unwind goes on below this frame.
> +				 */
> +				return unwind_frames(env, do_print_state);
> +			}
>  			mark_reg_scratched(env, BPF_REG_0);
>  			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]=
))
>  				cur_func(env)->no_stack_arg_load =3D true;
>  			if (bpf_is_callx(insn))
>  				return check_func_callx(env, insn, &env->insn_idx);
> -			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> -				return check_func_call(env, insn, &env->insn_idx);
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
> +				int call_idx =3D env->insn_idx;
> +
> +				err =3D check_func_call(env, insn, &env->insn_idx);
> +				if (err)
> +					return err;
> +				return unwind_out_of_global_call(env, call_idx, do_print_state);
> +			}

[Severity: Critical]
If check_func_call() processes a global subprogram that is marked with both
might_throw and might_unwind, it evaluates might_throw, calls
process_bpf_exit_full(), and returns PROCESS_BPF_EXIT.

Does this cause do_check_insn() to return early here with err =3D 1, comple=
tely
bypassing the unwind_out_of_global_call() logic?

If bypassed, the landing pad associated with the call is never verified and
is replaced with a ja -1 (dead code). At runtime, if the global subprogram
calls bpf_unwind(), the exception unwinder routes execution to this unverif=
ied
landing pad.=20

Can this result in hitting the ja -1 infinite loop and hanging the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001133006.1335=
369-1-yonghong.song@linux.dev?part=3D7
