Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793338A70E
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273281; cv=pass; b=qZEftou12EgVM7MQ+H67+T8QLpc4A92EFsrYwJGbwJrACgm4rqPgbq/fogstS6ONFwzn8VFLjrh12pdGXn1q5DrigsQUzza3Ph5clFsf0EnaYr1XU+w/IPYTvKJcZDnutr20mk2ycodGDwIVv9bPu9HmISQ/3uIcnlfjZuvNeo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273281; c=relaxed/simple;
	bh=PAtyFNoU4Vvth0rHO2KzQt3jjca13kupc9tJUaaD5iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ck2wOxhRYHWozB63HgaIpoxMn6IdinB4FWyab8qwGhCwzLbYRRpL7dfF8TgYwRke5zTTGzYQrV2pMkdN0glRxZzITgHoa6X8caKfQZfxzuKUVayQkS5Cexei2aTKGNQcJMcm1NDM1vXcnZF7iQckwExO4qplEXqYDj1tTyQrqlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQWy+7iO; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQWy+7iO"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829759ca646so242847b3a.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773273279; cv=none;
        d=google.com; s=arc-20240605;
        b=EWhwljh3ht90+/5EnA7S6h0P8zVhK4RnR5NB72qp2EObINGla7vq77enqCMDyMKB3w
         RcJXLQHIfXlj/V7PwgFEluKI1SIE4Etqr1F72XPDAE6unhv1k+DKnGVV2GTJ80JC1bNW
         evax2a4QETmhNeIZk6Vt9KWSfMUGR4eXjQ7eMOMSuNbqQRNlM+30bKzyMKJU+0/PJC9a
         l8MuH/iY5AMwZLcYoL6XDjjQNc6JD8Ukj3Mx4QYPP3zsydeqzYVB62y200+4bEOcltku
         Lwy2bSj1R7LpnpAqPq8jBnbXkSntA+cbzOtADOBQhIfdvJb3/RIiidAXopm4EqNEOh+q
         eo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=29In+3CYaUYaoJ616C0iqqJdt2LJEnbbMY9vwWPwx4U=;
        fh=zIA5VqOoiS6QIBPqtvlAo6yNlmLdFZ6cWuvLt3gfFMw=;
        b=ddaxBEU0Onfpru6dEynMQqknJbNK7qMAF3FktgxVh9SYKPd3jK8R8kSE3ZmvgcawGf
         atgm9+psgA+bwq2og9WdlPs2lBsJyq+w4gsk1JyEI9SiudsaUtUgtREMEadiIFfPseax
         26TsL57dQZoVCPZkDDStvB3e7DF+Wm54Te5DFSNWc25yUV95TCtHhD6gPdDy0kj87VOR
         vB5bwEFPRlbmQh+qJZjNF/+/lgqFynfNWvQHYi8zeD48ckCt3T4esj+gL5v8U4vc2pl0
         nSYQz/FPfRfRMcFN1mqTrpbWbwK9FXVSUObIEQ8YPZfLMmV2YEfBPR5n/JNUmVFkTDqr
         tICg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773273279; x=1773878079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29In+3CYaUYaoJ616C0iqqJdt2LJEnbbMY9vwWPwx4U=;
        b=DQWy+7iOM7hrDs/0Jgp+nsA32Udm6+cR2YR8VA1iri4tPboe+V/NZxhJ3P6TzuRzhn
         5XQiXdAo6O3PEDXccljDsNGzoS4zMf7+B1CiAzq1eKv94cFs9wx/P1jvtYgmJgApYWB4
         uHDbMdz9fNesQFiQTYBxC/Tbq7kwqrrbQJGFKIVmDlQY4cggjovlH9Tbwy7PW+YWG1cK
         cTEW+IdTv3tfjbZJrZsVQVYz70YmU78RJIskdJZIKr0iSsnnaUCACli29Maiv3VJ+t/p
         DT1QH42W5bKYgk02ca3zCtk+sSVeKT5x0IdLd2nMk/alg9IyCtOrxl41f7SH6gKbmDMX
         cy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273279; x=1773878079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29In+3CYaUYaoJ616C0iqqJdt2LJEnbbMY9vwWPwx4U=;
        b=wz6AhKBZEVtlBVZcA709sSnp8w06y7ZqDkXtqWxPWykpkagKG+bXdr2Z5w0zG+zWL0
         ZlO4GmmIYlCrxLQn8l2OdNT09Vt1koMc0VpzVeNifg/hiaHTB1jvue+ZTuv1MT11zdtZ
         fjDS9xWXRiE9yF5jWULSreWyINeYX5t4RskiV6CKc/jnOQ4CVQTNNvw5BrO/r5FYFjwC
         jSl3LJtFJKpJL4q6sLzRBK1id/pAlcDwSiM8CeQhL/lEftAf/0fKiD5Xks8JKdGqxG0f
         2R4S1KNVXth+/rqN5EyEQO10QxGiOTIcoU+9ZenSday4OUut4kUT1AQ9zxfFepjCrqN2
         HBWA==
