Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9642224DE
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245941; cv=none; b=MCxMlFQ7U1lzR2RiVRu1Nh2nDQ4e2FGLdYRUOp322kRK8kqlFR3AcnAdoBh0L4gKodVqUO1TM6x8y3JTY6vLU9DG5Yrs+LKgsFuoZZQ+E+1ECNjbWsmaI0XD1biN+rlPeuk5YuDcMTJB94HbPpqVezQDCGyOO+rYa0ncR/Z5Ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245941; c=relaxed/simple;
	bh=+I8/GsIvhe2lRt7jqQZlZxq3m/e45bpYDJQCgHzg2yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI2fYzVZK3/rOUgUQlcpKnJpTzCiAtEgWDVfqjlghV3GouF+mAHVdThNDhJeMfACE6qRAopjX5iBKtxWskZsSE9UIdRr/QbcrAcFTg4X2tTlwejcR7KypoD0qeEfwX2qgE7NROhdpSFnBtwJwVw9BBFL410APR7GTma3VkaiWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZwJasid; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZwJasid"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-432bfaf533eso6062441cf.2
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712245938; x=1712850738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBCZ+mBbDn4nzIieBD9exWLTdsmhzk7OWFyYYRqFsWs=;
        b=IZwJasidx5qYamreSBXKh1ielXZ4JIKBaaRog7RDRBSwjx/ldjuyAwJ1Pa4YmLz6nq
         UxqvhPZnLCVuWDa2/3EUuHfkYLQ4lWuM8IXDI7UEaxcDvdji/O4iimjW+F7hlgFHddOr
         NxIuiqR2226emIKllc3+fO/IF6sJ9CfKro7m2om2HYaWrU5kutN9FLl8DLtLpvzrK+aJ
         4Xr62E4nuLn74ieYCbHGasvIUjHnn5+WqOeJ3Vt8l2G8WCxDT/hlhyQ4nQN4MWEts/Oj
         1zseZzTPgID0I8g4q8YiBCe44L5EjyCT+YcqYfk+taaTnnkcUfsyu6Xu5dAbeCGt/FIC
         IoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712245938; x=1712850738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBCZ+mBbDn4nzIieBD9exWLTdsmhzk7OWFyYYRqFsWs=;
        b=oZKZ31DSnq/sv2fpXXxBRTg1JJr/BWATQq2Tc0CSOckouxHkEplahQhntAR4lTLyYc
         3UbzfMBTb3aXGCf+GD0iNFJHKpHwX9N9SxmCU2xfYUT/z4FZYT1K9C24aDyj5fhvcf/o
         pljntmTNjSB8bycL1BH1VElWQ+vHwZmXjJOKuMFS208jsPlkT4/BiA/zoGKhwdzLmagN
         +fyNVE2z9LvkfPtEILGug3qauvkpuEV5Z42yPaiDdh2eJc6EqgaYNLO3ClR9DJ5dRYw/
         vPSRqtT6m0Go3eSrrgUkbQo6dEikD6hN0KQX6LQoptkFVj7pLI7IVKwA1UawDSYjtiId
         3HAQ==
X-Gm-Message-State: AOJu0Yz9Q1OGFdedv4erXy+M5+5Z1q+BfNgwPIY7xutSFwzu+73v9iiT
	P76CxsvDQvNOKsIpaiRumam6ZDsU7pBX/kRSvsmBN8OZ2UITlDMzxd80uTJ5lCzxfzvIexvAiZd
	ZSVaF79PlasAMBW29RH6VGUZcVUdxR27jqCg=
X-Google-Smtp-Source: AGHT+IEc7mYPRbjoPlUAeyA36zwIUX4q+bbNAt+vNZQhIAIfy0hbguFgl1cR9PqHowrBOeH9l2hos3JcL4mpqzuz/1s=
X-Received: by 2002:a05:622a:15c8:b0:430:a037:db36 with SMTP id
 d8-20020a05622a15c800b00430a037db36mr2956371qty.32.1712245937913; Thu, 04 Apr
 2024 08:52:17 -0700 (PDT)
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
 <CAK3+h2yUVUAVq5OZjnrRti58OM=ro6Kvb4b48fwcpHCM-M92UA@mail.gmail.com> <CAK3+h2xJ91qciuPdurFr6=s5G6kHcBWt4D+weYE62N0FR2LLfg@mail.gmail.com>
