Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FB1990C7
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255658; cv=pass; b=tRQ1x0mhjVhOpGVLAYx4P3mINVe6oJuNgcLLSxzE6ZKb4dPZuqExzFFZNusgMWMU/6Isg2D9SM38dAk6OmtiPLTW52rYb08md7NML9OVFfNkY1DsebgDx9cxu1zdgt9F7EbZYC6zkMiOIk1Li9N3y1f6O7GctJ3R1cSrD6IK1aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255658; c=relaxed/simple;
	bh=a1ZXRKphl5imqZjNE+Y8nJJfuQanpVMqZxkO8ED1aDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etja3zWvk2zwfBTl765JUb1vT5eB3aenPpfl6gv7dMh12oXyCKfOpStgbx8405SRpgtnPr9QL28Epa8CYGUb44Ss19ImLZN3klQTlGZ1+kCps/U9yAVTMmO38hT0//rTf+D8Y9F0iPvmWjlVFLnQcxqu1cOlFLtxvlQ1x/2CdoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J82RAOTY; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J82RAOTY"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73c990a96dso55216a12.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773255656; cv=none;
        d=google.com; s=arc-20240605;
        b=ANPhrx8giaxVGyUJFRzHT96tmVj/d/GKEo3PgLheD2txaJaB0RxHlPTat40suJ51kJ
         hE94L49UFwmGX2SQz55of2zvnBgBYi8GV1ZpEbclWpwWh2zh6adgWhRLEi22C2mW0Vx4
         lSpWez07koFGYc6GCZprh9chJ2buIwdbbPVMWZPK1T/SLS06KX6NlC1isukEnOFmtSKC
         Zl+ouTEyXTarkYoTiOFYUgv3U5YM418qZlZJtXCvUel3oJhgQVd6T4OTyN1i/EF0QLx5
         vwDtBTVTYNIQSiw4gvAriTooVBLR8sNfF1ghebnV3zNsuikKSz6nnQmj2T9cmCRrx8JU
         MXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0FAeFSpvvJ+yRAPhqY1CjzDGLPwlqegDmP9v+/H/qYs=;
        fh=1LhFiYc1Rq+qPcq6jOq+2i3N54xRLlAhlj0skHZQ83s=;
        b=fATwMlB+lcqM7pODM/p/Z8f5+lM4vfA5uL70VDR+3bxIQupONssfB14KGmZRlNEKUY
         +iI0lWKOk8qqdnNac6L2yCsKVmbIvYVZuBRCY5SST5FDLgvlJjwXIwdIhhGszyuEX/K6
         xntlGP6H6oycB+50D1Q3Pd3v9CMt0wD5mGHFcKmAHDMhVWD4U3AVljCXWpV3+3rAoiBp
         jaFbHdktzAx4NwT+3f1855BgqhO5exuqjjZKOCqonxzeT2bqIIU6t0RCBuoj9jEXyd8a
         qKocQ9icjVmfh8pRFGyrqO1J2rsI8BI7CK+LHwFfxzaiR6/avY2258XcnIWN/ItsOmcR
         ivTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773255656; x=1773860456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FAeFSpvvJ+yRAPhqY1CjzDGLPwlqegDmP9v+/H/qYs=;
        b=J82RAOTYOSqxJWZSEWoidVxWMonJ3W4utfVqnbsuBRb+eJVbyMoRlLVcdRcI2WpXgn
         cNsa7xZ7ngJqit1CpO42Wjlu5VUUiRsSkLivUppQ66GSA7ezv1MaqZObq3beM/XxsY9i
         9zcE5a5Rnt8tA/joxvcEuMAMOUtDfxCEby8MWlWs7AGefYKyO6Zem/oVG6xSOIkrwEbG
         /c1v8kVOlIrjMgfb1nN/9LtUm5yUBEOCW2xytRRCMH9/6LzFONffLiLDaNN/vQEtZoDp
         I6vXoodfjOzCvXyDVE4C5cffByMMSwId72ozJZ3vCp2cXGtc87dlnEXDADKy04FzRHa8
         P9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773255656; x=1773860456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FAeFSpvvJ+yRAPhqY1CjzDGLPwlqegDmP9v+/H/qYs=;
        b=HwrUNF/T3o9J0BNt3A68LVzFY8rjE1YG4yKH3Gt6PD3NXDb1I+TqhwNhlC6xxP7rl6
         EiREun6U3k0znAQ3dFqEZkVbhi88lfquONsx5OWZ/z3BO9rmBFk8EZVIsJSXTBNEfvsl
         6wbziqX1wiyWMCbhuJMoN5S7dhwVpcfS+O6RTB+gaYvRTgtaMwrOEhv0B69TZ0QZ+8Do
         8fNbClhd69hJZWNg1gnMXFlIWX+K4z2xv/h3a64Gg7bLrz9/q6+YdcgsjPPimKDXuzCF
         sXEn2jnR7zEX4XJF7Fzf43q2IK5mDZ2s4sS+ZH6jcx7Z04EU7NzJX+VySXCsGtMulWyi
         AYkA==
