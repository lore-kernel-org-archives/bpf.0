Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341239E6F5
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273202; cv=none; b=K4s4D04X1tea1GaahIiz5Qf6jVmGTr9lGplg+Qkc+rWbGIwMA8WvdAoEp62dLNyt7KEo3uFXDMUOkslzry6f325S6ytXciWQA7nfILBF7gac5BVnKV9inAL6KnNU+0HHf8sfVeGVbSKa5PcHoMAllXT/PySYHIKihUkouxVfVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273202; c=relaxed/simple;
	bh=ojWOweE3eLyWXbtBfpAKq63uVR22MOGtRVEIgETb7YM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sqaSvzy7t3/rVrgVcrkJtizUaXYjIkfqiXnx0hHBJpEhFuVHI6EMAnv9O5H+TRKrAxZItd1T4S1MATm+RutduyV4hon83XbPFa6XcFB7oiLZd9IHm6GRQO6sNdbYf9pYoj1WyTevxg/kjXN0MdeqibF3LUk7cUUx108oZTNnHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EivuL5HA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EivuL5HA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0E0C4CEF7;
	Wed, 11 Mar 2026 23:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773273202;
	bh=ojWOweE3eLyWXbtBfpAKq63uVR22MOGtRVEIgETb7YM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EivuL5HAMwP2TOQ3uK2I0flhH6iI33G3M4uaTggE8sKdfGXi2isvzxXlkefm6+9J3
	 ilWvosYywpKZg5qD4MJnizsbT+0ghPlMDPUsAiTse3S60TzMlwAzFZmlAEFyVHpZc1
	 cw/pgZlVnEwFELQOS0KDMNTAC8EhJrPhiKSD/BEdY6WLrC/IXLLVvJvvazdrR2a9zu
	 k1zZOT0wACXfF98IonCVukqu9rtOY1cpkcKA5rpQdnAYbASsyLbA9wzMl4q8RVn5Wo
	 WEdSmZC2qG2P2FwLR6yaY+ZefxVKKmBuxxSjZXlaxt1PrSY+elWVLYB8CokEupudw1
	 /0n8X8V73/Nug==
Content-Type: multipart/mixed; boundary="===============1099468717710390570=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <480892a72caa391641ec52a010730d213241830683280a0583cfc334d8f39325@mail.kernel.org>
In-Reply-To: <20260311225726.808332-3-puranjay@kernel.org>
References: <20260311225726.808332-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf v3 2/3] bpf: switch task_vma iterator from mmap_lock to per-VMA locks
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Mar 2026 23:53:21 +0000 (UTC)

--===============1099468717710390570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 2ccdc3228063..50dbeaeafd86 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> +__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
> +{
> +	struct bpf_iter_task_vma_kern *kit = (void *)it;
> +	struct vm_area_struct *vma;
> +
> +	if (!kit->data) /* bpf_iter_task_vma_new failed */
> +		return NULL;
> +
> +	if (kit->data->locked_vma) {
> +		vma_end_read(kit->data->locked_vma);
> +		kit->data->locked_vma = NULL;
> +	}

[ ... ]

>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
>
>  	if (kit->data) {
> -		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> +		if (kit->data->locked_vma)
> +			vma_end_read(kit->data->locked_vma);
>  		put_task_struct(kit->data->task);
>  		/*
>  		 * mmput_async() -> schedule_work() -> __queue_work()
>  		 * takes pool->lock. BPF programs on traceable functions
>  		 * or tracepoints called under pool->lock, or programs
>  		 * running in NMI, can reach here and try to re-acquire
>  		 * pool->lock, causing a deadlock. queue_work() disables
>  		 * IRQs before taking pool->lock, so irqs_disabled()
>  		 * detects both cases.
>  		 */

Is vma_end_read() safe to call from NMI context here?

The comment above notes that BPF programs running in NMI can reach
this code. The old code deferred the mmap_lock release via irq_work
when irqs_disabled() to avoid exactly this class of problem.

vma_end_read() calls vma_refcount_put(), which can call
rcuwait_wake_up() when a VMA writer is waiting:

  vma_end_read()
    vma_refcount_put()
      rcuwait_wake_up(&mm->vma_writer_wait)
        wake_up_process(task)
          raw_spin_lock_irqsave(&p->pi_lock, ...)

If an NMI fires while the interrupted context holds pi_lock or
rq->__lock, this path deadlocks. The same concern applies to the
vma_end_read() calls in bpf_iter_task_vma_next() and
bpf_iter_task_vma_find_next().

The task_vma iterator kfuncs are in common_btf_ids registered for
BPF_PROG_TYPE_UNSPEC, so perf event programs running in NMI context
can use them.

>  		if (!irqs_disabled()) {
>  			mmput_async(kit->data->mm);
>  			bpf_mem_free(&bpf_global_ma, kit->data);
>  		} else {
>  			irq_work_queue(&kit->data->irq_work);
>  		}
>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22978681697
--===============1099468717710390570==--
