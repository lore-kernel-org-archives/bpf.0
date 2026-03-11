Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418843CC9F5
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220957; cv=pass; b=Yksl+aPPSZjAK0sHZdKHKkH9rYwVIcaP0ycJEhukQZ4cX1sTjhG/n+jTRGuzJ4IMrKSA+VQa2ERvf6oim0eeEykFYs3bCYrSnhpf4+R8RY/w95hPjC/AA6UWkU+OIBGd4tvgat8q2wcUYBW/1BPiDoMjyIzTuiGEGsoQi2Yg7Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220957; c=relaxed/simple;
	bh=YACcX35xOsZaWzEwi+YLtodbEl58LHKv9PHt6kgvIE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAHQ4J2b/e3AEnRvFzi2aS7S0LNxzzOxwnNG6alvWkXSLyjs0JJw1NglArb4w0TSQM8kJLCMa0JyFiDTuroHoZPoCp/R62PWOHZMqngcgqsXDqFc4fzL6NrcRvoEr1TBozRtPgfCpy9D7MjQaiCIg88DvzClvbZmfPL2Pt/nM9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ickx9bIH; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ickx9bIH"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso5710654f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 02:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773220952; cv=none;
        d=google.com; s=arc-20240605;
        b=INRntXj3//lAkYiSgsqDMj254lutBpdwy12ZwMARYrlof9i7PT9mFOK7EbglRE8z85
         YnFhHwjj3w+dPFwx7miX4O7DyO4WEyoPifCb+yjV2dSK4N7UCVF6Ek3MXYZoCaQ34olO
         nehSMimLZYXB5qwuiVjgD8B30WndiaVJCM4Ca9C4ErQButlhaaFoQ2mceHw/haMU/kRh
         YZq/0th0CZCGO3Eg2R2wZSpGptmMRR8jdi7hnfzTYqhZBvJGwwTdS2bCzLr1roSMLebU
         TU/NFIf6cfEmF8ZSouHo7JXzPPWtVE5QI+QRtUdAHgJUWoPW4KC8F6zO2O93sImArwF9
         aR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lFgMihWsoMtZghWDDXPtR/BAjR1Y+4atLFgxslVUViE=;
        fh=L+8XuW71TYI3ZY+qsVmkRvnvM1nv//gtmxrrIjBdQbE=;
        b=A4cFkc6A+42TouzU2Gph/W/1IjtX7a04+U6kcl07LfbM7cn5z3q5nKgO9kRkR65Mk1
         DQ8xoO1Kvagk7nxM27oPCO3wRkz2N2rjtAf5enXNS3ftZyTH9jEmHLFgb9En0OZUohRJ
         BVb6RFUtvaW/8AeVtq5av2iHoQuXwo9nfiPaKVHtyrB4RuA2sFzldKdE+6yOjn25ZqyU
         XUhES1jxKqQGfYNozmhYohpFPGeqh39EjUMAZ2pWQuYHSbrBZzqjbMISZk+i6sXrQdtA
         g1aXxC3Sk7FQxUnkZJXFxZluR4SUuJdBbBpo0NH4XcvNWtsYItCJ9vHXnDNXakxGUjF8
         LUsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773220952; x=1773825752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lFgMihWsoMtZghWDDXPtR/BAjR1Y+4atLFgxslVUViE=;
        b=ickx9bIHtBU+sEi1aRGjZqo71gBfwNnWragbJ5Y8eH6yQJeAOCXmN2Cs0w4diTS98P
         fAHrLuQUe90UVcLlBnQ7IckbzDv9YyEf/SsjmvzrA4l+teUaYAT5UV/+0oqPhMP+sFTe
         Bx3o8QJABxpQrLpMey/y0vFDienmPw6fZSFBf/8AiVUV3YbWRc7K1ZcaNtJTQQnXsmIJ
         Fpsg0G2Hs0P8gzaZis4iEpH1EBHNUWzoAIpTm1HlkLUFWdPTJekar4JDGd6F8beE2d5N
         CwC2T9QKkwm8Ogr8r6qMCmzFcXwh9jPLR+K41Pg40VIbP64xQiFc92GWxhPIpA8XjUF3
         54FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220952; x=1773825752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFgMihWsoMtZghWDDXPtR/BAjR1Y+4atLFgxslVUViE=;
        b=iG3+nd/9AnmpZm/1FHnN5pIuUpxQ6TPLiO7dNSYEV8kkIxMnyRx/SrIz2TvpVthDhD
         NMO6f7/W+xkiwEiZJ79tQfVPLcYfQ3Mly8Mn8l3SWA5Wh08LGyzS95u5xwy2tjqQm4cC
         9o4EBuJqh3VDrClEco5uONuS2ZXa0C8ZSN3ah+K/UFsSKfT4weD0jHcyKmoblwIK/tHQ
         pSjM+6JLcOfCF1bU4IWdw2ljRlOfvvoj8Sg/0X7W2d/bh8UJSwpu0FulcuqHY5vOAYnu
         HRMErzeJAZXXjYHrE5v6waUFSJv10rcFVxNe8yNpe81tF0Y9ZCG+IT571bS4UCnD6fd3
         0eog==
