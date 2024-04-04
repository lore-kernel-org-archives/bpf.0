Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81382D90
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268553; cv=none; b=AKynvMLeM0g2flLkBrNN92JINjoX6XL9NHqVWKmb9op7nQzuUZpD2Svzdx/3DYfiecl9tb5VNZEgfOo8O7m9ESg3tLios91QhBAHs4rQqqfNXNTtVyn4/7+9R1iNvAnfCmAuzH4v23bONAnwCmlxw4GLzqkoiX4JjzdnoGachgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268553; c=relaxed/simple;
	bh=xrVtWERE9JVxIZc+zKWqczPBWo34a66bA4YYk02f3yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/Oyoi+8fknRj9U/lEaBtIoOeI3kXk7KRD0lktPCnyWHJ7QfXL5M2rxp2k6u6Pnv3EReARb8BTn97tjODaLZ7WYBhXubYRfQXJqWPbdyivnLhUvP9B2fa1JJlJ8VjHz4Df7/WQpgIOMCXI6g5f0vibIWtSaXq/5CTnuUCbJznt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dflrszy0; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dflrszy0"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1073346a12.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712268551; x=1712873351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxZpgXgYrjV9BuFVmJ0EnOCAc6z8pgY1CoK1ggB+cZs=;
        b=Dflrszy0BXlmliISKt0X6HtNyjix4vSpUt4JhVsw+d9VgKkbkbHSxxYGAfiWnnpznj
         6gwHSDLx1KPzLm5qYeIsvqoisml16X3UgEsVqcui6ocWIH60f6qY+zETniM4sXdURZOV
         Wv+Ry93H114jAwe528G9nqBDUrhSb3Q0HezVq0k9pzgq0EUKKzV/rWPZXxKy0dAQpBi5
         ILAoPtPmpIiPNWMhb/O4pnWwTJKDlFAf4Qkr5sg05+1T9E/TKry4quIV4Iea8VM/pa4w
         YYTaPkGCTG9OhEx9Gz3bULVsVHD8VaH5KAVooq/Z20QgOkXzbaezxBULPSxnGBPNhB0Q
         WrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712268551; x=1712873351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxZpgXgYrjV9BuFVmJ0EnOCAc6z8pgY1CoK1ggB+cZs=;
        b=fVol7TlniYB2nnhUrqvfUI8jL8XLNRzwNv/25NqQThspqMbvdkD9UL8yV4WmwzSVqh
         IX9DRT8X3l/zYA64Vw1U7l/jkcuu38Yb7U8e+PA0SrjYqJoL/zl5Qzi/zwnq85RMlhrh
         cABnq9tcSLhe7YTuf3AawlPK+qLnH5s2NptFTcXDhCnjmDLCSewQt3ipYa12WMuFbxH+
         cP1XcPX2kDP1I/O7lnLQ3I09pQcSccJ+xCutEshFm/5D5X3BNDeq0IkL07yP3OJ8eC5t
         KQaVAjifhfhj+8uFey7+5yZNfcnMtlI3xOB3DW3/ypRGp/Z1iP7+LFjVkIQpzcbsyEiL
         XiSQ==
X-Gm-Message-State: AOJu0YyBel26W5Q9O1izlDS4VJTFMS6j1lNDD/J9BbWATQHBGKeK/don
	PLR8JiRLfZ3co92vMZSSg5mbKN3UwFytA2dHAqYZuOWQh4EUvleucTi42Ysk4kqC+HEQzvNItp9
	eKyhCcdCe592hZuRrg/ufZ06TrWGzoRmH7os=
X-Google-Smtp-Source: AGHT+IFn2GJwWlRxI6MG8Anydj+VV/tBPldJ4GHXn927qnYDNn4fuRWaunHUkO0sYh7BDFR8W3ZANib8vUiGMS0TlIQ=
X-Received: by 2002:a17:90a:7896:b0:2a2:ddc0:4bf8 with SMTP id
 x22-20020a17090a789600b002a2ddc04bf8mr2687907pjk.31.1712268551492; Thu, 04
 Apr 2024 15:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
 <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
 <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com>
 <CAEf4BzbKz2xCK6jqVnzA4uWnZKx+UteNPcZ3zFtyYe885stnLA@mail.gmail.com>
 <CAK3+h2wkbuMrcPg6E7Gh0AxbGiSKNGJ6RX=psxtBP6k9W0L6PQ@mail.gmail.com>
 <CAEf4BzYY09WnHsz3peLYMy0=A3JkivV-zxD2GjmGrQWLbhW7mQ@mail.gmail.com>
 <CAK3+h2zpV75MkOx49RvXyvf+DwHjHaF9e8jFj+3AG2qZQZEr8A@mail.gmail.com>
 <CAK3+h2yUVUAVq5OZjnrRti58OM=ro6Kvb4b48fwcpHCM-M92UA@mail.gmail.com>
 <CAK3+h2xJ91qciuPdurFr6=s5G6kHcBWt4D+weYE62N0FR2LLfg@mail.gmail.com> <CAK3+h2xiFfzQ9UXf56nrRRP=p1+iUxGoEP5B+aq9MDT5jLXDSg@mail.gmail.com>
