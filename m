Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB1242B747
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306977; cv=pass; b=JqnPart9WwKQ2y/cvUlBaCCFapKpwkwjDN4148ylA6vE8tw0CXabn77TRiSysC4zaPOWJaJ4WJGxLymsALRYc8Inwf/wjcDnh8pqwmeH6NJEAUXBSTlqb/70RQIkYACDmFK2KVBCsWHu5hQ/+k837i2XmdsyC48suagwuwH7d54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306977; c=relaxed/simple;
	bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEIqOg0m460SLOKV4Fta4tWMEPa9Jdm23tw4YZmoXFUOoXs+DI1OIK7aj8gmpCF8KUT7pU565tExSC+phthfQ3PGKmB3J4jOekdD3JzE7450lyDb3+4GfShrgbXTfwiQWQWAuHxdoUuT7dupiT+NW9ej3g2FMa6b1i3SCziNyS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1dKpPbb; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1dKpPbb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43626796202so514919f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 07:56:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770306976; cv=none;
        d=google.com; s=arc-20240605;
        b=K946WeiA0nHCFLx6GdsGNwrDhU3FibRfrhmcpAB7Du9Q5+2XKkSkhs5J+p1CiKvM6i
         LO7G8JywSFoKsoo+6VVD0vpxv2vch3Ic/Un/ZnIGQWlZiRC4plawhTgTmsqYECYwUU6Z
         4MRRr8itd1DZ4LGq17EnSFmVd2Qy9H6PSlJuNy+UJX0w+IyROoJHGQDMplXAHppa4rd6
         XPrIkwHXOxSLyy10Bma0MyjB5L2zgy15jOTRgv3bHqwJ8umMPvAjTOe1eMm5Vqnsgnhj
         Ayx7aqRgarXQl0UDNQoIwZYrx2Rjmamq1K9v6Gb6dZUSGWmAOaBZaj3p6JpWr4cOEJNB
         ILmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
        fh=qERPB0d/bMCPvMdDfltOOr0kAvglu0YmGZCZQjCLQGs=;
        b=EbGx9q8IGbVMEWJMN77bDSQCuJD0psB3L1oBpYZU0GhL7xV7LdJIIlXGxEQiinYfhr
         /cj1ojWSMOyHawBalvgTKh8r5sxQQS7jvKZt3My41HxQQVJA+H+5PNYW5UdXIwQlOQ3t
         S6IGGHkvGC6pcCEMCYgnLpv5Kfu/WLA+1xxcpommiEl77LGNBwn6KCc511Xm7jj5Bns6
         cMRRPIUIzLMazWq9zacKDiU+uuJVsPT3Wg6T8lLtCpZv0ixBWlNj6c/y1zHszOj1T19b
         bcBZWEAWqdH9W0xw6KhhuYOorUEaHWeekH8O9Op/kM1kcHI2hBV0kCUGhhoO5ApjY4/B
         qwYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770306976; x=1770911776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
        b=e1dKpPbbuYZ4qRc9IZBQbEBh/NLfIRwGTLQvagt1u6U+6piLSFDf2upy6zjr0Q2Flk
         MRAP66k+nquUtvOe4Wqzt2eo0sh5ZM1MtvjuPbi2ACLhLLJ8we9nABLj7C6Mh89kReIj
         pN+9fN34zQAOStgxSQjyhAyE/V91L8nqP/7fboBJ/8LZVhJBK4PI4SNW4K46L3/d8ACD
         S40lPjlgeohCAct3ywMtuem6d80loW5XKf6aPJsHT2py7C8LufyA++gA7Tecmh5I9nCr
         CsY3wGpEAID9VRMTuKpWEWKnEylhOD6eRyivlSvtZo02Tk6zhczaahqaz29Ei1Sa+lwg
         ccSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306976; x=1770911776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
        b=FQcB6c1x+Z1I25wRTbnxd8Hhlpn8pKvJ3M+5xXpMMKmoRKyxef5ojxrqseYLZDsqGX
         XYJEhp9qPlP0Lj9Z6t+FTDwxb4vtApPMKirUtIMcfyxcOu+wJ7zFqxUifGmRv/CUskfH
         FJmiqbKgzRFQ8uP4bBfeRCKMmvEVn3PI1yZQslixBctQei6IKwN2h0HggWltI45pHxxy
         ksY70jor1mjEFeQvrowCdldW+gPrRCpJ5/+QJdsHGBGPMdbk/xWHGuw1pUt4bvEbgktH
         sM2V7MXCJ2Chu28ot7/5K5IQaF0kwUvRZFgJkCzNh7TmeUIygKXpqCZhAZk+WNiN48Ey
         pCkw==
