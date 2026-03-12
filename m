Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D013FA5F6
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333506; cv=pass; b=gV7CxAr9OBaxpEM6TBFXxOQ9qSallwtTc+grLHulEE8ywNXJpQ+Nd57WYD/+WvD27uRqsDJ+zN4YTSlzUgwHZ+7mLJuMSuiCSs/yhRRJIsed3ciprN+bava7v/Zok5drnjNrM5qgzukI48FH5vPOOwAP7tg7aqkjOlErhE1vuuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333506; c=relaxed/simple;
	bh=Vq8zGrcyKMyPY6bFkr2015tujlsc7yLdOU75ZkYUZ3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9+N+4q7iLEiuMrS0eUKk8fye7DXXLixHa62kljVX6BnLIt+UGi9oII4xEuT42OBB6xR06C30jvpZEbhliIitbG+w0igy32Y+yok4Je+6ck/hmzBaKe8h9qvtDJUS638ObhiXDLVlr6Pxm+OvtFx5MrFaoiKL4pP5dSeW8xcCcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg6sjPry; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg6sjPry"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso1378032b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773333504; cv=none;
        d=google.com; s=arc-20240605;
        b=U65N3cXNtHuGKq3pw9ao3lfMqDYVLRHCE0oYemIwBpyV+jaxJlTDvs8JmkPj3yBcZW
         WFsRAC/3k9nVHBH7wU/sNEsBEHLHfprc3kDjQejnGlrUr3bkZLVGJmA+7iTXY/s7zcq/
         LwBUfJ2kY+I43OE9duvXOMicyo9cBvkL5sHlEGcKqvaF/y7u5d3gGRE8x5AQmhHNMAWo
         NLS2akgJqJc/haSRBmQvB01PfaAXl5mTR2sdvNpphWAT08IGNRPSrItIU1ylwdEFvyxz
         yB0weoJ3gDwUKMel78CkIuzcLIytsm74fgWG25mycNSbJitgiKrWvJGpNbfS8sv2cLYj
         yf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hMIhXIeKjdIykADTnd/XofgmWW9k+oXupvgruobSlL4=;
        fh=tKRp3HLZWfldRsbobI5dTMQh0l8PkW3hScYzmE28uUs=;
        b=GGJoZYedshv09gWwyTKZai456ECvsBNito1CQk2AmrvRASFB5bY9aVAE517XRp6jeK
         FaH8qs7P0FJKs0zmu8jglXrd8oWhj+PNSOKKyEz5454wSP+v4Fpok+MM79Ci3B3f73ub
         1h3ZL1EPvJnwVPWJd/4OgVIly87ByL1eC/lxAZya0zgJe8wH6HRbeY7JxpAtHIR50z9J
         OL0VKuwbvyaUq0+rYleLiA1hftbWNbrugcFtFYs/5I36zz1HwPaxYNdDuk+XyPCoPrv/
         Sc6ErYNoI+bziQChQGVzSBd0xaKeok+mQA124BvArLlCYDqn0MfHSrB1kJ+ui1XdDA03
         6gkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773333504; x=1773938304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMIhXIeKjdIykADTnd/XofgmWW9k+oXupvgruobSlL4=;
        b=Bg6sjPrylc0yhPEkAYe8Bm4LKgB3GvcXCEj6eGoxihMpQm4FzJdDVgJ6HW9dQ1jwSv
         jxujeiboyhLObpdvWWTrunORx4nvPfDSCyFO7Ro5o+nkqfnjNQpuc4QwZQbwFG8catdR
         vWjrle4os7GIXXk4ezM3AzZMNZFYq6DVqUnD2wQHe9CJgg0lCIbtp98GVwWQQjyuF4f3
         1onYOsS+G3ETa/R7X/RKcwVserTJ7AGs14Iinkm3itctaV35BPkktCmt0vqTwRbpR5vd
         BxOcKdgp/a4l71M3h7Rgc9KmsxiBpHD/55UJyhIprlho4ZezcMNec2NkaQzfPpDmMm2n
         45RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773333504; x=1773938304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hMIhXIeKjdIykADTnd/XofgmWW9k+oXupvgruobSlL4=;
        b=nWdTVwz8lm0t8hVUnizEIUu9vld3Xpy59HRERuvc/SJiDhD2TQWKjurKbol9mYUgyR
         3oTbqHVktBDKCeX8v7HhriT/dHBsHSbH6UxLe5NxX1k+H5VzmirThXBDMDjw/xQaGsik
         AP3R/gGjOQYSud1YzeqRKuJ4jTpsgHzLi9aQNpp1Lqw7IUhsx3KGWA+b1x0oqIaEhFmR
         ZP0vA7w9EaOBXFnEjkroJkueL3DL0zEVHUmqrs3rag1ekwGp8YVxKrZmL7gYig7axJJq
         mGy/1suTi40kvCL7phw2aRn/djvQowx8m4YoCWLxn6W95wjlrPbrFWYm3fjXiSLp7t6K
         0UGw==
X-Forwarded-Encrypted: i=1; AJvYcCUw4t/Hu7yt6dh3S4NiAe+83FkaZfknSiCIQB63fq85V8d/XC0cAbpmhWW0C+mBwNdgKdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89VjKOwtSKtvXIy9Y5Aqbt47hPaBoCcJW8zUjk+xPQR5g8Ex8
	MdQGcyACF7VZsx0tzKV1Y1tebC5EUifUdKrdHWAL7NFwYnFO+x5+8iIDpAylR45vs0W0oZ4ssdJ
	X/jWxCN82EZwfP785rD/SchZa2IhZyZA=
