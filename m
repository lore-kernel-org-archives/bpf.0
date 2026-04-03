Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6D242D6C
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229058; cv=pass; b=kEEnqqGBjM1Wjq5mWnGvd3d7C79dhLEaaEmS38ZcW2rfapOzycdyPKMo19L59hridKEse7NQb/VC5jHce8s8/awa4YTc5N/7VJfuwOZZhGbpTY818aMd7Hm6E0bxfw0Kv80+5zPHpHNKtctVWvYwXMjNON5t1TSjVG7wFgHltpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229058; c=relaxed/simple;
	bh=FmFx9y9vOMooi+jiHRnqmnmuzGF9mxhfB80WeaMtTvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1iLaZGJeXRp4QN/UURtkWVlrLc2sHHZO002vOdQLJnDFpHGjboTIU/6vV40Of35dPBZZTYsHJp7gnfXKL3X+9Z94DYlq4ZafPyhx6EMM0elJiWRZ5xJrgOwtOPgxu2cRXq364r4692Eq7a6s/hZDCyVlKnyTXtj9pVpvT5nOxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwQ9ptCB; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwQ9ptCB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso1637495e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 08:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775229055; cv=none;
        d=google.com; s=arc-20240605;
        b=fU5czlHnOndk896qW1pfQx7SuXNWg+iTOdeTd3YhcdoiVcBRswgZbobcciuHiSgDkw
         C+zCwnlRH04Mq/i4iGsjPr7+rNJaSzwAWpEamD4ZEsJXduH/QuzHreYolcvxfXB9FjNO
         8qfzNvplEBkWWcV2A2sMtuZt9BRTC7yxdvfpxQFjdzv2YtjcYFQd7DL0VK9+qcBjJTAe
         rhUZ8Rl6Fv0GzdCCMNimwCGYTkrCmiJ4E7Qbc+FobcAyzMwNEs78Z5yItO/5mgRCiLNM
         twtPio5zkQ5e0DrE5OGEq6RcjuXEXunwZcOQPO8oZtmN2Zwhr9X+HOjNQGgidLgdHWAN
         Wpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Py7YmSLpaWlnQNo3OpJWbbnz/Dcac8KFBZ1MrKVpBU=;
        fh=nK1sKfOAOlKgx9LOXsQrEFK5C3aJSpECzQWLF+tENHY=;
        b=DqvyQ5PTB4bR2rw2wdA+p2MR17Y7T1sKN9boK1AWxCRqu7mt+8YsClREvn1s1hkRfB
         iRVvNmeFVfQKGgyFDq9PPNV5qcRKtJB66+HDWHe3K9D6rxD9B/YHWLBw9s0bQPq75dJ6
         D8W08cxXEXgmF1CkoxbEyCSjSLkbEPcgFu66CvtxyEE0Pz8yL6otBHWiiiMciKtkhggB
         7A3dgboWsl0riHfsl8/FohlW+RUHd4vdX5rwZFSfNONskUYHb0WUQfCQcN9muFeSPHGR
         4Jx3fBbC4mlS4MIEI9MUY8QcZqGYyAScUokNpbA0nkfwFnrB6eBFEYzYw7wm2x29gyGa
         I8tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775229055; x=1775833855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Py7YmSLpaWlnQNo3OpJWbbnz/Dcac8KFBZ1MrKVpBU=;
        b=NwQ9ptCBgFYjQ4zh6IUzAAQUPPwZx5Jg+C+dRNPca8wJeXAI7g6fsycCbyUattfQj8
         9y2rIVIbOn1cqLDJ6+GSpqHALjCTrResGbB3goJofMZbrGvR5E/LJCxgndqqpV0Dbh1C
         Q0af58uFraSFIoBvH+LdetkNUY0mdv9OqsQcgRdFI8YrLYnLcU091O5xVZCr8Z8mU0k5
         TI1pSfgLKQxMv1aGLMcpEdvOvZWKVqZR1i2q8vid9g2KpSJ6vnMrF2cZnRu8kB7i20qQ
         KNHadBqvLZk+ia6uy3zddHd2Esu68dj+roeWszIcGV3e4gTm7Csl14zrFl7Gala5gJLg
         FwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229055; x=1775833855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Py7YmSLpaWlnQNo3OpJWbbnz/Dcac8KFBZ1MrKVpBU=;
        b=sHAj7KviAjkY0iyt2Ro4dyNC3vm8Qq/u9joPLb+bNXzwFVYtvNWkF30KjgqynRdQl7
         0aeqKStNXAKgaOP4y9HYKlhlPzsT8wd6FoCfKntNIor/ZTrUMU06Ro8wmjI2h2R0qyBV
         qiuA7xW5I/4Z6uuozASjEZpDkJ9JQnzqLcbCfRrVYl/+RjYzXRkswAuDW/Xax2qE8q1Z
         F4zBhMjQWyc9jBlr3nf0008ovl8DSgWexKLSalaTzIO4kpW4MGPrPft0hGyPAAP+9dvz
         jjQNwg31wQDO0cnYwNYEwWbHvvkklvLrC8eztoYwGFIAfVOiM6BCs/9T5/eNGXxxmJiC
         Y2+Q==
X-Gm-Message-State: AOJu0YxB1MWy7K6RXkA1bC9Rfc1kI0NFSgS6IdDCw3PVpWiTUT3+Z8hh
	X3sZ4DS+Vm19UIlVN3M7qooV5VbqWYpL55bnTUaMYfnorNg2yJVwtVfPKYrRbBeEmqB5l1PC/87
	Wwo3QQgqtbwasLjrW74n0VuUpWhepXVM=
