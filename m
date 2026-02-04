Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154A1917F1
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165181; cv=pass; b=Wfdyt6kEZXdBG39XkhQ6UO334PW1nE+E7lu7fIMifOECb65znIDX0wdAHflB8Uc4eWI0Yo8xtwxXIBDnk7pba1G2kV0SM1pYEKIdekuIzKxaFOtEeGnmEBLNa4X3VnvL+dg5EocG8nGH3ZRafZc6nc5HUymZ181qRkeihK3SdcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165181; c=relaxed/simple;
	bh=QWkzteauj0a/xDl70Jvy3xLshg/6rX1fUfUBJsu2eww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ci4JW1DjGHyHB5h5Y0ub8yjUevnZZD5symnMErXIcNGCtMn36GNz7TEH6zKeKpM6Mh5o9Ce0HdlFtX2LdBNPL+uqAcGMI0LebUAMflOhWNLSAhJCHR8Rcnmie1x+2w/6Mj03AlBD1yWJVJEqRf71SXLm3IW4NBd5xfOceAnW4rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLaEjOiq; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLaEjOiq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43615d9c5d0so570686f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 16:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165178; cv=none;
        d=google.com; s=arc-20240605;
        b=LNBBIjsbkAp980jGVyMWkdc+Y7Lr9fEclqLckYW7RBjie8rYDYw1L5YpCT3EVGExjB
         MSec248GPF430xHwWaoqjUwLxA8rA6KB0v/j6F0w/ZTPsarAK0nNeLxyRVnWyngLCMNt
         t1UlNhydszFqKGc2/cDDHHWMoHy+Dxbv7IzBbUovDFlOSjCUVsr5GHuMV6KHMcx/yfXg
         htChv4U18Ah/EplJwKGi0R86xB3GEan44U7A0TnP0tgrWaDOXxjHyNJjFaC8YUijDR38
         GoNrD+SVj7d+Y9b26DdIEm8aXtfnQBAnR4XYvTcpKQbaLG4H0WsclMb82c/3NqslQISi
         Tzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqQ3bzlYfFhXWlxoYLyctq53kuXQUb6sNX4WeDpsPO4=;
        fh=+fKu4vNNExkwLzWIKYmGNY7ZVAccuGPbPKhHhGA4f7c=;
        b=jysQw7vzUCZ+qNHDy+zvdo6bpOy5ff+zaa4pJJLXzEsygX40d96OWXr9K6PmlZ4pnz
         ZZvuVctIPNjpa6GA5j/CytOr42ISIdOAe3leXhlf+lY5Pf4BlY8H1F19fNR9k+7qIQNP
         Ql6YvcsekbqxQXIicNnVIJ+RhZT6koMvHFmJP+0KEi1rK6XR55Wx4KaFornR4hrZPBCD
         OjlrxvmJpmozCLjbEWoY0EtQfT4cLvKKvzJF31jxM9pCbnUq5BA9/yigeAcIgTVXOTIE
         MOCrnEDzj0lVGL8BiO9m7mM0TY7mAVsS9337sklfWn81Oun7TyqjET/Ml9NCcmeaf8km
         BjlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770165178; x=1770769978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqQ3bzlYfFhXWlxoYLyctq53kuXQUb6sNX4WeDpsPO4=;
        b=FLaEjOiqv70boEcF1Rh6+o9NfXoNHWv0doht0f0UXIJv7WJcPMaRfXEJqEH9xMQT0U
         nbOJE2u8rgwYgyuD8ErMph1ZAGsYXoi9NaWZnP3dmyZDAKINgciiMSd1fS77r7zQ46Xo
         OM6diC9tbFfd2JaGjTmpErdia6Qnu7KggQkLWWnX2xEw4NYeaQMb8fX1Nn28qKYUFAgh
         W6pJPnttmo+3CUGI2v+sSdSnnKFR0tD9n5U4xs/5Fr2h7lJWJWKG03twW+TnC5db0PQa
         B3H/wt1BRM0+MUcZAUM+/MMhf+zq0n2WqnCXmJf0BH289KSMKdi7VTsqgwtJkPBFC8Fs
         aDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165178; x=1770769978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqQ3bzlYfFhXWlxoYLyctq53kuXQUb6sNX4WeDpsPO4=;
        b=lwO1iFMZ/okfqol7sqGmvH5bJNaFVk8SsnbZj6Nv3wS2EyPk/lOWYOdWe0HH0RmWxN
         d5DjbMZ+ic5MbeFkDzh3a15CoqpIqVU+ubv11IpKZ+btVvmJoAhGJD5KP0/lVQR5e2Hh
         6qFcT+CUCRbh+nUzwX82F2Jz9PM0EdsEd27xRsFuXdbYiO2TzZN15RXckzLjg3ZpNCG1
         v8uzJ51sQVUqtTk3nvYuT+ST5o3/yCkcrmYym6h8dG5L0mjeyIXGkaZYVRTWl8onXV7M
         BpWpGXoj9NXoZD4tUVvZYmfqZXBwVnsG2srRetpNQC/8A6BoiZywrWM72fIdieWEkFly
         ddRw==
