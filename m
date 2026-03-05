Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB355288C22
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736483; cv=none; b=jc4IuWm9BYcyBUtm1SF9R9amWClfEaKIGdVX3jumn6jqmImfOdXcdLrB/R/NmUc5dvRWLqX4QsoD0qFLwlSwrfuT5IdjWsQS9OZOENvWZwED2HNRT+xv/8Ll06JdkTJ+D6/GmK/QpLXnyWzIuuNWysN31se9xSh1GQnyx/QUsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736483; c=relaxed/simple;
	bh=imwLACCZePFiwVwcDuJiN0CqpCIGruQYOHWmRNrWaHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPXtv4jxwpqCno4F3cdjPfTt43Dddv7Xwh8VmMfTaFnqAbS3j0t8QDqxeiTdgm9wYb4/Xw42hMfoEchMtLdXEm0oM0yvcnnL5WH0fADd7g+M0XZn6XafXHOGy4n363vBSez8i1bm0eXbGxKD2BbrNjeuJ5s+p3W3XovqamTlQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTFPd4/8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTFPd4/8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4837584120eso64251335e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772736479; x=1773341279; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QV/RGhC5ykvK6YPWqOsNlLac8i7Qu2T2qGRoYkOZpGg=;
        b=fTFPd4/804CwPlasXam0Rt/aH5Yp887MS6mXdQqueBys/YLhel3W6vHrzABtmG0V/E
         fxc17DRmG9WwV/GvtyoREU9fdFsHKKN3H74261wJdjxLHGWBAFKybAWGYV6EIRcS9GjW
         EbZYdaD23BjSgX62oXzzjdv1B7txLcEkAH/z6uZKut9j3oxau2TeY/mOhcWioJ0mTGH+
         /PM9sZITO38wBoMsv0FSWRPu0UMECcywQBakA0ZClU3lq6am1OQvfZURr/+Hj6w3VS+N
         RBHsO8Rnn9ub7/c1xxPl3Gi2lGss+7CAKcZ2gwV1kDBx0Kv6sqxrwZL64wKhRt2jkD4y
         T1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772736479; x=1773341279;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QV/RGhC5ykvK6YPWqOsNlLac8i7Qu2T2qGRoYkOZpGg=;
        b=hoGZytFSR8feCW9Ju4EqpnSxq1prm/B9TJy5ZD+wmYtmXFMc7C+D0yj9HM3JEQSca2
         wwyFaS0lp2nIKeHjceknWXm6DDrDwIsr/KlbQO2hBFHsFWWV0pHIFlouJ4otzDPC/4O9
         r26T01gqjflBhvh73oq3h3vE0/5sl8mnZS3RaRebeIW+greFkN64vCIZw762//0amdcF
         GqAQ6ffu4idO9z0MSJ/SW0F9yTXUimL8mzqlUOGRw1BqacOloclHQNGnzMonw04QKbje
         mY/x/gsySXR0/8DqbxHu6a+8qcJQSyVMwhKgMPKcjS0y9MVR5ty6lJQUP0882drEW441
         pHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm0oweUkjvkvifRjtCPz5lAtlI1YeK1R1qPmMujafnvgwpV3FxJw4KrMzPCQgL3QUECW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXe33RoZHUPsrvW/cxwWNzgC3h2G4OSPb4HB7RVqwr0v0VMEC
	3MnbHmJ5QfYcHAhUx/fgcmW3qAizt8x0Rj9Ec9Eg8mxTUcI2rEZnSUG1I59cUw==
X-Gm-Gg: ATEYQzwcDjuWgN3bEtHJgzfqnnkf5tFjznZzW/mfvqPvGtFf1nLdLIjiDS/SvhmR+Rz
	VIDQHC5W+qqo2wCDn+nfdVNrGDr+yETH3ygQ15+eH4lu+DtXIC4lJ5IVasgFNDGzTqav6sO3oBr
	rr3hKj4nVpAhcskMBroAMp6mQQsaFGrq3CMyem/PrJDoyi4TyhakzXHdKXqCkG3E7w5KtMn8wHc
	hewT/5UeZgJzFI6xZEsGYL5AAOVYJsdiDyZRJ8mBHt857RYtvRfqsQPN/olH0N3t/9cf365+7ZQ
	4B1Uwr2u8J2nrZ9ofamxS/dNJCV2tdpJOCJZ8UNm3HocLcKwDBQIvo/ZuR+0MUZKqSCDOfu6Pky
	v4pzp+5WeXP0x9miQEaQjWPyjzYB1t8UfOKZUlPU3VczGo8U9IFlhQHlQWe5iF+qfcCYctorstz
	rVyaz6Ls/YYiqrFAAjj6tDdM2Na1q76CVQwfjPUw==
X-Received: by 2002:a05:600c:4e0b:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-4851982e869mr126545445e9.9.1772736478879;
        Thu, 05 Mar 2026 10:47:58 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fadeb5bsm79625085e9.5.2026.03.05.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:47:58 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf 2/3] bpf: switch task_vma iterator from mmap_lock to
 per-VMA locks
In-Reply-To: <20260304142026.1443666-3-puranjay@kernel.org>
References: <20260304142026.1443666-1-puranjay@kernel.org>
 <20260304142026.1443666-3-puranjay@kernel.org>
