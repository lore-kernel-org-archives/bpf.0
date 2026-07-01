Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1225DB1A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901085; cv=none; b=jTjXFJWTeBqex28nYYxCyisEBa/6MecxlAg18RP8wC8ds3lQ7DALL22hVzeTNWwft/ymALT+vbfW8BjgN0wYFplI4L1mXroBClqkSL9rjowFO6yS4HH+LhGGgtZ+qYrdmg+clQOvrh5PZvgQx9lJXRSqj6OUwsDcTKnXPdILUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901085; c=relaxed/simple;
	bh=Mx6VIlFmZUMU9tDwA7sWlgZ9jYsQ70rh5VqS+XWiwdo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZB4x7v7KnI5UQ7CB8c61x/3PtuWvRHSjoZOhA6LnL9/Ht1EfDSC2LdWuM5djY34qzugu3OdRqKkjghabh+rTKP2MGxQfmmac3mMd8wmDe3/K1b+dSiLETJ0oWzTkRcHvGzpFlzeL/YPsDnNsOmI9SXeId0KmNSkDbmwU30t4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4f8OpPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4f8OpPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4111F000E9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782901084;
	bh=/mopfRHZiawgnlBMc93PHQyIwsQVhu9bqA4H2lFPgzg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=H4f8OpPC2K5Q7kS0aXCvAiNqwPxmj8H9hQuLPgBwgjt9PTcTfG0waZk8y1y1Gwm9g
	 fBzf6PwPOrPZKiLNu/vdq/x0rsqK6Q/+WbzBtoxsNB3cSo5LX6na5V7s5JWCF1tTu+
	 v6nbs/x18tIY2RqPOTuld0Fw+eIkFYCeISIHUWcu+r/ZW0DIuob7YrMQeXI566F569
	 iA9NfCaZDYDjDiqm4cuIB9lYucoRGA1WLQ9dYZyiA9ZHDRcjBuvZ2Edr0aTtmQ8ojG
	 ZZUxjOqXc1DV4X+gMVFV0Hhevj+Vsef6kNuHBTkp/r6wmnBp5+b37hviJJD64DtXbf
	 yinW2HZ/ey3Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 06/10] bpf, x86: emit KASAN checks into x86
 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701-kasan-v3-6-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-6-bd09bb942d86@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:18:03 +0000
Message-Id: <20260701101804.0E4111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] emit_kasan_check fails to save and restore x86 caller-saved re=
gisters R10 (BPF_REG_AX) and R11 (AUX_REG), causing BPF register corruption.
--

commit f9acd1352526b0ce263a176070ea1146c5f57a4a
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: emit KASAN checks into x86 JITed programs

Insert KASAN shadow memory checks before memory load and store
operations in JIT-compiled BPF programs. This helps detect memory safety
bugs such as use-after-free and out-of-bounds accesses at runtime.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b70cecfec1793..a383ffc8f2899 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2605,14 +2640,14 @@ static int do_jit(struct bpf_verifier_env *env, s=
truct bpf_prog *bpf_prog, int *
>  			}
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
> -		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +		case BPF_STX | BPF_ATOMIC | BPF_DW: {
> +			bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
> +			u32 real_src_reg =3D src_reg;
> +			u32 real_dst_reg =3D dst_reg;
> +			u8 *branch_target;
>  			if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>  			    insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
>  			    insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
> =20
>  				/*
>  				 * Can't be implemented with a single x86 insn.
> @@ -2626,7 +2661,19 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
>  				if (dst_reg =3D=3D BPF_REG_0)
>  					real_dst_reg =3D BPF_REG_AX;
> =20
> +				ip +=3D 3;
> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				err =3D emit_kasan_check(env, &prog, real_dst_reg,
> +						       insn, ip, false,
> +						       accesses_stack_only);

[Severity: Critical]
Does emit_kasan_check() correctly preserve x86 caller-saved registers like =
R10
(BPF_REG_AX) and R11 (AUX_REG)?

Looking at emit_kasan_check(), it saves r8 and r9 before the C function cal=
l=20
but seems to miss saving r10 and r11:

    /* Save rdi */
    EMIT1(0x57);
    /* Save r8 */
    EMIT2(0x41, 0x50);
    /* Save r9 */
    EMIT2(0x41, 0x51);

    /* mov rdi, addr_reg */

Because the x86-64 System V ABI allows C functions like __asan_load* to=20
clobber R10 and R11, failing to save and restore them before the call can=20
corrupt BPF registers.

For example, in the atomic block above, BPF_REG_AX (R10) is used to tempora=
rily
save BPF_REG_0 across the emit_kasan_check() call. If __asan_load* clobbers
BPF_REG_AX, the restored BPF_REG_0 will contain garbage, which could be use=
d to
bypass verifier checks and lead to out-of-bounds kernel memory accesses.

> +				if (err)
> +					return err;
>  				branch_target =3D prog;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-kasan-v3-0=
-bd09bb942d86@bootlin.com?part=3D6
