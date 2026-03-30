Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BA2874E3
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913790; cv=pass; b=XtuPn6jchPRtnDI3y2OwWGuC4WbViofrKlWYX4YRXRgRS3aH0dwXxsClyQ+u1lEPQhKCYFYwi/6NJ3099qTonXH/kB28hlEeHoH5QmlfTnCVmdTT2wGciQwQWc7Yi0jk9omZCyQTYlpdFEDFNAMjg+gD2FPr0KB9oYq8sxM6ie0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913790; c=relaxed/simple;
	bh=rKkCVzO634M/ykr5UfZa83m2Y2I1ajUSG3RHXMs3eSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6ruFtWW4qV/uhvxtwblKi65zVASd7hvXkvCDq8UqNJYUgMbyENUiOdz1kTY8VHIoJiQxDDUDGu8tJzB+KDBLq5CHkmNygSAR6sWshOM3iuAfISzzAQX/ULUt1bDDBS/kucItksiLLsui5xLvcTiXTw0VS+bA+sfQubY2fE5pMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drqDdAMT; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drqDdAMT"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66c4c7e2bb7so31534a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913787; cv=none;
        d=google.com; s=arc-20240605;
        b=F3ZoKjgz38iTstN/fn+KbvRy4I7OZp7rsTT6/mneayCH9Z4N4RP4qKUj7POTHFkQRp
         79MRCnXq9fbG2GXLbhfL7kmJ4VjqbDhm2sd5mBJM4PlFEeYxTCa0g1tbf24XCXM4D+B3
         XdahUGLqYFnzMoeYuq8fWWfsh7kg5mfnAhOBUD951VQzwD220Qx3a9OQFZo5qNwhnHMr
         3SP26H8e9C3V0sPnPtqIntkFFBvnuXHXZ4gEjv4bC6u754zB39cLpPO/CWchDG6xNM94
         BKm4yRy0ZxDDRDUs9A2KE+xM1sTCa1AUi/vtD/t07Jg8wj2mYxfwEDKkqJOUxFOVkp2K
         9oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KMyp+mvOr0w31wt4+m/LIlRYt9qtRsGLqeBPit9bg7U=;
        fh=s/U2tX1QyS+6Cr3UC+tsC37VXjN1NmMqAyctztF2ai4=;
        b=EF3gTXVxafFf9ECO9nIhF/gwXkVKfOS5QNP02BdJIm3SVUutsyXkxv/0T6CvW5Dt/B
         qH+OYD5Cu+qQbBxmFftQGdZ14b2Tm9XrH2ZJvoq/dOkKJjk9fUFM7dRMnesebiye3m0R
         kNjyBcPO+I5A+8HKuZL08cKL1aYNCApiTPsi7YJ9fSsVnXVGhEoAEUizC5U6VH+Iup8m
         ov109X0p0+U2X8lGBomBfV0q/d5DAYyjaPYQFtDLfr1pmSNjCbJAkssCLYJdoloW0CKX
         xUIUDxPda6EzoW9UJ94o6XP0Uc3mjjD6FQD/wyxV2zFQPLNGC37I29PfFagt8jPvWUlM
         Oyfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913787; x=1775518587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMyp+mvOr0w31wt4+m/LIlRYt9qtRsGLqeBPit9bg7U=;
        b=drqDdAMTH+osappY4ZplvfhopzUVYLcVNP+pVsyNuBH/x+iQQFff60STrdfTqGN/DN
         jPojgdlB0lrDxWdU4cxzWx3eyAEeCPQRCF8zJd0XZ3WztjUAPcrfzo3cHcPICcPnxrRQ
         tIDff8HKcJfrbNZkrNbsae+btiUKvH+mLh7ztQ82qINbLRsCblNcpzcChXiVGX2qArcW
         TmdMG/GLWY7f41b2ssvvoMQIpjbQM7p2jenKHv3q36NP8fV2aFVsVTPMfSS9nJCObvyW
         oasrbV6tF2oj0Swn7eSPCzoXOTRm4QoExKoAsj+UfXQmmJZ08lTyUPcOLLuif01HJwE+
         rriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913787; x=1775518587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMyp+mvOr0w31wt4+m/LIlRYt9qtRsGLqeBPit9bg7U=;
        b=re0igBE4qRPkXhWMnmVfaPvvcYUIi9aaiE/0ABFcaKqhrtSP5Q+4f4l7F7GNr1fQWi
         1oLvSK0khfTyKl7l9726o6CpIy6RQHE1YlyRiRPEZM2LXTAu8IZLr2SyDObFPX3TV9uA
         OCFn7Rr81jbQSVOhDoKpm2z1ges4edGHHU9hOEgSxPC8yFyscUOl1CDdphYwEEChflOq
         uUrceYZli+L2fOwgYvYRtkZRrEDgS+mN+OcrNRMpNqgDhT1pRzNpCl5AsdSnjxU1Eiyx
         03WyFaMJNNHYvkqytuhC/hQ2A6QZ5y/DR34v9hIvDG7wDv6eSHKsnN3IsekW8Dxyt4cy
         Rtcw==
