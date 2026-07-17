Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632D378D71
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316435; cv=none; b=Tf2aI2ME68EHSkFzmkv06JKLVZ7JVoiStJ6u4CidrvDWFt5LUmpc19GhRYNljysPhyq27r6+cnrCeAzGBj/zoEYuj2rC7/d0gA69Jn5OjnZP5tCDx98Y/9xOjcv0o1L802dzvVEOYgt0EuJh66XrnWmxNnISzSUwGXI1vL9XX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316435; c=relaxed/simple;
	bh=zFJ09XcFlZo+WYkNLEs3PyynEA8enOMYFwQkd+w5o5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cUOLIxxWYGOUdFkmrD7l/1UEB9pgPuEbc3D8MO9V8kOjIMJIgagYtpYF4/EBMNwMdjuwfIOZwRi+uQWzGjJ29pn5sO+u5E1FEq65jcxgX/Gl8h2bBNQlHObWDNGM8Z+whzdQyNWQzSVKhse3J+JcORrf62JrSGJ++tUSDbdWkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmZYp3dI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmZYp3dI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C241F000E9;
	Fri, 17 Jul 2026 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784316434;
	bh=YzlyMAMUSBb3envnQrltVFS+hUwIhIe6QvEyppFZJWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmZYp3dIj1cKh6Hy6rwvf8Dd0I4VWZWqu6WVmPtZh9aHHUZaDN/dDEUnC/sUJ4Pgd
	 scAGLhdDmhyFbPSVBY5HxBSxHCskrDnefMEuDRJ3eLsa0jE5qKpSn74ZNbTouicOFn
	 qOEVkXRyigpm8H/fMyccxuRBxXN3AFXkYVI6kWJLI5pVysjymwwDVrGn0pp2FwtnqO
	 9iQp4XdDahByBaJszbDZpRK6z4sD4aUH77ApThA7hEUTDHRvOQjuGzg+oVvi8H8U8R
	 SKXDjdhiWT0TI4Bni7Izkvjc5TVtaDr6w/6vXdrMk7svGM5hN/7GED2r6g+V7cyfXe
	 +Uyx48J2FHsbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf, parisc: Add support for BPF_SDIV and
 BPF_SMOD in the parisc32 JIT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicholas Dudar" <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717190544.257306-3-main.kalliope@gmail.com>
References: <20260717190544.257306-1-main.kalliope@gmail.com>
 <20260717190544.257306-3-main.kalliope@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:27:13 +0000
Message-Id: <20260717192714.25C241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The parisc32 JIT silently miscompiles the BPF_MOVSX (move with sig=
n extension) instruction, treating it as a standard move.
- [High] `emit_call_libgcc_ll()` swaps the high and low 32-bit words of 64-=
bit arguments when passing them to libgcc helpers.
--

--- Patch [2]: [PATCH bpf-next 2/2] bpf, parisc: Add support for BPF_SDIV a=
nd BPF_SMOD in the parisc32 JIT ---
commit ef16e681a3d01d651d08cd8250b0ccd28e9d3647
Author: Nicholas Dudar <main.kalliope@gmail.com>

bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc32 JIT

emit_alu_r32() and emit_alu_r64() call the unsigned millicode
($$divU/$$remU) and libgcc-style (hppa_div64()/hppa_div64_rem())
divide/remainder helpers for BPF_DIV and BPF_MOD regardless of the
BPF instruction's signedness, so the parisc32 JIT does not implement
signed BPF_SDIV and BPF_SMOD (off =3D=3D 1). Signed ALU32 and ALU64
div/mod get an unsigned quotient and remainder rather than the
verifier's and the interpreter's signed result for negative operands.

Thread is_signed =3D (insn->off =3D=3D 1) through emit_alu_r32()/
emit_alu_r64(), and on the signed path use the $$divI/$$remI signed
millicode routines (32-bit) or the hppa_sdiv64()/hppa_sdiv64_rem()
helpers added in patch 1 (64-bit) instead of their unsigned
counterparts. $$divI and $$remI are extern-declared and exported next
to $$divU/$$remU in arch/parisc/kernel/parisc_ksyms.c.
bpf_do_misc_fixups() rewrites the zero-divisor and INT_MIN/-1 cases out
of the instruction stream before the JIT runs.

