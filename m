Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F230C17B
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040922; cv=none; b=Aa9PiZdIGAQ9/GgBFdbl94pLS0geuJPXktrMHPGoQf6zSaIJ/S/HFXzjhEJYpZOREP3QngE00jSL0IdqzfwshtvfHwHUk5wCVOqGrlUPEj4idGbGfeO/nu+nbJV7nZVtabyQZYrdzviNZpirZuzvMC1mLZ+f3NgbxCkmiJm6Ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040922; c=relaxed/simple;
	bh=70ald6ekBzy6qtJwVvBsKi8rT4MKYoCu54w24Z4bTBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q1+2eEE3/Zw/AXjlWEg2vcjU0mTfVBQjB9svzxHjAyE9Y+t5nQ7mtrvwqPhhQIyII2j0Df0EVwqDQD1SM1J+tA1CnQ47w6zT8OnI0OxpS7I4W48ulZ/Z7hcAHGKp3Da8M0Tl/XVwz29l1dPTH0ay3ftleOyskxW409IRPsqcttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/+Q9Tgg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/+Q9Tgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B8AC2BCB0;
	Sun, 17 May 2026 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779040921;
	bh=70ald6ekBzy6qtJwVvBsKi8rT4MKYoCu54w24Z4bTBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=p/+Q9TggKwReVn9VOPn9ov2J/XVLHXGRVJi4wFdcDHnZ5VwkEKCCN4kfqSOpi6iyP
	 Y16oI+81Y71H9PZwdtPkkvdfkL1AkZxrGovyf3ylEw33JGsIfczWabadmQPIldXYz7
	 w1ERChFj7wSE+tpZbitJF7YS6+KWdB+yEnkNrHkNhT7BHyS5wbQgTp+rchvtYv6iat
	 hPCmYKzcT/V7+llvhuAPuGUofJEeKDKIDwEe9VV+8+cx/yLnvqLP2DPSDHyZlXvZOE
	 SzZn8irVmDl+BXV/FlXp44Ctt8u9jL5fbtf8RB8pqzcNacTnrPePULZ0l5Pg96v3C0
	 V0pT9VtZ7VLyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] powerpc/bpf: fix alignment of long branch
 trampoline address
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517214043.12975-2-adubey@linux.ibm.com>
References: <20260517214043.12975-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 18:02:01 +0000
Message-Id: <20260517180201.87B8AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] JIT Buffer Overflow due to undersized pass 0 allocation.
- [High] Flawed alignment arithmetic actively misaligns the trampoline addr=
ess.
- [Medium] Inline epilogues silently bypass the alignment logic.
--

commit ce3a7a39e286dcf5c4eaad0616ec652506a106fa
Author: Abhishek Dubey <adubey@linux.ibm.com>
Subject: powerpc/bpf: fix alignment of long branch trampoline address

This commit attempts to align the dummy trampoline address field between
the OOL stub and the long branch stub to 8 bytes for memory compatibility.
It does this by emitting an optional NOP depending on the alignment of the
instruction pointer.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,34 @@ asm (
>  "	.popsection				;"
>  );
> =20
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_=
context *ctx)
>  {
>  	int ool_stub_idx, long_branch_stub_idx;
> =20
>  	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 */
> +#ifdef CONFIG_PPC64
> +	if (fimage && image) {

Since this condition evaluates to false during pass 0 (where fimage and
image are NULL), the alignment NOP is skipped and the required buffer size
in proglen is calculated without it.

During the final passes (1 and 2), if the NOP is emitted, could this increa=
se
the instruction count beyond proglen and overflow into the subsequent
exception table or fixups? A later patch in the series may alter this area,
but does this patch introduce a self-contained memory corruption regression?

> +		/*
> +		 * pc points to first instruction of OOL stub,
> +		 * dummy_tramp_addr is past 4/3 instructions depending on
> +		 * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
> +		 *
> +		 * The decision to emit alignment NOP must depend on the alignment
> +		 * of dummy_tramp_addr field.
> +		 */
> +		unsigned long pc =3D (unsigned long)fimage + CTX_NIA(ctx);
> +		pc +=3D IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;

Because pc is an unsigned long byte address, adding 4 or 3 adds bytes
instead of the intended 16 or 12 bytes (since PowerPC instructions are 4
bytes long).

Adding 4 bytes to an 8-byte aligned address makes it unaligned. Does this
flawed arithmetic force the code to emit a NOP when the target address is
already aligned, thereby misaligning it?

> +		if (!IS_ALIGNED(pc, 8))
> +			EMIT(PPC_RAW_NOP());
> +	}
> +#endif

[ ... ]

> @@ -107,7 +131,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen=
_context *ctx, int tmp_reg,
>  		PPC_JMP(ctx->alt_exit_addr);
>  	} else {
>  		ctx->alt_exit_addr =3D ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, ctx);
> +		bpf_jit_build_epilogue(image, NULL, ctx);
>  	}

Because fimage is strictly passed as NULL here, the if (fimage && image)
check in bpf_jit_build_fentry_stubs() will always evaluate to false.

Will this cause the alignment NOP to be unconditionally skipped for all inl=
ine
epilogues, leaving their dummy_tramp_addr fields unaligned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517214043.1297=
5-1-adubey@linux.ibm.com?part=3D1
