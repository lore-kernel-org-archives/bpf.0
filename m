Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35329C328
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178764; cv=none; b=hv/4l9I2ZfeqqxcDqdmdHZZARJrWPtJQSxX4/0VzpmOQvCRgyjM2vhl83zaWULOmR4ruPg0NXk3EA8/dham9NN/D3N6WTpon+syDPk+BcZThgZmlnnAPxpzXeUCNJDnavRLJu6cvCDgR25MyL7t4Die/19wmnZ4zk7WXJvVUylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178764; c=relaxed/simple;
	bh=UAtHo1apBISl+rvNGNAw5crks6wJWYesua44qgn6kiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lyvPl6aBRGyHjbyhO12GYKZl6EaP3iP3HfzxacqAiVoZIB2qnY3hYkDfNTeA+iGQgxcypvppQMjP5RnfdjiNogXg0frjLIMIF2iHYPy8iadttOTgCZcLfE0i5uVd8GpaIfSExZ7pOfTL9s3xHsapJp7BAVEey8bxCAgcier/Wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeHWJJJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeHWJJJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC0A1F00893;
	Thu, 11 Jun 2026 11:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178763;
	bh=PVdvtIDEX+QIE1e5FVtM22rzIqx4Ieh6YroJecRL07M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DeHWJJJ3dlevHM67iziqXzUrZkn69L/t+vbFP9mRc8TMtoCHCQ/mj3R4dauuvmNpJ
	 7TAW3zvULbGU9roxLSBcE+PGygNnEX5LTvMVIodmrB73A7hM1Y7fZ2TASLarKosDdV
	 me8RliY1MnZz/wpgEJTo8U2ohmIwVTJ2bhoz8Mw2YgPHKTOJl/UPiKLO0aebpy+B9J
	 CXMAmoYk2iptk2tRRjDGnPjOmHgsHVDVO9iC7eJePCe9Eiv9vjo6JiEHWucN5fWYV8
	 yo5VhYdO9PkeIkhgLb6gKuTiNc9f3u1M1Y7DHRDWSR/EP+l+MnpDsOdMMUYFXe94FH
	 LHgei9dTJdTBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] powerpc/bpf: Move out dummy_tramp_addr after
 Long branch stub
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611153826.31187-3-adubey@linux.ibm.com>
References: <20260611153826.31187-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:52:42 +0000
Message-Id: <20260611115243.2FC0A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure in 32-bit PowerPC BPF JIT due to missing argument in =
`bpf_jit_emit_exit_insn` call.
--

commit c1ec67bf99079bbd4869481f8942e54d5968cdb6
Author: Abhishek Dubey <adubey@linux.ibm.com>
Subject: powerpc/bpf: Move out dummy_tramp_addr after Long branch stub

This commit moves the dummy_tramp_addr field to the bottom of the long
branch stub to improve uninterrupted disassembly. It updates the offset
calculations and aligns the field to an 8-byte boundary.

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 71e6e7d010573..6632de9871dd3 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
[ ... ]
> @@ -217,7 +217,8 @@ void bpf_jit_build_prologue(u32 *image, struct codege=
n_context *ctx);
>  void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_cont=
ext *ctx);
>  void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_=
context *ctx);
>  void bpf_jit_realloc_regs(struct codegen_context *ctx);
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int =
tmp_reg, long exit_addr);
> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_conte=
xt *ctx, int tmp_reg,
> +										long exit_addr);

[Severity: Low]
Does this prototype change break the build for 32-bit configurations?

It looks like the caller in arch/powerpc/net/bpf_jit_comp32.c was not updat=
ed
to pass the new fimage argument, which will result in a compilation failure
with 'too few arguments to function' when CONFIG_PPC32 is enabled:

arch/powerpc/net/bpf_jit_comp32.c:bpf_jit_build_body() {
    ...
                ret =3D bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611153826.3118=
7-1-adubey@linux.ibm.com?part=3D2
