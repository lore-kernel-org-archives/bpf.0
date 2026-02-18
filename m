Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49DCA4E
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771373928; cv=pass; b=RLkAQhLbEIHjCjK20JtpkgWGBTIi6oEd5EaLynd8eOSm2d9ezg4vE4p/ikWOkmJB5D2kZ/2fnDoC9fzp10ap728e36n4n11nukoj+kHVO0/pZgfbOor2NmtDunYlJSqLw43n5JwnOyDWy19ub7fAjGFsYzPMlzpJKIFTNPL3bL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771373928; c=relaxed/simple;
	bh=8W16osE5TcN7pkY9ru61rGXuhFCvOny70/JAu8AZeL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsizlQka0WR9ff9kPlG9aaQ2ScSoIS/B4D8oE5REkTpkI8zQtbJx2An2sGGDZBkdUkP/tJc2g44obLsbBfswyM4hUAy9ZIVvcnJr7iJfyLBKIQ5d3BUk9JukzTxEQmVmpbhuRjdEODSgBBeLeGVtRiosfK5Fq8b6mBKUPv67ziw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQO6F9Td; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQO6F9Td"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43770c94dfaso5535479f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 16:18:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771373926; cv=none;
        d=google.com; s=arc-20240605;
        b=eDGpBhK4Bg6TVEbQQq8Y5ARoYOsStPuAGA+wXx3JffkAjiNbYE11yiTF15ebtdk+2+
         EfMTIWLZ09h46a/ws/l8Tv/L1nMzetiwfkC2PoOanAXGBBg+NEINEFH2Eydpab2EnYpB
         F7Oh7Qr6KsIHCkg99REn6/uDfJOvPuCw7zkYH6LS1eVbb0quz2UKkhYKI9rlebjM+ROY
         r9o1BwcJzvxCMhd+ogj12eO9oNtOM8kD5NEOZAcp+LYpyf+YRO9PFziuYCoW4mgXHHkj
         ESHKAXBZZKo3jUsmDcnRFcG8P7NUHtN/5J046tYWeFMiveGiYdI1LELlOexevP733/wA
         /RQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2u1W6fScagLdBh8EUbr+74daZtgBQR/ZePB+67RGA0=;
        fh=nBMTQULTPwLZopWSdlGIvNUvwGtaE9y82/FTHOk/a1Q=;
        b=V8Y0AeklnQ79KkYQGPiQN3DeGHI98mMnWKfWWRS1bb8uekUQFVD/R2dbm82dpEK3VV
         ZgidtY6Lg1BEHnPbFgTBgKzhoJbdaRhL+KRGnQNFjPApl+jwcz98bRtqUVt0sqQhDLTq
         R7F+axrviPfrWevSe2ZjU3TRhAEYHmv2Irwv/CTaIzEvznEMjMwe8WA17tkITV1smvHj
         wKhLsePZ4U4uL/EbKdHEtdRzIudLeIEUkKFq6yB2Epvwn5DnDajcUJ1lw+hs2efxF27b
         PTLyNitTC+vCdkTcIb3ifym2UxL3EWAa6U60LQkoq1u/CKZHaNuZzHnzWMbxcmMz+mXz
         3LKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771373926; x=1771978726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2u1W6fScagLdBh8EUbr+74daZtgBQR/ZePB+67RGA0=;
        b=eQO6F9Td6Jqn4GW/x5n+66Mxv/oiOuNjMOGXGyPbuqHCGxf+Z9jMoXO2XPuk3MjOBR
         Un5Pe8NJ5P0MQ5duAmoufingptzXqwgMwcOiQDgWBSu/swbePP5FRuOh5AzTeIBOz8fK
         qgsX8g4by4mkCh8tpfLjzjDOEXLFiW9Ygcx/GOwhaM/V2OYQIk0Hq0GSBn5BIl5NkHY+
         QnFHkH2k2VEGPbuWe1BM4G/QMHDNT40swVL3rLjQLP1uXc7LFZkBBaCns6MHlt6byhcH
         eA9SNsCmhn3BUL1iJE46KfAfhhYPYXpk2SK9O+2XtJIPbYojpc00lYe8914Vg65RbbBb
         27Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771373926; x=1771978726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2u1W6fScagLdBh8EUbr+74daZtgBQR/ZePB+67RGA0=;
        b=Ez1ufHx+hFEhqZxfJME5nKxnWBJjCal6YXzBk6nHFTa3qk8nHrYBH4GLSa9iX5U5J6
         iih1uP+T55UEHl/XZkSjCH1aFYg5rBQwC6vbiI+/D1Xp3wTENI7/Gb7J1ISGQldLh1sX
         HuKQab3/UmtEHwHm8fPjORpGQgF39GdSjF4URU0EFARfuC3sBEm2rvqaoIZmCZJolfOt
         BLrTu3/NKifg5+bIv/S1tZEHF+Z6V0IyyWMO3xiq3D70hkAJSlHva9RURYya9zDf9KZ7
         81SfOpBkXsokoJqL/v14EQOAb1keSqZZBlGWJqN4MD/kYNMwtg+oWDaSwiAFlCTOGLAQ
         0BNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQYRSqm40/LCWjlvbooXKlKoRjE4Vy0uVgS2oJD9iv2gqjsL7P4vwXKO/YIvaAroHxGb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UzT1x1NAjenFsU4TLm8JmmKu22ULVifEPNHQmdXBf3ad3UDy
	k7lQ/iwTurhSr082+cUnITRX+fY1mZeGOgOV8l7SIjJ9Hadjjf93s17pcOpdRwA2TVLM/uvi0Q7
	81SfjJJq8E6VtoQdcuKdpu5gAOUalo0k=
