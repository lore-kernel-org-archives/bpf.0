Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BC35979
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736841; cv=none; b=GJKkFMVP0uVUkBS3IwfX5gZPQs2Zsl0ZapXBbV6IFWjxuQbDMxOUCqIDUHi7pwPxJBkD5j4tZjzE0aj+AO0yQ4piWmKRjSrWl7LlxvrD0izvorsHzVG8SqP+Upx0g7X5OK+BULou0u+C0jLrHYElAJTj6PoL4TeIj5JqjASTVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736841; c=relaxed/simple;
	bh=hFbtEvLI1Rdt3r9sECOtUwZqHnkp8YHNelsoHZzwGCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k3sQZuqwFf+qJ4KcB54AJl7Ry/mw2SF4+Ci58rfu/zrJ+VvDhgIx3G0hI5zWStEK0yBZSDg7EUdo8yVPXnd05Ce+2Ckxn+ekJA+23Cq/KU/s/gl4NN0jXhaMCqnjggKfxusxnn/ZpzF1efcrh2oc9DcZSf2T/7bCGPxh2ugS3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q88Oneog; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q88Oneog"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b790af67so2946232f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772736838; x=1773341638; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sf2pBEvQGMi+yoH9+uX3xZtGk5dwcktzreSB/ICSHE=;
        b=Q88OneogpDQb2JOb2cb27lk9hyhnMzmUlbS8iVbJLjLzU8+adAzMUKY86eI1jpDzk1
         WRnucf/SxhLSJnefWHLLfw9ZFy94ITeGkaq6dAUdwho9RRpfbqC8aPkxX4GlGiG1X7Rg
         7e4Qvsb8alnwtPcEMq9XiwS+laedD2WKaBa/lfliJv1xXvwQG2+dk/43+3EQfIoFz0YF
         WG2M577cPS08I3FWR4rERA+72HdLRXzs7tbB+XUkF5qyp1CTvH2cLnBDohWu43aMvNaZ
         5wILCz6cIMOaMp7x7Y07R+4ELFn9X/0jBHlA9nqagdnuYO38/YUWbJi57PP9GVoOT8ZH
         U8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772736838; x=1773341638;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sf2pBEvQGMi+yoH9+uX3xZtGk5dwcktzreSB/ICSHE=;
        b=JK/mASkipnW6apZnIvxLkelnMtTUdIJgzx9O6B5w2dwJ9qho0rMzhIpxNnBme92Gl5
         Hmhln4uH0tRjXvtBF9OAJDU8gGKPI2mh1tg6Wn1nIUlD4YtGelbilzDQtusb7XY+GlFU
         Vcb2hKr0qqD4AkIIw3DniLPWzjd6uAYACDWolFR3sxv55wSmppXtM3038WNBYHtULd2M
         XlTWAtyi2HZjb82ZLdRjAM1Nz5ReK0YeU6K7JT4JnWblwDqby9Di3nYSaTpc6Mq0DrJe
         4OCbbuuaTSzOghiljDprNYQLjiF1j6lrg86xsZmF2tVB31zZ4GaLTWYaSa3et3hfKpED
         hv+g==
X-Forwarded-Encrypted: i=1; AJvYcCWwTJe92CZTKCOtIAREHjyiSn0FERqXAZ8viy8Sc6StV/Mm9kpCOO+NlCce3QEBmWnOfHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/2svJyIYeccnfigNJJ+9kCw+lLoLLThCQdGA5w1LYbpdcUA8
	wrB8mB1EFESrMmQvJu3KHns4ObDFCs7RQhUl68g/8pg1tlSHZOP41slk
X-Gm-Gg: ATEYQzwT+RkW7fEsP/89DbZTKUiccf4v67xRyMRNXR6Td/MjALeBFj1k87EjxweG3nU
	SsPXEAjvV1FCdfDjolTQqDaojcWi+fiXGWH9NfR6huMavZq3vU0N9kFA+XU3OXpxJe74X2cZwxS
	dhiyXuyL+AlMZm4l0W813sR9rL6waWEclxIUMO2nVj8JIKllmRbwxqSd3jRXT+jWhWhyRSDqtVU
	CF249avRoyYAyP0bzwxhR8azMS+uG8Sr8qrrbaSQG4adPh5WgMUPOIw+uT6jbRkeH1NJCJGMj79
	73escHYz+VAhMNx2Cte9P4SZD1mI13D8UnXieEdctQXD/iMhir8TpHFshRPtsr90nilhq4W77un
	mVLZdoxKUzOjO4Yytt7JhRQbfQIRcAA/588WILGQo5ZdgvSnPm2271c4vH6FsfOxIu38H65+lYu
	Mf1BDkwH//kY1c+FigKjR3x0oZLmenGDmHKLaV6ybJIOCrsJRd