Date: Thu, 05 Mar 2026 18:47:58 +0000
Message-ID: <87jyvqxgdd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> The open-coded task_vma BPF iterator holds mmap_lock for the entire
> duration of the iteration, increasing contention on this highly
> contended lock.
>
> Switch to per-VMA locking. In _next(), the next VMA is found via an
> RCU-protected maple tree walk, then locked with lock_vma_under_rcu()
> at its vm_start address. lock_next_vma() is not used because its
> fallback path takes mmap_read_lock(), and the iterator must work in
> non-sleepable contexts.
>
> Between the RCU walk and the lock attempt, the VMA may be removed,
> shrunk, or write-locked. When lock_vma_under_rcu() fails or the locked
> VMA was modified, the iterator advances past it and retries using vm_end
> saved from the RCU walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU,
> individual objects can be freed and immediately reused within an RCU
> critical section. A VMA found by the maple tree walk may be recycled for
> a different mm before its fields are read, making the captured vm_end
> stale. When vm_end is stale and no longer ahead of the iteration
> position, the iterator falls back to PAGE_SIZE advancement to guarantee
> forward progress. VMAs inserted in gaps between iterations cannot be
> detected without mmap_lock speculation.
>
> The mm_struct is kept alive with mmget()/bpf_iter_mmput(). The
> bpf_mmap_unlock_get_irq_work() check is no longer needed since
> mmap_lock is no longer held; bpf_iter_mmput_busy() remains to guard the
> mmput irq_work slot. CONFIG_PER_VMA_LOCK is required; -EOPNOTSUPP is
> returned without it.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 72 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index d3fa8ba0a896..ff29d4da0267 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -9,6 +9,7 @@
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/btf_ids.h>
>  #include <linux/mm_types.h>
> +#include <linux/mmap_lock.h>
>  #include "mmap_unlock_work.h"
>  
>  static const char * const iter_task_type_names[] = {
> @@ -797,8 +798,8 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>  struct bpf_iter_task_vma_kern_data {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> -	struct mmap_unlock_irq_work *work;
> -	struct vma_iterator vmi;
> +	struct vm_area_struct *locked_vma;
> +	u64 last_addr;
>  };
>  
>  struct bpf_iter_task_vma {
> @@ -868,12 +869,16 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  				      struct task_struct *task, u64 addr)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
> -	bool irq_work_busy = false;
>  	int err;
>  
>  	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
>  	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
>  
> +	if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
> +		kit->data = NULL;
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* is_iter_reg_valid_uninit guarantees that kit hasn't been initialized
>  	 * before, so non-NULL kit->data doesn't point to previously
>  	 * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> @@ -890,13 +895,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  	}
>  
>  	/*
> -	 * Check irq_work availability for both mmap_lock release and mmput.
> -	 * Both use separate per-CPU irq_work slots, and both must be free
> -	 * to guarantee _destroy() can complete from NMI context.
> -	 * kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work
> +	 * Ensure the mmput irq_work slot is available so _destroy() can
> +	 * safely drop the mm reference from NMI context.
>  	 */
> -	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
> -	if (irq_work_busy || bpf_iter_mmput_busy()) {
> +	if (bpf_iter_mmput_busy()) {
>  		err = -EBUSY;
>  		goto err_cleanup_iter;
>  	}
> @@ -906,16 +908,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  		goto err_cleanup_iter;
>  	}
>  
> -	if (!mmap_read_trylock(kit->data->mm)) {
> -		err = -EBUSY;
> -		goto err_cleanup_mmget;
> -	}
> -
> -	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> +	kit->data->locked_vma = NULL;
> +	kit->data->last_addr = addr;
>  	return 0;
>  
> -err_cleanup_mmget:
> -	bpf_iter_mmput(kit->data->mm);
>  err_cleanup_iter:
>  	put_task_struct(kit->data->task);
>  	bpf_mem_free(&bpf_global_ma, kit->data);
> @@ -927,10 +923,47 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> +	unsigned long next_addr, next_end;
>  
>  	if (!kit->data) /* bpf_iter_task_vma_new failed */
>  		return NULL;
> -	return vma_next(&kit->data->vmi);
> +
> +	if (kit->data->locked_vma)
> +		vma_end_read(kit->data->locked_vma);
> +
> +retry:
> +	rcu_read_lock();
> +	vma_iter_init(&vmi, kit->data->mm, kit->data->last_addr);
> +	vma = vma_next(&vmi);
> +	if (!vma) {
> +		rcu_read_unlock();
> +		kit->data->locked_vma = NULL;
> +		return NULL;
> +	}
> +	next_addr = vma->vm_start;
> +	next_end = vma->vm_end;
> +	rcu_read_unlock();
> +
> +	vma = lock_vma_under_rcu(kit->data->mm, next_addr);
> +	if (!vma) {
> +		if (next_end > kit->data->last_addr)
> +			kit->data->last_addr = next_end;
> +		else
> +			kit->data->last_addr += PAGE_SIZE;
> +		goto retry;
> +	}
> +
> +	if (unlikely(kit->data->last_addr >= vma->vm_end)) {
> +		kit->data->last_addr = vma->vm_end;
> +		vma_end_read(vma);
> +		goto retry;
> +	}
nit: maybe we can move this next vma lookup (retry block) to the
separate function, this code looks a bit intimidating in _vma_next().
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> +
> +	kit->data->locked_vma = vma;
> +	kit->data->last_addr = vma->vm_end;
> +	return vma;
>  }
>  
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -938,7 +971,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
>  
>  	if (kit->data) {
> -		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> +		if (kit->data->locked_vma)
> +			vma_end_read(kit->data->locked_vma);
>  		bpf_iter_mmput(kit->data->mm);
>  		put_task_struct(kit->data->task);
>  		bpf_mem_free(&bpf_global_ma, kit->data);
> -- 
> 2.47.3
