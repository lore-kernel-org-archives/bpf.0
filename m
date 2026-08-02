Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F33002B3
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706022; cv=none; b=RDp4+tnQYD2o8m5Stf3YPMvxG66oZ1jbJBVSfW7rgWkkQVc+1SS0/IJHz1cmSZBmOV0phXmixCj0FzwVOU+Pxze4h4R06BUwOHGUraienJG87DedoSM3hAbeak60v4ZXFWi1VNauer/LKfDJ3441AN8x4wllax5EBabyG36ZBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706022; c=relaxed/simple;
	bh=1chlNl1XRLfjqdKrcFMLew4xT+OcZkvMIsMeZO1CZ6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjlCCVqM5zesajNU0E6hhkXJ+gfNrtdvpqYBaSyZa7Sbdt0u7iDfFqP0QOtROuhzKndgg1fMa8mCNbL1xlqSt5OlxIqOgMITHc21DDw6hPl5zVSf5OAfyBRqVFropewwhw4SEXYriDwcfdAMNURd/FvqkLwqV5w7gGUm6vnUs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+pr2s2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+pr2s2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46CF1F000E9;
	Sun,  2 Aug 2026 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785706020;
	bh=+Ol4aysKV8GwVUtfpiGZiQRIJG/GJAvlcFhsGJ0fn0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+pr2s2kuJUp4Xe0PH45IJB+FvHdD1ybPdjCY6WyyBt8XicmO5QHzTOPOuZ9SkNmg
	 4498E9HSYpOMlM0yq/vUsfHyAvzxw9zgv375GMu3V0uk7kaQeHb6826Bddsygqwdkz
	 1WMV8TQRLua5idghKP6HbV2lOCBbR6KBusbEAWawDGRdRxAJ/SeIBg6aWU2HkuesOQ
	 vB4EDyjOzIORY/Rr/49a4jbv/gKUxkIHxMrgnvm1NrT2jAPZEG3qPP9CQwgZZlWidh
	 ZzDnnOpSb8SL2TjM7UT/BAXy3u737QlgPTHIq97dFWVBUlwSQ3jhkxxDElNFRykQT4
	 dUbdj44oIw6hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/5] bpf: simplify the bpf_is_reg64()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260802-static-zext-v3-4-3456b2604574@gmail.com>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
 <20260802-static-zext-v3-4-3456b2604574@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 21:26:59 +0000
Message-Id: <20260802212700.A46CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf_is_reg64() fails to identify BPF_ADDR_SPACE_CAST operation=
s with imm =3D=3D 1U << 16 as 32-bit when the arena has BPF_F_NO_USER_CONV =
set, leading to missing zero-extension and possible sandbox escape.
- [Critical] Unconditional overwrite of `zext_dst` destroys manual override=
s for `PTR_TO_ARENA` arithmetic, leading to missing zero-extensions and arb=
itrary kernel memory access.
--

--- Patch [4]: [PATCH bpf-next v3 4/5] bpf: simplify the bpf_is_reg64() ---
commit 4ece654ab9bc1fb0f5d2f2cc247cae7c94f2cb89
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: simplify the bpf_is_reg64()

This commit simplifies bpf_is_reg64() by removing unused parameters,
removing BPF_JMP instructions handling, and streamlining conditions. It
also moves the function to kernel/bpf/fixups.c.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 6125598d16a84..7b3510d46b377 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -44,6 +44,49 @@ static int insn_def_regno(const struct bpf_insn *insn)
>  	}
>  }
> =20
> +/*
> + * For use only in combination with insn_def_regno() >=3D 0.
> + * Returns TRUE if the destination register operates on 64-bit,
> + * otherwise return FALSE.
> + */
> +static bool bpf_is_reg64(struct bpf_insn *insn)
> +{
> +	u8 class =3D BPF_CLASS(insn->code);
> +	u8 mode =3D BPF_MODE(insn->code);
> +	u8 size =3D BPF_SIZE(insn->code);
> +	u8 op =3D BPF_OP(insn->code);
> +	bool mode_mem;
> +
> +	/* subregister endiness swap */
> +	if ((class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) && op =3D=3D BPF_E=
ND && insn->imm !=3D 64)
> +		return false;
> +
> +	/* w0 +=3D 1 */
> +	if (class =3D=3D BPF_ALU && op !=3D BPF_END)
> +		return false;
> +
> +	/* cast from as(1) to as(0), PTR_TO_ARENA is 32-bit */
> +	if (insn->code =3D=3D (BPF_ALU64 | BPF_MOV | BPF_X) &&
> +	    insn->off =3D=3D BPF_ADDR_SPACE_CAST && insn->imm =3D=3D 1)
> +		return false;

[Severity: Critical]
Does this logic miss identifying BPF_ADDR_SPACE_CAST operations with
imm =3D=3D 1U << 16 as 32-bit?

If the arena has BPF_F_NO_USER_CONV set, bpf_do_misc_fixups() rewrites
all BPF_ADDR_SPACE_CAST instructions (including imm =3D=3D 1U << 16) into
a 32-bit MOV to explicitly clear the upper 32 bits.

However, since this falls through and evaluates to 64-bit, the static
liveness analysis evaluates zext_dst to false. When
bpf_opt_subreg_zext_lo32_rnd_hi32() runs, it skips inserting a
BPF_ZEXT_REG zero-extension.

Could this leave the upper 32 bits un-zeroed on architectures requiring
explicit zero-extension for 32-bit operations (e.g., s390x) or that
sign-extend them (e.g., riscv64), leading to out-of-bounds memory accesses?

> +
> +	/* non 64-bit, non signed extended loads */
> +	mode_mem =3D mode =3D=3D BPF_MEM || mode =3D=3D BPF_PROBE_MEM || mode =
=3D=3D BPF_PROBE_MEM32;
> +	if (class =3D=3D BPF_LDX && mode_mem && size !=3D BPF_DW)
> +		return false;
> +
> +	/* atomics, see insn_def_regno() */
> +	if (class =3D=3D BPF_STX && size !=3D BPF_DW)
> +		return false;
> +
> +	/* both LD_IND and LD_ABS return 32-bit data. */
> +	if (class =3D=3D BPF_LD && (mode =3D=3D BPF_IND || mode =3D=3D BPF_ABS))
> +		return false;
> +
> +	/* Conservatively return true at default. */
> +	return true;
> +}
> +
> +/*
> + * Return the 32-bit subregister defined by INSN, or -1 if INSN does not
> + * explicitly define a 32-bit value.
> + */
> +int bpf_insn_def32(struct bpf_insn *insn)
> +{
> +	int dst_reg =3D insn_def_regno(insn);
> +
> +	if (dst_reg < 0 || bpf_is_reg64(insn))
> +		return -1;

[Severity: Critical]
Would this unconditional behavior inadvertently overwrite manual overrides
for PTR_TO_ARENA arithmetic?

During verifier simulation, adjust_reg_min_max_vals() manually forces
aux->zext_dst =3D true on arena arithmetic to ensure zero-extension is
applied by the JIT.

However, the static liveness pass in bpf_compute_live_registers() runs
afterwards and does an unconditional assignment based on def32. Because
bpf_is_reg64() evaluates 64-bit ALU operations as 64-bit, def32 here
becomes -1.

Could this cause the liveness pass to blindly clear the manually set
zext_dst flag to false? If bpf_do_misc_fixups() then rewrites the
instruction to a 32-bit operation, it might miss the necessary zero
extensions, potentially allowing an escape from the arena boundaries.

> +
> +	return dst_reg;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-static-zex=
t-v3-0-3456b2604574@gmail.com?part=3D4
