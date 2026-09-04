Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6247626159E;
	Fri,  4 Sep 2026 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788486470; cv=none; b=XQwKs/KmZwZlF22am0kX1Xfkt46eiV9E3YZxAKk06CqWz6tR5T0aZyOrxBawyhzmqhksEyVhKZMEhDmkaamz/lPy0U46pfl2hBFgkVc8h777VbbDFJUWI1ErIO4E9/z6sXNd2IPG9ZRhV0mQ5UaBD5PkSDfgUeILtHpZcoUdJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788486470; c=relaxed/simple;
	bh=JVDeMIkLAV+FTDJQW2eQo7JhGBJ6KEDiA1nqd6dgOaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IWWdpLPgtUa0bg/8wih1cck37KK0mGVbz1q7vxCYQAxNN6fzEXrEMPeaRbATQgsgj+8AQeRTbfBwXV89QfgjV3nrSowQvaG6S0pYdwAn6NF7I4dPAKq3FmgKVCLVnNmKuB0LAAYAjY8nHh6c2Nkn4EZoRM202yI9rVTK315hcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0Be6oyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0Be6oyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04AA1F000E9;
	Fri,  4 Sep 2026 01:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788486469;
	bh=RZ163bT2SBMXkLQEC+5u90c1x+gxGZEmjcnUHnCF/8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0Be6oyFwDcODmK7c+iYIRQHgJYvQZcYniX9PhZkHPqT0/EnApR1/g1JcjrcSAzzA
	 h+iVFjLyT/Pwj2p+IcGcYG3fugZbdr5BnzMYgPV/ukJ+fT26pTzKYcEitFyPRrp6fd
	 XOBKXNolKa+U6CC3MTk0PcvwecTkWMSahnzDGK3tv+JFYXsbrzsazIO2OCBxuxZc0d
	 BAzb7yJMpbbcvjVhdoHU2K4EJP864yVVplzS7dX9d5KBbgvRG7u1EoF/8jdDHNPph+
	 aQfFFX73NCgNx3/8tFj6KKdFY4H1uzeUSf3sz5FV6VD3f1rIZ9KfcpWz9liizB4ZSA
	 uSUUYFZhzoVTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/8] arm64: cfi: Use
 CONFIG_ARM64_FUNCTION_PREFIX_NOPS for the type hash offset
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBGZXJuYW5kZXogKEFudGhyb3BpYyk=?= <jose.fernandez@linux.dev>
Cc: bpf@vger.kernel.org, ojeda@kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-5-ce6687739b0c@linux.dev>
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
 <20260904-b4-arm64-callops-kcfi-v1-5-ce6687739b0c@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 01:47:48 +0000
Message-Id: <20260904014748.C04AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] bpf_prog_fill_jited_linfo() calculates incorrect line info addre=
sses because ctx.offset includes the CFI prefix size.
--

commit 1909b8cf9ec25c69a7f49627fb1a30b3d8e545d4
Author: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
arm64: cfi: Use CONFIG_ARM64_FUNCTION_PREFIX_NOPS for the type hash offset

This patch modifies the CFI prefix to use CONFIG_ARM64_FUNCTION_PREFIX_NOPS
instead of hardcoding four bytes. It adjusts cfi_get_offset(),
SYM_TYPED_FUNC_START, and the BPF JIT to account for the dynamic number of
NOPs required by kCFI kernels with CALL_OPS or ThinLTO and BTI.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index c18e005a41dbe..7ad14d9847138 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
[ ... ]
> @@ -185,8 +185,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx=
 *ctx)
> =20
>  static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
>  {
> -	if (IS_ENABLED(CONFIG_CFI))
> -		emit_u32_data(hash, ctx);
> +	if (!IS_ENABLED(CONFIG_CFI))
> +		return;
> +
> +	emit_u32_data(hash, ctx);
> +	for (int i =3D 0; i < CONFIG_ARM64_FUNCTION_PREFIX_NOPS; i++)
> +		emit(A64_NOP, ctx);
>  }

[Severity: Medium]
This is a pre-existing issue, but does expanding the CFI prefix length
cause bpf_prog_fill_jited_linfo() to calculate incorrect line info addresses
by adding the CFI prefix twice?

When loading any BPF program with line info on an arm64 kernel built with
kCFI, ctx.offset measures from the start of the JIT buffer, which includes
the CFI prefix emitted here.

However, in bpf_int_jit_compile() in arch/arm64/net/bpf_jit_comp.c, the
offsets are passed to bpf_prog_fill_jited_linfo():

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    for (i =3D 0; i <=3D prog->len; i++)
        ctx.offset[i] *=3D AARCH64_INSN_SIZE;
    bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
    ...
}

Since bpf_prog_fill_jited_linfo() adds these offsets to prog->bpf_func,
which is already shifted past the CFI prefix by cfi_get_offset(), the CFI
prefix length ends up being added twice. The bug existed prior to this patch
(off by 4 bytes) but this patch exacerbates it to 16 or 24 bytes depending
on the number of NOPs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-b4-arm64-c=
allops-kcfi-v1-0-ce6687739b0c@linux.dev?part=3D5
