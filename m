Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DD45040B
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124838; cv=none; b=HvwlauRyDK+5MRgbhn0MiDfHq4u1r5M3enqnid2rAtnOKUC/VVF1mxe9gnVAwgrfk2NW96LGGypBkYClJ/o+fl1DKWv+hEph+T9gezDbFJxdkng5kCN9XX5ToZ2BmyE8wtSTKqEDjOCRf27Y/lQZ43xNPlFvTPip8cLBSRrwz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124838; c=relaxed/simple;
	bh=jvyrHw2fSREGa/LJf8OQ+tuI3Iz/zH2CyvZIyGv7KJY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CactKjFs8/AxrQUPbnxWQ9jY5lMonsUOBAO4A7+zhAEG3WSB6ASuZ3CSwRXwzyRUqHOg4Gyqf1wBBMJQ+/N/hUmo5jw2jtTEgMtnno9j9aUnuz4++dQgykZwjYaevvfsFKcNakW1xNrV5oYEnMQDEAaDNA8VpYJdsisgGCMWRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM2+bwXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM2+bwXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01EA1F000FF;
	Sun,  4 Oct 2026 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791124837;
	bh=DR+GUWBt4i7jWQtle/e+XxNjGtvRjQVgWtfmv5ki7bk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DM2+bwXG5IZucY+oIQAuW81dNAB4/jp9R7jz/5buIKFmNN6/Ggrkz5ak9eyzyko9e
	 dwpfay6PdyO3JwWh+Z8quhHYRa7gtW2l8oi/mCeHOhtaPvasiVmp5URlFWRv8qpzsm
	 KIDtn7yFJ5+uAaiQTn8a5bn6aiE2/9ANfGAF8QjNDOWIkFTjejQbUmQK9EiUd8edPa
	 H3LUm4qt9cK4dubBeVoEMe6hw3keXZjJI00r8zBsI+G89k7+1eusfJ+rZgqAyltxRg
	 4uK1+3r42cQg1R39P8Z4Wl0gMWk44yOvEW5qPu6Y8p8zH5/SIvgDm6SuGsbk9JubC+
	 9F4iFOichQp2w==
Content-Type: multipart/mixed; boundary="===============6935375452918051412=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc427e5f673f00ff830ebc761352c4dcabfe0065edfe36077921cafc89372665@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-14-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-14-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/43] bpf: representation for intervals with steps
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:40:35 +0000 (UTC)

--===============6935375452918051412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: representation for intervals with steps

TL;DR:
- base/step not compared with explore_alu_limits or regs_exact(), so states
  may be wrongly pruned, skipping verification
- step not logged when var_off is unknown
- 64-bit modulo in scalar_step_scale() may fail to link on 32-bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4371fb3405ac..05914fcbe77c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -178,6 +178,13 @@ struct bpf_reg_state {
>  	 * during state comparisons.
>  	 */
>  	u32 map_uid;
> +	/*
> +	 * The value described by this register, interpreted as s64, lies on
> +	 * a line described by a linear equation base + step * k.
> +	 * Invariant: base < step.
> +	 */
> +	u16 base;
> +	u16 step;

Are base and step covered by the strict scalar comparisons in states.c now
that they sit after id in struct bpf_reg_state?

With env->explore_alu_limits set, the SCALAR_VALUE case of regsafe() does
this:

kernel/bpf/states.c:regsafe() {
    ...
		if (env->explore_alu_limits) {
			/* explore_alu_limits disables tnum_in() and range_within()
			 * logic and requires everything to be strict
			 */
			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
			       check_scalar_ids(rold->id, rcur->id, idmap);
		}
    ...
}

The memcmp stops at id, so base and step are never compared, and the
function returns before range_within() is reached.  Before this patch
var_off, r64 and r32 all sat ahead of id, so this comparison really was
strict for every field that drives value tracking.

With this patch step is value-relevant:

    reg_bounds_sync() -> __reg_deduce_bounds() -> deduce_bounds_64_from_step()

snaps r64 onto the line, and is_branch_taken() ->
simulate_both_branches_taken() treats an empty r64 after that snap as a dead
branch.  So step alone can decide that an eq/neq branch is never taken,
which seems to differ from the commit message statement "Branch (eq/neq)
checks do not take into account base/step yet".

explore_alu_limits is set by sanitize_ptr_alu() once a program loaded
without CAP_PERFMON (bypass_spec_v1 == false) does ptr += <non-const
scalar>.  After that, can this sequence be wrongly pruned?

    call bpf_get_prandom_u32
    r6 = r0
    if r6 & 1 goto l2
    r0 &= 3
    r0 *= 3            ; var_off=(0;0xf) r64=[0,9] base=0 step=3
    goto j
  l2:
    r0 &= 15
    if r0 > 9 goto out ; var_off=(0;0xf) r64=[0,9] base=0 step=1
  j:
    if r0 == 1 goto bad

The fallthrough path is explored first and its state is saved at j.  At
"if r0 == 1" simulate_both_branches_taken() intersects r64 with [1,1], and
deduce_bounds_64_from_step() turns that into an empty range, so the taken
branch is judged dead and bad is never verified for that state.

On the l2 path r0 arrives at j with byte-identical type, delta, raw,
var_off, r64 and r32 (tnum_mul((0;3),3) is (0;0xf), same as
tnum_range(0,9)).  Only step differs, so the explore_alu_limits memcmp
matches and the state is pruned.  At runtime r0 == 1 is possible on that
path, so the never-verified code at bad can run.

Without explore_alu_limits this is fine, since range_within() rejects
cur->step == 1 against old->step == 3.

regs_exact() has the same gap:

kernel/bpf/states.c:regs_exact() {
	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
	       check_ids(rold->id, rcur->id, idmap) &&
    ...
}

It is used for EXACT comparisons and for the default pointer types in
regsafe().  scalars_exact_for_widen() ignores base/step in the same way.

base and step are still after id at the end of the series (2c96fb13421f).
The later commit 90d24cd54ac0 only switches states_maybe_looping() to
offsetofend(step), and nothing updates the explore_alu_limits memcmp or
regs_exact().

Should base/step be moved ahead of id (after r32), or compared explicitly in
the explore_alu_limits path and in regs_exact()?

>  	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
>  	bool precise;
>  };
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index d850a7863d2e..900d1bb1988b 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -692,6 +692,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
>
>  			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
>  			verbose_a("var_off=%s", tn_buf);
> +			if (reg->base != 0 || reg->step != 1)
> +				verbose_a("step=%d+%d", reg->base, reg->step);