X-Gm-Gg: ATEYQzzqGB6STaYMf98Nfj33iqXFSe33wLZakXoKJKpVikQ+cpox9t1bUV9dBZ9RUsH
	P14m5+jV8+YdKtmY0mJ1idU99QOjekEsys27pMazbE8lZGX3X2m4+DLP4vEVZi6HryjiBK1r2IG
	W+7PwIdo2Zfb8i1Sj5S18BPPIEF3srm64tf8/4Wd7ZrY1cJbu91qazGEL/FsXFripowJurmw274
	0uX+ZgpOMf8yFzEzuhvW1m+6nKfHYQ8RYRvGK2rK5bJslP3LQGGUm8gTNmU3FoIcXa7iy+Nnx0r
	KPKod77zorZAZKaKz5doQDw=
X-Received: by 2002:a05:6a00:428f:b0:81f:5acb:55fc with SMTP id
 d2e1a72fcca58-82a193bda03mr185131b3a.10.1773333503890; Thu, 12 Mar 2026
 09:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311225726.808332-3-puranjay@kernel.org> <480892a72caa391641ec52a010730d213241830683280a0583cfc334d8f39325@mail.kernel.org>
 <CANk7y0gOSQN7vULuBVwhVO=Tq6bB99jZwovras7F5yjNu5tVqg@mail.gmail.com>
In-Reply-To: <CANk7y0gOSQN7vULuBVwhVO=Tq6bB99jZwovras7F5yjNu5tVqg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:38:09 -0700
X-Gm-Features: AaiRm52nC7tCxZk0vrj-3snLqanOIvPk_g4kKb2cXSf8VgZB9XjpF1lL_46iie4
Message-ID: <CAEf4BzYupi9RwB0SC_QOKncNd4viNu6Yp4-kmnbS1846A-uL5Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 5:35=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Wed, Mar 11, 2026 at 11:53=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > > index 2ccdc3228063..50dbeaeafd86 100644
> > > --- a/kernel/bpf/task_iter.c
> > > +++ b/kernel/bpf/task_iter.c
> >
> > [ ... ]
> >
> > > +__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf=
_iter_task_vma *it)
> > > +{
> > > +     struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > > +     struct vm_area_struct *vma;
> > > +
> > > +     if (!kit->data) /* bpf_iter_task_vma_new failed */
> > > +             return NULL;
> > > +
> > > +     if (kit->data->locked_vma) {
> > > +             vma_end_read(kit->data->locked_vma);
> > > +             kit->data->locked_vma =3D NULL;
> > > +     }
> >
> > [ ... ]
> >
> > >  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma =
*it)
> > >  {
> > >       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > >
> > >       if (kit->data) {
> > > -             bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> > > +             if (kit->data->locked_vma)
> > > +                     vma_end_read(kit->data->locked_vma);
> > >               put_task_struct(kit->data->task);
> > >               /*
> > >                * mmput_async() -> schedule_work() -> __queue_work()
> > >                * takes pool->lock. BPF programs on traceable function=
s
> > >                * or tracepoints called under pool->lock, or programs
> > >                * running in NMI, can reach here and try to re-acquire
> > >                * pool->lock, causing a deadlock. queue_work() disable=
s
> > >                * IRQs before taking pool->lock, so irqs_disabled()
> > >                * detects both cases.
> > >                */
> >
> > Is vma_end_read() safe to call from NMI context here?
> >
> > The comment above notes that BPF programs running in NMI can reach
> > this code. The old code deferred the mmap_lock release via irq_work
> > when irqs_disabled() to avoid exactly this class of problem.
> >
> > vma_end_read() calls vma_refcount_put(), which can call
> > rcuwait_wake_up() when a VMA writer is waiting:
> >
> >   vma_end_read()
> >     vma_refcount_put()
> >       rcuwait_wake_up(&mm->vma_writer_wait)
> >         wake_up_process(task)
> >           raw_spin_lock_irqsave(&p->pi_lock, ...)
> >
>
> This is a valid concern and fput() will have similar problems because
> it calls schedule_delayed_work(). I will have to think about how to
> fix it, the easiest would be to add the following to new:
>
> if (irqs_disabled()) {
>       kit->data =3D NULL;
>       return -EBUSY;
>   }
>
> Then the mmput_async()'s deferral to irq_work is not needed because
> the iterator returns early in _new().
>
> But this will make the iteratory useless in NMI because
> irqs_disabled() would always return true in NMI (unless I am missing
> something)

It seems like having task_vma iterator work in NMI and irqs_disabled()
conditions is untenable due to all these issues... deferring mmput
through async irq_work is fine as it's fixed cost to keep track of
that. But doing async VMA releases for each VMA seems like a bigger
problem, as we'll need to dynamically allocate memory to keep a list
of VMAs yet to be released, which sucks. So yeah, perhaps just giving
up and making task_vma work only in "more normal" is what we have to
do? With do have task_work to work around this, so task_vma is still
extremely useful once add VMA snapshotting

>
> > If an NMI fires while the interrupted context holds pi_lock or
> > rq->__lock, this path deadlocks. The same concern applies to the
> > vma_end_read() calls in bpf_iter_task_vma_next() and
> > bpf_iter_task_vma_find_next().
> >
> > The task_vma iterator kfuncs are in common_btf_ids registered for
> > BPF_PROG_TYPE_UNSPEC, so perf event programs running in NMI context
> > can use them.
> >
> > >               if (!irqs_disabled()) {
> > >                       mmput_async(kit->data->mm);
> > >                       bpf_mem_free(&bpf_global_ma, kit->data);
> > >               } else {
> > >                       irq_work_queue(&kit->data->irq_work);
> > >               }
> > >       }
> > >  }
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2297=
8681697
>
