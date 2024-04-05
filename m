Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C5172BC9
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347232; cv=none; b=WvhM5W7nscQLqHy259OWUkLL1JHSAiztH9/gxh+u+TP+EEYhC1Zm5ZeNgAbnhlB0ZOZnyebrfIeqEtM5+INQcdGhCDBxO9J+ZAUTxypEjZ90M3GbFK6lUbepNgJzOuVQU2CRVQ1G1clmMBKIgXELMZJCESiMOuj9tbDzllnu+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347232; c=relaxed/simple;
	bh=CrFUiy1deeiBJvBEQ1xNg3t5/ykhus5T3L1JFlB1Oxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nha8Vw6drj1p/eDFwe0Ys0bEkDuiped/qCY9rrN4dOZnPG8wVo67/vGCkT/2/sQUhqAV7eRc+kJtKZ1ZccYcTzkYg2AeoTB2GwyO6wq/UytMpsjoHYnfa0lSHMS6kQWay2w4uyAPKi/oXmCMr3P6CmvD6pH7+kxYReIFFYcEgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6mqbuw2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6mqbuw2"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a49bce83baso124950a91.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712347230; x=1712952030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfXECwOHl3edVA8AwxDyNhvCAArh8CvhHu0VTvGbVNQ=;
        b=j6mqbuw2CrMymf02A4RHWegwgStmxBGamzNv5f7UGpT79xpJnvymYNxa/U8u7PtmUm
         XTFhaSrpm9FUOFrzgnm4Q0JEFYFA7u6HjIUquQ3FTlHqNT8rVdSAk1mB359iSJqGUPlv
         wvnlifLNrU62fvpp0aCkuZyUFmN62+z4Ms52SFIRUDGL1sOKJFUVagxvkKZlGqM7CEu5
         +P77dO1g8UVTMxnADFgp2d4S9r9bEVyAQCEHdC9gnewkvNI0fNBwgMOHsutXwxIUYYHF
         cvlgN8wuLbMj4OXIYV8gYkVUFlFsp5Erwnbqm5lQU6g0bCMb7vwBn6tJRyyFArbKoYyE
         H5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347230; x=1712952030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfXECwOHl3edVA8AwxDyNhvCAArh8CvhHu0VTvGbVNQ=;
        b=JE5cYC0bPShGvkliqrDK/SglSDSBOwapO6T08Rf/lvfDOiSIknDvCN83XiljS0DVTF
         niDLrWTIty6H1Nlva5GHinZYSgDZdK3Zj+Or77Xl9Zh9/PVY4Ig9uRYGUUCA3ilGD1ca
         sPgX7wsZi4vrWK46gguqhIGZ7z2A4ZWuxw8rVKFdP9cUEprumfaHPhbP+UQG5yZlFidv
         ULNH11B56ACA28vT7Ma0IPNhYPA2RXCyJZqAe8cqXIT1qPViUpNu4Fwn7O7SPJfzHaje
         7DRJoLLvlg+Kj0HHjPnY0IAt7p6QF66zUXJJgMwZa/eeZSv1oH/INxDTeYK5+603INBy
         pokA==
X-Forwarded-Encrypted: i=1; AJvYcCWoEj8xBGm2mWIqifE2jhsto/oNFQQahFdChuDt1W17ZVPIQM0j1B23QR+X6VErOOlAQa9prqRV4vtmac7a9aIW3DAe
X-Gm-Message-State: AOJu0YxiTbSI2p1mj1/BHBl5YFnvnfCSSFAYcoyc7lRnVA0RyE9mQQkb
	uWCSBI1eCXqETeSS+xCMpzN2ehO1eAUr5wStPfxn8tuRLc9x3DfYTR3igKG0ha832Y5eyWvgNv6
	JNl3sNBACm3Z681VtW1q8wvQtnUE=
X-Google-Smtp-Source: AGHT+IGBoqPz6jJPG0WUkux/B2OxbMJurT8tbHkRr/ay3h1HZeZiW6swywoIjfYxA0SJbbLPhPzmckZBLRyISTSoLD0=
X-Received: by 2002:a17:90a:cb97:b0:2a3:1081:b338 with SMTP id
 a23-20020a17090acb9700b002a31081b338mr2387326pju.10.1712347229458; Fri, 05
 Apr 2024 13:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404100901.7d6bc10f@hermes.local> <3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
 <20240404112710.25d4e99d@hermes.local> <CAEf4BzbHbXHixPAEJccnrgt5xtV+d1iyvQYdC8Dpzs3cWdCRcQ@mail.gmail.com>
 <20240404175258.363f441c@hermes.local> <CAEf4BzaTNRsFbppS31XQmFv+yjqw1_JASheOdw-7H_bHL=6HGA@mail.gmail.com>
 <20240405123759.6265fd4e@hermes.local>
