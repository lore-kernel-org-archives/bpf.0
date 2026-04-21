Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8E3D091D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776323; cv=pass; b=niCkM0fw/v4YWfSb8dt0GiIV+s6p7Iz7WxE4M9aHWwDsYCcQSxbRcWVIZp9NopFi5doqX8HO/ZZaBux0GNm5PH2SOAhX8LD5ByzDORSePWnmWQEceODzlLXY+XmmQ8xwwvTqxvRYR6kTMpYtdzIGHk0RsoNk3eXR8HRHDzZ9/zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776323; c=relaxed/simple;
	bh=Ypq9vbVKeYDEyJgIYjEFrwetr6tzWasuBJFqaQCWKno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW+ozMFrdBw31KfVQrgarZNRvdG6wWJ/kSv9N+7hrQ/CTLktiKq5Fd0d4ks17fOO5AX2tVW8w6iB8IP1MCm/pHlbsHJOIo7Y0kbnRK/8GPYnCIqctQXN4L7Nx6yjhIuD3wMKjR1QZoEpN9nbmlKeopzAyAyHeL2BXv8o7isya9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCWCR2HC; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCWCR2HC"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a402dea4a5so4803609e87.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 05:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776776320; cv=none;
        d=google.com; s=arc-20240605;
        b=aDOSzHP1yZ9J2QD9k/1RYRI6CXuf8ozbKphs7cZfmX9g9FHV47U3rX/LMluOk6sZYI
         uHbwQmtice0nsQ16ekhP2QsAB+3adDEdgMTg2d9ZvwpQpSeV7hOlXwL2ASsEdrNpxhL+
         bhaClNEEqrrfvo2UR/x3o+sTKRTL2cEMhk/3OMIiXZcGNiwdyzsbWzS5mRokPH/e0QR8
         sxtd8n5Fdgw8OrnkeMWZvMuFjvoSkWnW7F6XyQIjHYgD01dHSavYyA3qhqSJpGzjzf0g
         GOnX054d/i/8FkxwP00T39mou3R2yDrqH4mDDDyxg9V82D+0Hb786zBRyXNjLjNwkwOL
         J6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4dFEtY8RcrtaZeXUnmogrtpVC/Og8GraCdRaNwWc6g=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=W8ZfnPRWSF9F0ww8Cbqt0fCtkggu6iRtC3+//nD/XAIggQqyBI+r4HBx0n2L09HRGx
         ITpIdyGB77/ZRiO6c+sYIXu/HTE5UWZlfF5HoKVMua2W9ZCcIE7+lcvd/uVDc/YGJYgZ
         keAXvzxYCG1ZZP5IRQVGNhgOPz/G7Edoa7X5/zOVscoSFuBV2DYGlJENKOfDEQfhPFZn
         2ALk3KEMkrwTDCgS5Row3S8YmBLmMkDLIyhR5tcZCNfaYcJf0QBAQeWwpxDEHJO+AGu9
         o9FTiUGjGZWHFbZ7ZFkO5j003mtQBPNag4v4CTKsf9nPdh/w7ziPvsOjbj52DiUs9j8R
         nyuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776776320; x=1777381120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4dFEtY8RcrtaZeXUnmogrtpVC/Og8GraCdRaNwWc6g=;
        b=kCWCR2HCdgwUyHNqzOw1WHNupx1zO5+pcDDzkTwUFYk+72DhBGPpuB8ZzqWeUicQAg
         EpRJ4Mno6qyL11wCkUlKpcl/3J8mXY4zUxjOnJ1HZaDmSoTprfFrmF2U8aw92PoBe6Nd
         MjbE1r847pMEg6WA5Xn//AqvaM4bUVGgHpaPIy0lOERVrRBGQuDhVqDEzM9gkKGoDnTk
         s58yK/4P7u0hlKaeOnlnDyyhMOHrzOXqbS3EUhAKby9hwoTHK877CGPjXAAhUYs50tRG
         6DkMYk04/exEw61R8C4+tYL6sUmydw3DGddm4waASImikyPxgFJ1uKqnbD+MX1p1v6dw
         hLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776320; x=1777381120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4dFEtY8RcrtaZeXUnmogrtpVC/Og8GraCdRaNwWc6g=;
        b=L/sffmHLwVHpowPRKMm/vjsiFHPSYc5a5QzO9cA29cnHW9pe9W+W8kJcezto9xKFo4
         7CDUd8qTt2lkWewWydpfvxHnOerqvnLleP/K+/DWOH+CaV2ArFwoxfjlhFDsIcf2FacC
         P426ewBNgG5ekQmuxVv0YQtJkkCMS6bB9XrKWUUo9QAP/rlMajaX6Xwz0tp5QvEhS6GW
         il2n7b/GGCrLz4ySJP02w+A+eDoINpaTuoM+CXOOVgO7U3CG7LB35P7wkR9bT+gGin/h
         +ZuVifLXoHTWJaDMnaIMwiqbQKGophhtBjTROPQissIJGFOvAay+jSsTfC7kJXASVWxk
         mlWg==
