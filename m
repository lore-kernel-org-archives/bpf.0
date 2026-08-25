Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400203161A1
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624445; cv=none; b=ZVGLSlyQuSnOridiYBmVdE8ZPKx/sWBabezEwSgqnOUGjwlEAR5xok2Q0pMTj3O0Xl5/Lv+tezUVsNwhhymY9sLrXHg+m3Eq+9jQZ3FSqkeXfOMsOlzheY0TD3C0vUSL8n9wBjT4s/TuLPYiUi113q5pBX9qQ0hN/TkiJAv/2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624445; c=relaxed/simple;
	bh=3GzEeonSy0GCsyVRDYgJEZ9Oqg0XZ0y3D3sYwguB7YA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bv07xl/Is2+Aso5AJJJnu+nftnIvPV75LWzSNqY6FT1l9ubxzFORLUA8Y6rD1AXdmf3HoleVyrD7GbpjZ9xYfcaRGxdx7CLydavg2SiVp9epARHeuB7PikcggqrXLTxaE9FPZCvosqxnut0I6fjqfPUDzHLU3iOehh5Bx9maYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3DvjUuX; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3DvjUuX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3GzEeonSy0GCsyVRDYgJEZ9Oqg0XZ0y3D3sYwguB7YA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787624441; v=1; x=1788229241;
 b=r3DvjUuXzP7ZWA3aGfpRKw+Q0h19oa99JnxrOYwaRbX9Rwbu8h8gHpIoU/DNqeIqJNiVaDkD
 6oQ3L/e3SWlbq//OvP/85gxfTZdDmbx8uyQOI9RA1wg+JAU2MJfLkXnoTwNMlMXdJK6FRC3l0BB
 CFRjNryQL+WpshxIMA/Us5LE=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.160.239)
	by smtp.migadu.com with ESMTPS id f0ce71cfc12c4d70;
	Tue, 25 Aug 2026 02:20:31 +0000
X-Mizu-Trace-ID: f0ce71cfc12c4d70
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd013141-0635-49ea-8c1b-f18133138678@linux.dev>
Date: Tue, 25 Aug 2026 10:20:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, void@manifault.com,
 changwoo@igalia.com, suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] sched_ext: pass the initial cpu.idle state in
 scx_cgroup_init_args
To: Andrea Righi <arighi@nvidia.com>
References: <20260824142817.568085-1-cui.tao@linux.dev>
 <aoxeGI-RsNj3nDKU@gpd4>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <aoxeGI-RsNj3nDKU@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Andrea,

在 2026/8/24 23:07, Andrea Righi 写道:
> Hi Tao,
> 
> On Mon, Aug 24, 2026 at 10:28:16PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> scx_cgroup_init_args carries the initial weight and bandwidth control
>> parameters of a cgroup to ops.cgroup_init(), but not its cpu.idle
>> state. A cgroup that was already configured idle before the scheduler
>> was loaded (or before it was onlined under it) is presented as
>> non-idle, and the BPF scheduler only learns about it if cpu.idle is
>> written again later.
>>
>> Add the idle state to scx_cgroup_init_args and fill it in all four
>> places that build the args: scx_tg_online() for cgroups onlined under
>> the scheduler, scx_cgroup_init() for cgroups that already exist when
>> the scheduler is loaded, and the sub-scheduler handover paths
>> scx_cgroup_claim_subtree() and scx_cgroup_return_subtree().
>>
>> Verified in a VM with a probe scheduler printing the init args: a
>> cgroup configured cpu.idle=1 before loading shows idle=1 in
>> ops.cgroup_init(), the default shows 0, and later cpu.idle writes
>> still come through ops.cgroup_set_idle(). The sub-scheduler paths
>> are compile-tested only.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> We should probably add:
> 
> Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback"
> 
> With that:
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> 

Thank you for the review, and for catching the sub.c handover paths
earlier. v3 adds the Fixes: tag you suggested and carries your
Reviewed-by. The field is also renamed to sched_idle per Tejun's
review; the rename is mechanical, so I kept the tag, but I'm happy
to wait for a re-review if you prefer.

Thanks,
Tao

> Thanks,
> -Andrea
> 
>> ---
>> v1 -> v2: Also fill .idle in the sub-scheduler handover paths in
>> sub.c, scx_cgroup_claim_subtree() and scx_cgroup_return_subtree(),
>> missed in v1 and pointed out by Andrea Righi and the sashiko AI
>> review bot.
>>
>> v1: https://lore.kernel.org/r/20260824133954.561956-1-cui.tao@linux.dev
>>
>>  kernel/sched/ext/ext.c      | 4 +++-
>>  kernel/sched/ext/internal.h | 3 +++
>>  kernel/sched/ext/sub.c      | 2 ++
>>  3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index b646711a45fe..a7218314dcfb 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -4764,7 +4764,8 @@ int scx_tg_online(struct task_group *tg)
>>  				{ .weight = tg->scx.weight,
>>  				  .bw_period_us = tg->scx.bw_period_us,
>>  				  .bw_quota_us = tg->scx.bw_quota_us,
>> -				  .bw_burst_us = tg->scx.bw_burst_us };
>> +				  .bw_burst_us = tg->scx.bw_burst_us,
>> +				  .idle = tg->scx.idle };
>>  
>>  			ret = SCX_CALL_OP_RET(sch, cgroup_init,
>>  					      NULL, tg->css.cgroup, &args);
>> @@ -5185,6 +5186,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
>>  				.bw_period_us = tg->scx.bw_period_us,
>>  				.bw_quota_us = tg->scx.bw_quota_us,
>>  				.bw_burst_us = tg->scx.bw_burst_us,
>> +				.idle = tg->scx.idle,
>>  			};
>>  
>>  			ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL, css->cgroup, &args);
>> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
>> index 53e136a47924..aa149a9c29f7 100644
>> --- a/kernel/sched/ext/internal.h
>> +++ b/kernel/sched/ext/internal.h
>> @@ -259,6 +259,9 @@ struct scx_cgroup_init_args {
>>  	u64			bw_period_us;
>>  	u64			bw_quota_us;
>>  	u64			bw_burst_us;
>> +
>> +	/* whether the cgroup is configured idle via cpu.idle */
>> +	bool			idle;
>>  };
>>  
>>  enum scx_cpu_preempt_reason {
>> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
>> index 0554448835bd..9701bd1d8ea0 100644
>> --- a/kernel/sched/ext/sub.c
>> +++ b/kernel/sched/ext/sub.c
>> @@ -1361,6 +1361,7 @@ static s32 scx_cgroup_claim_subtree(struct scx_sched *sch)
>>  			.bw_period_us = tg->scx.bw_period_us,
>>  			.bw_quota_us = tg->scx.bw_quota_us,
>>  			.bw_burst_us = tg->scx.bw_burst_us,
>> +			.idle = tg->scx.idle,
>>  		};
>>  
>>  		if (tg->scx.sched != parent ||
>> @@ -1464,6 +1465,7 @@ static void scx_cgroup_return_subtree(struct scx_sched *sch)
>>  			.bw_period_us = tg->scx.bw_period_us,
>>  			.bw_quota_us = tg->scx.bw_quota_us,
>>  			.bw_burst_us = tg->scx.bw_burst_us,
>> +			.idle = tg->scx.idle,
>>  		};
>>  
>>  		/* the first pass must have transferred everything */
>> -- 
>> 2.43.0
>>

