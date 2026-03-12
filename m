Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955112512DE
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275746; cv=pass; b=eZEtGuRmEMiTOUFWFjpNRLMoK8jIPvM4FPIpRBb2aGOpRLnU4D2MsVevL1QA8Bi786h6pY2zsSZSjJ5bepyX59vZmfMy5b1DvvOxiimfq5rZNzYUVkZtn5BL78vi9UGPSCVApofNJPyZLjGzlL5RahKrl43nCOLcgopP77uXkjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275746; c=relaxed/simple;
	bh=1JvWAZWExy+VqPTR1n/QwQ7c24F+TMl5x108hGrmWpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQmmjkZD8JEIHxmaXHzpHRb4LsUpr4GLeDn6Bt0I7vLDo67eyXoFtKpTmkXa71L3dX0piUZH5FlzemT1OQLhiHXVrz9fzpf+h3yrzOckGq26R1h2GtIL9HF17KKLKyyvcTSsIakYlgnImNjb8o/tbHs8kly0IjDvm9rObkrhabM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0nl4Nwx; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0nl4Nwx"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936331786dso48222566b.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 17:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773275744; cv=none;
        d=google.com; s=arc-20240605;
        b=jy4dfn2WlGbzKtA7DBNyPI1XoTaD6vkGQIMdrs+Bs2Lv5ZdR5h08DUjIuEeKUeXpDh
         nuaGF0M4RTuRAA1qSeJEfcKWoLQpN93a2p+3oeWq9S4Q2m1VM7qEWlDih9LOXaHBmRKd
         I7rNYaE3ZLgLL5qWvICk+OOJ3hVLPq8VmEbKGKq+gdvHCUP8zfS8/5img/lgB3VhAErC
         SDWygBtoyBaQpXOt7etKg/RvW2TudtsOgUlRv+HwEyYCI5fpcBUEXlpp4J5/PFFw9nyY
         5Xz6lwEcb7QZLsTIKZLxL4EDBhcdYnLIsfLF94BKCR/+sfIohuAz1q4AemZKVtBQs2aS
         aObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Avm1ud4vVifZjsgecOmKobnWr0DR9jGYcoaueKEqoLw=;
        fh=p9R8I3N69Ro6zTrNSn+S4t/IvOj46g+dlqtALAMwpw4=;
        b=aDXgRTOahfbDyfi1DLnMLzTDQm5oGH2ZBKjfA9tTQ5ZhbHng7jELm0WNPLto7/u5mA
         9EulPmjHC1UXtI7354LxZH1hANWTyzrmqSFICf7WfmtUCYnw3pB41YyxXKHmTt3IZxJn
         MMYpNzoJvnEGZus0fvxAVLYd1ds+3Zbm9Nqfe4yMrDipkBj33pNEGSBLLPGmbvZMxyrM
         iHs5kmvj+wv6TybVESrOua6li8lqjox0KwbiDJRIqyh9vEHa49VxGNwDbFMGt1Hl7Kxj
         mtuHJUVTE029ApGaBZKCFzyepuqK+2VucNTGcaxmZas1j0B4jiCXks/xh7wtoZ6WPEJm
         yCrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773275744; x=1773880544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avm1ud4vVifZjsgecOmKobnWr0DR9jGYcoaueKEqoLw=;
        b=X0nl4NwxwQV7WIfoo7WZixgw82dnE+LA02SlpUB5SZlh6B2AJb8c9QAPu2CP+/047u
         3LMFyyOFzy9uCn5yApc5VumP201MCHaBiw+YYXHVIFwwyDMt9jnZlWj0U7I79H4lYhFY
         lzCzC2RGmDBjmJfsApt5Vkh8ohHteMl0CZY7RLIami4488vvUTcgcOoACvR8sYSrekkv
         grCIRWQdzBPnPyI/cMRDQkoBudpyA+ooHj551rPWBZUJ2IqMetHLSaKZLIo+r2qQ+Iww
         pokS27Ivm94seN9hAkYj6puuYRLw5uYIbOchxGSliep3efFvomeQa6UqzY5eb6ebWTKd
         DGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275744; x=1773880544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Avm1ud4vVifZjsgecOmKobnWr0DR9jGYcoaueKEqoLw=;
        b=ZbR053i1OzHoKP6kxdvskvfpevlY2SaMOhlBh5IFDtB2xPe7ceqgle+n6Q0bOT5iQq
         fngyPutmKg+q02Mtj/qRkU+AdK9K1e1isyvLidlLkDHXkRhvNSAStEyCtQ4NdnCviQzq
         9JIgLXiQ0GR5CXr9lreDFoepfgV3cjXGpsopoJ0LewI3BQpBCD90qRpD1XXXQ/YuJ6nx
         p/LKHKgvBrNZWtaFsaitPGcZeub5VcZn5mNeqAR2lX8wbyfeHBtsFcER2qdb82S69aVc
         KFyurMGs6xO3i9dwK9c03T+GJBklzJLWCG+EmPMsIoCmKCazDsJWtjPJpexZI/dz1x+T
         ki6A==