X-Gm-Message-State: AOJu0Yz10EJqZ4l96+796mFFuGY/Po95n7275Nh2B/Os5PHop9tEdgRc
	cD5c2h7wNgtNFlHPkSIpDuPmiQqL9hG+KYVrwKhri01G+g9pe0BqTrzlOcQfzD7n3PiIXm3QZgX
	PNCSRKJ5YspYKgBp73qtqTLlnAF7Gjl0=
X-Gm-Gg: ATEYQzwF4CjqZdvlnJQQzNYiNr9ejiehC1g78dl+AV/iBXf/1fguJYSRLMpjxuFKgOA
	PX6gN9TebF0LwQM3nmM7YR+hLg+vyCc0cY+WLthmvygzN40XKNF3BL2Z2DNXN9CQ8HwWegoA+DR
	rQskXacWE0R1jrc4Q8sH5z7idUuVEfnyplVOk37S/n7MoJXOy+d6TXi9dvT2++740CmcQxnk91b
	y18m8i8pYWDDefiF474iafYL8scqJHo2ybPRC1mlNbppBaqGUeTpJm1nP2jxE9caUoD2gZiRJ6Y
	BKLgL5U=
X-Received: by 2002:a05:6a00:9485:b0:829:862d:6b46 with SMTP id
 d2e1a72fcca58-829f707339dmr3361698b3a.6.1773273279506; Wed, 11 Mar 2026
 16:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-4-puranjay@kernel.org>
 <CAEf4BzZiVQ2=UKXOVs7Y5NArhmQvW81EpzMbkOogHgNnbjUcXw@mail.gmail.com> <CANk7y0jbtPSkOoxjZGQ3aRuiQLSUjQr78CNp5NDLjm_R3eVGOw@mail.gmail.com>
