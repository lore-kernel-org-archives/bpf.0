Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40273E4510
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984429; cv=none; b=TbS7+hhCIo6B+fAYIEDA4eXOULrjrNRW25T8FjbuG8LNnv/LWF3Pg0/Y6Lna2Nit5jrmDff5ddDG9zWt9jnNx0GHMFpVypd0RMhs6hrEBG2ooE1X43pPAHcdb20RWprnaw+BcLTv5jmNKdjoSQCKdW4AeKoWjEKw/7Ed9wJxOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984429; c=relaxed/simple;
	bh=OiDfq17QAZlSyhJb6xUWTPzHFTNiVBbD2d9LR/t1Ipc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNdE3pASGL6X1xDMixMsdgcGdDuevwkp4t85hKrMWjKM3NuGMZdGlQEdhewPr82/YSFg/e2zwco3bG+0XA0MKpnaVGTLiz/NYgAbRY74XeMme1i+mYyna6/4DVYR45g0WqphqXU1OVbBa272JV1nefI1ui9HFfqGmQRAb2yAkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PCRRj0kW; arc=none smtp.client-ip=91.218.175.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PCRRj0kW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OiDfq17QAZlSyhJb6xUWTPzHFTNiVBbD2d9LR/t1Ipc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788984424; v=1; x=1789589224;
 b=PCRRj0kWKKwpfIqAaP/+SG1CoXIuaUgKbVCd1lRHj73sXblIwBE157D2INvF3Ju1BzVjWhvt
 Eo5A/s3fQ0LCczJrksv3JEUsx6fWX+4nUcfHCz/26RpZXitiZ+7MRCm5mpzM1SzB+EIfMUb4i1y
 bsCEOuQwZ1sLa/GH+6tCsqss=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 04bb54aa1bc2000a;
	Wed, 09 Sep 2026 20:07:04 +0000
X-Mizu-Trace-ID: 04bb54aa1bc2000a
X-Migadu-Flow: FLOW_OUT
Message-ID: <d8d4de31-79ee-425f-8759-92a1ebfa9d0a@linux.dev>
Date: Wed, 9 Sep 2026 13:06:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: Hui Zhu <hui.zhu@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Geliang Tang <geliang@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1788857915.git.zhuhui@kylinos.cn>
 <06452a0d7722c92a38fdfd117954d244c3e52d0e.1788857915.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: JP Kobryn <jp.kobryn@linux.dev>
In-Reply-To: <06452a0d7722c92a38fdfd117954d244c3e52d0e.1788857915.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 2:11 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> BPF programs can observe memory pressure on a cgroup (e.g. refault
> stats via bpf_mem_cgroup_page_state()), but cannot act on it:
> triggering reclaim on a chosen cgroup requires writing to
> memory.reclaim, which BPF cannot do. Add bpf_proactive_reclaim(),
> a sleepable kfunc which performs one proactive reclaim pass on a
> given memory cgroup, similar to a write to memory.reclaim but
> without retrying until the target is reached, so that when and how
> hard to reclaim is BPF policy rather than hard-coded thresholds.
> 
> Since some bpf program types may be invoked while holding fs locks,
> limit the kfunc to BPF_PROG_TYPE_SYSCALL only, to avoid deadlocking
> in filesystem shrinkers on the reclaim path. A SYSCALL program can
> invoke the kfunc directly, or asynchronously from its bpf_wq or
> task_work callbacks, which run in process context and keep the> SYSCALL program type.
> 
> The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> following the precedent of high_work_func(), the memory.high
> workqueue fallback, which bounds each reclaim request the same way
> and uses one work item per memcg. 

You can end the sentence here at "fallback" and remove the rest.

> Note that only the reclaim target
> is capped: the actual scanning work and its duration are not
> bounded. Reclaiming more than one batch is left to the BPF program
> rather than enforced by the kfunc: with one call per bpf_wq callback
> and the same work item requeued for the next batch, the program can
> also stop submitting batches in between, e.g. once the target cgroup
> is dying.>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   mm/bpf_memcontrol.c | 88 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..2817c6db9a5d 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -6,8 +6,11 @@
>    */
>   
>   #include <linux/memcontrol.h>
> +#include <linux/swap.h>

You can drop this since internal.h below pulls it in.

