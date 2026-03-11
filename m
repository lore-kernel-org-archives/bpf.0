Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3413E6383
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254139; cv=pass; b=iJDmDL31WJjq+sJSFWB/rPnixpcUdvJNSvDlxbjHZypEf2aR5hxQbAvecAZIuYXo+K9vMlqJtcZHHCvW+XiMLEOmusnV6jhpmTct3PBX39rbHmNbu5y3UZVTRSSU7IRXGHJEAi4mqEPlt3SFrwwNRTfuw8XNMW7vU3T5njU2n7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254139; c=relaxed/simple;
	bh=Kv5HGpeaVsowP2UoVJl+YA3Z61wxXIqZRqZUARkpuRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDT+SkUoZHmfuW4mGHiVc+QBooCf7lXI2cwV5Ny1lrcbhmGNXOAvQ5KoeJnfNZSIegzlLNVaGDpV4yYA9m2NPARIlBcltW82T7CCNFcExy7oJ+uAeIkXsBlPMWB2QNzqP2nFxtOq2pluw1RJMX7End8e0bZB/0cnhyKIXcq6hfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAGeo1Cu; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAGeo1Cu"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82985f42664so136417b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773254138; cv=none;
        d=google.com; s=arc-20240605;
        b=e289KtZCETfDn0BIAOIwpAuakQmIYW3cOdehrRzc0d9p7gbyQSyjCcudG5AGjAjeWm
         53yChPY2zkl5KNMkYjx7JKA9hTz27BbEg3tSq0YeQ2p8ezCy0JWAh9/XAT16CwzaFi2V
         bw7nYDfzFlO6uTTXWyEaIYqZNwK357wQ9vKv6+8OnWhYwIQF0gzGNIzV6yBbaGIR7AG0
         8q0ZHwFrdZZktBIKW1QB/KGb1ZbXUZiep91tzbN5Uw7VnSH6aFcbKOynYe80Z2U4IG/M
         57QqW9azenoiJdJ83aiwdpTtgh5eR5zJBc+2VPq/GbKAhQf5fjBCOLUffjse+6MiiOdY
         qt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EoLmk1asla2dYu5zVPNqzkaq9OJ3PnPNrLqenMj2f/o=;
        fh=3JFULSt81QhP9ARgOVVWpn+UY1r04WcyvJhNnAO9JVY=;
        b=T9+L1oguT9GeVazE6d5CC211iPRfEcXmdJaWOVuDfB0q4g/euJNQlel69zyQV5isK2
         MVArEEAkif9qbcNrYKrY1vOP24Uac+oSvqsOEjYni93KE6rCIicSRzXzKpytwpGCzNWQ
         e92j8AH/CNgTymDgQToqk4qnyOOr6koTFhFu4QaGWK/xBxbsDxxBA8Q0OjGHbZsVkn8H
         kQAolIfSUq5X/mgvqCqmRuZM8kMjiyEhMw9qsGl9Jy/SR9SlsTHBofzUj8Kzn8/oNR2+
         hV9/dYf9k0YXNi5/ZVz3faCe8tmRpC5rNAKOPk+KRM4+t1Ulf6OXVem5N2cFN0C1qe3n
         N++A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773254138; x=1773858938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoLmk1asla2dYu5zVPNqzkaq9OJ3PnPNrLqenMj2f/o=;
        b=aAGeo1CuGajwqMd5yCVQO2jrGLDptI1TeM6dmBVpcwSUqWJPDfF8P7Rw9ZWxld89oD
         kBhNk/u2quAkEmWuzWO1sbcW5FVjRPQSEovuRa4BqoLCB2jK+EHNW4h5mhLsOqqjv2w/
         pesENOf8cVct1ICg2NtP4H3IqZXjhOsNVqtEtDEPJABf0wg94y6du74w25mJpZkMiMxj
         tPicMM4nFdgSrXvfGICgSCSvagKS7NMYimh3nixOmLkg5WkvMt9zk9BdZV3WSn7JkjtX
         ldlBDSXawtj1qBCN1LOv1on2HYoVCMuvBKQZ0OxykQ9/25zD57iSbYSc3tkD4LidX+xB
         l5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773254138; x=1773858938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EoLmk1asla2dYu5zVPNqzkaq9OJ3PnPNrLqenMj2f/o=;
        b=g0LxtEUN6lnO8nJBwA6qN1pK/DW6VrMt3RkWSzA1oATk4CnVsVYbhqXbBAQaHggT4J
         xGSVxpvNAuvc0XAjZuNOu11/ATGOkXEmw7hZ+6H0CGZxk+cstbjNmRlWR5IQRtbEkyEW
         0k08Bb27oNgdl7/gKa6BWjklHPMEqXglQ92V9vzT3azAZ3uQzhMT4nS+cijhuaYRM0ED
         kX2OjQbdBw6aAilLPa2wDbC6aDSU8je6J5pHQtVL4n7uQXtHwINXN+kTpZWrQodbyMDX
         sqOLkoVPIU1HkL8flLJPotRoZ2IeEfrwvwMsPfN8JH08zLR079RYnKfzumTXextNgqDe
         7BUg==
X-Gm-Message-State: AOJu0Yy2dE1zu5PrcmEEA6cQ5t2reGCeER5g+FUH4+oHwI32jwMkFrrz
	wtfDQh8lXw71mApiIx/Ms2lwsnG1RCFX1E2DWbfKUw1YDO1hyFhuVGH085txVb8RuA/MZ42uqdP
	sJxgh3vcd7TBwDEjZw88I3FJDM6mBHX4=
