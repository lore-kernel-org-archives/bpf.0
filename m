Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507E221554
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166396; cv=pass; b=tdBiSxkk2F6q1gCXxwHI1S2hBhMxLmq1OntBYS7Y/B1k8VQdMEB+CyKqzm/TWV3aOhrAjbq3WyJDjToWvFm2cyz4ZkTAsFFdhlJXxQIssPrX2fPcWRrv/sOM5eynMIjjkBvGNw4mbXgDhDumDKHW3yjtGetFgL5H6Si4jfGQ4B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166396; c=relaxed/simple;
	bh=hJoxwbCf1202qnrnTkaVoQ03QxkF363XCcGVKZ1rDEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqbTUpLUWyOYMFfm5utRhhZnAzhU3mb+zBxBzclTmpTkeefJvx+2AQcGyI5eUIuMCc3jqm6XBlhSxUY5dnPnFHVto7xEjBgE/aBm5rnD6komI1+lrU/Lt6jaDDKvSLx6dUzNIjKRyVGwPiXgDmx4GqrnaddeijE6jkaDYrzkOS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mttGGqkU; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mttGGqkU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so5231750a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 16:53:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770166394; cv=none;
        d=google.com; s=arc-20240605;
        b=DMtgSalOLuc3UVs2SjPMA6yPeaB0OkD7L6pP7MH4ruETftLuz0cBiTOzJJl21AZpo1
         R9JZ+k/L13ET+L3sH96B/dDxc0wi/39EBfLVo8HTUM54EDue7iqkvOVyWmDWf0uoQAme
         zXMELx3RV+9ABguZHrrT24mc1JXzHM5RAzAPJmkrW85ola0hLQvur9+eboX7cKy2rURH
         zKpafAKOQ8D/GN9vzQ2Q97It8jMY0lk0xGANtUz8JyXNGyNGPmdnlV+9r/mfkBFzPPHh
         4q9O6n6Xt8cM9Py7L433RBcSqJpjFrl+hjeBwrJVoNaOLrauCxhnikxgJHGwvo8N0Swe
         pH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7qmlllrmbVRYmuhd7Gn9dS98jj4YGml5ebLKdqtNczY=;
        fh=F67QOCqalbsFVAGPSJigrtRkIsSjn/242asg//34fs0=;
        b=bGqYPQ4ZQ3YUoRrBMvmhUO6rZ4xxpUBHxxXLN1jWFe3lmHKfzOhwXZaKGNuIpVfAl9
         HW1UYqGyT8k1O/o463vqDAfN3iMQ/ZjC8COf3Cw6sydJrEHtCia3+1gwZAB6aPoGda6/
         9yisbX1t99jPnGvEd0bjxzDSKNp+nNGWwij8LWCE7TCg8T0rRXpShdwu4ZF9Rn9/uvkw
         B6wvqTRzU5txcggq+xA6fk3nGwONATUtRmsIKkbgkvU6jKlcjlV7LxG3KhOxnP76xcpI
         cqmjGApzvg6MnR+NrtoLlT6jfkcyEfwvZITFPvRR+NGjGS2HdGx/7wwuz/PqU9U2TleW
         MdJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770166394; x=1770771194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qmlllrmbVRYmuhd7Gn9dS98jj4YGml5ebLKdqtNczY=;
        b=mttGGqkU45y9uj4fPXfL/6Yr+Hqx0/AhqR20pjRMgudqA9zqCPvzgoIp0rxmaFY4Lw
         SnAuXGO1Cw51ev7o/ZL+7KH4XNjzjE3fZWVRYWuuckU0UxAjtlIBJAchJsBr2+FQPJAK
         Zsw6Q4QyMrzBA6CY9nXMHZmSVR0B6c6b/kRRXTL8Z8lyfapLIYGrV0ImsD+qCHWUKELo
         3QmKqjlc/hcC/8hkPpO9mLlh1FLCb+dvZUipnVLX4ItrqC2jyssAmrbq3ncZV2VB0ett
         dXOwOHL+F8kkgvlCHjLpOwemyy2zcDeSChtW+KmtftUOApch1lKGJrP3aRh1eiOTfU/a
         cghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166394; x=1770771194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7qmlllrmbVRYmuhd7Gn9dS98jj4YGml5ebLKdqtNczY=;
        b=NbTPLNlzpaqfJb4twPwCvHL+C9PYUar/eZ7BVXZekFKD0DpN8h4yCn3HWx3+IOuMRQ
         nBFbUtdLhqHFOUExqx9wwrXw9hm0+ew8RHK5h/EinjREWtJSVtHxFb6sol+MHju2AWo1
         f+Zpet/7waXdiVemJX694GKe1MCftFge9EBqNwclG7HHhTDVhBQsxBQfQu+nXGbMMc5x
         2nMe5uYGf9yzlxNG3QqzECbMZ60f9Dqmlx36ayvTN5MdJdbNQJDEMoXZpBkknGDkcmTL
         vXHGfGgI7B7R2lM5qgrmEirOZzNDZX0cvCoVXmObbjMRdUmIX+jEQlHTpIr+L0kK+2W0
         uZLw==