X-Gm-Message-State: AOJu0YxW7hWQRKw8JAVht8uHGXLa/WH2D10PD/SofUE48cP2Qsi4KmeA
	3iH3qt0MdaURBIfRfR6G1KI9PnXJnu3MpPm2E1b70vuaTSlcSlnXnixnBwM7t7ACx1KkQt+ujY6
	ELNE4JYYUGQSBQUhH75M6fvjhHFwqScY=
X-Gm-Gg: ATEYQzymJbXlxV6CFJoZhKjXbFx13oymg9Yx4oBmGaxFQgDJMtvJhDnw0iKKtK54z8z
	7/RW3TeqqgTfL9M8mAR01WLttIEHDy0+0Hknu8qt2t+r/CJf5a6GrRxcBVYjnGsDBqo+Zf7tSFe
	BDmwsxq7sNtwCDDOd5f8TpgXleiV9yjcQbVfpOV3pfHJv7p/p2MuKAwCdIsY3dHKzcMmmtf0JuT
	DSer5M0WYFOglGZnwlQCczfecYJMFgBguKRdTOw2zNEOeUoBiW2H+bWXkC1+7tTSrufm2lI2btx
	zSMAOSI=
X-Received: by 2002:a05:6a20:5482:b0:398:9044:77b7 with SMTP id
 adf61e73a8af0-398c61395c1mr3259630637.59.1773255655884; Wed, 11 Mar 2026
 12:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-4-puranjay@kernel.org>
