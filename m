Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640C330B32
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943851; cv=none; b=uxNAVDEwEE97aWXH1othrBx/LMfMjkAPMCYO1TIPWxTVJ9FPIaA6Wvdy0RSoUpaNSlicfwqxeOjH9utQ60b303bnmazmZoIkWGFlNFu60RBk8eC8xNDZ2y8PSH7DzSvoOx8KeCYND/HXmd7CaFu+XKdESR68543NxzeC90zoMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943851; c=relaxed/simple;
	bh=5llm6NnXL1xsV4vhwvYxrGjFsmJIe5n1IjGvGuiYFEs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X+YDnxB9A2EWyzCaWbb19+vG7zxEd7zRq/PsLqtRxgGylzFnFWy7/UovBxblHOHYpDNrGggL9z/asHOcEEQ16qecvvcvo08S+t9Fwamh+6B9F/AroegHD3CXPVSgb7vnuhC16ru10TG8hGNOhoJQuwOKMuGy9XXMcyDkmD3kHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxwb0FRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxwb0FRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515CA1F00A3A;
	Mon, 17 Aug 2026 05:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786943849;
	bh=I8sgrZ3w37xs6olfFm+nuDv7YVrjsk0Xb6RyWib+IYs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Uxwb0FRB9f0bABjPCOLZR0NMam15b5xPCdkjw4S1VhTg4mQZDOVksxHAXyTQLKdkX
	 vxUARlmjJggKF2/QysLAsAs8pr8CB92tXsdHS03GOzrBWKnGB5X5R1pe8HIhY2hh9m
	 UZNzCQWe4XUzwRIOTf9nj10w3WtxDh3jajsCx0m59zJjiiHIOdpvh5YJ5+j/oi24cK
	 3MGacTw55FKkSUSSujdj5ho3FoUoA4OuuwupzTopTpgTHlUo3iiNzBM51K6mGFqYhh
	 yLM50wYSc43SmY7eQ+qTlWFE4ndq+pY9hoiSi78tJFIkU2NTK+CIrSFllFRD4PLAM+
	 EvzHjTl5R2pBg==
Content-Type: multipart/mixed; boundary="===============8630942586406859978=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <412885dce17d0fa3a3a9d5eff1d9bd06a100f7f17ed66700bda5e9851881262b@mail.kernel.org>
In-Reply-To: <20260817042202.2288574-1-yonghong.song@linux.dev>
References: <20260817042202.2288574-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 04/10] bpf: Handle R2 as a return register in precision backtracking
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 05:17:29 +0000 (UTC)

--===============8630942586406859978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Handle R2 as a return register in precision backtracking
>
> Precision backtracking treats only R0 as a return register at a
> call/return boundary, so once the verifier starts modeling R2 that way,
> marking the second half of such a return precise would trip the
> "unexpected regs" checks in backtrack_insn() and reject a valid
> program.
>
> Marking the upper half precise, for example by branching on it after a
> call to a static subprogram, walks backtracking into the callee and
> reaches its BPF_EXIT with R2 still set in the mask. Handle R2 like R0
> in boundaries where a call defines the return registers.
>
> R2 differs from R0 in that it is an argument register as well, so it is
> part of the BPF_REGMASK_ARGS check and has to be cleared before that check
> rather than next to R0. Clear it unconditionally, rather than only where
> the callee or the kfunc really does return a pair. That gives up the
> "unexpected regs" assertion for R2, and in exchange keeps backtracking
> free of any BTF lookup. Nothing is lost: a callee that does not return
> a pair leaves the caller's R2 uninitialized, so the main verification
> pass has already rejected any program that reads it, and backtracking
> is never asked for its precision.
>
> At BPF_EXIT the return registers are sampled before the callback path
> clears R1-R5. That clear does not touch R0, but it does cover R2, and
> running it first would drop a pair return whenever the instruction
> following the call happens to be one that invokes a callback.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for 16-byte return support. Should this
include:

  Fixes: 162762023c59 ("bpf: Add helpers to describe the R0:R2 return register pair")

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index a2b18a9f1694..653db80bcc47 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c

[ ... ]

> @@ -520,7 +524,25 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
>  		} else if (opcode == BPF_EXIT) {
> -			bool r0_precise;
> +			bool from_subprog_call, r0_precise, r2_precise;
> +
> +			/* BPF_EXIT in subprog or callback always returns
> +			 * right after the call instruction, so by checking
> +			 * whether the instruction at subseq_idx-1 is subprog
> +			 * call or not we can distinguish actual exit from
> +			 * *subprog* from exit from *callback*. In the former
> +			 * case, we need to propagate the precision of the
> +			 * return registers, if necessary. In the latter we
> +			 * never do that.
> +			 */
> +			from_subprog_call = subseq_idx - 1 >= 0 &&
> +					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
> +
> +			/* Sample the return registers before the callback
> +			 * handling below clears R1-R5.
> +			 */
> +			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
> +			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);

A subsystem pattern flags this as potentially concerning: the multi-line
comment above starts its text on the opening /* line:

	/* Sample the return registers before the callback
	 * handling below clears R1-R5.
	 */

The BPF subsystem guide suggests putting /* on its own line for
multi-line comments under kernel/bpf/:

	/*
	 * Sample the return registers before the callback
	 * handling below clears R1-R5.
	 */

Every existing multi-line comment in backtrack.c uses the older form,
including the comment block that this same hunk moves, so matching the
file's dominant style is a plausible reason to write it this way. Does
the newer form matter here?

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31995069373
--===============8630942586406859978==--
