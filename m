Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA283AA1B2
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123879; cv=none; b=msteut50ViJzTWhj9P5zhC95CqUt3JTtPqljlZJ77G5zhuOwiiYlLvQLUtZJrBYO2uPYbrmG7CqnrhvDqp3Pk0LAHfDFRFWWBld2qxejJGQo8FPls6LKuaCQBPPWalviJEyg3mtIavraBXc3TihLlTIOeD8VYDF+refsg4Zc3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123879; c=relaxed/simple;
	bh=OhksoQlaq98s9kAEp89TfPonGDokfau/yzstQbTzyS8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Up/4Rtw7PnO2nCY9XQoV8lXI7DmPoFR+Uc8enRhXZN9lmVTLscfAZ2PuQHuq5Pg6lLl+Kc0JcMbdH9FTsdTUlIozzg2Q8BSW0i6oo5k/yJc1uI6VhHO2NVJrUnwfB2DHHr9iZkXV68erm0poRCTr3ENbisVUfEhekGGIjdj9ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlMhYa8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlMhYa8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC361F000FF;
	Sun,  4 Oct 2026 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123878;
	bh=YK04Tc3HyFBLnkUm3Y5sxokpXYI/RAWzAZ/odR8V7Jg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BlMhYa8HRaecE54C1z0vIyRHBJCwQCy9qWtmghlquGY7ffCKFVm2Lz44eCwWalPDo
	 pdAT700U5xK/TM7T2xSvoOBB9wVnU2JDkY+hpCQUfAt4pv4dvn0ot54TjF0Avw2Q/i
	 HueUVla9vxe/w9j7x7fzklTlRkokdsdvJ6HEculeMw0VgDDOCyBW5GAJcmbFL45Ibp
	 SoWvpSYUIoO+m0GA815Ru2xpLzAB3xah9BlYY1dmNXRcy5tZ2n5Lh5CH/zRyJvoGqQ
	 N0bhyLo+nC+QWxpMzeSuMnaIHgNGoGL0mIHpXL/O2EFOTzulck/QilAcOF818ppyUf
	 9e3C86d5rI+cQ==
Content-Type: multipart/mixed; boundary="===============0766898026523053831=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c9a97fae07b8fb6df4619a230ef8d9d358e2820b310055038e203bec9a36f402@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-38-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-38-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 38/43] selftests/bpf: tests for register base/step arithmetic
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:36 +0000 (UTC)

--===============0766898026523053831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for register base/step arithmetic

TL;DR:
- Commit message lists tests (step_mul_non_pow2, step_lsh,
  step_add_const_base) that don't exist
- The "w1 = w0" selftest match may not check R1's stride
- Comment has a wrong value (0xfffffffa)

> selftests/bpf: tests for register base/step arithmetic
>
> - step_mul_non_pow2: Retain step 3 after multiplying a bounded scalar
>   by a non-power-of-two constant.
> - step_lsh: Record step 4 after shifting a bounded scalar left by two.
> - step_add_const_base: Shift the base to 1 while preserving step 4
>   after adding a constant.
> - step_neg_value_range: Preserve the signed range of {-3, 0, 3, 6}
>   when intersecting with a non-power-of-two step across zero.
> - step_arith{32,64}_overflow: Reset the stride and preserve valid
>   bounds when a {32,64}-bit operation wraps.
> - step_mov32_truncate: Reset the stride when MOV32 discards nonzero
>   upper bits from positive values.
> - step_mov32_negative: Reset the stride when MOV32 zero-extends
>   the low 32 bits of negative signed values.
> - step_movsx: Reset the stride when sign extension changes the
>   register value.
> - step_linked_regs_add64: Translate both bounds and base when
>   propagating a comparison's refinement through a scalar-ID delta.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

The changelog lists step_mul_non_pow2, step_lsh and step_add_const_base, but
the patch doesn't define tests with those names, and no later patch in the
series does either.

It also doesn't mention step_arith64_no_overflow or step_arith32_no_overflow,
which are in the patch.  Those cover MUL by 3, ADD of 1, MUL by 2 and LSH by 1
(step=0+3 -> 1+3 -> 2+6 -> 4+12), not "step 4 after shifting a bounded scalar
left by two" or "shift the base to 1 while preserving step 4".

Should the bullet list be updated to match the tests that are actually added?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> new file mode 100644
> index 000000000000..079e34820a8f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> @@ -0,0 +1,290 @@

[ ... ]

> +/*
> + * Safe ALU32 multiplication and addition preserve the stride and scale its base:
> + * step=0+3 -> step=1+3 -> step=2+6. MOV32 preserves the result.
> + * LSH32 currently resets the stride, but must preserve the correct upper bound.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w0 *= 3 {{.*}}step=0+3)")
> +__msg("w0 += 1 {{.*}}step=1+3)")
> +__msg("w0 *= 2 {{.*}}step=2+6)")
> +__msg("w1 = w0 {{.*}}step=2+6)")

Can this match pass even if MOV32 doesn't preserve the stride?

The verifier log line for this instruction prints R0 first and then R1,
roughly:

    w1 = w0 ; R0=scalar(id=1,...,step=2+6) R1=scalar(id=1,...)

R0 still has step=2+6 from the previous instruction, so the regex can match
R0's state on its own.  If the MOV32 path (check_alu_op() -> zext_32_to_64())
started resetting the destination's stride, this assertion would still pass.

step_arith32_overflow in this same file anchors the destination register:

    __msg("r2 = r0 {{.*}}R0=scalar({{.*}}step=0+3) R2=scalar({{.*}}step=0+3)")

Would something like "w1 = w0 {{.*}}R1=scalar({{.*}}step=2+6)" be needed
here so the check actually tests R1?

[ ... ]

> +/*
> + * 0x49249249 * 7 wraps to U32_MAX. Keeping step=0+7 incorrectly caps the
> + * result at 0xfffffffc instead of U32_MAX.
> + * Adding 4 to {0xfffffffc, U32_MAX} wraps to {0, 3}; keeping step=1+3
> + * incorrectly narrows the result to 1.
> + * Shifting the same input left by 1 gives {0xfffffff8, 0xfffffffe};
> + * keeping step=0+6 incorrectly narrows the result to 0xfffffffa.
> + */

This isn't a bug, but is 0xfffffffa the right value in the last sentence of
this comment?

0xfffffffa is not on the line 0+6k (0xfffffffa mod 6 == 4).  If step=0+6 were
kept after w2 <<= 1, the range would be [0xfffffff8, 0xfffffffe], and
cnum64_intersect_linear() would round smin up by imod(0 - 2, 6) = 4 and smax
down by imod(2 - 0, 6) = 2, leaving the constant 0xfffffffc, the only
multiple of 6 in that range.

Should this read 0xfffffffc?  The test itself still passes, since it only
checks smax=umax=umax32=0xfffffffe and that step= is absent.

> +SEC("socket")
> +__success __log_level(2)
> +__msg("w0 *= 7 {{.*}}umax=0xffffffff,") __no_step
> +__msg("r2 = r0 {{.*}}R0=scalar({{.*}}step=0+3) R2=scalar({{.*}}step=0+3)")
> +__msg("w0 += 4 {{.*}}smax=umax=smax32=umax32=3,") __no_step
> +__msg("w2 <<= 1 {{.*}}smax=umax=umax32=0xfffffffe,") __no_step


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============0766898026523053831==--
