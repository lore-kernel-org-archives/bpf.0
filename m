Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691423DC970
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125743; cv=pass; b=GoGCl6NuqDblog0i04v6+VPWMa/1JD3ZBi9DzysoBalVYPr7gkXm9hdFftQLn48m3TnkNHepJG11UARP5jWyuzRlY6cSeq//acpgcrLH02o43mb9U3Yr0xixNFX5GQQhSk8Aihntq6uCjonKkEgSGWS9eiGrir6jSDPsxgO9VcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125743; c=relaxed/simple;
	bh=XFNBYkqy/qL9pAB3omkhETgbB3B+UoCdabtMOdkTF1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwZCK+O3BmCjMABC0sP49aOW7QHyn/z70Yi3MjLMRsHq2z+jxIQWU7xvC23SU5ai5yTPk82plj28VU2yhieN+KaMsZHGbhJmzXpFF82t4IH4wSnfvcDxogj1foa7oXV3L2SfrS0NhQzaKw3GzyMmYnIQjLLlHzoiHS4JqpC16iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxftVDU2; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxftVDU2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so737036a91.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 15:48:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769125735; cv=none;
        d=google.com; s=arc-20240605;
        b=cwOYiQMCe2PsSdxrj3YS2ZKiio7H+GXTE5TBsMYm1m02VHNRmllU1qNqWUPI7F1OI9
         So5t92gJAEqRnUUhU+6lOgJZBEHNJ8kabwELLfrw4V9/P9/sEYlq+jHnpfUYhNTCeITj
         cE8AdaR793YPd7eIkywPY4y5kL618IPA3Y0s/2nh3otgoyhERztc7xu5HJC54GrEAHL9
         Pv6LAvv0M3osThcnyGCgdbz//I4plEJnYoD+nz2pWsAc0ahO1kXY0aMQs2kwtVec/mPx
         OKnH9iZ/SP3e43DTa2OZ/8vK109Qk8PKAE5RryjMDgk7OTIkx7iiys+pVBlTp9nHNs0W
         pHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1b52txf9vFv4WYpVv8fV1rN9/rUFJqJApjV6TOdgkQg=;
        fh=be3ZzmqAIbRlSghzgFcEfYPfCYPMzDKw5fMGW4LljfE=;
        b=DPQ/u6+ITsX3iGjGJPnL4nJQTIS8efL6iXY9OjwZI5NUIpEoWBBAfs/4eFRVlmCVhQ
         j/w8ZcBiNRxdpiwhDuQ5UJQU7XeQjUx1Tq4FpKAYj67Go4MGxy3nnPq466noGijDb8K5
         bq0BtI3jRY5GPzag3ocmNgnB6pu/mLMJDOOvKmocp+G9e4U7pbck37RpPwNV80ELqzSz
         SOsrVcsiSEVFTs0OBu840kQjkAj2RzIvbxNfU5eJhS5ozE9b9vVWbgKJSSEPgAB3oHeq
         fcDTrmJMEB6DYkkAGig7T5iytSbtokHtTq07FkqMIJpxpJChEIrcFVLLqUY7LQm55zN1
         qxjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769125735; x=1769730535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b52txf9vFv4WYpVv8fV1rN9/rUFJqJApjV6TOdgkQg=;
        b=jxftVDU2CIC22IuyQTCVbZmEwkmAB5vackvgsqCFTTchl2U+jaPO2vpQ7cU0Ucqlfl
         pdhpm/bIomFBaq4MBJ56kU9xRtUaDguudy9UNRMfFn5XAp9UFthfllolMZzVpGBcYU0W
         di63bDMf9kns7figzxV+i3m5N/W7h3xR88W4TvlY5xGLemq6iWEEe+lzOkB9WP9ucrCm
         +KjMHXkFD4Cse4vBdzVS7HE8hdTk0C5AUEBgKpK4QFI9Xn9r2m91LzYPjdeNlzeCB+zX
         1DrKZMDSuLwkU1jGjeRTq5xmYKOFKQlEdNYXdsd2wJI1s+zycgmSflDxQainwtsXGpT7
         R61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125735; x=1769730535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1b52txf9vFv4WYpVv8fV1rN9/rUFJqJApjV6TOdgkQg=;
        b=wDiVb7KJG++dnFfGCv1y6fBuSaDc8xh2HfWWxKoH3PBbGF28GY4bwHQvT0YndjwYjI
         IF4bnu2J0s2/qxCJ2IVWAlIgmAHNecBTetYWmUIybTOJP8DTTl3JThSu8PPIc0ghkk43
         Y8SUzvgG3hqMVfpnB3XMvd75RxtRTWXeT88xQSAa3ElEYTc9GW0+b4y6D5kG2k2Xk0rL
         I0H23YDgrL0BaQRiXac4SSyA61ri1vs5JiXyLR53SnB03B9L+YtuZcMZ1pGtkIyeabuh
         tohnzTLto+Hief7zBOiaV2aajlbVLMx9EX2vCr8pNDcCNbGlL0tUABEm5m3RGnFuPlEB
         FcDA==
