Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAF33F588
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670133; cv=none; b=jriqw+LJMhPDgetmvbvf7FXp85C+PRZH0wAvTDrgGkq9bY7alwBSE9Bmcs2hPXcavyot2Lgehp2xrNPkIbdHZRT5nMBfZJHAUdocahpSKQTSL4ifsSRWS0zNP4Zzbpi6eDXN3hOkUB7n512H2Gs9j7oj5iUOSYLkTfHDGJGxAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670133; c=relaxed/simple;
	bh=zxF0DPQsb0Uic70iaRrMIkkPFpmB1WD8r/Bne4eVMWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1waQzCSfCV8ZqIb+U/ZocXBhTh9DcKIsiAcafLqrHeXQfjLx9jhzcAeIw6BESpTwwKmJA/szRKWLoqGDCm07Xy+CxOk9PMUr9U4Pelu0ZnMjgnGZPavqpnMd1OhP8dpQkhRhYnv5CyXg9LNqy+iF8US9u36XUbpv8REOesDSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOKS8jcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOKS8jcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB003C2BCB4;
	Fri,  1 May 2026 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777670133;
	bh=zxF0DPQsb0Uic70iaRrMIkkPFpmB1WD8r/Bne4eVMWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mOKS8jcnSMq8CiEQC4ZHwMAo+YEQA99nkGvAt8Zy7B6WCOyRUnLDwFbaa3EFN44Ir
	 3ASyWt6tts7bthRWWU3y7iTRisDD7jqstCea73hGE3MOaZM3Nhr7RooMcyPP1QOSVQ
	 HHumpC9fkf0sVQVLPFpE0kedGbO8lLYZs9CkxaBCVvQkrElWkHe9UdzUxt5l0d63Yt
	 GbfYAY5bwDKtUh73GkQFF1qkjJbEC652uT8IY6UJnKNgoEtBdQEmBLuyDKD3c93EEn
	 6VWI0XPayKJiq77k2PIMIix2+q4j7dSiOEP3KCVyqNZw3vmnnSnI1kfB6rbZTFAzWZ
	 qv2drz0btjJ6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] lib/bitrev: Introduce GENERIC_BITREVERSE and
 cleanup Kconfig
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430211351.658193-3-ynorov@nvidia.com>
References: <20260430211351.658193-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 21:15:32 +0000
Message-Id: <20260501211532.CB003C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Build and linking failure for modules using bitreverse when CONFIG=
_BITREVERSE is compiled as a module ('m').
- [Medium] Kconfig unmet direct dependencies warning when GENERIC_BITREVERS=
E is selected by architectures.
--

commit 43d61911d4e52b31128989028f6541618dd3291b
Author: Jinjie Ruan <ruanjinjie@huawei.com>

lib/bitrev: Introduce GENERIC_BITREVERSE and cleanup Kconfig

This commit introduces the GENERIC_BITREVERSE config option to explicitly
manage the generic bit reversal lookup table, replacing the previous check =
for
!HAVE_ARCH_BITREVERSE. It updates lib/bitrev.c to use this new symbol and
makes it dependent on the BITREVERSE config.

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 00a9509636c18..3ac12308eb765 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -62,6 +62,24 @@ config HAVE_ARCH_BITREVERSE
>  	  This option enables the use of hardware bit-reversal instructions on
>  	  architectures which support such operations.
> =20
> +config GENERIC_BITREVERSE
> +	def_bool !HAVE_ARCH_BITREVERSE
> +	depends on BITREVERSE

Because BITREVERSE is a tristate symbol and GENERIC_BITREVERSE is defined a=
s a
bool, what happens when BITREVERSE is configured as a module (=3Dm)?

Kconfig evaluates a bool depending on a module as 'n'. This means when
CONFIG_BITREVERSE=3Dm, CONFIG_GENERIC_BITREVERSE evaluates to 'n' and remai=
ns
undefined.

Will this result in missing declarations and linker failures for any modules
relying on the bitreverse library?

Additionally, does this strict dependency cause Kconfig unmet direct depend=
ency
warnings if an architecture subsequently uses select GENERIC_BITREVERSE but
the kernel configuration has BITREVERSE disabled (such as in allnoconfig)?

> +	help
> +	  This option provides the standard software-based bit reversal

[ ... ]

> diff --git a/lib/bitrev.c b/lib/bitrev.c
> index 81b56e0a7f325..3a53ff67aebaa 100644
> --- a/lib/bitrev.c
> +++ b/lib/bitrev.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#ifndef CONFIG_HAVE_ARCH_BITREVERSE
> +#ifdef CONFIG_GENERIC_BITREVERSE

If CONFIG_GENERIC_BITREVERSE evaluates to 'n' when CONFIG_BITREVERSE=3Dm,
this file will be compiled empty. Does this prevent byte_rev_table from bei=
ng
exported for modules that need it, causing a modpost linking failure?

>  #include <linux/types.h>
>  #include <linux/module.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430211351.6581=
93-1-ynorov@nvidia.com?part=3D2
