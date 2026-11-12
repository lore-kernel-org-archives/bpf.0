Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508390;
	b=qwQJ9c7n7dFeGTRrBe6S2hWSdkgAx+JBj76v14p5MEYGYaDnqrJzPcFMTxIZYehd3vME
	 s0HL0ZDvZfnCjsZHuMeAVJGems+2THdfUpBzq/gc2EOHLM0+YHvmuSeJstMNYjFxRaTGs
	 LRK48gs9IY5NFt1LB990qrimhD7RToZAExaQBOyL5oKd1R4PMY8Z+HppDYUhckRwcvUdN
	 QZjB1QV4WFlE2RADdgiW8lXfQNUS5am/fqr1WUJZuzHHz22zyBu4XhFjkMRqG23FqOLv7
	 JgfPDe/gnC5iD9ScYRGLzg4Q8dVXJEbWJ7l3FN0INJPTXjK5TXlJ6kbJIdLnGVg0Lww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7XTaMBSJocX7R1q9IiXe5TvK1ts0/2rtoQ55kCQz38Q=;
	b=xzVzr0NyQJp50Mh7zInKY+mIAVATKK3RP0GuciXdjYuz3i1IiGl1nDjRIPl6pNvULk+7
	 zyOISm0xQynEKf95Cy4SlzGk22rVl/ZcG/rAsAZhfRrDE22LQWQoYIZ5ThK8SCWUc/zzD
	 IbmpaAJb/1hrNeBKC+S/5r6rcOzUCLIiUGLcSd5v2T3oQbIy0MkipXFxAJ3AbJvIxEzEU
	 8DqBAx/TqtxIESSP6TKDPz1plnuuQsjNT4W3AiTDanTFEv2D8mWUwT/lH+FAXLBksIw/K
	 1h0rAt4JeZJnm0b2MIsmzkkyogEZI1mUEoNi8hC0N+teFLJh/ZYjXMZcvO5c1wb8Pog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+hCYSRp;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A3606A8B9
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F1A3606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+hCYSRp
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso30343566b.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508389; x=1795113189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XTaMBSJocX7R1q9IiXe5TvK1ts0/2rtoQ55kCQz38Q=;
        b=L+hCYSRpqtbZvvzfTPM51bNUhMq2BbuykAG5oFAhxSmlmrzcY9wgwVFlr9REQwSZ3x
         wFQ6aD5XkVDSlS/t58e2UDg4YJLULKoeISY6s48Uc8/WoP71bu8tnqwwhKrweZaLpmyV
         dIFkAlIIk/2ibebZ6Clb/IQ1VW9uBuNzs3oRGC3Cy/4rIjM8ybiqZ+dPvrCsX7ObOkTu
         3yV5Ycwm05puJ4S++T/NemezOeH+JiHw7TmJPBFnw7JNh6J4/wpJgrdWY4J5FQsB6Gkq
         ctxI8c7X7ypxK7cTPvieH4Y2A3rpTI2NqPrPISkBK53e2xSFbKFOl1D6Pa39J3FtUw6v
         egfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508389; x=1795113189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7XTaMBSJocX7R1q9IiXe5TvK1ts0/2rtoQ55kCQz38Q=;
        b=kc5dGyuO7VA+p1cSSJugtydRUbryOrktXgjXfocnStl5HwwR+i95gBewOqmvYtgVvU
         noAusTiCU6mxT4rvW/GgBhMd77XFNdYdELbRROjX8YzMKaXBVP/y846HVstNQsqqYAlN
         sp6GIccSCj5KYLILFLPQivRj+yFpHW3bUYrbw49HZZje2dSrh6fyiPeQUWWtcMR7J1mE
         A+HhtYE0KT/tClubDKTJsaYS3ObkLYfIgQxAy5CGFCKLVR2MmZC9eoB2WlBrRoMSG3no
         cEHODTk/B1eXHMzTgsSwiFrkJjYBTr1onJ8Tfb/w9lKXOHO0h8blJlD2DULnZZD0AJiB
         7thw==