X-Gm-Message-State: AOJu0YxwlDXkYFJ9XnemJHWN26zC2OpnF2Jgp8lpBZii/K7HFd/CKBDv
	NbdpQkvBhWrM6WOxSa7vkTb1mT7nODwj2pxilRfKeuaM7K3J1oqdTSXL6Pn+/a5twk2RjRBTEXu
	2nkuvU99xJ0zAKgbPuD6PTajeq9H8Owc=
X-Gm-Gg: ATEYQzxD7SuhDnYOBGH0dXdDUijFcU3EvstF+sJ1+NiU5QNKvb676rNuCpZ9ly7zvIK
	uPjpjwEE5gb8CyvHEduawfZcURS0EUgSBDUPsbnBgx8GUfP3sOT3ceiBjOVrWBYbIcvnhGT8S99
	4EKYcGippvUL0X5PRq4vS3veASrXKDElupZJk57zZVPXG1iNgWBqIv1XIa+0LUyCMvnXrxNzPY8
	wz3PN939ZtHOK3pWKhv4zqFaKe364+P3s8T8e3b7MADdDBWeOYgmWUqw2pKKxBjCNa6EffPC2xf
	XJhUk21pURvavd/eLJsujPHiR0m47dBrprh03uNBDQ==
X-Received: by 2002:a05:6402:3210:b0:665:33eb:22f9 with SMTP id
 4fb4d7f45d1cf-66b28365484mr7652555a12.6.1774913786707; Mon, 30 Mar 2026
 16:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326151111.4002475-1-puranjay@kernel.org> <20260326151111.4002475-3-puranjay@kernel.org>
 <CAEf4BzZ8iFDE6ym=EBC_PF7xYQrfQcGg4VvD9GG_rhvCH5wbeQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8iFDE6ym=EBC_PF7xYQrfQcGg4VvD9GG_rhvCH5wbeQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 31 Mar 2026 00:36:15 +0100
X-Gm-Features: AQROBzAyD5EojhW6pRA5ujJfUN3rzXF7l-WC2dX7gJh3XEmOMv_dIhnSyuM7G7g
Message-ID: <CANk7y0jKdj80htFFcL6ocQJh_S2aKPcTTVCJmPQ8orXrZqfJFA@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf v5 2/3] bpf: switch task_vma iterator from
 mmap_lock to per-VMA locks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 12:31=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 26, 2026 at 8:11=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > The open-coded task_vma iterator holds mmap_lock for the entire duratio=
