Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68ADDA0
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712282861; cv=none; b=fdiXAUp1IrfOQeD9yJSC8LHcs4JfmJQq0oylrhlUHxx4v9tB/Yl0bRRNxZykkttIL8sSazPZXOOflhvEMecufdNTFHtfI1NL4+psD0mkLunqnjRpwjuMA5IhDMUo8jeDPqqcwU/lqoEHz6X2lXQjsKlFgsGTRywclgS5aIYAf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712282861; c=relaxed/simple;
	bh=jR9zcPzYO1pxOoUAg4vr2ePJO8NGylLBK5cVD7Isf8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8xPL08pr+QpCVPDzIv66wL/+/Nui3wUgKI+Z7K3QXBzec11JqMqbeWaKCBaVBi2pptHjWLGzJF5/xJ3TB5jzefqdBHGB86Ek14LC9s0TGkXiotasrHJ29Ar9+Aj+QCoJualDKd4prwzLaUpuEc0JAGLVbGqLMM6iFU/mavce20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYbJrqE4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYbJrqE4"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43456949480so5050871cf.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 19:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712282858; x=1712887658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wNPqu9nZkVn9fAfYibfuMhPfc8U6GFYM6tKIR2FjBY=;
        b=SYbJrqE4OBritBdeGn394ZVoomY1Vn3oVx8UWsr36WpR5xPxhb6wVze9DPmxKwajTS
         sgGsL4gVc1rsMk/4MEwY4FqI+3eu4WfsHc5PbAVEYYzytkS9CyX7tPK2O2ojOdF4D0KJ
         tgyv/Xy3J1citQAXLlA56vVAWxsdvijN2XOOcr/2mFsUmMMH1Vx6XJkfgZPTYkvNBOGM
         R0NyH4vT+/tffrN20P6K6rnTRddgcsMUWXp5SHJ3Asrw1CKrSpv+CKT1SrDsPg1U7ad8
         M3ZJqu586W3MmOjpsVTq+G1ookYL1TtrTfXwwppovJyiJK2oej0fQCTP76isZQPORQSI
         fUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712282858; x=1712887658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wNPqu9nZkVn9fAfYibfuMhPfc8U6GFYM6tKIR2FjBY=;
        b=PRt6z5xYFx11IQ5bWKKZWsMmRFkglHc4q5dTgSneJXpBZB373r4JuKlW/Jv8FO9ez4
         dAFdI0/Mbxd1DaX4cm9X1W7BbTpL9Im8Uko5B3RPc7Z3uIgYnocL1m/3r0dflxCODyI3
         Pdm0vGgvz2mLAbdKd8cvOuw1JchInD+66MWnILwup49P9y3zbfHB0HrraNHbt0A3HYPw
         bt9IkzRSLjKrusWq8MxfGYDKWXGLXltPTmkeOkpjkmmCT7zAwwp943HMRRE/P3+25Dnf
         otTaSBiXWfhp3gWVEp7JMcjlzoUuTWycc1/zgxlJ/nH9tJmvQCpv3UseS68vNGDPiTvk
         sIgA==
X-Gm-Message-State: AOJu0YxO4Zy1qahz4O+dY2oGrvpwKd6JaIvCjSqZ2FBIdhICOsBRaQRv
	01GvglRl6x+hSaH5k7WkMGeVASnCMXn9YXe/LWKfHW5BHIP0bjisNDTDzzh+PeAWVZDSfLiuRNJ
	G7BHMgTFahIWaGYyrB7hscESmSrVsz6afGlQ=
X-Google-Smtp-Source: AGHT+IHgWX/SWMbP3jbEkOsul7eg93fxwpWM6pvii20AcWlKX6MZ2BoOERXbW1UgJqxAb0+tN2aC9qvuWHSQ6TAH/nA=
X-Received: by 2002:a05:622a:13cc:b0:431:5b18:5ca6 with SMTP id
 p12-20020a05622a13cc00b004315b185ca6mr66957qtk.47.1712282858502; Thu, 04 Apr
 2024 19:07:38 -0700 (PDT)
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
 <CAK3+h2xJ91qciuPdurFr6=s5G6kHcBWt4D+weYE62N0FR2LLfg@mail.gmail.com>
 <CAK3+h2xiFfzQ9UXf56nrRRP=p1+iUxGoEP5B+aq9MDT5jLXDSg@mail.gmail.com> <CAEf4BzZ1XNznvqjjj3_vyUYEp9c7ju=tAg1B7yPp68fxfNJQDw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ1XNznvqjjj3_vyUYEp9c7ju=tAg1B7yPp68fxfNJQDw@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 4 Apr 2024 19:07:26 -0700
Message-ID: <CAK3+h2ymkOmmGYHy1WOT5L+nbavM0sfRZ3LKZiMz-GAhcO1=WQ@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 3:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 8:52=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.co=
m> wrote:
> >
> > On Thu, Apr 4, 2024 at 8:45=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.=
com> wrote:
> > >
> > > On Thu, Apr 4, 2024 at 8:42=E2=80=AFAM Vincent Li <vincent.mc.li@gmai=
l.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 1:01=E2=80=AFPM Vincent Li <vincent.mc.li@gm=
ail.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 12:56=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 3, 2024 at 12:35=E2=80=AFPM Vincent Li <vincent.mc.=
li@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent=
.mc.li@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > > > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vin=
cent.mc.li@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > Once I enabled the open source firewall IPfire kernel=
 6.6.15
