Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62B59220E
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891930; cv=pass; b=YYztN0jOFRRK71lU65JtLTTwo+CFjs0LNOI4O1kpelZWJombEP3yOgqnBEc280/q+3MG6znnZ6UAYT9Mx4ooAQsThBLL6Os8PCnNIzi5Tjha1sad5brWuxEFXnMd9pxls96hd9WDZyVD0h/AwaaDyVSUO6Nv/wRektCBnib/nbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891930; c=relaxed/simple;
	bh=ZmvmJ9RRdS1XUwFgvrDxdgjYnAIEbxN+tTRUY0GgbkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYrJTeTinnmDo0eIRsv7vvOWICleMU+qeyh8K5bjYQolMVm8z/3QqrDgRv6Vt1Tl0z7PONNDtweZ+7ry2/FQ4ysjq948tftHl6gEhmPh+vlG1XYPgrgLxT6Gu+JRI+L4XMTPUbP9WLuoeNq2+0pUDtKeuYJXsxQWZ/lYOQ0M5Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=sRZUIqi4; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="sRZUIqi4"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-85aa9c1308dso40360647b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 11:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788891928; cv=none;
        d=google.com; s=arc-20260327;
        b=e04uGxVzTHW8GapphDN/m4PfNt6A2OKn/IBsoqAtd3oVmmdDXc5ir+eTsPi/rmheGJ
         +mm60+NpHS5JWRe9upliNfxAb3sEaNiT6nbQ1dwMsBhk6XY6G04ekffMODkMv5hevy2w
         mhwAERj9MK5yiq/5S4zxDzOznir1I/wZgYfHtGFfOq8njlemULWD0pxjtUiEfyaiyl+3
         pKrs7AMApcbjlDsZZygcbAIdTN2rf9o7O9GoVuS6h9Ga8VxcLvjHBm8Cpbg6l2ABKPWy
         o2Eca8TZSX7OtJsv0PfVJrNyLBGP5AmBnPbjGsLSaFQ8ZmYYDfySlOK4HFQ1w2odxyFa
         L/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nvKTWX1LgoRghRacucAYp92Kpp2ApP3ICujHDBfyMTA=;
        fh=5bG9Ph3wKY1cq0b9UgO3oml+l2PwNGRHDr56ATb400I=;
        b=Yjm5XAoAE7qNq2HcrZuTWWlQ/9u7JIk6n3ooP2gpZC3vl/IaDfKNARGjHHiPDZENEq
         pmj8UAzRCdHWnYRCwNJakc1E9jsyiAE4kg7ltwbMUHbOUl1x1AMvIlGVgFpY2o7jiIP+
         3LlrieA4TS9wQ6/5bVF14CW0UnEiVTmx/1R/ybIwjIBs9PfE8ahrzzOnZmNoPQqUBaCK
         0C4bHtdAQqTNNYsXEC8rmlT6kywbyQTZdf9ZJtiKRJHxvR3ovSdLGZ/J50Hhpj5wdDvq
         K0cUsx2ch6M4qMbWG1+hm8Z/5KZl2uQswfKugmq3Edg9WWGGCte0EUNS1Pvyg/EaFhqC
         kORg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788891928; x=1789496728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nvKTWX1LgoRghRacucAYp92Kpp2ApP3ICujHDBfyMTA=;
        b=sRZUIqi4BWcH873HpOBU/qwuBrwzUftv6/x8SGwKoUmdlTbDVCJpdBgjEAgV+6LAo6
         TGCOfF5txiaXiFblGw0dRSEkt/F9ItwfDwo9GRUClodmgwqfoz3bzQ8TPssYV3L2yfl6
         wY+Tq+w9r2kLWP58QfYqLdNO7AzOd4xk5Ck4sK8oT0ERhH+HPNzhPI4NzccvPfetP2qm
         BSGL+M3iABcr8VbeJtCFunM5vPAMwlVOQO19aHNkDN1svMwoGgKJxOOn+zA7iQvE3B5J
         Qjs8/9R5dWkN10y88FJtjE5t3UukMIiddi/a8Cdu3LyYntWJuDibpoNxVvcq7Lf9r3ae
         bF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891928; x=1789496728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvKTWX1LgoRghRacucAYp92Kpp2ApP3ICujHDBfyMTA=;
        b=VIxl0DIbHd5n5UJ0yYGXVIWx0NFQ7FLMJnnyPSS93Tnv7aRsAhcaINLk2Xf2mIoPlv
         gABwWO09ZNFQYUZ78zz5w2x/EGrOs34uHtW6A1wN+hrs30bCDmCu94toIktHnz3MR+PT
         Cr3wi2yIsDwzwumll78e9LWcnkX1WEIyEKaD4FqrR/49ftcLigNvEPnDRFofTyGDe9ZN
         sV/c1ytnBngtJP+gHmQpsyBnKU9MgBBDgpAX10HgM/yzaVUfP0cguokDjeCEeRyRqd8E
         henZRxyVig/hEPE3Z+7EvdbFeuo7BtZWFsLW7hYvkCY8G2RdsDUlIBlHPxcc//2isqFe
         d0fg==
