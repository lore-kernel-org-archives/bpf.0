Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6623F1AB1
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179289; cv=none; b=FeEazXDZigxL26D2RtyNvrfbw70lT1QLFUlMHDUnB6+Bqwq/w7HC+HE/tBCrRy0fjxvErDj4uymlMUTeVZhL5yseVVPixsU6abMiYJE43W48buJwd60QYmnpTBmGyItAVxGhNMhV4f8Hmv/imvg9uY23Yyuhtk0IPSqeDNyRugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179289; c=relaxed/simple;
	bh=4YggoqwIIIasbLWspwW3AMmJLNsisXP8JfObvwUdt4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZTCXGq9JmsN4/cyxb5Lc3PpUPO6KWbidEzeS4j6Z2E7Z/VEqiQrIDdPAZSAcZW5y303Yg7aPglDuLX0N+/c01rrAO3KoEtcsbAVWiSWL0Xr7/my/QifzKu6FPk3OXUq08Nq1n6oMfLFFX4nb3TU5e6l6cgxv+QiJTBnCeX7XHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC491cMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC491cMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0471F00893;
	Thu, 11 Jun 2026 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781179288;
	bh=dr2v1ojHNbrfCZte9dE1Cz2e8cLdc6OaXU6YnSswGJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YC491cMpwwQbMUxy3Ec/0PraY20nQ5TzTUa0GjFNLaVQabdoiEXs1sWe9GfdVnxES
	 saj0t09amdsdHHbDX3xetboI8C5bcowCAT731KMRilkDK9VUtIg1iiim+IYhwQ5YWV
	 GNhG+5/QRPUQYFvUZkpPUIbZEUBFS2tC5hPbuyjPrv6a7KiuA1xhvDahqBMQbRi5zJ
	 Je3Mv1Q0e2AxIjRBEsoj99+ALOpjAnyngYHB3mW2nJOdPheDisk/eWWU2+b2UCB7z9
	 D4nuBJ7lrdsN9HkUsjNPh4Sk3gZxb2QkbSXmNQoUz84iVcryaUPEMXTDlOc85G4T02
	 6SmGWRwld0pZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/7] powerpc/bpf: fix buffer overflow in JIT for
 large BPF programs
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611153826.31187-8-adubey@linux.ibm.com>
References: <20260611153826.31187-8-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:01:27 +0000
Message-Id: <20260611120128.1C0471F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a guaranteed buffer overflow for BPF prog=
rams larger than 32MB by failing to clear `cgctx.alt_exit_addr` before the =
second size-calculation pass (pass 0).

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch ex=
poses it fatally: missing update of `addrs[fp->len]` during JIT passes caus=
es `BPF_EXIT` to branch to uninitialized memory, crashing the kernel.
--

commit 7f31e323d670ec5c6b2df079f524622af737b8e6
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: fix buffer overflow in JIT for large BPF programs

During pass 0 (size calculation), exit_addr is 0 since addrs[fp->len]
is not yet populated. bpf_jit_emit_exit_insn() treats a zero exit_addr
as in-range and skips bpf_jit_build_epilogue(), so the alternate inline
epilogue instructions are not counted in alloclen.

Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ib=
m.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 2e2993bc646e5..032918f192b1f 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -128,11 +128,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fi=
mage, struct codegen_context
>  int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_conte=
xt *ctx,
>  							int tmp_reg, long exit_addr)
>  {
> -	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))=
) {
> +	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx =
* 4))) {
>  		PPC_JMP(exit_addr);
> -	} else if (ctx->alt_exit_addr) {
> -		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx=
->idx * 4))))
> -			return -1;
> +	} else if (ctx->alt_exit_addr &&
> +		is_offset_in_branch_range(ctx->alt_exit_addr - (long)(ctx->idx * 4))) {

[Severity: Critical]
For programs larger than 32MB, bpf_int_jit_compile() runs a second size
calculation pass (pass 0). Since cgctx.alt_exit_addr isn't cleared before
this second pass, could this condition evaluate to true using the stale
offset from the first pass?

If this happens, pass 0 would skip the inline epilogue and emit a single
jump instead, undercalculating the buffer size. Would passes 1 and 2 then
write past the end of the allocated buffer, corrupting kernel memory?

[Severity: Critical]
This is a pre-existing issue, but this patch appears to expose it fatally.

In bpf_int_jit_compile(), addrs[fp->len] is set after pass 0:

	addrs[fp->len] =3D cgctx.idx * 4;

However, it is never updated inside the subsequent loop for passes 1 and 2.

Because pass 0 now generates a significantly larger body (building a full
inline epilogue for the first BPF_EXIT), passes 1 and 2 will shrink. Since
addrs[fp->len] isn't updated for the new shrunken body sizes, BPF_EXIT
instructions in pass 2 will branch to the old pass 0 offset.

This offset points past the actual generated epilogue into the breakpoint
padding. Could this cause a kernel panic when the BPF program executes?

>  		PPC_JMP(ctx->alt_exit_addr);
>  	} else {
>  		ctx->alt_exit_addr =3D ctx->idx * 4;
>  		bpf_jit_build_epilogue(image, fimage, ctx);
>  	}
>=20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611153826.3118=
7-1-adubey@linux.ibm.com?part=3D7
