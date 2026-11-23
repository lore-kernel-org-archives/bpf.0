Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795395611;
	b=Ufv0Sn9dCm5kiiQHHxnGsNMQ8X366c40eXPK9mVgQAsD3sLltCapFESAsAUILkKQoD15
	 p9Iyv79gM/aGRewZDHAmzjJr7zmXqfFGAqnh+fQGQrN/Y1SO21eSxKQ8id5RAFdmqZFpG
	 V8/Ar5UhIJIHLuV2Qia19GyCiOYvsuj8ng7xVnVY4XCuaGFLm+qEwdpHB61ZpX3hjd4VA
	 u0Xx+wJ8XA06WP0iHhMxkggZ8tf6o5Yt6z8PoLj2gNNhwqsVDlHAvAZ2DkU722mccMlVr
	 lUf5cJkNZw2L+KPsOK75175aM+8PlWNkuPIbGHvmhLOQpd+BrQMNrq2YysTJsI0e1Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=piG+kL4iC1Z4Hpe7xi5Xl4SWpL8eCvTsaqDj3n9+VHY=;
	b=CiljzzBIeTI748yXKiC38glNBhrFJD3tOGS50UKGMM1PZmiswfCcWzUMgfxLSk0alQb/
	 KA4xEbLiQpQGPthpfR0e4NAPxnTwJiJ1yix1HqGYQLcAr5uiCXrg4+omDP7PbcmkiktH2
	 U++5T8fResvEMSOjvEP9+hoElLf3btpHd3FqBOjedgJGBx097pJB/lR4Q3z8x79h0l1vf
	 f1t5qpEfqN6StTXV8fIOqMigr4RRU8Jyl+vAyJIFrKph1yMyJaU7yO6AUjv/wjp9atmZ6
	 iMvrydIMqNKZ/KhDQzXhUKxJwbmlu2cYJlKugZck5KvIMck2i4PWZ0Z3MRW04VdYN9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfX3rwEI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B0606A32D
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 01:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510B0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfX3rwEI
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4a3109444cbso176038f8f.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 17:00:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795395610; cv=none;
        d=google.com; s=arc-20260327;
        b=CSBK3mJWfLmHqhNCqAOtc2Q5yD8rODdoTohcSVeMp7k9N/AaElQvTARR4tcDNxk7lg
         eEOQ8HYB2GqKCJ+oZe+5hv5HGGAiwoogdSZnAYOW4Z5FgiV6GTAHDRdgsqEFsYG3enLM
         lsa7+N4OaQlpKFcDPNqAcet7L69PlvUlvkFKATie0MhNlPE2tit6SSPezmsiWEknQiIx
         sKmFbf7LRsUVIPko3SSMQCwCjOsPAT/9JA05nnRdB5gvgBqrsekza7VKj7kiJHZtE0CE
         G73yc0e8XkOV8TjuX4XnzFM8FrkpNPisuNI34Jay9PbilNQkjl9AVJq+8fTC0sbzA5rr
         2x8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=piG+kL4iC1Z4Hpe7xi5Xl4SWpL8eCvTsaqDj3n9+VHY=;
        fh=egDHTYiRlWEhjX79I8tyYfgSLjlZiSst1N6eRvPbXzA=;
        b=bnKGNAUKcPaE7B898x/34A9ZH/OQUfVoem7mP+aTVoc9CqKEpOKg7iyMhFtor3EbMT
         NWyuzF2lYpxJvdTR+CIeBhM1jtZoqbqrBGikevABDrt/oF/f+aH1iSOlDCqv5B7S3ypq
         kjXZPeULVWcW5cogx8QhrArUKKG+N7J0VDx1Iv4G1uMFLHbdj4rmQNTOix8cS+yjQUDm
         UFsWqSHT7syhbBB8LmGF8kcLNZ8AjQeuwMZOEEnGgJy6DeuqPJaHf8ktX2aOF4SbtLkt
         unuoHVJWUuCroQLS3PGvlzeEWiOYl3xLntGrfe0mb/39fXHJoDIKnFbxVv4xzaB6IK6e
         Xskg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795395610; x=1796000410; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=piG+kL4iC1Z4Hpe7xi5Xl4SWpL8eCvTsaqDj3n9+VHY=;
        b=zfX3rwEIZ4ZO/jWh2ws3j4Y3Aa9Kc/xx3cnFdFkVAkJaPk2BM3l5XRcFpoSR7q+YiC
         6j5dTQRhOIjVE+zM1agQ4QU38WcG3aO8/8qeAR23noGcTrNmXyBNK0F9kHwMF2oan1+U
         AnQOLnlXW3gOudzhRe1ISQpOcJ7uL5Tg9ECgnfW7hezDZIiINeJR5YV6VbemoyBQ5xf7
         BtBJ+XPxjue2tflFEm6xcM+QVU98LDPI2eB9jHMFAmG3IIKAWsxDKnbjMGbDvLFo6++n
         4pgqlQAb7qKsTqvcFu1fYqoJwfvWFBrPUaL/ZRrjxDXCPMzwHGtn4BDIqSLMk1luC7kP
         sR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795395610; x=1796000410;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=piG+kL4iC1Z4Hpe7xi5Xl4SWpL8eCvTsaqDj3n9+VHY=;
        b=wS/9IS1Ilrn6mQ4VtzKzLCbpa9HEsoroZFiZd/PtnEv9Mbv+ILZlS9325rvF7BaJ27
         p3pG0Wc26VMuRVUt6Z143rXwrv+3C3z8ojpFg1xrX+xRLKu/0fs67S/vAPI7KzgdIXME
         8FMMAZSyN2Nip3B4PlQPUT5ONUNUQR/cuhRR4oOLwyJHinwfPyyLsBu+Up8ntlzFYxvI
         N1zbeRzPHzYAT06XytaTLRjQlKjVhrm4dZgvYDljCiYXYJGvU6RJMjYykMtHxnjj12Ww
         f0g1NFPD4GcLq5v8OfoEnzTyz6QpdcoZ+wI4lrCJgiMBfM99M4nAuYLi95SaMwS73PfO
         TaIQ==
