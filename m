Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402557;
	b=eZ72Z+m7hE0R4jQCBqqwCmUiJx/OQrv823wfn9uDg1QwWfeWwOBTOIpYyt0EJAKZ7A3T
	 WAbykD5J8yYJ2APQ7JVbgCy/7BipCKrVMj3Aw0+wjiB6HRaW9QIISYKSBYbX03SbNeIvb
	 6O2IGl3EcXRgg8gm1DcJO5rIY2muTKV1zK/Qcin2E4CJb65VdTw6gdiRF1aunpX45uxSj
	 BWU5o/RvK+TURG3hIAv1uzt7SqvVWexLKElcwu5SdWp++vJQfJrCbQa095s50HthbL5Yh
	 zdGd97AQ0fjfCbnEriQKek5sxDBRdB+Zw5BcjLc6oMeHjQJhdytskMX+DjW7hSQYk1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402557;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EqIOeSS4maIZYOpQoaKUyGKVvkKQ3ikaek+A4bdInE8=;
	b=BYNFVsnbPjWV+UkavUPb3y0VvLlY/QsslfGw/w6ZvkVNSF4iM6BE6DS9PIOIAdzxKHuJ
	 pw+KnYJhpG2b696P6rG3ZAmLEAfTrasKnRDhA/McChXvTX6aAHVXOTjExvoTJWg+Gxrsb
	 7dYRuL+Z6aEcakcKYNsqHgh/izNc83MG9Jjaa6/LBmZAZyi1pXmP7XLo2IcltMX62FCjf
	 dwmfckYwO7mmu0aBQeiRNP4Jh6BbJx0WoL64Mxge2yGY7cyQJnyWrrXjJlNg8/kdyEu8n
	 mzHZl6v0yeCNAtq9eWsTSY/zmFjy8B/rvJGj4dggOewcdVHW7J4jK+cXYO5u8AiBxrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=TfGLRmUd;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EF606A320;
	Mon, 23 Nov 2026 02:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 656EF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=TfGLRmUd
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1E31040E0219;
	Mon, 23 Nov 2026 02:55:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gFa_PkNtywMx; Mon, 23 Nov 2026 02:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795402551; bh=EqIOeSS4maIZYOpQoaKUyGKVvkKQ3ikaek+A4bdInE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfGLRmUdtzJnW/la6ViMQTiSwsoL3R0A1zfTDHeSvfANolurh0+sxxj5KxR5WFpaC
	 KW5hVzOm4QsNKoaJutroDVXQIO+wH4NhfKPoKme+rNgCR8YNCU3dINxIunsq3sFUYZ
	 WjwDX5aospN/W6+SWH8ULNnGWT1iHgPPmZ7o9pkJ96SyRK/4aCqvBkDwFdjZsgQ4XE
	 AzAdLT+dVvOlc31X7ofEpdbmjEOMMsuSET96FpMjcZmOPX2bHuNLSaMIWLUGmje6YA
	 13kkrGqdyun1KyeNs2Ual1cV/454cpkJYrgJmXhwoMClxsDUI7ftGh+jv8E1OZdgeP
	 NFjH2TK6nAhnvEPyiz/c/c5zH76ckDIi0sDQAXTxyYEKihMhAtJEXUrbo96Qt4y9La
	 3RGyzBwdx9s7aNYDIv/UuowNUthUHbUvM7qoqp5SXI+6eCytBg5A4SLP7OHbkYFGty
	 wWJ+RgnKc3iK34rUNVLu4LWUD8PzgrdQC6MEsxUsJN5TyGASFXicWSRhV5nwjAU5sA
	 5IaD1EtkIMm28NHomPDDu5rCunoyhssYwgVJL8LpibAz3D6hXpBleIpp834IeLOjiv
	 61hfZjgMLdhKX+47aMfRqi+zl8c6DDTQLC4D0/Hka6y3XeAnIcuvAM0GZL2mqVWRCa
	 YqAaVeyZWX4UUtBdaCFL6C0s=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C0BE40E0240;
	Mon, 23 Nov 2026 02:55:32 +0000 (UTC)
Date: Sun, 22 Nov 2026 18:55:29 -0800
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
Message-ID: <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
 <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
 <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
 <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local>
 <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>
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
In-Reply-To: <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>

On Mon, Nov 23, 2026 at 01:59:32AM +0100, Kumar Kartikeya Dwivedi wrote:
> I also don't understand your security concern. 

Was:

"the only line of defense is for is_bpf_text_address() to really DTRT."

not clear?

Do you want me to elaborate?

> Thus far, I've tried to provide reasonable explanations for this
> change and clarified how it impacts nothing other than BPF's own
> behavior. At that point in the fault handler, without this exception
> handling fixup, the kernel will panic.
> 
> Instead of paying instrumentation overhead to get to that point, we'd
> like to shift that cost to that path, that is already otherwise going
> to lead to a panic, to instead continue the BPF program.
> 
> I don't think being dismissive, telling us to "go back to the drawing
> board" without understanding how BPF works, or arguing "BPF people
> will do bad things to the kernel if we accept this" leads to a
> productive discussion.

Lemme try to parse what you're saying: I don't understand BPF, I should not
question the BPF "design" and I should simply shut up and accept your change
because you keep repeating the same argument over and over again - performance
- and that is absolutely very important and the page fault handler should be
changed to special-case bpf programs.

Right?

Anything else I am missing?

In any case, here's my answer: NAK to that patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
