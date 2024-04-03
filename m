Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEB14885B
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172957; cv=none; b=lBCM6SHxh6gdcH6ThLcGhLAG6hsGieMJungbbZG0OC+jTBVeo2cVj9RSqT4XKKxl2k+LhKpj+hyvimVxZS/YLRHGS3ieU+XCyE/RLRz68rd4Tay9RJhr+hDFnDerXdJ3GuTIk5QfLeqIW6u3hqBYA+STLpchApRSt0qaESeOKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172957; c=relaxed/simple;
	bh=hXz2cPGb4PC4e1nfVd++miPNjKY2UDhHKAE3TRo31sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F52ZRd1Smk/G9XDt0CKnd7jyQ+KDPEzBJfn3WbOOpxT+dJfuxsTqr0UbBlXDDQH+haBkOnZ8ZGXoTrdHhRx0Bj3QFDPGvwqOIJ7P+iOGxpxcDnih+M02sU3E3A2Dq3UPKRLOHVDqqlFjxgQx7amOCRZXr71udlt9c2Xb7TTr3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhQyCEUs; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhQyCEUs"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-432bfaf533eso1316431cf.2
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712172955; x=1712777755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyBblZXaJ7Qz92niJRLfEuqAHmHFqZggsv1P007Fz8E=;
        b=DhQyCEUsRW3iTGRJ0z7CzW7ni9XNCWVRzDTlIlOwfSaHaaAUKyswV22eXo5MMWHr4+
         H1W4xVgWbgsbS9jL0gVNBTIC8+M2vaJLcr4Kfm2pSUoil2gAB5j6iOLPdDzfBr1ZNESk
         5AT9G8U2mza0WiTz0/xGeXsVnys6GmwMd6jpyyp3Ziy3fKcaAKu0Qd/iSmtoFRdFrDVJ
         rCiLQdT9JKHkZPLleQiYecaNwtfR9Z9yL01zLBUsNwYM8b4SWVRN/9g1vvTrWiyrsYKq
         weK5FgC2riqJm+nZhh5P3il0uLU4CkRDPvwmUNizEqb5xPTVEmoIDgOMyC+6yJQ/N9qz
         hbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712172955; x=1712777755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyBblZXaJ7Qz92niJRLfEuqAHmHFqZggsv1P007Fz8E=;
        b=OmhN9Fs6QqLbvrCklCHVbc/t74zk+9bCuj0TzF1/iBFrX3m9ePteGXWvdPQJIZXvoc
         qG80mgZA6qBnVSpd3Vsme2AbGFTZcH8vd9nFxP7vlakYFKaLwFMXw1O3MHKWLElY0emy
         KF1yVYjJWEO+OrziiHrlOFhFafn3HpjVvjLDK3LIIdberZqJDuZ/SBYG42w/lZJLq1Y0
         oM3EvhEzMXcKLT0HCeIHBeF7QfriCOBJ/2ubKpzOWjPZNutGEOmRoI/Gctcp1d5xA8fN
         AKVC2rSPvs71knrL3Tct68bQ6CeO7A9SCW9RI073YO7kaNH3kkEdIokJ2WwULBuDAgcQ
         ktmg==
X-Gm-Message-State: AOJu0YxcJOfdFQN2A2zataRicWipuRGzAIacP6r+wCe0MI+sqpxMhdSU
	OIuZTYG6kGrlebA2yeRZ153Rd1EedvqSYe4/vRKVVk54tH1zxn6ncRkA0JhiSqk5CC94RU8A0mM
	2f83hVY1G4CkWWycPka6S717iQbrBVlats6Q=
X-Google-Smtp-Source: AGHT+IGT6dfAstd3e//hYI1XessPQ175N69n/b3KUEUDYAZN5DzYWU0bQ5TgpODTtYX3uXcapVNQ4ERUBV6tBaMOCtI=
X-Received: by 2002:a05:622a:1b29:b0:432:e294:f3a3 with SMTP id
 bb41-20020a05622a1b2900b00432e294f3a3mr387467qtb.34.1712172954900; Wed, 03
 Apr 2024 12:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
 <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
 <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com> <CAEf4BzbKz2xCK6jqVnzA4uWnZKx+UteNPcZ3zFtyYe885stnLA@mail.gmail.com>
In-Reply-To: <CAEf4BzbKz2xCK6jqVnzA4uWnZKx+UteNPcZ3zFtyYe885stnLA@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 3 Apr 2024 12:35:43 -0700
Message-ID: <CAK3+h2wkbuMrcPg6E7Gh0AxbGiSKNGJ6RX=psxtBP6k9W0L6PQ@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.c=
om> wrote:
> >
> > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.mc.li@gma=
il.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Once I enabled the open source firewall IPfire kernel 6.6.15
> > > > DEBUG_INFO_BTF, the IPfire ISO image is increased from about 450MB =
to
> > > > about 1.5GB, I suspect because IPfire has many driver modules to
> > >
> > > BTF can't be that big. I think you just get all the DWARF for modules
> > > and vmlinux itself. DWARF is necessary to generate BTF during the
> > > build time, but it can be stripped out afterwards, leaving just (much
> > > smaller) BTF intact.
> >
> > ok good to hear that :).  I am new to this, how to strip
> > kernel/modules DWARF after kernel/modules being built?
> >
> > >
> > > > support as many hardware as possible, pahole generated BTF for all
> > > > these modules, that could increase the size of the ISO image, so I
> > > > wonder if I could disable modules BTF only but keep vmlinux BTF, or
> > > > maybe selectively enable BTF for some modules, but not other module=
s?
> > > >
> > > > I found this discussion [0] making DEBUG_INFO_BTF_MODULES selectabl=
e
> > > > independently. I am still not sure how to disable modules BTF, I tr=
ied
> > > > make menuconfig, still not obvious to me how to disable
> > > > DEBUG_INFO_BTF_MODULES
> > >
> > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, but see
> > > above, I don't think the BTF is a problem here, it's not stripping ou=
t
> > > DWARF.

I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
in .config, but make oldconfig always flip it back to y, if I run make
bzImage without make oldconfig, it will have "Restart config..."
like below and n  flipped to y again when examining the .config

# make bzImage

 SYNC    include/config/auto.conf.cmd
*
* Restart config...
*

>
> strip -g ? I don't know how this is normally done in Linux distros.
>
> > >
> > > >
> > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvwuCJL=
jesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b294ec2=
d
> > > >
> > > > Thanks!
> > > >