X-Gm-Message-State: APuU4Z8DfesO+1FtTR/1ml6HmD8jSuW6YeWwzI//5llKiEnqOjREIdCb
	fDF1pK3hlE87PHZ9pBZ6rdmE97/d2imAJUVfVB8yGwvCwzZXGup2WNdt4ccqHhME3r66CKu6aix
	JLvtIOYKh8VYDtTQh0vSnCop2S4f+T7w=
X-Gm-Gg: AZFdTZeGYHi4K2hkIvX1y7v1Ade5WjHpmiQKHz3AbB89ccr2SRjNKvMo8qrktTUyb46
	X9yXq+0wJeVXs2/56ZCiYGUt7tdr/+CYoHYlrn0fOWb3ZvnvBM3+7u2IQkJuabVQIvu9emdnRTo
	MPYJqtK88aoI09ihdIgB4h2jDOc0J2s9kI4ynQpuKFKrdCXpA2bd1cbGZUSqvSMuF/J3wfP53tc
	9gwLXrmELdhblbIep15YTRWA3kEpFP1/2UsOMSx0Uf7Jrvh+MpPCu26DXnT+E2QY7e98Ut07kas
	I+TSPbbNzmPT54sVWpEMOjZEkbErYYhwj4M8/zB4NVGEXhpUo2vBtEM/k4S1gEY3uJsfNOR6I11
	PR8rqgpdx0sfN6610Pf4wlPODajh/I5jKlDoYfkVJDVgwIjcmsseSTe0ZK5X96Yt1Qgn6pPW7Z2
	sfRiYi6hBV5L/zYGTR9fsz+FkhIsXMe9t3U+WA5dZlSmjOMNIve9wsKP75oVLpc/bCpcbKSSIyR
	dLssHJGwiMedSv4
X-Received: by 2002:adf:f192:0:b0:491:e477:6820 with SMTP id
 ffacd0b85a97d-4abb3a4d388mr14634915f8f.20.1795395609469; Sun, 22 Nov 2026
 17:00:09 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local> <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
 <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local>
In-Reply-To: <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 23 Nov 2026 01:59:32 +0100
X-Gm-Features: Aa3M54qOPnpUyDXKZHWNCJGKCw1YeuvD3U8ZqfH5NfXKEBHeXQ6oONmoTr3LDGc
Message-ID: <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
To: Borislav Petkov <bp@alien8.de>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 01:31, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Nov 22, 2026 at 10:59:33PM +0100, Kumar Kartikeya Dwivedi wrote:
> > So I am not sure I see how this risks making things worse for anyone
> > else. It's not about saving some bytes, if you look at the cover
> > letter, we reduce significant amount of code and associated overhead
> > from programs running in hot paths.
>
> Lemme summarize our "discussion":
>
> Boris: you're subverting SMAP security.
>
> Kumar: but but, performance. And we're special.
>
> Nope, not good enough.
>
> You need to go back to the drawing board and massage your bpf program until it
> doesn't need any hackery like that.
>
> I dunno, tag the pointer, massage it so that it causes a "normal" page fault
> like it would happen for any other userspace program, whatever. Just not this.

We already handle it properly. The only practical difference without
this patch is that we pay extra overhead to handle such addresses. It
would be useful to shift the cost into the fault handler, since common
programs instrumented with the relevant sanitization do not exercise
it, but still pay the cost.

I also don't understand your security concern. Since the destination
register will be written to zero, I don't see how the program gains
any new capabilities or reads anything. It cannot use this to bypass
SMAP protection.

Thus far, I've tried to provide reasonable explanations for this
change and clarified how it impacts nothing other than BPF's own
behavior. At that point in the fault handler, without this exception
handling fixup, the kernel will panic.

Instead of paying instrumentation overhead to get to that point, we'd
like to shift that cost to that path, that is already otherwise going
to lead to a panic, to instead continue the BPF program.

I don't think being dismissive, telling us to "go back to the drawing
board" without understanding how BPF works, or arguing "BPF people
will do bad things to the kernel if we accept this" leads to a
productive discussion.

>
> HTH.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
