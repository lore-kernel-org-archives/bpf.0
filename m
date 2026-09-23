Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E6426D2E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174898; cv=none; b=K/DAtbe/ptaKnYGLzuFFmcksuA9cfgoqQDSuHgkyXcETpq+0HeYES0P44cdiwx+DBkxx6cT5bx62HPhjx96FrVa0KmnqbNXWGIZ/YVSV9Tsz7QRaYmxOZVT5CJImVYMaTcLCET7axKkpR+dliIvEKda0/ltA+Kcl10PFrOoHHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174898; c=relaxed/simple;
	bh=ciYylHWA0IJQoMnH725/EwIKXZETfJsHlPlEkKmNSao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kXxTFzBh3QcfZGe0li3ehdaY6pdCAMHTraWXx2tT6dpujH63Z3Dxf17usNKIB0CzKJumA+jr1mED89HDdLelNmKcYUOBa7WsJibGngEx3hTxDHqn21aT1iD5+QWmAakoJykhGylL4KSiFpSV+vax/qzywZ5aHl8vil19sWZVZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bpl07rYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bpl07rYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C1B1F00893;
	Wed, 23 Sep 2026 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790174897;
	bh=eN8Fq9B0mgizCgf44BBFjWLG08eGPBkZntX+Me335G0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bpl07rYOnKKbiXN5PKcq8ouIJrNEv/lqZECd5iTeYb3KBwR4coXXfXmCnOagBQ8WF
	 DI/x/HJn74PvH+Q0CokhSIRODxDaypYmFMjAArx4sBSuqKhCzur7IMF2gMcxXlmqNk
	 jX0J5O+qyhdEil8H6ZrM0EYDeBIZ/aBGLBW7OfYAf8D/MxwmtK0SWsemwfoRSDla1d
	 cUn94omln6Wa7bOrewNEh3NG2LdWpkTEIMM4U84NGNHIGrAU2xVfJcSqGfd2jNGoqY
	 87zHXrVOpcUD4s/7nN4bUo3RmmDq12/CcsRd6ldYN+T+eZ2g7FGLBy6SwL6zPXkhOt
	 zVOU4XzEiBjTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] riscv, bpf: Fix missing sign-ext for signed
 1-byte and 2-byte kfunc args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923144154.934674-1-pulehui@huaweicloud.com>
References: <20260923144154.934674-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 14:48:16 +0000
Message-Id: <20260923144817.67C1B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: build failure due to missing sign_extend() definition in RISC-=
V JIT
--

commit 6d703d57a8b42af3d4a88a2137eead18963e0c3c
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args

This commit modifies the RISC-V BPF JIT to perform sign-extension for 1-byte
and 2-byte kfunc arguments to comply with the RV64 ABI.

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
Does this introduce a build regression?

Compiling the kernel with RISC-V BPF JIT enabled triggers an implicit
declaration and subsequent linker error because the sign_extend function
is not defined for this usage in bpf_jit_emit_insn.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923144154.9346=
74-1-pulehui@huaweicloud.com?part=3D1
