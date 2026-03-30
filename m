Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBD398905
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913858; cv=pass; b=lJ3sPe7cRoOxFJSAX0cOZ8tmfu5fINEj+XVV+ZDEchIhxb8YpovkYn640EDX8xCOb3Ei0utRLI8I2bRqhRJjnBdIt1zFlpUgl2ejPxr6SR9pZSJ9Qj6sKlcTewZ0rXd1dxJ3t6uT3X707HhAFM+Q9R0F/+eecJzsDOeNSF+h4a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913858; c=relaxed/simple;
	bh=+sYW0ZZf7O+EcEba7b1iFF9kRwjmqn9VUzOM6ybJquo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lky46D5uHeOd+RKhVpa8lW1f3rJxO3feogI9DXz6xU6T1wMQMyiNWvuR05HIOEws2/dmEnZA+IvLp9VCftyPtAEpv8sz6UvwbTYjw1ApbGW3FygFRA032erYOxIRcmCLfSWTjdBmlhaQZzot06F/q8vbklIof00xRcShUdFbLto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aywVJr5o; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aywVJr5o"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66bb66db39dso3176765a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913855; cv=none;
        d=google.com; s=arc-20240605;
        b=WXgPt4RaSmTsvcIsTsIzkwV25tEhx8+PyWgxPLMMrRxY/hYJHC8PpqG+okAbeR2qhW
         exRwhWAIV9/M64DLr4NW5BKBM9iBEldk6IGvwZrzTg+p30wufhZkziohbQX+sOkr96No
         8ufLMRnx1N4L1oaDWd/wrYxIBxk9b4CqnWS7woJK5l5mRqaRiLq21Oq+ow5LnqBXOj/G
         lXV3YUIIhCQ06jAgtHa20wE+/k5Sq00ReCNCycf9Z2vW3mdo/LTuqPR1+Pom3k3pHgDX
         pptBJ6OZO0dV6/cwKASGculw1ZN0GKDEGM33cuxiAzjwV+v0VHhH+rigIhljQodfUCYe
         Efkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rx2HAxz8KPE8ZaRYLuU4rVv3wiaVxPKThZAvSXlP2Uo=;
        fh=s/U2tX1QyS+6Cr3UC+tsC37VXjN1NmMqAyctztF2ai4=;
        b=Rsc9ZQIGDPT1eV3YBkMJtK4X/CrQNAmgZW6OU37DQAgD+1AzQCALcttJF6u4YGrrLQ
         s46A+etWrB1VBUU4nF9lx/6HxBBKIciKIqhRckSW4NVnfMHRBY1So2/EtSP9dcnwA/PA
         dJb9JSHAsFlyfxe9Fyc6IyeQBL5M5wLdf4fTw0/LxW223+oJF+fg5CGKZQR44GENEOfq
         cgzUFFjT0CMsKMGL4HVybce0MPUFDoCoWt3gTgWoNjNuKEPL7Rreh6MHkTX1CQxm/c9c
         1JWBVEoosPEUgEGbT4+lNydbS1HTc2++GUirS/fZztXUF+CPVEeLLS5Lq9WzwabZJB8d
         ycQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913855; x=1775518655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx2HAxz8KPE8ZaRYLuU4rVv3wiaVxPKThZAvSXlP2Uo=;
        b=aywVJr5owQpeBAWMzfBdSlzEjB5Skmz49LBpSpkPuvtTG1IbsX++B75aU32aSoENzN
         LT7rkWu4ZmwX1tfb+Q+RKYd86OgRRN/5uxewXm4mtErC3yOCrYE5wFhixXhhojCRUbr8
         Mt7SQ2R9llMHxgMauMQjGztN+vqjv/MUwVUUAJQfjb/TKlk1GRPlctYuDDmoHYtHvw5q
         LRlGqmE277VVuN66l3Ics17o1mIz4PHGqTATBPV2A6Mlb0toA+KO5N1rvvOU/xrhz4Xf
         JtC0ncFcHg7NI5Fm78MtMT+eZnQBItr5UBJDn13XK6tP1Hc1sTuModF7iqA57rj/ZTQr
         P96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913855; x=1775518655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rx2HAxz8KPE8ZaRYLuU4rVv3wiaVxPKThZAvSXlP2Uo=;
        b=d9kuXhtMNy3Ik9k5/6thRmtIJIliTBlbEPcXFmXTowIBzoeif8pkpev0cGt4u5+4C9
         bVDdw6DYk65jKS+EoCwQiJQ6Qji5MrlD/3RsG4UYvR70rF7tVUJsmXnaAUCeI4d1qdim
         qA9WbBEUns0IkMazrXNHjFpbA761quC9zDTSy9JrXsqBrgEWJxWRwGtV1UAY3vruEpHg
         gLNOaDjx/RY4jSb5cUulu2PMgkSxWURddhqTvot+pPWv+juf5IdHszErry4SYuJxxSdj
         dnYSQ2MR0oeSb06jy0J8VIZRa3yuTswMhhyOEdIut1jxiNWeUYseHKgieR85Zhf6sX1s
         ymlQ==
