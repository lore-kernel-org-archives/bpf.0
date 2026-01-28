Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25196BE5E
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558567; cv=pass; b=XrqSR2NGGhTDv9m9W0z6OCZPlnNuBGJcDV01G+iBLnCXnmRfZZy8vD9zCUj6fgYgICN+1fArs5LSvVxu/xuCXY4Xir++WRDw9X05bFfC2pv6+kso6g8I+cviCWW1lL5jig3V8mSBVm0PxKjfODHVex5Zz7pHzqmJFgtt3QNkm2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558567; c=relaxed/simple;
	bh=nI3btpbW9vR6CiuNHnfHHPZt2CHUMavU7P7AYOWHcoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhODBt79o0CgOPJLOnDsnkbqbesPIpqAFHME+fYLD/v3OQ1YgHE4cb2G8R9VxUy97lHYJ6C7ZJPB+TDHpqM5SvBHnjrwqWQvqCUw2uwIQDFO4MZipBDlR1/z1CVmj4MCH8MYgYnKvVhdzXlEaLYwjLYliz+QqrNJkLF28Nc1DvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW2YOzjx; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW2YOzjx"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc544b09so4635117f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:02:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769558563; cv=none;
        d=google.com; s=arc-20240605;
        b=k6OmJEiXer0SbqR4kdnZq7Ie92ipq5EHz2GdhjpX4Olt0TsGoptVwt2wPMM1+4ndk9
         wbhF29dZkHa6Y8oc9KCQauAYZC7fEaTp7BJcfDWhOsA7JEHRO30VSm26TCOEuvrX7xcA
         Bb4tiOd/D/0lzOpbMmTf8fmmbYckeW0mbEEIF+VS5SvRQEFTtcxYF5A+Q/trUrs9A4r5
         pbXatqtcUVZLidpAqpGjhtpYywl6vSfeRxOvNbH/lEODKPLMQ2eYcfT5mbd03YL4kSMf
         x3rE/1z3HzdHY80YoQnYuqvdCr5XD82ZWmLqC/Yh+Ey8go4TYRAPGlKoGFeKRamNoKX+
         zzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BqYX3sz5GE0LccUgGBgIDruO3ijcsM/jahVKoVoNOPQ=;
        fh=FIDBW07aRKEFMi+ncmCIqVhdWfIZ5CbvKX+4Edrs2TE=;
        b=jqlgomJroMAsLbwObzL2nJkJW8KETaQz4WAmuo4JYB4ml57Cjtei73EvqZJ00UJShR
         Nf7Gxw49bt1IkiTNqiOpBkB9tHiJfdnA0KfUxMwy+qq5Mj3QkAaWBpYBIusdusFD5poR
         krkWWY/Dp39ZBJ2OtvKZARCRTjChpp/ytnsDSJSccCWYfReL3An/CVXYzJjJS7VJ1w9/
         GJp108ffo7Htid0TTPzVOtzbhkiw8HW+AFUlYBVr9Oq/D8Zl0DGFAc740RcMTt0zfEpE
         AmBX1K1fHE2mroIR0Fv9UZUf2EmwGQkWo0RMoVeZrEZC0ttbKp0C7bDuP/08mJsMquON
         xnkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769558563; x=1770163363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqYX3sz5GE0LccUgGBgIDruO3ijcsM/jahVKoVoNOPQ=;
        b=cW2YOzjxWCDZPEf/3mGgMdatYGQN8vU0L52WSm90Ofu1j9MKtAFcHO5Jq1VO8ms9gE
         Z/zjC6M43uH7WhP6Kl2oc/bNwvUDsK2ooJOQX98DuHxuNXqBVLWBV5JYb+vrx0jst/LJ
         9HNIEDWyjDzlDx0IpT5SFgGW52LuRd5TGo5VjGCO1gtHTGnSMcrMhSna2nLuW2hE0E7f
         mJ7Qk9AonIu+P/To91hvgz13X9r84T7uoq9Og/O1RXahea3RWj7wIHhzCNUr6xhZfg1i
         NxX3X9uz3N7cZMwXSlhEutV7w+0X763vjd5ceweMFT7MBb9Q/283RQ1gOEddZMXFm3lc
         AJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558563; x=1770163363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqYX3sz5GE0LccUgGBgIDruO3ijcsM/jahVKoVoNOPQ=;
        b=XNAoKRHhwztiX73UAptusK6oQMnf2wAA+MwrkaKgohROMyJdN3wMn36bOtbTvpPcux
         BifuvfvftF3j48FnPRdPYttV+08gsvqcebcxOUV6tgjmdWiQ/fBc95+UEF8S8CV56JG+
         lQuXa9GUVmI8KdltD10dtPAFUvcBUGbSZ6rPXyzwyXz02/pNtv6/BYbL7zDpXVn1hGTC
         tcwsgp3jc5sWsmRU5pkpBO1lCeVpP6sH4eS7ya9Su6agj1+M4ApZ2Tr6AZFJS+3notFq
         vEG+2tIFMYU9CN1R+PyHw3HtLP+qX5GshpXcSmCXx8ouxdcVlHJQX+wyt4/Pv6Wlnbvs
         Ghaw==
