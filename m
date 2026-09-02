Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFFB3DC87A
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333673; cv=none; b=eDeviEizS19poTWb3cxzRw141MxwewgIXAl6C9Z7BFtJ0UJhBu/aNIvPba8HNni9i8SeVO0oevVfBY2Okz9g3SAMMuxSes2Be1FPiHQOcgqqPTEW88z9A8QOB+cCkPxT2un57P8FKDs2jCP7DC4k4R7NOhP/hcAsF++LfFkWGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333673; c=relaxed/simple;
	bh=Qo/ODHC1lTigxTB8gnPpWyxb3Zdd6l4mCrZKxBrS4BM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jnVliOZrPD/8sg7kPQfX3zuIfm4CSYz3R7K9FM4BmitB4gO0ix0cRUyX2fGYEuqNkVybVFR4dau6KytLY3UtLgQJ+SHANmMLDlrsRAF0Ut8otvUopNh+rWYG+QY4G33DzB4P97QRIWWKTNb/+1WGcldFlNx4zIq1lFTRTkwL9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlm1Iw7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlm1Iw7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5851F000E9;
	Wed,  2 Sep 2026 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788333670;
	bh=CwnVCIUclHSrTL2GoQvOyQc8JwysKQi7Wpmaw70/MdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wlm1Iw7OyaF7haYZcLOoPbezhMRPbTF/Mk4GMqrZpNQ4GWqPqFMmqiifyoKnLVjFa
	 DwvY2JgNUsm5XWXu1tS9KtOqwUUCykK4aDqLCAxSMmHcNVFy7KhYFzLI5gmpt4JQEC
	 G0bYhtVeM7EiVIRGZ7dytHPWVKrJYPwIK0XAKtZsWTLpcpH2OwXIeatgmROnFMTxTj
	 Mxr8Fb9d6LWXX+StrsDBm049IRmilxuzbHRy9ruDMeMiWjucq+sK3iNwDKmwN0TH2k
	 i50hW4TSgddFn+a7lnlKDPJVvxkwFB/wDLQh5QSl0BahpjLnxThjhgfi++wFLKsGN7
	 jWzBSp4c2crKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 3/6] bpf: Reject UHMUL/SHMUL in unsupported
 JITs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902070534.2141812-4-tangyazhou@zju.edu.cn>
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-4-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:21:09 +0000
Message-Id: <20260902072110.3C5851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The PowerPC JIT backends check the first instruction of the progra=
m instead of the current instruction when rejecting UHMUL/SHMUL.
--

commit 1bfedfff9f6c73dc718b4f4866c0696e836592cb
Author: Yazhou Tang <tangyazhou518@outlook.com>

bpf: Reject UHMUL/SHMUL in unsupported JITs

CPU JIT backends currently lower BPF_MUL based on the opcode without
examining insn->off. Once the verifier accepts UHMUL and SHMUL, a backend
without explicit support would therefore lower either variant as the
existing low-half multiplication and silently produce the wrong result.

> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit=
_comp32.c
> index bfdc50740da8e..b578b19017b22 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -349,6 +349,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *imag=
e, u32 *fimage, struct code
>  		u32 true_cond;
>  		u32 tmp_idx;
> =20
> +		if (bpf_insn_is_hmul(insn))
> +			return -EOPNOTSUPP;
> +

[Severity: High]
Does this code check the correct instruction? In bpf_jit_build_body(),
insn points to the first instruction of the program (fp->insnsi), and
the loop uses the index i. By calling bpf_insn_is_hmul(insn) instead of
bpf_insn_is_hmul(&insn[i]), the check only ever looks at the 0-th
instruction of the program.

If an unsupported UHMUL or SHMUL instruction occurs anywhere other than the
very first instruction, it will not be rejected and will instead be compiled
silently as a standard lower-half multiplication.

>  		if (i && (BPF_CLASS(code) =3D=3D BPF_ALU64 || BPF_CLASS(code) =3D=3D B=
PF_ALU) &&
>  		    (BPF_CLASS(prevcode) =3D=3D BPF_ALU64 || BPF_CLASS(prevcode) =3D=
=3D BPF_ALU) &&
>  		    BPF_OP(prevcode) =3D=3D BPF_MOV && BPF_SRC(prevcode) =3D=3D BPF_X =
&&

[ ... ]

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit=
_comp64.c
> index fc9db691e8203..4ef0f3cffe848 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -992,6 +992,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *imag=
e, u32 *fimage, struct code
>  		u32 tmp_idx;
>  		u32 jmp_off;
> =20
> +		if (bpf_insn_is_hmul(insn))
> +			return -EOPNOTSUPP;
> +

[Severity: High]
Similarly, does this code check the correct instruction for the 64-bit JIT?
It appears to check the first instruction instead of &insn[i], which will
cause the same silent incorrect compilation for unsupported UHMUL/SHMUL
instructions not located at the first position in the program.

>  		/*
>  		 * addrs[] maps a BPF bytecode address into a real offset from
>  		 * the start of the body code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902070534.2141=
812-1-tangyazhou@zju.edu.cn?part=3D3
