Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271041F0991
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857447; cv=none; b=eANSNEs7/7hXGtzEjjIr1G5em0s9kVRQ6kpiWchB1YKJc2bgOIyTvKeeL6dJkJEHdPd08zJYBFq5yJl9F89MWzzx/tjopt2xmfsTssZijzTU7P0dknH38UK3w4kD+5GLnqg9Ru+N2P8nYJ9yBEO7EIDLWvFUpX2pw/uMlsOzmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857447; c=relaxed/simple;
	bh=j4ooE9qbdH7u3VyYxNEm6EXQ3rMm3lkGkjsG8CIuFmY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=krZndE/OM3OfgCzDgu6hlnx8wx0wZF8yO1CHP7KlbE9aw+k1101LeZw/6VAWpDxke1e7bRV8julenSjl2AMHubvQlERKxMqImI/FYJqjLw0nseQNUcGC4vUGFw/AXeCVDB7z0ImzJ1o9fDzoKzkT31MwFZZTM6Sl4Hr5A6S/gUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/HRA6UA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/HRA6UA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5920C19421;
	Fri, 10 Apr 2026 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775857447;
	bh=j4ooE9qbdH7u3VyYxNEm6EXQ3rMm3lkGkjsG8CIuFmY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=n/HRA6UAQoqMKkSkFXaewyCjGbzr/m5dMXLeqvapaLUX57uDlzA5ON9ez+7x8Gke4
	 dWNPEJexZ6flPuw/qV2LdnvZziIkXosob9BiR1IxbTvojCNmUPcy0Q5FawyXg3aKLq
	 3FpwnZ0cXzOXNQ1SADMqYGhc4+7sT5BCdtBxu6yBRzcbli2wDQ0yPMPlU0kjO74UxJ
	 fO6a4bJDAtbNhWBA7pOtc39mKc+sSv7AoR8qggdo5b4DgVgde/yFFo0Zk0YRpaF4ON
	 Zc09DiNwz3XTvp08Hq5GUsoJ4ycPFgklUjgmVK4AtMHuVhGMOh128iUtmXsM35ECbn
	 YMU+5xt4BBTOg==
Content-Type: multipart/mixed; boundary="===============1959785815766215107=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb5b061479a00ba43992f755435e158bb913fb80e5ce106d20c81c42f6bb4356@mail.kernel.org>
In-Reply-To: <20260410-patch-set-v4-7-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-7-5d4eecb343db@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/14] bpf: introduce forward arg-tracking dataflow analysis
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 21:44:06 +0000 (UTC)

--===============1959785815766215107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7b31d8024c61..49b19118c326 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -886,6 +887,8 @@ struct bpf_verifier_env {
>  	} cfg;
>  	struct backtrack_state bt;
>  	struct bpf_jmp_history_entry *cur_hist_ent;
> +	/* Per-callsite copy of parent's converged at_stack_in for cross-frame fills. */
> +	struct arg_track **callsite_at_stack;
>  	u32 pass_cnt; /* number of times do_check() was called */

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index a3af5972520f..c5d6760454d6 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +static struct arg_track fill_from_stack(struct bpf_insn *insn,
> +					struct arg_track *at_out, int reg,
> +					struct arg_track *at_stack_out,
> +					int depth)
> +{

[ ... ]

> +	cnt = at_out[reg].off_cnt;
> +	if (cnt == 0)
> +		return imp;
> +
> +	for (i = 0; i < cnt; i++) {
> +		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
> +		int slot = fp_off_to_slot(fp_off);
> +
> +		if (slot < 0)
> +			return imp;
> +		result = __arg_track_join(result, at_stack_out[slot]);
> +	}
> +	return result;
> +}

[ ... ]

> +	} else if (class == BPF_LDX) {
> +		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
> +		bool src_is_local_fp = insn->src_reg == BPF_REG_FP || src->frame == depth ||
> +				       (src->frame == ARG_IMPRECISE && (src->mask & BIT(depth)));
> +

[ ... ]

> +		} else if (src->frame >= 0 && src->frame < depth &&
> +			   BPF_MODE(insn->code) == BPF_MEM && sz == 8) {
> +			struct arg_track *parent_stack =
> +				env->callsite_at_stack[callsites[src->frame]];
> +
> +			*dst = fill_from_stack(insn, at_out, insn->src_reg,
> +					       parent_stack, src->frame);

Can parent_stack be NULL here? bpf_compute_subprog_arg_access()
allocates callsite_at_stack with kvzalloc_objs (zero-filled), but
nothing in this commit ever writes to individual callsite_at_stack[]
entries. They all remain NULL.

When a callee receives a parent-frame FP-derived pointer (e.g. r1 with
frame=0 at depth 1) and does an 8-byte load from it, this path is
taken. fill_from_stack() then dereferences the NULL at_stack_out:

  fill_from_stack()
    cnt = at_out[reg].off_cnt;   /* > 0 for precise args */
    ...
    result = __arg_track_join(result, at_stack_out[slot]);
                                      ^^^^^^^^^^^^^^^^
                                      NULL dereference

This appears to be a bisection hazard. The next commit in the series,
0458daba63a9 ("bpf: record arg tracking results in bpf_liveness
masks"), adds the code that populates these entries:

  if (bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) {
      env->callsite_at_stack[idx] = kvmalloc_objs(...);
      memcpy(env->callsite_at_stack[idx], at_stack_in[i], ...);
  }

Would it make sense to either defer wiring up the
bpf_compute_subprog_arg_access() call into compute_live_registers()
until the next patch, or move the callsite_at_stack population into
this commit?

> +		} else if (src->frame == ARG_IMPRECISE &&

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24264407165
--===============1959785815766215107==--
