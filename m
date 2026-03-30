Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61737E310
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913518; cv=pass; b=K6DMUFgJTgbQT/U9HKiITLfRowi/7IsjHH/GHksXZGf44sNUJGNr2YNiakO8gf0AkWeEN8qmkZ2iw55jgVZLxyYAgHMzHRU3txnihv7X40cRf2mzw06VPO28K5yXpBWfFQYh7lai55fUAja9z/FgTND6nGew4/LUSS/l93ihHLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913518; c=relaxed/simple;
	bh=LiDaoLvabRPL0mOb5WxPWLB5Lt6yNKtDpZTaGBSaOyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5HmpJ+D6sBbjHjdrYq41WB+7L6V8WqIIeKuz8XPZ3Rik1AgSzsaaFGyeJylC494n6WRxofMji9PcFgcWiG8tuCni+qqr7YsA8H5EdUonDyaS2A9MQx6qzyDj0yWT3Va5jlnrEGAUNdcSOV9tDdKjzHhvRcU82kb6Uh1bin9nUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbjGDuJY; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbjGDuJY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829781b2b01so2552312b3a.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913516; cv=none;
        d=google.com; s=arc-20240605;
        b=hsWO5d2hfI2ttLqSp0AHq0MwyzQhDeE6Jx3AQP3jqz9MGJlNvlWi9j5dfPzD0kPF8+
         gv5yE51mychWQTf/a6C5SaJVuMeErMc4r5mFMPMKnfcVAvH5syrJZMoBqpfA/B3mTzRB
         0POM5eE1r+DFz7cXqztrBre2BECni6q+RhX0pAAbrAHDhSaqIwOU6ufmQGyACKjLsnol
         fP9Tmym96dLq14LH73tNwPcC0/QjWqi0vd4HwJJ/zqWeHd3oCb9HjUlHZsPry97U+aoY
         x85xlMfYKA/B1P9F1KkqISgQvSzB9Vx8iRLlGIDvFyDWnJk8ooL0tWVT5ds74u3N3s4Y
         uB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZwuq8ajv/3n4V4/Zuj1tgjOsXF9QFRml2YXxWJ+TbE=;
        fh=3JFULSt81QhP9ARgOVVWpn+UY1r04WcyvJhNnAO9JVY=;
        b=NPDoQ2MJ9Lcqh1kGffEm+e0aos8YBOQ25aFR/ubI2Ss4iDkPXTlK4O+I4Q1T7AwN0s
         SCxp2A8fytTXQbwk3IwGEfGFt5cdp/2lyKjqzNy+1d3mIPO87fMfOW2RX7wVzdy6u1GP
         TOLsBwAfG8RcZ714CdtUQxWTnGf6NX4+/l4bLibFhi9nUAKK2f11h+a6qb7/Ryr/+qh1
         s6UdDbLb+lNgr5212DpaNrfJwtGmQlceJZKlZFEyGf/uiLguWIC6zVXhfnQwnHlPliLh
         ki8pg3A9OHDMf0mNf4A27OCr5LtX3WJ/0cLfD2g9M2dxqcLhnqYBLbULahc5cmeexT1L
         lvlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913516; x=1775518316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZwuq8ajv/3n4V4/Zuj1tgjOsXF9QFRml2YXxWJ+TbE=;
        b=BbjGDuJY6I/zx/oAl0MyKpvHRdH3wU52QGoSgod8rGMHwsxLOrvS1uj0jK2ZRmmSyb
         i9ITX2/oDXF0DjNI1Kr88B21vhPQ1oHdfJ1Stje+ZOZRpOqM7coJN65Y28sxXyTI6RfO
         DdGhfEd8pZfF5gDMKG6fx/Nr7ThL17BeSrBdTgva6duu2chXPQ4LOphteBpXNJqrW1vr
         XBW4/2rsCVmQCF2HJP+4hNtgtL6lL/5ECINEczYGm7+MfmTBeVTsPFlOQ/WM3+sh/iQd
         CGOF03PNY1J5i74OAse19Nivp0Of0wsKUQuNzFsqK7Pjtojqj3mqxWLx/HOlgROcsgAo
         CnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913516; x=1775518316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZwuq8ajv/3n4V4/Zuj1tgjOsXF9QFRml2YXxWJ+TbE=;
        b=Y0yBicIxxK1KJU/zBBl6wUU7Z6BvggbHcbOkdBpvp3mNjNBWfd+z+102rcmLwKZuR8
         R37wF9RvYZMAXOMgN2BvU9TL30O1iYDDopHjir5SiiHEARIP8jyhsfaWMjyhcOZkbf3g
         RBdcDmkOcROPXNcpYbYSp0OeumQ+UqFsC2uHDWLdTTbauo1zVIBX7AE9rfsqaot8fCln
         Dv9HmXFF/D9jj2i7AQ6hsudJXcL1asVSsEx9iLtEn1uEqbdhduvzDx/0otQc7Bz1yq4d
         //xrUgf0R+OB9PRfOoYeXb9mMOEDvy9UayEyt3kZQbGLgamuuU1HND6D9QPZGjS/4SMD
         mQ8w==
