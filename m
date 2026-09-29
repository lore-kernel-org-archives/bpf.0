Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958A51AFEE
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683352; cv=none; b=tSGZnf8y/YbIRXip2jAHscmStJhrnt4mapTstY6Vrb6yhy5ZgrsCKWPP5hr0JlGfN79q+HmAoJqDozWJsYRfh55oQui3kbZxI/o+oAoxGhKD701KBLF3PnKYZHo5BVGdrHiipz1S9YjBAiNmz/RMF3AXk6qkx8hVQcVuvQCrEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683352; c=relaxed/simple;
	bh=u2URI7H77FV2uO5yHbYVmhBdQqokMH1WgTp4YXioDBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy0XFnbpbg7wLFpS5xrUyhZNAOMuoVuhxv9oL7seZS8zMgfwxqpO+XrgKyo6XVBrsC/EFof8wBjllGd++1pSleZ5juWJjpSAUUekcASv43cOllb0JPFKjcqXrMs5Wv9p42WjjmboncThRrl+EmuVS54GG+jrTysDiNl3vnn+W9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD5jehd0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD5jehd0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so4137115e9.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790683349; x=1791288149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25t3+cyX1TPzgjhiGoYamCjE9uBsBXHzwHyGo2dqa6I=;
        b=nD5jehd0B01tU5MAmPCHBfC1w2TudAYVyp0Kd5X4iW3mD84KWMejL5dejiA0chU2Mt
         vgSgaybHnVIJddWo5ngC/bOqgVoMeapmp+Isinjyd7I6utaMRM6df8XM8ZpR4iVhyFPo
         e7VGjuOKq9mTDV2vv4Eh95Sr7HtiYjNbqiZtc3eOD8D1Wrzb16kmCLTfIprw9w6Hzdty
         +BOq1BuSiCj6txG6EzyLzEJoNOdhisYyM0o65Cgryyk8d7QA//ZD7otWJa2d1OjPi0w/
         5rWcavr4XQSZ/09mwDd5dAmJVfN3+m/eMBlG3kLUM5PP4iUYclY/mB8+bxvqws//nMK1
         VCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790683349; x=1791288149;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25t3+cyX1TPzgjhiGoYamCjE9uBsBXHzwHyGo2dqa6I=;
        b=rNwP8bX9WfKfyxrzrYZosYVUWjUmvz3HvG4VA464nkpEHjfeCnWWLNwoMz5U6CmZ/o
         U4qznFHk+QIckBk/ha5jH3RkFd2BUwZAObPkPhBhi4uxFZA+FArFXSYlhCkdgem/aTUq
         +4yCJvUslQLnZZid4oSMTfuBQ+r6tuXS8ZpOFutO13P8okbh+gjXKxfCPxhx/eSk5DOj
         2lp3cZDk9KW6PNp60nGJeQ+cRXoieqhZ/PoXkIL+F3nmcCYQBa6kSUlOCSHiXUnfSDIp
         e9Kgxs/8M8ru3XpBfrC8ryyFTpQe/0U/OF8Kxxb5HarJ81z30t+bIYZdu3eg+5I9vHhD
         Gqjg==
X-Forwarded-Encrypted: i=1; AKwUvBwiX10s1teNSoCsD2HSYnV+K9CAikJWiIdN0pc8lob+u46t46AWemMyHM6kVQiIuKAPdXQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l9k/KBRVIDjTIgbZLb3sEyI/yvkR/V9Khv8UQ9lCI1qujwaQsx
	ixAnThZtH/h8bSjpYP1JwlSLNEOzDXbV+c2+H9m5jhFZobU3Evb+pLjX
X-Gm-Gg: AYBFou2TxDYVWjHYnEZTD+RThMhN7RwJSWVTRsUsjxyX4SURAHYPoeD89Hb6eulacMH
	+QixnWSMROt4DREm/9QImOC3JaYTHa0Jo2v8kd1aueIaxapplgJIMeIttwUaH9JIO0Kjq8DkvWZ
	2BGr43GpHmyf7CNq+rDletHfZEPTZHyHghpGo8fSHDp1vMAJoFvsi+YhmVE/4LtA3dKXugri/Md
	J4ChQPl7ILxT1PJ2xtutzRhJSY2pvzWQccsH0+5b6I4bo0X3KvfIt3cQpENnSQiPF8ktSxCPTTM
	tTdcqcEr4tYpVbDEJk3ZzlVOdUiQVDXinbZW9GjQx8rcFAl9/LNMbpSrtsXDu2m/DEB8i/F4c+O
	WdSuzGPH/qQjulv+eU1Ay7VxeQL2Ff9jlMVgBWi0HcMo7JRVtM3kmYt5H++u6IYUU8KHTdLfnTP
	EMtVWq+ehSAxQNLUmVWKuW0M301WHHmD8Vr4WBoavDydsi8jfD0YVwA2nNgs/Q7c/B04EAZw/wH
	HjbqMjiowO7s06SjRZf4dB0TDRghWquVrs=
