Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F0823DE;
	Wed, 10 Jun 2026 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061382; cv=none; b=FqJb+o48RHBpWC5alNqglDMoGchm5MdoqcZKHDgdeUpIDKjnTFStFh1r6M9OJPKRS0zw7yNseJmrDvbGm+eRzznSG0wMhyqHnr/fTETasqgyTyfTtqoNAzLz6NJ0S6jGXdPL3961U6DYrjhC+cg+wLVFGskk9Pwdnx4jRA3jcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061382; c=relaxed/simple;
	bh=r2mjX9Qde3TcVB6EdODD3vjSWowd16mTaZ/srUt0JiE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HfVwVLReAbqM25oHvR+AcI4oHDYq9J9tqBmd16TL/XY7rGFAHCOB4Z9Vycx8SZ/wXU4iN0DrF9mTrSq4owrWBWp3ERckX8GCG+AZettbE4UxFkIO7VCbk45TFJ8T/GiFN9ro1heXXOrgEDg2AfXkz/asC19n78C4PixnAjPf/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmnWQAFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmnWQAFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77171F00893;
	Wed, 10 Jun 2026 03:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781061381;
	bh=/2IkXVbGeTqGtaf4w/vx4QCWyCaN0wtxnmt7LDWWlo4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KmnWQAFAHFHm9evcZ04wpC+PgOKoCYsz2AOb7Ig7tiuMfDzlWuFumRgf8yif5Ggjg
	 OhoB+XV9RMt3mhncJ8RjZPFOwz9uriKSxA4qy2oHQAzuF+Z9cHLuwlJsXaUEeK98qa
	 5hFpYGYj3mcbL3dwKRCC7ZVWwb3Tcc0esHGfQLtMmehYrGDqyEjG1dyY8Vso3kay35
	 BadWh6kUWMQj8BW9k1fb9CTaReOHtk2L7Dx0pD/vYeiiqZ/udsLRWaiMA6/S+otjnd
	 7tKZFRV9IkRW1nktu2mmIbp0lORbAAUjlkPdUUYB1YNbad+srBw8jBvYpUyDjRS9jo
	 c8pCZCV7hSRfA==
Content-Type: multipart/mixed; boundary="===============2913729978520096314=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c66036b0e1528d69dc15e19faca58b8aa3453cac9d2554984b3130e96321b357@mail.kernel.org>
In-Reply-To: <20260610024637.343364-1-sanghyun.park.cnu@gmail.com>
References: <20260610024637.343364-1-sanghyun.park.cnu@gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
From: bot+bpf-ci@kernel.org
To: sanghyun.park.cnu@gmail.com,yonghong.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: sanghyun.park.cnu@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,memxor@gmail.com,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,emil@etsalapatis.com,puranjay@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 03:16:20 +0000 (UTC)

--===============2913729978520096314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e791ae065c39..77f90b887bf1 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> @@ -765,14 +775,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>  	if (!task)
>  		return -ENOENT;
>
> -	mm = task->mm;
> +	if (task == current) {
> +		mm = task->mm;
> +	} else {
> +		/*
> +		 * Foreign task: pin task->mm against a concurrent exit_mm().
> +		 * Use trylock on alloc_lock instead of get_task_mm()'s
> +		 * blocking task_lock() to avoid deadlocking the target task.
> +		 */
> +		if (!IS_ENABLED(CONFIG_MMU))
> +			return -EOPNOTSUPP;
> +		if (irqs_disabled())
> +			return -EBUSY;
> +		if (!spin_trylock(&task->alloc_lock))
> +			return -EBUSY;
> +		mm = task->mm;
> +		if (mm && !(task->flags & PF_KTHREAD)) {
> +			mmget(mm);
> +			mmput_needed = true;
> +		} else {
> +			mm = NULL;
> +		}
> +		spin_unlock(&task->alloc_lock);
> +	}
>  	if (!mm)
>  		return -ENOENT;
>
>  	irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
>
> -	if (irq_work_busy || !mmap_read_trylock(mm))
> -		return -EBUSY;
> +	if (irq_work_busy || !mmap_read_trylock(mm)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
>
>  	vma = find_vma(mm, start);
                         ^^^^^^^^

sashiko-bot@kernel.org raised a concern about this in v4: bpf_find_vma()
traverses the VMA tree of an external mm_struct (from a foreign task) without
checking check_stable_address_space(mm).

When inspecting a foreign task, the mm_struct could be flagged with
MMF_UNSTABLE if it was subject to an OOM reap or a dup_mmap() failure. In this
state, the maple tree can contain XA_ZERO_ENTRY markers.

If find_vma() returns one of these markers, could the subsequent check using
vma->vm_start dereference an internal integer value and cause a kernel panic?

>
> @@ -782,6 +816,9 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>  		ret = 0;
>  	}
>  	bpf_mmap_unlock_mm(work, mm);
> +out:
> +	if (mmput_needed)
> +		bpf_iter_mmput_async(mm);
>  	return ret;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27250036662
--===============2913729978520096314==--
