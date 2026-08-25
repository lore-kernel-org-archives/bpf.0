Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6C328B5E
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650124; cv=none; b=OKqCcPe/eHpZvQTm901mCkCj7w6DJkOeQRG88D3A8tCpu/bWr9hVDOXTNq9O8rPpDFBED9Tqiw89QJsFw803tCTZFisC+YRviDh95OmDRjg80qLjPRB0bWp0ES5nHW+rGDNg2uhyPA72rTOivcyzDTQZwTgMkj49QhRo7FZzWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650124; c=relaxed/simple;
	bh=x45sufu59TYs6wwcfMUhG2W/bkS9fIcI9yrk0oMc0PI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rFQr+/QnFrblAV8kfvrI9rRdyhhDYlOHBiLNZnGXiHAzhroB+oHVGEQ6eCCExMsY5/LDNWJbh3Zqqks42jfxssGeDdSzRKcLsxSzylcL4DoEQPGFGz9V4/CohP4IW+g8ipAOeqLJ0zI8XdJW6dOk0puB4/EejBTFEq1dI3nnuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M5Wq7tTw; arc=none smtp.client-ip=95.215.58.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M5Wq7tTw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x45sufu59TYs6wwcfMUhG2W/bkS9fIcI9yrk0oMc0PI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787650120; v=1; x=1788254920;
 b=M5Wq7tTwPwPhSANJfRhKcFP6pKXgxpD7HSb1Eh8deDsyDRBoQk+V/MSvj+JNy+SKF152bxWn
 FL7f/aAH75mEtcyZ9ubK0wpo18hI6XVmMjcDi0S8ahvhZcpJ7rmw+nM88OLjbUmoNfxEIDBAAkP
 rk297sILIrIOaDyTx/YLxlzI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 62e9a67761ddc445;
	Tue, 25 Aug 2026 09:28:30 +0000
X-Mizu-Trace-ID: 62e9a67761ddc445
X-Migadu-Flow: FLOW_OUT
Message-ID: <1b118693-dea7-4489-bedd-9813530904c8@linux.dev>
Date: Tue, 25 Aug 2026 17:28:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, void@manifault.com,
 changwoo@igalia.com, michalblk@google.com, suzhidao@xiaomi.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] sched_ext: Allow ops.cgroup_set_weight/idle() to be
 sleepable
To: Andrea Righi <arighi@nvidia.com>
References: <20260825052336.46746-1-cui.tao@linux.dev> <ao1R11aGRZH9hE5f@gpd4>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <ao1R11aGRZH9hE5f@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrea,

在 2026/8/25 16:27, Andrea Righi 写道:
> Hi Tao,
> 
> On Tue, Aug 25, 2026 at 01:23:36PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> ops.cgroup_set_weight() and ops.cgroup_set_idle() are delivered from
>> scx_group_set_weight() and scx_group_set_idle(), which run from the
>> cpu.weight (and v1 cpu.shares) and cpu.idle cgroup interface write paths
>> in process context. Both hold percpu_down_read(&scx_cgroup_ops_rwsem),
>> whose read side may sleep. The call sites are therefore sleepable, like
>> ops.cgroup_set_bandwidth(), which was recently added to the sleepable
>> allow-list.
> 
> The change itself makes sense, but I think the serialization issue pointed out
> by sashiko is valid. Concurrent cgroup knob updates can complete their sched_ext
> notifications out of order, potentially leaving the core scheduler and BPF
> scheduler with inconsistent state.
> 
> We should probably address the race first. I may have a fix and will post it
> shortly (testing right now). Then we can apply this sleepable callback change on
> top.
> 

Thanks for the review.

Agreed on the ordering: I'll wait for the serialization fix to land
and rebase this on top before sending v2.

>>
>> bpf_scx_check_member() rejects a sleepable program on any member not on
>> its allow-list, so a BPF scheduler cannot allocate -- which is sleepable
>> -- when a cgroup's weight or idle state changes at runtime. Add
>> cgroup_set_weight() and cgroup_set_idle() to the allow-list so these
>> callbacks can allocate on demand, and document that they may block.
>>
>> Also add the matching compatibility markers, so userspace can detect
>> this support via BTF, mirroring
>> scx_compat_marker_cgroup_set_bandwidth_may_sleep().
>>
>> To size the alternative, a scheduler that gives each cgroup a
>> dedicated idle DSQ must create it in ops.cgroup_init() for every
>> cgroup up front. In a VM with 2000 cgroups that is 2000+ standing
>> DSQs, each a struct scx_dispatch_q plus a per-CPU area. With the
>> allow-list entries the same scheduler can create the DSQ lazily on
>> the first cpu.idle=1 write of a cgroup: 4 allocations for the 4
>> cgroups marked idle at runtime, and repeated cpu.idle writes do not re-allocate. Verified with a probe scheduler on an
>> unpatched kernel (load rejected with -EINVAL) and on a patched one.
> 
> nit: this paragraph needs a rewrapping (line too long).
> 
> Besides rewrapping, could we simplify this part and rephrase it in terms of DSQs
> rather than allocations? For example (something along these lines):
> 
>   Without this support, a scheduler that uses a dedicated idle DSQ for each
>   cgroup must create it eagerly from ops.cgroup_init(). With a sleepable
>   ops.cgroup_set_idle() callback, it can instead create the DSQ
>   lazily when the cgroup is first marked idle, avoiding unnecessary DSQs
>   for cgroups that never use cpu.idle.
> 

