Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1A3CB8EF
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355470; cv=none; b=mY/1OrYVz3/8BSuo8WNp+1ar56AwuTO+doj6VcX82mo1YTs1A7M+P2WvaVEfDplbNqyxXo8M4qSEpSpfDhelQuqTqvL997ZibzX3VNuiSrvE99z7ZUy59vljxTAtNNY46HhsOyTQF/KJ32o9n90rA/vxPz6Etjrvt24XLonRF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355470; c=relaxed/simple;
	bh=xcgJpobxl9fexPuJs/nmoOiKoLq/2tfNYkhuc1SfB50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/NGBAdvGCvJfX+PQCjTa1bejszyMlukDTFKs9udjDGL6Wlm4sBZ9WB/PRRP+tjPxGOJblM/SwEl/vm1pSPHlN8Bs+IfLpM/1AHYFc+XjlWt7vL8E1Q+9WH6OMmAeBzalCrO6JVP1/Tr7/EwJlBUENYyHyrhvFhGumGCX6DW5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W6xO5ArS; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W6xO5ArS"
Message-ID: <33024de2-1121-4f08-a579-8a9ceeddf8bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785355466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6wLravY6J6SG9GUNdSjZv41Sf5l51UfdBksFCzhbkE=;
	b=W6xO5ArSSXba4wsbV1LOqy5Ep659Ih5j+xnDAc1BfnCZ1+7drnVuIP+m4HhmlpovcuujH1
	nQt+AutRJT8rz7n72Uyez2+xbrF0JbwJwIDBixpKksRx2BqGx1qntBZ1wfyvQj1ayveqeE
	K6A3Q/M/G57zgUkBlZkfw3+b+HpQv+w=
Date: Wed, 29 Jul 2026 13:03:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fix mmap_lock leak in irq_work path
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan
 <puranjay@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com, sashiko-bot@kernel.org
References: <20260722023004.1497923-2-sanghyun.park.cnu@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260722023004.1497923-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-07-21 7:30 p.m., Sanghyun Park wrote:
> stack_map_get_build_id_offset() introduced a per-CPU irq_work to defer
> mmap_read_unlock() from NMI context, and bpf_find_vma() later reused the
> same mmap_unlock_work. Both callers only check whether the work is busy
> before taking mmap_lock, so a nested caller can reuse the slot before the
> first caller queues it. Two read locks may then be acquired while only one
> deferred unlock runs, leaking a read lock and blocking exit_mmap().
> 
> Reserve the per-CPU slot before mmap_read_trylock(). Use the same wrapper
> in stackmap and bpf_find_vma() so both callers release the reservation on
> trylock failure. Release it after the irq_work callback unlocks the mm.

Hi Sanghyun,

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

The fix looks correct to me, thanks!
Just one non-blocking nit below.

> 
> Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")
> Reported-by: syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cdd6c0925e12b0af60cc
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/r/20260630033745.B80201F000E9@smtp.kernel.org
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
>   kernel/bpf/mmap_unlock_work.h | 37 +++++++++++++++++++++++++++++++----
>   kernel/bpf/stackmap.c         |  3 +--
>   kernel/bpf/task_iter.c        |  7 +++----
>   3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
> index 5d18d7d85bef9..d416e4337635f 100644
> --- a/kernel/bpf/mmap_unlock_work.h
> +++ b/kernel/bpf/mmap_unlock_work.h
> @@ -4,12 +4,14 @@
>   
>   #ifndef __MMAP_UNLOCK_WORK_H__
>   #define __MMAP_UNLOCK_WORK_H__
> +#include <linux/atomic.h>
>   #include <linux/irq_work.h>
>   
>   /* irq_work to run mmap_read_unlock() in irq_work */
>   struct mmap_unlock_irq_work {
>   	struct irq_work irq_work;
>   	struct mm_struct *mm;
> +	atomic_t active;
>   };
>   
>   DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
> @@ -18,8 +20,8 @@ DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>    * We cannot do mmap_read_unlock() when the irq is disabled, because of
>    * risk to deadlock with rq_lock. To look up vma when the irqs are
>    * disabled, we need to run mmap_read_unlock() in irq_work. We use a
> - * percpu variable to do the irq_work. If the irq_work is already used
> - * by another lookup, we fall over.
> + * percpu variable to do the irq_work. The active flag reserves the slot
> + * before mmap_read_trylock() and until the irq_work callback consumes mm.
>    */
>   static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **work_ptr)
>   {
> @@ -29,9 +31,10 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
>   	if (irqs_disabled()) {
>   		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>   			work = this_cpu_ptr(&mmap_unlock_work);
> -			if (irq_work_is_busy(&work->irq_work)) {
> -				/* cannot queue more up_read, fallback */
> +			if (irq_work_is_busy(&work->irq_work) ||
> +			    atomic_cmpxchg_acquire(&work->active, 0, 1)) {

It appears you could use the `active` guard exclusively to cover the
leak.

It is taken before the trylock and cleared only at the end of the
callback. So can irq_work_is_busy(&work->irq_work) be dropped here?


>   				irq_work_busy = true;
> +				work = NULL;
>   			}
>   		} else {
>   			/*
> [...]
