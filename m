Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132639;
	b=P+P+WDQeE8NA7I9TjcmoQJgU8P8EbV9BRa7k1Lf45DcvZ7TBIHkWQwSgptgLWjuYkjol
	 tH0xPBTMFJKi8EQ0/zk2d5t+0CDchS4HyF41FEkNXYEUDUDGBIIhdQVdkkAEdrkbDI5jb
	 Q+Z9Rnl9c1r+2PQO/W9i3RP4B0/vmnOOrMjJZxZRXtg4jbJQ3eJ/a1fP3PBt+uWW4g4Ny
	 n56bC8XaXmXl8nr5jrZ4ZcdbvB9kNkTWakkeNvNNTFXErIOM8oQNZFGgRC8PQnAQpL4JI
	 RYgXIl2++5ylUSzb7diqMBPv/x9/NWCVZ39+eeBDJjFosK1EGbvW4YI1MQzMEOAPvcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=vdTD+z1BV7ER/sJNdW9O6v4cJXxLTFSb7KPymHiyT9M=;
	b=lvvkP4A3rVDKZb/dJ04ltPwf85tyBuUq4QPMwlSvU5IYBoqedoqjRnJyWcFF60eQRZhm
	 Rq7Z9AevRgjYxvdok1GBrHphbUanUdbDla9LbIPoDZaN3DeU09ktwbmWwwkWHyYnm04CY
	 WosjsbjU5y37TDcjxrRZsvdcgFehIoDsePjB782z5efVRKfb1pfhpvACWm8CG6bZCYcFx
	 cTt9RVEYPycmfDpqMxeNAKiAxPOxiO1TY1rxX0/7OzsK9QnOhjiqIcxuH9NoSt0ICFLZC
	 m53b+W55ZxYaeSfkT3w1jCHlRCzpPZIMnJgGGxhGCRX7OJvSbZQ8Joz4Lj94iqWDoZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U0p0PjzB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.136
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93178606A325
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93178606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U0p0PjzB
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4a77811be24so2177955e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793132637; cv=none;
        d=google.com; s=arc-20260327;
        b=PyxWmFIsroguWR5fN5PU/w1aEAbY1sOeHaWd4wMKQg86yi63AcYBoPWbGRVl0sbyhl
         5RsttI9dFrhJx6CgTPElNBtEiSaHtT6p++5m3xmUCFaRf8ZE6/nTJULeeGCEZ128wnBK
         YjyvXNggnJkxbK4kHYAXOYn0bcrHj+yIJrRasZ1hQE0vxIl4o6+S6FzEBRjj7L/xbR18
         melTw5mNcsG5Ro+9MBdVTKXa4BzPq+V76iUhOIw/g8KPdjh8t1og7VPv4StrqslcqazW
         SZj5zE/N+1jzmVtqAz68epmDZDa7y0P8mSHK99mGmMIBz7aZfBqCv2D+VJR/TL77t/MZ
         VNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vdTD+z1BV7ER/sJNdW9O6v4cJXxLTFSb7KPymHiyT9M=;
        fh=nK4o+E/nKAvNbzKwQovufHGBef//cfTPEviVumPIXzA=;
        b=T9GeRFEGjN9vF7MfTEbkz4bKx1orZCW/2qq1q42Asvkkgu9RoKxX9NnchwbS+RDBvy
         fwaFWY0xbHUBxYNNLYyi5vuY3aflalWJGDFLdYnjoh/xSz4LEL18bsCFbFe1GkybBwKF
         +/h6+Yi2/qoPjEsgSdcmjltwkr7/3fX7mhNZL5fjXIt6qusoL084skx3OahIPpz/PjNN
         pmxlEdVJpy8Qo2oJdWaObLedwzDMA1G6ZCYNu02Cmd6kQU51Qm5/1i7KYZCTaftw0mFd
         VAwSe/xQm7QmV+yi1QdW4thoC6QtK5ptU0U2/5b39SvpESkroFbAnA5bOwqHJ8pgCTDL
         h6SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793132637; x=1793737437; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdTD+z1BV7ER/sJNdW9O6v4cJXxLTFSb7KPymHiyT9M=;
        b=U0p0PjzBB+jCmQqqMW2byGqsZ/ts28dWhCDLo6BwzYlsu/mNmyLWRlpqGSfoj1X20J
         wXV9jDW80GQ8vxj8URDDIIRbXEdnVg5Lv/Yo+HH7l1hnLP59tynA/rDYOmfJ1/nQYglP
         TEkIoHeftuTvOLrf00BtPl8G88Vj66WIoZEdS5XpUE0Hi22uhthElN9mMmmEz6K/L9NE
         Ym7eDcDJztAacPghdilOJitoiKLBBrr/YFESJkGhUa1LeQC46pFt4VwMba4Mi9qff55F
         PWcdJ3Eb0eXtIkH3ieSUf2/JmQk5bxIViVHpbCNhU5FEfplVrVcziIW2YruJteNs3TTO
         yXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132637; x=1793737437;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vdTD+z1BV7ER/sJNdW9O6v4cJXxLTFSb7KPymHiyT9M=;
        b=ki6hCQrUCklZskpYYkk7rb+DCpE7lOtndqgSitTXwMhaBMZpQYWLCwO1pFvvP7/SKD
         i/+szFUQDc9alpgRgtDfUIa6Gn2hxyPsLAT4Ke4H5NM68QaoKQgae5nIkoBChP8QQ03y
         qltGvJ5DOEdDCm9A6NDHNXdxpxgSdICQwqDiVNVA9goSZ7xONqqKHNaFd9yxjpx7oW7C
         jkaYCck0SJfDv1M0r57Ysb8/RWE+YQXnAZ+/coJJOFWAesUSrtiaTxlur7iq7VGE+EX2
         SHK3k6iJoaJ3hgN69R4dNlcPv1agbQBktSukAXZFRusZjxSc+V2pk9xJhQqBWH2pLq+S
         7HLA==
