Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B236404E
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781905620; cv=none; b=q+950CMNA9z31xfDe0zRWYyGb+084ABtX6WRVC0taghmn1yXiDO7B5iiYT/FOBczgCLChEmyBQBTB05gJnmILW72yNZ+9q1VevPTCUYqqqsGphKISNjQBMF9EG4sawti2s7cOleQCYvAH3cCd4sLFsjnzaj7S+KjJiLoCyJuXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781905620; c=relaxed/simple;
	bh=sYGeSjYcN2+xzU1u5sXGii23PC+1HMgxDli2TEJJ4HU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HDZK7z57KrpQEI/2HXxzghlJnAhS/axIonql3UUyYq9KOEoCni7afvyyx3VhQ4hhfKFJKL0A8ggHCYwGsrk1tfSAGQ+vYpZA/m9h6Gy1zWKY476e1R8FQn0PYnGDW4LDGcP5+glPGUPs6g1uoSeYErAKNpFmPCHu2uf4Zadoo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvzAtyAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvzAtyAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671A01F00A3A;
	Fri, 19 Jun 2026 21:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781905619;
	bh=XsL+1dVhtGIeABRPr71EltCJzW5NVfDMJHWrJ/UXWj4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JvzAtyAxikOZkk5J2ELGrHlSYRlNbssqC9Nk5oEXvdDnFGq3qXXpuV8vUpjJMxojN
	 ixyvL1Z9pd+rLJsHQ7UW3DYSsyQmCOeg2qEmpO/BhGoZM9AdfUDCHr3zp1llDdsq3j
	 QGQcjaDa/fzVOJyEc5pDD+8XeHQCfJYQ1LIvYV5jBuhGI7XmVhAOjUCgsxw1nFUWBm
	 TYBKfkCTGPcdPelMmfbkyfOFQHZVJXrQ6LBRXqIhA+/lo524ioOiqOfJfc7p936kyI
	 FSyVj0jZVVJealzyUFEdAaKhPuxrB4EIay6rnUTxSpUcS+0BonwXo2VwHhjyNwi3w/
	 i4K3++e2c9J+w==
Content-Type: multipart/mixed; boundary="===============3741140801479479567=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5137e2394814411a40317db8e64da71f03516228bcc8f4070f75762ed297906@mail.kernel.org>
In-Reply-To: <20260619205934.1312876-5-memxor@gmail.com>
References: <20260619205934.1312876-5-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/17] bpf: Prune verifier diagnostics on backtracking
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 21:46:59 +0000 (UTC)

--===============3741140801479479567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e81fdb0e22ae..ca4bba163418 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -192,6 +192,9 @@ struct bpf_verifier_stack_elem {
>  	struct bpf_verifier_stack_elem *next;
>  	/* length of verifier log at the time this state was pushed on stack */
>  	u32 log_pos;
> +	u64 diag_log_pos;
> +	bool diag_branch_valid;
> +	bool diag_branch_cond_true;
>  };

[ ... ]

> @@ -1786,6 +1794,21 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
>  	return &elem->st;
>  }
>
> +static struct bpf_verifier_state *
> +push_stack_with_branch_diag(struct bpf_verifier_env *env, int insn_idx,
> +			    int prev_insn_idx, bool speculative,
> +			    bool cond_true)
> +{
> +	struct bpf_verifier_state *st;
> +
> +	st = push_stack(env, insn_idx, prev_insn_idx, speculative);
> +	if (!IS_ERR(st)) {
> +		env->head->diag_branch_valid = true;
> +		env->head->diag_branch_cond_true = cond_true;
> +	}
> +	return st;
> +}

[ ... ]

> @@ -16060,7 +16086,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  			return err;
>  	}
>
> -	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx, false);
> +	other_branch = push_stack_with_branch_diag(env, *insn_idx + insn->off + 1,
> +						   *insn_idx, false, true);
>  	if (IS_ERR(other_branch))
>  		return PTR_ERR(other_branch);
>  	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
> @@ -16074,6 +16101,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  	other_branch_regs[insn->dst_reg] = env->true_reg1;
>  	if (BPF_SRC(insn->code) == BPF_X)
>  		other_branch_regs[insn->src_reg] = env->true_reg2;
> +	bpf_diag_record_branch(env, *insn_idx, false);

[ ... ]

> @@ -1720,6 +1723,10 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
>  	}
>  	if (pop_log)
>  		bpf_vlog_reset(&env->log, head->log_pos);
> +	bpf_diag_event_log_reset(env, head->diag_log_pos);
> +	if (activate_diag_branch && head->diag_branch_valid)
> +		bpf_diag_record_branch(env, head->prev_insn_idx,
> +				       head->diag_branch_cond_true);

This isn't a bug, but could the changelog be more precise about how the
queued branch outcome is recorded?

The message says "append the queued outcome before push_stack() so the
saved diagnostic position includes it, then reset back to the active
path before continuing," but the code records the queued outcome later
when the state is popped.

In check_cond_jmp_op(), push_stack_with_branch_diag() captures the
diagnostic position and stores diag_branch_cond_true = true on the stack
element. The queued outcome is recorded in pop_stack() when
activate_diag_branch is true:

    if (activate_diag_branch && head->diag_branch_valid)
        bpf_diag_record_branch(env, head->prev_insn_idx,
                               head->diag_branch_cond_true);

The active path's false outcome is recorded after push_stack_with_branch_diag()
via bpf_diag_record_branch(env, *insn_idx, false).

Does the description match an earlier design, or could it be updated to
reflect the push-then-record-at-pop approach?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27848712882
--===============3741140801479479567==--
