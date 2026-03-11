Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205E2F6586
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257161; cv=pass; b=VQPgrWOTPm/FvWnRuTqMx9DA8zkEFFxS3AunPKs8G8SyDgdJTON9lmpzQSAyuyAXrc6B+7tNH3WK5NTv2VYutTHXnONkIifzyPc+ri3ImAC9nyNp63n4Mj6XvypfgZZrlC1Xj3vdbpgDy66CbCoKx3KOds1L0YtGt/4DkFPb9Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257161; c=relaxed/simple;
	bh=nyX8ozewjuILf9DCnPDZRZZFoDLHcXZTsdyBKMtjdOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hruHMagoXCFEZXxYGixajnLps2HzR6pHz0upWMcA4zdpzQtA+bPDbXa4s/Vth4SXX1j3PDL85sDu3K/CgQNIzUKpQSG8P8zswCoAGxMtdOzEdrmr+4bH3A9Fd3QGzPMgORD+RC4ygHkOeclObKon2OdcO+w0Ry9N56irQjAgPro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwwqKc0m; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwwqKc0m"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b96f02b4329so28439966b.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773257158; cv=none;
        d=google.com; s=arc-20240605;
        b=cHPnltmA/bfYQgifDwfPD4+ZiklxNz0D02YyUh/BphbpsmgEAj5n4shlIiGtffODvj
         XX9oLD4SIdUnfjBuohxo9az7M+K7/osdZAvIxQhx2ITlxtSVir1YNkE6ucKgOY+cqsY6
         H4yvGupwlL0FJXvEb0nol61PkTcCIX4OrQglVxstfYrqgWeFFKiPMiRjNKMgYiR8sk3j
         Un0Gl295Kn0RcQkOz3PGd2hSzA7cBcTPrZkCURG00nGoUrvgZmOJ48rpMOm06fxPp5z1
         eyAse41plUDoDoYjFJM9KL++FXkER5l6ehnvhmDUe7V1U45bd00f22dA1BmAY5S7d+8E
         lNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0kUC5JW6hNypBzppq9kjGfksTrvsJLobl+0ftpLkju8=;
        fh=Q/KxyxWWh5u847wAqPelx5tO2z9yXDIEkI7FayjuHCg=;
        b=PG7eApMJpVpmNCpv7ADJUKYP+PvYCTFmhZS1ZGdf9AjHZMTtJJ6HAzzGHHZv2hQaX5
         YvWOgli0Bh4rI40SEEJ8KuXI7cvgsSqvn8iO2TvnQ5DTjX8dWV8qQsiZ8LajoZtvYgGG
         bYkyOj8lJc9gXtWsKOCV6xDefNOG241RyCZl0hHEBcdck0eTXQhT2Cv25mY3LuqUvHSc
         VSEHC/9YZG5JYTlc5tjybTj+Xuh2UQMixuOwRbI76zrYwXhALTxxrL2fdUURn7S7QM/k
         T/t0dh8PwsQyKc1jRx/4D+zt0UJ6EclcLw4AGQSKz/exwbBMXW5ugNcK66jsg7M6zx7/
         XRTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773257158; x=1773861958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kUC5JW6hNypBzppq9kjGfksTrvsJLobl+0ftpLkju8=;
        b=lwwqKc0mwU7n7rAXJy9CpMPMY1Sbsfzd19fcUZL9ftdMGpu6HYNLFG1tdHp0cITUZB
         1Kd/gP+dAeOKU+X+niXAwaAQKv53r902ur3nkIpxa3icNJ3/FFHIS5YTeZXh2rycHuos
         lRDELrIlYRMAcfAoI0EgaACNNhC1lhsusMrw2zOl3+Qrs825YiwdplB+7Li2TFzZM9VG
         hIekGmy5CPy2f7awUef+G2IpVQAqIoccngNaSvLcwiFUbCmvGXakTY9nzVydwrCmR6aa
         1rAIcvADbopRqPAhsjHX+6txg5Zsuqfx/O5ckUaZ6PQDXgeO1WJaJtkEGpSwS02ttq4j
         AOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257158; x=1773861958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kUC5JW6hNypBzppq9kjGfksTrvsJLobl+0ftpLkju8=;
        b=DlSJCg1q7yw60GvchhpB9eIPXtNJesPGIC1EALy4teCLjSyArMCWgZr328gMtwL+DL
         d4koCtZnoj0E2Iwq/Vh/bSAdbernEzvgQYvVTiZEWX1DRKYMUzXjJJyElyMC1XqNthWb
         QZDlxP0n8MThV3tlpNHa81ccQKwPLDO9k9JvoEJGKVmJ7QfNRz98uyxbzNWJnIbLotPd
         WA1KRm9wwdt5yOEGo2fCnItQArMqmYyZ3MQX6UmZFZo21Ww7vZ2lENs8B5mCXnCjKJwz
         Sml1CaQFlaRRadmX7YxhIHFEuJcvJDdxoLPhIv99hy+D+CDPiqTO7sbkNpCsKXvvQtv9
         +FeA==