In-Reply-To: <CAK3+h2xiFfzQ9UXf56nrRRP=p1+iUxGoEP5B+aq9MDT5jLXDSg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 15:08:58 -0700
Message-ID: <CAEf4BzZ1XNznvqjjj3_vyUYEp9c7ju=tAg1B7yPp68fxfNJQDw@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:52=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> On Thu, Apr 4, 2024 at 8:45=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.co=
m> wrote:
> >
> > On Thu, Apr 4, 2024 at 8:42=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.=
com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 1:01=E2=80=AFPM Vincent Li <vincent.mc.li@gmai=
l.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 12:56=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 12:35=E2=80=AFPM Vincent Li <vincent.mc.li=
@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.m=
c.li@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vince=
nt.mc.li@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > Once I enabled the open source firewall IPfire kernel 6=
.6.15
> > > > > > > > > > DEBUG_INFO_BTF, the IPfire ISO image is increased from =
about 450MB to
> > > > > > > > > > about 1.5GB, I suspect because IPfire has many driver m=
odules to
> > > > > > > > >
> > > > > > > > > BTF can't be that big. I think you just get all the DWARF=
 for modules
> > > > > > > > > and vmlinux itself. DWARF is necessary to generate BTF du=
ring the
> > > > > > > > > build time, but it can be stripped out afterwards, leavin=
g just (much
> > > > > > > > > smaller) BTF intact.
> > > > > > > >
> > > > > > > > ok good to hear that :).  I am new to this, how to strip
> > > > > > > > kernel/modules DWARF after kernel/modules being built?
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > support as many hardware as possible, pahole generated =
BTF for all
> > > > > > > > > > these modules, that could increase the size of the ISO =
image, so I
> > > > > > > > > > wonder if I could disable modules BTF only but keep vml=
inux BTF, or
> > > > > > > > > > maybe selectively enable BTF for some modules, but not =
other modules?
> > > > > > > > > >
> > > > > > > > > > I found this discussion [0] making DEBUG_INFO_BTF_MODUL=
ES selectable
> > > > > > > > > > independently. I am still not sure how to disable modul=
es BTF, I tried
> > > > > > > > > > make menuconfig, still not obvious to me how to disable
> > > > > > > > > > DEBUG_INFO_BTF_MODULES
> > > > > > > > >
> > > > > > > > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fin=
e, but see
> > > > > > > > > above, I don't think the BTF is a problem here, it's not =
stripping out
> > > > > > > > > DWARF.
> > > > > >
> > > > > > I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
> > > > > > CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
> > > > > > in .config, but make oldconfig always flip it back to y, if I r=
un make
> > > > > > bzImage without make oldconfig, it will have "Restart config...=
"
> > > > > > like below and n  flipped to y again when examining the .config
> > > > >
> > > > > Maybe CONFIG_MODULE_ALLOW_BTF_MISMATCH is auto-selecting it, try
> > > > > turning both off.
> > > > >
> > > >
> > > > originally CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set, so I set it=
 to
> > > > n, still CONFIG_DEBUG_INFO_BTF_MODULES set back to y, I also tried =
set
> > > > CONFIG_PAHOLE_HAS_SPLIT_BTF and CONFIG_PAHOLE_HAS_LANG_EXCLUDE to n=
,
> > > > no effect, all back to y
> > > >
> > >
> > > I found if I change DEBUG_INFO_BTF_MODULES def_bool to n as below
> > > diff, it works, is this the right way?
> > >
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 975a07f9f1cc..98d7a4476d00 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
> > >           using DEBUG_INFO_BTF_MODULES.
> > >
> > >  config DEBUG_INFO_BTF_MODULES
> > > -       def_bool y
> > > +       def_bool n
> > >         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > >         help
> > >           Generate compact split BTF type information for kernel modu=
les.
> > >
> >
> > this seems  always set DEBUG_INFO_BTF_MODULES to n when I want y, not
> > going to work :)
> >
>
> this diff seems resolves the problem
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 975a07f9f1cc..31bd799bf3b5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
>           using DEBUG_INFO_BTF_MODULES.
>
>  config DEBUG_INFO_BTF_MODULES
> -       def_bool y
> +       bool "Generate modules BTF"
>         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
>         help
>           Generate compact split BTF type information for kernel modules.
>
> any suggestions ?
>

yeah, you'll need this fix ([0]), it's an issue of how
DEBUG_INFO_BTF_MODULES is defined and/or a quirk of Kconfig

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240404220344.3=
879270-1-andrii@kernel.org/

> > > > > >
> > > > > > # make bzImage
> > > > > >
> > > > > >  SYNC    include/config/auto.conf.cmd
> > > > > > *
> > > > > > * Restart config...
> > > > > > *
> > > > > >
> > > > > > >
> > > > > > > strip -g ? I don't know how this is normally done in Linux di=
stros.
> > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2t=
yk84ZGvwuCJLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951f=
eb931b294ec2d
> > > > > > > > > >
> > > > > > > > > > Thanks!
> > > > > > > > > >
