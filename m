Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55D2E06E4;
	Tue, 13 Oct 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896137; cv=none; b=pLReeZU9f7ymOmeLvfpCZmN2hDFnGYbq9BPwDnnPJWsWWczU/4diqJD6ItoV7RIb39L98Pwf9Uy7slfSb1IsMZzigzgwqFaMXLNz9UxbUWRxgCPnawG0lUBw+zJkav0pLbDnmGoB3W25m0yT7vNkPNZL0Jok+d14EkuFjhH/yMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896137; c=relaxed/simple;
	bh=4hOGlWDI5HWkZbDBQRET2Fxee0zSOGc4EjqmuF05r80=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AjjmhB0HMKJIwU+kUVLzhEV2RXOPMhgNg9D7g0/R7XVdDMzztSzqNVk3pGPohX+vEAhsB60XXeQ2cFAYSDNX5aOmRPEMe2Q42c5nks7wRx/adQV8RL62JOCaB06lKnZqSzG0SghvgluN2V5KXG1PBBMCrVnYleyil/3J2vvvQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHxM7vfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHxM7vfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E141F00893;
	Tue, 13 Oct 2026 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791896136;
	bh=bLACkm8QjLtvgdrWg5Cs24vdQLpzXUAMiAF017A7tcw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NHxM7vfyD6/R1ywGsksQSG/bJzCAGOWLgbtqvSKmadsfTUEtZe4Crg/GNmPH+iUNj
	 VLp73GOrkJxRQdcXX6/S1XEPj9Bef5YwlMUsjNSdGprCSD86NsGt/QK2i5wceleiux
	 /5Lh/Uv5fTT3/CJLa4aIyEU4iJx65qHRfNKk9yYJQVywx/4UzW/vX4QGW0dVGgQ40k
	 Z2IQefCqUXzd5iKvUt44E3/P4ecAhd6XadbwtD0cbl1LH2+/a2Ga2Lu8NjG7Qg8oca
	 pobhum4nz6r25Rx4VC/G0auZl0stvLfef6rkIwV0wJdOqfFSO7/t/CnEqsPty+gUNv
	 8zajDaEGesaVw==
Content-Type: multipart/mixed; boundary="===============5214291219682700347=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab9326a4770f9d1ac812e55feb39e34341d84951f3b5d276dee18d5471d8353e@mail.kernel.org>
In-Reply-To: <20261013121005.626-3-yangtiezhu@loongson.cn>
References: <20261013121005.626-3-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 2/2] LoongArch: BPF: Optimize 32-bit operations using native instructions
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 12:55:35 +0000 (UTC)

--===============5214291219682700347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> LoongArch: BPF: Optimize 32-bit operations using native instructions

TL;DR: LoongArch BPF JIT now feeds non-sign-extended operands to 32-bit
div/mod; on cores without DIV32 (e.g. 3A5000) results may be wrong, possibly
breaking verifier-proven bounds.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -752,212 +741,232 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>
>  	/* dst = imm */
>  	case BPF_ALU | BPF_MOV | BPF_K:
> +		move_imm(ctx, dst, (u32)imm);
> +		return 0;

[ ... ]

>  	/* dst = dst / src */
>  	case BPF_ALU | BPF_DIV | BPF_X:
> +		if (!off)
> +			emit_insn(ctx, divwu, dst, dst, src);
> +		else
> +			emit_insn(ctx, divw, dst, dst, src);
> +		break;
>  	case BPF_ALU64 | BPF_DIV | BPF_X:
> -		if (!off) {
> -			emit_zext_32(ctx, dst, is32);
> -			move_reg(ctx, t1, src);
> -			emit_zext_32(ctx, t1, is32);
> -			emit_insn(ctx, divdu, dst, dst, t1);
> -			emit_zext_32(ctx, dst, is32);
> -		} else {
> -			emit_sext_32(ctx, dst, is32);
> -			move_reg(ctx, t1, src);
> -			emit_sext_32(ctx, t1, is32);
> -			emit_insn(ctx, divd, dst, dst, t1);
> -			emit_zext_32(ctx, dst, is32);
> -		}
> +		if (!off)
> +			emit_insn(ctx, divdu, dst, dst, src);
> +		else
> +			emit_insn(ctx, divd, dst, dst, src);
>  		break;

