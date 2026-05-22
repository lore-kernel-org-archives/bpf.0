Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68E3A7F52
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451126; cv=none; b=gUqADMK42f8k1IiCYEC3Z0ZiID2vC3U8kBYVaCW2DBMXmJYJrwJhsn/r8FomT7DQuTQu02Flhu34Rf1RyHfAbIGup9h9Soa9c17T1KWvRPz/caeTFBQTOpLlYDd/3GHjKr7dxtSOCsqTIJ2s11p6sUBj6Jia68xShbGYxkYZYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451126; c=relaxed/simple;
	bh=baWQd869kABE+Oa89yUYbABf7JIao/y9EAWjEn7++FQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4aMzwYN2zO4pCuXdGiM7Sw8X3AbZayNP2zbogM9WjfJbnbntxQMR0ZePOlQzGb/5ROOl1lDBFFp8Tbc3FApepeYNrB/2fcZjj0q/GLB96KjHYsdzhN51JiKS1v8twgo1aOpXvm90Pubj2nOmb44N8lxe+zJSLPhrkLAyWbo4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk/1By+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk/1By+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEEB1F000E9;
	Fri, 22 May 2026 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451125;
	bh=+X4n6/TNzZj928yYOtEkLpVa/BPj0z3bxMjKHzo0cDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uk/1By+jAVGKCajJl9J7qfKtyCOw85lmv2SqujPWtXaEUT9BZLA5i5VvAp3JnAGva
	 DQ8tOOS1ZgJNvox3cTkbGJQB/LS/HxAKFnzJckqFF/KsFqWTfLyVYvynT+D2YeMDst
	 ZA8PjLtmWs8mWjI7swBddu4PiejVuJhXcfkaUtGmr8uMkPgE6Zr3sIB0qS9GoSgVfN
	 O1CLiya/MknV/PYXDZYm8v6R4d8nI4FraKspqgo7J8lZGmrfgyBe+5tzBERhLHJmjI
	 PiUSbgnk6FgnZan5DKHdPPspKF22CGaSIuSsNUwD2iW2idrXSaE/7AaRGB3G+xQHG0
	 OYXDaKU9BE5Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/6] x86/asm: Use CFI_* macros in SYM_FUNC_* macros
 so they can be added to VDSO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522110427.2816637-4-jremus@linux.ibm.com>
References: <20260522110427.2816637-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 11:58:44 +0000
Message-Id: <20260522115844.9BEEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `__CFI_TYPE` macro in `arch/x86/include/asm/linkage.h` creates =
unbalanced CFI directives because it uses `SYM_START` but closes with `SYM_=
FUNC_END`.
--

commit 2769cdf2ca16b1b56aace01ab1acf0951b91be1f
Author: Josh Poimboeuf <jpoimboe@kernel.org>

x86/asm: Use CFI_* macros in SYM_FUNC_* macros so they can be added to VDSO

This commit adds CFI_STARTPROC and CFI_ENDPROC annotations to the SYM_FUNC_*
macros. This allows VDSO asm functions to avoid adding them manually, while
leaving the macros empty for the kernel proper.

> diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkag=
e.h
> index a7294656ad908..c2ca8117376fb 100644
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -112,34 +116,51 @@
>  # define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
>  #endif
> =20
> +#define __SYM_FUNC_START				\
> +	CFI_STARTPROC ASM_NL
> +
> +#define __SYM_FUNC_END					\
> +	CFI_ENDPROC ASM_NL

[ ... ]

> +#define SYM_FUNC_END(name)				\
> +	__SYM_FUNC_END					\
> +	SYM_END(name, SYM_T_FUNC)

[Severity: Low]
Does this change to SYM_FUNC_END() create unbalanced CFI directives when
used with __CFI_TYPE()?

The __CFI_TYPE() macro is defined earlier in this file to expand to a
block that starts with SYM_START() and ends with SYM_FUNC_END():

#define __CFI_TYPE(name)                                        \
        SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)        \
        ...                                                     \
        SYM_FUNC_END(__cfi_##name)

Because SYM_START() does not emit CFI_STARTPROC (unlike SYM_FUNC_START()),
code expanding __CFI_TYPE() will now emit a CFI_ENDPROC directive without
a corresponding CFI_STARTPROC.

While this might not break the build today since CFI_ENDPROC evaluates to an
empty nocfi macro outside VDSO and __CFI_TYPE() is not used in VDSO code,
will this cause issues if KCFI or typed symbols are ever used in VDSO build=
s?

Should __CFI_TYPE() pair SYM_START() with SYM_END() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522110427.2816=
637-1-jremus@linux.ibm.com?part=3D3