In-Reply-To: <CAK3+h2xJ91qciuPdurFr6=s5G6kHcBWt4D+weYE62N0FR2LLfg@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 4 Apr 2024 08:52:07 -0700
Message-ID: <CAK3+h2xiFfzQ9UXf56nrRRP=p1+iUxGoEP5B+aq9MDT5jLXDSg@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:45=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> On Thu, Apr 4, 2024 at 8:42=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.co=
m> wrote:
> >
> > On Wed, Apr 3, 2024 at 1:01=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.=
com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 12:56=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 12:35=E2=80=AFPM Vincent Li <vincent.mc.li@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.mc.=
li@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent=
.mc.li@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Once I enabled the open source firewall IPfire kernel 6.6=
.15
> > > > > > > > > DEBUG_INFO_BTF, the IPfire ISO image is increased from ab=
out 450MB to
> > > > > > > > > about 1.5GB, I suspect because IPfire has many driver mod=
ules to
> > > > > > > >
> > > > > > > > BTF can't be that big. I think you just get all the DWARF f=
or modules
> > > > > > > > and vmlinux itself. DWARF is necessary to generate BTF duri=
ng the
> > > > > > > > build time, but it can be stripped out afterwards, leaving =
just (much
> > > > > > > > smaller) BTF intact.
> > > > > > >
> > > > > > > ok good to hear that :).  I am new to this, how to strip
> > > > > > > kernel/modules DWARF after kernel/modules being built?
> > > > > > >
> > > > > > > >
> > > > > > > > > support as many hardware as possible, pahole generated BT=
F for all
> > > > > > > > > these modules, that could increase the size of the ISO im=
age, so I
> > > > > > > > > wonder if I could disable modules BTF only but keep vmlin=
ux BTF, or
> > > > > > > > > maybe selectively enable BTF for some modules, but not ot=
her modules?
> > > > > > > > >
> > > > > > > > > I found this discussion [0] making DEBUG_INFO_BTF_MODULES=
 selectable
> > > > > > > > > independently. I am still not sure how to disable modules=
 BTF, I tried
> > > > > > > > > make menuconfig, still not obvious to me how to disable
> > > > > > > > > DEBUG_INFO_BTF_MODULES
> > > > > > > >
> > > > > > > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine,=
 but see
> > > > > > > > above, I don't think the BTF is a problem here, it's not st=
ripping out
> > > > > > > > DWARF.
> > > > >
> > > > > I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
> > > > > CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
> > > > > in .config, but make oldconfig always flip it back to y, if I run=
 make
> > > > > bzImage without make oldconfig, it will have "Restart config..."
> > > > > like below and n  flipped to y again when examining the .config
> > > >
> > > > Maybe CONFIG_MODULE_ALLOW_BTF_MISMATCH is auto-selecting it, try
> > > > turning both off.
> > > >
> > >
> > > originally CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set, so I set it t=
o
> > > n, still CONFIG_DEBUG_INFO_BTF_MODULES set back to y, I also tried se=
t
> > > CONFIG_PAHOLE_HAS_SPLIT_BTF and CONFIG_PAHOLE_HAS_LANG_EXCLUDE to n,
> > > no effect, all back to y
> > >
> >
> > I found if I change DEBUG_INFO_BTF_MODULES def_bool to n as below
> > diff, it works, is this the right way?
> >
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 975a07f9f1cc..98d7a4476d00 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
> >           using DEBUG_INFO_BTF_MODULES.
> >
> >  config DEBUG_INFO_BTF_MODULES
> > -       def_bool y
> > +       def_bool n
> >         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> >         help
> >           Generate compact split BTF type information for kernel module=
s.
> >
>
> this seems  always set DEBUG_INFO_BTF_MODULES to n when I want y, not
> going to work :)
>

this diff seems resolves the problem

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..31bd799bf3b5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -408,7 +408,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
          using DEBUG_INFO_BTF_MODULES.

 config DEBUG_INFO_BTF_MODULES
-       def_bool y
+       bool "Generate modules BTF"
        depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
        help
          Generate compact split BTF type information for kernel modules.

any suggestions ?

> > > > >
> > > > > # make bzImage
> > > > >
> > > > >  SYNC    include/config/auto.conf.cmd
> > > > > *
> > > > > * Restart config...
> > > > > *
> > > > >
> > > > > >
> > > > > > strip -g ? I don't know how this is normally done in Linux dist=
ros.
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk=
84ZGvwuCJLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb=
931b294ec2d
> > > > > > > > >
> > > > > > > > > Thanks!
> > > > > > > > >