X-Gm-Message-State: AFq9FYJe9/VG84+SzhPrTwg1BcrMJXG9ZuWf4LXIa2f4DHV0XzXbfapl
	RkuunVyY2Uz/IRS2Z8dguSl4ue57mGrYDjz+eV7bE/Ij4l8N8dH5EWdKFwK7PeXfUZWannaDQlk
	9Cj7chI3cdrTZkfJALO6gaU8A/eLYs9o=
X-Gm-Gg: AYBFou30ec59yv/GYnxJFlM1Xntcy45ozZSjEkeGuyMGkiDVzjRK33b2cMtfUeRENBV
	jkY0tWr/GNOOBvfzxULPH/4YlJdgXate2EyLTAACK+qvz7qlJEJDx9Q/vvpNUawNegwYDM3lz6G
	vkRfgmonVGH1Zp0tHOWWKYgy92IWbcTR7NDa6KOrpdlfGembT9W5mGkIOJGnoxauGxSNi3jnZ8J
	kI+9GcBNnP3hpfGw2oQZ1JZy4Bq87veNuApi+BCtBg2hhCCG4v6jzUzkL7sAfmViRoElstA0AFm
	T8Z7b3NZsaCGViHT4mLkXVibwUjRsi3Qe6UBARhcpurL53UeAIXWFmUg7ts6HdIeZNFqWWYDYvi
	DvnSItNWCNS6D/2LtE69Iq4OEyNfP1/o3n4onmKFB7TaGicr/tNS2pGUjQreV+gpu27H2hVg55z
	CDbsntu6wJZkUgohnVHE44rfLkq8ouMQL6mnjAUsWyDaTuW+kpc04uvDVZnIm7xkEKS6t2wPKte
	U902MbEQYw8dGA1
X-Received: by 2002:a05:600c:5253:b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4a9676d427amr855535e9.33.1793132636567; Tue, 27 Oct 2026
 13:23:56 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-27-alexei.starovoitov@gmail.com> <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
 <DMF694XH2TJO.P59A31VE6GWP@gmail.com> <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
 <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com>