X-Forwarded-Encrypted: i=1; AJvYcCWY4nvCOFZYsvCFKGJ1acnFki15oa9R5kMxKZ7OyrFjjxs8EerHbAX+ZVDlM+AtOOaZDjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2iS5wV++IL30MHT75rAPr5TCGdEstslgVBbktdaM4c0+c6ni
	hGCkNurXpyAY1XM1XN10RAe3X+1Km6PaCAbF0S3/5RM9uNvXZ27OUYMCpQ82i9JCkZJrlzfl5Q9
	9aFOB5pB43jlWJllmNG1/lLgtfyLslYU=
X-Gm-Gg: AZuq6aJcqU8Jx6VMWLY6p16wnFnAT4v4nYmY9GmN//yioOCZrbdxkrQSOyE+1Bejh+Y
	OlGFvCAGAHE+uivUTWGx0tL37HIVxxEbGWqvoOSLK+WkWvR9vIAiDCFm+ps3UnhPvM+pkIxNbTd
	PdGo99O41u3AoeE9PYJxFy2Dz5RKY+ABgIHND5VZf+agGly8S7VF1q5Aie8bNqR28Xiurha7Su8
	2gOZhh0lfaHR5GlG3KBaiYndk/rdqLzkjTDpUVZhAU8Ku0PpC8/iLSgXp9sgz2ta+U5/Vx5R1n1
	ag9S9GiUQnF2ociHpcrc02h5PFHM/z5vqO/BECJy7Vor4WEyRlHDUIrhWC7nfvwCPaeAKOEG
X-Received: by 2002:a05:6000:2207:b0:431:3a5:d9c1 with SMTP id
 ffacd0b85a97d-4361805500amr9966917f8f.30.1770306975650; Thu, 05 Feb 2026
 07:56:15 -0800 (PST)
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
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com> <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
In-Reply-To: <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 07:56:04 -0800
X-Gm-Features: AZwV_QihuuP3z2J76lmeYSQjSgbNK5taZrRT9R4w6RLFqNKBj9OV5WRgklhng0I
Message-ID: <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > > >
> > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > >
> > > > > Testing revealed that sorting within resolve_btfids introduces is=
sues with
> > > > > btf__dedup. Therefore, I plan to move the sorting logic directly =
into
> > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, which ar=
e
> > > > > invoked by pahole. However, it means that we need a newer pahole
> > > > > version.
> > > >
> > > > Sorting isn't a requirement just something I wanted to bring up. If=
 it's
> > > > too complex and doesn't achieve much benefit then let's not do it.
> > > >
> > > > My worry is because "cat trace" takes quite a long time just readin=
g the
> > > > BTF arguments. I'm worried it will just get worse with enums as wel=
l.
> > > >
> > > > I have trace-cmd reading BTF now (just haven't officially released =
it) and
> > > > doing an extract and reading the trace.dat file is much faster than=
 reading
> > > > the trace file with arguments. I'll need to implement the enum logi=
c too in
> > > > libtraceevent.
> > >
> > > If you mean to do pretty printing of the trace in user space then +1 =
from me.
> > >
> > > I don't like sorting enums either in resolve_btfid, pahole or kernel.
> > > Sorted BTF by name was ok, since it doesn't change original semantics=
.
> > > While sorting enums by value gets us to the grey zone where
> > > the sequence of enum names in vmlinux.h becomes different than in dwa=
rf.
> >
> > Thanks, I agreed.
> >
> > >
> > > Also id->name mapping in general is not precise.
> > > There is no requirement for enums to be unique.
> > > Just grabbing the first one:
> > > ATA_PIO0 =3D 1,
> > > ATA_PIO1 =3D 3,
> > > ATA_PIO2 =3D 7,
> > > ATA_UDMA0 =3D 1,
> > > ATA_UDMA1 =3D 3,
> > > ATA_UDMA2 =3D 7,
> > > ATA_ID_CYLS =3D 1,
> > > ATA_ID_HEADS =3D 3,
> > > SCR_ERROR =3D 1,
> > > SCR_CONTROL =3D 2,
> > > SCR_ACTIVE =3D 3,
> > >
> > > All these names are part of the same enum type.
> > > Which one to print? First one?
>
> Another option is to print all matching entries, incurring increased
> overhead and extended trace log length. However, I prefer printing
> the first matching entry, though it might be inaccurate in rare cases.

I disagree. It's not rare.
I wouldn't print anything. Let user space deal with it.
