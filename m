Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0A3939D4
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283284; cv=pass; b=UkgcJ0ZLcD91ddi7PDvfOtvlM2wu6hqJU9d8Vtx6HtDdhsuFMWbBUyJvfnYb1lqkKRnbz57Uz4qxCEUgyxKguzkyv00P2vH6pbvHc4kheXjoFRBTQo/sxMCGZMMKE0qL8OIFFYhNVZjXjtLyr8chJKVkMtrxxyPcFf6B91a7OkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283284; c=relaxed/simple;
	bh=H9TJNHkisUEr4z39rBi90p8f80JBCtp4uFnDx2T9EUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOQhlCu+TaKVQVn8iR/XJXgtJwTe7EnAopB5QTCSxvEFgZ4zDJKqLehJfg2s/XtIyGWxANwgHDhvDxNuaKY7v2Mt3VZ3liuPjYyy0oQHMzHXZiVdoxMjuY9P+27uPOmHwDOXL8nQI6JSDUQ6Jn5o88qljV5JSytr5cmrBvY/6kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLFi+UPk; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLFi+UPk"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b884cb1e717so271444666b.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 01:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770283282; cv=none;
        d=google.com; s=arc-20240605;
        b=TdppezOcuB/VHeVvzdH7OV1G1AkX6dMR3n3m3yDVkW1e2vj1UXnKK9BaSyE76tn2QP
         jaOKVKh0tsHT8Vcx54K3eE6vaE3HuTXQjWQAsSVRpx4CvS8aS/EKqpyUmD9wWts0IoYh
         mqzIZ3g2GWG3bF2Mg1/XDWgyD/YMFiYoZy45zkxP3mcowcb0AdlVz15BENskaPGaUvxu
         Xjh6M+gWMGZdDWwu++Rfd8Z7OP/GP4ND7anJfuJe0aapzEAgAN80fZiJl8V/yYVacIB1
         vm6cPgVuprfRoCYNd7sTAyB26poOafFM72IAVYv0TdIAwGouKnLASPTtkhTYse4QQfLU
         KWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IalgGCN2Gqp+8rAz+6lD8MM8rro1ne0RtIUJXyB5u2c=;
        fh=CoNpXdpd4TqWoVfk55xEDTQ0hn1HhSHvORSz3HfzkcQ=;
        b=cB1e6yEPdYcRYBJXiB5R2vhMSqYWNPEz4Bp/fOdd/9cfyXo5hCCh0ZPzyNWHOgCkKy
         lIuxI8EOB+Xe56lVLl4RVZOHIjA/XgVW+KeA/oy8izURwExVQ160iAcgkZgEBICAy0aC
         0CF/VnjOUjBPUCS8f05fhRvAn4ihDdaP2mO9Tj7IGAh4VxmEuQ/nq6Es1e/X1nP3KrM9
         9K1JPxXVeCEM+uxl/gScKDPYHMAvfczeJAOn6zS/TglKwz4bBt8k7AbGMjGkaOFl2UJC
         dMhOMZWi+d6f07hmnv7zwsst/yhfofrN7XWPpuqIKG7UU0FShLD+J1HU3FMaa8eMnUHe
         jzQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770283282; x=1770888082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IalgGCN2Gqp+8rAz+6lD8MM8rro1ne0RtIUJXyB5u2c=;
        b=aLFi+UPkU/J1L8MI4XywYY6RUA673hLsPtAsH7MkE6SIEIMe2fMjl2oTdhb0SyNEh/
         TPI+KGVRxKBHeU7isX9hSVdCXOds5aV+MkOJ4zfSl2E1Nxi1riy9Bg6eANse7IIQMxx9
         3M6/OpXHy8erDw3isR4Tp18f5FI1fR06teutGpuQGmXQyojcU93udewR0XVh2/eiRP2H
         odvMUONSBcbbjH4q/3dsMOWUPQ4ZQE2cbROjms0F9isuFSoe0CxUC+jrVdH0LMkhvUpK
         P6tCXmj+SrTc10OnUNPoFYjPql4y/3fPJl5aL0+62G9HycwRMbSSWhbJUm6UbYVsl4xm
         z+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770283282; x=1770888082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IalgGCN2Gqp+8rAz+6lD8MM8rro1ne0RtIUJXyB5u2c=;
        b=bnii3Wu5bBi3J9pVemTe0LB3VOPcBjgvHGNIlr2fG3EqkglnCRVZETgaSPCv2i74Jr
         M3aycuX9ZL9nGMFxXUII4Gdnk8gdh2l9X6OF6C7Rji6VKorHlfp0ipMuP+wVsojl5+dp
         +/l1fVKdmUrMeh3T2PZFJBiu9QXcX3WlWUMmeyg1re2qFAAdqZJJLRee9AZtsuiSB/8J
         KUK9SCIHYlrrCF5iQeA9IJfeh3Fti4ZgboBSutqTPMfVljZ756fSDh45tQOErmI9Uf2Y
         a4uSfsbQt73Zs5ZuIEfDjMiN8gEcJWBs1lFbak1DafShFeCdYWE5XDpq8BYQ8Iuh3rTg
         ljUA==
