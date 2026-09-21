Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B34FDA4A
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026821; cv=none; b=LPxgzbbpvuDbHY/F3QLEi7ZVijPo55rye7Aka3KNwRpJwC4MB7myBPgPEyFaG38prOlqofJheH3nUuMQ72LGTFH9rsAZKU6Et0WfHDRJOpVBsxpqgv/0yjGh1pii1WA5KC6FK5pqLmRt+8ZSIp0WWW3zHCQmHtcekiCZLbQjSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026821; c=relaxed/simple;
	bh=gczUHT0Ug/nDRssTN4hfHhPp+BrkFtUY3mx+HsRavKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrhNy3yUfd01f8nXJraX4XeppQvGxrp1fpwhvGUxKBc4VOdkIwIAafGbpE/2SZdC/2p80djMiBQDNnpjEpUy9NssSkSRtYJcab/dQLqXjfOWGvpH6ufBXFnqHyZfJo7OAkK60zODjK27VCFD1KqjsFPeVIvvbtT9hydiV5LddN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTcsucgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTcsucgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C01F1F000FF;
	Mon, 21 Sep 2026 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790026819;
	bh=6xDBSQA8NZxE3abbSdrT5RkZiJeOQrCqe1Kso/vkglk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mTcsucgOmRMUZzVODZp6Y+Ne5JQX7J2jc4mtLgfa6MiS2NLOoZj59rITH1iYMQEet
	 5V8xLQIQyys79ZZSegIep019pbCZzY40iPtaptN8mqbrOTk9/UZ6P6s3E2yc+va3+2
	 L0n9q4p+FEj9SoRlIuoW5q5fxJQ43brNLVjJ2Hi94jRKZeHGFZxg/siFu3Aeb+3rbb
	 BKNnIzqCIFtv9GfOkQ1YOzt5DUbxhT/Rra2zqvWgU64Wm/NFc9DpIRekuGij0j/VyM
	 9NzfVBWP2ywcEUC3MU7zC3TP1ds7J06H+UUWnU6VRNcoZR84y+hnideQQV89slg8G/
	 i5WRjAkB4ASJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the
 verifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921210114.1720196-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210114.1720196-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:40:18 +0000
Message-Id: <20260921214019.5C01F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf: BPF_EXIT in exception cleanup pads bypasses runtime unwinding
- [High] bpf: nested bpf_throw() in landing pads causes kernel NULL pointer=
 dereference
- [Medium] bpf: R0 precision tracking is not cleared across exception edges
--

commit cdb6004b5b8821aea00d57d94b9ac5bcf916b6a4
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Walk the exception unwind in the verifier

This commit updates the BPF verifier to walk the exception unwinding path
step for step when bpf_throw() is called. This aligns the verifier with
the runtime unwinder to properly handle landing pads for exception cleanup.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 507a366dffa47..bf5e7e6ab78f3 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
[ ... ]
> @@ -909,6 +913,14 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
 *env,
>  				 */
>  				return 0;
>  			subseq_idx =3D i;
> +			/* This insn is a landing pad the unwind reached from
> +			 * a throw or a resume hist->unwind_frames frames
> +			 * deeper. No insn stands between the two, so enter
> +			 * those frames here, the way BPF_EXIT enters one.
> +			 */
> +			for (fr =3D 0; hist && fr < hist->unwind_frames; fr++)
> +				if (bt_subprog_enter(bt))
> +					return -EFAULT;
>  			i =3D get_prev_insn_idx(st, i, &history);
>  			if (i =3D=3D -ENOENT)
>  				break;

[Severity: Medium]
When traversing the exception edge here, does the backtrack correctly clear
the precision tracking for R0 in the pad's frame?

When returning from a throw to a landing pad, R0 is initialized to
BPF_PAD_ENTRY_R0 by the kernel unwinder. Since its precision might be
tracked if used in a conditional jump in the pad, this backtrack loop uses
bt_subprog_enter(bt) but does not appear to clear R0's precision mask in
the pad's frame.

