Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2F175A74
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547685; cv=none; b=aVFtrVBqxaxZeL/5cLHPpo99mS6LSESmxIQW0MXWTsXKcX31bonALkcTD7gZrkYjuwoLHNbZuU9bHqKw15RRE0MjkoqYHiKR2aDBWyZNcUFbvMFVrPrO0Wq4nsf47nPGRZ3u9/gohswwt12S2Q0T3EVfrqxeQfeaBnZdDhfG/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547685; c=relaxed/simple;
	bh=htPsQARnsYqBSL2nkoSdR4ahf7fb2p0McQWED/H21No=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f/u/qxS6W/daKDctxwcb4FOG5f64Z8B2czMLi30SCocKXzFFJxw3bZPXFrhJrFrysXnrb+IAZQA87ABFY5fKAgA2qu1ZUxtsWXRvhrLQ4bCzAr+w14AHZXsY+WtpzvT9pQbI8A2GTXUPKIwAScfhTSSGxJmUqzGpo6HCDhK5WN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl/OMX0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl/OMX0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0E41F000FF;
	Fri,  9 Oct 2026 12:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547679;
	bh=S9609TGrm+BAdB8im6otpsSdKzUjSKodklqds9+XZNg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Hl/OMX0xN2qZte7M/WVdwOu7HJZmBKt/VazmI6wKne21CzCQAzwqyVYWGdeSjZJXY
	 cmW+/GVo5yCRkYhaxj30KO3ufiO8RtO7tAFwkQlf3fYp1vWlultcnXQ2PrMkHYId2H
	 mIBkKnSHfAobpOVXdwCJWifjldBo58+GDAXSOqnGWnFv9WDaJecQ7mJshHs4Uoyrpj
	 obKwTjwSL5e+jqp8YuKsqNUbkPLwlXwRt65GGYik1R59ss2q7Uj7E5U+NryUobuaTQ
	 isiicYVEl3FTWlNmAsZXYfJreVaFOPtPD8mJrHbyxEcknW3esILszwInP3WyUwxXHq
	 AsDwKpnkYnK3w==
Content-Type: multipart/mixed; boundary="===============2713618016317183260=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <debf620cc082978bcb926bf13fa5af72f46e25607f0ca9289f4bb41ca15530d3@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-19-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-19-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 19/51] bpf: representation for intervals with steps
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:58 +0000 (UTC)

--===============2713618016317183260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: representation for intervals with steps

TL;DR:
- Commit message says eq/neq branches ignore base/step, but they appear to
  change branch pruning
- Comment in reg_bounds_sync() names reg_umin() where reg_smin() seems
  intended (nit)

>     bpf: representation for intervals with steps
>
>     Extend scalar register tracking with a linear "base + step * k" description:
>     each scalar carries two u16 fields, base and step (invariant: base < step),
>     recording that its value is some point on the line base + step * k.
>     A fresh scalar starts as base=0, step=1, i.e. any integer.
>
>     This lets the verifier reason about strided values, e.g. an index multiplied
>     by an element size, which neither the min/max bounds nor the tnum can capture
>     for a non-power-of-2 stride. Such reasoning is necessary to allow
>     array access with a variable offset through PTR_TO_BTF_ID, e.g.
>     for expressions like p->arr[i].field.
>
>     reg_bounds_sync() uses the description in two ways:
>     - __reg_bound_offset() clears the low bits of var_off implied by the number
>       of trailing zeros shared by base and step.
>     - __update_bounds_from_step() intersects the 64-bit range with the line via
>       cnum64_intersect_linear(), snapping smin/smax to actual points on it.
>       This is the last step of the sync, as refining the range from var_off
>       can move the bounds off the line.
>
>     range_within() is extended to check whether the cur register's equation
>     describes a subset of the points described by the old register's equation.
>
>     Scalar ALU operations update base/step as follows:
>     - ADD of a constant (including pointer + scalar): keep step, shift base;
>     - MUL by a constant: scale step and base by the constant;
>     - LSH by a constant: scale step and base by the corresponding power of two;
>     - sign extension: keep the register unchanged if all values fit the target
>       type, reset to base=0, step=1 otherwise;
>     - All other operations reset to base=0, step=1.
>
>     Branch (eq/neq) checks do not take into account base/step yet.
>
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

The changelog says "Branch (eq/neq) checks do not take into account base/step
yet."  Is that accurate for this patch?

is_scalar_branch_taken() ends by calling simulate_both_branches_taken().  That
function runs regs_refine_cond_op() and reg_bounds_sync() on copies of the
registers, and treats range_bounds_violation() as proof that a branch is dead.

reg_bounds_sync() now ends with __update_bounds_from_step(), and
cnum64_intersect_linear() returns CNUM64_EMPTY when the refined range holds no
point of base + step * k.

For example, take r1 in [0, 30] with step=3, base=0 (say from r0 *= 3 with r0
in [0, 10]), followed by:

    if r1 == 4 goto L

The tnum and min/max checks cannot decide this.  In
simulate_both_branches_taken() the true branch refines r64 to [4, 4], and then
in cnum64_intersect_linear():

    d = imod(base - imod(smin, step), step);   /* imod(0 - 1, 3) == 2 */
    if ((u64)smax - (u64)smin < d)              /* 0 < 2 */
            return CNUM64_EMPTY;

So the JEQ branch is treated as dead (pred = 0) purely because of
base/step.  JNE behaves the same way, and JNE against a range edge now snaps
the bound onto the line ([0, 29] becomes [0, 27]).

This looks sound as long as base/step are sound, but it is a real change to
branch pruning, and mark_chain_precision() is called on the compared registers
whenever pred >= 0.  Should the changelog describe this instead of saying
eq/neq branches ignore base/step?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 47a632a6749a..f5b2500335a7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2208,6 +2337,15 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
>  	 * then new var_off is (0; 0x7f...fc) which improves our umax.
>  	 */
>  	__update_reg_bounds(reg);
> +	/*
> +	 * Both tnum and base+step define a sequence of points,
> +	 * potentially w/o intersection, or intersecting after N
> +	 * tnum_step()'s, where N can be large. On the other hand,
> +	 * step+base *must* be in sync with r64 in order for
> +	 * array traversal logic starting at reg_umin() to be sound.
                                          ^^^^^^^^^^

This isn't a bug, but is reg_umin() the right function to name here?  The
array traversal logic isn't part of this patch.

It is added later in the series by b312df27df3b ("bpf: varying offset access
support for PTR_TO_BTF_ID pointers"), and that code starts from the signed
minimum rather than reg_umin():

    if (check_add_overflow(reg_smin(reg), (s64)_off, &min_off) || ...

cnum64_intersect_linear() also snaps the signed bounds (cnum64_smin() and
cnum64_smax()).  For ranges with negative values, reg_umin() is not on the
line at all.  For example, [-5, 7] with step=3, base=1 has umin 0, and
0 mod 3 != 1.

The claim that step+base "*must* be in sync with r64" also does not seem to
hold for signed-wrapping ranges, since cnum64_intersect_linear() returns those
unchanged when cnum64_srange_overflow() is true.

Could the comment refer to reg_smin() and the smin/smax snapping instead?

> +	 * Hence, place this as a final step in the reg_bounds_sync().
> +	 */
> +	__update_bounds_from_step(reg);
>  }
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============2713618016317183260==--
