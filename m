Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94B2DC32A
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393907; cv=pass; b=qdbpTeprgeBWNKpJYWuexc07Q31DyTuiM6gLMvoUgrl+XcpFiwxPYG6/4UICIm8T9HsoIEVNqs6kBIYFTq7tu86zA8FJ+J3Unrjn+AlS742YqA4//0Jq8IEMPUfD3X/akpEmXMUlIallrvjhI9LLFK8p1ta7oCnziRDwSnk90jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393907; c=relaxed/simple;
	bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbOOMlrOG0HfBrFIkoPHP9jQJx8GvJlmdjWBBQWf8rjVNSMARjvhkop0S2I8Jm2T4FDF9NvFU61QZ0CagH6krozps9kslc4ADN8Pn3W/glgFfZ5dlCR5BGdcOmbMQmwsioWBvs/ACP69lTWAzDB55ywljxKYVrWAc8jHomGjHKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUQz7tUu; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUQz7tUu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so26806575e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 08:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770393905; cv=none;
        d=google.com; s=arc-20240605;
        b=YvBy9osLJKzfMULd8I3R+l/DpIZL6cIp3xzSjqBDMntoEecYjzyuwyw9Q8nRK+JrL4
         z3X6LPnYimXMu7H7ueExHC7+viwN/N2swEFvSpFCk5VfAlMomZtFB9X6PzKsPYC8wgSQ
         gk3cVq05HMycb4htsluQukcDm0vcRT+WNtsfnf1SvRhwCzB0SwzuKBub+Fn5MJdvuk+P
         a7rZ84hWGARx/YAoPq/Ud/l8by922ofpw3If0VmfemLKBVAvJAKOxATcFhWfHj1NaeoW
         fohS+fPl7ZWYfIZR/fr4JSOV/qW3Ovi6rex54FC97C84g4i3Uv1xoawLeGks1zWZCPmF
         1+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
        fh=4XHimgBhUuo71VOGhN2DULKwF0WFMnyK9mjFhJzwoN8=;
        b=Go2Yi2QjRK3Of3dqhmFmTXEZYwvEtLNPGDYsLh3wRCYFvW/y39jiDfpl+XfeXubiHE
         nQI9p45G5gfeIRtRE96nwAom8vYy0GwT2KTq6G4cUGlt3BIxZV4lfCn1/2+Lrb8jEcQo
         pySAlYpipikMw+0nrI+GMeweex/kqNhYdDMHd74xJQSpx9vBB3/dYybBu02h1vR2+AxQ
         iBZ1jctIeome8mvqmlQkTA19YshyYBwpwLhC7fIU80TexJ3VKbgo8hkk7rPOHqfgAt/s
         rjXYaXUalVF0Uzzzga96oSr9stiOUBMVsW5hWP5emsUQiZJBP2tpIlJs4FT6GMmvuxMK
         p6oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393905; x=1770998705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
        b=WUQz7tUuC3BzUZBSiSNXzjiHf/QhZoz70WSbC5QNKjNRYgjUVkM79P/DjYKSwJqt9O
         QO5peGz+feW0mIKTE/lP0jThvvr4exeIe/SZBQMcAImWnB+KK9QBy54DJ1OxH6hGNgu6
         mPhsa8oxNd1c3eVs8x7Ewul7ph1rmVJypOwtLPaTtdZaFW1GNXJTGqCknj9wt8+9bVIB
         RHeIZP1axnHN87yM8bjz7GuswLbjHHV/bm6xz/Q0NPglbwyDMi87Z/vRvHYbYqC9tvo/
         +AJ6Q9ONqomIu0lw90haB7X1YpiOJnxB/qFu4m6vWk4qgckUPBTt9mLs67Il7rC1xjdb
         ttmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393905; x=1770998705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
        b=oJxZwMQlDS9oae/UCprmAcdl8iy8fcKbGAV7FnenMY+3LsxYlKiDtmqvz3N+Bj1OAH
         kTIGZiWgMwuung13luyUYkH+kcX/NnSsrflE8GLLwHjzMt7spBvNDrxZ9C+3wZbyLiCm
         zRMvRZKmc8eln/OVBizi0ek5wIo73xcBmFYgiH5gavkYUMMJJar1u5R1xIQtMv2mjwNn
         0SNbY3vOloHdNtv/GYW0zzOkxPP+SnInNvO/+IRg02YAMfeJoL3LlGYjuI5MBFk5EaVd
         oIq+Qf1sTVHwPQapafXTb694jwGX2YBw4LsvXlfE+msITZyc4Yn8d7XWDpLb5OEsk7Cp
         CnSA==
X-Forwarded-Encrypted: i=1; AJvYcCUZO8rTFX3uBUpnq6G20FyEPP0MqYH65kHlkDZ9TZbsj8XBVlACGq3uSmDXmG2LgYpH8GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBIsndkuPK7tRWPTDwssOQjUGaZPb+JRGntBUPMa1BvHh+D/A
	iVykQBs3qgIxmDlBD9pTA93s91O98+IvXZKzcO4oCisTF6vKGUr1d9hI0HaMjyoTEMAKCXKcQ9/
	nM/RnSLHvYFFBq+nBYeV2FanGggqSbZg=
