Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977701FF5E3
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913098; cv=pass; b=NhqyT/ESLm4KCmI6VWI2UCdWsUxpNqvSqwV/dlS7VtOE8BhN8w2qo4X+keaThMme3izrTIfODoMjeU03/Dme2fiBSMK4zr1WGKioTE7IWJBf2NRc9SxvLXixrhsNayfVe1H2/9NL2jsW5eIOIeghbHpy86nu8CqYEqMo15WUy5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913098; c=relaxed/simple;
	bh=gzqee4Ijt+TXKG3fIUpNAom5QhGa0DO5GJZQGGwwWuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/MnXrmIDA10lK2LCPyM+0jTr6LMPiTdur8FXLoOiGqJ2Cj4cm6dVmyy6rH3yGQ7CxytuuvJMGuVW8uu3WPtDSvE8apYWIJHhSsVBdlImK616dCrLXvCaJS3oB1PV3mj1B597wIrD/6WP5cmCB4MNv+KZsRURXLJm0nvpP4YYVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2bFH+Al; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2bFH+Al"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70c112cb61so3029242a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913097; cv=none;
        d=google.com; s=arc-20240605;
        b=bWBDZArfg+gpduZrpBoU+zOtB40/3T8y6xp/Y2ZiIsvCYygvaWtUKsMAiLvsUTwlJE
         trHyxno4erFR9upDVKcDftRITk9pWEcNJ94F8y00bBtmHLu8m+vbxZzAG6AMNxrHXLkn
         6lWat5sowrMoZ8ZhTsUW/xyKMJE0kaDXwApSbJUo2b2X6z9Ozz7emXfb0gcpwL0cNOfj
         R17Tox8d0oYLcOyUR6H2oOmIs/zc3faHEFevHlhGr89J81+5ahRFJy9BybdcxoXkDVUp
         ycQzcach3Lv4rFYPvzvLnQtwhLZjptRqxLRcfD7fhfuYddKrK7RQ9ZrzX3JLk8oK8UMk
         hpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i7adkUojVMLzre5L+tPO4b9hPe1mmRay02ca1LsbsEM=;
        fh=3JFULSt81QhP9ARgOVVWpn+UY1r04WcyvJhNnAO9JVY=;
        b=apdegXb8CX/zYyWaC7hu5q4khcKHwQ2ko5UBPuEWFtATmDUk9fbW8vC7dXoA0YxINZ
         Js9gXBWpYpSyYaOXfTIguQGNLreVemFX8HC2jCyOzlw8TOCAWB1dKtxXRoHO4XMjCfCj
         kFs8JasqPeiD7rXPbEP+IJq/4TYXHCgFN0S+ubqwOUUfmjRD1q6BGAp/zfG8lbB4szJD
         A1kaxOQU56sOmtxpneviY1GXenHAQ+O/ynrKV0EJjhg8skf2P+g3a7tmdpCrVJiqaxEv
         2kfrJ9d+aXjSDciY+EdX+sAUMtMn2p6j0M/TS17irjsUdxiRFWSUCkaNWt41Z6EafYBl
         Ynsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913097; x=1775517897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7adkUojVMLzre5L+tPO4b9hPe1mmRay02ca1LsbsEM=;
        b=B2bFH+Alc6qyGxWyJxxYVPVy3w9FgfcZjAYr7YEGwZO/Pibs9TULPfrkXw/wROq9JS
         WSsojOOHYyhF3OvOZKUnW2A9vL5u49Y/2Ma4k39f2Q+tzKjF6pXcVr08u5LBnvF49gpa
         m257Tc/HFU3DQE9J1di4Kp33RA/5kmsM4BRuTu3xiB/Ro+PRE6/nW2o5yRghPwM0GznH
         HwqjxltEXID3OsihSTz448VWYsD1UD9ISZAZBVJGlQgBI82XZHGZDOxIyVZV1g8lziIC
         2qDXf9DS2MeF3MvhM8U9j9sBXCR6j/LchR5pJBHOYLtBcP6Mt2oijFR6djy0ee8kNhG9
         tZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913097; x=1775517897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7adkUojVMLzre5L+tPO4b9hPe1mmRay02ca1LsbsEM=;
        b=TyP1v7NmTycJ4GrWJTfF7xpSr8/m9CIdiL/ufwJwz2HO1dQjwnfdDuCsvysoIm2LUF
         YUylBGOAssgDbc+3Yg+yfIJlk99pUm2hFABiPTITS3+DhVFBbD6BziGZX/dKDDVTcAcy
         Wxtt6g933GupQGBOBr9tsEbWlffS1XiKGw1K/j4rZ9tFrY0OOlPEDvbtY/FGKOrYHfpJ
         YkvZHVGPRnSZWteUdx2kCUgFPx6ZFjzJ2d8596lF04sf6yfOMO0Qpcmr7QodFW8lUpvs
         NmBOFw1LZ9G0NiNJSPqdLGkVp/re29+mHN9iRCy/dAXmGa26VP5aBA0LzmYRFGq08rxb
         76IQ==