X-Gm-Message-State: AOJu0Ywza/vN5saKWhOYdtEn6EE/dGxww0T5lDULObvYA5LzBjU8Z83J
	JiPQGgyZQ7ktUga806ukWL6zOEeMp53dQTvDfIFnDZWZdFff3WtGNlkP/p7tBb9F2gIRr/PAOFa
	Tlvz+O74ixR7IT8Aa7x/OQ32DzltBqiw=
X-Gm-Gg: ATEYQzzYB5bHAV2sebJWOwIgIRinXY8ipKcX6/6TAzhZqhfqG+M4H3OP1Gsi7PMejfL
	IRJ5u4ZrpVL86FQ0uH4KRlDhDlqpcLhG2sh+09/FdlI0x77YzePY5MUE3+aPysgNvEdMHNx5Pnw
	Sh8rf2UhmSLxX2IBLlHl7HPfhT/kKUS6/O8HXJP/gk9lIm4XMko28XESdyqPtxXR3DsJb4ow2Pa
	d0Chtd2qiwx+xOKYNwUBIrwi0cpXkumKAKhUrl+Ug5EAOOKcQF5yPAd9sXCeihYacQClTkJcEDW
	h5WkAVWUNk0ng+WZHOBFn7ohFY7vYPTEaQ==
X-Received: by 2002:a05:6a20:7d9a:b0:39c:4b84:d90f with SMTP id
 adf61e73a8af0-39c878491a3mr14067814637.8.1774913516017; Mon, 30 Mar 2026
 16:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326151111.4002475-1-puranjay@kernel.org> <20260326151111.4002475-3-puranjay@kernel.org>
