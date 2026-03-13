Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B09345721
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371982; cv=pass; b=J66ETYKYvDHGoY8tmK5CbINw7PyglSOkUT0BiHRMVAmjVnVc36mPwwQwTCbir5lefwdimPlTte5QolZeKULiUauoZgl0y0QOpb+ejG8kYtiTrUB5SAD0goL4iWBMRUDYsNGoj3KeMRkDdDtdxUYtBH4H3vWjxDOKJWS6Wm5ooAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371982; c=relaxed/simple;
	bh=z5C5+rca80+rlH4kb5g/9Tr41VJjW5u74Z104MskDBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af0diQhwC3RZuOfJnawZ+fS1UP+tyzkUDnSBoMQgJ7weue7jwYs3MCXEbtdESLYAVDNv+Kh1oR0EW1graD+h/RKfPSbBW0Ugmd0DmlQCkizhcm997kMOElUxNDD3zLWzhUzIi5VwgHAhLRFcxIQKazqLmM14IGiYzIX26h4HuVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4nE7BZ+; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4nE7BZ+"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b9b190easo1220148f8f.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773371979; cv=none;
        d=google.com; s=arc-20240605;
        b=jI3QozEC3IydftEpKs943nqdmNIFlICyiaevdm30NrkllL+a4pXxTwGPdFIlSmUVUc
         8e/WDWZ6pYjLr3wSbpvX7ZxDCgnT+LuDzsb+DzEmt5qkMpIBV69inTHRLsB4S3Gpm5ai
         zzed7WJuLc1l6DjvA6dEhKQvMeedE6qXHrUiwTMF/DKz53rYVBQc9jMGeExSchOkVRoL
         hNk83JOzbL6bLBtA7OXuBrKxjQfy1NjhEnNSbF8t6lZ1YoB3FTtXtjmI1/kp73W7Mv84
         yiDRIAHbr45d7Lf3JbjHWx5HQUZRyMmL0bax6nqGAJXbRO+UdgKnFa68LEg4AUIjyitX
         AuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+6Gw/LsD1loG1u5d/wa3El7wK1OULiHLKLED7ss9fdI=;
        fh=2Yq2ltyOUV7+aNQplXNYygsE7Xa5Z+4CYqYW5T8Xa14=;
        b=Uk0cmIFsI4iAjpCWWoRXecOlFgJ9ubMYLn4UmJx3Z2rRfjU1TAoT2TjukWvVDai207
         qnuc/N1l1yLtGNOqs+9ZwHybD482RCV/crCD/UvGY+UOUKLtmSk7nAJlSs0BIL9GWFje
         SWvCHXdym23V+VINgOvh9lV+RXX0a8jKLS1qE4DOlTqFqg0dxeFCw0bs3TmtQYu8+W8V
         OHIod3MOKnmKjyBC1LScit/iZXaNi1SUiCGe8+NP/8Ou+n/ZxmeZ1SbqQCJysQzcnM8H
         GscFaOUsJ76vLByL9ZKXoDbl0TwLXSogKjljSGWEVA8szUZasj8xUUc/76uwbU8QRjoN
         oTIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371979; x=1773976779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Gw/LsD1loG1u5d/wa3El7wK1OULiHLKLED7ss9fdI=;
        b=G4nE7BZ+6DZaLp8CT09J7OzT9iPJTPYkEWv3epAFkBZWmvVW3ouskeVkw+d8e4dD3T
         OmsAafwxfEHLyNU+jFp48SZpGZGh/o3XaLBzcFPSD0yqP/U7pAe9FC2SjcfSVS9tz258
         HMalmYtHot6V7W+Mcb+I5i3BOjoH+BemmlmCZV66KUYGNygQ004PVUuBVxGxOM/qlKce
         WmoIS+pN9NMvxblaZ+gBtjgNzTlWl03SyrFOBaRPjuP3OVTX6QQz9Tfz6nYeA0HCRP4M
         9sl4DXxamKDdzjxaG6K5K5wA2jA53RPRlre2bF+bVeCAjb4hoo1cIkHOknrztbzKrKiK
         sG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371979; x=1773976779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6Gw/LsD1loG1u5d/wa3El7wK1OULiHLKLED7ss9fdI=;
        b=kmlFKueLWA3zF7mENTe1XGyLDIhwbRASEidRq3V8deWMuXTHTIU9sAQS8L1yfLUIVU
         G90/t6sBQk4e4feDnH1P7i28sU/wjq3bHpcfEgv3eo/sf44tt9nz5+UQNN46ntWE+0QZ
         NyGWGjcipU4xJuJXPV6L1rw9Y3lQwF3lig8bc2C/aA1kN3JV9fndMWWQO9zndA0F4pWO
         fAWz7fjEFCmlcU0RXySpXmbw/XJoKTW+fkXyiH8+jqLIJBwDJIBa6+73eNMtdnFeDV5K
         WzBSmDbCw6ALnnOJ5jbzlCqlkNmO4WhK09vPmgehNVZLFVkqzNuHhU95Wyulwn4azsb9
         1cvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUgRaF407QX7lSTnqAYOpLzuRB5t9Jvh8qUbSr0oJ5Vd6aZyuTXh9jp3p8GXyAmS1zVqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQ+yXYYbwuJ6sGAr21sk6zvMjDwwyGaGrIlLzX6nZpJUm/nAv
	QjBXTKkm8M1nyrHO0TdxRh05Oh9j7Hmdj88VLZVHERFxgeXoZeqkzTH85aOy4sFMYHOo/7eB9BE
	6Q7N4E3j87dwVWwTwbzUoYAFpuAGYVM8=