X-Received: by 2002:a05:600c:4ec6:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-4a00d770386mr37629215e9.10.1790683348633;
        Tue, 29 Sep 2026 05:02:28 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:bbf9:6e62:677e:7b50? ([2620:10d:c092:500::5:e8fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00ed06ea7sm54200505e9.4.2026.09.29.05.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 05:02:28 -0700 (PDT)
Message-ID: <434f2e94-190c-45cb-8d91-54310da039ea@gmail.com>
Date: Tue, 29 Sep 2026 13:02:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Prevent task work context reuse
 while irq_work is busy
To: Yun Lu <luyun_611@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org
References: <20260929072800.113129-1-luyun_611@163.com>
 <20260929072800.113129-3-luyun_611@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260929072800.113129-3-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/29/26 8:27 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> A bpf_task_work context can return to STANDBY before its scheduling
> irq_work handler returns.  Both callback completion and task_work_add()
> failure can publish STANDBY while the irq_work is still BUSY.  A new
> round can then reinitialize and queue the same irq_work on another CPU
> while the old handler is still running.
> 
> One concrete interleaving is:
> 
>   1. CPU 0 successfully queues ctx->work with task_work_add() and pauses
>      before its SCHEDULING-to-SCHEDULED cmpxchg.
> 
>   2. The target task on CPU 1 completes the callback, resets ctx->task
>      and publishes STANDBY.
> 
>   3. CPU 2 starts a new round, changes STANDBY to PENDING and queues the
>      same irq_work.  The new handler changes PENDING to SCHEDULING, but
>      task_work_add() returns -ESRCH because its target task has exited.
>      The handler has not yet reset the context or rolled back the state.
> 
>   4. CPU 0 resumes and changes the new round's SCHEDULING to SCHEDULED,
>      even though no task work was queued for that round.
> 
>   5. The new handler resets ctx->task, but its SCHEDULING-to-STANDBY
>      cmpxchg fails.  The context remains SCHEDULED with a NULL task, and
>      subsequent attempts to acquire this context fail with -EBUSY.
> 
>   6. Map-value deletion observes SCHEDULED and queues asynchronous
>      cancellation, which passes the NULL ctx->task to task_work_cancel().
> 
> Overlapping invocations also share one BUSY bit.  An invocation can clear
> that bit while the other invocation is still running.
> 
> Initialize the scheduling irq_work when the context is created and stop
> reinitializing it for each round.  After claiming the context with the
> STANDBY-to-PENDING cmpxchg, check BUSY and reject reuse with -EBUSY if a
> previous invocation is still in progress.  Checking after the cmpxchg
> orders the BUSY read after the STANDBY publication.
> 
> No irq_work has been queued for the attempted round at this point, so
> the rejection can roll PENDING back to STANDBY.  Use cmpxchg for that
> rollback to preserve FREED if a concurrent deletion has published it.
> Once BUSY clears, scheduling can be retried.
> 
> Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  kernel/bpf/helpers.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 028fc6796b59..350269b8646e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4553,6 +4553,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
>  	memset(ctx, 0, sizeof(*ctx));
>  	refcount_set(&ctx->refcnt, 1); /* map's own ref */
>  	ctx->state = BPF_TW_STANDBY;
> +	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>  
>  	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
>  	if (old_ctx) {
> @@ -4595,6 +4596,18 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
>  		bpf_task_work_ctx_put(ctx);
>  		return ERR_PTR(-EBUSY);
>  	}
> +	/*
> +	 * STANDBY can be published before the previous scheduling irq_work
> +	 * returns. Claim PENDING before checking BUSY to order the check after
> +	 * that publication. No irq_work has been queued for this attempt yet,
> +	 * so reject reuse and roll back to STANDBY while BUSY is set. Preserve
> +	 * FREED if deletion wins the rollback race.
> +	 */
> +	if (unlikely(irq_work_is_busy(&ctx->irq_work))) {
> +		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
> +		bpf_task_work_ctx_put(ctx);
> +		return ERR_PTR(-EBUSY);
> +	}
>  
>  	/*
>  	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
> @@ -4644,7 +4657,6 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
>  	ctx->map = map;
>  	ctx->map_val = (void *)tw - map->record->task_work_off;
>  	init_task_work(&ctx->work, bpf_task_work_callback);
> -	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>  
>  	irq_work_queue(&ctx->irq_work);
>  	return 0;

