Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ADF23D281;
	Tue, 15 Sep 2026 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439511; cv=none; b=Cpnq+Ljhrl8dgzvSA2weDYM3riH40oEwVo2h9eC7s07RNDCS2GlXZCq5cvhrs5bB2YgOXvWf0QUegtLOX8mU6CNrI2MY6UqBFxt9XtvyYE2wq+Uef1T54TI0GOOK6eIoS52KgyvvrmGsJuRqGyA9ZUASeHOXrF6PGaLwsa4yVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439511; c=relaxed/simple;
	bh=fxHbn1hkr/4pkELmaShAa43uMVU5BI2+e8Kwu6VpryE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsK+twJhsfxaig5ZUUwyLBvjRXleGImYtrnL3aXcKfDI0R47KcvQFyq6lfI0nSWLX29V/Ad1dzct3l3SEQMBbe6nfXmjQb7ftLrzjvzeFF8vlqHCK0KrISo8DbNW9MNOTSpwrbSjitPKS3f0NInPoHoPqKj/rvnid7PoIvTpLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=epZV88N2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="epZV88N2"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E5CF340E022C;
	Tue, 15 Sep 2026 02:31:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qjc-Nwnlwtg8; Tue, 15 Sep 2026 02:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789439496; bh=qSXFbfpOKnuvaEbNiDn4HfVO50MtuTzZ+yYBsK0eDiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epZV88N2/8zazLMcKvlccwrylVOewX/+KHOEExwCUJZyMLMKCWdHEWrFddkaGlHo3
	 /rAkqnMLs7Mv1O7gPyalgGsZ8dOdjbczGw2Njwgpys5PAhwuem40BaZo3s+hypRWNe
	 q3Yrxy7XscBDptePVIXSiMXYuxfykS2Z8RkkK1BHI8HqMxrizOpyGEhWKfjzxcSc8t
	 AlUFtRN0q4KjqtEBIWkERV0jvgmC51eiighIb0vTjfehho381YFscFIAy1RTLqTAud
	 jiRLdMRFT5dsNWff0ULOIflPBioo4eIvsF3rjqNyDWcVBh2MQMUVAXh0pQkOmtSAkE
	 Xlj2tcMorNeP2JtXhKWRASpEKkHgW/cCRzWx7nALLiycLmx3p0uLLbKyvzoOqSaNhB
	 HxuqcOgpdoUFJf7m/J8McpSUHbnvjPeFvK/yXJ02YAbBLy15DXsInlAEYdtJd7y8Iw
	 LxlhhpBXDHHLv8DHlM88rBAECYVlLxDxM1Sb6UoGNDSGMtV/3NWk8tYbkrno69CIsN
	 /p9kOKTWjTJ/CyOgiYlvFJtsnEKGLVy/ICnxoO20cuYkqnZS2yRFL+EVLcrJ48TfsP
	 NZVIP2MgDtk66smtyDcdMOALcHCtAPdqOOkJHC6aj1MRsKb0t7dZebPa9zjc3vwGh1
	 LrMYUBg8VAsjRJKk75Dgf9Mc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6408F40E00B9;
	Tue, 15 Sep 2026 02:31:19 +0000 (UTC)
Date: Mon, 14 Sep 2026 19:31:15 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/5] x86/cpu: Initialize boot CPU cpuinfo defaults
 early
Message-ID: <20260915023115.GFaqit8zcWHGkAdHD5@fat_crate.local>
References: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
 <20260814235134.3461435-3-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814235134.3461435-3-ihor.solodrai@linux.dev>

On Fri, Aug 14, 2026 at 04:51:31PM -0700, Ihor Solodrai wrote:
> early_identify_cpu() clears the capability array, the CPUID table and
> extended_cpuid_level, but the architectural defaults for the rest of
> struct cpuinfo_x86 are set only later, in identify_cpu().

And I would've stopped here. I don't think we care too much about a CPU which
doesn't enumerate CLFLUSH. Or is there an aspect I am missing.

I mean, you can say something along the lines that now things like
->x86_cache_alignment are more correct but I don't think you need to go that
much into detail.

> On x86_64 x86_clflush_size defaults to 64. Until that default is
> applied it reads as zero, which get_cpu_address_sizes() interprets as
> "not enumerated" and replaces with 32. So on a CPU which does not
> enumerate CLFLUSH the boot CPU runs with an x86_clflush_size and an
> x86_cache_alignment of 32 until identify_cpu() resets them to 64.
> 
> Use the same defaults from the start, so that the boot CPU does not
> depend on a later reset to end up with the right ones.
> 
> The values the boot CPU ends up with do not change. Early users of
> cache_line_size() on a CPU which does not enumerate CLFLUSH now see the
> architectural 64 instead of the 32 fallback, which is what they should
> have been seeing all along.
> 
> This change comes before the last patch because that one removes the
> reset: without the defaults established here the boot CPU would be
> left at 32 instead of 64 on an x86_64 CPU which does not enumerate
> CLFLUSH.

This paragraph goes...

> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

... here, after the "---" delimiter as it doesn't really belong in the commit
message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