X-Gm-Message-State: AFuF++lfdzWHcY4jmM9vrlRxD/qX4KXAeSey2D7pBUs41cyXL3vxJjNT
	xvVRgCDcVftjl1VGTuPqW0Xm8/MUK2LDpJXqOobx1znWJMWrJj0wto23mslpDt7J5AWz6e4uzk8
	QgoWbOFkK0aKH/zs2bNRL82ddsPTJadevEsm7uftuN5Xo+iAHYMU01VA=
X-Gm-Gg: AYBFou3pkfU6NLnPVnQCcocDRHaRid29OdKi0kGZt91Z4BBxAemBGUbclK23mnB1uFu
	ZhpBTqc5nsqNX/IkWVA9Rx2+HZbe2cu9OX+/+pQjtW/nvDION0ms2LxKbBk+exvqzIcNZgx6xsd
	8y1nizdkzeQyK+6LCY1dAJT2JOzme+axSGf1l7rK0A6dHvsnDuR7aoHrIVyxX+ghcG+0Vw263Mh
	ru5aS2Q3efd6hZM9ZcmvJraVk6rCPHQcYOkQAr8EGWQLmUlbADnSXSQKpiV7oQcZff8FUisJJQg
	hDlVZ+9b97GmwCs6fx9h4k3oK8waNpgYyNV+FQdYrdI97Gelsm5qBVE=
X-Received: by 2002:a05:690c:4b84:b0:857:12ab:3e19 with SMTP id
 00721157ae682-8712b98b472mr132297157b3.32.1788891928064; Tue, 08 Sep 2026
 11:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830093514.4105972-1-memxor@gmail.com> <20260830093514.4105972-3-memxor@gmail.com>
