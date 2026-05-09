Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877DF2BFC85
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293308; cv=none; b=jKDhBy9NalpIzYongRSK3qXI6NQus9IYbU+7jxsPNx5QMPoZ9Z6xJRCpyRxW3eE3TYpFhQdsCURUhWF7su+JfICdtVcNeBPxDw8Fry/2IaGzSHkFUC4mWu2K6U2tjYRK6WjYJSq6tY2BdnMH42Z6MY6bmKkbiJqN9stx7qr9UA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293308; c=relaxed/simple;
	bh=jI6Il1s5rgziPqD+FRZSMcX5PihBQ888VMGI9lfjGrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8PEPd9Sfmbbl5zKmJFTv82gBqagRRP5ySkIMh0LP6cl5AazCawu+hjmkOMe/FIXEfI9n3NAjOn0L4Kbh90Xs0s9JMERJsiOWZocG8DYUuwMGOxV+N+wG5NLVnDWtrZAZFlxqhTGmvwPKoy7+tQGOOjI/welTFjftSs/PdBpoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAXGQJbb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAXGQJbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F50C2BCB0;
	Sat,  9 May 2026 02:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778293307;
	bh=jI6Il1s5rgziPqD+FRZSMcX5PihBQ888VMGI9lfjGrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DAXGQJbbNZNLRRG4D9I8gAi9V5giqpwymj91/bXQFjjnrnzYM/+82z2Ww7pkU7IQd
	 Wp3JSpTo6wlkHb2URiKuoSrZQs6DHCz6lBfb9wJgr1BOPaO+tHIOD8m+tG43GsCuaD
	 WHgHqIRz4VcSZrxTCYur4WUonMXBXpGRokRzrDHzW1ejJH6ytLrCk8pHCTImjvT6fu
	 pdyXXMCxGXGjRBgkVBlPfdq2xWrNER+ayYJ3P2ryZk+usjPXBWpDQzYs1LvPtws2w1
	 ZNfDZUBU4rGNSc8iRF7EeqYjoIdZBvxf/h2D1badFuzzgLa3cgezxTon+WL0mPHfjx
	 2GBy0AVVL+w8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 15/23] bpf,x86: Implement JIT support for
 stack arguments
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213124.1132088-1-yonghong.song@linux.dev>
References: <20260507213124.1132088-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 02:21:47 +0000
Message-Id: <20260509022147.D0F50C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The offset translation formula for outgoing stack arguments (A=
rgs 7+) negates the BPF offset, reversing the memory layout and causing par=
tial accesses to corrupt the stack.
- [Critical] Immediate stores (`BPF_ST`) of 8, 16, or 32 bits to Arg 6 bypa=
ss the register routing check, writing out-of-bounds to the stack and leavi=
ng Arg 6 uninitialized.
- [Critical] Partial loads and stores (`BPF_LDX` / `BPF_STX`) to Arg 6 unco=
nditionally emit 64-bit register moves, ignoring size semantics and breakin=
g verifier bounds tracking.
- [Critical] Sub-register accesses to Arg 6 bypass exact-offset interceptio=
n, falling through to memory operations that leak the kernel return address=
 or corrupt the stack.
--

commit ee1dd512e669afb6db2ee6c05d9e78b43305dc79
Author: Yonghong Song <yonghong.song@linux.dev>

    bpf,x86: Implement JIT support for stack arguments

This patch adds x86_64 JIT support for BPF functions and kfuncs with more
than 5 arguments. The extra arguments are passed through a stack area
addressed by the R11 register (BPF_REG_PARAMS), with argument 6 being routed
to the R9 register.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ea9e707e8abff..67c2f4a3b9cc3 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -2134,12 +2227,27 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>  				EMIT1(0xC7);
>  			goto st;
>  		case BPF_ST | BPF_MEM | BPF_DW:
> +			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
> +				/* Arg 6: store immediate in r9 register */
> +				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
> +				break;
> +			}

Are stores of 8, 16, or 32 bits to Arg 6 missing the register routing check?
Because BPF_B, BPF_H, and BPF_W sizes jump directly to the st: label, they
appear to skip this R9 check. Could this cause them to mistakenly apply the
stack argument translation and write out-of-bounds, leaving R9 uninitialize=
d?

>  			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
> =20
> -st:			if (is_imm8(insn->off))
> -				EMIT2(add_1reg(0x40, dst_reg), insn->off);
> +st:			insn_off =3D insn->off;
> +			if (dst_reg =3D=3D BPF_REG_PARAMS) {
> +				/*
> +				 * Args 7+: reverse BPF negative offsets to
> +				 * x86 positive rsp offsets.
> +				 * BPF off=3D-16 =E2=86=92 [rsp+0], off=3D-24 =E2=86=92 [rsp+8], ...
> +				 */
> +				insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;
> +				dst_reg =3D BPF_REG_FP;
> +			}

Does subtracting the BPF offset reverse the memory layout within a stack sl=
ot?

If a BPF program accesses the upper 4 bytes of Arg 7 (offset -12), the form=
ula
evaluates to BASE - (-12) - 16 =3D BASE - 4. This points out-of-bounds below
the stack pointer. Similarly, writing to the upper 4 bytes of Arg 8 (-20)
would evaluate to BASE + 4, overwriting the upper half of Arg 7.

[ ... ]
> @@ -2149,7 +2257,17 @@ st:			if (is_imm8(insn->off))
>  		case BPF_STX | BPF_MEM | BPF_H:
>  		case BPF_STX | BPF_MEM | BPF_W:
>  		case BPF_STX | BPF_MEM | BPF_DW:
> -			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
> +			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
> +				/* Arg 6: store register value in r9 */
> +				EMIT_mov(X86_REG_R9, src_reg);
> +				break;
> +			}

Will sub-register stores to Arg 6 bypass this check? If a program writes to
the upper 4 bytes of outgoing Arg 6 (insn->off =3D=3D -4), the exact check =
fails
and it will fall through to memory translation, potentially writing
out-of-bounds.

Also, does EMIT_mov() unconditionally emit a 64-bit move, ignoring the BPF_=
B,
BPF_H, and BPF_W sizes? If a 1-byte store is performed, this might write 64
bits to R9 instead of the intended size.

[ ... ]
> @@ -2248,6 +2366,19 @@ st:			if (is_imm8(insn->off))
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>  			insn_off =3D insn->off;
> +			if (src_reg =3D=3D BPF_REG_PARAMS) {
> +				if (insn_off =3D=3D 8) {
> +					/* Incoming arg 6: read from r9 */
> +					EMIT_mov(dst_reg, X86_REG_R9);
> +					break;
> +				}
> +				src_reg =3D BPF_REG_FP;

What happens if a program reads a sub-register of incoming Arg 6?
If insn_off =3D=3D 12 (the upper 4 bytes), the exact check fails, and src_r=
eg
becomes BPF_REG_FP (rbp). The resulting memory read from [rbp + 12]
corresponds to the upper 4 bytes of the kernel return address, which could
be leaked to the BPF program.

Similarly, if the program performs a partial load of Arg 6 (insn_off =3D=3D=
 8),
EMIT_mov() moves the full 64-bit value from R9. Could this bypass the
verifier's bounds tracking if the verifier assumes the upper 56 bits are
properly zeroed for a 1-byte read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D15
