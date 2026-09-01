Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06C4749D4
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269211; cv=none; b=TDPhRvVXYLVFdDDqSGvdNG8stmPFxXkguuTPLrzIXX/teTSkFJ09E8jDnHnCD1Da0dc9Tn6asQHcKD9/FaVo9yNvC1o/z8H5xHNgrxQSmyi7mHi0aM5i1hHMFUNRRWT83KL3EM+AWP3/dJe8mqHvtzagWrIi+ubGhvVLc2ivBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269211; c=relaxed/simple;
	bh=2jY01KBUJIh7KjYFs2u0BCbAFBgCLRDoe80FhapcUo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQXOC34dfjRkcv3KqyL5qrpQgWlRbYrdkRyNIwCMIrvEH1dxoBLyk4Lew6O1VGRhU5J1bql1pD96BPypgkFpkKx/VI6vfCQqC2Yr2q2yn9GqnHEeMOayhFYGlcIqeb0b1zqeOSwL44jHkzZNAuR2DkywGdKcsm07iK2lrBZqdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW8WI8WC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW8WI8WC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24591F000E9;
	Tue,  1 Sep 2026 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269210;
	bh=pbXvnqFJx09t4nCCBym7x/L+UiF+fsre2r7g4aH4ZIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UW8WI8WCOsycoacdbI9Q761TwKf2PpcIJXYdxjk11ez6UxjjASQ6ewKX2PF5aFJBQ
	 JvnTcSAFJL0XkXigvsK/lNvG1boJCvsU8TC81AQE7uQCVU1OjwLY23OCg9PtxGT5Lv
	 QIlDOZasYB7QXOmYCDbMk2311UgvQsY4MYqtauwmg1hVEBbPl6HWETjVjtKt4Sw+oW
	 Ov/dZUkcDLaQvl4ALcrTnjXzEnQEcNOYHvuYAQ9IY9I/nuif3lrcJBgjvLyg+3HkpY
	 yIzhLP/wHqMGwwEE4nBqKKUy9/tI0fKL+GmF+WcMA4JvYqAE2CQ93DQ+Gx92z+Bdrl
	 QL5ujE/3TJvfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, riscv: Make arena support depend on ZACAS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901131132.16241-1-cp0613@linux.alibaba.com>
References: <20260901131132.16241-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:26:49 +0000
Message-Id: <20260901132649.F24591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The unconditional use of `system_has_cmpxchg128()` in `bpf_jit_supp=
orts_arena()` causes a build failure when `CONFIG_RISCV_ISA_ZACAS` or `CONF=
IG_TOOLCHAIN_HAS_ZACAS` is disabled.
--

commit c73d679b84188e98d5cff0171b751fa3f4ce5627
Author: Chen Pei <cp0613@linux.alibaba.com>

bpf, riscv: Make arena support depend on ZACAS

This patch updates bpf_jit_supports_arena() to return the result of
system_has_cmpxchg128(). This ensures that BPF arena map creation fails
with -EOPNOTSUPP on RISC-V systems that do not have the ZACAS extension.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index e7378be171a9f..a5870d386f983 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -2141,7 +2141,11 @@ bool bpf_jit_supports_ptr_xchg(void)
> =20
>  bool bpf_jit_supports_arena(void)
>  {
> -	return true;
> +	/*
> +	 * The arena range tree uses kmalloc_nolock(), which needs
> +	 * cmpxchg128, provided by ZACAS on riscv.
> +	 */
> +	return system_has_cmpxchg128();

[Severity: Low]
Does this code cause a build regression when compiling without ZACAS suppor=
t?

Looking at arch/riscv/include/asm/cmpxchg.h, system_has_cmpxchg128() is
conditionally defined without a fallback:

#if defined(CONFIG_64BIT) && defined(CONFIG_RISCV_ISA_ZACAS) && defined(CON=
FIG_TOOLCHAIN_HAS_ZACAS)
#define system_has_cmpxchg128()        riscv_has_extension_unlikely(...)
...
#endif

If a kernel is built with CONFIG_BPF_JIT=3Dy but CONFIG_RISCV_ISA_ZACAS=3Dn
(or CONFIG_TOOLCHAIN_HAS_ZACAS=3Dn), will the unconditional use of
system_has_cmpxchg128() in bpf_jit_supports_arena() result in an implicit
declaration error?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131132.1624=
1-1-cp0613@linux.alibaba.com?part=3D1