In-Reply-To: <20260830093514.4105972-3-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 14:25:15 -0400
X-Gm-Features: AcwNN1Xe7cAjYt3YFMQMuyVnAIugsahgJK-j8map4Gqkj9tOmp3HVrn6ylNLx7c
Message-ID: <CABFh=a6xK1eZL+Bc48DRZpppdqs008N5uQZTT+TaCpmOwx-S5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/6] bpf: Defer stream file notifications from
 NMI context
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> bpf_stream_vprintk() and staged stream writers can run in NMI context.
> The stream file interface currently wakes its wait queue directly after
> publishing data. Wait queue wakeups take a spin lock and can invoke epoll
> callbacks that take further locks, so calling them from NMI context can
> deadlock.
>
> Give each stream an irq_work item and queue it after publishing data. The
> irq_work callback reports readable data to poll waiters outside NMI
> context, while naturally coalescing concurrent notifications. This matche=
s
> poll and epoll readiness semantics: notifications do not count records,
> but prompt waiters to re-evaluate persistent readable state. Publications
> made before a coalesced queue attempt are ordered before the pending
> callback, and the work can be queued again once that callback begins.
> EPOLLET consumers drain until EAGAIN, so one wakeup may safely represent =
a
> batch.
>
> Synchronize pending work before releasing the final stream reference so
> the callback cannot outlive the stream.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/stream.c | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1745686331be..0af3c79f5d03 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -17,6 +17,7 @@
>  #include <linux/numa.h>
>  #include <linux/mm_types.h>
>  #include <linux/wait.h>
> +#include <linux/irq_work_types.h>
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
>  #include <linux/module.h>
> @@ -1719,6 +1720,7 @@ struct bpf_stream {
>         struct llist_node *backlog_head; /* list of in-flight stream elem=
ents in FIFO order */
>         struct llist_node *backlog_tail; /* tail of the list above */
>         wait_queue_head_t waitq;
> +       struct irq_work notify_work;
>         bool dead;
>  };
>
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index d3dbb1aca792..99a89533eaef 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -6,6 +6,7 @@
>  #include <linux/filter.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/gfp.h>
> +#include <linux/irq_work.h>
>  #include <linux/memory.h>
>  #include <linux/mutex.h>
>  #include <linux/poll.h>
> @@ -76,6 +77,17 @@ static void bpf_stream_release_capacity(struct bpf_str=
eam *stream, int len)
>         atomic_sub(len, &stream->capacity);
>  }
>
> +static void bpf_stream_notify(struct irq_work *work)
> +{
> +       struct bpf_stream *stream =3D container_of(work, struct bpf_strea=
m, notify_work);
> +
> +       /*
> +        * Stream writers can run in NMI context, while wait queue callba=
cks may
> +        * acquire locks. Defer those callbacks to irq_work context.
> +        */
> +       wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM)=
;
> +}
> +
>  static int bpf_stream_push_str(struct bpf_stream *stream, const char *st=
r, int len)
>  {
>         int ret =3D bpf_stream_consume_capacity(stream, len);
> @@ -87,7 +99,7 @@ static int bpf_stream_push_str(struct bpf_stream *strea=
m, const char *str, int l
>         if (ret)
>                 bpf_stream_release_capacity(stream, len);
>         else if (len)
> -               wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOL=
LRDNORM);
> +               irq_work_queue(&stream->notify_work);
>
>         return ret;
>  }
> @@ -230,6 +242,7 @@ static void bpf_stream_put(struct bpf_stream *stream)
>         if (refcount_dec_and_test(&stream->refcnt)) {
>                 struct llist_node *list;
>
> +               irq_work_sync(&stream->notify_work);
>                 list =3D llist_del_all(&stream->log);
>                 bpf_stream_free_list(list);
>                 bpf_stream_free_list(stream->backlog_head);
> @@ -402,6 +415,7 @@ int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t=
 gfp_extra_flags)
>                 init_llist_head(&stream->log);
>                 mutex_init(&stream->lock);
>                 init_waitqueue_head(&stream->waitq);
> +               init_irq_work(&stream->notify_work, bpf_stream_notify);
>                 prog->aux->stream[i] =3D stream;
>         }
>         return 0;
> @@ -482,7 +496,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *=
ss, struct bpf_prog *prog,
>                 list =3D tail;
>         }
>         llist_add_batch(head, tail, &stream->log);
> -       wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM)=
;
> +       irq_work_queue(&stream->notify_work);

Why defer all notifications regardless of whether we're in an IRQ or
not? The point about batching
is not clear cut imo, by doing notifications exclusively as IRQ work
we are either delaying reads
by a nontrivial amount of time (in which case batching does decrease
the number of notifications)
or we are not delaying the notification almost at all (in which case
we are not batching).

>         return 0;
>  }
>
> --
> 2.53.0
>
