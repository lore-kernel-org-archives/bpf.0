Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C655258CDF
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770556099; cv=pass; b=mfEZeA/h14GRWn7DcbCAAw1valaycXE1HJ4gNfF2Ok1wQhHBU5oIeC/tSx9vBHioxZD6zq3XrKRDyhvMU0khdzPhCqeXq2S+CN/GtD1Hy/63MIn8MVZ7smoK7GGjWc6Tqci6WR0Y+T8tpYVec58GgltPc/dxckUei3atdINeYVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770556099; c=relaxed/simple;
	bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxG6evySKfTlTjU4oDoTQJctEkOviOm2dxUTJOwEOZNiS5E/5FLzH/UyXoGkzE28K/YDaKeWrRE3sAoCKqfEy7Rxa1EOx0GisU/JSexeT5t2eTxA64AcPrEGmCAmLNJId3+pSER9DHvhWkOtf2kbbsweEbIkBeiNz/JOvAY8Q7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjY60c9Z; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjY60c9Z"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b883787268fso329045366b.3
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 05:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770556098; cv=none;
        d=google.com; s=arc-20240605;
        b=huNbMulRYve422EWF6BhVXghCjHfkwhWbFEOfQc29wztCRnouhEYldzmbOwRZT469t
         FK7ARjiPTo4wLPVqZWD/y8IVG0X3VkL+Eu6d/OhQkH0uCvyS3bC/k4zaFvGUl8GSzGXr
         p2MqolU1OkCsP9VuyqlrFTszG3h+5p/rSgEkXWgzw55bwgeF4jbRoPAWNqubc5cTXh1H
         O7hYC+vFwd9v0eC/XlNHtTu9g/gnqPriyJSL/HhvtTx5W179YSRLFkxMljup91Hhmkp6
         Tr+/ZzQuABmbZppOpfIkABWFAM2UL54xmPNMFH91QHh0a8BTwI1gp0BnzyipSLJFhtk6
         hw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
        fh=GcP14/x+bZSA8+McS/12UjdB695wfgK2p7IOu2/hCvg=;
        b=N+SJKOuaXI1ehKKH4fVaXry7D38TmajJ23OKyNlR0LZT6tJgz1gaqV0aFdvFsYzo6F
         HpNgc4XGw8BLS3TdLqs98zQXtPsgKKN5jrSoU1WEoei3txO7Ivj6EJc2nIfRQEMk/fr4
         xMWLNrdqaeHepQbqStLEt03aDh2qz5BlLmL4PzXo4UlbY6FxV0k20aAsxoC3i07sbVkV
         ZFnmr6fahkBKl3Cw3VCVGos48+Vl2fRq6UaEGMII3RruxSOybwlYR2VPK2H2BPSCDwL7
         Ns7KpVsChWEjgYFPcgpBqK61oIYlg7zewcdsTnpX5UOBbJ2VUEyrfRemkSiX1c5ViuFn
         5JRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770556098; x=1771160898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
        b=XjY60c9ZWHYsyEZIxYugWU9bCDqy5Iv14GgRP1DdykTLRU6Nd3qRZCkHKz0jnoFLcL
         m6X8uGAWNE1dgSZn0X0lM3CwSund7SQzdHBZRoNJx7EV6n4VY/5cRZ5ApvzD2gODItWj
         pKXxCOKkQa/YliZK6/6IDRrUMV/fwqKL3p8bIJ/xH7ycPCzxTdvOUBHFC4K2EavDGnFP
         x0r+dz7qN9MTSYjQujvsG4UQ7uQ6iyxpkQ5lxcjsBOZ1Pw0Yr/a6sn/7qZp0aOWHmRvo
         +BXrKbTN9oWB0TDGTvhDZl8El7ayfdnmUhe0OWFZBUVe31F3aHdobsVJ9dxiOkHZnycE
         NVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770556098; x=1771160898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
        b=DLcxLz0v0bOLmzFn5gxqGeGUa9jJapzl/KdP2x7hKoSpPez13V66/aYyAb9tguMWXl
         7ymbOTZcrmgSKgGgV4trlhz5bBzM2cAjtRCjXO/1SZGOCi7ohK2WGr7Jrds/RQMGXUNH
         i+N0w9P8nddvAyZRF/ww9UEpLHW/vJ6EWT0vRqHkV4kkNS31dtntuxSPLNt/cVR9VkjN
         BvZhJPqcUc8BVMxjULCDZd0ah7QezZpgQjQCYgh+F+/Lb2ENjGARm9ms9SkW2LRpdHjB
         stg98OY4vSB3XStdSJ0D2FWOt+eOzzo35KltD0jVEjpXgwT1UdguK3XhjvfgWyQUpO44
         v8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPpyW3pXIkh9xWMlEAw76Xv/8kN2aLtDYRSLs0aO2VPOO5oo9dvqjhbDXJZytOV2mqOUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bj+xkzABedIOFbOHzIeX5JlCXiLW5aOifBaCjxJ2OPoplPD7
	wB/l02aZSbFnmyeZk/5f/haBnAnwLxx2UTTUxoasooQfpi3qp7tX7r+rKyzYL2iCW6/szYiJrNY
	IZ0vhgCgPL3XnxEYqizKFD2O+kuv+sSM=
