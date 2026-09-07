Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819E3E3DAB
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807081; cv=none; b=b372DzIVCAQVdj3NjKwrlgZRkNaDoPpBXZIalhg8IqDXhMQ8Vl1qWDwiEbkFGJ9DdqLBNh+nmkzfeQS4k/+56fre892FUlheh9PutCPZI0R9PI+ghIoK23oBWxGXEK+FUwQrbvn5Ov0YoSysyKLcyN8jHk1No1IpDxVHXOb175c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807081; c=relaxed/simple;
	bh=NddO47tYxBI2h7DsCq/hs4VZYoZz/R9enIlpJ3TUNlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fd7U39Cv686fZAg/YW3aeORMBzweeWsNhXpnbwy6QCCUmY1myb/Bk05OTmLkBCJ4p4aSwWxHgNquSdEtkpgPyMg28j/hQA5aGe4zwWhbmi3gbvMwCMeQk/WgG9lqqgl+Bb2S89YIL7QE+NqfgAEhHe5umm8r4aKJlZysoV4tKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EcL5nzSM; arc=none smtp.client-ip=95.215.58.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EcL5nzSM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NddO47tYxBI2h7DsCq/hs4VZYoZz/R9enIlpJ3TUNlw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788807072; v=1; x=1789411872;
 b=EcL5nzSMc/vm/90o63vsPdZHGM3U7c9pGvBSvfZmIIpjN9vH34WFfRrRdNfk2xBuYWbQ6Ckr
 MeV4cOF0JgerKOzZLNevblkr8FTzqlzYmcJ1cbCFhA3P5a037/TPsO5vBCLIsmzoNgzHzwMK6Lp
 mxU+qbAzF1dt6uO4RS6b8g68=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ed654492ec4f958;
	Mon, 07 Sep 2026 18:51:11 +0000
X-Mizu-Trace-ID: 0ed654492ec4f958
X-Migadu-Flow: FLOW_OUT
Message-ID: <6df0f368-0acb-49b4-8bf6-c82d3d2c79a1@linux.dev>
Date: Mon, 7 Sep 2026 11:51:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
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
References: <cover.1788764121.git.zhuhui@kylinos.cn>
 <0f1e2b5408aef7baaacf7306dff5f6d4fb91e441.1788764121.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: JP Kobryn <jp.kobryn@linux.dev>
In-Reply-To: <0f1e2b5408aef7baaacf7306dff5f6d4fb91e441.1788764121.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hui,

On 9/7/26 12:08 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Add bpf_proactive_reclaim(), a sleepable kfunc which performs one
> proactive reclaim pass on a given memory cgroup, similar to a write
> to memory.reclaim but without retrying until the target is reached.

The cover letter has the reasons why you're adding this kfunc. It should
be included before this paragraph.

> 
> The kfunc is restricted to BPF_PROG_TYPE_SYSCALL so that reclaim
> always runs in a clean process context. Generic sleepable programs
> may execute with filesystem locks held or in NOFS/NOIO contexts,
> where the reclaim path could deadlock in filesystem shrinkers. A
> SYSCALL program can still drive reclaim asynchronously through
> bpf_wq or task_work callbacks, which run in process context and
> keep the SYSCALL program type, so they can call the kfunc too.

I think this paragraph would read better if you inverted the decision
and rationale. Something like:

"Since some bpf program types may be invoked while holding fs locks,
limit the kfunc to only syscall progs to avoid..."

> 
> The reclaim target of a single call is clamped to MEMCG_CHARGE_BATCH.
> try_to_free_mem_cgroup_pages() takes nr_to_reclaim as a lower bound,
> so nothing else limits how long one call scans. An unbounded call
> stalls other work on a shared workqueue, and since lru_lock is held
> with interrupts disabled the contention delays IPI handling and can
> cause CSD lock stalls. MEMCG_CHARGE_BATCH is the bound already used
> by high_work_func(), so each call becomes a bounded unit of work.

