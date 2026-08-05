Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24721383C80
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910919; cv=none; b=YEQr7cDMr1CNRYUWtWEFniZhitBIfY8c0QC2V/5XAMv7wOWt8dA6ylvItxLBFh4kga2udiKTHroD7WuFIIEfDJ5JeRUYlX/HofEGNroV66aTqGOE5+A5g+io6ppVnay3zEMZGeS+E4FxsHMwyHIfRxv/Qpe+dzKGn3UX99c3Zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910919; c=relaxed/simple;
	bh=wk+xmhOrQotOK03PSNjgrHfWXcibQiHFCXnOeU5AJD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udeh5bvn8NacjAHmzj5zujprqnkI9ai7j4a6wI/TTjJ2KnywYxnbG5BWNTpZDZSgU8riTuzrmhkNkeE8nsKCN/AtjoKNP1VXzv8/oiOuI5GEUzQrbk0NGAvEHE/g7yjmeYwj0BWp2XXd4tL/V13mrrcp3U5hcnAHk3WlIvLDeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS0j30wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS0j30wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536961F000E9;
	Wed,  5 Aug 2026 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910917;
	bh=urXasehf8lw9XbZlJ/eiwzGd+j4jmml+PSgVpTgl9Lw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AS0j30whjgOCF/l6Jh83ZpAxGnIzbeNddBNjxFrbvmgN5Zq0kSQGoyteGlPDlz/Gn
	 Hf0WVaGMqv8/5h+NtBikiWARHZeowfzwjQiYSnNQ2jdJbKfEvwEKrkrqqS+HGLD6uR
	 FedgeH+mUDZWwgE6zy9V6gABIaDeTJ84FNlbh/2paXJGH4WGSb4Tg6DaVApHlxZTEO
	 tpMqK5Q9Jb3ht7xrHUkhLcbCJ7FXyiT2j9VrL9ixZky2fCgrgOtdrw0gs60846F8jD
	 f7/VPTz+ZKePnrCwDzrB/0wry2vjqddhLhzsYytSqmG6+K1ykRQGp4Brzd/YBy4yO1
	 pAJ6E9lFb9x2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/8] powerpc/bpf: fix alignment of long branch
 trampoline address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <26e8e6fa5d0279ec92281d5324678f00294e2cb7.1785906979.git.skb99@linux.ibm.com>
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <26e8e6fa5d0279ec92281d5324678f00294e2cb7.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:21:56 +0000
Message-Id: <20260805062157.536961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Passing `NULL` for `fimage` in `bpf_jit_emit_exit_insn()` causes i=
ncorrect alignment calculations for alternate epilogues, leading to an unal=
igned 8-byte memory store during JIT compilation and misaligned runtime add=
resses.
--

--- Patch [1]: [PATCH v10 1/8] powerpc/bpf: fix alignment of long branch tr=
ampoline address ---
commit 4bc0d2265cceaf063f46ec43f44292e01148338a
Author: Abhishek Dubey <adubey@linux.ibm.com>
powerpc/bpf: fix alignment of long branch trampoline address

This commit attempts to fix the alignment of the dummy trampoline address
field between the out-of-line stub and the long branch stub. It introduces a
NOP padding instruction to ensure the address is 8-byte aligned for
load-register compatibility. It also passes fimage through the epilogue and
fentry stub building functions to calculate the correct alignment.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 7b07b43575f11..42046f73c2792 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,39 @@ asm (
>  "	.popsection				;"
>  );
> =20
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_=
context *ctx)
>  {

[ ... ]

> +	ool_stub_sz =3D IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub=
_sz, SZL))
> +		EMIT(PPC_RAW_NOP());
> +

[ ... ]

> @@ -81,6 +109,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct cod=
egen_context *ctx)
>  	 */
>  	if (image)
>  		*((unsigned long *)&image[ctx->idx]) =3D (unsigned long)dummy_tramp;
> +
>  	ctx->idx +=3D SZL / 4;
>  	long_branch_stub_idx =3D ctx->idx;
>  	EMIT(PPC_RAW_MFLR(_R11));

[ ... ]

> @@ -107,7 +136,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen=
_context *ctx, int tmp_reg,
>  		PPC_JMP(ctx->alt_exit_addr);
>  	} else {
>  		ctx->alt_exit_addr =3D ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, ctx);
> +		bpf_jit_build_epilogue(image, NULL, ctx);
>  	}
> =20
>  	return 0;

[Severity: High]
Does passing NULL for fimage here cause incorrect alignment calculations for
alternate epilogues?

Since bpf_jit_emit_exit_insn() passes NULL to bpf_jit_build_epilogue(), the
fimage argument eventually passed to bpf_jit_build_fentry_stubs() will be N=
ULL.
This means the IS_ALIGNED() check in bpf_jit_build_fentry_stubs() will eval=
uate
alignment relative to 0 instead of the actual fcode_base.

Because the executable memory allocated by bpf_jit_binary_pack_alloc() only
guarantees 4-byte alignment, the real fimage base might not be 8-byte align=
ed.
If the NOP calculation evaluates 0 instead of a 4-byte aligned base, it can
incorrectly omit the padding, leading to an unaligned 64-bit store when wri=
ting
dummy_tramp:

	if (image)
		*((unsigned long *)&image[ctx->idx]) =3D (unsigned long)dummy_tramp;

Performing a 64-bit store to a misaligned pointer is undefined behavior in C
and can trigger alignment exceptions. Will this also cause the ld instructi=
on
to load from a misaligned address at runtime, defeating the patch's goal of
load-register compatibility?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785906979.gi=
t.skb99@linux.ibm.com?part=3D1
