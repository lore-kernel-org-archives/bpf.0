Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AA2D8771
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619542; cv=none; b=tm4miA3WA253/4FyAk48TMa/7lTq9eIfPaPor2Zk4vXJ/h9Zzev5l92FVZio8hWaz25pTRRIv+WDfigUHZYvOETOnp7gwuyeY3eaFdzWoLHl+FwYCMTfbJLNb+0BsLDXD/nZGKNsrDb17IEy/1mgDLYySqNUsjD9Ijjj8yvP2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619542; c=relaxed/simple;
	bh=Yuh0786K3gXkjxD1jcxueP3/9+s7Fbh249JZzfdBJgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MfcQyv8ZtE0PGdeb3ayQYBnNp+bI978N/qBkBjuFU0IjLm4acUjRMoXTMQKatlQMIb9N9Ui6uh6D7+bJdX18qWgH9TgIvPWF2xkfFng1S/u0+/2Bk+kZzBqPL/88GGEurs+Yw6fxicO9Q04CCDnsYUSKV3jKxgWgaL9z2P6Sqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3W1OIaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3W1OIaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF59C2BCAF;
	Sun, 19 Apr 2026 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776619541;
	bh=Yuh0786K3gXkjxD1jcxueP3/9+s7Fbh249JZzfdBJgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O3W1OIaKwYAmK50oZQwj4uRlx/TpwqtokoY5K9Rcne5GTztajzllLjeECR3AEWGz9
	 0GNk9xLJpayOqRaSGp8zn+xgIg6PaG+JDHITjjmxW7fqk+z6bTlOd7C3168A1j6x5P
	 JMeo3+suo2A/oc5AhOgJqJ1dqdr7IRcrxt21dCSNHmWVoduqQYdJlgE6Z7rACQMOl0
	 p9F0xpGkKKPGVAm1mQo2jYJBPGu0knS5yfeqYOcJUe9CCVr02YsKQ29x2oev4qvIdf
	 5ap2MTawl9K7NVlJBv5g4Rqb7s91AV1mSHRZy+vaVkC7tCg3jWAU0te/eI5aQFnkTE
	 iBIVkD04ft4Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 14/17] bpf,x86: Implement JIT support for
 stack arguments
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163429.739002-1-yonghong.song@linux.dev>
References: <20260419163429.739002-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:25:41 +0000
Message-Id: <20260419172541.BDF59C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Incoming Arg 6 mapped to volatile R9 is clobbered by calls, ca=
using verifier type confusion.
- [Critical] Sub-register BPF_LDX from incoming Arg 6 incorrectly copies th=
e full 64-bit R9 register, breaking verifier bounds tracking.
- [High] BPF_ST instructions for outgoing Arg 6 miss size checks, causing o=
ut-of-bounds stack corruption and uninitialized arguments.
- [High] Sub-register BPF_STX to outgoing Arg 6 overwrites the entire 64-bi=
t R9 register.
--

commit 16df4bd097c0d6a600a22bdb40ebfc360ece0fc6
Author: Yonghong Song <yonghong.song@linux.dev>

    bpf,x86: Implement JIT support for stack arguments

This commit adds x86_64 JIT support for BPF functions with more than 5
arguments. The extra arguments are passed through a stack area addressed by
register r11 (BPF_REG_PARAMS), mapping Arg 6 to R9 and Args 7+ to the stack.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ea9e707e8abff..06f33fef1e8e1 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -2134,12 +2227,26 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>  				EMIT1(0xC7);
>  			goto st;
>  		case BPF_ST | BPF_MEM | BPF_DW:
> +			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
> +				/* Arg 6: store immediate in r9 register */
> +				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
> +				break;
> +			}
>  			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
> =20
> -st:			if (is_imm8(insn->off))
> -				EMIT2(add_1reg(0x40, dst_reg), insn->off);
> +st:			insn_off =3D insn->off;
> +			if (dst_reg =3D=3D BPF_REG_PARAMS) {
> +				/* Args 7+: reverse BPF negative offsets to
> +				 * x86 positive rsp offsets.
> +				 * BPF off=3D-16 =E2=86=92 [rsp+0], off=3D-24 =E2=86=92 [rsp+8], ...
> +				 */
> +				insn_off =3D outgoing_arg_base - outgoing_rsp - insn_off - 16;

Does this code handle 32-bit, 16-bit, or 8-bit stores to Arg 6 correctly?

The check for dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8 is uniqu=
ely placed
inside the BPF_ST | BPF_MEM | BPF_DW case block. If a BPF program uses a
smaller size store like BPF_W to prepare Arg 6, the code bypasses this check
and falls through to the st: label.

At the st: label, the insn_off calculation equates to RSP - 8 relative to
RBP, emitting a memory store that corrupts unallocated stack memory. In
addition, R9 is never updated, which leaves Arg 6 uninitialized for the cal=
lee.

[ ... ]
> @@ -2149,7 +2256,17 @@ st:			if (is_imm8(insn->off))
>  		case BPF_STX | BPF_MEM | BPF_B:
>  		case BPF_STX | BPF_MEM | BPF_H:
>  		case BPF_STX | BPF_MEM | BPF_W:
>  		case BPF_STX | BPF_MEM | BPF_DW:
> -			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
> +			if (dst_reg =3D=3D BPF_REG_PARAMS && insn->off =3D=3D -8) {
> +				/* Arg 6: store register value in r9 */
> +				EMIT_mov(X86_REG_R9, src_reg);
> +				break;
> +			}

Does this full 64-bit move break semantics for partial writes?

For smaller sizes like BPF_B or BPF_W, EMIT_mov generates a full 64-bit move
that copies all 64 bits from src_reg to R9.=20

BPF semantics dictate that a sub-register store should only modify the
specified lower bytes of the target location, leaving the rest unmodified. =
This
full copy could overwrite data previously stored in the upper bytes of Arg 6
via other partial writes.

[ ... ]
> @@ -2248,6 +2365,19 @@ st:			if (is_imm8(insn->off))
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>  			insn_off =3D insn->off;
> +			if (src_reg =3D=3D BPF_REG_PARAMS) {
> +				if (insn_off =3D=3D 8) {
> +					/* Incoming arg 6: read from r9 */
> +					EMIT_mov(dst_reg, X86_REG_R9);
> +					break;
> +				}

Can R9 be clobbered by function calls when used for Arg 6?

The verifier treats incoming stack arguments as stable memory preserved acr=
oss
function calls. However, under the x86-64 System V ABI, R9 is a caller-saved
(volatile) register.

If a BPF program reads [r11+8] after making a helper, kfunc, or subprog cal=
l,
it will read the clobbered value left in R9. The verifier will incorrectly
track this as the uncorrupted argument, which could cause type confusion.

Additionally, does EMIT_mov(dst_reg, X86_REG_R9) zero-extend sub-register
loads?

This generates a full 64-bit register-to-register move regardless of the lo=
ad
size. For smaller loads like BPF_B, BPF semantics require the value to be
zero-extended.=20

Since the entire 64-bit R9 register is copied without zeroing the upper 56
bits, garbage left by the caller in the upper bits will leak into the
destination register, breaking the bounds tracked by the verifier.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D14