In-Reply-To: <CANk7y0jbtPSkOoxjZGQ3aRuiQLSUjQr78CNp5NDLjm_R3eVGOw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 16:54:27 -0700
X-Gm-Features: AaiRm5341S3A2UAQNZSY4PmIYufNJSYFAb-65hEzDNpJfXyE4mfnBU1MrUQNnEk
Message-ID: <CAEf4BzaBwvVwkFo2Jq7-NvJL4=+4wZ9TagmQLjRf4QAW3Qqy1A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/4] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:25=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> On Wed, Mar 11, 2026 at 7:00=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> > >
> > > The open-coded task_vma iterator holds mmap_lock for the entire durat=
ion
> > > of iteration, increasing contention on this highly contended lock.
> > >
> > > Switch to per-VMA locking. Find the next VMA via an RCU-protected map=
le
> > > tree walk and lock it with lock_vma_under_rcu(). lock_next_vma() is n=
ot
> > > used because its fallback takes mmap_read_lock(), and the iterator mu=
st
> > > work in non-sleepable contexts.
> > >
> > > Between the RCU walk and the lock, the VMA may be removed, shrunk, or
> > > write-locked. On failure, advance past it using vm_end from the RCU
> > > walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
> > > stale; fall back to PAGE_SIZE advancement when it does not make forwa=
rd
> > > progress. VMAs inserted in gaps between iterations are not detected.
> > >
> > > CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > ---
> > >  kernel/bpf/task_iter.c | 91 +++++++++++++++++++++++++++++++++-------=
--
> > >  1 file changed, 72 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > > index e8efc9e1f602..e20c85e06afa 100644
> > > --- a/kernel/bpf/task_iter.c
> > > +++ b/kernel/bpf/task_iter.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/bpf_mem_alloc.h>
> > >  #include <linux/btf_ids.h>
> > >  #include <linux/mm_types.h>
> > > +#include <linux/mmap_lock.h>
> > >  #include <linux/sched/mm.h>
> > >  #include "mmap_unlock_work.h"
> > >
> > > @@ -798,8 +799,8 @@ const struct bpf_func_proto bpf_find_vma_proto =
=3D {
> > >  struct bpf_iter_task_vma_kern_data {
> > >         struct task_struct *task;
> > >         struct mm_struct *mm;
> > > -       struct bpf_iter_mm_irq_work *work;
> > > -       struct vma_iterator vmi;
> > > +       struct vm_area_struct *locked_vma;
> > > +       u64 last_addr;
> > >  };
> > >
> > >  struct bpf_iter_task_vma {
> > > @@ -858,12 +859,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bp=
f_iter_task_vma *it,
> > >                                       struct task_struct *task, u64 a=
ddr)
> > >  {
> > >         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > > -       bool irq_work_busy =3D false;
> > >         int err;
> > >
> > >         BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeo=
f(struct bpf_iter_task_vma));
> > >         BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D =
__alignof__(struct bpf_iter_task_vma));
> > >
> > > +       if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
> > > +               kit->data =3D NULL;
> > > +               return -EOPNOTSUPP;
> > > +       }
> > > +
> > >         /* is_iter_reg_valid_uninit guarantees that kit hasn't been i=
nitialized
> > >          * before, so non-NULL kit->data doesn't point to previously
> > >          * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> > > @@ -879,12 +884,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf=
_iter_task_vma *it,
> > >                 goto err_cleanup_iter;
> > >         }
> > >
> > > -       /*
> > > -        * Both mmap_lock and mmput irq_work slots must be free for _=
destroy().
> > > -        * kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock=
_get_irq_work
> > > -        */
> > > -       irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->wo=
rk);
> > > -       if (irq_work_busy || bpf_iter_mmput_busy()) {
> > > +       /* Ensure the mmput irq_work slot is free for _destroy(). */
> > > +       if (bpf_iter_mmput_busy()) {
> > >                 err =3D -EBUSY;
> > >                 goto err_cleanup_iter;
> > >         }
> > > @@ -894,16 +895,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bp=
f_iter_task_vma *it,
> > >                 goto err_cleanup_iter;
> > >         }
> > >
> > > -       if (!mmap_read_trylock(kit->data->mm)) {
> > > -               err =3D -EBUSY;
> > > -               goto err_cleanup_mmget;
> > > -       }
> > > -
> > > -       vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> > > +       kit->data->locked_vma =3D NULL;
> > > +       kit->data->last_addr =3D addr;
> > >         return 0;
> > >
> > > -err_cleanup_mmget:
> > > -       bpf_iter_mmput(kit->data->mm);
> > >  err_cleanup_iter:
> > >         put_task_struct(kit->data->task);
> > >         bpf_mem_free(&bpf_global_ma, kit->data);
> > > @@ -912,13 +907,70 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bp=
f_iter_task_vma *it,
> > >         return err;
> > >  }
> > >
> > > +/*
> > > + * Find and lock the next VMA at or after data->last_addr using an
> > > + * RCU-protected maple tree walk followed by lock_vma_under_rcu().
> > > + * On failure or if the VMA changed, advance past it using vm_end fr=
om
> > > + * the RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall
> > > + * back to PAGE_SIZE advancement to guarantee forward progress.
> > > + */
> > > +static struct vm_area_struct *
> > > +bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data=
)
> > > +{
> > > +       struct vm_area_struct *vma;
> > > +       struct vma_iterator vmi;
> > > +       unsigned long next_addr, next_end;
> > > +
> > > +retry:
> > > +       rcu_read_lock();
> > > +       vma_iter_init(&vmi, data->mm, data->last_addr);
> > > +       vma =3D vma_next(&vmi);
> > > +       if (!vma) {
> > > +               rcu_read_unlock();
> > > +               return NULL;
> > > +       }
> > > +       next_addr =3D vma->vm_start;
> > > +       next_end =3D vma->vm_end;
> > > +       rcu_read_unlock();
> >
> > are we doing this whole vma_iter_init+vma_next just to differentiate
> > between lock_vma_under_rcu() return NULL because a) there is no VMA
> > anymore and b) VMA is/was there, but we failed to lock it? Is that
> > right? If so, let's add some explicit comment explaining that aspect
> > specifically?
> >
> > better still would be to change lock_vma_under_rcu to return
> > ERR_PTR(), maybe mm folks won't be against that?..
>
> lock_vma_under_rcu(mm, addr) uses mas_walk() internally which only
> finds a VMA that contains addr (i.e., vm_start <=3D addr < vm_end). If
> addr falls in a gap between VMAs, it returns NULL. It cannot iterate
> forward to find the next VMA. The RCU walk with vma_next() (which uses
> mas_find()) finds the first VMA at or after last_addr, bridging gaps.

I see, makes sense. I missed this bit.

> This is the reason we have to split it into two parts. We could have
> used lock_next_vma() but it fallbacks to mmap_lock. We could create
> new helpers in the mm/ that don't fallback but return NULL, but I
> wanted the changes to stay within BPF code.
>
> > > +
> > > +       vma =3D lock_vma_under_rcu(data->mm, next_addr);
> > > +       if (!vma) {
> > > +               if (next_end > data->last_addr)
> > > +                       data->last_addr =3D next_end;
> > > +               else
> > > +                       data->last_addr +=3D PAGE_SIZE;
> >
> > this feels very arbitrary and kind of wrong. if we are unlucky to look
> > up vma that was moved to earlier, next retry won't look it up anymore,
> > and we'll get better vm_end. So instead of arbitrary + PAGE_SIZE,
> > let's just keep last_addr as is and retry?
>
> There's no guarantee the stale maple tree entry is gone on the next
> retry. If the concurrent writer hasn't completed the RCU-visible tree
> update, we'd see the same stale entry and spin without progress. The
> PAGE_SIZE fallback provides a hard forward-progress guarantee for this
> case.

hm, ok

>
> > and speaking of, we should still pass data->last_addr into
> > lock_vma_under_rcu(), IMO, given our vma_next() is speculative, no?
> >
> As explained above, the reason for splitting is not error checking,
> can't pass data->last_addr to lock_vma_under_rcu() because
> data->last_addr could be in a gap.
>
>

[...]