X-Forwarded-Encrypted: i=1; AL+hErGsAQFE2VnCRDjCGBgLKAdgYm5vr7NhrnQANl8euDLke7UnTQXxszHkzfhHh/OHGZwzEi4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tZtUXJGBOCtCkrcEU9Dsfoqhfr450O5xqRz+fJxN6UMO5B6cy
	3jsbRPZjLpXcCua7LUWVUUhrRwm9sel1amyye7OjWaMi3HVs9Hoa6Px4
X-Gm-Gg: AYBFou3hmRHv5IWbGbt0Oz1mD4+qawmxaerBaam7OxNAD8b4lMZzbVLd9JJjw0wVJ1E
	cUKGKRQFRonjYMQCu8DAJbmb3tPIjxbWy1t9I8hXojDUf83ek2JNyejzoUkkhMs6jwkL+WJaY+6
	92SAwarYoAUsg61bHyLfgrOnyPdsm8exGy5MHfMDo48SpXl6VqOBduBBTZp9HZCwZcdpDoiZ1ja
	1AYlTMoLIMlFPRiIfBJMdCAS08C8P5NqRkUyyDgTXuanxg9Q+M9et+Q6zQoH6gYfh2gYGMM2DNm
	5GLQuhE1eNLFs5Dog/mWAl8Kn3N6LgTCyGBCg/fschAyCxrMUkKoAklQuXv41Nfk/NreCCelw3/
	KPHTXPIhyGWp5qc0cmB7i5BiNWiPZi23sdNHsYjVUHBPFYbQ0DS/3jj/TOdhIi5STM3yhyrwqi/
	d0ACGrv+DHYK4V4g6CzygZYaoOSPnXh/O0qR0i1EsjsxM52H0v05WsiAEjdLM2xMXrt/bpRPTuR
	cPOmfSoYM8qoU0STSHRi/ogcRsRu5nO39r8EHZUK5OYPdbm3vJMQlW5iXvjzdTi9+B+gY8DlCAy
	/0uhG9hISOenp2cQiHZrJ3I6NvrP78AofpEMvw==
X-Received: by 2002:a17:907:c0f:b0:c2e:2275:1168 with SMTP id a640c23a62f3a-c507c3fd35fmr333753066b.19.1794508388705;
        Thu, 12 Nov 2026 10:33:08 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b2369asm6139766b.25.2026.11.12.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:03 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <avYGX1UpGlvbvHO5@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
 <20261112090734.GH2668804@noisy.programming.kicks-ass.net>
 <20261112101108.GE2669272@noisy.programming.kicks-ass.net>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112101108.GE2669272@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 11:11:08AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 12, 2026 at 10:07:34AM +0100, Peter Zijlstra wrote:
> > Looking at this in a little more detail; I'm confused. 
> > 
> > You're literally adding an index, so that you can find the
> > static_call_size, while all you really need is static_call_addr().
> 
> /size/site/ obviously :-)
> 
> > That is, you could have just created an array of relocated site->addr
> > and sorted that, that would safe you a ton of indirection all around.
> > 
> > That is:
> > 
> > 	index->entries[i] = (long)static_call_addr(start + i) - (long)&index->entries[i];
> 
> Should be:
> 
>  	index->entries[i] = (long)static_call_addr(start + i) - (long)index->entries;
> 
> They have to all be relative to one location in order for sorting to
> make sense.
> 
> > That will make your lookup take at least half the amount of loads.

hum, but we still need the site’s init flag for static_call_is_init

I could store site pointer directly instead of the index and see how
much faster it is


> > 
> > 
> > Also, you really should support modules, there is no point being fast
> > until you load a module.

I had that, but decided to remove it because my follow up changes
did not support modules as well.. I will include it

jirka
