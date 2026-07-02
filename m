Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA24C6D
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960535; cv=none; b=GDZs8DHftPmG77doZLxCOVIOO2aeRXF3r9f6NiSH0gS0F+rSVMbuKlGsP73r9u2IIRTVixo6m36AZb9Mt5/4WCjD8nUSW5pein+Tu7q+f00GPGgU6wK90S3WVM2raq7DNnSam3DHJDI5ngPxxZ8gS5xUimghVgxvHtm9EMTDK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960535; c=relaxed/simple;
	bh=9J3nWDqQWBcGS/xuCy/SBbKRbomcll2Gp07wNmkL1/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pRZI1nlItUuqSEAIFaEDFFV0YUj36jTA7Ft7IX8g33SaGRWtjVi7VnP4W01xtanTME6SSdNqF7NYr/iWzCw4vnz29RtsAoAEIsr93+KCbg4XflEltVsli41MR/AiqcSu5xpLV0e6X3KO6ikDHbs81Vou0qYPWtdKLADGqvVQ6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHFX/RY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHFX/RY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65831F000E9;
	Thu,  2 Jul 2026 02:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782960534;
	bh=EsfMQlQ5dG/Wiz84985U65fzI2SuyE0w1cKUoY/yyEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHFX/RY0+L4r1qFq5Tti1jBuPmEIgwKwwPc9W7oMyDf2tdZyi5KZqmmxiMvFUz1PS
	 tjzmQ5K6OmxlVWpRaBUuAH5s/i2/XWQ2a/dtpg2ZdzBfHcA80qyk+X60aypoF/NjFF
	 E8rBTdGEbUS5jgr8v1ny+qAUw0Msgq4GmrZLtJv50YezL8Mf7PQQVhNFlfnn4hiPhK
	 8ryJVn7VjM+nzjyTNl4PMNhB8RSKwStUipMWY2+opadJV7cnSURlLWBoi10R0sTQ8/
	 zFQlQ6CdzV8ll9lp3fI7IycyT9jBZ8xR/EACKPd6qZMZryGzK2XSCyU+ntSnhgt1st
	 nkqe8RkBFM3ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/11] LoongArch: BPF: Support atomics on
 arena pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702022322.51033-8-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
 <20260702022322.51033-8-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:48:53 +0000
Message-Id: <20260702024853.D65831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Faulting arena atomic operations fail to clear their destinati=
on registers, defeating the verifier's zero-extension tracking and enabling=
 arbitrary out-of-bounds memory access.
- [High] Missing exception table entry for the `sc` (Store Conditional) ins=
truction in `BPF_PROBE_ATOMIC` `cmpxchg` allows trivial kernel panics.

Pre-existing issues:
- [High] LoongArch's `ex_handler_bpf` does not report arena violations, bre=
aking standard BPF arena semantics.
--

commit 445332124b454806c0eb995caa9dad9e7668feba
Author: George Guo <guodongtai@kylinos.cn>

LoongArch: BPF: Support atomics on arena pointers

This commit implements atomic operations on arena pointers (BPF_PROBE_ATOMI=
C)
for LoongArch. It adds exception table entries to handle page faults for
these memory accesses.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 4a3b632c1fde5..a7f2d45aef751 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -585,12 +600,14 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>  	case BPF_CMPXCHG:
>  		move_reg(ctx, t2, r0);
>  		if (isdw) {
> +			ll_idx =3D ctx->idx;
>  			emit_insn(ctx, lld, r0, t1, 0);
>  			emit_insn(ctx, bne, t2, r0, 4);
>  			move_reg(ctx, t3, src);
>  			emit_insn(ctx, scd, t3, t1, 0);

[Severity: High]
Does this Store Conditional (scd) instruction need an exception table entry?
If a BPF program executes a BPF_CMPXCHG operation on a read-only or=20
Copy-On-Write (COW) arena page, the Load Linked (lld) instruction will
succeed because it is a read, but the subsequent Store Conditional
instruction could trigger a page fault due to the write violation. Since
there is no exception table entry registered for this scd instruction,
would this result in an unhandled kernel page fault oops?

>  			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);
>  		} else {

[ ... ]

> @@ -600,12 +617,42 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>  			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
>  			emit_zext_32(ctx, r0, true);
>  		}
> +		/*
> +		 * On arena the ll may fault (unmapped page); the page-fault
> +		 * handler restarts the program at @resume.  Only the ll needs an
> +		 * entry: if it faults the sc is never reached, and once the ll
> +		 * succeeds the page is mapped so the sc cannot fault.  Resume
> +		 * past the whole ll/sc loop.
> +		 */
> +		if (arena) {
> +			ret =3D __add_exception_handler(insn, ctx,
> +						      REG_DONT_CLEAR_MARKER,
> +						      ll_idx, ctx->idx);

[Severity: Critical]
Should the actual destination register (r0) be cleared here instead of
using REG_DONT_CLEAR_MARKER? If a fault occurs on the arena pointer, the
destination register retains its old value instead of being cleared.
Because the verifier assumes the register has been bounded (e.g., upper
32-bits zeroed), leaving the hardware register with an unbounded value
might allow out-of-bounds memory accesses.

> +			if (ret)
> +				return ret;
> +		}
>  		break;
>  	default:
>  		pr_err_once("bpf-jit: invalid atomic read-modify-write opcode %02x\n",=
 imm);
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * For the single-instruction am* ops the memory access is the last
> +	 * emitted instruction; register its exception entry before emitting the
> +	 * deferred zero-extend so the fault resumes past it.  cmpxchg handled
> +	 * its own entry above.
> +	 */
> +	if (arena && imm !=3D BPF_CMPXCHG) {
> +		ret =3D __add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER,
> +					      ctx->idx - 1, ctx->idx + (zext ? 1 : 0));