X-Gm-Gg: AZuq6aKjq4/mpE/xt1D/fjIvF+2HzXHgcohU00ppKuKcq5GZv+V3dxBeYjsAdsC6mXh
	DIS9EflJ8WCoHFwkr3XgyaO1mE5T+4FepN/FnCJXnAL6c5oW+6XCXi/6kcTJsjzyDMyzEDUCVwW
	mctj2JXB+fowWertF9A4SDo/7SbFmT8FNwUg+eqRiEcio2FzyRydHu6nkPwJhsasDUBfsqj9N7W
	kFfbin5DNTHdWnJbBI3EDSIxNEZ/cCmaMFnSA4noH34/wrI6JAYlc90FWYTqlR2x5Pj42Pb82WF
	WHXJYlz9QYex+9lkiOMj59TKLR6xBIuKyxYo7qwOr+wAgnwWS0ALovYuC+F1e2vLq5OnilpqCyL
	NavcCJyd8eJPKE+oF+R1CLCR0d80nplCGFewN
X-Received: by 2002:a05:6000:2003:b0:437:6dfe:1b89 with SMTP id
 ffacd0b85a97d-43958e58522mr97161f8f.61.1771373925653; Tue, 17 Feb 2026
 16:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217160813.100855-1-iii@linux.ibm.com> <your-ad-here.call-01771350933-ext-9929@work.hours>
 <CAADnVQ+TB09AU3VTmjZ97xNFPG=3eOpoHut-dsnPSsJRLPPStg@mail.gmail.com> <b8b35dd7-fd17-4145-b81d-b58b466d9174@linux.ibm.com>
In-Reply-To: <b8b35dd7-fd17-4145-b81d-b58b466d9174@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Feb 2026 16:18:34 -0800
X-Gm-Features: AaiRm50XfziVi5ECQ_ZHLi5tkbIjGtRBd5b--60cR_D1CUbYZnaX2FfjPvjOQwY
Message-ID: <CAADnVQKSMCohZy_HZwzNpFfTSnVu7rfxgmHEDgT9s28XxcDS5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf/s390: Implement get_preempt_count()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 3:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
>
> On 2/17/26 20:32, Alexei Starovoitov wrote:
> > On Tue, Feb 17, 2026 at 9:55=E2=80=AFAM Vasily Gorbik <gor@linux.ibm.co=
m> wrote:
> >> On Tue, Feb 17, 2026 at 05:05:07PM +0100, Ilya Leoshkevich wrote:
> >>> Hi,
> >>>
> >>> This series adds get_preempt_count() BPF implementation for s390.
> >>> On s390 preempt_count lives in lowcore: a per-cpu data structure
> >>> mapped at virtual address 0 or 0x70000 depending on the kernel
> >>> command line.
> >>>
> >>> Patch 1 adds a kfunc to obtain lowcore address.
> >>> Patch 2 is the implementation that delegates to it.
> >> Hi Ilya,
> >>
> >> do we really want to expose bpf_get_lowcore() (full lowcore) to BPF ju=
st
> >> to implement get_preempt_count()?
> > I think there are no other options. For this and other cases.
> > Like to inline bpf_get_smp_processor_id(), current_task, etc.
> >
> > arch/s390/kernel/bpf.c is a good place for such arch specific kfunc.
> >
> > I cannot really tell by looking at the implementation of get_lowcore(),
> > but can this kfunc be marked as KF_FASTCALL to further improve performa=
nce?
>
>
> I think so.
>
> KF_FASTCALL will require inlining in the JIT, right?

Not really. Just that the binary code has to conform to fastcall
semantics. Like in this case the get_lowcore() is always_inline and
its body is written in asm, so bpf_get_lowcore() kfunc
seems to fit the pattern. It's a leaf function and doesn't
scratch s390 cpu registers that are equivalent to bpf's r1-r5.
It only updates bpf's r0.

> Then bpf_get_preempt_count() might be a little bit better, because
> inlined bpf_get_lowcore() followed by preempt_count access will look
> like this:
>
>      LGFI %r2,0x70000

it doesn't have to be inlined. It can stay as a call to kfunc.

>      LY %r2,preempt_count(%r2)
>
> and inlined bpf_s390_get_preempt_count() will be one instruction shorter:
>
>      LY %r2,0x70000+preempt_count
>
> Do you think it is worth the while pursuing this?
>
> If yes, would it make sense to add an implementation delegating to
> preempt_count() to BPF common code and use it only for s390 for now?

Let's not over optimize.
bpf_get_lowcore() seems to be a more generic approach and
a bunch of s390 accessors can use it.
get_preempt_count() can call it from bpf prog as your patch did.
Then later s390 JIT can call into that kfunc when it inlines
bpf_get_current_task() helper.
I think you're saying s390 JIT can inline bpf_get_current_task()
more efficiently as 'LY %r2,0x70000+..' ?
And complicate the JIT with MFEATURE_LOWCORE detection, etc?

We're actually thinking of moving the other direction.
Use in-kernel arch specific disassembler to parse compiled kfunc-s
and inline them in JIT instead of emitting binary opcodes.