X-Forwarded-Encrypted: i=1; AJvYcCUEgiz0QMAzSUQq8SVIrigLwISD4/P3vVUPvzex832w/WYx9ZiRK4DUZ5RtsKu35iLcNqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VnZiG3zo54hLbfNOMm6H/ZNY5rrIIV/az9mpANquelwIID0D
	TFmmtTqz0P5prIeISFDt/8AB4eJRuQHuzSCezH+HG+gbnNHyqARV/OekDjDnGh1ADCCbGDzQhG+
	lA8+OSwrovzB6LiXlz4R4nTbilIBsi7U=
X-Gm-Gg: ATEYQzx3mlo0aDY5Lm6p/Ou0GL24u+kXHRqMNeb828pn2AWEcTFDZpGn6HwsOMpHs/I
	Ujszoy328PvSYHOW5+xSnakaWg4Yo7Y85zNn+9b2j2sUGJ8slK+hSTTKOdDpOf7Id1AS/zEordS
	Dqqhtwysrd7A3T4LWyqlHgeixrRhJ1+L2iRuHiU7tkcqYcTILm5ed1/ZK+l80g8Fm2BSmG1MooX
	i+zoZv577x6l0ay9MF1LS4MAQK1T/+QlM5L/bVIe87Oi0Z/kgliwgyeMNV0Sx3rCDrzRZ68zHqM
	vPRE1+N6RW9M8gV8vkOM5CSPP8HJZoonBizamZqOY7NFCEng74wZ60pio1FS
X-Received: by 2002:a5d:5e01:0:b0:439:bcc2:bf0a with SMTP id
 ffacd0b85a97d-439f81e7e25mr3490492f8f.23.1773220951904; Wed, 11 Mar 2026
 02:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303150639.85007-4-leon.hwang@linux.dev> <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
 <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com> <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev>
In-Reply-To: <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 10:21:53 +0100
X-Gm-Features: AaiRm50nAQdzlpHM51HW1PyT3VT1H1H64hcFybhjy9jwHkvvigOgK5QbW0gQV78
Message-ID: <CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, yangfeng@kylinos.cn, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 07:08, Leon Hwang <leon.hwang@linux.dev> wrote:
>
> On 11/3/26 01:23, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 3 Mar 2026 at 17:04, <bot+bpf-ci@kernel.org> wrote:
> >>
> >>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >>> --- a/kernel/bpf/core.c
> >>> +++ b/kernel/bpf/core.c
> >>
> >> [ ... ]
> >>
> >>> +     switch (match) {
> >>> +     case BPF_MAP_OWNER_MATCH_FOR_INIT:
> >>> +             if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
> >>> +                     return false;
> >>> +             break;
> >>> +
> >>> +     case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> >>> +             if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
> >>> +                     return false;
> >>> +             break;
> >>> +     }
> >>
> >> In the v1 review, Alexei Starovoitov asked for strict conformance
> >> both ways rather than one-directional validation:
> >>
> >>     "Don't be fancy. Require strict conformance both ways
> >>     in *all* patches."
> >>
> >> https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com/
> >>
> >> The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
> >> matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_write_ctx
> >> but allowing the reverse.  Was this an intentional design choice, and
> >> if so, should the changelog note the disagreement?
> >>
> >
> > Let's follow the approach Alexei outlined, while the changes look ok
> > to me, let's remove the one way check and just do
> > owner->kprobe_write_ctx != aux->kprobe_write_ctx, same for the other
> > two checks. With this we can also get rid of this INIT vs UPDATE
> > distinction.
> >
> > Other than that I think patches are good, please also test both
> > directions in the selftest in next respin.
> >
>
> Hi Kumar,
>
> Thanks for your review.
>
> I agreed that both-ways check could simplify the code. But, the UX could
> not be great.
>
> Let me explain it with an example.
>
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>
> SEC("?kprobe")
> int prog_a(struct pt_regs *regs)
> {
>         regs->ax = 0;
>         bpf_tail_call_static(regs, &jmp_table, 0);
>         return 0;
> }
>
> SEC("?kprobe")
> int prog_b(struct pt_regs *regs)
> {
>         return 0;
> }
>
> prog_a is kprobe_write_ctx.
> prog_b is !kprobe_write_ctx. And, it will be added to jmp_table.
>
> With both-ways check, prog_b is required to modify regs. I think it's
> too restrictive for users to use prog_b as tail callee.
>
> With one-way-check of this patch, prog_b can be used as tail callee to
> keep regs as-is.
>
> This was what I was concerned about, and the reason why I did not follow
> Alexei's approach.

I agree but the main question is whether such a case is realistic, are
we going to have write_ctx programs tail calling this way?
Tail calls are already pretty rare, thinking more about it extension
programs are probably also broken wrt checks in this set.
bpf_check_attach_target is doing none of these things for
prog_extension = true. Nobody reported a problem, so I doubt anyone is
hitting this.
It probably also needs to be fixed.
Since you noticed it, we should close the gap conservatively for now,
and wait for a real use case to pop up before enabling this one-way.

>
> Thanks,
> Leon
>
