Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393864;
	b=MQB2f703rNi+1kOEb3xIjU2YJYqX4JlhUugyNfaqt3QRh2oBSjGW3fN7P4gwBreIJHMe
	 s3GjSNm2uG0a4ncNJ9dSGZpeu5Aaik6CncppviVGQA87gpGWptYpGgOC8yEWqsn2x5p4W
	 /skwBMRKPy79F5gr5DURJSUIn4KA2ciLWttIYkcMu7+hdQ62Av1N6iF3zW7AZKMPHSmoJ
	 ZXNyZoJE132UeQTe8MjiepOsptP3Px1TBn/ee/HmoJ7orBYZfZYv8bLSIOceZ1OLgGuMu
	 Bgc+uGF8b1QiWHsqd8Q1IxpQrXDbI1joprlFjd56YfUNVgdp9q/hu7pqtt65yiMnNgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393864;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xeQmcAZxQUTWqI1wKM3X0FAeTjCnZYEkIZfRrsQaagk=;
	b=Ecyuh10bL9C0ow1eLP+cNjD/8qH72STsty48qBIi2vGY+t7W9TzXZJHtaC0WfvkUMSWz
	 pK+WP7/bPbpmUlyOjtUFkAvQnnxr5sgwXkDKfGaFyr8h9xICTbmt8E46igLOswOcgZT5z
	 L2UPqqKoVvfYLSa0tPOzWW+CMSi1bBalffK2lc1JgMYsD6mWzTwsPunCjc45rYpVy+Byd
	 M3gPYqPvia9Em0Wg2Lmi8NK4Qx+14fUW3E1i441m4AJcGn4faOFBQ5uJzvpNdcq+LC7wH
	 pO58rTgP96kAtVoBBBwmL+r0Ju1Ac6MwetzBDoqSlqrdJ9lqXDZKgfo13PWLPRr2yyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=OBUmdcPt;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC66606A320;
	Mon, 23 Nov 2026 00:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC66606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=OBUmdcPt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF7B340E021D;
	Mon, 23 Nov 2026 00:31:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MsE8HQ7xTj5Y; Mon, 23 Nov 2026 00:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795393858; bh=xeQmcAZxQUTWqI1wKM3X0FAeTjCnZYEkIZfRrsQaagk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBUmdcPt/vi1t+PbVbpO09tSAcJ/gINEFuY00drnFzREjFXPPj5xyjURBbx7xHQAM
	 9/VhlvdKtBElxjOEJYmXNAZAJXTtVUykQy9VW/WQU9t2OtL4bJUh6UjbojcZi9Jtr6
	 /ZKb3K3W+EOznrdkjYHeCqjo3oJ1c8g9YMJTsVv7hMUTSdq4/9nWUeArhx8p4c1JL9
	 59FnF6FNySZaIulKH5/TXDllVkyFDvbF+i7RDWwybiQgIUK5BidMSV8j/Tw63OWzcy
	 fM9h7ZAe2XGqOlQOwYx2cl6ZT4UVowMkm4RnWOXuguCKPkvFFpOdFbWuvxHrt+lbqd
	 6g9jP0bg1HIKpEUpT8ihgpTonZ7hyVlPyx0PRMHdHt1UG2At6Rm1d79PqUosbR0LJO
	 QO0LgyeAr6f77jxFkp3RkVLkcAN0/2k+UBo1+q+JE2XnF3w3Eo+AxuU37erO8pWoXg
	 WJKiszjPZoUBpyq/BTWgrdvxmjHhIIwsvI7xKauiwGIs/DIm0AXG052AYnUd2rxGdn
	 jt4R4eQHn1G0VvzPB2AqPT9nKXfwjtYhKeDds8Yf7jr3h9Tc1znFWXPOvJlVS0DZqN
	 xomlTsMJ6ZsNQJxVy9xN+feJnT6eFgvFP9jSxhLkpKrYrTUPjwgUnSomV52srzGnV9
	 ZT5YXXsodcJ6OQK6zwYYqQ7k=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9BD240E0219;
	Mon, 23 Nov 2026 00:30:39 +0000 (UTC)
Date: Sun, 22 Nov 2026 16:30:36 -0800
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
Message-ID: <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
 <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
 <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
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
In-Reply-To: <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>

On Sun, Nov 22, 2026 at 10:59:33PM +0100, Kumar Kartikeya Dwivedi wrote:
> So I am not sure I see how this risks making things worse for anyone
> else. It's not about saving some bytes, if you look at the cover
> letter, we reduce significant amount of code and associated overhead
> from programs running in hot paths.

Lemme summarize our "discussion":

Boris: you're subverting SMAP security.

Kumar: but but, performance. And we're special.

Nope, not good enough.

You need to go back to the drawing board and massage your bpf program until it
doesn't need any hackery like that.

I dunno, tag the pointer, massage it so that it causes a "normal" page fault
like it would happen for any other userspace program, whatever. Just not this.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
