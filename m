Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3741325E;
	Wed, 10 Jun 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103032; cv=none; b=gzbXe246vHtsPSliiJjrS7RpDFIcjepkVt3AWPnWEf0h0hK/njV+TgV5eEn0U7ApDIpFJ0H4tu41RYChuF3k4dnhR06agX6mLrzz9L+zaYHCG4gPiyiOxMr8rBfq7F3yzQFpfh28Sx3vFZv57gDBAwXGuK1kXpdEam7cl8ZYg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103032; c=relaxed/simple;
	bh=kEmwiT7ztaLKTE/AXyDw16pOXNuEA+bcUkuEUtNrnXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg2YImxQTZEqorogyMzSxFtnr5GfnG8IpI8TxWWCyTSK0yrCyi/51tRWw1xx65QOClS2G+NM7qc1H5hkDmDv8bNSWSohSgdWRwcv+8fLU6gN3kneep+HHFJTQ4F6yb5KAZMO+aSJahlryOUjPkJMgAG+7AMGiZxpvrQPYanTreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vB0w3on8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vB0w3on8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6cBb/7PfPr18seAAc+jd6aknLhtzGWH29hDyeS4Ef0o=; b=vB0w3on8CW+4+m7XCQiAD0sE2W
	2jix2Do0ndAYMaX/PguTiuR6HZ+hL3mBxD+DgRlz2KI2Kwebsf7uUf8CN6s3tof2Z/GpwpcRGWNe1
	+A2lHI+MheKIWTdxsIE71tUH7Gw+hk3COooxfpKhhJFfDj/1yEEB1e7Xcm4vHPj92/p8O1rQgJ0Lq
	cDijR2vtpBHqlTYjlSMvhB9sTwqT+hHHwUH0e4Oj0TOVd9WkkDS/XOO549/fKgvs7hDr/xMAX0yuk
	ZTnXYoj6iKaTP81n3Ic8LaHeFezf4ovtqypav/Lbpz6OnJnj6Z1NFUnJmBASMLO6iV+33+La4nXxY
	CAWz81Bg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wXKFx-009GU7-0L;
	Wed, 10 Jun 2026 14:50:13 +0000
Date: Wed, 10 Jun 2026 07:50:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
	Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/7] bootconfig: render embedded bootconfig as a
 kernel cmdline at build time
Message-ID: <ail5fuwSj_cOHOn_@gmail.com>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
 <20260609-bootconfig_using_tools-v4-3-73c463f03a97@debian.org>
 <ebb4fb1d-effe-44c6-82dd-8223b36419a1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb4fb1d-effe-44c6-82dd-8223b36419a1@gmail.com>
X-Debian-User: leitao

Hello Julian,

On Wed, Jun 10, 2026 at 02:44:52PM +0100, Julian Braha wrote:
> On 6/9/26 11:28, Breno Leitao wrote:
> > +	depends on BOOT_CONFIG_EMBED
> > +	depends on BOOT_CONFIG_EMBED_FILE != ""
> 
> Hi Breno,
> 
> Just an FYI, this dependency on BOOT_CONFIG_EMBED is redundant because
> the:
> BOOT_CONFIG_EMBED_FILE != ""
> is only possible when BOOT_CONFIG_EMBED is enabled.

Good catch, thanks. BOOT_CONFIG_EMBED_FILE itself already depends on
BOOT_CONFIG_EMBED, so the explicit line is redundant. I'll drop it!

Thanks for the review,
--breno