Is it intentional that the step print sits inside the
!tnum_is_unknown(reg->var_off) block?

Whether base/step carry information does not depend on var_off.  A scalar
with an odd step and a signed range that crosses zero has a completely
unknown var_off, so its step is never printed.

For example, after "r0 s>>= 56" r64 is [-128,127] with an unknown tnum.
Then "r0 *= 3" makes scalar_step_scale() set base=0, step=3 (no overflow),
tnum_mul() keeps var_off unknown, and __reg_bound_offset() clears no bits
because count_trailing_zeros(3) is 0.  The log shows:

    scalar(smin=smin32=-384,smax=smax32=381)

with no step=0+3, although step affects branch outcomes (through
simulate_both_branches_taken()) and pruning (through range_within()).

Two states can print identically and still fail to prune each other, and an
"infinite loop detected" dump would hide the difference.

Would moving the step print out of the var_off block, right after
print_scalar_ranges(), be better?

>  		}
>  	}
>  	verbose(env, ")");
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4dd71bf7c1d9..f71778a75f30 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -1910,12 +1911,128 @@ static void bpf_diag_record_caller_saved(struct bpf_verifier_env *env,

[ ... ]

> +static void scalar_step_scale(struct bpf_reg_state *dst_reg, u64 amount)
> +{
> +	u16 step;
> +	s64 tmp;
> +

[ ... ]

> +	if (amount == 0 || check_mul_overflow(dst_reg->step, amount, &step) ||
> +	    check_mul_overflow(reg_smin(dst_reg), (s64)amount, &tmp) ||
> +	    check_mul_overflow(reg_smax(dst_reg), (s64)amount, &tmp)) {
> +		reg_step_reset(dst_reg);
> +		return;
> +	}
> +
> +	dst_reg->base = (dst_reg->base * amount) % step;
> +	dst_reg->step = step;
> +}

Will this link on 32-bit architectures?  amount is a u64, so
(dst_reg->base * amount) % step is a u64 modulo with a non-constant divisor.
The compiler lowers that to a libgcc helper, __umoddi3 on i386 or
__aeabi_uldivmod on ARM32, and the kernel does not provide either one.

verifier.o is built whenever CONFIG_BPF_SYSCALL=y, which is set in ARM32
defconfigs such as aspeed_g5_defconfig and imx_v6_v7_defconfig, so those
builds look like they would fail at link time.  The rest of verifier.c uses
div64_u64()/div64_s64() for this reason.

The modulo also looks redundant.  The check_mul_overflow() calls above
guarantee that step == old_step * amount fits in u16, and base < old_step,
so base * amount < step always holds.

Could this become:

    dst_reg->base = dst_reg->base * amount;

or use div_u64_rem() if the modulo is kept?  The code is unchanged at the
end of the series (2c96fb13421f).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============6935375452918051412==--