X-Gm-Gg: ATEYQzxjcAB3n5W7IyJfKTe+0xnRL4c8SQy+VBUT3GjsP1cFuwyXnFXgGeWBaYJo1ZP
	yZwEatnTpPB6VtIHopncz5cEQZNX2BLDSss7gXyyjrJWFFpWdduZq0uErDqYtSav2SgLt4WLd1m
	70vHTPokUU2RewCngR47SM61esJcpehBkwzdr0pEswCdPrHdesPxJ+TqszdVZD3yREgOZvYF4eA
	FGjGDwoCnamRn9FvCmKP6ucACRnXLly74gM7JVbBvybgtglZOSMldY/d/bNxTRkQvm6rRc3Dls5
	4Y3VZaY=
X-Received: by 2002:a05:6a00:ab83:b0:81c:92ec:ccf3 with SMTP id
 d2e1a72fcca58-829f6f2122emr3445590b3a.19.1773254137820; Wed, 11 Mar 2026
 11:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-3-puranjay@kernel.org>
In-Reply-To: <20260309155506.23490-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 11:35:25 -0700
X-Gm-Features: AaiRm53AO8NFMXMSk0bS6sJ-QeMYsXDVvvg9SIwOxf1_KVhvOrvKhJ7bU7MFE1Y
Message-ID: <CAEf4BzYY9ykm_LzMEGjg_=xB2-o5tuayTSXcov4Pqh4Wb=qq3Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/4] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> The open-coded task_vma iterator reads task->mm and acquires
> mmap_read_trylock() but never calls mmget(). The mm can reach
> mm_users =3D=3D 0 if the task exits while the iterator holds the lock.
>
> Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
> on error paths via mmput_async(), which is safe from process context.
> From hardirq/NMI context mmput_async() can re-enter __queue_work() and
> deadlock on pool->lock, so defer to irq_work in that case, following
> the pattern from defer_timer_wq_op() in kernel/bpf/helpers.c.
>
> Widen the mmput_async() #if guard to include CONFIG_BPF_SYSCALL,
> following the same approach used for CONFIG_FUTEX_PRIVATE_HASH.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs"=
)
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/sched/mm.h |  2 +-
>  kernel/bpf/task_iter.c   | 65 +++++++++++++++++++++++++++++++++++++---
>  kernel/fork.c            |  2 +-
>  3 files changed, 63 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 95d0040df584..5908de0c2f82 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -140,7 +140,7 @@ static inline bool mmget_not_zero(struct mm_struct *m=
m)
>
>  /* mmput gets rid of the mappings and all user-space */
>  extern void mmput(struct mm_struct *);
> -#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
> +#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH) || defined=
(CONFIG_BPF_SYSCALL)
>  /* same as above but performs the slow path from the async context. Can
>   * be called from the atomic context as well
>   */
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 7c302ee78f7e..e8efc9e1f602 100644
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
> @@ -813,6 +814,44 @@ struct bpf_iter_task_vma_kern {
>         struct bpf_iter_task_vma_kern_data *data;
>  } __attribute__((aligned(8)));
>
> +/*
> + * mmput_async() is unsafe when IRQs are disabled because it can re-ente=
r
> + * __queue_work() and deadlock on pool->lock. Defer to irq_work in that =
case,
> + * same pattern as defer_timer_wq_op() in kernel/bpf/helpers.c.
> + */
> +static DEFINE_PER_CPU(struct bpf_iter_mm_irq_work, bpf_iter_mmput_work);
> +
> +static void do_bpf_iter_mmput(struct irq_work *entry)
> +{
> +       struct bpf_iter_mm_irq_work *work;
> +
> +       work =3D container_of(entry, struct bpf_iter_mm_irq_work, irq_wor=
k);
> +       if (work->mm) {
> +               mmput_async(work->mm);
> +               work->mm =3D NULL;
> +       }
> +}
> +
> +static void bpf_iter_mmput(struct mm_struct *mm)
> +{
> +       if (!in_hardirq() && !irqs_disabled()) {
> +               mmput_async(mm);
> +       } else {
> +               struct bpf_iter_mm_irq_work *work;
> +
> +               work =3D this_cpu_ptr(&bpf_iter_mmput_work);
> +               work->mm =3D mm;
> +               irq_work_queue(&work->irq_work);
> +       }
> +}
> +
> +static bool bpf_iter_mmput_busy(void)
> +{
> +       if (!in_hardirq() && !irqs_disabled())
> +               return false;
> +       return irq_work_is_busy(&this_cpu_ptr(&bpf_iter_mmput_work)->irq_=
work);
> +}
> +
>  __bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> @@ -840,19 +879,33 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
>                 goto err_cleanup_iter;
>         }
>
> -       /* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get=
_irq_work */
> +       /*
> +        * Both mmap_lock and mmput irq_work slots must be free for _dest=
roy().
> +        * kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get=
_irq_work
> +        */
>         irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work);
> -       if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
> +       if (irq_work_busy || bpf_iter_mmput_busy()) {

see my reply on previous patch, but why do we *have* to do the per-CPU
stuff here? iterator has its own state, we can have our own irq_work
node there. Simple and easy, what's the downside?

>                 err =3D -EBUSY;
>                 goto err_cleanup_iter;
>         }
>

[...]