X-Gm-Gg: ATEYQzywXDIW9+juvIUrg0osH8r4osvdmwcoGFRPB7K704a2qMKR/Lb5y2XWtSvyrYP
	xTJ9rp1YlZ630QXDEW9BeJmadxMpqGTPYEAszv1tjL/T7bjuWip8rs0+W1nM3lX5bx/0Z/W8KS2
	HPNFiD/Y0buWPfcZou82OQqBKQcfw5Q6YQp58K62Ksi9ehEm9boSAXl5u9bKABn1gf9HuQmRRXz
	8SfcEFmk0RIZTq6W3YM+NysdUuRq2Oafw7C2HRCNieSO0/rUiBr14C+W+Gk9kVSXy9KSgum/6C4
	znnfbu/FP0R0hBBobZ/K99wcCMrqwGr0m0UXAJpFnCP0cfuQWvzJFnMEc+x4WiK0KV/C+4kfyKQ
	Pp9wPlxa6bJa6ltWnArj/9MhmRw==
X-Received: by 2002:a05:600c:818d:b0:487:13d:4e77 with SMTP id
 5b1f17b1804b1-488997df8e7mr53145335e9.27.1775229055166; Fri, 03 Apr 2026
 08:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
 <20260402184647.988132-2-a.s.protopopov@gmail.com> <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
 <ac7XSg6AsJq99WvT@mail.gmail.com> <CAADnVQJ_e2fyODknJyMPRw4Z7ztu3-0ZrVM8jXpoO1g7bH52jA@mail.gmail.com>
 <ac9yriPJX9RXa5tr@mail.gmail.com>
In-Reply-To: <ac9yriPJX9RXa5tr@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 08:10:43 -0700
X-Gm-Features: AQROBzAoZlfanP8CKTJZ2o8zTPCCYykiOZ0BnxsVpK7-am0RUE-Q_u5oiXMJFew
Message-ID: <CAADnVQK0mEAdZ3PEHv=wvbPUrEA7EPmU7w928JOd=143vt+kJA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiyong Yang <ksur673@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 12:47=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 26/04/02 02:32PM, Alexei Starovoitov wrote:
> > On Thu, Apr 2, 2026 at 1:44=E2=80=AFPM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > On 26/04/02 12:00PM, Alexei Starovoitov wrote:
> > > > On Thu, Apr 2, 2026 at 11:38=E2=80=AFAM Anton Protopopov
> > > > <a.s.protopopov@gmail.com> wrote:
> > > > >
> > > > > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > > > > specify an offset inside the load instruction. This is a bug,
> > > > > because while the verifier ignores the field, JITs are not.
> > > > > So, patch the verifier to not ignore this field.
> > > >
> > > > This is too terse to understand.
> > > > In 2nd patch you're saying:
> > > >
> > > >    r1 =3D &map + offset1
> > > >    r1 +=3D offset2
> > > >    r1 =3D *(r1 + offset3)
> > > >    gotox r1
> > > >
> > > > Here offset3 is, normally, equal to zero; but this is not guarantee=
d.
> > > >
> > > > What is this 'offset3'? Where did it come from?
> > >
> > > The offset3 is the .off field of the BPF_LDX_MEM instruction.
> > > The BPF assembler will correctly work with non-zero offsets:
> > >
> > >     r1 =3D &map;
> > >     r1 =3D *(r1 + offset)
> > >
> > > > What do you mean JIT handles it?
> > >
> > > JIT will issue a memory load with this offset,
> > > but verifier will ignore it (before this patch).
> > >
> > > > can llvm ever generate such code?
> > > > if not, reject it early ?
> > >
> > > LLVM can generate code with non-zero offset in BPF_LDX_MEM,
> > > say, if one jumps to a structure field, like in `goto *p->j`
> >
> > sorry, I still don't get it. What kind of syntax is that?
> > Could you share the godbolt link where llvm actually generates
> > such code? If the verifier will reject it anyway it's fine.
> > I just want to make sure we're fixing real problem.
>
> I am not aware of any real-life code, only can construct
> some artificial examples:
>
>         SEC("syscall")
>         int test(unsigned int n)
>         {
>                 struct {
>                         int i;
>                         void *j[3];
>                 } x =3D {
>                         .i =3D n,
>                         .j =3D { &&l1, &&l2, &&l3 },
>                 };
>
>                 if (n < 3)
>                         goto *x.j[n];
>
>                 return 0;
>         l1:
>                 return 1;
>         l2:
>                 return 3;
>         l3:
>                 return 5;
>         }
>
> It will compile into
>
>         <test>:
>         ;               .j =3D { &&l1, &&l2, &&l3 },
>              160:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r=
2 =3D 0x0 ll
>                         0000000000000500:  R_BPF_64_64  BPF.JT.4.0
>              162:       79 23 10 00 00 00 00 00 r3 =3D *(u64 *)(r2 + 0x10=
)
>                                                                    ^ offe=
t !=3D 0
>              163:       7b 3a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =3D r=
3
>              164:       79 23 08 00 00 00 00 00 r3 =3D *(u64 *)(r2 + 0x8)
>              165:       7b 3a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =3D =
r3

Great, but where is an actual gotox that is using that r3?
Looks like it's spilled into stack at 163 ?
Does it pass the verifier?
Would be great to add it as C selftest.