X-Gm-Message-State: AOJu0YzHqnznvBhD002JNV+y876T3lwIy7NhFxf7xbXy7Rq9an644BYO
	8XmB4kV03UelcUdv7PS3LrN9unwwlMqlBGaglC2UHUafqWY0tDt0+AMye1ivhpX7vrCoVJtGLHz
	9O+BuOBLNWYxkeQedHdsJEXk/oh7u2i0=
X-Gm-Gg: ATEYQzyAsqRrE08NGzeSk6YyUWwCcPAMBGXfHeB2ow+Mv4Ez5KEdHJqxpTcRIPURAdZ
	lep8oYlCmlLsH9mJJNZYcfZmOPEqAz/ITMxQhbjImNQAk39pshm4h4JPoEUEdA/FnuxwymJo+Mg
	QnU4x3/TyiWmDWPqHTctKFueLMWTCxViEXp9Vzg2B2lpND+52t6lgvR3b6trdDYZUoDdZCSaXN3
	q28Wgea3zPG5lwUwidRJknS7VsV1fqGKNQj4KUwCQ8SQ1kEPL8W+DP1JmjJb7u1T5Feqxoy17XH
	/WgdUHg118Uonu5ZSmF9JHuez4Bqy57mn3qPdmBgDw==
X-Received: by 2002:a17:907:c1a:b0:b96:fbeb:f7b0 with SMTP id
 a640c23a62f3a-b972e508856mr256631566b.39.1773275743712; Wed, 11 Mar 2026
 17:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311225726.808332-3-puranjay@kernel.org> <480892a72caa391641ec52a010730d213241830683280a0583cfc334d8f39325@mail.kernel.org>
In-Reply-To: <480892a72caa391641ec52a010730d213241830683280a0583cfc334d8f39325@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 12 Mar 2026 00:35:32 +0000
X-Gm-Features: AaiRm50Tz3caGo1ferZ9lksPWV8OqlRcZW9C65MhZSPZyRuBwrcXMOdvK8y9GcI
Message-ID: <CANk7y0gOSQN7vULuBVwhVO=Tq6bB99jZwovras7F5yjNu5tVqg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:53=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index 2ccdc3228063..50dbeaeafd86 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
>
> [ ... ]
>
> > +__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_i=
ter_task_vma *it)
> > +{
> > +     struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > +     struct vm_area_struct *vma;
> > +
> > +     if (!kit->data) /* bpf_iter_task_vma_new failed */
> > +             return NULL;
> > +
> > +     if (kit->data->locked_vma) {
> > +             vma_end_read(kit->data->locked_vma);
> > +             kit->data->locked_vma =3D NULL;
> > +     }
>
> [ ... ]
>
> >  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *i=
t)
> >  {
> >       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> >
> >       if (kit->data) {
> > -             bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> > +             if (kit->data->locked_vma)
> > +                     vma_end_read(kit->data->locked_vma);
> >               put_task_struct(kit->data->task);
> >               /*
> >                * mmput_async() -> schedule_work() -> __queue_work()
> >                * takes pool->lock. BPF programs on traceable functions
> >                * or tracepoints called under pool->lock, or programs
> >                * running in NMI, can reach here and try to re-acquire
> >                * pool->lock, causing a deadlock. queue_work() disables
> >                * IRQs before taking pool->lock, so irqs_disabled()
> >                * detects both cases.
> >                */
>
> Is vma_end_read() safe to call from NMI context here?
>
> The comment above notes that BPF programs running in NMI can reach
> this code. The old code deferred the mmap_lock release via irq_work
> when irqs_disabled() to avoid exactly this class of problem.
>
> vma_end_read() calls vma_refcount_put(), which can call
> rcuwait_wake_up() when a VMA writer is waiting:
>
>   vma_end_read()
>     vma_refcount_put()
>       rcuwait_wake_up(&mm->vma_writer_wait)
>         wake_up_process(task)
>           raw_spin_lock_irqsave(&p->pi_lock, ...)
>

This is a valid concern and fput() will have similar problems because
it calls schedule_delayed_work(). I will have to think about how to
fix it, the easiest would be to add the following to new:

if (irqs_disabled()) {
      kit->data =3D NULL;
      return -EBUSY;
  }

Then the mmput_async()'s deferral to irq_work is not needed because
the iterator returns early in _new().

But this will make the iteratory useless in NMI because
irqs_disabled() would always return true in NMI (unless I am missing
something)

> If an NMI fires while the interrupted context holds pi_lock or
> rq->__lock, this path deadlocks. The same concern applies to the
> vma_end_read() calls in bpf_iter_task_vma_next() and
> bpf_iter_task_vma_find_next().
>
> The task_vma iterator kfuncs are in common_btf_ids registered for
> BPF_PROG_TYPE_UNSPEC, so perf event programs running in NMI context
> can use them.
>
> >               if (!irqs_disabled()) {
> >                       mmput_async(kit->data->mm);
> >                       bpf_mem_free(&bpf_global_ma, kit->data);
> >               } else {
> >                       irq_work_queue(&kit->data->irq_work);
> >               }
> >       }
> >  }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/229786=
81697