In-Reply-To: <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 27 Oct 2026 21:23:18 +0100
X-Gm-Features: AclHuK-aT_qLQmguHlZlEyu3XYeaCBnaMElmYR_-F6ZDAnaYOAhB7wXip_7jqLM
Message-ID: <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct 2026 at 19:45, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 26, 2026 at 5:18 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > Overall, I think it is less clear to me (or anyone looking at patches)
> > as to why you did things this way.
>
> point taken.
>
> I was wrong in my previous email. An iterator over kernel objects
> stays in the r10 stack, and it works today.
>
> > Are there real patterns that existing stack tracking simply cannot
> > salvage?
>
> Yes.
>
> Pattern 1: one insn, two kinds of memory
>
>   sum(&local_array)     r1 = fp-64    --+
>                                         +-->  r2 = *(u64 *)(r1 + 0)
>   sum(&vec)             r1 = arena    --+
>                                               one insn, one JIT form
>
> We discussed an idea to let llvm clone such function.
> I tried it, and it didn't work.
> Short summary:
>
>   case                               why a copy does not help
>   ---------------------------------  ------------------------------------
>   the pointer comes from memory      no kind for the compiler, a scalar
>                                      for the verifier
>   an indirect call: &dyn Trait, fmt  one function for the two kinds
>   if c { &local } else { &*boxed }   one pointer, two kinds, one function
>   n pointer arguments                up to 2^n copies
>
> and real case in <&PanicInfo as Display>::fmt().

There are other ways to address this, like ensuring r1 holds fully
formed pointer pointing into arena at the point of dereference. I
don't think we sufficiently explored alternatives to this problem,
which is much broader than just stack and arena mismatch, e.g. ringbuf
memory buffer and arena memory buffer as same argument to the same
function has similar problem. The other approach would be testing the
value and deciding the form of access based on that. There must be
some way to distinguish arena ptr from other kernel ptrs at runtime.

>
> Pattern 2: the address of a local goes to memory, a load gives a scalar
>
> That's typical rust heap.
>

So storing a stack pointer in the heap and then reloading and dereferencing it?
Do you have real examples like you showed for other cases?

Normal Rust code probably doesn't even allow that due to lifetime
issues, a Box<T> outlives the stack, but perhaps I'm missing some case
you hit.

We can have more complex cases, like an object going into the arena
stack but storing a kernel pointer into it, that the compiler
heuristics miss. That is the other direction that will not be covered.

> Pattern 3: LLVM removes a bounds check, here in core::fmt::num
>
>   loop { remain /= 10000; offset -= 4; buf[offset] = ...; }
>
> and 'buf' is on stack.
> run-time clamp won't help, since real tracked spill/fills are in r10.
>

Well, since you're changing the compiler, we can always inject clamps
on the index.
The backend will know the size of the `buf` stack alloca, and can
clamp the offset into the right range.
Many assumptions have changed since we no longer worry about not
having to change LLVM.

> Pattern 4: fp in an argument
>
> ...
>

This is same as pattern 1, unless I'm mistaken.

> So an address-taken local must be where the heap is... in arena.
>
> [...]
>
> > It might require teaching the compiler not to move certain types on
> > the stack to r12 relative accesses, but it just feels ugly.
>
> it might feel fragile, but it worked for huge corpus of rust crates:
> https://github.com/llvm/llvm-project/pull/235577
>
> Your dsq iterator exapmle is 'alloca [48 x i8]' in the IR, so it works
> (I replied too soon yesteday).
>
> llvm selects the stack by use:
>
>   rule 1   r10   The function that owns the local passes its address to
>                  a helper or a kfunc: iterator, irq flag, dynptr, map key.
>   rule 2   r10   The prog stores a kernel pointer in it and loads it again.
>                  Also a local that holds the address of such a local.
>   else     r12
>
> > For certain things, like open coded iterators on kernel collections,
> > there is no other choice.
>
> Of the 16 rust sched that I hacked 4 walk dsq and 13 call
> bpf_local_irq_save(). In testing they loaded and *run*.
>
> But I agree that passing them around is fragile.
> The hope is for typed arena to save the day.
> Then rule 2 will go away.
>

I don't think typed arena will help here. It is just a slab of similar
types, it does not solve any of the problems we're discussing, esp.
with the stack. If you're assuming it will help here, and that it may
be necessary or useful for some part of this proposal, then there is a
misunderstanding of the problem it is supposed to solve. It will only
work for Box<T>.

(Unless you have some enhancement in mind you haven't described yet).

The other concern I did not voice before was mixing C BPF objects with
Rust ones, e.g. for supplying the allocator. I don't know how such
mixing will work in practice with all this.

> [...]