X-Gm-Message-State: AOJu0YxtAM7F7EwNIed43xR2/hlHzUw0V9fonoNtOzBWPfIOzbPKWOhq
	xw2vuQH5BjPnou80ylxeIDL51M5FbzjX0LjkMXyUJ8XmIVfhAlODlF2pURi4+KXRsvtdSe1S6XX
	TEjYrkA9bcHmff3Nk5+5ApZ/58mSMpYFk615D
X-Gm-Gg: AZuq6aKytjPk4bjp7lTVx5AR36nSORtogqLtgL5zElTjfOvshOluKSmoZucjJgRPU3s
	HeQi35gcFf8cfZbdsRp4+37SCYLg7ZzxJdqvY3B6UifvE5Yj92078Ss8KgY9ACUKITpOUA+wozh
	GzILdiae8Zud4VUlsGXJLNSKaMCIVBjZerQo8EMnWcf3C3BpEX894r5ds0TCwgDt2FyPQo9npK3
	zjQisbEwzxU2Jt568iD5+uX2CvWPURxEw1cKiNjzji63IRaXHDZUSCM/sMEmVA0l+ld3evdpbjC
	slrBZijZOXuOAYu0RgGp2Q==
X-Received: by 2002:a17:90b:6c3:b0:34c:3cbc:db8e with SMTP id
 98e67ed59e1d1-35368b45324mr854193a91.25.1769125735217; Thu, 22 Jan 2026
 15:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com> <20260122-timer_nolock-v7-1-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-1-04a45c55c2e2@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jan 2026 15:48:42 -0800
X-Gm-Features: AZwV_QihYD1EZUIJy_JjP4avRDsl-AHTiouqUwyK-LSYk5Os083wJx3EmUFsu7M
Message-ID: <CAEf4BzbV_g6SZqB-6N3eRz1x3ODKFGGrDxG4GO+BxoNnV4fojg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/8] bpf: Enable bpf timer and workqueue use
 in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:03=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor bpf timer and workqueue helpers to allow calling them from NMI
> context by making all operations lock-free and deferring NMI-unsafe
> work to irq_work.
>
> Previously, bpf_timer_start(), and bpf_wq_start()
> could not be called from NMI context because they acquired
> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
> patch removes these limitations.
>
> Key changes:
>  * Remove bpf_spin_lock from struct bpf_async_kern.
>  * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
>    atomically.
>  * Add per-bpf_async_cb irq_work to defer NMI-unsafe
>    operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
>    NMI to softirq context.
>  * Use the lock-free seqcount_latch_t to pass operation
>    commands (start/cancel/free) and parameters
>    from NMI-safe callers to the irq_work handler.
>  * Add reference counting to bpf_async_cb to ensure the object stays
>    alive until all scheduled irq_work completes.
>  * Move bpf_prog_put() to RCU callback to handle races between
>    set_callback() and cancel_and_free().
>  * Modify cancel_and_free() path:
>    * Detach bpf_async_cb.
>    * Signal destruction to irq_work side via setting last_seq to
>      BPF_ASYNC_DESTROY.
>    * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
>  * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
>    task trace grace periods before freeing the bpf_async_cb. Removed
>    unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
>    task trace lock.
>
> This enables BPF programs attached to NMI-context hooks (perf
> events) to use timers and workqueues for deferred processing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 434 ++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 252 insertions(+), 182 deletions(-)
>

Aside from that premature refcount_put in cancel_and_free, it all
looks good to me.

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async=
_kern *async)
> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
>  {
>         struct bpf_async_cb *cb;
>
>         /* Performance optimization: read async->cb without lock first. *=
/
>         if (!READ_ONCE(async->cb))
> -               return NULL;
> +               return;
>
> -       __bpf_spin_lock_irqsave(&async->lock);
> -       /* re-read it under lock */
> -       cb =3D async->cb;
> +       cb =3D xchg(&async->cb, NULL);
>         if (!cb)
> -               goto out;
> -       bpf_async_update_prog_callback(cb, NULL, NULL);
> -       /* The subsequent bpf_timer_start/cancel() helpers won't be able =
to use
> -        * this timer, since it won't be initialized.
> +               return;
> +
> +       atomic64_set(&cb->last_seq, BPF_ASYNC_DESTROY);
> +       if (!in_nmi()) {
> +               bpf_async_refcount_put(cb);

__bpf_async_cancel_and_free can be called (through an amazingly long
chain of function calls) from bpf_map_fops->release callback. And I
don't see any rcu_read_lock() there. So... why would you put a
refcount *before* calling bpf_async_process(cb)?  Please move it after
we are done with cb. I don't think we need to guard(rcu) in this
function just to handle this.

> +               bpf_async_process(cb);
> +               return;
> +       }
> +       /*
> +        * Attempt to pass our initial map's reference to
> +        * irq_work callback, if we fail to schedule it (meaning it is
> +        * already scheduled by someone else having their own ref), we ha=
ve to
> +        * put that ref here.

[...]
