Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCA39E6F9
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728475; cv=none; b=f0brwLZ/Ahi42VdYGuX5O8m16vlbnFL3GBriIXieyJh4HSoCiUohDWRqqLf0m+mw4jcddEAgqk+2gxwHxOr2GdguDudk+5zrk20sUCNxozjoAUGpg2uzuIEx7U6/HezJKaDa+995xN5FavMascdBnhmehXp5sbcYlGkP4Xfkdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728475; c=relaxed/simple;
	bh=Eak3gUFoQZmE7urEtUIA28QWb2KoIfKbptSQSa3R8S4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwsKj1G2fzDzeAcKMG8D/Gm4ODj0T0Twn1ONPMQi9yrxSuWWyVCC9n9f1MRYl9k7/1Ezav6CDh4frLw7rWhOGW/2Uevs8S62UfDaAvJPJ23RwAFyWbf49MWepMIlkJYfdjcSYrM/91ddPemh9CDy82I0A3GK1H6ErI0irYbdSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HalKg6yg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HalKg6yg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480706554beso89709945e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772728472; x=1773333272; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdoTHa7mB5OgfvuGicTKRYik17ItaSs4ar4HiIGJhtI=;
        b=HalKg6yg/Xgw09vusyYkP3uPQ4oXrQbsBYT1of1B0NWb554Suq+nkJXcxjzat+1zMq
         6k2v8M0DcvvvHcOnH1GIkuN5W4YNUadJbhdqKvRVZVUddQ/d34cEuEN8NBgpS9T+OT25
         KD7NLpl1ZwWH4J+ZBLXuSJs8wJx2UbUNKfTiM0Fi/IorVRqubQG6lh83Sf3Ae2RNz+as
         EIVWkZt56b4ukqk7snmsxpPnS7YISarGmUC0cWYEi3HrURzbxlLFfNFiKZQHbYRrWTBH
         T3ohJK/9YS15AUcE645sWVYtw3lvNb8SxXgHD0Ldo0rjG2cVqP017aF0j7gl15aHk47y
         jKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772728472; x=1773333272;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdoTHa7mB5OgfvuGicTKRYik17ItaSs4ar4HiIGJhtI=;
        b=Zxxw4m8OKeDkDGuYBs1FhhXcp6IryC52rdHVFoJg4DFyjBv2F+JjwBHFFhQEzOdlFN
         5fVoUPDdqQDEV14iVTwrrcRhDHYHU3WR2VHmDWyOH3MhjgFPh4a73yeLB9KuDZsJQmFN
         86so6C+mRfDujrNL6vFSVRmduxoo76F5a8B8Fu/XVYNsJVDtMjdLtfskg7LQS9RNiRZV
         wRptXKtcmPsa+nNJdhvMagG+RPknioO/d2R6mEKbLadF0o7Bq1UIRtJl8tluXLyGgLb9
         nYdXaeCNSHEcvUB4D2bBVToxm0/WHmjVDVoux0LjhKGEKQC8QzLBZyWupeZCRo2oIJuD
         Ax0A==
X-Forwarded-Encrypted: i=1; AJvYcCVo5nRNDZE9DDokqPrV7F95t2WZESAkQisz/k9xfpLKrKWFZxB5dAkzpRef4W0Hwe97p/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGvKs2QJxuJMm9EgOYJAw3cBJKOMq/SJwgW026+jLLQkXH/Vs
	d6PzuOI+Bdw/j4V21z4eKhzqWdufHypyd0IstIVh89Aqj1AaJp156KK/
X-Gm-Gg: ATEYQzw8OPOx6Rx0UmdlTAdfcGDHB18Fle8X3/rMqTj5yRQ8/OWChuVAJe5e/tjvm9v
	9X9cHJukxFDzLnBY3YNRbr7hWbyIeMiuGbuvJ25rwHHFAxpn8ERMV27hjXrwYxEvH8jIyLCVDf0
	hr950WNQWOevxD6AkVeKORdiU+L42Hlskj5DgBfi5zFvFszZhTBUZJljq/K2c9hNi6vcc9XOKkP
	I51f56Z1lrO92EnNvlaopmEHNvfErX+2MTGsFY065U4hVpHTHC06HcrXVETaL3sM/5hSOYFHrgI
	Bj7kB3IVZrLAUmVU19dApIMC7bl4RZCxcxFwv8sCzgrDcMiJNVUfagHXd8bMgreC3exuajqosKL
	8s2UM3fNhVCKRnNlGyvA+vBMLX6p5QgY0wa/hgSpHf5HmLz87QlERmNX9K9hULx33bRd63aamgg
	r2dSxoH+qZuvjfrsi6iVVaEtxSJ6TpaFTEifK8cw==
X-Received: by 2002:a05:600c:34d6:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-48519839269mr123112145e9.2.1772728471782;
        Thu, 05 Mar 2026 08:34:31 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fad02a2sm77041115e9.2.2026.03.05.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:34:31 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma
 iterator
In-Reply-To: <20260304142026.1443666-2-puranjay@kernel.org>
References: <20260304142026.1443666-1-puranjay@kernel.org>
 <20260304142026.1443666-2-puranjay@kernel.org>