It's not strictly speaking a bounded unit of work though. The scan work
time can vary.

The example of interrupt delay I gave on the prior rev is included here,
unnecessarily increasing the verbosity. I think you can just say that
you're following the precedent in high_work_func() which uses the same
cap, but I would still emphasize like I said above that the actual
scanning work is not bounded.

> 
> Reclaiming more than one batch is left to the BPF program. This is
> documented in the kfunc rather than enforced: call the kfunc once
> per bpf_wq callback and requeue the same work item for the next
> batch instead of looping inside a callback, and give each target
> memcg its own bpf_wq item. Keeping the policy in BPF lets a program
> decide when to reclaim and when to stop, e.g. once the target cgroup
> is dying.

You should be explicit on the different calling contexts. This is one
way to use it, but someone could still invoke it directly in the syscall
program.

> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   mm/bpf_memcontrol.c | 94 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..74ccac30c011 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -6,8 +6,11 @@
>    */
>   
>   #include <linux/memcontrol.h>
> +#include <linux/swap.h>
>   #include <linux/bpf.h>
>   
> +#include "internal.h"
> +
>   __bpf_kfunc_start_defs();
>   
>   /**
> @@ -159,6 +162,71 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
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
> + *         means anon-only reclaim; a negative value means the memcg's
> + *         own swappiness is used
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * memory.reclaim, but without retrying until @size is reached.
> + *
> + * @size is clamped so that one call is a bounded unit of work, matching
> + * the memory.high workqueue fallback in high_work_func(). To reclaim
> + * more, call this kfunc repeatedly instead of passing a larger @size.

Again I think "bounded unit of work" is too strong here. The reclaim
target is clamped but the scanning work/time will vary. Lets be explicit
that we're only capping the reclaim target.

> + *
> + * This kfunc is restricted to BPF_PROG_TYPE_SYSCALL to ensure it runs
> + * in a clean process context. The SYSCALL program can schedule the
> + * actual reclaim work via bpf_wq or timers, which also execute in
> + * safe process context (workqueue, task_work).

"clean" and "safe" are ambiguous here.

This is another example of mixing calling contexts. You should separate
them. i.e. can I call this directly in a syscall prog? does it have to
be async work? Also, as it reads, it makes it sound like calling the
kfunc is ok in a timer program.

> + *
> + * When reclaim is driven from a bpf_wq, call this kfunc once per
> + * callback and requeue the same work item for the next batch rather
> + * than looping inside the callback: a long-running callback stalls
> + * other work on the shared workqueue, and because lru_lock is held with
> + * interrupts disabled the resulting contention also delays IPI
> + * handling. Give each target memcg its own bpf_wq item, so that
> + * reclaiming one memcg neither serializes behind nor piles up on top of
> + * another. Deciding whether to submit the next batch is up to the BPF
> + * program, which can stop at any point, e.g. once the target cgroup is
> + * dying.

If this is the intended usage, be more explicit on the recommendation.
Reduce the verbosity on the interrupt delay here, similar to the advice
on the changelog.

> + *
> + * Must not be called with a filesystem lock held: the reclaim path
> + * may deadlock on it via filesystem shrinkers.

This should move to the syscall-only prog rationale. Otherwise, it reads
like something for callers to enforce.

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
> +
> +	return nr_reclaimed * PAGE_SIZE;
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> @@ -171,22 +239,44 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events)
>   BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>   BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>   BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
> -
>   BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
>   
> +/*
> + * Proactive reclaim needs a clean process context, so it is restricted
> + * to BPF_PROG_TYPE_SYSCALL. The bpf_wq and task_work callbacks that a
> + * SYSCALL program schedules run as the same program type, so they can
> + * still invoke it; generic sleepable programs (e.g. fentry on reclaim
> + * paths, inode_rmdir) cannot.

This comment feels out of place here and is not buying much at this
point. You already explained it in the kfunc comments, and the syscall
only registration further down is explicit enough by now.

> + */
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