> > > > > > > > > > > DEBUG_INFO_BTF, the IPfire ISO image is increased fro=
m about 450MB to
> > > > > > > > > > > about 1.5GB, I suspect because IPfire has many driver=
 modules to
> > > > > > > > > >
> > > > > > > > > > BTF can't be that big. I think you just get all the DWA=
RF for modules
> > > > > > > > > > and vmlinux itself. DWARF is necessary to generate BTF =
during the
> > > > > > > > > > build time, but it can be stripped out afterwards, leav=
ing just (much
> > > > > > > > > > smaller) BTF intact.
> > > > > > > > >
> > > > > > > > > ok good to hear that :).  I am new to this, how to strip
> > > > > > > > > kernel/modules DWARF after kernel/modules being built?
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > support as many hardware as possible, pahole generate=
d BTF for all
> > > > > > > > > > > these modules, that could increase the size of the IS=
O image, so I
> > > > > > > > > > > wonder if I could disable modules BTF only but keep v=
mlinux BTF, or
> > > > > > > > > > > maybe selectively enable BTF for some modules, but no=
t other modules?
> > > > > > > > > > >
> > > > > > > > > > > I found this discussion [0] making DEBUG_INFO_BTF_MOD=
ULES selectable
> > > > > > > > > > > independently. I am still not sure how to disable mod=
ules BTF, I tried
> > > > > > > > > > > make menuconfig, still not obvious to me how to disab=
le
> > > > > > > > > > > DEBUG_INFO_BTF_MODULES
> > > > > > > > > >
> > > > > > > > > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work f=
ine, but see
> > > > > > > > > > above, I don't think the BTF is a problem here, it's no=
t stripping out
> > > > > > > > > > DWARF.
> > > > > > >
> > > > > > > I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
> > > > > > > CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
> > > > > > > in .config, but make oldconfig always flip it back to y, if I=
 run make
> > > > > > > bzImage without make oldconfig, it will have "Restart config.=
.."
> > > > > > > like below and n  flipped to y again when examining the .conf=
ig
> > > > > >
> > > > > > Maybe CONFIG_MODULE_ALLOW_BTF_MISMATCH is auto-selecting it, tr=
y
> > > > > > turning both off.
> > > > > >
> > > > >
> > > > > originally CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set, so I set =
it to
> > > > > n, still CONFIG_DEBUG_INFO_BTF_MODULES set back to y, I also trie=
d set
> > > > > CONFIG_PAHOLE_HAS_SPLIT_BTF and CONFIG_PAHOLE_HAS_LANG_EXCLUDE to=
 n,
> > > > > no effect, all back to y
> > > > >
> > > >
> > > > I found if I change DEBUG_INFO_BTF_MODULES def_bool to n as below
> > > > diff, it works, is this the right way?
> > > >
> > > >
> > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > index 975a07f9f1cc..98d7a4476d00 100644
> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
> > > > @@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
> > > >           using DEBUG_INFO_BTF_MODULES.
> > > >
> > > >  config DEBUG_INFO_BTF_MODULES
> > > > -       def_bool y
> > > > +       def_bool n
> > > >         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BT=
F
> > > >         help
> > > >           Generate compact split BTF type information for kernel mo=
dules.
> > > >
> > >
> > > this seems  always set DEBUG_INFO_BTF_MODULES to n when I want y, not
> > > going to work :)
> > >
> >
> > this diff seems resolves the problem
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 975a07f9f1cc..31bd799bf3b5 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
> >           using DEBUG_INFO_BTF_MODULES.
> >
> >  config DEBUG_INFO_BTF_MODULES
> > -       def_bool y
> > +       bool "Generate modules BTF"
> >         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> >         help
> >           Generate compact split BTF type information for kernel module=
s.
> >
> > any suggestions ?
> >
>
> yeah, you'll need this fix ([0]), it's an issue of how
> DEBUG_INFO_BTF_MODULES is defined and/or a quirk of Kconfig
>
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240404220344=
.3879270-1-andrii@kernel.org/
>

Great! thanks. you are right, it is the debug info in modules eating
most of disk space, I found scripts/Makefile.modinst has
INSTALL_MOD_STRIP where I can specify strip options like
INSTALL_MOD_STRIP=3D--strip-all make modules_install, and the installed
modules will be stripped, and the installed modules can also be
compressed when CONFIG_MODULE_COMPRESS_XZ is set, just fyi :)

> > > > > > >
> > > > > > > # make bzImage
> > > > > > >
> > > > > > >  SYNC    include/config/auto.conf.cmd
> > > > > > > *
> > > > > > > * Restart config...
> > > > > > > *
> > > > > > >
> > > > > > > >
> > > > > > > > strip -g ? I don't know how this is normally done in Linux =
distros.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN=
2tyk84ZGvwuCJLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b66595=
1feb931b294ec2d
> > > > > > > > > > >
> > > > > > > > > > > Thanks!
> > > > > > > > > > >