X-Gm-Gg: AZuq6aKuzlAxkrnaicAUvQQvbx2hqaEnMPCEIx7tKjj3jjSeEulBDpcDNax2BBYLL4J
	7cDW4qn1+ZMScK4irpip5YBCp+9SRfkbsrMhB4ujHF8g/iD964cRvi3NMzKnNb7il9wJsP73Pna
	1gEkUZxU34n80gczOjj2LVA0AMX+kOFGVg61wUe6gmy4SddgD59xLwDsL2AZlPZ5eZoGnT7iqXG
	46tgx/zIhEGcR89p14XjVmEtHcOIfN2GGYcItT6P4MU1GH0VbOkd5+aWnfYZD9jGwDhhQl97vHL
	2EG7ys7fYAvxamyyLtIcPTeUc3FEeh5xXhGxJJWaWuWDxLj9ChJlKtWKzfvj6bwtbHknPaBxvwS
	kqfH85Oram/YET/czK7M3sstk
X-Received: by 2002:a05:600c:548d:b0:480:7162:fa48 with SMTP id
 5b1f17b1804b1-483201ecd90mr50571685e9.13.1770393905153; Fri, 06 Feb 2026
 08:05:05 -0800 (PST)
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
 <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com> <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com>
In-Reply-To: <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 08:04:54 -0800
X-Gm-Features: AZwV_QgRI0gmm_jNdS8JQDVd_GmShLrDbwSVBXnZrnR5RfecCaQcg6USmNhxez4
Message-ID: <CAADnVQKrAcSzTYbSEHkWiWS0Ot5wAQ8_Q_v6-J=6=O4MxLpbpQ@mail.gmail.com>
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

On Thu, Feb 5, 2026 at 8:10=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Thu, Feb 5, 2026 at 11:56=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gmail=
.com> wrote:
> > >
> > > On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@go=
odmis.org> wrote:
> > > > > >
> > > > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > > > >
> > > > > > > Testing revealed that sorting within resolve_btfids introduce=
s issues with
> > > > > > > btf__dedup. Therefore, I plan to move the sorting logic direc=
tly into
> > > > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, whic=
h are
> > > > > > > invoked by pahole. However, it means that we need a newer pah=
ole
> > > > > > > version.
> > > > > >
> > > > > > Sorting isn't a requirement just something I wanted to bring up=
. If it's
> > > > > > too complex and doesn't achieve much benefit then let's not do =
it.
> > > > > >
> > > > > > My worry is because "cat trace" takes quite a long time just re=
ading the
> > > > > > BTF arguments. I'm worried it will just get worse with enums as=
 well.
> > > > > >
> > > > > > I have trace-cmd reading BTF now (just haven't officially relea=
sed it) and
> > > > > > doing an extract and reading the trace.dat file is much faster =
than reading
> > > > > > the trace file with arguments. I'll need to implement the enum =
logic too in
> > > > > > libtraceevent.
> > > > >
> > > > > If you mean to do pretty printing of the trace in user space then=
 +1 from me.
> > > > >
> > > > > I don't like sorting enums either in resolve_btfid, pahole or ker=
nel.
> > > > > Sorted BTF by name was ok, since it doesn't change original seman=
tics.
> > > > > While sorting enums by value gets us to the grey zone where
> > > > > the sequence of enum names in vmlinux.h becomes different than in=
 dwarf.
> > > >
> > > > Thanks, I agreed.
> > > >
> > > > >
> > > > > Also id->name mapping in general is not precise.
> > > > > There is no requirement for enums to be unique.
> > > > > Just grabbing the first one:
> > > > > ATA_PIO0 =3D 1,
> > > > > ATA_PIO1 =3D 3,
> > > > > ATA_PIO2 =3D 7,
> > > > > ATA_UDMA0 =3D 1,
> > > > > ATA_UDMA1 =3D 3,
> > > > > ATA_UDMA2 =3D 7,
> > > > > ATA_ID_CYLS =3D 1,
> > > > > ATA_ID_HEADS =3D 3,
> > > > > SCR_ERROR =3D 1,
> > > > > SCR_CONTROL =3D 2,
> > > > > SCR_ACTIVE =3D 3,
> > > > >
> > > > > All these names are part of the same enum type.
> > > > > Which one to print? First one?
> > >
> > > Another option is to print all matching entries, incurring increased
> > > overhead and extended trace log length. However, I prefer printing
> > > the first matching entry, though it might be inaccurate in rare cases=
.
> >
> > I disagree. It's not rare.
> > I wouldn't print anything. Let user space deal with it.
>
> Okay, I will implement this in libtraceevent first. By the way, would the=
 first
> patch [1] introducing the for_each_enumand for_each_enum64 helper
> macros be acceptable?
>
> [1] https://lore.kernel.org/lkml/20260202111548.3555306-2-dolinux.peng@gm=
ail.com/

Just that patch alone? What's the point?
Refactor for what? Does it read better? No.