X-Received: by 2002:a05:6000:2c0a:b0:439:c24b:ec27 with SMTP id ffacd0b85a97d-439cfc2c20fmr6188099f8f.10.1772736838254;
        Thu, 05 Mar 2026 10:53:58 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b6d540b2sm32609242f8f.36.2026.03.05.10.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:53:57 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf 3/3] bpf: return VMA snapshot from task_vma iterator
In-Reply-To: <20260304142026.1443666-4-puranjay@kernel.org>
References: <20260304142026.1443666-1-puranjay@kernel.org>
 <20260304142026.1443666-4-puranjay@kernel.org>
Date: Thu, 05 Mar 2026 18:53:57 +0000
Message-ID: <87h5quxg3e.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> Holding the per-VMA lock across the BPF program's loop body creates a
> lock ordering problem when helpers acquire locks with a dependency on
> mmap_lock (e.g., bpf_dynptr_read -> __kernel_read -> i_rwsem):
>
>   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
>
> Snapshot VMA fields into an embedded struct vm_area_struct under the
> per-VMA lock in _next(), then drop the lock before returning. The BPF
> program accesses only the snapshot, so no lock is held during execution.
> For vm_file, get_file() takes a reference under the lock, released via
> fput() on the next iteration or in _destroy(). The snapshot's vm_file is
> set to NULL after fput() so _destroy() does not double-release the
> reference when _next() has already dropped it. For vm_mm, the snapshot
> uses the mm pointer held via mmget().
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index ff29d4da0267..4bf93cff69c7 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -798,7 +798,7 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>  struct bpf_iter_task_vma_kern_data {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> -	struct vm_area_struct *locked_vma;
> +	struct vm_area_struct snapshot;
>  	u64 last_addr;
>  };
>  
> @@ -908,8 +908,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  		goto err_cleanup_iter;
>  	}
>  
> -	kit->data->locked_vma = NULL;
>  	kit->data->last_addr = addr;
> +	memset(&kit->data->snapshot, 0, sizeof(kit->data->snapshot));
>  	return 0;
>  
>  err_cleanup_iter:
> @@ -923,15 +923,19 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
> -	struct vm_area_struct *vma;
> +	struct vm_area_struct *snap, *vma;
>  	struct vma_iterator vmi;
>  	unsigned long next_addr, next_end;
>  
>  	if (!kit->data) /* bpf_iter_task_vma_new failed */
>  		return NULL;
>  
> -	if (kit->data->locked_vma)
> -		vma_end_read(kit->data->locked_vma);
> +	snap = &kit->data->snapshot;
> +
> +	if (snap->vm_file) {
> +		fput(snap->vm_file);
> +		snap->vm_file = NULL;
> +	}
>  
>  retry:
>  	rcu_read_lock();
> @@ -939,7 +943,6 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_v
>  	vma = vma_next(&vmi);
>  	if (!vma) {
>  		rcu_read_unlock();
> -		kit->data->locked_vma = NULL;
>  		return NULL;
>  	}
>  	next_addr = vma->vm_start;
> @@ -961,9 +964,17 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_v
>  		goto retry;
>  	}
>  
> -	kit->data->locked_vma = vma;
> +	snap->vm_start = vma->vm_start;
> +	snap->vm_end = vma->vm_end;
> +	snap->vm_mm = kit->data->mm;
> +	snap->vm_page_prot = vma->vm_page_prot;
> +	snap->flags = vma->flags;
> +	snap->vm_pgoff = vma->vm_pgoff;
> +	snap->vm_file = vma->vm_file ? get_file(vma->vm_file) : NULL;
Are you omitting some fields when copying to snapshot? How do
you decide what fields are needed and what not? If your intention is
to copy everything and bump refcnt for file, why not memcpy() +
get_file(vma->vm_file)?
> +
>  	kit->data->last_addr = vma->vm_end;
> -	return vma;
> +	vma_end_read(vma);
> +	return snap;
>  }
>  
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -971,8 +982,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
>  
>  	if (kit->data) {
> -		if (kit->data->locked_vma)
> -			vma_end_read(kit->data->locked_vma);
> +		if (kit->data->snapshot.vm_file)
> +			fput(kit->data->snapshot.vm_file);
>  		bpf_iter_mmput(kit->data->mm);
>  		put_task_struct(kit->data->task);
>  		bpf_mem_free(&bpf_global_ma, kit->data);
> -- 
> 2.47.3
