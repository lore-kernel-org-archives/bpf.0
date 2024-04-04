Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5312D1EF
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245559; cv=none; b=ZX69UcguKdpyRn5EPgmne9NE7CclgZYGwAGP75P+0hlk/KiRK4iWROzBskbqLtwJQSbL57dqK56Ba0PkZKqWxwENeOCT/wi00qe4ZiMfPfPt8TrXvAiAO2+qI7HgHEZUrLYLPtrw+XkwW1QUEgXDaUPcTsSDDJCSqfz8OSBwEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245559; c=relaxed/simple;
	bh=sZ/x22X4J7HIO7ZQemQHO3Cxziy2J1Lddw+ctc7OJf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5TKbwhC6rCW7vpruh0iFx8oM/e1/W94QqxMENmhMpPLRUBqm9mLLx+nYXdHwVR2o5OEVuNWgG7HEwIPa2X8z28I9yvsgFjwRI7tyaKawwD9dAOahm741hh9vj8FwDJhXWP7hs/Dkh3YSEOl/4lcsOLeItvJTRSM09U8R+wemqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC1yIa+C; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC1yIa+C"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-432d5b5f00bso8601331cf.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712245556; x=1712850356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emof0JoQgi7CpwHJQRBHJ88awqwjU5MRW5gJG/QOYIo=;
        b=hC1yIa+C5zQm71R20Cu6xH+CeNMsSBoGT4lUNaCeJKP36E5P8yDLTb7pUIbs4QTNeu
         A2OmKFp1ktWkmTV8JJk2wVXE/nd1y1kpHgslhUqVEEhUvW/9FAty6aXw3hT16cLO00h7
         RsTCKELBDBHI6EYw4Qv9P4YSDQqY2RvrYiIAaB0BK9wMThX3Lvou2BIiocX7X0IsmgZv
         iq5Zvy5lKSDJEd6BGzLrO+hd8sRKwaYi1UXzFaoPX7q/h3VmtDjOvH965XvOZIHI92e8
         POP5SSBlDUPmNwdc1rzcb6nfCKkgEtQP+KhdJTFOwmEgrB3j2GptJ1wPaZM3g2+D83X0
         +p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712245556; x=1712850356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emof0JoQgi7CpwHJQRBHJ88awqwjU5MRW5gJG/QOYIo=;
        b=YEht2NpaID9nbwWW3X4RgeSjY9ncf7oTtpBpVl6ZRlUdqWRxsE7aWqsTng3XmIs2dq
         r9VMfvagWEYQzQIqcJTDZqTmRI1QwfUaIeRSEZfQ4age+845kpYp4iHoRqLTgCLpcZdi
         SdH7tsbCReOU8x5MY8XOwd/LtUhPoxRtK3952fa/T4BxQmTRKP8hZGLvDbcY/OCJKmgK
         /ciIovdUtObApJbBB/fEoCaw875C0Qh+VeyU9vmYhDF1u4QteAdJ2U5xacuOs1hZ8xL9
         wcFoz1KuUZ5lVyF+ElcZxOFcfy6s6TwSz6hMVUyuGy6b15GzTG5jXr9wfyA/dS4rp05E
         8IJA==
X-Gm-Message-State: AOJu0YzrgtXWvBywFbMVoC5MvchcRp+ZLDA38PSb3CkctE1mJVgUwV2T
	XaEC3qANv+X30N7SumVUSbthpB9D2HmJ1tGxWhU91E+N9ATAplHh9blm3Tmtc/7t+NrNIXlgF5U
	QGFPrS4J0HE7CisVmDOhE5Zi0VvzMmWyzk7A=
X-Google-Smtp-Source: AGHT+IF7XBdTUn/EL/JwdJWd1woTPoWcv445s92MM9WUdMhrvCL2/7hzcKZSp6bH7SIIC40E9TrQhkDS/3zBkYoCK58=
X-Received: by 2002:a05:622a:252:b0:432:cac6:5c63 with SMTP id
 c18-20020a05622a025200b00432cac65c63mr4165025qtx.5.1712245556459; Thu, 04 Apr
 2024 08:45:56 -0700 (PDT)
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
 <CAK3+h2zpV75MkOx49RvXyvf+DwHjHaF9e8jFj+3AG2qZQZEr8A@mail.gmail.com> <CAK3+h2yUVUAVq5OZjnrRti58OM=ro6Kvb4b48fwcpHCM-M92UA@mail.gmail.com>
