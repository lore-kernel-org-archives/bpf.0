Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906963E49D5
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231583; cv=none; b=ViWO+FUcFC0Gc0c785f4urMS8cko3msJ6DaY2/M2V519IQfVKitWDik3k8Uw2swgEUvSzeuSfwwN/10nHB5SJXXfnmwCuwkuOliAtZbtT4Oi3b//DiKQjxgMv2FMEQke6Rus1X2DM29C9B6sw24KwvruGaCElanOFd//NVdkiLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231583; c=relaxed/simple;
	bh=ciZZAzaZaR3UaV0eFejfaxcyL47+g1hpSZHv6435/SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6pLsSecdPrnszi1QWwhOGAVd8b2krqv90IZkUZgOefaT+MvzQDGa8EmVj2juukwZTkgsbSBGT+StlVg+QjQOg9WGb64b6WCltJFMtQSaq8vTtjmCFpW43aAahWO6bUdQRTzy0ATcORNMX8Ad2Ed5zJZCaTe30kK04/rKhnH9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BVddg9xQ; arc=none smtp.client-ip=91.218.175.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BVddg9xQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ciZZAzaZaR3UaV0eFejfaxcyL47+g1hpSZHv6435/SE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788231577; v=1; x=1788836377;
 b=BVddg9xQfgMBm84LyeQdcvSHAvPMHvHjo+BFO+MmquUDMQLeOuKFqK5661AWKPIRKRb/ODaE
 22Iw/mt+2pZn0IVc5aWGjiADZ1gD+AG4wT7FHx8oHkFBmNtIRVXGk90u4iXkAowjAmrdoWpV3HR
 dld728wU1Tx6YbToz/bwc0Hs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a8ec0cb1a616635;
	Tue, 01 Sep 2026 02:59:37 +0000
X-Mizu-Trace-ID: 0a8ec0cb1a616635
X-Migadu-Flow: FLOW_OUT
Message-ID: <4984b835-6cd2-4870-9b2c-ebe74c684b23@linux.dev>
Date: Tue, 1 Sep 2026 10:59:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH bpf-next v5 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 JP Kobryn <inwardvessel@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Geliang Tang <geliang@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1787826402.git.zhuhui@kylinos.cn>
 <5dfdc7800469eac4e9a240f2422ba65d4ef4c4ba.1787826402.git.zhuhui@kylinos.cn>
 <apHk86Y8araBlXcq@linux.dev> <DL0VTAZE10HC.3R4HIC6S0U3P1@gmail.com>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <DL0VTAZE10HC.3R4HIC6S0U3P1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> On Fri Aug 28, 2026 at 9:53 PM CEST, Shakeel Butt wrote:
>> On Thu, Aug 27, 2026 at 06:36:29PM +0800, Hui Zhu wrote:
>>> From: Hui Zhu <zhuhui@kylinos.cn>
>>>
>>> Add bpf_proactive_reclaim(), a sleepable kfunc which performs one
>>> proactive reclaim pass on a given memory cgroup, similar to a write
>>> to memory.reclaim but without retrying until the target is reached.
>>>
>>> The kfunc refuses to reclaim if the calling task is already in a
>>> reclaim context, as a nested reclaim would corrupt the outer reclaim
>>> state.
>>>
>>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>>> ---
>>>   mm/bpf_memcontrol.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>
>>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>>> index 716df49d7647..297ff7f05042 100644
>>> --- a/mm/bpf_memcontrol.c
>>> +++ b/mm/bpf_memcontrol.c
>>> @@ -6,6 +6,7 @@
>>>    */
>>>
>>>   #include <linux/memcontrol.h>
>>> +#include <linux/swap.h>
>>>   #include <linux/bpf.h>
>>>
>>>   __bpf_kfunc_start_defs();
>>> @@ -159,6 +160,49 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>>>   	mem_cgroup_flush_stats(memcg);
>>>   }
>>>
>>> +/*
>>> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
>>> + * current->reclaim_state, so a nested call would corrupt the outer
>>> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
>>> + * reclaim_state is also checked because it is installed slightly
>>> + * before PF_MEMALLOC.
>>> + */
>>> +static bool bpf_in_reclaim_context(void)
>>> +{
>>> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
>>> +}
>>> +
>>> +/**
>>> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
>>> + *                         cgroup
>>> + * @memcg: the target memory cgroup to reclaim from
>>> + * @size:  the amount of memory to reclaim, in bytes
>>> + *
>>> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
>>> + * memory.reclaim, but without retrying until @size is reached.
>>> + * Must not be called with a filesystem lock held: the reclaim path
>>> + * may deadlock on it via filesystem shrinkers.
>>> + *
>>> + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
>>> + * smaller than a page or the task is already in a reclaim context.
>>> + */
>>> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
>>> +						unsigned long size)
>>> +{
>>> +	unsigned long nr_reclaimed;
>>> +
>>> +	if (size < PAGE_SIZE || unlikely(bpf_in_reclaim_context()))
>>> +		return 0;
>> I have been thinking about this more and more and after looking at the reasoning
>> behind your check current->reclaim_state and also Sashiko's comment on NOIO/NOFS
>> contexts, I am more convinced that this kfunc can not be a simple sleepable
>> function. We need more than that. We need clean process context as well similar
>> to the userspace poking memory.reclaim. Something like kthread or workqueue.
>>
>> Kumar & Andrii, is there a way to restrict a kfunc to only be called from
>> special BPF threads/workqueues? Is there some similar concept in BPF world?
>>
> Yeah, I think the concern is valid. E.g. inode_rmdir() is sleepable but will be
> problematic here, I think. My first instinct was if bpf_in_reclaim_context() +
> nofs/noio save-restore might provide enough protection to let it be callable
> from generic sleepable contexts, but I guess that will disable invocation of
> filesystem shrinkers unconditionally.
>
> So my suggestion would be to fix the context to BPF_PROG_TYPE_SYSCALL. There, we
> should be able to init and schedule timers which poll specific state and arms wq
> execution etc. It then remains invocable from sleepable async contexts (wq,
> task_work) or the syscall program, all of which should be ok. Once BPF kthread
> lands we can let it be callable from those threads as well, but that is for
> later.

Hi Kumar and Shakeel,


The patch has been modified according to your comments.

Please help me review it.


Best,

Hui


>> [...]
