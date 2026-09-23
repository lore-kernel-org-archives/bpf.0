Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33941DE0B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185611; cv=none; b=r0X58cSbHj3/llm+JnaodZ4K+qTBhrtAskKwmYqyr+lOKnvWypieWSJIbcYSZQC1g5j2psr2ujKlEVCO9W8kKumIc/lwQ0joWS7eRH/XfHjPxH9KNS2WFLCv/T/GN+Jf9Zl7ZxGyMTAPvhsIuWPuxuQMTm39W881LazOOvdBgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185611; c=relaxed/simple;
	bh=lP2OgPqu+JD5hB1tQuwpfRlYKxQDs/daV7pHWgsxC6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAFmqrTNMiMNlOhz4/sdf7CQZpnKb11gBAko2AR47OyEMTQgHm9LeKD/X7BMBYvBJsi0EHZkOVoMPT+gbvPr1PYqQ/1FjPBfhV8b1/gBNlRtLtibchmRGgVcYuw9T5In8Da5wm5BKZh3GrNkSyxOQpIH4iNIHytHzmes0q41zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJqxPa5s; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJqxPa5s"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccff31419so10401465e9.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185608; x=1790790408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hu1szklrFioxUEuCp0/xB0UbpfSk2IRsnn4COvSBApI=;
        b=MJqxPa5skDGt5oDm2u+qo2Vf9dPQVx9fdiSf48M+oaFIpFoCpBl9VI/+If8VbeYNHX
         QDtSOEH+5syF3cn/eS5uwV9fKKBl1Fq4IaKW4PrOy5I0a6l7QxPjZJA4RmcxHaoayuV/
         9rYNQm1X8YJGNmY850SU/oTLG1UhZscmHcuQMtaW4Tui8UKxQQ30DZ3D9aq+13hGFKUZ
         aix4gNS74qY+Ee/tYQ6TG/E6/5B7mLurXVbltmBb6lGk/Lvwm9sv+van46nH0k590dl6
         ZBalZ3BOPonxL3rhTJ0FAQHXTXu5xQisSwLmHtS/rXDCuU+kUZTMAUGDrHtII2MtfBO+
         7n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185608; x=1790790408;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hu1szklrFioxUEuCp0/xB0UbpfSk2IRsnn4COvSBApI=;
        b=aJLnbkZ4ao0Vhd6fZlHMGnswoQeFdYFpNdZ824RYagf7lo3DpbVgQnJBrBJ3A/uuu5
         GmQ3aikLfx7AFMpZBYlaKgnl7BUPVTpaG5XebeBVo0z77TG8ygd4XfV1R1FeJmBGIbOQ
         +n9ptfpTdb0ftTfllViQ4xRgk+G8TF40sqtuxduukZ8jxTtJ8Rq60eg3CeD0bWHjMHnK
         6bfmr/LlfAXx/eFqUDFnxqZo9KIv/5clEnPvAELmxT8auOYMdte1nNRaXQJXK5+D3o7s
         irxnqOWaMYQAGvm+4DvXpAXZRIeHyOfLyd5qOGDj22DfEJsBnMg9kmWw8HF1NyMVkd2y
         pmMQ==
X-Forwarded-Encrypted: i=1; AKwUvByY669pbcqkLVv23MiNTtPfeu4rdKQeDLYoacQAAbHtZNiFfIPhZp0CTYhXqfEZUhq+N/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lHEr6M+oPF30TeD5B8+zAuIaKqu+n/2UrPpXf45Ob2SbECvl00
	wY+Gtj85nBfpLcZHQY4XxlmQ+Cc1PiSq43PgWlxuH3UG5xS8Gp1niaze
X-Gm-Gg: AYBFou0fM3j5Qb+LdCWNYrEfP0A0eCl+P+RrNGsIRtnpZ+/Qgs3WgYJuoW374FhIy4T
	bgLmxDskV0O47dZpgip+eojfUQjY9txpKkoEO4pVsARErJ7RUxl0ekNRFjMdmpdjLLUL/Ag+2T5
	3jOS6l6j72vetHvpoz4wAMthO8KaT43LXS2OlR3BdFGXY3YhLdDiUttk0s6aBvQbyn+guCXHQ8u
	oMxj/+DdjlAGzR2AAHgs3beBD5xHkSKPBfXlDH2aFYNM+h28k+B+fS/m3tAT8gcDdFyRsN/9/Ag
	aGqNsfQrO9vHwmnRWkjeKHedokBXBKBZyhDDT41Jm3O5j2whiu3Gb7rbwFRpu7UUvY9SV2KbIVv
	r9KkfH3V2eshhvd55GGjrOFpxvMRMq3udr5xchzTc9zoV7IprXSJ82/OZ32K8GI4qYw6XcHJb9M
	CsiYz548sy9N3C0j32Kywn7BFhlwk0c9Keb99JWuo+EZtZf2Grnhdt0AoOGKo88heP1f8bGzYhK
	UiBB9RlrrCg2kmFqrEE3+SwKXq2GwOu0jA2gbOENr2w
