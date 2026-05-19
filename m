Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D4374E46
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221263; cv=none; b=A4H/AooSGwPhJ1KhOJz5iZi/Qg7sW6GOS+G0tABnJudMdujoVmaZJR4RrpQVWCpVs3y80Ga4pin38IG7o6p1hZmXbOBzZjF5kJnNCvg7fiOMOK4mXaSvXMHxIgDT8/L3o6GZl3JGd8Bmg0MJtOhSXFCbqVRKsTyhrtsn0xnjDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221263; c=relaxed/simple;
	bh=ad7BQqcJ7hBCdLg0mjH1mRzYaFWD+ir7WzdVxWCS3kY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rA/UNBNDZ+Q1GU7hrdIqv4jfIP0kyGClqX73ykCaBYM1Q2U9Pys+P5VOtgfp6t4ZRc9B39a5utxt2rmn+XFIq+tFnY1DqxnjVRdX8dM0X7ayBBbjIvIIZvG6tktfCyJUYR7YHOOTLreHtqslg+kj+9ZZ0xDO78ykx6MHG/7Im7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpsPRSES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpsPRSES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C711F000E9;
	Tue, 19 May 2026 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779221262;
	bh=SS7vYo+X65cpBwufTVocdDhMcSbRwdhz1I/iFHKbcwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IpsPRSESgfoZl6vGgSLLLxYPT3pQLscQT6/OQCzfJb7yS87WwLxFtgiw8RuJMbtSq
	 Up3UM+/IJaCuSAnKlbC5KhMYzX644VmTs82L2ggO2FNwIMhkrToSmf8LjVuXml7Dpz
	 lgJDuTi++/Zj9NX+yItRNzYB/7BYzZ8mjAoGWh68V1BRBJE2Lu5x0Pf0wU6w/hE91x
	 /Yo4FSZLgaNw77Ls125pdDrjhXA1b8sCWMz/2FOR4+OpLAUJjMqqQ2TCY0dGqqEVOl
	 412ER8YgHiJ9QDo024MMt/fq3OU9TnBv3X1h8EGWEdmyj1VnAhIkYHFDOYfvxtIZmy
	 VisGXAcZdIYRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] powerpc/bpf: fix alignment of long branch
 trampoline address
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519233812.18787-2-adubey@linux.ibm.com>
References: <20260519233812.18787-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 20:07:41 +0000
Message-Id: <20260519200742.43C711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch fails to guarantee 8-byte alignment for `dummy_tramp_add=
r` because it incorrectly assumes the BPF allocator provides an 8-byte alig=
ned base address.
- [Low] The patch violates the BPF subsystem multi-line comment style by pl=
acing text on the same line as the opening `/*`.
- [Low] The newly added `fimage` parameter in `bpf_jit_build_epilogue` and =
`bpf_jit_build_fentry_stubs` is completely unused, introducing unnecessary =
API clutter and a dormant NULL pointer dereference risk.
--

commit e7c3479a62ded3b56790a3e36dfca75074c23779
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix alignment of long branch trampoline address

This patch ensures the dummy trampoline address field present between the O=
OL
stub and the long branch stub is 8-byte aligned, for memory compatibility
when content loaded to a register.

Reported-by: Hari Bathini <hbathini@linux.ibm.com>
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,38 @@ asm (
>  "	.popsection				;"
>  );
> =20
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_=
context *ctx)

[Severity: Low]
This is not a bug, but the newly added fimage parameter in
bpf_jit_build_fentry_stubs() and bpf_jit_build_epilogue() does not appear
to be used anywhere in the function bodies. Does it make sense to add this
parameter if it introduces API clutter and a potential risk if later code
attempts to dereference it when passed as NULL?

>  {
>  	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_instrs;
> =20
>  	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * dummy_tramp_addr must be 8-byte aligned for load-register
> +	 * compatibility. Since fimage is guaranteed >=3D 8-byte aligned
> +	 * by the allocator, alignment depends only on the instruction

[Severity: High]
Is the assumption that fimage is guaranteed to be >=3D 8-byte aligned by the
allocator correct?

Looking at bpf_int_jit_compile() in arch/powerpc/net/bpf_jit_comp.c:

	fhdr =3D bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
					      bpf_jit_fill_ill_insns);

The allocator is called explicitly requesting only 4-byte alignment. With B=
PF
JIT randomization, the base address fimage will frequently be only 4-byte
aligned.

If the base address is only 4-byte aligned, won't adding a multiple-of-8
instruction offset still result in a 4-byte aligned absolute address,
leaving dummy_tramp_addr unaligned?

> +	 * count offset. The OOL stub has 4 instructions (with
> +	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
> +	 * before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if (ctx->idx + ool_instrs) is odd, so that
> +	 * dummy_tramp_addr lands at an even instruction offset (=3D=3D 8-byte
> +	 * aligned from an 8-byte aligned base).
> +	 *
> +	 * In pass=3D0 when image=3D=3DNULL, conservatively account for space
> +	 * required to accommodate alignment NOP. In case final pass skips
> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
> +	 * jited_len signifies correct program size.
> +	 */
> +
> +	ool_instrs =3D IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
> +	if (!image || ((ctx->idx + ool_instrs) & 1))
> +		EMIT(PPC_RAW_NOP());
> +
> +	/*      nop     // optional, for alignment of dummy_tramp_addr

[Severity: Low]
This isn't a bug, but placing text on the same line as the opening /*
violates the BPF subsystem multi-line comment style guidelines. The opening
/* should be on its own line.

>  	 * Out-of-line stub:
>  	 *	mflr	r0
>  	 *	[b|bl]	tramp

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519233812.1878=
7-1-adubey@linux.ibm.com?part=3D1
