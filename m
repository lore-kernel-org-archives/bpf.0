Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986129D270
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355976; cv=none; b=EjWSXSkPHrabJ74jTDB8+QrqabNcccFpY2ss+DdRrF7OgxbcjkDWZ1fvEk1Xcf9g+K9YTc3Ll2Vq0PBQqKVENXUxleWBjAD2QrNmHsRPS0aAt02fR4SPh92DCm5hyNbP7qGDV9yATS/u0nfqxPk+iPfWbrinxUSbn0D3AwE3XLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355976; c=relaxed/simple;
	bh=cpvTxTSo8cKlQuXAlNM9V8yy0JvK67z1rk9ysPCdkdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C6usfvOMTv2aiAWt0skzb0HxgvHPVhBl8GzcEO6cGFT7bOjN0Y6EzJtXWI5IbEci0iyqjmTDCV7fgtLfw02Bm9trYrKjZ7aa4614jpIle6nV0U4W1kenyyEaGRcccL/Q5MyYMr6CMoNva7T10/X/38nvmSF0R8/atLzOLzAz3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d71XBDxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d71XBDxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B101E1F000E9;
	Fri, 21 Aug 2026 23:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355974;
	bh=cqxgK/qOPQyHpFHK5SrVbT72CPR3DHYKnOocwy5KanM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d71XBDxgFsGfiSuByMpCkEKyyx2JBZVk6C3S/1Kyc0fSeB94udyKbAXlneWu0P/En
	 9jkihGNf6+ya3dW1m7BaNnbNdtl4KcnsmhSrlzfsxp39O9Xw7ee3011wYwvWqVDCi9
	 2A7Pur5bkNaPTd7d72KFPPMzbWhGzMjighRudYdJGGtT0KwFd4HKOnW/pDrBrGFAfL
	 ncYEbL8CVlVamKBn4qHjhyWrodd5DsFL0oyrSzWGfyBq0BeaQJbVJmvnSfFE/l6nSK
	 gaKvpL0tWHRuozLp79Dhf0bQYxc3+3JtOqW5wo2UCCXaVQtgvzEPWYPTN0ZSvpy9On
	 yNRTHD+UnkTyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 08/14] bpf, loongarch: JIT arena kfunc
 argument rebasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821233516.3426127-9-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-9-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 23:46:14 +0000
Message-Id: <20260821234614.B101E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `insn_is_cast_user` JIT implementation on LoongArch fails to p=
reserve the nullable zero (NULL) due to an off-by-one error in the branch o=
ffset.
--

--- Patch [8]: [PATCH bpf-next v1 08/14] bpf, loongarch: JIT arena kfunc ar=
gument rebasing ---
commit dafba7b807dd9770b1b1fe373622d157b3fde2ab
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf, loongarch: JIT arena kfunc argument rebasing

Kfunc parameters marked with BTF_FMODEL_ARENA_ARG carry a 32-bit arena
offset in the BPF register, while the native kfunc expects a directly
dereferenceable kernel address. This patch implements the JIT conversion
for LoongArch to correctly add the arena base address to these offsets.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index d193293a0fd25..33cabaa7353f9 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
[ ... ]
> @@ -1195,9 +1200,22 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
> =20
>  			for (i =3D 0; i < m->nr_args; i++) {
>  				u8 reg =3D regmap[BPF_REG_1 + i];
> -				bool sign =3D m->arg_flags[i] & BTF_FMODEL_SIGNED_ARG;
> -
> -				emit_abi_ext(ctx, reg, m->arg_size[i], sign);
> +				u8 flags =3D m->arg_flags[i];
> +
> +				if (flags & BTF_FMODEL_ARENA_ARG) {
> +					if (WARN_ON_ONCE(!ctx->arena_vm_start))
> +						return -EINVAL;
> +
> +					/* rN =3D kern_vm_start + (u32)rN */
> +					emit_zext_32(ctx, reg, true);
> +					if (flags & BTF_FMODEL_NULLABLE_ARG)
> +						emit_insn(ctx, beq, reg, LOONGARCH_GPR_ZERO, 2);

[Severity: High]
This isn't a bug introduced by this patch, but seeing the correct offset of
2 used here to skip the subsequent addition brings up a question about the
pre-existing arena pointer cast implementation.

Does the pre-existing code for insn_is_cast_user in build_insn() have an
off-by-one error?

When handling the cast instruction, the code does:

arch/loongarch/net/bpf_jit.c:build_insn() {
    ...
    emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 1);
    emit_insn(ctx, or, t1, dst, t1);
    move_reg(ctx, dst, t1);
    ...
}

Because the branch offset is 1 instead of 2, won't it branch to PC + 4
and execute the or instruction instead of skipping it? If so, a NULL
pointer would be incorrectly converted to the arena base address instead
of remaining NULL.

> +					emit_insn(ctx, addd, reg, reg, REG_ARENA);
> +					continue;
> +				}
> +
> +				emit_abi_ext(ctx, reg, m->arg_size[i],
> +					     flags & BTF_FMODEL_SIGNED_ARG);
>  			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821233516.3426=
127-1-memxor@gmail.com?part=3D8