X-Gm-Message-State: AOJu0YzWFRuKYfgC1kDG9QOOjpqvjdO2pNljbkcUermJ45ee2sUDTdOv
	JACDgwmP+7jQ63uutFLDZlLNKLbKt7uIreCFhcqhkA15poO5CmfvGr1b249qNB8+5p1ppP5GEJY
	/s7gT1mFQhpdldp9Bq1k/N897F3edhVo=
X-Gm-Gg: ATEYQzyaLP1sFi/qVNeogsXCYznMc/FykcHwFsTYu54rZOCZp43NDJaAPCFtyLeSEV1
	y6eigs2nnfKSO4qcEGlT+Y7zf4QThp4wJDrlo+dTZG4OwZc39szxS3UNWxOZsWovrhSHvTMsTdx
	N++sq1St1I5v+JahpjlQbdpCTptbhE4+i4pBSDyD/QP/r4mKTBpXBLmiVtTfOlx5xlKNgePDz2Y
	2Un/xE9izw8A5iE0+3N6gtzNrYUb2+JBRHmP7t9kayS8Nx97tQrUPLcTPpkMEylnI3l2m3YlJvD
	Jr5bEhT15HToBkYMaraHW4A=
X-Received: by 2002:a17:907:9717:b0:b8e:9a0:1bfb with SMTP id
 a640c23a62f3a-b972de2f604mr209286366b.0.1773257157335; Wed, 11 Mar 2026
 12:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-4-puranjay@kernel.org>
 <CAEf4BzZiVQ2=UKXOVs7Y5NArhmQvW81EpzMbkOogHgNnbjUcXw@mail.gmail.com>
In-Reply-To: <CAEf4BzZiVQ2=UKXOVs7Y5NArhmQvW81EpzMbkOogHgNnbjUcXw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 11 Mar 2026 19:25:44 +0000
X-Gm-Features: AaiRm50lDJ-zkZLLCFnbTTNUrXLtSvrVmnmXtKnd440x2nEzboLwYPqznKA4KGE
Message-ID: <CANk7y0jbtPSkOoxjZGQ3aRuiQLSUjQr78CNp5NDLjm_R3eVGOw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/4] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:00=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
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
> > Between the RCU walk and the lock, the VMA may be removed, shrunk, or
> > write-locked. On failure, advance past it using vm_end from the RCU
> > walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
> > stale; fall back to PAGE_SIZE advancement when it does not make forward
> > progress. VMAs inserted in gaps between iterations are not detected.
> >
> > CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  kernel/bpf/task_iter.c | 91 +++++++++++++++++++++++++++++++++---------
> >  1 file changed, 72 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index e8efc9e1f602..e20c85e06afa 100644
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
> > @@ -798,8 +799,8 @@ const struct bpf_func_proto bpf_find_vma_proto =3D =
{
> >  struct bpf_iter_task_vma_kern_data {
> >         struct task_struct *task;
> >         struct mm_struct *mm;
> > -       struct bpf_iter_mm_irq_work *work;
> > -       struct vma_iterator vmi;
> > +       struct vm_area_struct *locked_vma;
> > +       u64 last_addr;
> >  };
> >
> >  struct bpf_iter_task_vma {
> > @@ -858,12 +859,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
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
> >         /* is_iter_reg_valid_uninit guarantees that kit hasn't been ini=
tialized
> >          * before, so non-NULL kit->data doesn't point to previously
> >          * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> > @@ -879,12 +884,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_i=
ter_task_vma *it,
> >                 goto err_cleanup_iter;
> >         }
> >
> > -       /*
> > -        * Both mmap_lock and mmput irq_work slots must be free for _de=
stroy().
> > -        * kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_g=
et_irq_work
> > -        */
> > -       irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work=
);
> > -       if (irq_work_busy || bpf_iter_mmput_busy()) {
> > +       /* Ensure the mmput irq_work slot is free for _destroy(). */
> > +       if (bpf_iter_mmput_busy()) {
> >                 err =3D -EBUSY;
> >                 goto err_cleanup_iter;
> >         }
> > @@ -894,16 +895,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
iter_task_vma *it,
> >                 goto err_cleanup_iter;
> >         }
> >
> > -       if (!mmap_read_trylock(kit->data->mm)) {
> > -               err =3D -EBUSY;
> > -               goto err_cleanup_mmget;
> > -       }
> > -
> > -       vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> > +       kit->data->locked_vma =3D NULL;
> > +       kit->data->last_addr =3D addr;
> >         return 0;
> >
> > -err_cleanup_mmget:
> > -       bpf_iter_mmput(kit->data->mm);
> >  err_cleanup_iter:
> >         put_task_struct(kit->data->task);
> >         bpf_mem_free(&bpf_global_ma, kit->data);
> > @@ -912,13 +907,70 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
iter_task_vma *it,
> >         return err;
> >  }
> >
> > +/*
> > + * Find and lock the next VMA at or after data->last_addr using an
> > + * RCU-protected maple tree walk followed by lock_vma_under_rcu().
> > + * On failure or if the VMA changed, advance past it using vm_end from
> > + * the RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall
> > + * back to PAGE_SIZE advancement to guarantee forward progress.
> > + */
> > +static struct vm_area_struct *
> > +bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
> > +{
> > +       struct vm_area_struct *vma;
> > +       struct vma_iterator vmi;
> > +       unsigned long next_addr, next_end;
> > +
> > +retry:
> > +       rcu_read_lock();
> > +       vma_iter_init(&vmi, data->mm, data->last_addr);
> > +       vma =3D vma_next(&vmi);
> > +       if (!vma) {
> > +               rcu_read_unlock();
> > +               return NULL;
> > +       }
> > +       next_addr =3D vma->vm_start;
> > +       next_end =3D vma->vm_end;
> > +       rcu_read_unlock();
>
> are we doing this whole vma_iter_init+vma_next just to differentiate
> between lock_vma_under_rcu() return NULL because a) there is no VMA
> anymore and b) VMA is/was there, but we failed to lock it? Is that
> right? If so, let's add some explicit comment explaining that aspect
> specifically?
>
> better still would be to change lock_vma_under_rcu to return
> ERR_PTR(), maybe mm folks won't be against that?..