X-Gm-Message-State: AOJu0YznayBu+R8y96hx+x840Qo4OJv63aFQdNW/0qzVDnL4EwNXvLnu
	cf7SENkS9WZiGFqyqGr+oBnxllIgWCfDDcWoTygJ8LeN0A/S/fsxCMXyq3CZDs3ui4CrcWPMra5
	ZyHJqiuRO8F0PEwYvOOMAAVbXxaW85FA=
X-Gm-Gg: ATEYQzwtyMn/jV6TE7r82FPgDQI5kbJKTUcpeVCVelcxWccAMv9XHcyYAwlahsGkF75
	Q1/PzaDdU1koLYqCOG/HkRt7Onb02DIT56ZxtcVgZ0WX4jIfkDKCY4mYpqwlzvgSiVw1hPHbLv1
	FHOIs+oInJ9VGGbh9qe0n76QAvqSvhHlc9ms9Vlin62PuWw5UMXhQXYYloJc0/35tWv0Pj/4ZVI
	gwNnPgxxBrtKGR2yhzboIYL8LxVAUpoh2o4VSjgN48zv8OFHYBn896mSFDgM/tFgMxJKyGXI+m8
	rx5ManrTzvrNNXRiJVI4uUgfwOZnMZ8rgPkByvzNlA==
X-Received: by 2002:aa7:c4d8:0:b0:66b:aa56:ee5e with SMTP id
 4fb4d7f45d1cf-66baa56f0d2mr3413745a12.24.1774913855216; Mon, 30 Mar 2026
 16:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326151111.4002475-1-puranjay@kernel.org> <20260326151111.4002475-2-puranjay@kernel.org>
 <CAEf4BzbGhpWLb75OUN4BoEWZOn1g0mGbPPK-yw3WLN57DPxxEw@mail.gmail.com>
In-Reply-To: <CAEf4BzbGhpWLb75OUN4BoEWZOn1g0mGbPPK-yw3WLN57DPxxEw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 31 Mar 2026 00:37:24 +0100
X-Gm-Features: AQROBzBHrEY4Eoef3Y5xKU4c8mhvvxfia3CgyaAhqOz9l2XcXMc20Diz2XttQ9o
Message-ID: <CANk7y0hzGN-BW4L=1CchEz8cHGbrjESU-SAK+KGxGZiNWNcDjQ@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf v5 1/3] bpf: fix mm lifecycle in open-coded
 task_vma iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 12:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 26, 2026 at 8:11=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > The open-coded task_vma iterator reads task->mm locklessly and acquires