X-Gm-Message-State: AOJu0YyWFkCH06VL2Gan+Qpunav8fOKlozKpdD2YtX4+2tB6zGivF23w
	o+xl3KdI6rpbZBy++eJNIHCUDoDinfHqLlZJ07+KsOT9u/6+JfC4SYxjhrPBjgBX0gZ3NgITBrB
	hHe3/IlS6TlPGDD8DnP9Sd+RTkOC/BmM=
X-Gm-Gg: ATEYQzyoztcR21LwLKWc1GxNCDTjYArQrgV57FV5zd9vVvGPb2cL6VpepuvYA/2W29Q
	uEs731vsjohm497Xyuqu5LUmBCz0Ni025k394BA89J8xa68ChPGPcJB1OHUz39zv4mL3zqGnzZW
	2GWoESb0i1FDLjlQiJCfu8Hy3MkiUxqaxpYSvutpFH6bZvg9Z9fJqo2Lyz+Z8YXHIyoPJAnDfmA
	gPh5jZTSpLytQM6srDboK6IzP5c4/9gdj/H4Q54HO/gzom+rBqJy7jwUPzd/BWB1YhkFtV3pSMY
	W1z5GuBjl7tVL4HQWXZQoUI=
X-Received: by 2002:a05:6a20:3947:b0:398:9d1e:1c6 with SMTP id
 adf61e73a8af0-39c87143253mr15906746637.0.1774913096952; Mon, 30 Mar 2026
 16:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326151111.4002475-1-puranjay@kernel.org> <20260326151111.4002475-2-puranjay@kernel.org>