X-Gm-Gg: AZuq6aIpaHtkWSGa18tjYAAr+/BSCU6LiPwiQ8WMPhyOeYKsnn8U/9H3PPdtqHjZDcZ
	sHcPegx/C0mTZVpM+3cYnP15F+m8qVZWYJnh/c8sQ9RqP7GcCYr+vmx6Y+f8RW7uitQNrt2N7eD
	88ym9dCU5H4auvO8MN1a+h8gTnYoMIQ1H3nwYrWEsWlSEPTiL/UtsRN98Zlt0THEGbUC8fISw7A
	oF+uYAuUw32lGWLE5HqLK+1SCSFtFIyGk4vnebfal5CaBLwWL/FOsuFnf1PcBKrbgCOUnAc
X-Received: by 2002:a17:907:2daa:b0:b8a:f9d7:1aec with SMTP id
 a640c23a62f3a-b8edf14ca69mr505910466b.10.1770556097276; Sun, 08 Feb 2026
 05:08:17 -0800 (PST)
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
 <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
 <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
 <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com> <CAADnVQKrAcSzTYbSEHkWiWS0Ot5wAQ8_Q_v6-J=6=O4MxLpbpQ@mail.gmail.com>
In-Reply-To: <CAADnVQKrAcSzTYbSEHkWiWS0Ot5wAQ8_Q_v6-J=6=O4MxLpbpQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 8 Feb 2026 21:08:06 +0800
X-Gm-Features: AZwV_Qieeug1LxlBhiGFK7rwN1TwVDWOJW9C6yLIevkRt3nhVeuKkqX9xXTmh2g
Message-ID: <CAErzpmv547nBOT95ZYv6KLD6esVUKY4he=EKiWvmuVPXZfSaYA@mail.gmail.com>
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

On Sat, Feb 7, 2026 at 12:05=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 5, 2026 at 8:10=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Thu, Feb 5, 2026 at 11:56=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gma=
il.com> wrote:
> > > >
> > > > On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@=
goodmis.org> wrote:
> > > > > > >
> > > > > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > > > > >
> > > > > > > > Testing revealed that sorting within resolve_btfids introdu=
ces issues with
> > > > > > > > btf__dedup. Therefore, I plan to move the sorting logic dir=
ectly into
> > > > > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, wh=
ich are
> > > > > > > > invoked by pahole. However, it means that we need a newer p=
ahole
> > > > > > > > version.
> > > > > > >
> > > > > > > Sorting isn't a requirement just something I wanted to bring =
up. If it's
> > > > > > > too complex and doesn't achieve much benefit then let's not d=
o it.
> > > > > > >
> > > > > > > My worry is because "cat trace" takes quite a long time just =
reading the
> > > > > > > BTF arguments. I'm worried it will just get worse with enums =
as well.
> > > > > > >
> > > > > > > I have trace-cmd reading BTF now (just haven't officially rel=
eased it) and
> > > > > > > doing an extract and reading the trace.dat file is much faste=
r than reading
> > > > > > > the trace file with arguments. I'll need to implement the enu=
m logic too in
> > > > > > > libtraceevent.
> > > > > >
> > > > > > If you mean to do pretty printing of the trace in user space th=
en +1 from me.
> > > > > >
> > > > > > I don't like sorting enums either in resolve_btfid, pahole or k=
ernel.
> > > > > > Sorted BTF by name was ok, since it doesn't change original sem=
antics.
> > > > > > While sorting enums by value gets us to the grey zone where
> > > > > > the sequence of enum names in vmlinux.h becomes different than =
in dwarf.
> > > > >
> > > > > Thanks, I agreed.
> > > > >
> > > > > >
> > > > > > Also id->name mapping in general is not precise.
> > > > > > There is no requirement for enums to be unique.
> > > > > > Just grabbing the first one:
> > > > > > ATA_PIO0 =3D 1,
> > > > > > ATA_PIO1 =3D 3,
> > > > > > ATA_PIO2 =3D 7,
> > > > > > ATA_UDMA0 =3D 1,
> > > > > > ATA_UDMA1 =3D 3,
> > > > > > ATA_UDMA2 =3D 7,
> > > > > > ATA_ID_CYLS =3D 1,
> > > > > > ATA_ID_HEADS =3D 3,
> > > > > > SCR_ERROR =3D 1,
> > > > > > SCR_CONTROL =3D 2,
> > > > > > SCR_ACTIVE =3D 3,
> > > > > >
> > > > > > All these names are part of the same enum type.
> > > > > > Which one to print? First one?
> > > >
> > > > Another option is to print all matching entries, incurring increase=
d
> > > > overhead and extended trace log length. However, I prefer printing
> > > > the first matching entry, though it might be inaccurate in rare cas=
es.
> > >
> > > I disagree. It's not rare.
> > > I wouldn't print anything. Let user space deal with it.
> >
> > Okay, I will implement this in libtraceevent first. By the way, would t=
he first
> > patch [1] introducing the for_each_enumand for_each_enum64 helper
> > macros be acceptable?
> >
> > [1] https://lore.kernel.org/lkml/20260202111548.3555306-2-dolinux.peng@=
gmail.com/
>
> Just that patch alone? What's the point?
> Refactor for what? Does it read better? No.

Thanks, I see.