X-Gm-Message-State: AOJu0YyyzO/RRz6qwJ3tc+eYfHwsZ1G9/FUa8MuzaJcvaauXgzL7rsAl
	UEP9v1GGraoTmbhlur/nEy8MEd7DHaIXihMcGZnwS+g9bu/jwS6y9WdbBdcG2MbjY2cwT7J61rQ
	o1fW6BvhyjxrGy2Pf6a8XClSJDK48YhQ=
X-Gm-Gg: AZuq6aL7nkO12ctMLrOV5qMJamq0Oi2lG/92Tvtozk0rEFBozjXPkyKp1Lz8Fw28QB7
	KKpmk+35mZtO5RmA/73SSLtZtYoEiO6VD6MEsaurkGczrfUahTQOCycImiLS0uV4JYi9OUTh2R+
	UP0lDnBiJsLLc8SEJ/ou7zHE9frvkbfKU2h9eV3vM9EfM/wCvu4mNgUvKmVAj5gMkbT5XCYTZyj
	z0qNpioSR5rX1CoNhhVbd+xMXccD3UzZqyP1jHrHEf134hAViu1dU+rVlTGmXvu2UQtFlE8hzyM
	ffVVevpMNDVN840ZUaPyo0vlwRZkPDhN3xcG7xnPlCozHdaCpZJ4+tSfJYt1mKHX+B9UMaUsicX
	CBlKDKvdKYiRO/g==
X-Received: by 2002:a05:6000:1888:b0:435:9690:f056 with SMTP id
 ffacd0b85a97d-4361805284fmr1419233f8f.35.1770165178311; Tue, 03 Feb 2026
 16:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
 <20260201025403.66625-2-alexei.starovoitov@gmail.com> <CAEf4BzZxWzntugOkbPLC=yy9TZ4v1YVaALR25-rOqF6xezVW-w@mail.gmail.com>
In-Reply-To: <CAEf4BzZxWzntugOkbPLC=yy9TZ4v1YVaALR25-rOqF6xezVW-w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 16:32:47 -0800
X-Gm-Features: AZwV_QgV8OcvolZ_SzoxQC1GVAe5_R7QsF58Vku8sTx-RN8q6uEcTEM1tu7dy7w
Message-ID: <CAADnVQ+c26Ff14vni7iqaZ71s3pw0AgABk81QSZ+5o4brBnoqg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 1/9] bpf: Enable bpf_timer and bpf_wq in any context
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:53=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Jan 31, 2026 at 6:54=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Refactor bpf_timer and bpf_wq to allow calling them from any context:
> > - add refcnt to bpf_async_cb
> > - map_delete_elem or map_free will drop refcnt to zero
> >   via bpf_async_cancel_and_free()
> > - once refcnt is zero timer/wq_start is not allowed to make sure
> >   that callback cannot rearm itself
> > - if in_hardirq defer to start/cancel operations to irq_work
> >
> > Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/helpers.c | 408 ++++++++++++++++++++++++-------------------
> >  1 file changed, 225 insertions(+), 183 deletions(-)
> >
>
> [...]
>
> > @@ -1456,10 +1493,20 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_ke=
rn *, timer, u64, nsecs, u64, fla
> >         if (flags & BPF_F_TIMER_CPU_PIN)
> >                 mode |=3D HRTIMER_MODE_PINNED;
> >
> > -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > -out:
> > -       __bpf_spin_unlock_irqrestore(&timer->lock);
> > -       return ret;
> > +       /*
> > +        * bpf_async_cancel_and_free() could have dropped refcnt to zer=
o. In
> > +        * such case BPF progs are not allowed to arm the timer to prev=
ent UAF.
> > +        */
> > +       if (!refcount_inc_not_zero(&t->cb.refcnt))
> > +               return -ENOENT;
> > +
> > +       if (!in_hardirq()) {
> > +               hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > +               bpf_async_refcount_put(&t->cb);
>
> any reason not to use bpf_async_process_op(BPF_ASYNC_START) here? you
> are basically open-coding it here (same for bpf_wq_start). For
> bpf_timer_delete() you just call
> bpf_async_process_op(BPF_ASYNC_CANCEL), so it's inconsistent...

I didn't want to obfuscate the call and to avoid tiny overhead
of switch (cb->type) which won't be optimized away by the compiler.

bpf_async_process_op(BPF_ASYNC_CANCEL) is there right next
to bpf_async_schedule_op(BPF_ASYNC_CANCEL),
so I wanted to keep those two consistent.

3rd reason is in bpf_timer_cancel_async() kfunc that
calls hrtimer_try_to_cancel() directly to return the result.
See patch 3.