In-Reply-To: <20260309155506.23490-4-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:00:43 -0700
X-Gm-Features: AaiRm52PaA9HRNTYeVk21io-gAJF_7rwme-r5V301TivSI68HEMD-1fgP0nPH48
Message-ID: <CAEf4BzZiVQ2=UKXOVs7Y5NArhmQvW81EpzMbkOogHgNnbjUcXw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/4] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> The open-coded task_vma iterator holds mmap_lock for the entire duration
> of iteration, increasing contention on this highly contended lock.
>
> Switch to per-VMA locking. Find the next VMA via an RCU-protected maple
> tree walk and lock it with lock_vma_under_rcu(). lock_next_vma() is not
> used because its fallback takes mmap_read_lock(), and the iterator must
> work in non-sleepable contexts.
>
> Between the RCU walk and the lock, the VMA may be removed, shrunk, or
> write-locked. On failure, advance past it using vm_end from the RCU
> walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
> stale; fall back to PAGE_SIZE advancement when it does not make forward
> progress. VMAs inserted in gaps between iterations are not detected.
>
> CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/task_iter.c | 91 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 72 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e8efc9e1f602..e20c85e06afa 100644
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
> @@ -798,8 +799,8 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>  struct bpf_iter_task_vma_kern_data {
>         struct task_struct *task;
>         struct mm_struct *mm;
> -       struct bpf_iter_mm_irq_work *work;
> -       struct vma_iterator vmi;
> +       struct vm_area_struct *locked_vma;
> +       u64 last_addr;
>  };
>
>  struct bpf_iter_task_vma {
> @@ -858,12 +859,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
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
>         /* is_iter_reg_valid_uninit guarantees that kit hasn't been initi=
alized
>          * before, so non-NULL kit->data doesn't point to previously
>          * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> @@ -879,12 +884,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_ite=
r_task_vma *it,
>                 goto err_cleanup_iter;
>         }
>
> -       /*
> -        * Both mmap_lock and mmput irq_work slots must be free for _dest=
roy().
> -        * kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get=
_irq_work
> -        */
> -       irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work);
> -       if (irq_work_busy || bpf_iter_mmput_busy()) {
> +       /* Ensure the mmput irq_work slot is free for _destroy(). */
> +       if (bpf_iter_mmput_busy()) {
>                 err =3D -EBUSY;
>                 goto err_cleanup_iter;
>         }
> @@ -894,16 +895,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
>                 goto err_cleanup_iter;
>         }
>
> -       if (!mmap_read_trylock(kit->data->mm)) {
> -               err =3D -EBUSY;
> -               goto err_cleanup_mmget;
> -       }
> -
> -       vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> +       kit->data->locked_vma =3D NULL;
> +       kit->data->last_addr =3D addr;
>         return 0;
>
> -err_cleanup_mmget:
> -       bpf_iter_mmput(kit->data->mm);
>  err_cleanup_iter:
>         put_task_struct(kit->data->task);
>         bpf_mem_free(&bpf_global_ma, kit->data);
> @@ -912,13 +907,70 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
>         return err;
>  }
>
> +/*
> + * Find and lock the next VMA at or after data->last_addr using an
> + * RCU-protected maple tree walk followed by lock_vma_under_rcu().
> + * On failure or if the VMA changed, advance past it using vm_end from
> + * the RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall
> + * back to PAGE_SIZE advancement to guarantee forward progress.
> + */
> +static struct vm_area_struct *
> +bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
> +{
> +       struct vm_area_struct *vma;
> +       struct vma_iterator vmi;
> +       unsigned long next_addr, next_end;
> +
> +retry:
> +       rcu_read_lock();
> +       vma_iter_init(&vmi, data->mm, data->last_addr);
> +       vma =3D vma_next(&vmi);
> +       if (!vma) {
> +               rcu_read_unlock();
> +               return NULL;
> +       }
> +       next_addr =3D vma->vm_start;
> +       next_end =3D vma->vm_end;
> +       rcu_read_unlock();

are we doing this whole vma_iter_init+vma_next just to differentiate
between lock_vma_under_rcu() return NULL because a) there is no VMA
anymore and b) VMA is/was there, but we failed to lock it? Is that
right? If so, let's add some explicit comment explaining that aspect
specifically?

better still would be to change lock_vma_under_rcu to return
ERR_PTR(), maybe mm folks won't be against that?..

> +
> +       vma =3D lock_vma_under_rcu(data->mm, next_addr);
> +       if (!vma) {
> +               if (next_end > data->last_addr)
> +                       data->last_addr =3D next_end;
> +               else
> +                       data->last_addr +=3D PAGE_SIZE;

this feels very arbitrary and kind of wrong. if we are unlucky to look
up vma that was moved to earlier, next retry won't look it up anymore,
and we'll get better vm_end. So instead of arbitrary + PAGE_SIZE,
let's just keep last_addr as is and retry?

and speaking of, we should still pass data->last_addr into
lock_vma_under_rcu(), IMO, given our vma_next() is speculative, no?

> +               goto retry;
> +       }
> +
> +       if (unlikely(data->last_addr >=3D vma->vm_end)) {
> +               data->last_addr =3D vma->vm_end;
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
> +       if (kit->data->locked_vma)
> +               vma_end_read(kit->data->locked_vma);

clear kit->data->locked_vma here

> +
> +       vma =3D bpf_iter_task_vma_find_next(kit->data);
> +       if (!vma) {
> +               kit->data->locked_vma =3D NULL;

instead of here? what are we microoptimizing for?

> +               return NULL;
> +       }
> +
> +       kit->data->locked_vma =3D vma;
> +       kit->data->last_addr =3D vma->vm_end;

nit: this is "next addr", not "last addr"

> +       return vma;
>  }
>
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -926,7 +978,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf=
_iter_task_vma *it)
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
>
>         if (kit->data) {
> -               bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> +               if (kit->data->locked_vma)
> +                       vma_end_read(kit->data->locked_vma);
>                 bpf_iter_mmput(kit->data->mm);
>                 put_task_struct(kit->data->task);
>                 bpf_mem_free(&bpf_global_ma, kit->data);
> --
> 2.47.3
>
