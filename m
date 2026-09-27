Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C53BFAF2
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540828; cv=none; b=rXko5engolP5OOqWaA7SZnObH9fk/I8RKY5qp+MpDRtFLHh6om5VcipVzk89nSGnx3/e/U3iPTd5I1NicCcwv+34Mm/e6rtxJGlB7BxyrDB1HJoAU0NFxG11QsnoCA/ncVsvBw8uZ0+ES5Wuk0IE/lrifdD/texMfhcybKvx3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540828; c=relaxed/simple;
	bh=ACx1Jl8T6sYCrVVHKeJ+kZNuzM01RONIjGLY4qdYUBk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Cj7UiU+VV/fCGaK8+iW3cpf2yGJDobScTxAs8eKarcQdloZ45NGQhlun5R+fk4l1iYS+2/DZ13ta5aSflB1kaRR0XtrY+LLJHDZi6UJTubm6dBaJSwu/9A/0lvxONcHsuHydWf7Y9iv3h7z3rgymQv8J4t0Dgxm1MSYhxXOZv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApM9eA+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApM9eA+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51261F000FF;
	Sun, 27 Sep 2026 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540826;
	bh=TeOyAsRC4kuzluxVXMnlOxfEJyxT1PhCyrPcYDCwCp4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ApM9eA+fJ4TyFrWtVpqh28S9mES7MJIkSfFO/wIOB80ArMl0rNb4SpfVHbFqn4/NA
	 Rs1oVsnuTsSfplNTSr1lVq3aIJiF9o28n1V85pzpYcVKjAGWosMn5FIeZfZQz/KDwP
	 t6uPtirayVKvqEwtfltM4BsPlEzX5+4Saaq+4czBLXrnPdu+pHtaU1+p2LKhK28dWj
	 sV9t5wJh0+PlXskQGAr+0bPjozWS4e/eMkSR3DO2lm5hlnPFJRzbQbVNyij5QfYkeY
	 4QGINFbYJcR41ETCm5657g/zs/U2s79hm0+Ehy4RpZ7EHO4chhxq3ul+L86/luEYXo
	 hQtG9psttUbtg==
Content-Type: multipart/mixed; boundary="===============5161320524623230792=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae40742ac61e6f0c42db66fad1441b140fb39aacc32666fc5b5cef29c9989f31@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-32-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-32-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 32/36] selftests/bpf: tests for register base/step state pruning
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:27:05 +0000 (UTC)

--===============5161320524623230792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> index a8358b625ce7..cb55fc216bc8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c

[ ... ]

> +/* Old register [4..130, step 2] should prune cur register [8..64, step 4]. */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("7: (27) r6 *= 4                       ; R6=scalar({{.*}}umin32=8,{{.*}}umax32=68,{{.*}},step=0+4)")
> +__msg("10: (27) r7 *= 2                      ; R7=scalar({{.*}}umin32=4,{{.*}}umax32=130,{{.*}},step=0+2)")
> +__msg("11: (25) if r0 > 0x2a goto pc+1")
> +__msg("from 11 to 13: safe")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void step_prune_hit_multiple(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 = r0;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r7 = r0;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 &= 0x0f;					\
> +	r6 += 2;					\
> +	r6 *= 4;					\
                           ^^^^

The comment says the current register is [8..64, step 4], but the __msg
check expects umax32=68. Computing r6 &= 0x0f; r6 += 2; r6 *= 4 gives
[2..17] * 4 = [8..68]. Should the comment say [8..68, step 4]?

[ ... ]

> +/* Old register [0..126, step 2] should not prune cur register [0..45, step 3]. */
> +SEC("socket")
> +__failure __log_level(2)
> +__msg("6: (27) r6 *= 3                       ; R6=scalar({{.*}}smin32=0,{{.*}}umax32=45,{{.*}},step=0+3)")
> +__msg("8: (27) r7 *= 2                       ; R7=scalar({{.*}}smin32=0,{{.*}}umax32=126,{{.*}},step=0+2)")
> +__msg("9: (25) if r0 > 0x2a goto pc+1")
> +__msg("11: (15) if r6 == 0x3 goto pc+2")
> +__msg("11: R6=scalar({{.*}},step=0+2)")
> +__msg("13: (95) exit")
> +__msg("from 9 to 11: {{.*}} R6=scalar({{.*}},step=0+3)")
> +__msg("from 11 to 14")
> +__msg("div by zero")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void step_prune_miss_non_multiple(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 = r0;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r7 = r0;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r6 &= 0x0f;					\
> +	r6 *= 3;					\
> +	r7 &= 0x3f;					\
> +	r7 *= 2;					\
> +	if r0 > 42 goto 1f;	/* can't predict */	\
> +	r6 = r7;		/* step=2 explored first, step=3 explored next */ \
> +1:							\
> +	if r6 == 3 goto 2f;	/* false if step=2, should not prune step=3 */ \
> +	r0 = 0;						\
> +	exit;						\
> +2:							\
> +	r0 /= 0;		/* trap */		\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

The commit message says this test checks that range_within() does not let
a cached step-2 range hide a step-3 path that reaches division by zero.
Does this test actually verify the step-divisibility check?

The cached r6 is r7 &= 0x3f; r7 *= 2, which is step 2, base 0.
__reg_bound_offset() clears the trailing zero bits of the step from
var_off:

    trailing_zero_bits = count_trailing_zeros(step);
    reg->var_off = tnum_and(reg->var_off,
                            tnum_const(~0ULL << trailing_zero_bits));

So bit 0 is known to be zero in the old var_off. That known-zero bit is
also what lets is_scalar_branch_taken() use tnum_overlap() to predict
'if r6 == 3' as not taken on the first path. The current r6 holds
{0, 3, ..., 45}, so any sound tnum for it must leave bit 0 unknown.
regsafe() then ends with:

    return range_within(rold, rcur) &&
           tnum_in(rold->var_off, rcur->var_off);

tnum_in() fails because (b.mask & ~a.mask) has bit 0 set. Suppose
range_within() had no 'cur->step % old->step == 0' check at all, or the
whole step block were missing as it was before this series. The state
would still not be pruned. The verifier would still reach 'r0 /= 0' and
print 'div by zero', and every __msg would still match.

When the old step is a power of two with base 0, the tnum already
describes the whole line. The comment on step_prune_miss_const_off_line
makes the same point about avoiding power-of-two steps so imod() is the
sole check. step_prune_miss_non_multiple does not follow that rule, so
could a non-power-of-two step for the old line let this test distinguish
a working step check from a missing one?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============5161320524623230792==--