In-Reply-To: <20240405123759.6265fd4e@hermes.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 13:00:17 -0700
Message-ID: <CAEf4BzZ8ue3e2ZzapxFLB0Lih4jWOWTcF4NPZfhaGOy9TVbtpQ@mail.gmail.com>
Subject: Re: vmlinux.h overlap/conflict with network protocol definitions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Luca Boccassi <bluca@debian.org>, daniel@iogearbox.net, 
	ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:38=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri, 5 Apr 2024 10:31:46 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Thu, Apr 4, 2024 at 5:53=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Thu, 4 Apr 2024 14:45:04 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > > > This is a known issue as currently vmlinux.h does not support m=
acros.
> > > > > > There are some efforts by Edward Zingerman to support this but =
this has
> > > > > > not done yet. At the same time, you could have a trivial header=
 file
> > > > > > like
> > > > > > https://github.com/torvalds/linux/blob/master/tools/testing/sel=
ftests/bpf/progs/bpf_tracing_net.h
> > > > > > to be used for bpf program and then your bpf program with vmlin=
ux.h can
> > > > > > have much easier CORE support.
> > > > >
> > > > >
> > > > > That is an example of header surgery which I would rather avoid h=
aving to carry
> > > > > as long term technical debt baggage.
> > > > >
> > > >
> > > > What's your ultimate goal? As Yonghong said, vmlinux.h is not
> > > > compatible with other headers. So you have to pick either using
> > > > vmlinux.h as a base + adding missing #define's (because those are n=
ot
> > > > recorded in types, so can't be put into vmlinux.h), or not use
> > > > vmlinux.h, use linux UAPI/internal headers and then use explicit CO=
-RE
> > > > helpers/attributes to make your application CO-RE-relocatable.
> > > >
> > > > It's not clear from your original email why exactly you wanted to
> > > > switch to vmlinux.h in the first place.
> > >
> > > Some backstory. There is not an existing TC filter for this, so the
> > > original developer had the idea of using BPF to do it.
> > >
> > > The program is a small BPF program to implement a TC filter that look=
s at
> > > SKB and does mapping to queue based on L3 (or L3/L4) header. So not h=
eavily dependent
> > > on kernel data structure, but sk_buff is not necessarily stable; actu=
al layout
> > > depends on kernel config.
> > >
> >
> > If it's only a few fields from sk_buff that you need, you can define
> > your own minimal sk_buff definition with
> > __attribute__((preserve_access_index)) added to it. You don't have to
> > declare fields in the right order, just make sure that field types
> > match. E.g., something like:
> >
> > struct sk_buff {
> >   unsigned char *head;
> >   unsigned char *data;
> >   struct sock *sock;
> > } __attribute__((preserve_access_index));
> >
> > You can call it `struct sk_buff___mine` if you already include
> > sk_buff, to avoid the conflict. Libbpf will still understand that it
> > should match it to struct sk_buff in the kernel.
> >
> > Alternatively, you can just use BPF_CORE_READ() macro on types you get
> > from kernel headers, even if they don't have that
> > preserve_access_index attribute.
> >
> > Or, you can just use __builtin_preserve_access_index(&skb->len) to
> > access sk_buff's fields in CO-RE-relocatable way.
> >
> > Or, you can have entire block within which all fields accesses will be
> > CO-RE-relocatable:
> >
> > int len;
> >
> > __builtin_preserve_access_index(({
> >     len =3D skb->len;
> >     /* other skb accesses here as well */
> > }));
> >
> > Many ways to have bolted on CO-RE even without vmlinux.h. vmlinux.h is
> > convenient (apart from lack of #defines, but that's an orthogonal
> > problem), but by no means required for BPF CO-RE.
> >
>
>
> The skbuff pointer is passed to the TC program. So BPF_CORE_READ doesn't
> make sense here.  The biggest concern is that kernel config of the build
> machine may not match the kernel config of the eventual target, and some
> of the fields of the sk_buff are hidden based on #ifdef and may change.

And everything else I wrote?..

Regardless, I think at this point if you want to get help, you
probably should provide the source code.
