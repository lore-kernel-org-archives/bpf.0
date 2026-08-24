Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E5438495
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581021; cv=none; b=uDzN41JYt0rvx2wMnyITNvHqngA77Ioq4w43uMHxk2SU2J4eDF4vFXmZ6nPY4NcVZRqss9QywB4zbrXMfSHSE4bNWUEYKrwZQpFEsiDagkZq6b8/4lFFdg4a1YsGRnA6JOWUjId7kcfi3utlZgWuuQ7QFAByrAEi7jwxvQLlQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581021; c=relaxed/simple;
	bh=hrf2Ufu7tuw2vu6nasTmIL9nYNzZk+TC4keTT8NzI0g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g3GUtHCkAPPqsZdvlappb5YA/v/4DEY/7lDzK3ZpWkQ3PAFFe3umndhRoH5tUKMgci9FiaHEW2x8HPbPufQ9nWFuDsiv2eXucKWoTUhIwDOGE+RnHPtn0rNWhotaeJI6wQuW6Xn1UvxpFWtLDDTsmctGr5+M0MWB2ag/NyeaL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7uFAkDB; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7uFAkDB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hrf2Ufu7tuw2vu6nasTmIL9nYNzZk+TC4keTT8NzI0g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787581016; v=1; x=1788185816;
 b=U7uFAkDB4c3WQALs5xLYKcfRP9/KU1P8rltcCg43CARJp1BERVmuTJYeH+teIWEE6Zz0lbwT
 t0A/RT7CSLImTwZFqbpcdY/LU4966u8cculT+VpNBQ2ZfJo7zgl6nEYlr0C72DUmnKpqO/Zn0HQ
 GfxEEuCkUY9YDFVNQtCnRWUk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 263c525af6cb8c23;
	Mon, 24 Aug 2026 14:16:56 +0000
X-Mizu-Trace-ID: 263c525af6cb8c23
X-Migadu-Flow: FLOW_OUT
Message-ID: <13ca7798-d10e-471d-aab7-e3199199e07f@linux.dev>
Date: Mon, 24 Aug 2026 22:16:49 +0800
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
Subject: Re: [PATCH] sched_ext: pass the initial cpu.idle state in
 scx_cgroup_init_args
To: Andrea Righi <arighi@nvidia.com>
References: <20260824133954.561956-1-cui.tao@linux.dev>
 <aoxRHw-Q5FCUX6zo@gpd4>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <aoxRHw-Q5FCUX6zo@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Andrea

在 2026/8/24 22:11, Andrea Righi 写道:
> Hi Tao,
> 
> On Mon, Aug 24, 2026 at 09:39:54PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> scx_cgroup_init_args carries the initial weight and bandwidth control
>> parameters of a cgroup to ops.cgroup_init(), but not its cpu.idle
>> state. A cgroup that was already configured idle before the scheduler
>> was loaded (or before it was onlined under it) is presented as
>> non-idle, and the BPF scheduler only learns about it if cpu.idle is
>> written again later.
>>
>> Add the idle state to scx_cgroup_init_args and fill it in both places
>> that build the args -- scx_tg_online() for cgroups created under the
>> scheduler and scx_cgroup_init() for cgroups that already exist when
>> the scheduler is loaded.
>>
>> Verified in a VM with a probe scheduler printing the init args: a
>> cgroup configured cpu.idle=1 before loading shows idle=1 in
>> ops.cgroup_init(), the default shows 0, and later cpu.idle writes
>> still come through ops.cgroup_set_idle().
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>  kernel/sched/ext/ext.c      | 4 +++-
>>  kernel/sched/ext/internal.h | 3 +++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
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
> 
> It looks like there are two more places in kernel/sched/ext/sub.c,
> scx_cgroup_claim_subtree() and scx_cgroup_return_subtree(), they should also
> initialize idle. Otherwise the field defaults to false and an idle cgroup would
> be presented as non-idle when it's handed to a sub-scheduler.
> 

Right, I missed those two. v2 fills .idle in all four places that
build scx_cgroup_init_args, including both sub-scheduler handover
paths in sub.c. The main paths are verified in a VM; the sub.c ones
are compile-tested only.

Thanks,
Tao> Thanks,
> -Andrea

