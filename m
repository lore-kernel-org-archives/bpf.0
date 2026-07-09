Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F33FE37B
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592703; cv=none; b=F05FUUBNZUCSfBSuFHDgbj2imu0E5HkXEudngNBpeDihYKg10UMvfqE63Avkassu/pGq/1CTpPcI2DX53JweWeBCgg7PaMxY4sYsYFkrrXbb7QFjtFj4o6hb7r+P9xUhbDpOTqOvJCWcGEh/aHl/qsZqKbhQ2gd6vxsJMXsBF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592703; c=relaxed/simple;
	bh=8FJu5p3y56PRuJ66yfzz5LDz8xcB24W8UvkcEMjYrtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uqk7PU2V5SlE+0GfVFHvViH4iIiw8p41/hhtXrqCJOzNHY5MXvBZxo30HXB4AURYVOBOEzwag5sFn9h7+e9ElEZO2bNTbc1PXt0EQNJiqsjJnShAEBlOohq6246kNv28yqim2f6jOL1x4aMYt9VKZSrlY1IIQ3tZ59YyXefmFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5vaXt3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5vaXt3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C651E1F000E9;
	Thu,  9 Jul 2026 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783592702;
	bh=aeGzDTd3atPOF4GNo1CVIYWvWHizSHfxehtvh3Zb45g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5vaXt3Q0l/xK+EkyG8hNGYEw3hkzb9VPRmMROz+9dY/W29W8ov0fV3+L6em0cHC/
	 XA7XZ0ucktd7s9oBAh3DVfPYn66u5EG8jFqjOS0GJyPtIavMZtsM83fAXyyd0wdLKp
	 e5VHxQpYRjgqZxC1dGK/Dr848pNxH7HgPLrLXdIexIMEvbhyNrDj54vbvfPw5xM2rN
	 IMl8dBPeZgk0n9gMfYpaTuyEMQp0GX813pG7oGbeygExlBSF6CrADsxDs+sdvAXC02
	 Llkj7qs/SvfW9VoinsgvbGY5MAzZ7TVRcqVDce+ISuzIzdYmB2zRHS6aiVe2OTrKb4
	 JbsHHZaXq4uyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 01/10] bpf: propagate original instruction
 offset when patching program
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-1-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-1-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:25:01 +0000
Message-Id: <20260709102501.C651E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect `insn_off_in_patch` offset passed during instruction r=
ewrites for pointer arithmetic, may_goto, and LD_ABS/LD_IND.
--

--- Patch [1]: [PATCH bpf-next v5 01/10] bpf: propagate original instructio=
n offset when patching program ---
commit 93b475f9be8b7e4db55e416665410ec667566b5a
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: propagate original instruction offset when patching program

This commit updates the BPF verifier to propagate the original instruction's
offset within a patch when calling bpf_patch_insn_data and
adjust_insn_aux_data. This information is needed to correctly map auxiliary
instruction data (like KASAN markings) after instructions are rewritten.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index d3be972714b22..188ea6205d617 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -1689,7 +1705,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  				return -EFAULT;
>  			}
> =20
> -			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf,
> +						       cnt, 0);

[Severity: Medium]
For LD_ABS and LD_IND rewrites, the original instruction is completely
replaced by the generated instructions. Should insn_off_in_patch be
set to -1 here instead of 0, to avoid incorrectly identifying the first
setup instruction as the original one?

[ ... ]

> @@ -1742,7 +1759,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  				*patch++ =3D BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
>  			cnt =3D patch - insn_buf;
> =20
> -			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf,
> +						       cnt, cnt - 1);

[Severity: Medium]
In this pointer arithmetic mitigation, if a trailing MUL instruction is
appended (when issrc && isneg && !isimm are true), the original instruction
ends up at cnt - 2 instead of cnt - 1. Does passing cnt - 1 here risk
misidentifying the appended MUL instruction as the original instruction?

[ ... ]

> @@ -1787,7 +1805,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  			insn_buf[6] =3D BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off=
_cnt);
>  			cnt =3D 7;
> =20
> -			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf,
> +						       cnt, 3);

[Severity: Medium]
For timed may_goto, the arbitrary offset 3 points to an intermediate JNE
instruction rather than the original instruction, since the original is
fully replaced. Should this pass -1 instead of 3?

[ ... ]

> @@ -1808,7 +1827,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  			insn_buf[3] =3D BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off=
);
>  			cnt =3D 4;
> =20
> -			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf,
> +						       cnt, 2);

[Severity: Medium]
Similarly, for non-timed may_goto, the offset 2 points to a SUB instruction.
Since the original may_goto is entirely replaced, would it be more accurate
to pass -1 here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D1
