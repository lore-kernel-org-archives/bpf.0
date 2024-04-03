Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8715530D
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174185; cv=none; b=ZIMH6PkEudLy+roLnvLh9V3A89w7FVhjQSCmALDpgJKa3ryctZIPcEIt4UOVSlNOTwJZK6+fuh2x7itUnwvwf7066EF+d9TO3m7jJ3InPM68jYpzRJTKPOvbsU+zECKZqwrFqJ+c9TsCqZE4jOI9/OACZ5yQS8sHOqRU3h7rDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174185; c=relaxed/simple;
	bh=7ul+O4bDE7u9ga3ov2YOFdCJdiSc0H5q0/d7thqSRm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REbU9ZdCBbH4K4A7lslPZg3VBCTiuqsbzTDfbzNjLXPzjIN0WI1pdCP5tlfXY04PdwgSJwOP5OjOlkBcNLMbIRkOAzs6w5CvDR0hKqmbhAvrbYyvnLhdAGJJJn5b65NFsqV6xqPtVUYIOSwd8C3rSCwJBF+T2r7L2OXBNbSmhTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na+2Zrrl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na+2Zrrl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2232e30f4so1558235ad.2
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174183; x=1712778983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td5+wqslQaCTuDqScsz+f5fZR/MxVPYcsVscqAXaCxQ=;
        b=Na+2ZrrlhGIpTbS39c1ccCu6cQH0JGtj+dnwjwqMGz7BGcMWPc3/jaxuH7zM7yWjQ2
         aUablaV+4xrLJeJRxcT1SWLQGiR8qiHlktc/jb9FKHFoK5ks7LPfClzq4INbtRc6OQ3r
         lYhjZ4s41ZPGRontgmJivIaRPK3hrQ7WSxRSqweFCOFkbB7yt27ZGxH8DP6+0YfzBKBk
         Alxxdcnt4A2bxMCy3HZtUfnPKudpc13+499tgZAZa/Iwjs4keJSelgHRV2quFcsQb9e6
         3uOTKG+AOj38dYoVnaU24Ijn7TuLLj4iH7U+ogs66q2ZaKMTD6VJ1Up8QIAjqw8t9/rT
         9rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174183; x=1712778983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Td5+wqslQaCTuDqScsz+f5fZR/MxVPYcsVscqAXaCxQ=;
        b=DMY7qKMJTt+7ObGsEUheREQrelNs2pcIS1NCzyt3wxam4Te238QerKM6cENQx5dGOe
         R2KeWLC+A6atO/5kwHT/vI3EUssM9fzGpgjHCObiaSXgiH73Sr+h2NyMUiRrJ8l5YiO5
         hD10Qpqr38veAm70EOXxuQXj02xVetNGdOk1cTvrPHn1FybXJaw6MjB2WgIoQ2Z5+Iat
         xyj7a1I4zrVVOi/fMkampHB1GHnmcfDuiLjKL42Zir4dONMRAbyXrud6+DtcCbI53pU7
         F0W4uD3GG2VG7loyn8RYuA4fAEEs4HYEB5PCTwRbjYK5DRo0KJNZ6n/UuUKK93YX2Fs+
         mGvQ==
X-Gm-Message-State: AOJu0YyWkbUfks9evU4gO71hZM7+ZY5u2xBYEdeidtTAKaOLXkop4x+l
	pu9YttziCf47INH/m4UydcSlkYeGI4WJCSQrLloZOKsQtVpOkfEdvhL9ypJdquO+XwH0L7XBvHj
	vrUkkmJ1zvFtB0RCFU/elhHapLBu70E6BO8o=
X-Google-Smtp-Source: AGHT+IH1gBCV3QU8BPUZzhcpvcObJ1QduDx8kMRgovGcZlF0ZxlA19a8pL8weDk23nTqyVUE8YeioXmz/TQHuVU8LGM=
X-Received: by 2002:a17:902:e88d:b0:1e2:8eee:ca5a with SMTP id
 w13-20020a170902e88d00b001e28eeeca5amr251467plg.52.1712174183233; Wed, 03 Apr
 2024 12:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
 <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
 <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com>
 <CAEf4BzbKz2xCK6jqVnzA4uWnZKx+UteNPcZ3zFtyYe885stnLA@mail.gmail.com> <CAK3+h2wkbuMrcPg6E7Gh0AxbGiSKNGJ6RX=psxtBP6k9W0L6PQ@mail.gmail.com>
In-Reply-To: <CAK3+h2wkbuMrcPg6E7Gh0AxbGiSKNGJ6RX=psxtBP6k9W0L6PQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 12:56:10 -0700
Message-ID: <CAEf4BzYY09WnHsz3peLYMy0=A3JkivV-zxD2GjmGrQWLbhW7mQ@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:35=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.mc.li@gmail=
.com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.mc.li@g=
mail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Once I enabled the open source firewall IPfire kernel 6.6.15
> > > > > DEBUG_INFO_BTF, the IPfire ISO image is increased from about 450M=
B to
> > > > > about 1.5GB, I suspect because IPfire has many driver modules to
> > > >
> > > > BTF can't be that big. I think you just get all the DWARF for modul=
es
> > > > and vmlinux itself. DWARF is necessary to generate BTF during the
> > > > build time, but it can be stripped out afterwards, leaving just (mu=
ch
> > > > smaller) BTF intact.
> > >
> > > ok good to hear that :).  I am new to this, how to strip
> > > kernel/modules DWARF after kernel/modules being built?
> > >
> > > >
> > > > > support as many hardware as possible, pahole generated BTF for al=
l
> > > > > these modules, that could increase the size of the ISO image, so =
I
> > > > > wonder if I could disable modules BTF only but keep vmlinux BTF, =
or
> > > > > maybe selectively enable BTF for some modules, but not other modu=
les?
> > > > >
> > > > > I found this discussion [0] making DEBUG_INFO_BTF_MODULES selecta=
ble
> > > > > independently. I am still not sure how to disable modules BTF, I =
tried
> > > > > make menuconfig, still not obvious to me how to disable
> > > > > DEBUG_INFO_BTF_MODULES
> > > >
> > > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, but see
> > > > above, I don't think the BTF is a problem here, it's not stripping =
out
> > > > DWARF.
>
> I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
> CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
> in .config, but make oldconfig always flip it back to y, if I run make
> bzImage without make oldconfig, it will have "Restart config..."
> like below and n  flipped to y again when examining the .config

Maybe CONFIG_MODULE_ALLOW_BTF_MISMATCH is auto-selecting it, try
turning both off.

>
> # make bzImage
>
>  SYNC    include/config/auto.conf.cmd
> *
> * Restart config...
> *
>
> >
> > strip -g ? I don't know how this is normally done in Linux distros.
> >
> > > >
> > > > >
> > > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvwuC=
JLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b294e=
c2d
> > > > >
> > > > > Thanks!
> > > > >
