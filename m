Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC83B6377
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784531180; cv=none; b=MCPB5xvPCMC9nR5+Ah5ysq2SE0YxawP0C24mRjXzu3J07NUvWJkFCERiUTFarrkMeC4x3aJ4iWI8m1EV9UDTIpLWsQ55j7Cuff3H9z2lDnyw0Ger6KreXOdFK/bjw5ELyuTrn//DZi8TOty6JlkpFVi44kyxaq73vtoGao1i5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784531180; c=relaxed/simple;
	bh=VdexnofYEAr4Lr2hYXWousDQrI/PAPYnrFacj8MgVSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MAhXLGi+tu4wIs+Eq84Bdlnow1C3fvOAQt33QQmAMxFn/ES7752Cl0ndacPPOdmoM7pqckDNBWKghYVtbdrnDb/0qWCbUXbEOQ0u3YEXvwDRV/R5NcEyEOo0/CgbKz1ARwYRrM4cVDdG8GLUuJk5LlLzWPodmovKXoJ8a/mHj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iivOt/Iu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iivOt/Iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F2B1F000E9;
	Mon, 20 Jul 2026 07:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784531179;
	bh=ojOsDIdZtf5VzSftSZUapf6wAdvC4KyurHlDxgsU2mI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iivOt/IuF6kInF2ZBMnbWCAxP/+6UAazzy2rZvdZbfRHF75Q5208LFCtoc9NjQirk
	 mu98WoUpDGgiDCkcyIqa4ZXI/jukGpiDE5MxgoM8gb+nLRzSwr72qtqsEeJvDzFMzW
	 NQxYonmO+fPRzKEErFquY01m0nhDo6Y9C1SSA/1sh+T6zzd/Wvcq/nLO3ndvQa8Mat
	 xFKw5x6FL6vYMZyF2VlEibCD4aaNe5zwSTeY4gHgtV4LaFoDQqPeh/rJRLbhjg8rZ/
	 hYD7CTfgELsMf/9XQk4GsWO8yRy8PanZ63NY9uDy48NlgcLpvPF4YsZaQKs7bBAYRn
	 y+ZPpOFbU7vhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] bpf, riscv: fix extable handling for arena
 load_acquire
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720-bpf-riscv-fix-extable-v4-1-165c0b3b07d5@kylinos.cn>
References: <20260720-bpf-riscv-fix-extable-v4-1-165c0b3b07d5@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 07:06:18 +0000
Message-Id: <20260720070619.41F2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The x86 BPF JIT incorrectly handles BPF_LOAD_ACQ instructions in i=
ts exception table population logic, leaving the destination register uncle=
ared on an arena fault and checking the wrong register for arena violations.
--

--- Patch [1]: [PATCH v4] bpf, riscv: fix extable handling for arena load_a=
cquire ---
commit 2540096dc96b56cd6aa635099890caa90920e4b4
Author: Feng Jiang <jiangfeng@kylinos.cn>

bpf, riscv: fix extable handling for arena load_acquire

This commit fixes the exception table handling for arena load_acquire
instructions in the RISC-V BPF JIT. It ensures that the destination register
is cleared on a fault to prevent verifier bypasses and pointer leaks.

Link: https://lore.kernel.org/r/20260720-bpf-riscv-fix-extable-v3-1-e9a6038=
82309@kylinos.cn
Link: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v2-1-421f758=
12533@kylinos.cn
Link: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v1-1-af023cc=
17af4@kylinos.cn

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index f9d5347ba966b..e1519ab4356c1 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1986,7 +1986,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		else
>  			ret =3D emit_atomic_rmw(rd, rs, insn, ctx);
> =20
> -		ret =3D ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
> +		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> +		if (ret >=3D 0)
> +			ret =3D add_exception_handler(insn,
> +				insn->imm =3D=3D BPF_LOAD_ACQ ? rd : REG_DONT_CLEAR_MARKER,
> +				ctx) ?: ret;
> +

[Severity: High]
This is a pre-existing issue, but does the x86 BPF JIT have the exact same
bug that needs fixing?

Looking at do_jit() in arch/x86/net/bpf_jit_comp.c:

				if (BPF_CLASS(insn->code) =3D=3D BPF_LDX) {
					arena_reg =3D reg2pt_regs[src_reg];
					fixup_reg =3D reg2pt_regs[dst_reg];
				} else {
					arena_reg =3D reg2pt_regs[dst_reg];
					fixup_reg =3D DONT_CLEAR;
				}

Since BPF_LOAD_ACQ is encoded with the BPF_STX class, it falls into the else
branch, setting fixup_reg to DONT_CLEAR.

If a BPF program executes a BPF_LOAD_ACQ with an invalid pointer into the
arena memory, causing a page fault, does this leave the destination register
un-zeroed?

Could this bypass the verifier's assumption that it was overwritten by a sa=
fe
scalar, potentially leaking kernel pointers out to userspace?

>  		if (ret)
>  			return ret;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-bpf-riscv-=
fix-extable-v4-1-165c0b3b07d5@kylinos.cn?part=3D1