X-Forwarded-Encrypted: i=1; AJvYcCWbBZ0RVKz1bPjUDts1rekkc4KPP5F+ubXtv+0z2fIFK4H4vKixh6eitzlWXvacOXC+et4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXg3DV2hnyon8H2cfZiO/Jh8uFOYhs7H13OWgF4VlQTrvGQVb/
	0o2Jby9QBSyy+cUUzYca6FpSpZPy+rjTRCP7wJs3910XdYhEPnO2ubfdMAIVnR7259yFnEj6Du1
	h9SxoIQsIXn2aXXWSOlEKp7u1lBaJQJw=
X-Gm-Gg: AZuq6aIWMioqjfwJFN8oHRpGU3eTJyIz+EWAgcfxPIVST4IWiMjfj11DInnkc+9M9/9
	pyjObgNfnHqxO2KotJqFCEumRufL11aOfTf04zV7HGLSojdDjFryQquIJ89Z3mNZeHjs2oQcmX3
	+9SRhYIM3BJcfeeFthuhYxrAXGxBCwzn4MrNpPXftiZN/7abQWUN+ImZaB2YbEFe1svI4JAOfXn
	kSIpUozjsYGvn7LNlRHmXs+psGOAphtKY17wZmNEVG8BYNC9+aE0f3jE1ACwtWHzi6f5OwSvnCz
	nbze/lK0NY2zYnQTM7P97S1kxomvzuJtX4EIrdrIjCpX9hc47HTeI4FmID8gha9O/Y4f1JHrecB
	LYFwlrfzZIEpuOg==
X-Received: by 2002:a05:6000:1787:b0:432:da3b:5949 with SMTP id
 ffacd0b85a97d-435dd07de98mr4588477f8f.21.1769558563203; Tue, 27 Jan 2026
 16:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091730.324322-1-alan.maguire@oracle.com>
 <CANpmjNM=w46BDuLsvAW6oM7JbPvrhN1ddaEUNSvsfZVU-514cQ@mail.gmail.com>
 <CANpmjNNoDHQOfH+bUqjpHdzYDxLwG7wA9qEywfWFNamt66Ziyg@mail.gmail.com> <20260127153129.2ca728a4550375a4172e1351@linux-foundation.org>
In-Reply-To: <20260127153129.2ca728a4550375a4172e1351@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 16:02:32 -0800
X-Gm-Features: AZwV_Qg96av6I3zAqyrLrwYJoXEAK61PE3QSsCgZsolKmiYC8gdinpMyZiUsehQ
Message-ID: <CAADnVQ+7ZxXE8O254rkYt+U9PO3Rxt681LaOT7W5UMj1PobHHA@mail.gmail.com>
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in BPF
 Type Format
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Marc.Herbert@linux.intel.com, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, namjain@linux.microsoft.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bvanassche <bvanassche@acm.org>, nilay@linux.ibm.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:31=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 28 Jan 2026 00:08:10 +0100 Marco Elver <elver@google.com> wrote:
>
> > > "KCSAN and KCSAN_SANITIZE objects" doesn't make sense.
> > > "KCSAN_SANITIZE.. :=3D n" objects?
> > > Or just "instrumented and uninstrumented source files".
> > > Anyway, I know what you mean, but others might not. :-)
> > >
> > > > Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy =
type qualifier")
> > > > Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> > > > Suggested-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >
> > > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Which tree do compiler_types.h changes go through these days?
>
> Thanks for poking.
>
> compiler_types.h appears to be a free-for-all.  It's best to view such
> a thing as a KCSAN patch rather than a compiler_types.h patch - that
> the patch affects compiler_types.h is incidental.
>
> 31f605a308e6 came in via paulmck so convention (which perhaps only I
> maintain) says "Paul", but whatever - getting the fix merged is the
> important part.
>
> So I'll grab Alan's patch, shall drop if it pops up in -next via a
> different route.   Aiming for upstreaming in the next merge window.

You mean in the upcoming merge window, right?

The severity of the bug is significant. Better to land it sooner
rather than later.

> It's unclear whether a -stable backport is required.  Thoughts on this
> are sought.

Yes, since without it kcsan and bpf are mutually exclusive.