For the commit message, v2 will rewrap the last paragraph and rephrase
it in terms of DSQs following your suggestion.

Thanks,
Tao

> Thanks,
> -Andrea
> 
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>  kernel/sched/ext/ext.c      | 18 ++++++++++++++++++
>>  kernel/sched/ext/internal.h |  9 +++++----
>>  2 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index b646711a45fe..53b888f5a6c5 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -8079,7 +8079,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
>>  	case offsetof(struct sched_ext_ops, cgroup_init):
>>  	case offsetof(struct sched_ext_ops, cgroup_exit):
>>  	case offsetof(struct sched_ext_ops, cgroup_prep_move):
>> +	case offsetof(struct sched_ext_ops, cgroup_set_weight):
>>  	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):
>> +	case offsetof(struct sched_ext_ops, cgroup_set_idle):
>>  #endif
>>  	case offsetof(struct sched_ext_ops, cpu_online):
>>  	case offsetof(struct sched_ext_ops, cpu_offline):
>> @@ -11055,3 +11057,19 @@ __initcall(scx_init);
>>  #ifdef CONFIG_EXT_GROUP_SCHED
>>  DEFINE_SCX_COMPAT_MARKER(cgroup_set_bandwidth_may_sleep);
>>  #endif	/* CONFIG_EXT_GROUP_SCHED */
>> +
>> +/*
>> + * scx_compat_marker_cgroup_set_weight_may_sleep: advertises that
>> + * ops.cgroup_set_weight() may be implemented as a sleepable callback.
>> + */
>> +#ifdef CONFIG_EXT_GROUP_SCHED
>> +DEFINE_SCX_COMPAT_MARKER(cgroup_set_weight_may_sleep);
>> +#endif	/* CONFIG_EXT_GROUP_SCHED */
>> +
>> +/*
>> + * scx_compat_marker_cgroup_set_idle_may_sleep: advertises that
>> + * ops.cgroup_set_idle() may be implemented as a sleepable callback.
>> + */
>> +#ifdef CONFIG_EXT_GROUP_SCHED
>> +DEFINE_SCX_COMPAT_MARKER(cgroup_set_idle_may_sleep);
>> +#endif	/* CONFIG_EXT_GROUP_SCHED */
>> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
>> index 53e136a47924..f81d03de2d3c 100644
>> --- a/kernel/sched/ext/internal.h
>> +++ b/kernel/sched/ext/internal.h
>> @@ -736,7 +736,7 @@ struct sched_ext_ops {
>>  	 * @cgrp: cgroup whose weight is being updated
>>  	 * @weight: new weight [1..10000]
>>  	 *
>> -	 * Update @cgrp's weight to @weight.
>> +	 * Update @cgrp's weight to @weight. This operation may block.
>>  	 *
>>  	 * Knobs of a cgroup belong to the parent, so the set_* ops are
>>  	 * delivered to @cgrp's parent's sched. That sched may never have seen
>> @@ -773,9 +773,10 @@ struct sched_ext_ops {
>>  	 * @cgrp: cgroup whose idle state is being updated
>>  	 * @idle: whether the cgroup is entering or exiting idle state
>>  	 *
>> -	 * Update @cgrp's idle state to @idle. This callback is invoked when
>> -	 * a cgroup transitions between idle and non-idle states, allowing the
>> -	 * BPF scheduler to adjust its behavior accordingly.
>> +	 * Update @cgrp's idle state to @idle. This operation may block. This
>> +	 * callback is invoked when a cgroup transitions between idle and
>> +	 * non-idle states, allowing the BPF scheduler to adjust its behavior
>> +	 * accordingly.
>>  	 *
>>  	 * Delivery follows the same rule as cgroup_set_weight().
>>  	 */
>> -- 
>> 2.43.0
>>

