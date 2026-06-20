Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6639A05D
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972802; cv=none; b=ioM4WmuASAKbflxxVz9YKvngZWAxWsnS5SLhbZGTHB3aKQhDxC1q2lrieyQGNOKjs4JGl2hrFNL/Dg9cwMvp5yeSF6jw5htqdm7MP/imHE7zlUCYSOdgCf4jW99rUCr1SkKmnpPpY6ldKtp805N2eSC/1ARrcaPIxs/3sQjjQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972802; c=relaxed/simple;
	bh=DF90u4e1+dpko2c/CjJGfO5EQr9Qpjy8UClSSABTj0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ng8JrnE3LhHtm3guDrrykJVe+GPgNvlItt4cV0lhoYObmhGSYzlQk5IbMQ1i9wIyq4KZZsa1K3G8dolTv+CSF1o+ZrsfsFuSLc6Dw7wezFg1HO/ufOoRsYLToI1LUpFQ1xsNd8Cqu+4OsgwAAdoZDpzKif8QhGr75aUQ0urCXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a92iD/KC; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a92iD/KC"
Message-ID: <01d0ad15-679e-4730-949a-5eae77576cbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781972787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ncpi3o456X2WtqVxKxuQ+RzEqipdjCZmJTgS7yulqeg=;
	b=a92iD/KCu+yqsL1KbkjREWR/0WY2kGbhzvSSy+E7T8TTgKw8ywiCEMexhWUsHbaRSUZofT
	FAo8MVhWzi77nheWFEdtEGX+HPd0+oxBMBjp8erABs9U5GhDDxNiGwcruki/dzVLKRZqxC
	Pxr/eij9y5ckREHjiZHCIuri9fXEXPk=
Date: Sat, 20 Jun 2026 09:26:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
Content-Language: en-GB
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610024637.343364-1-sanghyun.park.cnu@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260610024637.343364-1-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/9/26 7:46 PM, Sanghyun Park wrote:
> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
> holding a reference on the mm. On a foreign task, a concurrent exit_mm()
> can free the mm_struct between the lockless read and the trylock,
> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
>
> For the current task, task->mm is stable. For a foreign task, pin the mm
> under task->alloc_lock and release it with mmput_async(), mirroring commit
> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
> Use spin_trylock() instead of get_task_mm() so BPF context does not block
> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> foreign-task path because dropping the mm reference is not safe there.
>
> Race:
>
>    CPU0 (BPF program)                  CPU1 (exiting task)
>    ============================        ==========================
>    bpf_find_vma(foreign_task):
>      mm = task->mm
>                                        exit_mm():
>                                          task->mm = NULL
>                                          mmput(mm) -> frees mm_struct
>      mmap_read_trylock(mm)
> 	// UAF on mm
>
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
> v4:
>   - Use [PATCH bpf-next] subject as requested by Alexei.
>   - Add the missing BPF maintainers/reviewers to Cc.
> v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.park.cnu@gmail.com/
>   - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
>     trylock + mmput_async(). (Yonghong Song)
>   - Reject irqs-disabled contexts on the foreign-task path.
>   - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async()
>     falls back to mmput() which may sleep, and bpf_find_vma() can run
>     in non-sleepable context.
>   - Shorten the foreign-task rationale comment and trim the changelog body.
>   - Fix the v2's whitespace damage.
> v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKOAa3_ZenPOFkA@mail.gmail.com/
>
>   kernel/bpf/task_iter.c | 50 +++++++++++++++++++++++++++++++++++-------
>   1 file changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index fc5f463ca5..baee813290 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -754,12 +754,22 @@ static struct bpf_iter_reg task_vma_reg_info = {
>   	.show_fdinfo		= bpf_iter_task_show_fdinfo,
>   };
>   
> +static inline void bpf_iter_mmput_async(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_MMU
> +	mmput_async(mm);
> +#else
> +	mmput(mm);
> +#endif
> +}
> +
>   BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>   	   bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
>   {
>   	struct mmap_unlock_irq_work *work = NULL;
>   	struct vm_area_struct *vma;
>   	bool irq_work_busy = false;
> +	bool mmput_needed = false;
>   	struct mm_struct *mm;
>   	int ret = -ENOENT;
>   
> @@ -769,14 +779,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>   	if (!task)
>   		return -ENOENT;
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
>   	if (!mm)
>   		return -ENOENT;
>   
>   	irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
>   
> -	if (irq_work_busy || !mmap_read_trylock(mm))
> -		return -EBUSY;
> +	if (irq_work_busy || !mmap_read_trylock(mm)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
>   
>   	vma = find_vma(mm, start);
>   
> @@ -786,6 +820,9 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>   		ret = 0;
>   	}
>   	bpf_mmap_unlock_mm(work, mm);
> +out:
> +	if (mmput_needed)
> +		bpf_iter_mmput_async(mm);

mmput_needed is true requiring CONFIG_MMU enabled, so the above
bpf_iter_mmput_async(mm) can be replaced with mmput_async(mm).
This will make code easier to understand.

>   	return ret;
>   }
>   
> @@ -800,15 +837,6 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>   	.arg5_type	= ARG_ANYTHING,
>   };
>   
> -static inline void bpf_iter_mmput_async(struct mm_struct *mm)
> -{
> -#ifdef CONFIG_MMU
> -	mmput_async(mm);
> -#else
> -	mmput(mm);
> -#endif
> -}
> -
>   struct bpf_iter_task_vma_kern_data {
>   	struct task_struct *task;
>   	struct mm_struct *mm;

