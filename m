Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7C4A5EA4
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145254; cv=none; b=Hp45bPE6HtqMwp661/eYg57JPXWpb+rHdC8K5vTh5EtLVTHmhBDyq5+6OntxO5tJrO5CvxPkPbg+cybqTvXX2QvdOPa9d0/cxfzsXMAEeTT++/IzJvck57xHkXIJNv8iPgNuO6+pDQMwMD2LyFMgNPCa6e7mYL7/bSILEOH01mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145254; c=relaxed/simple;
	bh=1/z0FLX5c8MJjvVq/dpeMWmoF0X0PfQG7i2EqIyD/3k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b0bQ7x1UgkZ8IUYWV0F2KTZswEDSeXkMjtK/A5HTgtppc4IewIu7aWhQ5w0RCE1FMUxQrYGCQikyHKodFpyo5i0qQJWjkDHB6L2inxhOBx04C2GXSyU89g6nb5W7MXo+bd2awSdibXbTe0mlOTFHuGOXabp9WwvgUBc6Idxxvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR96Tv/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR96Tv/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22CD1F0089E;
	Fri, 11 Sep 2026 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145252;
	bh=ui0DsrL76pV2XfyMfunOw8f6wffi1W14CiLCT5Q1PgU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mR96Tv/gtB4+rxGchCrFOwntPa1PhlYSxCulNIglPaAiFSZC1yaoErtHuQsEMKfTo
	 CE9YT8nvzXdBNjUTeJRfkSHDyxv0Cdd96Oy8oexuwqJ5ondPmrQMZoF3WaOIBVYBzX
	 W6kGulljxhq1O8GdX7LvChXHPluPiX5RMx8j8G++8mnvaERNy8mElYESCmpAn3xee9
	 06m+t/eYfYQ1LqoSKXu6WoSphAXUng4lMgyHXZ78lRuGJDAgnTGZ3yLermxZZNZo2u
	 AWx3bhnhubImLvhn0BLnIMpEBTtcJKHyh+usafvWfHBSP/c6ezOXEjnUc98PctTFid
	 g9/AF14BsnQ+A==
Content-Type: multipart/mixed; boundary="===============5538768161035505225=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0b84d8722fb6870aa98302b2ee8a71a0be1da1f4925204529c5545a66e1a4ba1@mail.kernel.org>
In-Reply-To: <20260911155005.2010021-1-yonghong.song@linux.dev>
References: <20260911155005.2010021-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 10/15] bpf, x86: Move kfunc arguments into the x86-64 calling convention
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 16:47:31 +0000 (UTC)

--===============5538768161035505225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index bba351944202..0496607a7003 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1839,6 +1839,60 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
>  	return 0;
>  }
>
> +static const struct bpf_jit_arg_abi x86_arg_abi = {
> +	.nr_arg_regs		= 6,
> +	.backfill_after_stack	= true,
> +	.even_stack_align	= true,
> +};
> +
> +static const u8 x86_arg_reg[] = {
> +	BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5, X86_REG_R9,
> +};
> +
> +/*
> + * Move the arguments the x86-64 ABI places somewhere other than the argument
> + * slot the BPF calling convention gave them. @stack_base addresses the
> + * outgoing stack argument area from RBP. Return the number of emitted bytes.
> + */
> +static int emit_kfunc_arg_moves(const struct btf_func_model *fm, s32 stack_base, u8 **pprog)
> +{
> +	struct bpf_jit_arg_move moves[BPF_JIT_MAX_ARG_MOVES];
> +	const u8 nreg = x86_arg_abi.nr_arg_regs;
> +	u8 *prog = *pprog, *start = prog;
> +	u32 i, n;
> +
> +	n = bpf_jit_plan_arg_moves(&x86_arg_abi, fm, moves);
> +
> +	for (i = 0; i < n; i++) {
> +		u8 dst = moves[i].dst, src = moves[i].src, reg;
> +		bool dst_mem = dst != BPF_JIT_ARG_TMP && dst >= nreg;
> +		bool src_mem = src != BPF_JIT_ARG_TMP && src >= nreg;
> +
> +		/* Take the value into a register. */
> +		if (src == BPF_JIT_ARG_TMP) {
> +			reg = AUX_REG;
> +		} else if (src_mem) {
> +			reg = dst_mem || dst == BPF_JIT_ARG_TMP ? BPF_REG_AX : x86_arg_reg[dst];
> +			emit_ldx(&prog, BPF_DW, reg, BPF_REG_FP,
> +				 stack_base + (src - nreg) * 8);
> +		} else {
> +			reg = x86_arg_reg[src];
> +		}
> +
> +		/* And leave it where the argument belongs. */
> +		if (dst == BPF_JIT_ARG_TMP)
> +			emit_mov_reg(&prog, true, AUX_REG, reg);

This isn't a bug, but for the memory-source case, could reg be AUX_REG when
dst == BPF_JIT_ARG_TMP so the load lands directly in the scratch instead of
going through BPF_REG_AX?

The case is reachable: a prototype such as (u64 a..e, struct {u64; u64;}
s, u64 f) backfills f into R9 and hands the planner a down-move whose
source is a stack slot. With the current code, emit_kfunc_arg_moves()
generates:

    mov r10, [rbp+off]
    mov r11, r10

when this would do:

    mov r11, [rbp+off]

Picking AUX_REG when dst == BPF_JIT_ARG_TMP (and BPF_REG_AX only for the
memory-to-memory case) would drop the extra instruction from every such
call site.

> +		else if (dst_mem)
> +			emit_stx(&prog, BPF_DW, BPF_REG_FP, reg,
> +				 stack_base + (dst - nreg) * 8);
> +		else if (reg != x86_arg_reg[dst])
> +			emit_mov_reg(&prog, true, x86_arg_reg[dst], reg);
> +	}
> +
> +	*pprog = prog;
> +	return prog - start;
> +}

[ ... ]

> @@ -2837,6 +2897,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  				if (err < 0)
>  					return err;
>  				ip += err;
> +				ip += emit_kfunc_arg_moves(fm, outgoing_arg_base -
> +							   outgoing_rsp, &prog);
>  			}

[ ... ]

>     bpf, x86: Move kfunc arguments into the x86-64 calling convention
>
>     Do the proper move from the BPF calling convention to the x86-64 calling
>     convention to satisfy the native requirement.

This isn't a bug, but could the changelog name the case that actually
needs a move (a by-value argument spilling to the stack followed by a
backfilled register argument) and note that at most one argument moves
down, so the scratch register carry is safe?

The current wording says what the patch does without saying which
arguments actually end up somewhere other than their BPF slot, or why a
reviewer has to reconstruct that from bpf_jit_place_args() and
bpf_jit_plan_arg_moves().

>     In addition, the arena argument walk counts eightbytes rather than
>     parameters, as an argument may take two registers.

(This second paragraph reads well and is concrete.)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527
--===============5538768161035505225==--
