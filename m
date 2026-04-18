Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCADD2AD10
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776528400; cv=none; b=EdK3LIEuEvoothOs9GMcwZ2/QHNt2BVbywyiKfthOb4dLGQKyHnFyHaZqwVs5BJni8ryZWUGeh3DhIFXdkZyBqSJkH4xOY285rBfm5DGF099/inpYQC7BxGQWoFgpUUyclVmDKEzyb0wQ8HDeUg16bI5aQyr7az4Dg8aFbRObW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776528400; c=relaxed/simple;
	bh=tn6VG3rZkjsluJOYJ4JfqxIqE9osDiRL6pFKGceoJ/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CWZfncMUiYwp5Z6qo7wITMB3oBm+S5+wB2DssgJIpQnW5691u0+K/O4nZioShSx5f5uhegRPZ9zEFPb/eXuVZWwPPK5bblteSHvK5DUbTkQjRNVVMfxJAJCcczXjuaCf1L6xzeKi+PLO82ini6YB0oSdIih6JAW9K7YKUp4l6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgibkN7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgibkN7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E16DC19424;
	Sat, 18 Apr 2026 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776528400;
	bh=tn6VG3rZkjsluJOYJ4JfqxIqE9osDiRL6pFKGceoJ/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tgibkN7kAGwJd91hzlBgiLG7iTsjimSN6kr+ZMzSSMN8nIilSM4jT0dHoYgA5qHI5
	 7IGtXoU2hrR5T6DBW+0YD+F4dx3DkDW08yJl3sPF5QnLqQkFC2nOcpS9rjokkyZpaK
	 e+oNLvKTq8Di9iI3oupdg9vxs95YksCuewtDtxHSfK2JKEZ/y+6pNURNt8a6BeOUSM
	 MMpfDlDJSKjU869MIDMU7zLtHDG8875N0cBEpCCro8/PG+R9LO3uKD1W0i0zqkj2LN
	 Lrv/ZsxIEiYJjmixfTRW0LzQbrdqv8UNbdBA3G9DzYXwjF/hDCmsu/eDU4FsDEQXx3
	 hIL/W7A/wk8lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 6/6] bpf, arm64: Add JIT support for cpu
 time counter kfuncs
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418131614.1501848-7-puranjay@kernel.org>
References: <20260418131614.1501848-7-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 16:06:39 +0000
Message-Id: <20260418160640.6E16DC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Division by zero kernel panic during JIT compilation due to di=
rect read of cntfrq_el0.
- [High] Implicit sign-extension of the 32-bit multiplier corrupts nanoseco=
nd conversions.
- [Medium] Unconditional JIT inlining of timer read bypasses hardware errat=
a workarounds.
- [Medium] Silent 64-bit math overflow for duration measurements exceeding =
1 hour.
--

commit f282b55d9d2af467b0a51264b002bf14ff3648fc
Author: Puranjay Mohan <puranjay@kernel.org>

    bpf, arm64: Add JIT support for cpu time counter kfuncs

This commit adds ARM64 JIT inlining for the bpf_get_cpu_time_counter() and
bpf_cpu_time_counter_to_ns() kfuncs. It emits instructions to read the
architected timer directly and perform the nanosecond conversion.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 0816c40fc7af9..7da7507ab4315 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1571,10 +1573,54 @@ static int build_insn(const struct bpf_verifier_e=
nv *env, const struct bpf_insn
[ ... ]
> +		/* Inline kfunc bpf_get_cpu_time_counter() */
> +		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +		    imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
> +		    bpf_jit_inlines_kfunc_call(imm)) {
> +			/*
> +			 * With ECV (ARMv8.6+), CNTVCTSS_EL0 is self-
> +			 * synchronizing =E2=80=94 no ISB needed.  Without ECV,
> +			 * an ISB is required before reading CNTVCT_EL0
> +			 * to prevent speculative/out-of-order reads.
> +			 *
> +			 * Matches arch_timer_read_cntvct_el0().
> +			 */
> +			if (cpus_have_cap(ARM64_HAS_ECV)) {
> +				emit(A64_MRS_CNTVCTSS_EL0(r0), ctx);
> +			} else {
> +				emit(A64_ISB, ctx);
> +				emit(A64_MRS_CNTVCT_EL0(r0), ctx);
> +			}
> +			break;
> +		}

Does this unconditional JIT inlining bypass the hardware errata workarounds?

The generic C implementation of bpf_get_cpu_time_counter() uses
ktime_get_raw_fast_ns(), which safely respects the out-of-line workaround
framework (CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND). By blindly emitting the
MRS CNTVCT_EL0 (or CNTVCTSS_EL0) instructions, could BPF programs receive
unstable and corrupted timestamps on affected hardware?

> +		/* Inline kfunc bpf_cpu_time_counter_to_ns() */
> +		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +		    imm =3D=3D BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
> +		    bpf_jit_inlines_kfunc_call(imm)) {
> +			u32 freq =3D arch_timer_get_cntfrq();

Could this cause a division-by-zero kernel panic during JIT compilation?

On platforms with broken firmware, the cntfrq_el0 register is often left
uninitialized (0), and the kernel relies on a device tree fallback.
If arch_timer_get_cntfrq() returns 0, will clocks_calc_mult_shift() below
execute a do_div(tmp, freq) and crash the system during BPF program load?

> +			if (freq =3D=3D NSEC_PER_SEC) {
> +				/* 1 GHz counter: 1 tick =3D 1 ns, identity */
> +				emit(A64_MOV(1, r0, r1), ctx);
> +			} else {
> +				u32 mult, shift;
> +
> +				clocks_calc_mult_shift(&mult, &shift, freq, NSEC_PER_SEC, 3600);
> +				emit_a64_mov_i(1, tmp, mult, ctx);

Does emit_a64_mov_i() implicitly sign-extend the 32-bit multiplier?

The emit_a64_mov_i() function takes a signed s32 value as its argument.
For systems with slower timer frequencies, clocks_calc_mult_shift() can
compute a large unsigned 32-bit multiplier whose most significant bit is
set. Will this cause the unsigned multiplier to be implicitly cast to a
negative number and sign-extended to 64 bits, corrupting the subsequent
multiplication?

> +				emit(A64_MUL(1, r0, r1, tmp), ctx);

Will this simple 64-bit multiplication silently overflow for duration
measurements exceeding one hour?

Since clocks_calc_mult_shift() is called with maxsec =3D 3600 (1 hour), the
multiplier is calculated such that delta_ticks * mult fits within 64 bits
up to that duration. For longer durations, could this simple 64-bit
multiplication wrap around, returning falsely small or corrupted nanosecond
durations, unlike the 128-bit math used in the generic kernel timekeeping?

> +				if (shift)
> +					emit(A64_LSR(1, r0, r0, shift), ctx);
> +			}
> +			break;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418131614.1501=
848-1-puranjay@kernel.org?part=3D6
