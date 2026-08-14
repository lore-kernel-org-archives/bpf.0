Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0473D6CBA
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690659; cv=none; b=nP1b1EvFbTyfUAUy1atFQr4jh7aD77gAVBNqI+Ls0nVhEAuoZ7SX6Qyzj7nAIOGaEguycOjzOYoeRmB9JOBQHa0jkD5Q+3DwnEe2vuLG8TQVrG34WSq4Uavk2nFY9lm3vGtfHtiY8S8Gjo6U3Mb4ExQrcxqH6VNJpuW802QreHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690659; c=relaxed/simple;
	bh=qrr/Euc2AGtWr9G4Pmq/sQueLqmCt4NZ6hfMRLVH06s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M833yu9ZryBcAOGRw87yyvIi3GmylkO9Ow6gmORHNNGYCjlUBTqRYSvVX7A8npkgIpkOTZObLFYrMrpPYqd6fMp9kxMWRI8/qumOQKO1Ns6x6det3xQ83IeOqL2+N+F/5PkUvs3hYRKGDMVnAQELigo5zbGAyCeBRp4qSJMxYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu4d8Lwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu4d8Lwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B361F000E9;
	Fri, 14 Aug 2026 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786690658;
	bh=vHurub2f1Yhl8A8zH17vUD6zXAeEM/nd02dYX/GcMQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eu4d8LwhJAtEd4yueUk2mmjk5/xpzqNKSrK/HH5gkF1nRHTbSP8VVTAyGW3G3xP2N
	 CP0KeQvopH+5OJIgX4pkhtMX84tn3eZxiop4lOeq8eDRpbJEXJi285mbh20wskvQkW
	 UFgVV8kURbS0Cw2Lus/TqHEtsb91DmYYebEYR0r8cX4BYUwwdDXol5przT+PZVUVlT
	 /Yu7JpMiW7hvciuLH+IYlTzN3jFtRmx4iGqPeJ/dGKOdvG43yew3WiqR97z916yhYs
	 JoaIBOjWBNknkcE/W9KzVhaI4HFeqlXLt2kHlO8l//25NF1Qy3zM58hELLEqnPFvis
	 uXTLzzYTbioWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] riscv, bpf: Fix missing sign-ext for signed
 1-byte and 2-byte kfunc args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814064726.3607615-1-pulehui@huaweicloud.com>
References: <20260814064726.3607615-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 06:57:33 +0000
Message-Id: <20260814065737.D1B361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a call to a `sign_extend()` function that is u=
ndeclared and undefined, resulting in a compilation failure.
--

--- Patch [1]: [PATCH bpf-next] riscv, bpf: Fix missing sign-ext for signed=
 1-byte and 2-byte kfunc args ---
commit 47567ad8c96e02d677f1ae5123565efa9cf1b55f
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args

This commit updates the RISC-V BPF JIT to sign-extend 1-byte and 2-byte
kfunc arguments as required by the RV64 ABI. This addresses an issue exposed
by recent state pruning liveness analysis changes.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 10e01ff06312d..0c6de02eb33a8 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1784,9 +1784,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
> =20
>  			for (idx =3D 0; idx < fm->nr_args; idx++) {
>  				u8 reg =3D bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
> +				bool sign =3D fm->arg_flags[idx] & BTF_FMODEL_SIGNED_ARG;
> =20
> -				if (fm->arg_size[idx] =3D=3D sizeof(int))
> -					emit_sextw(reg, reg, ctx);
> +				if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
> +					return -EINVAL;

[Severity: Low]
Is sign_extend() declared in this context?

It appears this function might be missing from this file or requires an
unapplied prerequisite patch. Looking through the source, there doesn't
appear to be a sign_extend() function defined in the RISC-V BPF JIT code
that matches this 5-argument signature. Will this cause a build failure due
to an undeclared function?

>  			}
>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814064726.3607=
615-1-pulehui@huaweicloud.com?part=3D1