In-Reply-To: <20260326151111.4002475-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 16:31:43 -0700
X-Gm-Features: AQROBzCFd6yR_9T2Bvr24kmwaj_k59rIMclTxHKelY4mAbRTGg3y5DymnosakYM
Message-ID: <CAEf4BzZ8iFDE6ym=EBC_PF7xYQrfQcGg4VvD9GG_rhvCH5wbeQ@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf v5 2/3] bpf: switch task_vma iterator from
 mmap_lock to per-VMA locks
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:11=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> The open-coded task_vma iterator holds mmap_lock for the entire duration
> of iteration, increasing contention on this highly contended lock.
>
> Switch to per-VMA locking. Find the next VMA via an RCU-protected maple
> tree walk and lock it with lock_vma_under_rcu(). lock_next_vma() is not
> used because its fallback takes mmap_read_lock(), and the iterator must
> work in non-sleepable contexts.
>
> lock_vma_under_rcu() is a point lookup (mas_walk) that finds the VMA
> containing a given address but cannot iterate across gaps. An
> RCU-protected vma_next() walk (mas_find) first locates the next VMA's
> vm_start to pass to lock_vma_under_rcu().
>
> Between the RCU walk and the lock, the VMA may be removed, shrunk, or
> write-locked. On failure, advance past it using vm_end from the RCU
> walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
> stale; fall back to PAGE_SIZE advancement when it does not make forward
> progress. Concurrent VMA insertions at addresses already passed by the
> iterator are not detected.
>
> CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 98 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index faf4d6197608..46120745ee84 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -9,6 +9,7 @@
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/btf_ids.h>
>  #include <linux/mm_types.h>
> +#include <linux/mmap_lock.h>
>  #include <linux/sched/mm.h>
>  #include "mmap_unlock_work.h"
>
> @@ -807,8 +808,8 @@ static inline void bpf_iter_mmput_async(struct mm_str=
uct *mm)
>  struct bpf_iter_task_vma_kern_data {
>         struct task_struct *task;
>         struct mm_struct *mm;
> -       struct mmap_unlock_irq_work *work;
> -       struct vma_iterator vmi;
> +       struct vm_area_struct *locked_vma;
> +       u64 next_addr;
>  };
>
>  struct bpf_iter_task_vma {
> @@ -829,15 +830,19 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
>                                       struct task_struct *task, u64 addr)
>  {
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> -       bool irq_work_busy =3D false;
>         int err;
>
>         BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(st=
ruct bpf_iter_task_vma));
>         BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __al=
ignof__(struct bpf_iter_task_vma));
>
> +       if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
> +               kit->data =3D NULL;
> +               return -EOPNOTSUPP;
> +       }
> +
>         /*
>          * Reject irqs-disabled contexts including NMI. Operations used
> -        * by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_as=
ync)
> +        * by _next() and _destroy() (vma_end_read, bpf_iter_mmput_async)
>          * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
>          * Running from NMI or from a tracepoint that fires with those
>          * locks held could deadlock.
> @@ -868,23 +873,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
>                 goto err_cleanup_iter;
>         }
>
> -       /* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get=
_irq_work */
> -       irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work);
> -       if (irq_work_busy) {
> -               err =3D -EBUSY;
> -               goto err_cleanup_mmget;
> -       }
> -
> -       if (!mmap_read_trylock(kit->data->mm)) {
> -               err =3D -EBUSY;
> -               goto err_cleanup_mmget;
> -       }
> -
> -       vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> +       kit->data->locked_vma =3D NULL;
> +       kit->data->next_addr =3D addr;
>         return 0;
>
> -err_cleanup_mmget:
> -       bpf_iter_mmput_async(kit->data->mm);
>  err_cleanup_iter:
>         put_task_struct(kit->data->task);
>         bpf_mem_free(&bpf_global_ma, kit->data);
> @@ -893,13 +885,76 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
>         return err;
>  }
>
> +/*
> + * Find and lock the next VMA at or after data->next_addr.
> + *
> + * lock_vma_under_rcu() is a point lookup (mas_walk): it finds the VMA
> + * containing a given address but cannot iterate. An RCU-protected
> + * maple tree walk with vma_next() (mas_find) is needed first to locate
> + * the next VMA's vm_start across any gap.
> + *
> + * Between the RCU walk and the lock, the VMA may be removed, shrunk,
> + * or write-locked. On failure, advance past it using vm_end from the
> + * RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall back
> + * to PAGE_SIZE advancement to guarantee forward progress.
> + */
> +static struct vm_area_struct *
> +bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
> +{
> +       struct vm_area_struct *vma;
> +       struct vma_iterator vmi;
> +       unsigned long start, end;
> +
> +retry:
> +       rcu_read_lock();
> +       vma_iter_init(&vmi, data->mm, data->next_addr);
> +       vma =3D vma_next(&vmi);
> +       if (!vma) {
> +               rcu_read_unlock();
> +               return NULL;
> +       }
> +       start =3D vma->vm_start;
> +       end =3D vma->vm_end;
> +       rcu_read_unlock();
> +
> +       vma =3D lock_vma_under_rcu(data->mm, start);
> +       if (!vma) {
> +               if (end > data->next_addr)

here you have vma->vm_end on the left side

> +                       data->next_addr =3D end;
> +               else
> +                       data->next_addr +=3D PAGE_SIZE;
> +               goto retry;
> +       }
> +
> +       if (unlikely(data->next_addr >=3D vma->vm_end)) {

here you have it on the right side... which just makes it harder to
compare two cases for no good reason...

here you actually do the "else branch" but for already locked VMA, so
make it easy to see this analogy:


       vma =3D lock_vma_under_rcu(data->mm, start);
       if (!vma) {
               if (end <=3D data->next_addr)
                       data->next_addr +=3D PAGE_SIZE;
               else
                       data->next_addr =3D end;
               goto retry;
       }

       if (unlikely(vma->vm_end <=3D data->next_addr)) {
               data->next_addr +=3D PAGE_SIZE;
               vma_end_read(vma);
               goto retry;
       }

isn't it easier to follow?


> +               data->next_addr +=3D PAGE_SIZE;
> +               vma_end_read(vma);
> +               goto retry;
> +       }
> +
> +       return vma;
> +}
> +
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_ite=
r_task_vma *it)
>  {
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> +       struct vm_area_struct *vma;
>
>         if (!kit->data) /* bpf_iter_task_vma_new failed */
>                 return NULL;
> -       return vma_next(&kit->data->vmi);
> +
> +       if (kit->data->locked_vma) {
> +               vma_end_read(kit->data->locked_vma);
> +               kit->data->locked_vma =3D NULL;
> +       }
> +
> +       vma =3D bpf_iter_task_vma_find_next(kit->data);
> +       if (!vma)
> +               return NULL;
> +
> +       kit->data->locked_vma =3D vma;
> +       kit->data->next_addr =3D vma->vm_end;
> +       return vma;
>  }
>
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -907,7 +962,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf=
_iter_task_vma *it)
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
>
>         if (kit->data) {
> -               bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> +               if (kit->data->locked_vma)
> +                       vma_end_read(kit->data->locked_vma);
>                 put_task_struct(kit->data->task);
>                 bpf_iter_mmput_async(kit->data->mm);
>                 bpf_mem_free(&bpf_global_ma, kit->data);
> --
> 2.52.0
>