n
> > of iteration, increasing contention on this highly contended lock.
> >
> > Switch to per-VMA locking. Find the next VMA via an RCU-protected maple
> > tree walk and lock it with lock_vma_under_rcu(). lock_next_vma() is not
> > used because its fallback takes mmap_read_lock(), and the iterator must
> > work in non-sleepable contexts.
> >
> > lock_vma_under_rcu() is a point lookup (mas_walk) that finds the VMA
> > containing a given address but cannot iterate across gaps. An
> > RCU-protected vma_next() walk (mas_find) first locates the next VMA's
> > vm_start to pass to lock_vma_under_rcu().
> >
> > Between the RCU walk and the lock, the VMA may be removed, shrunk, or
> > write-locked. On failure, advance past it using vm_end from the RCU
> > walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
> > stale; fall back to PAGE_SIZE advancement when it does not make forward
> > progress. Concurrent VMA insertions at addresses already passed by the
> > iterator are not detected.
> >
> > CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/task_iter.c | 98 +++++++++++++++++++++++++++++++++---------
> >  1 file changed, 77 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index faf4d6197608..46120745ee84 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/bpf_mem_alloc.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/mmap_lock.h>
> >  #include <linux/sched/mm.h>
> >  #include "mmap_unlock_work.h"
> >
> > @@ -807,8 +808,8 @@ static inline void bpf_iter_mmput_async(struct mm_s=
truct *mm)
> >  struct bpf_iter_task_vma_kern_data {
> >         struct task_struct *task;
> >         struct mm_struct *mm;
> > -       struct mmap_unlock_irq_work *work;
> > -       struct vma_iterator vmi;
> > +       struct vm_area_struct *locked_vma;
> > +       u64 next_addr;
> >  };
> >
> >  struct bpf_iter_task_vma {
> > @@ -829,15 +830,19 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
iter_task_vma *it,
> >                                       struct task_struct *task, u64 add=
r)
> >  {
> >         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > -       bool irq_work_busy =3D false;
> >         int err;
> >
> >         BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(=
struct bpf_iter_task_vma));
> >         BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __=
alignof__(struct bpf_iter_task_vma));
> >
> > +       if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
> > +               kit->data =3D NULL;
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         /*
> >          * Reject irqs-disabled contexts including NMI. Operations used
> > -        * by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_=
async)
> > +        * by _next() and _destroy() (vma_end_read, bpf_iter_mmput_asyn=
c)
> >          * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
> >          * Running from NMI or from a tracepoint that fires with those
> >          * locks held could deadlock.
> > @@ -868,23 +873,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
iter_task_vma *it,
> >                 goto err_cleanup_iter;
> >         }
> >
> > -       /* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_g=
et_irq_work */
> > -       irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work=
);
> > -       if (irq_work_busy) {
> > -               err =3D -EBUSY;
> > -               goto err_cleanup_mmget;
> > -       }
> > -
> > -       if (!mmap_read_trylock(kit->data->mm)) {
> > -               err =3D -EBUSY;
> > -               goto err_cleanup_mmget;
> > -       }
> > -
> > -       vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> > +       kit->data->locked_vma =3D NULL;
> > +       kit->data->next_addr =3D addr;
> >         return 0;
> >
> > -err_cleanup_mmget:
> > -       bpf_iter_mmput_async(kit->data->mm);
> >  err_cleanup_iter:
> >         put_task_struct(kit->data->task);
> >         bpf_mem_free(&bpf_global_ma, kit->data);
> > @@ -893,13 +885,76 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
iter_task_vma *it,
> >         return err;
> >  }
> >
> > +/*
> > + * Find and lock the next VMA at or after data->next_addr.
> > + *
> > + * lock_vma_under_rcu() is a point lookup (mas_walk): it finds the VMA
> > + * containing a given address but cannot iterate. An RCU-protected
> > + * maple tree walk with vma_next() (mas_find) is needed first to locat=
e
> > + * the next VMA's vm_start across any gap.
> > + *
> > + * Between the RCU walk and the lock, the VMA may be removed, shrunk,
> > + * or write-locked. On failure, advance past it using vm_end from the
> > + * RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall back
> > + * to PAGE_SIZE advancement to guarantee forward progress.
> > + */
> > +static struct vm_area_struct *
> > +bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
> > +{
> > +       struct vm_area_struct *vma;
> > +       struct vma_iterator vmi;
> > +       unsigned long start, end;
> > +
> > +retry:
> > +       rcu_read_lock();
> > +       vma_iter_init(&vmi, data->mm, data->next_addr);
> > +       vma =3D vma_next(&vmi);
> > +       if (!vma) {
> > +               rcu_read_unlock();
> > +               return NULL;
> > +       }
> > +       start =3D vma->vm_start;
> > +       end =3D vma->vm_end;
> > +       rcu_read_unlock();
> > +
> > +       vma =3D lock_vma_under_rcu(data->mm, start);
> > +       if (!vma) {
> > +               if (end > data->next_addr)
>
> here you have vma->vm_end on the left side
>
> > +                       data->next_addr =3D end;
> > +               else
> > +                       data->next_addr +=3D PAGE_SIZE;
> > +               goto retry;
> > +       }
> > +
> > +       if (unlikely(data->next_addr >=3D vma->vm_end)) {
>
> here you have it on the right side... which just makes it harder to
> compare two cases for no good reason...
>
> here you actually do the "else branch" but for already locked VMA, so
> make it easy to see this analogy:
>
>
>        vma =3D lock_vma_under_rcu(data->mm, start);
>        if (!vma) {
>                if (end <=3D data->next_addr)
>                        data->next_addr +=3D PAGE_SIZE;
>                else
>                        data->next_addr =3D end;
>                goto retry;
>        }
>
>        if (unlikely(vma->vm_end <=3D data->next_addr)) {
>                data->next_addr +=3D PAGE_SIZE;
>                vma_end_read(vma);
>                goto retry;
>        }
>
> isn't it easier to follow?

Yes, I agree. Will use this approach in the next version.