X-Gm-Gg: ATEYQzzkq/Vzphg6BOUTWoXuUmUC4BsxYchgdHgkFNjCtnWV8DUCEvckUGVCQpjur/Z
	qi+ArGUO45xWpQrjNkstHf8DRLsBXZ4JCbDuTbazA1H83rmNOONy+Za7Od8sixPzPaOR4WDzgHL
	RZM4mQRAW/0JtiKahcEp0pV07jyBccwLUic6CkUoSNBSxkpmhGnYzZk0/jiksVbErdGUlE7xzPs
	5Hyxc+hfTfiO+3V5nZRXwYk43LuLXmibGlvjbFPREBN9+O7GzvZrnhX/OZ92Ah/5+Qci7r6dIWH
	YOGX+6fLTCk293ZfUPEOps/iL0dykGB3ul6btDyQYUK9C466zfNf/fVzz5Ds1g9TgOE=
X-Received: by 2002:a5d:64c3:0:b0:439:ba75:7db0 with SMTP id
 ffacd0b85a97d-43a04d71539mr3164756f8f.1.1773371979457; Thu, 12 Mar 2026
 20:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311225726.808332-3-puranjay@kernel.org> <480892a72caa391641ec52a010730d213241830683280a0583cfc334d8f39325@mail.kernel.org>
 <CANk7y0gOSQN7vULuBVwhVO=Tq6bB99jZwovras7F5yjNu5tVqg@mail.gmail.com> <CAEf4BzYupi9RwB0SC_QOKncNd4viNu6Yp4-kmnbS1846A-uL5Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYupi9RwB0SC_QOKncNd4viNu6Yp4-kmnbS1846A-uL5Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Mar 2026 20:19:28 -0700
X-Gm-Features: AaiRm50d4jBysdvHnVvp8B2_0YXyw9lI936RZXBgc5_YuJrLP28IFSf8-1WlapY
Message-ID: <CAADnVQK+6i13LykoNb91S=naBdGaenOdxnWV6mHc7ZB6dxpSSg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 11, 2026 at 5:35=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > On Wed, Mar 11, 2026 at 11:53=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > > > index 2ccdc3228063..50dbeaeafd86 100644
> > > > --- a/kernel/bpf/task_iter.c
> > > > +++ b/kernel/bpf/task_iter.c
> > >
> > > [ ... ]
> > >
> > > > +__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct b=
pf_iter_task_vma *it)
> > > > +{
> > > > +     struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > > > +     struct vm_area_struct *vma;
> > > > +
> > > > +     if (!kit->data) /* bpf_iter_task_vma_new failed */
> > > > +             return NULL;
> > > > +
> > > > +     if (kit->data->locked_vma) {
> > > > +             vma_end_read(kit->data->locked_vma);
> > > > +             kit->data->locked_vma =3D NULL;
> > > > +     }
> > >
> > > [ ... ]
> > >
> > > >  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vm=
a *it)
> > > >  {
> > > >       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > > >
> > > >       if (kit->data) {
> > > > -             bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> > > > +             if (kit->data->locked_vma)
> > > > +                     vma_end_read(kit->data->locked_vma);
> > > >               put_task_struct(kit->data->task);
> > > >               /*
> > > >                * mmput_async() -> schedule_work() -> __queue_work()
> > > >                * takes pool->lock. BPF programs on traceable functi=
ons
> > > >                * or tracepoints called under pool->lock, or program=
s
> > > >                * running in NMI, can reach here and try to re-acqui=
re
> > > >                * pool->lock, causing a deadlock. queue_work() disab=
les
> > > >                * IRQs before taking pool->lock, so irqs_disabled()
> > > >                * detects both cases.
> > > >                */
> > >
> > > Is vma_end_read() safe to call from NMI context here?
> > >
> > > The comment above notes that BPF programs running in NMI can reach
> > > this code. The old code deferred the mmap_lock release via irq_work
> > > when irqs_disabled() to avoid exactly this class of problem.
> > >
> > > vma_end_read() calls vma_refcount_put(), which can call
> > > rcuwait_wake_up() when a VMA writer is waiting:
> > >
> > >   vma_end_read()
> > >     vma_refcount_put()
> > >       rcuwait_wake_up(&mm->vma_writer_wait)
> > >         wake_up_process(task)
> > >           raw_spin_lock_irqsave(&p->pi_lock, ...)
> > >
> >
> > This is a valid concern and fput() will have similar problems because
> > it calls schedule_delayed_work(). I will have to think about how to
> > fix it, the easiest would be to add the following to new:
> >
> > if (irqs_disabled()) {
> >       kit->data =3D NULL;
> >       return -EBUSY;
> >   }
> >
> > Then the mmput_async()'s deferral to irq_work is not needed because
> > the iterator returns early in _new().
> >
> > But this will make the iteratory useless in NMI because
> > irqs_disabled() would always return true in NMI (unless I am missing
> > something)
>
> It seems like having task_vma iterator work in NMI and irqs_disabled()
> conditions is untenable due to all these issues... deferring mmput
> through async irq_work is fine as it's fixed cost to keep track of
> that. But doing async VMA releases for each VMA seems like a bigger
> problem, as we'll need to dynamically allocate memory to keep a list
> of VMAs yet to be released, which sucks. So yeah, perhaps just giving
> up and making task_vma work only in "more normal" is what we have to
> do? With do have task_work to work around this, so task_vma is still
> extremely useful once add VMA snapshotting

Since the fix is targeting bpf tree let's do the simplest/minimal fix
if (irqs_disabled())  // EBUSY
No irq_work deferral at all.
Once the fix reaches bpf-next we can restart this discussion on how
to make it usable in a wider context.
I feel that with task_work all such cases of "nmi makes it hard"
should be punted to humans to refactor their code to use task_work.