Date: Thu, 05 Mar 2026 16:34:30 +0000
Message-ID: <87pl5ixmjt.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> The open-coded task_vma BPF iterator reads task->mm and acquires
> mmap_read_trylock() but never calls mmget(). This violates refcount
> discipline: the mm can reach mm_users == 0 if the task exits while the
> iterator holds the lock.
>
> Add mmget_not_zero() before mmap_read_trylock(). On the error path
> after mmget succeeds, the mm reference must be dropped. mmput() can
> sleep (exit_mmap, etc.) so it is unsuitable from BPF context.
> mmput_async() is safe from hardirq but not from NMI, because
> schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
> which can deadlock if the NMI interrupted code holding that lock.
>
> Add a dedicated per-CPU irq_work (bpf_iter_mmput_work) and a helper
> bpf_iter_mmput() that calls mmput_async() directly when not in NMI,
> or defers to the irq_work callback when in NMI context. Use it in
> both the _new() error path and _destroy(). Add bpf_iter_mmput_busy()
> to check irq_work slot availability, and use it alongside
> bpf_mmap_unlock_get_irq_work() in _new() to verify both slots are
> free before acquiring references.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 77 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 98d9b4c0daff..d3fa8ba0a896 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -813,6 +813,55 @@ struct bpf_iter_task_vma_kern {
>  	struct bpf_iter_task_vma_kern_data *data;
>  } __attribute__((aligned(8)));
>  
> +/*
> + * Per-CPU irq_work for NMI-safe mmput.
> + *
> + * mmput_async() is safe from hardirq context but not from NMI, because
> + * schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
> + * which can deadlock if the NMI interrupted code holding that lock.
> + *
> + * This dedicated irq_work defers mmput to hardirq context where
> + * mmput_async() is safe. BPF programs are non-preemptible, so one
> + * slot per CPU is sufficient.
> + */
> +struct bpf_iter_mmput_irq_work {
> +	struct irq_work irq_work;
> +	struct mm_struct *mm;
> +};
struct mmap_unlock_irq_work is exactly the same struct, perhaps an
additional patch renaming it to something like struct bpf_iter_mm_irq_work
is needed. Then we can reuse it for mmput.
> +
> +static DEFINE_PER_CPU(struct bpf_iter_mmput_irq_work, bpf_iter_mmput_work);
> +
> +static void do_bpf_iter_mmput(struct irq_work *entry)
> +{
> +	struct bpf_iter_mmput_irq_work *work;
> +
> +	work = container_of(entry, struct bpf_iter_mmput_irq_work, irq_work);
> +	if (work->mm) {
> +		mmput_async(work->mm);
> +		work->mm = NULL;
> +	}
> +}
> +
> +static void bpf_iter_mmput(struct mm_struct *mm)
> +{
> +	if (!in_nmi()) {
> +		mmput_async(mm);
> +	} else {
> +		struct bpf_iter_mmput_irq_work *work;
> +
> +		work = this_cpu_ptr(&bpf_iter_mmput_work);
> +		work->mm = mm;
> +		irq_work_queue(&work->irq_work);
> +	}
> +}
> +
> +static bool bpf_iter_mmput_busy(void)
> +{
> +	if (!in_nmi())
> +		return false;
> +	return irq_work_is_busy(&this_cpu_ptr(&bpf_iter_mmput_work)->irq_work);
> +}
> +
>  __bpf_kfunc_start_defs();
>  
>  __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> @@ -840,19 +889,35 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  		goto err_cleanup_iter;
>  	}
>  
> -	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
> +	/*
> +	 * Check irq_work availability for both mmap_lock release and mmput.
> +	 * Both use separate per-CPU irq_work slots, and both must be free
> +	 * to guarantee _destroy() can complete from NMI context.
> +	 * kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work
> +	 */
>  	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
> -	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
> +	if (irq_work_busy || bpf_iter_mmput_busy()) {
>  		err = -EBUSY;
>  		goto err_cleanup_iter;
>  	}
>  
> +	if (!mmget_not_zero(kit->data->mm)) {
> +		err = -ENOENT;
> +		goto err_cleanup_iter;
> +	}
> +
> +	if (!mmap_read_trylock(kit->data->mm)) {
> +		err = -EBUSY;
> +		goto err_cleanup_mmget;
> +	}
> +
>  	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
>  	return 0;
>  
> +err_cleanup_mmget:
> +	bpf_iter_mmput(kit->data->mm);
>  err_cleanup_iter:
> -	if (kit->data->task)
> -		put_task_struct(kit->data->task);
> +	put_task_struct(kit->data->task);
>  	bpf_mem_free(&bpf_global_ma, kit->data);
>  	/* NULL kit->data signals failed bpf_iter_task_vma initialization */
>  	kit->data = NULL;
> @@ -874,6 +939,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  
>  	if (kit->data) {
>  		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> +		bpf_iter_mmput(kit->data->mm);
>  		put_task_struct(kit->data->task);
>  		bpf_mem_free(&bpf_global_ma, kit->data);
>  	}
> @@ -1044,12 +1110,15 @@ static void do_mmap_read_unlock(struct irq_work *entry)
>  
>  static int __init task_iter_init(void)
>  {
> +	struct bpf_iter_mmput_irq_work *mmput_work;
>  	struct mmap_unlock_irq_work *work;
>  	int ret, cpu;
>  
>  	for_each_possible_cpu(cpu) {
>  		work = per_cpu_ptr(&mmap_unlock_work, cpu);
>  		init_irq_work(&work->irq_work, do_mmap_read_unlock);
> +		mmput_work = per_cpu_ptr(&bpf_iter_mmput_work, cpu);
> +		init_irq_work(&mmput_work->irq_work, do_bpf_iter_mmput);
>  	}
>  
>  	task_reg_info.ctx_arg_info[0].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_TASK];
> -- 
> 2.47.3
