Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9A173331
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345885; cv=none; b=pjumwpX9HVZXppTfQqBJqSIwPzm/1CfFabqqEFCscAEBft+FDVShq6alEJ+kVnyuWxHEtVX6tNQy0atDGTyz7f1PbFCwrTGc2xsw7mfAp64JtL6vc/O9rG5iCDmrJ0aOrLDjo6WQEJNmzEHEZEbgQ9C6aOM3tyaI+Vo4ioY6Y/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345885; c=relaxed/simple;
	bh=kgTkYWu9av3fk1wXE/MMRWaBlHajVPxmTOnpQFuf3wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U07Fr4oAGDaTP+vVUKcVFSo3rjXsUzyP3Edx3yP3a5OPOYo1EgLXL2U+8x9F19zmBQoCuR1GrKVWek+epzm1E/Iyx832Hti/ApQF6bGSPDZwaxjmfAPV2KcojGb7SqHQCsFV9uqUbgRxyUw8cfqboEaS7j7ofU2cjJLj5zDX2pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nYlQpOQB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nYlQpOQB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e782e955adso2403316b3a.3
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712345882; x=1712950682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Skw/7zSwkdGJ/Jo5P9vQ92gzd4vVsUPWr/RZJFT+0E=;
        b=nYlQpOQBwu0SeowBmx5buT+znB91WQ+lG5jBfadkguScgcKKYn2mxWXIBgTo6TjcjF
         hh1ju9BZ/cU1tvJ+aEghewejfqN+ELULAnlLXj3Pwelw6poz+JhWMGtkWVDsy8X+RUb/
         RVDXNNT5JbQxHRP7StJMFIGPyp/WLyYSlhAvdpX6uafO3YZsUk6hwE2OrdHs1ZP0rxUk
         pfVtgs4E3u/KSz3gttSLe56zhmTKDw6Nyq1nI+iWKOeau3gPJMyNJmEy+vZ2ylfc5W5e
         7M5I5z33CdK75eUhkrxwmV7vJ4sUSQLmUG9b5CaOIFwyv3nRW8JcWr5wcFi3g2Kk0dub
         RWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712345882; x=1712950682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Skw/7zSwkdGJ/Jo5P9vQ92gzd4vVsUPWr/RZJFT+0E=;
        b=EJBP5rgUjTEndo83tf5N3fFTZx6S2jE8mbd2JbFCOEhySIJTRTA0qAfyDvARYISEg5
         18sXr+/y2LGqZ6Awk4tUobR8h0CQ+6abtKY8fXxtt7a+Idy1yDgLWOAw0qxkvhElSbGn
         K3sVkH/fgM2SJ7mjWRJs1cCQU9qVhwn2/aO0nzoV+duoV8aY05DBLGsaD1cTusbb17D2
         xkiriW6YDISWLCQqlcz5pTmgIzJev2eAoRINx47v0I0VgQOK/cO9/DE5CQwKq1/XvNvu
         MDdsf+q/XPK/4F1/059c2d4A6r/e/NlOQrS1hBUI60l7+rc+uu+5mnHXlAoGQGUnRdOT
         G7RA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Rc1n22LyGtXlN3q3h1QPLZvqMLbuatfqQY1B9B8fW/IL8JV/tJkyMADxhvB+pIlUdH4dZ1nPPeot9QbtK9YeM6Su
X-Gm-Message-State: AOJu0YynHV4jy2ZBK2fz+f8AOBSlv24NTH0pCFet9+d7WgaPokq8jRtj
	u99dK2ZTLoLUDt5VeE7P/rDw/Q1pFnOieD1mkp3JjXukQNw5SWexZWxVg58bvCY=
X-Google-Smtp-Source: AGHT+IHdaoeChGjYHsWpM/vSMHNxgMOeDLvzY75BPeRxNbiJW2/6A2VWDhF9OxxjEBBo27nQU10WdQ==
X-Received: by 2002:a05:6a20:87aa:b0:1a7:3ee0:5e17 with SMTP id g42-20020a056a2087aa00b001a73ee05e17mr1893999pzf.55.1712345882555;
        Fri, 05 Apr 2024 12:38:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006ecee1ae8fdsm1942485pfl.144.2024.04.05.12.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:38:01 -0700 (PDT)
