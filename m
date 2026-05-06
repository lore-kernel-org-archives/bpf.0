Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC63264F6
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104183; cv=none; b=plT7QK8o1cwgAt3Q/rodWRDsAoyT+tSDyDxFR3nRR/mXqAGtNauGf6rH+6k6mDxCLY61Y3NvrpeoexwHzgpONTHMZQ491xk4gCEUXQZWTEerfKUG2R2zZmySzg8a1oN/TVLGjdAz2bKnwkpOk/a0vyrr3xRbhcQF+2xaUhdCnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104183; c=relaxed/simple;
	bh=Y9y2Gvy68fCuKuyJl0Z+tFp6omQst7rBqtIF2XjZieg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sdw64jskrxfg6KkF3cDWr7Gzc+Lzc/JyOERDJD0IsE54DtBKtlbuVvjel82J36EYuHxSZKnry3bNv0yv8SgcygRvz8WqVv1jVFLZMLNvYWC5jPva9kTvrGbZccOIhNBn06vm0UsSC9l/lTfET30Sgg33Ficmp3Hr/73rydVJX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKTPkjb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKTPkjb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAE8C2BCB0;
	Wed,  6 May 2026 21:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104183;
	bh=Y9y2Gvy68fCuKuyJl0Z+tFp6omQst7rBqtIF2XjZieg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kKTPkjb23MXPL8B6FAP5RPfAAgDToVyyHr46fMWSeeuvv4ThYeqjUU+xltdpoe5Fd
	 yBQHDvH33VCNOvh/PV9FYcTibu5+2/8t4h6Qh22lUv7M0zAJCehlkXKmRcf9Pa+/Gz
	 Ne+fRs1E1dA7GNb9C3NP2N8+KA3r/sEs3lcONVfsCLd3f6a4kus5RPoghJ+gblrtXF
	 S70pj09tsLjdeC1f2ZYeclkUjv7sGCOAfUaefWrcBS2W+YPaiE82hBWtSJXC+tIOsn
	 gh44uansw+PmR3Oatyn59IrOHNHxDFtvF8LkwbE1k8W4zRlAiMzcywvLTrke4yeXJE
	 1Bc/HfplZ0URw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] lib/bitrev: Introduce GENERIC_BITREVERSE
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506175207.110893-3-ynorov@nvidia.com>
References: <20260506175207.110893-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:49:42 +0000
Message-Id: <20260506214943.1AAE8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit's instructions for architectures to explicitly enable=
 GENERIC_BITREVERSE will trigger Kconfig unmet dependency warnings.
--

commit dfa2feef3c11e8e7f890a24d4a12c9d0c88f4918
Author: Yury Norov <ynorov@nvidia.com>

lib/bitrev: Introduce GENERIC_BITREVERSE

This commit introduces GENERIC_BITREVERSE to allow architectures to provide
hardware-accelerated bit reversal implementations while still being able to
fall back to the generic version. It modifies Kconfig and the Makefile to
make GENERIC_BITREVERSE selectable.

> Architectures that require generic bitreverse API as a fallback should
> explicitly enable GENERIC_BITREVERSE together with HAVE_ARCH_BITREVERSE.

Will this instruction for architectures to explicitly enable GENERIC_BITREV=
ERSE
trigger Kconfig unmet dependency warnings?

> diff --git a/lib/Kconfig b/lib/Kconfig
> index d8e7e89ae3205..a33988adfaa3e 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
[ ... ]
> @@ -63,6 +64,17 @@ config HAVE_ARCH_BITREVERSE
>  	  This option enables the use of hardware bit-reversal instructions on
>  	  architectures which support such operations.
> =20
> +config GENERIC_BITREVERSE
> +	tristate
> +	depends on BITREVERSE

If an architecture follows the instruction in the commit message and
uses select GENERIC_BITREVERSE unconditionally, Kconfig will force it to y
even when BITREVERSE is n or m.

Even if an architecture attempts to select it conditionally via
select GENERIC_BITREVERSE if HAVE_ARCH_BITREVERSE, a warning will still occ=
ur
when BITREVERSE=3Dm. Kconfig promotes the boolean condition HAVE_ARCH_BITRE=
VERSE
to y, which in turn forces the tristate GENERIC_BITREVERSE to y, violating =
its
dependency on BITREVERSE (m).

Should architectures instead use select GENERIC_BITREVERSE if BITREVERSE to
properly inherit the dependency, or should the Kconfig dependencies be
restructured?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506175207.1108=
93-1-ynorov@nvidia.com?part=3D2