Can divw/divwu be used directly on dst and src here?

The LoongArch ISA only defines the result of div.w, div.wu, mod.w and
mod.wu on LA64 when both rj and rk hold sign-extended 32-bit values.  The
exception is a core that reports CPUCFG2_DIV32 (BIT(26) in
arch/loongarch/include/asm/loongarch.h), where the upper 32 bits of the
inputs are ignored.  Cores without that bit, such as the LA464 in the
3A5000, may return any value otherwise.  Nothing in the JIT checks for
CPUCFG2_DIV32.

The operands here are often not sign-extended.  Every ALU32 result is now
zero-extended at the common exit of build_insn():

> +	if (is32)
> +		emit_insn(ctx, bstrpickd, dst, dst, 31, 0);
> +
>  	return 0;

so any 32-bit value with bit 31 set is left in the register as
0x00000000xxxxxxxx.  A BPF_LDX | BPF_W load (ldwu) is zero-extended in the
same way, and src can hold arbitrary upper bits coming from ALU64 ops or
pointers, since ALU32 only consumes the low 32 bits.

For example, with w0 = -6 followed by w0 s/= 3, rj is 0x00000000fffffffa
when divw executes, so the quotient is not guaranteed to be -2 on a core
without DIV32.  Likewise, a ldwu of 0xffffffff followed by w1 %= 16 gives
modwu a rj that is not a sign-extended value.

The old code widened both operands (zext for unsigned, sext for signed)
and then used the 64-bit divdu/divd/moddu/modd, which are well defined on
every LA64 core.  The MIPS64 JIT, which has the same ISA restriction,
still sign-extends the operands before its 32-bit div/mod.

[ ... ]

>  	/* dst = dst / imm */
>  	case BPF_ALU | BPF_DIV | BPF_K:
> +		move_imm(ctx, t1, (u32)imm);
> +		if (!off)
> +			emit_insn(ctx, divwu, dst, dst, t1);
> +		else
> +			emit_insn(ctx, divw, dst, dst, t1);
> +		break;

In the K forms the divisor is built with move_imm(ctx, t1, (u32)imm), so a
negative signed divisor, or an unsigned divisor of 0x80000000 or above,
also ends up in t1 as a zero-extended value rather than a sign-extended
one.

[ ... ]

>  	/* dst = dst % src */
>  	case BPF_ALU | BPF_MOD | BPF_X:
> +		if (!off)
> +			emit_insn(ctx, modwu, dst, dst, src);
> +		else
> +			emit_insn(ctx, modw, dst, dst, src);
> +		break;

[ ... ]

>  	/* dst = dst % imm */
>  	case BPF_ALU | BPF_MOD | BPF_K:
> +		move_imm(ctx, t1, (u32)imm);
> +		if (!off)
> +			emit_insn(ctx, modwu, dst, dst, t1);
> +		else
> +			emit_insn(ctx, modw, dst, dst, t1);
> +		break;

The same question applies to the modwu/modw uses in these two cases.

The verifier narrows 32-bit div/mod results, for example
scalar32_min_max_umod() bounds the result of w1 %= 16 to [0, 15].  If the
JITed code returns a different value on a core without DIV32, can the
program end up with a value outside the range the verifier proved, for
instance when it is used as a map value offset?

The commit message reports test_bpf, test_verifier and test_progs passing,
but does not say which CPU was used.  Would those results be reproducible
on a core without CPUCFG2_DIV32?

Would it be better to sign-extend both operands into temporaries (for
example addw t, reg, $zero) before divw/divwu/modw/modwu, to gate the
native 32-bit forms on CPUCFG2_DIV32, or to keep the previous 64-bit
sequence for these four opcodes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38397948534
--===============5214291219682700347==--
