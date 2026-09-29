Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AF30F95C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641868; cv=none; b=IQztI2+dpIFdbUNIbeRBzc38eG+yg8aODsbOlVRgGkQF3F0p4p+K3+xS5FNQkAhD/8E52zGp6va8RLY/vkTzlcJUCp9a+nf7SlCK6L6TqXgk1W8bujAwx+/KHVi0J7nd0rMfquX6M6zyfp2zeMdD4IQgQCQo8LAeRFcB4KLq5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641868; c=relaxed/simple;
	bh=SxVUalDwPGV3+o4jJiLMFjXAgxI3n9tEypjmj4mz8UM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QaUQ22ZJnuk6TaHE8hWpuZ/un9yDZdGuoTMOztmZt2ZKEaGTSKMHhz+i6klAvNs1XzdoEQ+F05A/hSOCEEB/G6Zid/7sYsQhQmWSw8Q0pymLQyRU3xQTBo7MhsQwP9sf3peuAX2E/oDoFkv+mFuhsFPiVb7Fbin/nJlQjbv6mpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIIAaEhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIIAaEhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0211F00893;
	Tue, 29 Sep 2026 00:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641866;
	bh=9q3QlGkTq3KaZjWeXLxO2/P6pRLmdqBKEAXGG7i7KcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIIAaEhd+qB3/Ebhwg9hifR9ZHgwRn0Adn0Cg+7kjtPJsejnpQaYlrf7RQKGj5nG7
	 fqy7y3BthuvrDvRYpcSGj81lBEVvdYg1ArxZH6fPV5szH3OSHtvK5nMxhwQze2Xlg5
	 XFvwWZDETfS/Ym72ysiQ6okvpXan/Zdsi/14Y/awm7TCSuREOBto+0t9y9yZ56YuPT
	 fXZOvnSylgPhlO85P/GH5m8L2O0C5Cu34RwEhzh7IXnKjAda3f+WFTqM7ZGnMn6sCc
	 UNFbaYFtWn98rCwkerZZfcmCTt9MNTV6P+iN1lIoreyGETAwxXM3Jhxnz3v4PA9sFg
	 +0Wm+RGLVV5hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 07/22] bpf: Resume a covered call at its
 landing pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929001638.3248952-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001638.3248952-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 00:31:05 +0000
Message-Id: <20260929003106.3A0211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: landing pad state desync via discarded memory mutations a=
llows OOB access
--

commit 41b3c5e14924fae7175095b7012838a14c2e5ffc
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Resume a covered call at its landing pad

This commit allows a covered call to resume at its landing pad when bpf_unw=
ind()
is invoked by a subprogram. It pushes a cleanup pad branch with the caller's
pre-call state and handles bpf_unwind() by returning PROCESS_BPF_EXIT for
nested frames.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fc3df452de2e4..ee074d4a936b5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19167,6 +19186,57 @@ enum {
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
x,
> +			      bool *do_print_state)
> +{
> +	struct bpf_func_state *frame =3D cur_func(env);
> +	int pad =3D bpf_exc_pad_of_call(env, *insn_idx);
> +	int err;
> +
> +	if (pad < 0) {
> +		err =3D check_resource_leak(env, false, !env->cur_state->curframe,
> +					  "an unwind with no landing pad");
> +		if (err)
> +			return err;
> +		if (env->cur_state->curframe)
> +			return PROCESS_BPF_EXIT;

[Severity: Critical]
When process_bpf_unwind() returns PROCESS_BPF_EXIT here, the verifier stops
exploring the callee and discards its state. Does this discard any memory
mutations made by the callee to pointer arguments before calling bpf_unwind=
()?

Since the CPU unwinds the stack without undoing memory writes at runtime,
could this desynchronize the verifier state from runtime state and allow
out-of-bounds memory accesses?

> +		/*
> +		 * The main program's frame returns at once, which is the
> +		 * program returning. Mark r0 the zero the fixups leave after
> +		 * the call, and leave through the exit, which is what holds
> +		 * that zero to the program type.
> +		 */
> +		mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
> +		mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
> +		return process_bpf_exit_full(env, do_print_state, false);
> +	}
> +	clear_caller_saved_regs(env, frame->regs);
> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
> +	*insn_idx =3D pad;
> +	return INSN_IDX_UPDATED;
> +}
> +

[ ... ]

> @@ -19421,7 +19491,29 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
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
>  			mark_reg_scratched(env, BPF_REG_0);
> +			/* An unwind out of this call resumes at the pad. */
> +			err =3D push_cleanup_pad_branch(env, env->insn_idx);
> +			if (err)
> +				return err;

[Severity: Critical]
push_cleanup_pad_branch() pushes a branch using a snapshot of the pre-call
state. If the callee modified a stack variable (e.g., an array index) and t=
hen
unwound the stack, does the verifier evaluate the landing pad with the orig=
inal
unmodified value?

Could a BPF program use this to bypass bounds checks by mutating an index in
the callee before unwinding, causing the verifier to optimize out the checks
in the landing pad while using the out-of-bounds value at runtime?

>  			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]=
))
>  				cur_func(env)->no_stack_arg_load =3D true;
>  			if (bpf_is_callx(insn))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929001601.3242=
665-1-yonghong.song@linux.dev?part=3D7