>   #include <linux/bpf.h>
>   
> +#include "internal.h"
> +
>   __bpf_kfunc_start_defs();
>   
>   /**
> @@ -159,6 +162,73 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>   	mem_cgroup_flush_stats(memcg);
>   }
>   
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes, clamped to
> + *         MEMCG_CHARGE_BATCH (64 pages)
> + * @swappiness: the reclaim swappiness, in the range [0, 201] where 201

It's awkward to point users to a numeric range and one magic number.
What if you changed the associated macros to an enum:

enum {
   MIN_SWAPPINESS = 0,
   MAX_SWAPPINESS = 200,
   SWAPPINESS_ANON_ONLY = MAX_SWAPPINESS + 1,
};

Then these would be available in vmlinux.h and you could name them in
the comment above.

> + *         means anon-only reclaim; a negative value means the memcg's
> + *         own swappiness is used

You reject anything less than -1 below. This should say "-1" instead of
"a negative value".

> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * memory.reclaim, but without retrying until @size is reached.
> + *
> + * Only the reclaim target is capped: @size is clamped to
> + * MEMCG_CHARGE_BATCH, following the precedent of high_work_func(),
> + * the memory.high workqueue fallback, which bounds each reclaim
> + * request the same way. The actual scanning work and its duration
> + * are not bounded. To reclaim more, call this kfunc repeatedly
> + * instead of passing a larger @size.
> + *
> + * The kfunc can be called directly from a BPF_PROG_TYPE_SYSCALL
> + * program, synchronously in the context of the thread running the
> + * program, or from the bpf_wq and task_work callbacks of a SYSCALL
> + * program, which run in process context and keep the SYSCALL program
> + * type. It is registered for BPF_PROG_TYPE_SYSCALL only, because
> + * generic sleepable programs may run with filesystem locks held or
> + * in NOFS/NOIO contexts, where the reclaim path could deadlock on
> + * those locks via filesystem shrinkers.
> + *
> + * For asynchronous reclaim of more than one batch, driving the
> + * reclaim from a bpf_wq callback is recommended: call this kfunc
> + * once per callback and requeue the same work item for the next
> + * batch, instead of looping inside the callback and monopolizing a
> + * workqueue worker, and give each target memcg its own work item,
> + * as high_work_func() does with one work item per memcg. Whether
> + * to submit the next batch is up to the BPF program, which can stop
> + * at any point, e.g. once the target cgroup is dying.
> + *
> + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
> + * smaller than a page, or (unsigned long)-1 if @swappiness is out of
> + * range.
> + */
> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +						unsigned long size,
> +						int swappiness)
> +{
> +	unsigned long nr_reclaimed;
> +	unsigned long nr_pages;
> +
> +	if (swappiness < -1 || swappiness > SWAPPINESS_ANON_ONLY)
> +		return (unsigned long)-1;
> +
> +	if (size < PAGE_SIZE)
> +		return 0;
> +
> +	nr_pages = min(size / PAGE_SIZE, (unsigned long)MEMCG_CHARGE_BATCH);
> +
> +	nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages,
> +						    GFP_KERNEL,
> +						    MEMCG_RECLAIM_MAY_SWAP |
> +						    MEMCG_RECLAIM_PROACTIVE,
> +						    swappiness < 0 ? NULL :
> +								     &swappiness);

It would read more consistently if it was "swappiness == -1" here, since
you reject less than -1 early on.

> +
> +	return nr_reclaimed * PAGE_SIZE;
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> @@ -174,19 +244,35 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
>   
>   BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
>   
> +BTF_KFUNCS_START(bpf_memcontrol_reclaim_kfuncs)
> +BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_memcontrol_reclaim_kfuncs)
> +
>   static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
>   	.owner          = THIS_MODULE,
>   	.set            = &bpf_memcontrol_kfuncs,
>   };
>   
> +static const struct btf_kfunc_id_set bpf_memcontrol_reclaim_kfunc_set = {
> +	.owner          = THIS_MODULE,
> +	.set            = &bpf_memcontrol_reclaim_kfuncs,
> +};
> +
>   static int __init bpf_memcontrol_init(void)
>   {
>   	int err;
>   
>   	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
>   					&bpf_memcontrol_kfunc_set);
> -	if (err)
> +	if (err) {
>   		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
> +		return err;
> +	}
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&bpf_memcontrol_reclaim_kfunc_set);
> +	if (err)
> +		pr_warn("error registering bpf reclaim kfuncs: %d", err);
>   
>   	return err;
>   }