X-Received: by 2002:a05:600c:5020:b0:49f:d377:ac24 with SMTP id 5b1f17b1804b1-49fdeff8236mr53366425e9.3.1790185607412;
        Wed, 23 Sep 2026 10:46:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:397:fdb0:a40e:d985? ([2620:10d:c092:500::4:7d16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5df44f9sm1905615e9.11.2026.09.23.10.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:46:46 -0700 (PDT)
Message-ID: <03fe858d-b3dc-4244-9a4e-6177a0530344@gmail.com>
Date: Wed, 23 Sep 2026 18:46:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix task work scheduling and
 callback race
To: Yun Lu <luyun_611@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org
References: <20260922100042.136818-1-luyun_611@163.com>
 <20260922100042.136818-2-luyun_611@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260922100042.136818-2-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 11:00 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> bpf_task_work_irq() publishes a task_work callback before changing the
> context from SCHEDULING to SCHEDULED.  The callback can therefore run on
> another CPU while the irq_work handler is still using the same scheduling
> round.
> 
> Nothing currently orders the handler's use of ctx->task against
> bpf_task_work_ctx_reset().  The callback can reset ctx->task and publish
> STANDBY before the handler resumes, allowing map-value deletion to make the
> handler pass NULL to task_work_cancel().  Publishing STANDBY this early
> also allows a new round to reuse the context and irq_work while the old
> handler is still running.
> 
> One concrete interleaving is:
> 
>   1. CPU 0 changes PENDING to SCHEDULING in bpf_task_work_irq() and
>      successfully publishes ctx->work with task_work_add(), but has not yet
>      attempted the SCHEDULING-to-SCHEDULED transition.
> 
>   2. The target task on CPU 1 runs the callback.  It changes SCHEDULING to
>      RUNNING, executes the BPF subprogram, then bpf_task_work_ctx_reset()
>      releases ctx->task and sets it to NULL.  The callback changes RUNNING
>      to STANDBY and drops its ctx reference.
> 
>   3. CPU 2 deletes the map value.  bpf_task_work_cancel_and_free() changes
>      STANDBY to FREED.  Since the old state is not SCHEDULED, it does not
>      queue cancellation and drops the map's ctx reference.
> 
>   4. CPU 0 resumes.  Its SCHEDULING-to-SCHEDULED cmpxchg observes FREED, so
>      bpf_task_work_cancel() calls task_work_cancel(NULL, &ctx->work).
> 
> If deletion changes the state to FREED before the callback runs, the
> callback instead takes its FREED exit and may drop the last ctx reference.
> The destroy path then resets ctx->task, producing the same NULL dereference
> when CPU 0 resumes.
> 
> A controlled reproducer that delays CPU 0 between task_work_add() and the
> state cmpxchg triggered the following fault on a v7.3-rc3 based x86-64 KVM
> guest:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000890
>   #PF: supervisor read access in kernel mode
>   RIP: task_work_cancel+0xd/0xa0
>   RDI: 0000000000000000
>   CR2: 0000000000000890
>   Call Trace:
>    <IRQ>
>    bpf_task_work_irq+0x95/0x100
>    irq_work_run_list+0x4f/0x90
>    irq_work_run+0x18/0x50
>    __sysvec_irq_work+0x18/0xb0
>    sysvec_irq_work+0x66/0x80
>    </IRQ>
> 
> 0x890 is the task_struct::task_works offset in that build.  It is read by
> task_work_pending() through the NULL task argument.  The rcu_read_lock() in
> bpf_task_work_irq() only keeps ctx memory alive; it does not retain
> ctx->task.  A NULL check would still race with releasing the task
> reference.
> 
> Fix this by taking a task reference in the scheduling irq_work before
> publishing the callback.  Use the captured task for cancellation at the
> handler tail, so the task remains valid even if the callback or destroy
> path has reset ctx->task.  Release the reference on every add success and
> failure path.
> 
> The asynchronous cancellation path is queued only after deletion wins
> SCHEDULED-to-FREED.  In that case the callback observes FREED and cannot
> reset ctx->task, while the map's transferred ctx reference prevents the
> destroy path from doing so.  It can therefore safely pass ctx->task to the
> same cancellation helper.  The two cancellation paths are mutually
> exclusive: the scheduling handler handles deletion from SCHEDULING, and
> the asynchronous path handles deletion from SCHEDULED.
> 
> The callback or add-failure path can publish STANDBY before the scheduling
> irq_work returns.  Initialize irq_work when the context is created and
> reject a new round while it is still BUSY.  This prevents the old handler
> from consuming the new round's SCHEDULING state and publishing a false
> SCHEDULED state, and prevents invocations on different CPUs from
> overlapping on the same context.
> 
> This keeps the task-work callback non-blocking and adds no context fields
> or states.
> 
> Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> Reported-by: Jackie Liu <liuyun01@kylinos.cn>
> Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---

Looks good, the only thing that bothers a bit is
PENDING -> STANDBY transition when irq_work_is_busy(),
but overall looks like the cleanest solution.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  kernel/bpf/helpers.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3cc5c8fc875..d8bea7538de5 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4437,7 +4437,8 @@ static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
>  	}
>  }
>  
> -static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> +static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx,
> +				 struct task_struct *task)
>  {
>  	/*
>  	 * Scheduled task_work callback holds ctx ref, so if we successfully
> @@ -4445,7 +4446,7 @@ static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
>  	 * cancel, callback will inevitably run or has already completed
>  	 * running, and it would have taken care of its ctx ref itself.
>  	 */
> -	if (task_work_cancel(ctx->task, &ctx->work))
> +	if (task_work_cancel(task, &ctx->work))
>  		bpf_task_work_ctx_put(ctx);
>  }
>  
> @@ -4486,6 +4487,7 @@ static void bpf_task_work_callback(struct callback_head *cb)
>  static void bpf_task_work_irq(struct irq_work *irq_work)
>  {
>  	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
> +	struct task_struct *task;
>  	enum bpf_task_work_state state;
>  	int err;
>  
> @@ -4496,7 +4498,8 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
>  		return;
>  	}
>  
> -	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
> +	task = get_task_struct(ctx->task);
> +	err = task_work_add(task, &ctx->work, ctx->mode);
>  	if (err) {
>  		bpf_task_work_ctx_reset(ctx);
>  		/*
> @@ -4505,19 +4508,20 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
>  		 */
>  		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
>  		bpf_task_work_ctx_put(ctx);
> +		put_task_struct(task);
>  		return;
>  	}
>  
>  	/*
> -	 * It's technically possible for just scheduled task_work callback to
> -	 * complete running by now, going SCHEDULING -> RUNNING and then
> -	 * dropping its ctx refcount. Instead of capturing an extra ref just
> -	 * to protect below ctx->state access, we rely on rcu_read_lock
> -	 * above to prevent kfree_rcu from freeing ctx before we return.
> +	 * The callback may have completed and reset ctx->task already. Keep the
> +	 * captured task alive until this invocation is done with cancellation.
> +	 * The RCU read-side section keeps ctx memory alive until then.
>  	 */
>  	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
>  	if (state == BPF_TW_FREED)
> -		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
> +		bpf_task_work_cancel(ctx, task); /* clean up if we switched into FREED state */
> +
> +	put_task_struct(task);
>  }
>  
>  static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *tw,
> @@ -4537,6 +4541,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
>  	memset(ctx, 0, sizeof(*ctx));
>  	refcount_set(&ctx->refcnt, 1); /* map's own ref */
>  	ctx->state = BPF_TW_STANDBY;
> +	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>  
>  	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
>  	if (old_ctx) {
> @@ -4579,6 +4584,18 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
>  		bpf_task_work_ctx_put(ctx);
>  		return ERR_PTR(-EBUSY);
>  	}
> +	/*
> +	 * The callback or add-failure path can publish STANDBY before the
> +	 * scheduling irq_work returns. Do not let a new round reuse the context
> +	 * until BUSY clears. Otherwise the old handler can consume the new
> +	 * round's SCHEDULING state and publish a false SCHEDULED state, and two
> +	 * invocations can overlap on different CPUs.
> +	 */
> +	if (unlikely(irq_work_is_busy(&ctx->irq_work))) {
> +		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
> +		bpf_task_work_ctx_put(ctx);
> +		return ERR_PTR(-EBUSY);
> +	}
>  
>  	/*
>  	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
> @@ -4628,7 +4645,6 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
>  	ctx->map = map;
>  	ctx->map_val = (void *)tw - map->record->task_work_off;
>  	init_task_work(&ctx->work, bpf_task_work_callback);
> -	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>  
>  	irq_work_queue(&ctx->irq_work);
>  	return 0;
> @@ -4777,7 +4793,8 @@ static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
>  {
>  	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
>  
> -	bpf_task_work_cancel(ctx); /* this might put task_work callback's ref */
> +	/* SCHEDULED -> FREED keeps ctx->task stable until this runs. */
> +	bpf_task_work_cancel(ctx, ctx->task); /* this might put task_work callback's ref */
>  	bpf_task_work_ctx_put(ctx); /* and here we put map's own ref that was transferred to us */
>  }
>  
> 