> diff --git a/arch/parisc/net/bpf_jit_comp32.c b/arch/parisc/net/bpf_jit_c=
omp32.c
> index 5ff0cf925fe95..eea0a34a3bfee 100644
> --- a/arch/parisc/net/bpf_jit_comp32.c
> +++ b/arch/parisc/net/bpf_jit_comp32.c
> @@ -562,12 +564,14 @@ static void emit_alu_i32(const s8 *dst, s32 imm,
>  }
> =20
>  static void emit_alu_r64(const s8 *dst, const s8 *src,
> -			 struct hppa_jit_context *ctx, const u8 op)
> +			 struct hppa_jit_context *ctx, const u8 op,
> +			 bool is_signed)
>  {
>  	const s8 *tmp1 =3D regmap[TMP_REG_1];
>  	const s8 *tmp2 =3D regmap[TMP_REG_2];
>  	const s8 *rd;
>  	const s8 *rs =3D bpf_get_reg64(src, tmp2, ctx);
> +	void *func;
> =20
>  	if (op =3D=3D BPF_MOV)
>  		rd =3D bpf_get_reg64_ref(dst, tmp1, false, ctx);
> @@ -604,10 +608,12 @@ static void emit_alu_r64(const s8 *dst, const s8 *s=
rc,
>  		emit_call_libgcc_ll(__muldi3, rd, rs, op, ctx);
>  		break;
>  	case BPF_DIV:
> -		emit_call_libgcc_ll(&hppa_div64, rd, rs, op, ctx);
> +		func =3D is_signed ? &hppa_sdiv64 : &hppa_div64;
> +		emit_call_libgcc_ll(func, rd, rs, op, ctx);

[Severity: High]
This is a pre-existing issue, but does emit_call_libgcc_ll() swap the high
and low 32-bit words of 64-bit arguments when passing them to libgcc helper=
s?

For example, when calling hppa_sdiv64, emit_call_libgcc_ll() places the lea=
st
significant word (lo) into the first argument register (HPPA_REG_ARG0) and =
the
most significant word (hi) into the second (HPPA_REG_ARG1):

arch/parisc/net/bpf_jit_comp32.c:emit_call_libgcc_ll() {
    ...
    emit_hppa_copy(lo(arg0), HPPA_REG_ARG0, ctx);
    emit_hppa_copy(hi(arg0), HPPA_REG_ARG1, ctx);
    emit_hppa_copy(lo(arg1), HPPA_REG_ARG2, ctx);
    emit_hppa_copy(hi(arg1), HPPA_REG_ARG3, ctx);
    ...
}

Since PA-RISC is Big Endian, shouldn't the calling convention expect the mo=
st
significant word in the first register? This seems like it would cause 64-b=
it
ALU operations relying on libgcc helpers to compute entirely incorrect resu=
lts.

>  		break;
>  	case BPF_MOD:
> -		emit_call_libgcc_ll(&hppa_div64_rem, rd, rs, op, ctx);
> +		func =3D is_signed ? &hppa_sdiv64_rem : &hppa_div64_rem;
> +		emit_call_libgcc_ll(func, rd, rs, op, ctx);
>  		break;

[ ... ]

> @@ -1163,12 +1172,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct hppa_jit_context *ctx,
>  			emit_imm32(tmp2, imm, ctx);
>  			src =3D tmp2;
>  		}
> -		emit_alu_r64(dst, src, ctx, BPF_OP(code));
> +		emit_alu_r64(dst, src, ctx, BPF_OP(code), off =3D=3D 1);

[Severity: High]
This is a pre-existing issue, but does emit_alu_r64() silently miscompile
BPF_MOVSX (move with sign extension)?

When bpf_jit_emit_insn() intercepts BPF_ALU64 | BPF_MOV | BPF_X and passes =
it
to emit_alu_r64(), it does not validate if the offset is 8, 16, or 32 for t=
he
sign extension. Then in emit_alu_r64() for BPF_MOV, it performs a simple co=
py:

arch/parisc/net/bpf_jit_comp32.c:emit_alu_r64() {
    ...
    case BPF_MOV:
        emit_hppa_copy(lo(rs), lo(rd), ctx);
        emit_hppa_copy(hi(rs), hi(rd), ctx);
        break;
    ...
}

Because bpf_jit_emit_insn() returns 0 (success) instead of rejecting the
unsupported instruction, the BPF core does not fall back to the interpreter.
Could this lead to silent data corruption when a BPF program relies on sign
extension, especially if the verifier assumes the extension has occurred for
bounds checking?

>  		break;
> =20
>  	/* dst =3D -dst */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717190544.2573=
06-1-main.kalliope@gmail.com?part=3D2
