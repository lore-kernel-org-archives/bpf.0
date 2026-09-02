Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9D39FCC5
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332277; cv=none; b=qJvbuxcPhJ4MrLcMKf9dkT9NEKFArHTszQK/pRixCVJBUjyJIXU35JHpQ2Ki8G9eV0lDB3fPk6KOk88ee+gJgOI233WPUCJzFH4RiuL8TVJu2it5JwkCaf9dhVKGvJoDFb+xDkSJQ5l2ETikP7OqonIbYaeC4oAHrCdwPs6jK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332277; c=relaxed/simple;
	bh=dYnmVRgv/hTqXQbdZ6YIg65oaInMmkvygceKouO7NOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBuB/Dks8aLXjd6m2cU1j3UbyzAGdhaNY+LWn4Gbk3m/8QOFoSgHVV89HMjNhbViyqTk1DASaa3CE5tGgxdi473e3fb01CFxKu1JUOKA7CCDQek/G3dYbNR35uvwvZ4ZdWfnViFRn9yWURuOpXsLyvU0Jv/5ux+uU22/+WaVZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D0wlcP9p; arc=none smtp.client-ip=95.215.58.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D0wlcP9p"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dYnmVRgv/hTqXQbdZ6YIg65oaInMmkvygceKouO7NOk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788332269; v=1; x=1788937069;
 b=D0wlcP9ph+/u4QBChid0aJR9pjdX6OyQzuCC1kQjP66yKOJLEVwdAkq3ftwm3vIPvpWgOqhU
 cYxlFSKOuPeI/JJDiWwWqSShAlD2euWWEJepdgeq/unE06ojaJiGrjl/eu/1pK1SW9VIEo8jWeY
 dFhdZis6fbV2PDqBaszRPEjo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 15f431fa020b49d7;
	Wed, 02 Sep 2026 06:57:48 +0000
X-Mizu-Trace-ID: 15f431fa020b49d7
X-Migadu-Flow: FLOW_OUT
Message-ID: <9ff42a33-8ad2-40cd-a980-9fa87474e527@linux.dev>
Date: Wed, 2 Sep 2026 14:57:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH bpf-next v6 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: JP Kobryn <jp.kobryn@linux.dev>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
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
References: <cover.1788228773.git.zhuhui@kylinos.cn>
 <24726feaf836608d78986e2c565461cf809d8326.1788228773.git.zhuhui@kylinos.cn>
 <f9e77f14-a6a9-4cd3-a217-43abe4747275@linux.dev>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <f9e77f14-a6a9-4cd3-a217-43abe4747275@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi JP,

Thanks for the review!