X-Gm-Message-State: AOJu0Yz28Vnyvpv6C31k2yz3wmRAd+OmYLeDxwYJRiLsB28G7hnKGb8h
	l1Hso1+4OkD2OZjSd/p5Tey8NUDEKDz2NuLKF5WR6lesw5ylhCeVB0IOQG5e5g/bQ3SbVPree8e
	x8aqB/4vrL/Z41/pLGetGFUFOZPuSRWY=
X-Gm-Gg: AZuq6aJnjT4YdmyplHsM6SSn6pP/xskG5+KVfGErNgzb01UhObm9iY++eCkB0ldVYK3
	T0StjW4oxe5AQ0TdnSmiMVAO56M36Gl4oqROw4kFbkPVGaRKZwndOF6QdQJuycWdbwuQynbp06c
	JjrjpyXyotny8ruKBBnam9jwdiXlRR5FuyNmWpF32BxoBDRj2nXa+F+m55+Re/+NSlQplJEOnbB
	19f2r725ejlQEpXZ7PAfNMTSgviyM/PXQilQaZrgM1NkQM0S07YpGT4E5JCtIwiqETPN+aQClLL
	95IeQbvm3NM=
X-Received: by 2002:a17:90b:57c5:b0:352:c762:8c2e with SMTP id
 98e67ed59e1d1-354870d71e2mr926443a91.13.1770166394237; Tue, 03 Feb 2026
 16:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
 <20260201025403.66625-2-alexei.starovoitov@gmail.com> <CAEf4BzZxWzntugOkbPLC=yy9TZ4v1YVaALR25-rOqF6xezVW-w@mail.gmail.com>
 <CAADnVQ+c26Ff14vni7iqaZ71s3pw0AgABk81QSZ+5o4brBnoqg@mail.gmail.com>
In-Reply-To: <CAADnVQ+c26Ff14vni7iqaZ71s3pw0AgABk81QSZ+5o4brBnoqg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 16:53:02 -0800
X-Gm-Features: AZwV_QgzoyBzLhButbMPKyPvz7-OiI01gRQimZXJbjPgQ1dj_vWi-IFvSz-dxng
Message-ID: <CAEf4BzbNR1n6=t3m+gJdZPq8giEHim-FeFyFhya8n9ZszR09xA@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 1/9] bpf: Enable bpf_timer and bpf_wq in any context
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 4:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 3, 2026 at 3:53=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Jan 31, 2026 at 6:54=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Refactor bpf_timer and bpf_wq to allow calling them from any context:
> > > - add refcnt to bpf_async_cb
> > > - map_delete_elem or map_free will drop refcnt to zero
> > >   via bpf_async_cancel_and_free()
> > > - once refcnt is zero timer/wq_start is not allowed to make sure
> > >   that callback cannot rearm itself
> > > - if in_hardirq defer to start/cancel operations to irq_work
> > >
> > > Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  kernel/bpf/helpers.c | 408 ++++++++++++++++++++++++-----------------=
--
> > >  1 file changed, 225 insertions(+), 183 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -1456,10 +1493,20 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_=
kern *, timer, u64, nsecs, u64, fla
> > >         if (flags & BPF_F_TIMER_CPU_PIN)
> > >                 mode |=3D HRTIMER_MODE_PINNED;
> > >
> > > -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > > -out:
> > > -       __bpf_spin_unlock_irqrestore(&timer->lock);
> > > -       return ret;
> > > +       /*
> > > +        * bpf_async_cancel_and_free() could have dropped refcnt to z=
ero. In
> > > +        * such case BPF progs are not allowed to arm the timer to pr=
event UAF.
> > > +        */
> > > +       if (!refcount_inc_not_zero(&t->cb.refcnt))
> > > +               return -ENOENT;
> > > +
> > > +       if (!in_hardirq()) {
> > > +               hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > > +               bpf_async_refcount_put(&t->cb);
> >
> > any reason not to use bpf_async_process_op(BPF_ASYNC_START) here? you
> > are basically open-coding it here (same for bpf_wq_start). For
> > bpf_timer_delete() you just call
> > bpf_async_process_op(BPF_ASYNC_CANCEL), so it's inconsistent...
>
> I didn't want to obfuscate the call and to avoid tiny overhead
> of switch (cb->type) which won't be optimized away by the compiler.
>
> bpf_async_process_op(BPF_ASYNC_CANCEL) is there right next
> to bpf_async_schedule_op(BPF_ASYNC_CANCEL),
> so I wanted to keep those two consistent.

Same as for BPF_ASYNC_START, not sure what's different there. I still
find it inconsistent with the synchronous bpf_timer_cancel(), but
whatever, I'll apply as is.

>
> 3rd reason is in bpf_timer_cancel_async() kfunc that
> calls hrtimer_try_to_cancel() directly to return the result.
> See patch 3.

yes, I noticed this one.