This could leave R0 erroneously tracked in the pad's frame as the backtrack
proceeds, eventually reaching the program entry and triggering a
verifier_bug() that rejects valid BPF programs with -EFAULT.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 680ae191aa3f5..2bc08c18ebc89 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -14585,7 +14588,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  		env->prog->call_session_cookie =3D true;
> =20
>  	if (bpf_is_throw_kfunc(insn))
> -		return process_bpf_exit_full(env, NULL, true);
> +		return unwind_step(env, insn_idx, &env->insn_idx);
> =20
>  	return 0;
>  }

[Severity: High]
Is there anything preventing a nested exception from being thrown here?

There doesn't seem to be a check for env->cur_state->unwinding before
processing bpf_throw(), which allows a program to throw an exception from
within a landing pad.

At runtime, the landing pad is executed via arch_bpf_run_cleanup_pad(),
placing kernel frames on the call stack above the BPF frames. A nested call
to bpf_throw() would invoke arch_bpf_stack_walk().

Since it would encounter the non-BPF frame for arch_bpf_run_cleanup_pad(),
bpf_prog_ksym_find() returns NULL. With ctx->cnt being non-zero, the walk
halts prematurely, causing a blind dereference of ctx.aux->bpf_exception_cb
and leading to a kernel NULL pointer dereference.

[ ... ]
> @@ -18522,25 +18624,11 @@ static int process_bpf_exit_full(struct bpf_ver=
ifier_env *env,
>  	 * for which reference_state must match caller reference
>  	 * state when it exits.
>  	 */
> -	int err =3D check_resource_leak(env, exception_exit,
> -				      exception_exit || !env->cur_state->curframe,
> -				      exception_exit ? "bpf_throw" :
> +	int err =3D check_resource_leak(env, false, !env->cur_state->curframe,
>  				      "BPF_EXIT instruction in main prog");
>  	if (err)
>  		return err;
> =20
> -	/* The side effect of the prepare_func_exit which is
> -	 * being skipped is that it frees bpf_func_state.
> -	 * Typically, process_bpf_exit will only be hit with
> -	 * outermost exit. copy_verifier_state in pop_stack will
> -	 * handle freeing of any extra bpf_func_state left over
> -	 * from not processing all nested function exits. We
> -	 * also skip return code checks as they are not needed
> -	 * for exceptional exits.
> -	 */
> -	if (exception_exit)
> -		return PROCESS_BPF_EXIT;
> -
>  	if (env->cur_state->curframe) {
>  		/* exit from nested function */
>  		err =3D prepare_func_exit(env, &env->insn_idx);
[ ... ]
> @@ -18747,7 +18837,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
>  				env->insn_idx +=3D insn->imm + 1;
>  			return INSN_IDX_UPDATED;
>  		} else if (opcode =3D=3D BPF_EXIT) {
> -			return process_bpf_exit_full(env, do_print_state, false);
> +			return process_bpf_exit_full(env, do_print_state);
>  		}
>  		return check_cond_jmp_op(env, insn, &env->insn_idx);
>  	}

[Severity: High]
Are we correctly handling BPF_EXIT when an exception is in flight?

Because process_bpf_exit_full() is called unconditionally without checking
if env->cur_state->unwinding is true, the verifier treats BPF_EXIT from a
landing pad as a normal subprogram return (when curframe > 0).

It pops the frame and continues verifying the caller's instructions, where
an attacker might place lock releases to satisfy check_resource_leak().

At runtime, BPF_EXIT emits a bare 'ret' instruction. When executed from
arch_bpf_run_cleanup_pad(), it behaves like bpf_unwind_resume() by
returning control to the kernel unwinder, which silently discards the
caller frame without executing it.

This discrepancy could allow BPF programs to bypass verifier resource
checks and leak locks or references at runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921210033.1715=
000-1-yonghong.song@linux.dev?part=3D8
