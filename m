Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B84CF47E
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287271; cv=none; b=tlJIoblxdGPQXjdw63yg5SybE7eE8DYv7fmxe9yKkAWbjk2cyAP/pHudnoM9Y9hcqgwZqpACU+VtiKv3WXpxJ5uWI2HEQT4fEDX9eNwNgW+JvRCzJV4Qv2M3n7jGjZAgamESGuyCKapwFWxg7B1Fcu5fLNB6NvMLAr/09bcchQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287271; c=relaxed/simple;
	bh=VCoZe2kmRZDnTwf3AnYD63GCS5pSJuOBc6Ysr0mRddU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=D3ghpOOi7pC8s8R8ZzMcfFJ1UHmf8tRN+xCpwiWS1g3FFeRRYaNGbCdbKDFQ52+QvZX3IU4SzX8E/5dKdEtwkPxVisjygruw/JzvmzJ2qqt8f8dLHQBug0oHjiPQ2Iiw8gf249dC6jYweUYgdsU4Rv2O7GkRIfz3mXiYkoybKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOFWQCQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOFWQCQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015681F000C4;
	Sun, 18 Oct 2026 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792287270;
	bh=wF5/XRCTsSw78t6XDmdEETt6mUm6jrqUlhVIu7oJ0kQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aOFWQCQv1bNWMoodIM4UQ1qyeA1JtKFORosBy1DYTH2H17ZtF4Yc0toFCOyM6GCRW
	 3Ver9/KFyW+yy0iKSUl5jnMe/BGPX5NeX4792lNKNvjQoK0DY2t6X3b+oVfrnOSr5M
	 EfSFuzKGmLQtT2BnW7ursHF9qLUw0yS2N8YP0pWOCWM1urfETro+HREoFT2hlTSANm
	 TuYwHBzMWRYVeYrhV0qrToRT/SPnoqkYjIlA6NYb4plrVmW5p7RIC44Ipyptr5AsSA
	 GvAnfsecgnL2dSudw4SO1VGa6jNRkS24B4K87SlJRaeYId648GxmRkOBbJb+KZF8JU
	 aoVccIttmJgZA==
Message-ID: <sashiko-outbox-175873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/5] bpf, arm64: Support unwinding via r3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261018010246.1643877-4-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
 <20261018010246.1643877-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 01:34:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf, arm64: stale jump_target in bpf_jit_unwind_exit() skips l=
anding pad
--

commit e9dd702da2c478ecd8523b3f071fba585759acfc
Author: Alexei Starovoitov <ast@kernel.org>

bpf, arm64: Support unwinding via r3

This commit adds arm64 JIT support for unwinding via r3 by replacing the
post-call conditional branch with an exception table entry and rewriting the
return address in the callee frame record upon unwinding exit.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 506c4201fec85..9b702930486a1 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
[ ... ]
> @@ -1781,6 +1863,13 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
>  			emit_kfunc_arg_moves(ctx, fm);
>  		}
>  		emit_call(func_addr, ctx);
> +		if (bpf_jit_unwind_site(env, ctx->prog, i)) {
> +			ret =3D add_unwind_exentry(ctx, i + 2 + insn[1].off);
> +			if (ret)
> +				return ret;
> +			emit(A64_MOV(1, r0, A64_R(0)), ctx);
> +			return 1;
> +		}
>  		/*
>  		 * Call to arch_bpf_timed_may_goto() is emitted by the
>  		 * verifier and called with custom calling convention with
> @@ -1799,6 +1888,13 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
>  		 * counter and the private stack are callee saved.
>  		 */
>  		emit(A64_BLR(dst), ctx);
> +		if (bpf_jit_unwind_site(env, ctx->prog, i)) {
> +			ret =3D add_unwind_exentry(ctx, i + 2 + insn[1].off);
> +			if (ret)
> +				return ret;
> +			emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
> +			return 1;
> +		}
>  		emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
>  		break;
>  	/* tail call */
> @@ -1808,6 +1904,9 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
>  		break;
>  	/* function return */
>  	case BPF_JMP | BPF_EXIT:
> +		unw =3D bpf_jit_unwind_exit(env, ctx->prog, i);
> +		if (unw !=3D BPF_EXIT_RETURNS)
> +			emit_unwind_ret_addr(ctx, unw =3D=3D BPF_EXIT_LOOK_AT_R3);