Date: Fri, 5 Apr 2024 12:37:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Luca Boccassi
 <bluca@debian.org>, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 bpf@vger.kernel.org
Subject: Re: vmlinux.h overlap/conflict with network protocol definitions
Message-ID: <20240405123759.6265fd4e@hermes.local>
In-Reply-To: <CAEf4BzaTNRsFbppS31XQmFv+yjqw1_JASheOdw-7H_bHL=6HGA@mail.gmail.com>
References: <20240404100901.7d6bc10f@hermes.local>
	<3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
	<20240404112710.25d4e99d@hermes.local>
	<CAEf4BzbHbXHixPAEJccnrgt5xtV+d1iyvQYdC8Dpzs3cWdCRcQ@mail.gmail.com>
	<20240404175258.363f441c@hermes.local>
	<CAEf4BzaTNRsFbppS31XQmFv+yjqw1_JASheOdw-7H_bHL=6HGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 10:31:46 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Apr 4, 2024 at 5:53=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Thu, 4 Apr 2024 14:45:04 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > =20
> > > > > This is a known issue as currently vmlinux.h does not support mac=
ros.
> > > > > There are some efforts by Edward Zingerman to support this but th=
is has
> > > > > not done yet. At the same time, you could have a trivial header f=
ile
> > > > > like
> > > > > https://github.com/torvalds/linux/blob/master/tools/testing/selft=
ests/bpf/progs/bpf_tracing_net.h
> > > > > to be used for bpf program and then your bpf program with vmlinux=
.h can
> > > > > have much easier CORE support. =20
> > > >
> > > >
> > > > That is an example of header surgery which I would rather avoid hav=
ing to carry
> > > > as long term technical debt baggage.
> > > > =20
> > >
> > > What's your ultimate goal? As Yonghong said, vmlinux.h is not
> > > compatible with other headers. So you have to pick either using
> > > vmlinux.h as a base + adding missing #define's (because those are not
> > > recorded in types, so can't be put into vmlinux.h), or not use
> > > vmlinux.h, use linux UAPI/internal headers and then use explicit CO-RE
> > > helpers/attributes to make your application CO-RE-relocatable.
> > >
> > > It's not clear from your original email why exactly you wanted to
> > > switch to vmlinux.h in the first place. =20
> >
> > Some backstory. There is not an existing TC filter for this, so the
> > original developer had the idea of using BPF to do it.
> >
> > The program is a small BPF program to implement a TC filter that looks =
at
> > SKB and does mapping to queue based on L3 (or L3/L4) header. So not hea=
vily dependent
> > on kernel data structure, but sk_buff is not necessarily stable; actual=
 layout
> > depends on kernel config.
> > =20
>=20
> If it's only a few fields from sk_buff that you need, you can define
> your own minimal sk_buff definition with
> __attribute__((preserve_access_index)) added to it. You don't have to
> declare fields in the right order, just make sure that field types
> match. E.g., something like:
>=20
> struct sk_buff {
>   unsigned char *head;
>   unsigned char *data;
>   struct sock *sock;
> } __attribute__((preserve_access_index));
>=20
> You can call it `struct sk_buff___mine` if you already include
> sk_buff, to avoid the conflict. Libbpf will still understand that it
> should match it to struct sk_buff in the kernel.
>=20
> Alternatively, you can just use BPF_CORE_READ() macro on types you get
> from kernel headers, even if they don't have that
> preserve_access_index attribute.
>=20
> Or, you can just use __builtin_preserve_access_index(&skb->len) to
> access sk_buff's fields in CO-RE-relocatable way.
>=20
> Or, you can have entire block within which all fields accesses will be
> CO-RE-relocatable:
>=20
> int len;
>=20
> __builtin_preserve_access_index(({
>     len =3D skb->len;
>     /* other skb accesses here as well */
> }));
>=20
> Many ways to have bolted on CO-RE even without vmlinux.h. vmlinux.h is
> convenient (apart from lack of #defines, but that's an orthogonal
> problem), but by no means required for BPF CO-RE.
>=20


The skbuff pointer is passed to the TC program. So BPF_CORE_READ doesn't
make sense here.  The biggest concern is that kernel config of the build
machine may not match the kernel config of the eventual target, and some
of the fields of the sk_buff are hidden based on #ifdef and may change.
