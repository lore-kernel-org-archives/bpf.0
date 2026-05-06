Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843030DD1C
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103458; cv=none; b=nXGC8qng73Bc0vspBWgxhlVGW9uRDHhDwqroITHLAlNPXCgGXDRX6NpDti3MfYJuzuuL28QBKlKPvRXTkryntDwNOXsLVIHb9bmOjBix4GdLkj9MIAXNttahau8lXZa9Iw4/SA2fj6RtgViN+dn/xXqGBTY+wfFXCEwATvRB1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103458; c=relaxed/simple;
	bh=ZYK/fBItO8PQPsZYOECgypzK4/lUMCC/GecmBuhm4j8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xsd2HAXGcldJbjYJySFuZyUV8HVGt0F58Zk5geioJlLunFJ98Y1B6/SCJAZ01g9+oZFY01Uoqzoo1+cD/Huq+bLSFaVp3LOEV4y/+WtY2Y4dyYIAS9ZwBk5hOPipbDzU5WRJzfbLxQngMmO27wcZMS+rgqrzUQBTfz/zbR+cgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICHyg28x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICHyg28x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A33C2BCB0;
	Wed,  6 May 2026 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778103457;
	bh=ZYK/fBItO8PQPsZYOECgypzK4/lUMCC/GecmBuhm4j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ICHyg28xWvbGfcoKw5d1C3Xq14GmSf1JqU24cN5525NqbA/GsCOSc404LuFzh01tO
	 omkJ792UYc1gxwksOmfkRuxugPpFBXRDBwgPwlg8eWeUEOlAzwerVCx/mR7yK0APm1
	 1Mb1fZpjDEsgT5ie5xTuzL7ZJSRxabvtaOhVhGrrsVwP4r0MMkqDUCrLAFQZjHmSFK
	 6eWcDc1ItymqZxmjwdsSg4roECwudDDnIQKaY2xht107Ux6W4hYKyLYVowsllQa021
	 S8WtPb1gkXxpAzUyPJ0hLuFtuSzM1xC+CqHzuVLxmvVto8F2dHUumPDJbE0iSKlntY
	 veAJJ7Cu1Q0AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] arch: select HAVE_ARCH_BITREVERSE conditionally
 on BITREVERSE
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506175207.110893-2-ynorov@nvidia.com>
References: <20260506175207.110893-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:37:36 +0000
Message-Id: <20260506213737.71A33C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces a performance regression in fbdev by makin=
g the hardware capability flag HAVE_ARCH_BITREVERSE dependent on the BITREV=
ERSE API, based on a factually incorrect premise.
--

commit 62f45d1f26fdd43913871c56d8d0139e89cc923a
Author: Yury Norov <ynorov@nvidia.com>

arch: select HAVE_ARCH_BITREVERSE conditionally on BITREVERSE

This commit modifies architecture Kconfig files to only select
HAVE_ARCH_BITREVERSE if BITREVERSE is enabled. The stated goal is to avoid
generating unneeded code on architectures that have bit reversal instructio=
ns
but do not currently need the API.

The commit message states that selecting the option when the API is not
needed "may lead to generating the unneeded code." Is this description
accurate?

Looking at the implementation, HAVE_ARCH_BITREVERSE only enables inline
assembly macros in linux/bitrev.h. The software fallback table in
lib/bitrev.c is strictly gated by obj-$(CONFIG_BITREVERSE) +=3D bitrev.o in
lib/Makefile, so no out-of-line code is generated when BITREVERSE=3Dn.

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 00a9509636c18..d8e7e89ae3205 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -58,6 +58,7 @@ config BITREVERSE
>  config HAVE_ARCH_BITREVERSE
>  	bool
>  	default n
> +	depends on BITREVERSE
>  	help
>  	  This option enables the use of hardware bit-reversal instructions on
>  	  architectures which support such operations.

Does tying a hardware capability flag (HAVE_ARCH_BITREVERSE) to a software
API (BITREVERSE) cause unintended performance regressions elsewhere?

For example, drivers/video/fbdev/core/fb_draw.h opportunistically checks
for the hardware capability:

#if defined(CONFIG_HAVE_ARCH_BITREVERSE)

The fbdev core intentionally avoids selecting BITREVERSE to prevent pulling
in the 256-byte lookup table, but uses the fast, native hardware
instructions if the architecture supports them.

With this patch applied, if a user builds a kernel where BITREVERSE=3Dn,
fb_draw.h will believe the architecture lacks hardware support. Won't this
force fbdev to fall back to the much slower manual bit-twiddling function
fb_comp() in its tight pixel-drawing loops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506175207.1108=
93-1-ynorov@nvidia.com?part=3D1