X-Gm-Message-State: AOJu0YwUb0//UGX2aWIeg2DINcnBJ7u/rL2MhvaXll4jZeVc0NUTNTaw
	DGnUiCdqMz0OdxhItkAS9I7K1bDSP37gp4q3hdyEJvHREbojA9Jf1zgjh4mcSNe41QJGCVCtMSQ
	Cy9gDNVhg7JnQROuWsYzXm4NdQ2j1Bd1wPbnb
X-Gm-Gg: AeBDieswhGnGk8FxYfAGXVgSYlqP+z3s+ClDsYa5johhrodoKa/Jofw3+BISsIjIuTY
	72r1xI9zRgdx5mln4It2yUmmXt3Iy3gw4qkZnYoXAH7imjFG+Ndef60SxR2DpjE5xa6DSrE5Psv
	s2FoB9K3CR30BojACfmUR8SAhlJxgjU75At2AOFBfgvzoVr3KhYWyI3SNMvPmDOxXMWib81xR0X
	HkMywtHUq6+481WeB0xJAlK8faZvBmBO2Obg6J4r5i/zG4be2oEKE/kSWcJZYm0/D6EEl3FV4JC
	NS5cKy63iJ6HwhscuQ==
X-Received: by 2002:a05:6512:239d:b0:5a4:505:f62f with SMTP id
 2adb3069b0e04-5a4172ca7fbmr5337248e87.6.1776776319287; Tue, 21 Apr 2026
 05:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-6-kerneljasonxing@gmail.com> <20260421094025.684A0C2BCB0@smtp.kernel.org>
In-Reply-To: <20260421094025.684A0C2BCB0@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 20:58:01 +0800
X-Gm-Features: AQROBzDLRai2NsErGwP6JqUZsExStq91zppFmZENRMO6-KgFjDCR30CiO_K2g9M
Message-ID: <CAL+tcoBDnrThvfP+4JdATXHs1Ti351jGCnzb9x69QEXXr=HbyQ@mail.gmail.com>
Subject: Re: [PATCH net v2 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in `xsk_=
skb_metadata` allows unprivileged users to bypass bounds checks and cause o=
ut-of-bounds memory accesses.
> - [High] Software checksumming calculation fails completely because `skb_=
checksum_help()` is invoked on an incomplete and non-linear SKB.
> --
>
> commit aef1b3344bd952f39b1181e046ab7d9ce77fbc8a
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: avoid skb leak in XDP_TX_METADATA case
>
> This commit explicitly adds a call to kfree_skb() (via
> xsk_drop_untrans_skb) when xsk_skb_metadata() returns an error, preventin=
g
> an skb leak if metadata processing fails.
>
> Link: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.=
org/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 55b448abb8178..fd5432fb807e1 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -829,8 +829,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >               xsk_skb_init_misc(skb, xs, desc->addr);
> >               if (desc->options & XDP_TX_METADATA) {
> >                       err =3D xsk_skb_metadata(skb, buffer, desc, pool,=
 hr);
>
> While looking at this metadata handling, I noticed a couple of pre-existi=
ng
> regressions.
>
> Will skb_checksum_help() always fail when called here?
>
> xsk_skb_metadata() is called right after allocating the SKB but before an=
y
> payload fragments are appended via skb_fill_page_desc() further down in
> xsk_build_skb_zerocopy(). This means skb->len and skb_headlen(skb) are 0.
>
> If software checksumming is enabled, xsk_skb_metadata() calls
> skb_checksum_help(skb). Since skb_headlen(skb) is 0, won't the check
> offset >=3D skb_headlen(skb) in skb_checksum_help() always evaluate to tr=
ue,
> triggering a warning and causing the packet to be dropped?

Patch 1 has already dealt with this issue.

>
> Also, can a user-space program modify the checksum metadata concurrently?
>
> In xsk_skb_metadata(), the metadata is read directly from the UMEM buffer=
,
> which is shared memory mapped into user-space:
>
> net/xdp/xsk.c:xsk_skb_metadata() {
>     ...
>         if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
>                 if (unlikely(meta->request.csum_start +
>                              meta->request.csum_offset +
>                              sizeof(__sum16) > desc->len))
>                         return -EINVAL;
>
>                 skb->csum_start =3D hr + meta->request.csum_start;
>                 skb->csum_offset =3D meta->request.csum_offset;
>     ...
> }
>
> The bounds check does not use READ_ONCE(). Could a user-space application
> modify meta->request.csum_start and meta->request.csum_offset between the
> check and the assignment? If so, it might bypass the bounds check and spe=
cify
> arbitrarily large offsets, causing out-of-bounds writes when the hardware
> inserts the checksum.

Yes, you're right about this pre-existing behavior but currently I
don't have any interest in expanding the series. Maybe I will
construct it as a follow-up patch.

>
> > -                     if (unlikely(err))
> > +                     if (unlikely(err)) {
> > +                             xsk_drop_untrans_skb(skb);
> >                               return ERR_PTR(err);
> > +                     }
> >               }
> >       } else {
> >               struct xsk_addrs *xsk_addr;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.14=
844-1-kerneljasonxing@gmail.com?part=3D5