> > mmap_read_trylock() but never calls mmget(). If the task exits
> > concurrently, the mm_struct can be freed as it is not
> > SLAB_TYPESAFE_BY_RCU, resulting in a use-after-free.
> >
> > Use get_task_mm() to safely read task->mm under task_lock() and acquire
> > an mm reference. Drop the reference via bpf_iter_mmput_async() in
> > _destroy() and error paths. bpf_iter_mmput_async() is a local wrapper
> > around mmput_async() with a fallback to mmput() on !CONFIG_MMU.
> >
> > Reject irqs-disabled contexts (including NMI) up front. Operations used
> > by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_async)
> > take spinlocks with IRQs disabled (pool->lock, pi_lock). Running from
> > NMI or from a tracepoint that fires with those locks held could
> > deadlock. Disable IRQs around get_task_mm() to prevent raw tracepoint
> > re-entrancy from deadlocking on task_lock().
> >
> > Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfunc=
s")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/task_iter.c | 45 +++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index 98d9b4c0daff..faf4d6197608 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/bpf_mem_alloc.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/sched/mm.h>
> >  #include "mmap_unlock_work.h"
> >
> >  static const char * const iter_task_type_names[] =3D {
> > @@ -794,6 +795,15 @@ const struct bpf_func_proto bpf_find_vma_proto =3D=
 {
> >         .arg5_type      =3D ARG_ANYTHING,
> >  };
> >
> > +static inline void bpf_iter_mmput_async(struct mm_struct *mm)
> > +{
> > +#ifdef CONFIG_MMU
> > +       mmput_async(mm);
> > +#else
> > +       mmput(mm);
> > +#endif
> > +}
> > +
> >  struct bpf_iter_task_vma_kern_data {
> >         struct task_struct *task;
> >         struct mm_struct *mm;
> > @@ -825,6 +835,18 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_i=
ter_task_vma *it,
> >         BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(=
struct bpf_iter_task_vma));
> >         BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __=
alignof__(struct bpf_iter_task_vma));
> >
> > +       /*
> > +        * Reject irqs-disabled contexts including NMI. Operations used
> > +        * by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_=
async)
> > +        * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
> > +        * Running from NMI or from a tracepoint that fires with those
> > +        * locks held could deadlock.
> > +        */
> > +       if (irqs_disabled()) {
> > +               kit->data =3D NULL;
> > +               return -EBUSY;
> > +       }
> > +
> >         /* is_iter_reg_valid_uninit guarantees that kit hasn't been ini=
tialized
> >          * before, so non-NULL kit->data doesn't point to previously
> >          * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> > @@ -834,7 +856,13 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_i=
ter_task_vma *it,
> >                 return -ENOMEM;
> >
> >         kit->data->task =3D get_task_struct(task);
> > -       kit->data->mm =3D task->mm;
> > +       /*
> > +        * Disable IRQs so that a raw tracepoint re-entering the
> > +        * iterator on this CPU cannot deadlock on task_lock().
> > +        */
> > +       local_irq_disable();
> > +       kit->data->mm =3D get_task_mm(task);
> > +       local_irq_enable();
> >         if (!kit->data->mm) {
> >                 err =3D -ENOENT;
> >                 goto err_cleanup_iter;
> > @@ -842,17 +870,23 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_=
iter_task_vma *it,
> >
> >         /* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_g=
et_irq_work */
> >         irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work=
);
> > -       if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
> > +       if (irq_work_busy) {
> >                 err =3D -EBUSY;
> > -               goto err_cleanup_iter;
> > +               goto err_cleanup_mmget;
> > +       }
> > +
> > +       if (!mmap_read_trylock(kit->data->mm)) {
> > +               err =3D -EBUSY;
> > +               goto err_cleanup_mmget;
> >         }
>
> what's the purpose of this split of single if into two equivalent if
> (with the same cleanup handling and error code, as far as I can see)?
> Plus you are removing it in the next patch anyways...

Was trying something else earlier and missed un-doing this. Will
change in the next version.
