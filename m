Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408477;
	b=Ce4Hd5VY+ArUxgx3SSHyoquCL+rvP2baDtmCaYMQHw0e3Fbs90I2NZqaNLYamIIAWEZJ
	 kQyydmOVM/GzcYAMK/W/Wb8k8voYjCnEQ0uglXK7iOnMKrPJokM/dzwgdkamg8GyhWZ/m
	 aoZwcQ9SckvFltUp3Q3biCKI1m/U0Br7yjGmWWe3ZVLab/3Rtg3l8kRiS8NQTg0huaX9J
	 GFN1qlVSAi8p5d3sx1Bnx07LGSceUpfrZ+9Nyy659eO2jIXNC21c7TNDfoQeHrmr7JFAC
	 x9noWEa7L4ChVNDQ+djhf5fke80Wq4Tsb0gkRpWRD+QAOgjAKbOYckUw37/c4blDbzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408477;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cxK3C23Nbc4yqVGmreAc8CJ+FYjyRWQg9arshqODMEA=;
	b=zNAhfDv90xIP35qFKznEg+BPxZT//GLxjV6BwEQhR9ZxfjkueZVUnH/jXf1YtKsd1Vdr
	 XgrLsYkeKe4iCkHa5NVgU+5gPebk+Ii6DBDnEeta6QT9a06lrsaxzwGuWoqH1g6DATifH
	 Bmj9CE0zp6JEJt4CuxL9+fjnedLKOKmWS6XhxuQhqrj3tKFb5OTS976EXiKdvdSS2LxPC
	 KTWZGgpD+At5uEVTk6YDAoFCcJD5fnuSbmjQcYsrneUHL5WBXwBs+uB2UJ/mOL7XugmHn
	 GD/BjypHVjFRJEIcsIpMZWbm7gfzsQOskHUn/HI7fleuphAFsGobKJJj3Rfr4KSKyLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=C3tEIUYQ;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500E606A31A;
	Mon, 23 Nov 2026 04:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E500E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=C3tEIUYQ
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C916140E024F;
	Mon, 23 Nov 2026 04:34:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sZQc18PK5duM; Mon, 23 Nov 2026 04:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795408471; bh=cxK3C23Nbc4yqVGmreAc8CJ+FYjyRWQg9arshqODMEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3tEIUYQ3qgzniRgqPgfzeVq0C6gcJkbW50yyCMO0tamFLeY90T4dMh12rATmTCl9
	 VkK9j/zYHVz4JuuncO/9w318iDzynTVsUqQ51dqp5FxNQ4xIpz5KU7nHM162RYJjFM
	 xZ/YmKgpnArZkd1yp7AvlD8UNNoA2+HHvR/Ror0obnr1KkAA2wvOJiUTq/MI2cNhuS
	 IDr4xiLcarHVu6KQejfa4oX6+aQQEmi6DJVOA254GFFxIyuFkp9kA9/f4jRSHcaLLi
	 4DZ3k/7HdWtB0jTrRSSa7snb+RoA0JsMGURCyfsOJxRpVmaLNH4efk20iJIF8GOA0l
	 vCFdo5PoGuVSJRL02C2TjcCp9ES0FJB8zDmWKC8j/AA5hvIZLU7zPga1O5CfylyDVP
	 7hUgzcpb7ycNs5FliTuZN/VYKPUN5PI1gxzh+NSDi5bzoR7Mx6TJWSLywqxzUYbZ9Q
	 Quk3JCPKCI1j0/dsJ9osprF09b+zQp+qXsAJvIqAv3FY9hVbDt3qiQnS2ELrVMGMEq
	 R1cLn0xKW+9bq6VNH4UQydj/DoZ8+/dm4lWZdfoynrwWaLNnH/PD2MrbySDSgcrCpf
	 fljDAATkdSMkd9AH7oya9TjTly+tgD40Hky1X7hl7G9gWgv/bgCgtWo/DuBO2JOs0c
	 MNoT5Qd09cBlK3Yyj+SQgcxE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2661840E0219;
	Mon, 23 Nov 2026 04:34:12 +0000 (UTC)
Date: Sun, 22 Nov 2026 20:34:09 -0800
From: Borislav Petkov <bp@alien8.de>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
Message-ID: <20261123043409.GFawPCQT2M-hz0mvZP@fat_crate.local>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
 <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
 <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
 <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local>
 <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>
 <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local>
 <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>

On Mon, Nov 23, 2026 at 04:56:46AM +0100, Kumar Kartikeya Dwivedi wrote:
> I am happy to engage with any actual material concerns. So far I
> haven't seen any except you being constantly dismissive.

Sorry if I have given you that impression. I was actually gebuinely trying to
work with you by asking you to come up with a different solution. And I gave
you my main material concern: this hack to the #PF handler just to save some
performance is not good enough! No matter from where I look at it.

But then *you* became dismissive when you started giving me the spiel about
I should not question the BPF design and I should take this no questions
asked.

And such an approach definitely does not work.

So lemme try to elaborate and give you some more concerns of mine:

1. How reliable is is_bpf_text_address() and what happens if someone manages
   to pull off a hack which bypasses it? In that case, SMAP is basically
   disabled. And yes, "no one can hack this", "can't ROP-chain around it" and
   whatever else is not a good answer. This silly function becomes the last
   and only line of defense.

2. Is the rest of the arch code going to get "if is_bpf..." sprinkled around
   it because of some other performance argument?

   Because long time ago there was a pile of patches which did sprinkle "if
   (xen)" and they didn't go anywhere. The point being, special-casing
   something completely unrelated is not going to fly.

3. What do I tell the next userspace program type set which wanna do "if
   is_Y_program" in the #PF handler? I take them too? Because I should not
   question their design either and who do I think I am to question that?

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