In-Reply-To: <20260326151111.4002475-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 16:24:45 -0700
X-Gm-Features: AQROBzBR0-rAb2bQHsqfgsAqU62_E8PuaskR2Wouw4-zPeOjpPtX6gBdTyB6Eog
Message-ID: <CAEf4BzbGhpWLb75OUN4BoEWZOn1g0mGbPPK-yw3WLN57DPxxEw@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf v5 1/3] bpf: fix mm lifecycle in open-coded
 task_vma iterator
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
> The open-coded task_vma iterator reads task->mm locklessly and acquires
> mmap_read_trylock() but never calls mmget(). If the task exits
> concurrently, the mm_struct can be freed as it is not
> SLAB_TYPESAFE_BY_RCU, resulting in a use-after-free.
>
> Use get_task_mm() to safely read task->mm under task_lock() and acquire
> an mm reference. Drop the reference via bpf_iter_mmput_async() in
> _destroy() and error paths. bpf_iter_mmput_async() is a local wrapper
> around mmput_async() with a fallback to mmput() on !CONFIG_MMU.
>
> Reject irqs-disabled contexts (including NMI) up front. Operations used
> by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_async)
> take spinlocks with IRQs disabled (pool->lock, pi_lock). Running from
> NMI or from a tracepoint that fires with those locks held could
> deadlock. Disable IRQs around get_task_mm() to prevent raw tracepoint
> re-entrancy from deadlocking on task_lock().
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs"=
)
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 45 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 98d9b4c0daff..faf4d6197608 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -9,6 +9,7 @@
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/btf_ids.h>
>  #include <linux/mm_types.h>
> +#include <linux/sched/mm.h>
>  #include "mmap_unlock_work.h"
>
>  static const char * const iter_task_type_names[] =3D {
> @@ -794,6 +795,15 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>         .arg5_type      =3D ARG_ANYTHING,
>  };
>
> +static inline void bpf_iter_mmput_async(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_MMU
> +       mmput_async(mm);
> +#else
> +       mmput(mm);
> +#endif
> +}
> +
>  struct bpf_iter_task_vma_kern_data {
>         struct task_struct *task;
>         struct mm_struct *mm;
> @@ -825,6 +835,18 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_ite=
r_task_vma *it,
>         BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(st=
ruct bpf_iter_task_vma));
>         BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __al=
ignof__(struct bpf_iter_task_vma));
>
> +       /*
> +        * Reject irqs-disabled contexts including NMI. Operations used
> +        * by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_as=
ync)
> +        * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
> +        * Running from NMI or from a tracepoint that fires with those
> +        * locks held could deadlock.
> +        */
> +       if (irqs_disabled()) {
> +               kit->data =3D NULL;
> +               return -EBUSY;
> +       }
> +
>         /* is_iter_reg_valid_uninit guarantees that kit hasn't been initi=
alized
>          * before, so non-NULL kit->data doesn't point to previously
>          * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> @@ -834,7 +856,13 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_ite=
r_task_vma *it,
>                 return -ENOMEM;
>
>         kit->data->task =3D get_task_struct(task);
> -       kit->data->mm =3D task->mm;
> +       /*
> +        * Disable IRQs so that a raw tracepoint re-entering the
> +        * iterator on this CPU cannot deadlock on task_lock().
> +        */
> +       local_irq_disable();
> +       kit->data->mm =3D get_task_mm(task);
> +       local_irq_enable();
>         if (!kit->data->mm) {
>                 err =3D -ENOENT;
>                 goto err_cleanup_iter;
> @@ -842,17 +870,23 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
>
>         /* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get=
_irq_work */
>         irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work);
> -       if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
> +       if (irq_work_busy) {
>                 err =3D -EBUSY;
> -               goto err_cleanup_iter;
> +               goto err_cleanup_mmget;
> +       }
> +
> +       if (!mmap_read_trylock(kit->data->mm)) {
> +               err =3D -EBUSY;
> +               goto err_cleanup_mmget;
>         }

what's the purpose of this split of single if into two equivalent if
(with the same cleanup handling and error code, as far as I can see)?
Plus you are removing it in the next patch anyways...

>
>         vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
>         return 0;
>
> +err_cleanup_mmget:
> +       bpf_iter_mmput_async(kit->data->mm);
>  err_cleanup_iter:
> -       if (kit->data->task)
> -               put_task_struct(kit->data->task);
> +       put_task_struct(kit->data->task);
>         bpf_mem_free(&bpf_global_ma, kit->data);
>         /* NULL kit->data signals failed bpf_iter_task_vma initialization=
 */
>         kit->data =3D NULL;
> @@ -875,6 +909,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf=
_iter_task_vma *it)
>         if (kit->data) {
>                 bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
>                 put_task_struct(kit->data->task);
> +               bpf_iter_mmput_async(kit->data->mm);
>                 bpf_mem_free(&bpf_global_ma, kit->data);
>         }
>  }
> --
> 2.52.0
>