[Severity: Critical]
Could stale jump_target metadata in env->insn_aux_data cause
bpf_jit_unwind_exit() or bpf_jit_unwind_site() to skip the landing pad when
unwinding?

In build_insn(), bpf_jit_unwind_site() elides the caller's post-call branch
and relies on the callee rewriting its return address via
emit_unwind_ret_addr(). Both bpf_jit_unwind_site() and bpf_jit_unwind_exit()
use bpf_is_jump_target() at JIT time to determine whether an instruction can
be reached by a jump rather than falling through from the preceding
instruction:

kernel/bpf/core.c:bpf_jit_unwind_exit() {
	...
	if (!i || bpf_is_jump_target(env, prog->aux->subprog_start + i) ||
	    insn[-1].code !=3D (BPF_ALU64 | BPF_MOV | BPF_K) ||
	    insn[-1].dst_reg !=3D BPF_REG_UNWIND)
		return BPF_EXIT_LOOK_AT_R3;
	return insn[-1].imm ? BPF_EXIT_UNWINDS : BPF_EXIT_RETURNS;
}

However, env->insn_aux_data[].jump_target is populated during bpf_check_cfg=
()
(which only marks branch targets, not fallthrough edges) and is not preserv=
ed
across post-CFG instruction removal passes in verifier_remove_insns():

kernel/bpf/fixups.c:verifier_remove_insns() {
	...
	memmove(aux_data + off,	aux_data + off + cnt,
		sizeof(*aux_data) * (orig_prog_len - off - cnt));
	env->insn_aux_data_len -=3D cnt;
}

For example, in a subprogram annotated with btf_decl_tag("unwind"):

1. Path A sets r3 =3D 1; goto L, while path B sets r3 =3D 0 and falls throu=
gh to
   L, where L is a conditional branch whose target is dead (such as
   if r6 !=3D 0 goto dead; followed by exit;).

2. bpf_check_cfg() marks L with jump_target =3D true (from goto L), but lea=
ves
   the fallthrough exit at L + 1 with jump_target =3D false.

3. bpf_prune_dead_branches() or bpf_opt_hard_wire_dead_code_branches()
   rewrites L into goto +0 without setting jump_target on L + 1.

4. bpf_opt_remove_nops() -> verifier_remove_insns() removes the NOP at L,
   shifting exit into slot L (so goto L now targets exit directly with
   r3 =3D 1) and overwriting aux_data[L].jump_target with
   aux_data[L + 1].jump_target (false). A similar loss of jump_target can
   happen when bpf_remove_fastcall_spills_fills() turns a jump-target spill
   into NOPs that bpf_opt_remove_nops() removes, or when a NOP before the
   post-call if r3 !=3D 0 goto pad is removed.

When bpf_int_jit_compile() -> build_body() -> build_insn() runs,
bpf_jit_unwind_exit() sees !bpf_is_jump_target() and insn[-1] as r3 =3D 0,
returning BPF_EXIT_RETURNS. As a result, build_insn() omits
emit_unwind_ret_addr() while also eliding the caller's if r3 !=3D 0 goto pad
branch via bpf_jit_unwind_site().

When path A executes at runtime and exits with r3 =3D 1, won't execution by=
pass
the landing pad and fall through into the caller's normal return path where
the verifier assumed r3 =3D=3D 0?

>  		/* Optimization: when last instruction is EXIT,
>  		   simply fallthrough to epilogue. */
>  		if (i =3D=3D ctx->prog->len - 1)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018010246.1643=
877-1-alexei.starovoitov@gmail.com?part=3D3