lock_vma_under_rcu(mm, addr) uses mas_walk() internally which only
finds a VMA that contains addr (i.e., vm_start <=3D addr < vm_end). If
addr falls in a gap between VMAs, it returns NULL. It cannot iterate
forward to find the next VMA. The RCU walk with vma_next() (which uses
mas_find()) finds the first VMA at or after last_addr, bridging gaps.
This is the reason we have to split it into two parts. We could have
used lock_next_vma() but it fallbacks to mmap_lock. We could create
new helpers in the mm/ that don't fallback but return NULL, but I
wanted the changes to stay within BPF code.

> > +
> > +       vma =3D lock_vma_under_rcu(data->mm, next_addr);
> > +       if (!vma) {
> > +               if (next_end > data->last_addr)
> > +                       data->last_addr =3D next_end;
> > +               else
> > +                       data->last_addr +=3D PAGE_SIZE;
>
> this feels very arbitrary and kind of wrong. if we are unlucky to look
> up vma that was moved to earlier, next retry won't look it up anymore,
> and we'll get better vm_end. So instead of arbitrary + PAGE_SIZE,
> let's just keep last_addr as is and retry?

There's no guarantee the stale maple tree entry is gone on the next
retry. If the concurrent writer hasn't completed the RCU-visible tree
update, we'd see the same stale entry and spin without progress. The
PAGE_SIZE fallback provides a hard forward-progress guarantee for this
case.

> and speaking of, we should still pass data->last_addr into
> lock_vma_under_rcu(), IMO, given our vma_next() is speculative, no?
>
As explained above, the reason for splitting is not error checking,
can't pass data->last_addr to lock_vma_under_rcu() because
data->last_addr could be in a gap.


> > +               goto retry;
> > +       }
> > +
> > +       if (unlikely(data->last_addr >=3D vma->vm_end)) {
> > +               data->last_addr =3D vma->vm_end;
> > +               vma_end_read(vma);
> > +               goto retry;
> > +       }
> > +
> > +       return vma;
> > +}
> > +
> >  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_i=
ter_task_vma *it)
> >  {
> >         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > +       struct vm_area_struct *vma;
> >
> >         if (!kit->data) /* bpf_iter_task_vma_new failed */
> >                 return NULL;
> > -       return vma_next(&kit->data->vmi);
> > +
> > +       if (kit->data->locked_vma)
> > +               vma_end_read(kit->data->locked_vma);
>
> clear kit->data->locked_vma here
>
> > +
> > +       vma =3D bpf_iter_task_vma_find_next(kit->data);
> > +       if (!vma) {
> > +               kit->data->locked_vma =3D NULL;
>
> instead of here? what are we microoptimizing for?

Will do in next version.

> > +               return NULL;
> > +       }
> > +
> > +       kit->data->locked_vma =3D vma;
> > +       kit->data->last_addr =3D vma->vm_end;
>
> nit: this is "next addr", not "last addr"

Will change.

>
> > +       return vma;
> >  }
> >
> >  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *i=
t)
> > @@ -926,7 +978,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct b=
pf_iter_task_vma *it)
> >         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> >
> >         if (kit->data) {
> > -               bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> > +               if (kit->data->locked_vma)
> > +                       vma_end_read(kit->data->locked_vma);
> >                 bpf_iter_mmput(kit->data->mm);
> >                 put_task_struct(kit->data->task);
> >                 bpf_mem_free(&bpf_global_ma, kit->data);
> > --
> > 2.47.3
> >