> Hi Hui,
>
> On 8/31/26 7:21 PM, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> Add bpf_proactive_reclaim(), a sleepable kfunc which performs one
>> proactive reclaim pass on a given memory cgroup, similar to a write
>> to memory.reclaim but without retrying until the target is reached.
>>
>> The kfunc is restricted to BPF_PROG_TYPE_SYSCALL so that reclaim
>> always runs in a clean process context. Generic sleepable programs
>> may execute with filesystem locks held or in NOFS/NOIO contexts,
>> where the reclaim path could deadlock in filesystem shrinkers. A
>> SYSCALL program can still drive reclaim asynchronously through
>> bpf_wq or task_work callbacks, which run in process context and
>> keep the SYSCALL program type, so they can call the kfunc too.
>>
>> The kfunc refuses to reclaim if the calling task is already in a
>> reclaim context, as a nested reclaim would corrupt the outer reclaim
>> state.
>>
>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>> ---
>
> The difflog is missing in these patches.
Sorry, my mistake. Will add the changelog (changes since v4) in the
next version.
>
>>   mm/bpf_memcontrol.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 74 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index 716df49d7647..fd48faa5f8b0 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -6,6 +6,7 @@
>>    */
>>     #include <linux/memcontrol.h>
>> +#include <linux/swap.h>
>>   #include <linux/bpf.h>
>>     __bpf_kfunc_start_defs();
>> @@ -159,6 +160,55 @@ __bpf_kfunc void 
>> bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>>       mem_cgroup_flush_stats(memcg);
>>   }
>>   +/*
>> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
>> + * current->reclaim_state, so a nested call would corrupt the outer
>> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
>> + * reclaim_state is also checked because it is installed slightly
>> + * before PF_MEMALLOC.
>> + */
>> +static bool bpf_in_reclaim_context(void)
>> +{
>> +    return (current->flags & PF_MEMALLOC) || current->reclaim_state;
>> +}
>> +
>> +/**
>> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
>> + *                         cgroup
>> + * @memcg: the target memory cgroup to reclaim from
>> + * @size:  the amount of memory to reclaim, in bytes
>> + *
>> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
>> + * memory.reclaim, but without retrying until @size is reached.
>> + *
>> + * This kfunc is restricted to BPF_PROG_TYPE_SYSCALL to ensure it runs
>> + * in a clean process context. The SYSCALL program can schedule the
>> + * actual reclaim work via bpf_wq or timers, which also execute in
>> + * safe process context (workqueue, task_work).
>
> On the workqueue aspect, I could see potential issues. The target size
> has no upper bound so the total scan/execution time on the shared
> wq can easily stall other work. Contention on the lru_lock can make
> matters worse because interrupts are disabled while holding the lock. So
> the contention would not only stall other work, but can delay IPI
> handling leading to CSD lock stalls.


Agreed. I previously misread

     .nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX)

in try_to_free_mem_cgroup_pages() as an upper bound on the reclaim
target; it is actually a lower bound, so nothing inside the reclaim
path limits how long a single kfunc call can run. The next version
will cap the per-invocation reclaim target.


>
> It looks like the only existing path that explicitly calls
> try_to_free_mem_cgroup_pages() from a shared wq is the memory.high
> fallback used when the limit is exceeded outside of task context. But
> even in that case, it's more constrained. The reclaim request is bounded
> at MEMCG_CHARGE_BATCH (in high_work_func()) and is limited to one work
> item per memcg.
>
> Would it make sense to follow the existing precedent and use the same
> bound in your kfunc? You could then batch the wq submissions and you
> would also be able to stop submitting in between if needed, like in the
> case of the cgroup dying.
>
Yes, the next version will cap the reclaim target of a single
bpf_proactive_reclaim() call at MEMCG_CHARGE_BATCH, following the
high_work_func() precedent, so each invocation is a bounded unit of
work on the shared wq.

For the "one work item per memcg" side, I'd like to hear your
thoughts on the following approach: allow only one in-flight
bpf_proactive_reclaim() per memcg. The kfunc would take a per-memcg
flag (atomic cmpxchg) on entry and return 0 if another BPF reclaim
pass is already running on the same memcg, mirroring the
one-work-item-per-memcg property of high_work. This would prevent wq
work items from piling up reclaiming the same memcg.

The reason for doing this with a per-memcg in-flight check rather
than a fixed per-memcg work item is to keep bpf_proactive_reclaim()
flexible: it bounds how much reclaim can run against one memcg at any
moment, while leaving the reclaim policy -- when to reclaim, how many
passes to batch, and when to stop (e.g. if the target cgroup is
dying) -- entirely in the BPF program. Do you think this is a
reasonable way to bound the total reclaim activity per memcg, or
would you prefer something else?

With the per-invocation cap, each kfunc call becomes a small, bounded
unit of work, and the BPF program does the batching: it schedules
successive wq submissions and can stop submitting between passes when
needed. This keeps the "when and how hard to reclaim" policy in BPF
while bounding the kernel-side cost of each invocation.

Best,
Hui


>> + *
>> + * Must not be called with a filesystem lock held: the reclaim path
>> + * may deadlock on it via filesystem shrinkers.
>> + *
>> + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
>> + * smaller than a page or the task is already in a reclaim context.
>> + */
>> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup 
>> *memcg,
>> +                        unsigned long size)
>> +{
>> +    unsigned long nr_reclaimed;
>> +
>> +    if (size < PAGE_SIZE || unlikely(bpf_in_reclaim_context()))
>> +        return 0;
>> +
>> +    nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, size / 
>> PAGE_SIZE,
>> +                            GFP_KERNEL,
>> +                            MEMCG_RECLAIM_MAY_SWAP |
>> +                            MEMCG_RECLAIM_PROACTIVE,
>> +                            NULL);
>> +
>> +    return nr_reclaimed * PAGE_SIZE;
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>     BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
>> @@ -171,22 +221,44 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events)
>>   BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>>   BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>>   BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
>> -
>>   BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
>>   +/*
>> + * Proactive reclaim needs a clean process context, so it is restricted
>> + * to BPF_PROG_TYPE_SYSCALL. The bpf_wq and task_work callbacks that a
>> + * SYSCALL program schedules run as the same program type, so they can
>> + * still invoke it; generic sleepable programs (e.g. fentry on reclaim
>> + * paths, inode_rmdir) cannot.
>> + */
>> +BTF_KFUNCS_START(bpf_memcontrol_reclaim_kfuncs)
>> +BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
>> +BTF_KFUNCS_END(bpf_memcontrol_reclaim_kfuncs)
>> +
>>   static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
>>       .owner          = THIS_MODULE,
>>       .set            = &bpf_memcontrol_kfuncs,
>>   };
>>   +static const struct btf_kfunc_id_set 
>> bpf_memcontrol_reclaim_kfunc_set = {
>> +    .owner          = THIS_MODULE,
>> +    .set            = &bpf_memcontrol_reclaim_kfuncs,
>> +};
>> +
>>   static int __init bpf_memcontrol_init(void)
>>   {
>>       int err;
>>         err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
>>                       &bpf_memcontrol_kfunc_set);
>> -    if (err)
>> +    if (err) {
>>           pr_warn("error while registering bpf memcontrol kfuncs: 
>> %d", err);
>> +        return err;
>> +    }
>> +
>> +    err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
>> +                    &bpf_memcontrol_reclaim_kfunc_set);
>> +    if (err)
>> +        pr_warn("error registering bpf reclaim kfuncs: %d", err);
>>         return err;
>>   }
>
