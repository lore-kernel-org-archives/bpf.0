Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795738719;
	b=na/Mv342Zdq7jJCH5v8hAzEW2mLQ1B8bEGFAh4D0sBt5yLa5ZGn+zEGkJ4NMgzFe9RKb
	 sLPLRPRfAvdVq3rTSNAM94r7Eca+1DNAzYe++lU58Gtq1W0DHmlF68zbTXq2SJy8Y8jZ1
	 CL5iPL6JbOdFOs+TrGirgLReqgf0iaJ0vBF3cBIoj0A4wFx0Bumq0DvzlN5atB4dC/U+i
	 MsDB5snOUXdXuHLDu7OOj6FYb0dvHWtEPgPGYQoh6x5VvJW0nXyWJ12q+2Ve0n6QbNuZX
	 Vgf3KATzQDjqsZO0upGpEV4fzf58CNjFT55jmUjIbwYgCM22cSCZ9aFs5h3vugKYuww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=jEQoUDUHXfe47VJ+kLpzPaj5h2l+/kTai5BVTBPq2W4=;
	b=hmHGROieZi1z1ND+NvmYMl5l5dzGQ+Vy3NnbYzo2r4y5EGK6BzOaboVhFHfqahf29cNW
	 6qyQj61/LAUgvK+nIPuC2TR5vp6lqkD2EvySUduYZ/uu8Jk8S2ZrZpk+RvU3+EplQBEow
	 RT4cQ4imqOeyeZFXetwf+Py96RLverXRAgUHZziQ1hx3TUc5+/bKlrN/a/6ghiFqUVOq5
	 gutOfpm/j4KQp/mWqtcsS/ftBBYE4c0xHw1AnkWF6M/27dTZN6H1PKHazPWmgdohOoJD/
	 fYZF4dXBeIuI7aTeDm5FFAop3bbkHHFKOBPOFXeKRdaHvfIa6ieP9kBppPCfHLSX3FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFUT+IRS;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75024606A31E
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 00:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75024606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFUT+IRS
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b41e627cadso4661880a91.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 16:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795738719; x=1796343519; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jEQoUDUHXfe47VJ+kLpzPaj5h2l+/kTai5BVTBPq2W4=;
        b=RFUT+IRSg/juX6qTvxJ7Ac7jOoqAHJkDITQUBthK9OscfT8CSlOOyHthdGZKs/Wd5c
         MrQz3z4eQMDLCLkflKukQ9fynuNaE4beSAb7/QUHmLaaowidTgzHCHQoIZLSUa8MQ0A9
         Dw71Zhruay3Tb1PDcZKZnZB92oT7HWAq+hb1mu6Cv5ROrnaeQOz17uktFdkNS93qHJ+o
         5Z0LYHJWwdt5TAeLQGpg0cCQRwedLLZBs5gGZHYgN178OknMv5Jkd30BSN+GhPhTdF09
         33V9KEHM/6ixQkh4bcrp9MpvnJ5XtakDKt0rbZthbDt6tqP3WARno32UriQapTVjWAfy
         yh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795738719; x=1796343519;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEQoUDUHXfe47VJ+kLpzPaj5h2l+/kTai5BVTBPq2W4=;
        b=O0IIgdiYHmhySffGK0wqa30mZbRK9rbhETovwu0+XTlBt4Y6cGDF7BUeXtPBwnWK+K
         p/PW/ihDhQTISb9IYSPfXkf9/Xv2ykeeBXukEW/5FyeIczO+ARLEXoKfCkGsxG5tCP+/
         qeD00r0odvGVuhHo2StYWUzaAj3JwIuvSqYfRr5eo/nYE72JHacgVZXbZI8wfIDFti0v
         VUSUrOABBOO1oOhKLXhvVFvgihnaYRaW/G+CEEzhL7N3LYa1V4AvgCAgyG2Xlwrnms4u
         dNwu/bMEMiD52sPEL7oVuKQc/M0E1TNc0IHSWDm/whSZpAdd4m+jTcLbSjrBegfZOLmX
         eAPA==
X-Forwarded-Encrypted: i=1; AL+hErEWFSPouD1bQrKBWfIqF2AlmkGsXKK4uXo3CwUw6h3yffUlpyAxsehwJT92Kp+H6H8/dW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b91qpMx7i2A9kutEuxFwGMGkHe3dcGVf+bJlVEJqldlaIhhDr
	BgkWaluXc+25GGz0sCPptUORZiLDAeRTN2dPvokrEIXq0YDt4EsLcCI0
