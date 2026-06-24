Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA4C8CE;
	Wed, 24 Jun 2026 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344746; cv=none; b=IbS0o+75/1WKhhBzfkoy0LEYlkQ3E9s4RcBNfMA5nEmk+7wTA9Eo8S6ELIlE0wDbgZDfAloJTSjqUZO1d4O/qWNiCDaGTTsmPUX5GZZhXCYAa9EsmtRksUgQ5j3fqXwiWv9yqUUike4Ccj7uD0u7mWd4jh4LpocHPxDb0SDrSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344746; c=relaxed/simple;
	bh=Jy46J5RWZojiKt63sAIZBg2qz/8oKi/A0yUo1bBilM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS26t/eqCELbHaiZvrJvmr2o8Nm+KsdlAmBx48QoHUoImnay5E9Je9cmaZzL5Z5doU6/8qr4icCsU44q1YDKFOVdkbCdR9bkT/H3Xa+oyF29FiCPyLGjmmkftLvDmunbm0/RAOMvFT5/CpcqqdobGskiYfS6hrVVbOI4ccLg+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TYGxauwL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TYGxauwL"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 43D6F40E01B4;
	Wed, 24 Jun 2026 23:45:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KwMQDZbVK0C1; Wed, 24 Jun 2026 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782344733; bh=oAac3YjQlgOMQMiCgcb6pkychBKZy76MaByQWH987zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYGxauwLfdo1Q7NMaI4J2T7E5GF2+BqiAzGbYKN6cW/HZ0KVE8B0IVJqwQswl/mLE
	 BGSk69A3nl5rn+L6TtA3VEs1OOvmFCR5WNHtbVv6Bf7iOYD/RrDV7Qejgvc5OcQoU+
	 ygIRfEB1DB39Pq6uE9Wl3O7x3r0+4Cvjw2OByOTCDyUVB1xYQCpd9qK3IppN26JC2W
	 Z61oauNBSaO/5tOLKLUpjDY4dqCkPYGyQavXdANJ0VLs3Iq+/TFYA5JfEZTBoB2ygE
	 xh3/mysyW5dAvkLAh4Ycc9B0fV8J3lLAFoRgTLZ7TeysW8HNjwfx4QNCblJn9TmaDw
	 6ZD5XQZ4114jyimGg7mGrrUOZO+wwCP4l7JSAVuqXyNuv/W33vqHHrdSlj/fVI68Z7
	 t5qpUc2gl94SdxTARX5VNj+Kg5L9cAv+cGa/WrqypA1SA49PHnhCaKmX3/Kgfuv8Hj
	 VM0w8PNufH6GWtm8Pk8oQSlJTAIQetKrHgRudmcmFV2f+/lF24v9hMyBXiG/u87FUl
	 +rcNE5eY19s0xOit4REP8D98cRVqij5WGYo7I6HG91oPy1f8EDS6pix5a8Zsw87gmp
	 SnVV6nV18aShaIUfpEp5LVNVPx9tXeB+LhXeThPf8zc1YLwYznnkW0V9qtb5d1d+f3
	 bPr8v/i116dDdc66nE4IbWLg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B317840E00BF;
	Wed, 24 Jun 2026 23:45:13 +0000 (UTC)
Date: Wed, 24 Jun 2026 16:45:10 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
Message-ID: <20260624234510.GHajxsBgG62PHgEZa4@fat_crate.local>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
 <20260618170913.GBajQmOQyOiBLqopUl@fat_crate.local>
 <3207a706-354c-4e9d-ba53-dded1abb1842@intel.com>
 <20260618183815.GDajQ7F-bqTHnrakoi@fat_crate.local>
 <87643862-e32e-43c7-8c81-7186f30059ea@linux.dev>
 <20260624025732.GDajtHnB1Jc21kQnl_@fat_crate.local>
 <c49b1499-6aa0-4e17-8385-cd2bcd2220cc@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c49b1499-6aa0-4e17-8385-cd2bcd2220cc@linux.dev>

On Wed, Jun 24, 2026 at 03:45:15PM -0700, Ihor Solodrai wrote:
> The instructions are quite detailed, thank you.

I hope... the devil's in the detail as always so I might be talking a lot of
crap too, as usual. You'll know better when you start poking at the code.

> I'll try it and will send a separate series as soon as I can (likely next week).

No worries, take your time.

And ofc, if we decide we need a fix for stable, you could make a one-liner be
the first patch which maybe which disables KASAN inline  when 5level page
tables have been detected. Or something to that effect.

And then the last patch will remove that fix.

That is, iff there's even a need to have something in stable. I don't know how
widespread kasan inline is...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