X-Forwarded-Encrypted: i=1; AJvYcCXP2s96qy8Wwy39Y6oFgbnztdgXEclgVVUdpbvXH/uT9iukQ6NzhXadcvfvOubtXludsTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHOGXOApSlfIkupU/q8GcJWBFcGD7/L0aJVpvxBG0WD99TawE
	Bm3ub/DgIsBss6nh/aWC2lS/IvB+0uQ/x464Q0d3KsMI8YDTLdA3QTIpnv5iRLnUvM6lrd5XV/5
	h9hdKrej9tJtoT5ySPrkAfQiFwAkvV4I=
X-Gm-Gg: AZuq6aL6ORk8EX8HzL58z7OCG45Tj1TyNBV305WohS2MFxHvGdrhLw9MfuVlCDrAKPN
	abEI6FfzX26UFiO7aRDWcEVJ5iGNF873D/ZE2VNopOpxj+YMwQTvGkrHfjFsFeo/4Ny3wtkEur6
	ktCoTft90ND2saB3HbWjGHV8MUUFJivLebia/I/a57mOxXtyJUfLbB9OxOxKOfBpfIEBc2WDR/H
	KWK8C44q0h/8WnibFijsV1UtNTQ8y0N2GkkSxKN8vLcizHhODJHytkLvRbWFw7I/bsUuALf
X-Received: by 2002:a17:907:94c2:b0:b88:3877:d922 with SMTP id
 a640c23a62f3a-b8ebaebf0b0mr159376266b.10.1770283281676; Thu, 05 Feb 2026
 01:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
In-Reply-To: <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 5 Feb 2026 17:21:09 +0800
X-Gm-Features: AZwV_QgyCP5qHv6wmrjDl43TBmC7uiqpMqCxslLuXWGhiI-yrqFKJcJ-V81-X70
Message-ID: <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > >
> > > > Testing revealed that sorting within resolve_btfids introduces issu=
es with
> > > > btf__dedup. Therefore, I plan to move the sorting logic directly in=
to
> > > > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > > > invoked by pahole. However, it means that we need a newer pahole
> > > > version.
> > >
> > > Sorting isn't a requirement just something I wanted to bring up. If i=
t's
> > > too complex and doesn't achieve much benefit then let's not do it.
> > >
> > > My worry is because "cat trace" takes quite a long time just reading =
the
> > > BTF arguments. I'm worried it will just get worse with enums as well.
> > >
> > > I have trace-cmd reading BTF now (just haven't officially released it=
) and
> > > doing an extract and reading the trace.dat file is much faster than r=
eading
> > > the trace file with arguments. I'll need to implement the enum logic =
too in
> > > libtraceevent.
> >
> > If you mean to do pretty printing of the trace in user space then +1 fr=
om me.
> >
> > I don't like sorting enums either in resolve_btfid, pahole or kernel.
> > Sorted BTF by name was ok, since it doesn't change original semantics.
> > While sorting enums by value gets us to the grey zone where
> > the sequence of enum names in vmlinux.h becomes different than in dwarf=
.
>
> Thanks, I agreed.
>
> >
> > Also id->name mapping in general is not precise.
> > There is no requirement for enums to be unique.
> > Just grabbing the first one:
> > ATA_PIO0 =3D 1,
> > ATA_PIO1 =3D 3,
> > ATA_PIO2 =3D 7,
> > ATA_UDMA0 =3D 1,
> > ATA_UDMA1 =3D 3,
> > ATA_UDMA2 =3D 7,
> > ATA_ID_CYLS =3D 1,
> > ATA_ID_HEADS =3D 3,
> > SCR_ERROR =3D 1,
> > SCR_CONTROL =3D 2,
> > SCR_ACTIVE =3D 3,
> >
> > All these names are part of the same enum type.
> > Which one to print? First one?

Another option is to print all matching entries, incurring increased
overhead and extended trace log length. However, I prefer printing
the first matching entry, though it might be inaccurate in rare cases.

>
> I think these cases are not very common and printing the first
> one would be helpful enough, and we can add documentation
> notes in ftrace to guide users.
>
> >
> > another example:
> > enum {
> >         BPF_LOCAL_STORAGE_GET_F_CREATE =3D 1,
> >         BPF_SK_STORAGE_GET_F_CREATE =3D 1,
> > };
> >
> > and another:
> > enum {
> >         BPF_SKB_TSTAMP_UNSPEC =3D 0,
> >         BPF_SKB_TSTAMP_DELIVERY_MONO =3D 1,
> >         BPF_SKB_CLOCK_REALTIME =3D 0,
> >         BPF_SKB_CLOCK_MONOTONIC =3D 1,
> >         BPF_SKB_CLOCK_TAI =3D 2,
> > };
> >
> > I'd rather not print any and keep it integer only.
> >
> > pw-bot: cr