X-Gm-Gg: AZFdTZe0tvmmy18F0jmXGNosxRgumIR8GfV24ieHtAm5HwUIgmhXk1zhr0LSh7qrz9A
	29sKStTDFqR2zjHdo7D5oq2+3PAzl7emhuw8UPT94q8NxGM44zOxbAbdYQjAHSfRfxETtjGhR3O
	53F1klYkHM1BT5PRbz4st00M56Z0RjFD+oVb1lFS0ZNNSnO/C49W0QLrVueI7oDCmB52cZF7KzY
	09SrvEk92a25mOxkOgLyuOmfSBuxzMa0IMvsARpEVhVwPwDcnNnTTtVWWQVLT9RJcX0IR1sJwUh
	HYYwX/O+s2ZclDeuPYvURlnauix1j4vAvwWRgjVsQLKcn4zpmJV4YugcLjsi/0qHTryBKnQlHPv
	xQMulzml/C4E7gaRNvJxLupavcBVCqh+nvMKIKkqrzrYqFxgy+qygwPqQQNBgFg+eS44FrR2gdj
	bWPZSaThJgTlqcXATAcOayT0ocCkO6PXsIFgIvseDpY/71zN3tg6ucQ+oGQTOm7PUM80WJVrWKN
	wL7/eeqyyEILbVT0b9vojqN9buQsAIdo2vTpHXThetoeAoZcWVUWKxtF6K+i3VnWYF+fvYE1aCP
	uTvNaZgJuyglrer2O1GXoougrRkBn0eOEv43wYaLcld2aVLf//NK2OSWqd93P18S2dSvNW6ECRi
	jiaQktS9tv968/LQK+e8BfgXVrrpLBpK3Pw==
X-Received: by 2002:a17:90a:e70c:b0:3ac:9df3:6b07 with SMTP id 98e67ed59e1d1-3b41c9234b2mr23726357a91.24.1795738718594;
        Thu, 26 Nov 2026 16:18:38 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm15510580a91.0.2026.11.26.16.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 16:18:38 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 00:18:37 +0000
Message-Id: <DN5K8Y9824AE.3GPOE0WP9ELFN@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andy Lutomirski" <luto@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, <kkd@meta.com>,
 <kernel-team@meta.com>, "the arch/x86 maintainers" <x86@kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <03275761-8de2-41be-92fd-8e3012a87eeb@app.fastmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com> <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com> <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com> <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com> <DN4X9KVYMONH.VHKD1QED1BUQ@gmail.com> <03275761-8de2-41be-92fd-8e3012a87eeb@app.fastmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 26, 2026 at 09:30 AM Andy Lutomirski <luto@kernel.org> wrote:
> Okay.  So maybe there should be a nice patch set to *fix* it.

In a perfect world, yes, it would be nice to fix, but no one stumbled
on it since the probe_read_kernel appeared in 2009, so it's worth
fixing only if it doesn't kill tracing as a feature.
Kernel observability is a mandatory feature.
Looking at 3 options:

> 1. Walking a little list or table to validate the address (which may require some sort of synchronization and obviously needs to be NMI-safe -- for systems that use TLB-flush IPIs, blocking interrupts could probably do most of the hard work, and otherwise a little flag set while a read is in progress that can block the change of an address from safe to unsafe would do it.

walk and the synchronization makes it unusable due to NMI,
but we we can give uncached ioremap() a different range vs vmalloc()
then it might be practical with a single range check.

> 2. Allocate a PKS key for the purpose and use it.  (Only works on systems that have PKS.)

My research showed that the effort to get PKS into the kernel stalled years ago,
and it's intel only feature.

> 3. Use an entire mm for the purpose and treat it as a user access.  This is probably the cleanest solution but it will be slooooooooow.

You mean like use_temporary_mm() with direct cr3 writes ?
If every read needs mm switch that might expose intel HW bugs.
I remember div bug and I bet there are more lurking in the hw.
I'd rather not push the hw limits.

As a summary I don't see a practical improvement for probe_read_kernel.
Maybe there is an option 4 and 5.

The main point that it's orgonal to this patchset.

btw I'm planning to explore PKU for other bpf needs
if writes to PKRU register are fast enough.