[Severity: Critical]
Is it safe to pass REG_DONT_CLEAR_MARKER for fetch atomics? Similar to
the cmpxchg case, if an exception occurs on an invalid arena pointer,
the source register is not cleared. This can cause a divergence from
the verifier's zero extension tracking and potentially allow out-of-bounds
memory accesses.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (zext)
> +		emit_zext_32(ctx, src, true);
> +
>  	return 0;
>  }

[ ... ]

> @@ -616,10 +663,37 @@ static int emit_atomic_ld_st(const struct bpf_insn =
*insn, struct jit_ctx *ctx)
>  	const u8 dst =3D regmap[insn->dst_reg];
>  	const s16 off =3D insn->off;
>  	const s32 imm =3D insn->imm;
> +	const bool arena =3D BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC;
> +	int ret;
> =20
>  	switch (imm) {
>  	/* dst_reg =3D load_acquire(src_reg + off16) */
>  	case BPF_LOAD_ACQ:
> +		if (arena) {
> +			/* t1 =3D src + off + arena_vm_start; load from [t1]. */
> +			move_imm(ctx, t1, off, false);
> +			emit_insn(ctx, addd, t1, src, t1);
> +			emit_insn(ctx, addd, t1, t1, REG_ARENA);
> +			switch (BPF_SIZE(insn->code)) {
> +			case BPF_B:
> +				emit_insn(ctx, ldbu, dst, t1, 0);
> +				break;
> +			case BPF_H:
> +				emit_insn(ctx, ldhu, dst, t1, 0);
> +				break;
> +			case BPF_W:
> +				emit_insn(ctx, ldwu, dst, t1, 0);
> +				break;
> +			case BPF_DW:
> +				emit_insn(ctx, ldd, dst, t1, 0);
> +				break;
> +			}
> +			ret =3D add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER);

[Severity: Critical]
Could we pass the actual destination register rather than
REG_DONT_CLEAR_MARKER here? If the load acquisition faults on an unmapped
arena pointer, the destination register will not be cleared. The verifier
expects it to be cleared or bounded, which could allow out-of-bounds
memory reads if the register keeps its prior unbounded value.

> +			if (ret)
> +				return ret;
> +			emit_insn(ctx, dbar, 0b10100);
> +			break;
> +		}

[ ... ]

> @@ -708,10 +807,6 @@ static bool is_signed_bpf_cond(u8 cond)
>  	       cond =3D=3D BPF_JSGE || cond =3D=3D BPF_JSLE;
>  }
> =20
> -#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
> -#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
> -#define REG_DONT_CLEAR_MARKER	0
> -
>  bool ex_handler_bpf(const struct exception_table_entry *ex,
>  		    struct pt_regs *regs)
>  {
> @@ -725,12 +820,21 @@ bool ex_handler_bpf(const struct exception_table_en=
try *ex,
>  	return true;
>  }

[Severity: High]
This is a pre-existing issue, but does ex_handler_bpf() need to report
arena violations to user space? If a BPF program accesses an out-of-bounds
arena pointer (such as the guard bands), this handler clears the
destination register and resumes execution without delivering a SIGSEGV.
Standard BPF arena semantics usually require calling
bpf_prog_report_arena_violation() in this path to ensure the user space
process is properly signaled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702022322.5103=
3-1-dongtai.guo@linux.dev?part=3D7