In-Reply-To: <CAK3+h2yUVUAVq5OZjnrRti58OM=ro6Kvb4b48fwcpHCM-M92UA@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 4 Apr 2024 08:45:45 -0700
Message-ID: <CAK3+h2xJ91qciuPdurFr6=s5G6kHcBWt4D+weYE62N0FR2LLfg@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:42=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> On Wed, Apr 3, 2024 at 1:01=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.co=
m> wrote:
> >
> > On Wed, Apr 3, 2024 at 12:56=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 12:35=E2=80=AFPM Vincent Li <vincent.mc.li@gma=
il.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.mc.li=
@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.m=
c.li@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Once I enabled the open source firewall IPfire kernel 6.6.1=
5
> > > > > > > > DEBUG_INFO_BTF, the IPfire ISO image is increased from abou=
t 450MB to
> > > > > > > > about 1.5GB, I suspect because IPfire has many driver modul=
es to
> > > > > > >
> > > > > > > BTF can't be that big. I think you just get all the DWARF for=
 modules
> > > > > > > and vmlinux itself. DWARF is necessary to generate BTF during=
 the
> > > > > > > build time, but it can be stripped out afterwards, leaving ju=
st (much
> > > > > > > smaller) BTF intact.
> > > > > >
> > > > > > ok good to hear that :).  I am new to this, how to strip
> > > > > > kernel/modules DWARF after kernel/modules being built?
> > > > > >
> > > > > > >
> > > > > > > > support as many hardware as possible, pahole generated BTF =
for all
> > > > > > > > these modules, that could increase the size of the ISO imag=
e, so I
> > > > > > > > wonder if I could disable modules BTF only but keep vmlinux=
 BTF, or
> > > > > > > > maybe selectively enable BTF for some modules, but not othe=
r modules?
> > > > > > > >
> > > > > > > > I found this discussion [0] making DEBUG_INFO_BTF_MODULES s=
electable
> > > > > > > > independently. I am still not sure how to disable modules B=
TF, I tried
> > > > > > > > make menuconfig, still not obvious to me how to disable
> > > > > > > > DEBUG_INFO_BTF_MODULES
> > > > > > >
> > > > > > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, b=
ut see
> > > > > > > above, I don't think the BTF is a problem here, it's not stri=
pping out
> > > > > > > DWARF.
> > > >
> > > > I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
> > > > CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
> > > > in .config, but make oldconfig always flip it back to y, if I run m=
ake
> > > > bzImage without make oldconfig, it will have "Restart config..."
> > > > like below and n  flipped to y again when examining the .config
> > >
> > > Maybe CONFIG_MODULE_ALLOW_BTF_MISMATCH is auto-selecting it, try
> > > turning both off.
> > >
> >
> > originally CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set, so I set it to
> > n, still CONFIG_DEBUG_INFO_BTF_MODULES set back to y, I also tried set
> > CONFIG_PAHOLE_HAS_SPLIT_BTF and CONFIG_PAHOLE_HAS_LANG_EXCLUDE to n,
> > no effect, all back to y
> >
>
> I found if I change DEBUG_INFO_BTF_MODULES def_bool to n as below
> diff, it works, is this the right way?
>
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 975a07f9f1cc..98d7a4476d00 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
>           using DEBUG_INFO_BTF_MODULES.
>
>  config DEBUG_INFO_BTF_MODULES
> -       def_bool y
> +       def_bool n
>         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
>         help
>           Generate compact split BTF type information for kernel modules.
>

this seems  always set DEBUG_INFO_BTF_MODULES to n when I want y, not
going to work :)

> > > >
> > > > # make bzImage
> > > >
> > > >  SYNC    include/config/auto.conf.cmd
> > > > *
> > > > * Restart config...
> > > > *
> > > >
> > > > >
> > > > > strip -g ? I don't know how this is normally done in Linux distro=
s.
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84=
ZGvwuCJLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb93=
1b294ec2d
> > > > > > > >
> > > > > > > > Thanks!
> > > > > > > >
