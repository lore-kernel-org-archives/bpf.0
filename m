Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C496421256
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241208; cv=none; b=KmOrocIxXe0knFbPRTVMxHptcs0ScBEE7lREj+0sOj6ZY9v4OLs4U2v+VgPo0Sj9tn30DENGmvChjmMTjy5D7jvOHOREOQ+WKVHw/RVlSuFbAvnjB+zEP/RSixXZhtpJn5aVFa93HAsedno/8kb8AOqlTMzhoJ+ai1Xg8lPHnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241208; c=relaxed/simple;
	bh=zKOM20gDQvlmDkESxuumwOnIM88r03oIS6HHd8+eULY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rhp5EH15OTnOAstdPNmnNj8A/jB5gQqe5s0aGaaN+dfZeoWiiWKV46i07onhZ2xchZue7BERZ9pytc4tt/e0Tf7OKmDJS3/FaRj159upSoUQH3ZPMxiyG66/dfqjig3eGWW2HMdpupk9VohbWAWaxPRs5HmtCGXWPzTBqsrdOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUZWM9HD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUZWM9HD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7E21F000FF;
	Thu, 24 Sep 2026 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241207;
	bh=xuLFxPoGvcUPnDiHPSYk40+o0acm7FQGlqcT1X7GXxQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gUZWM9HDO45MybiuOXeh5i8eTCrzaz5p75+JBxYgmT9uqXZTFO7Vcp69/MzgFhsUZ
	 nbwr4nUf0KK+ZUe2n7w5b8rF5EkgF54mf9e5mVYyI/LzvH5x6UlYtxkVpKlEWzk8UV
	 TEe+xI8z+8z0ojX9tA2ln5wa21qNAc6LR3zUFxeCBdZ5bKvtafHMoWxEzCE2E6/FD5
	 ozSqLQ8WLe8V9skd99791Wl/eSqUY6o45tXrnKThDiKLq1lZwyFC20zCraDmiYxN8U
	 WILVlJhEzYegzK6UEYp7jyXHb7noW/rELGQaJ+nbhCUprDUE7VFFokWLqidpx3Bhjz
	 UZN1q8At4E0pQ==
Content-Type: multipart/mixed; boundary="===============7417576400106039804=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <52c1223353ad134a1dae657457cd39cb67c3e3d8caeaef0b07d4498f92bb653a@mail.kernel.org>
In-Reply-To: <20260924082607.2695649-14-memxor@gmail.com>
References: <20260924082607.2695649-14-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/18] bpf: Bound program stack use by a per-program limit
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 09:13:25 +0000 (UTC)

--===============7417576400106039804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 2f52315d8bdd..de83736509a8 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -36,9 +36,9 @@ enum {
>   * relative index @i is at &bits[(i * FM_MASK_CNT + kind) * words]. A
>   * half-slot at or past @words * BITS_PER_LONG is never read by this frame,
>   * hence never live. An instruction that may read the whole frame, such as a
> - * call passing a frame pointer to another subprog, widens the array to
> - * FRAME_MAX_WORDS, so that the read cannot lose half-slots to a later
> - * widening.
> + * call passing a frame pointer to another subprog, widens the array to the
> + * program's stack budget, the deepest an accepted program can reach, so
> + * that the read cannot lose half-slots to a later widening.
>   */
>  struct frame_masks {
>  	u32 words;
> @@ -264,12 +264,16 @@ static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_
>
>  /*
>   * Mark every half-slot of @frame as possibly read by @insn_idx. This widens
> - * the masks to the maximum width: a full read recorded at a narrower width
> - * would leave the bits added by a later widening clear and lose part of it.
> + * the masks to the program's stack budget: a full read recorded at a narrower
> + * width would leave the bits added by a later widening clear and lose part of
> + * it, and an access past the budget is rejected by the main pass later, so no
> + * widening of an accepted program goes further.
>   */
> -static int mark_stack_read_all(struct func_instance *instance, u32 frame, u32 insn_idx)
> +static int mark_stack_read_all(struct bpf_verifier_env *env, struct func_instance *instance,
> +			       u32 frame, u32 insn_idx)
>  {
> -	return mark_stack_read(instance, frame, insn_idx, 0, FRAME_HALF_SPIS - 1);
> +	return mark_stack_read(instance, frame, insn_idx, 0,
> +			       env->stack_limit / BPF_HALF_REG_SIZE - 1);
>  }

The new comment on mark_stack_read_all() says "an access past the budget
is rejected by the main pass later, so no widening of an accepted program
goes further." Can that claim hold in all cases?

bpf_compute_subprog_arg_access() records accesses on every instruction
the CFG can reach, but do_check() only explores feasible paths. In
check_cond_jmp_op(), when is_branch_taken() returns 0 or 1, the other
branch is pushed only if !env->bypass_spec_v1.

For a privileged load, a branch that is provably dead but not
constant-folded is never verified. Looking at something like this:

    call bpf_get_prandom_u32
    r0 &= 15
    if r0 > 20 goto L
    r0 = 0
    exit
  L:
    *(u64 *)(r10 - 1024) = r0

The program is accepted with stack_limit == 512. The liveness pass
still calls mark_stack_write() for half-slots 254..255, and
widen_frame_masks() grows that frame past the budget, to 4 words.

There is no functional impact. widen_frame_masks() keeps all old bits,
and liveness is only queried from __clean_func_state() for half-slots
below 2 * allocated_stack / BPF_REG_SIZE. allocated_stack only grows
through grow_stack_state() after check_stack_access_within_bounds() has
enforced -env->stack_limit. So bits past the budget are never read,
and a read-all up to stack_limit / BPF_HALF_REG_SIZE - 1 covers every
half-slot the verifier can query.

Could the comments state that invariant (verifier states never hold slots
past env->stack_limit), rather than claiming that accepted programs never
record accesses past the budget? As written, a later change could rely on
masks never being wider than the budget, for example to size a buffer from
stack_limit instead of FRAME_MAX_WORDS, and that would be unsafe.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35976322553
--===============7417576400106039804==--
