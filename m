Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21D2F3C18
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266131; cv=none; b=jt1is8yi1F0mhvkFh2VH0sFiA8WERU0e8nwCCq1p1NFeJtVPUma/aGXt5wVC7DzbZ3qEQ7zSqdmWQ8saWHL2TZnxSSSY6hN2lYBqYtLj/SmYEhLvURr7cj6chL1+eN25UDVqMRdp70F+pGBg79NBKuOZQoWKwhYjngUF87N8jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266131; c=relaxed/simple;
	bh=X+DkHxLt+CgQ947vh/gRAc51B7xguiauK38xqdvZxys=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CjGXn85Gy0UMPjd4hZWbzvAWdlS858X3/Ps8bcdeA4+1unH9NQsLrFb0CVQFrnrmwEU8WIlkvkSEq96kyjWNPfTSpV1YA/bLm/TnKhYhzQoxjVA119Ua1JJhQGVQXlxP44Edhu21b6BqmeSkT7cbSzdMJ88nEXHdWoPQpQjwJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mp4BZJBW; arc=none smtp.client-ip=91.218.175.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mp4BZJBW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X+DkHxLt+CgQ947vh/gRAc51B7xguiauK38xqdvZxys=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788266126; v=1; x=1788870926;
 b=Mp4BZJBWQ0nHlQMN8r+q9d/YUtOBHa+Nrp1JAowPqTbwJ/IC4FAhTCSayVmsTArHV3mX9Lh6
 FscbcURYEiimMVsgRLx7sSKGXo3IENSwrfnU6qw8pt3h7u4/s2SmcOhqRWdf+RooAlKr35qKPNV
 g4jb63He1lZs3CW23p+Tfc1A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6fb685d0476b67ce;
	Tue, 01 Sep 2026 12:35:26 +0000
X-Mizu-Trace-ID: 6fb685d0476b67ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <2da859e8-2025-4926-99f4-8ba595e25abf@linux.dev>
Date: Tue, 1 Sep 2026 20:35:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, void@manifault.com,
 changwoo@igalia.com, michalblk@google.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] sched_ext: don't deliver duplicate ops.cgroup_set_idle()
 for same value
To: Andrea Righi <arighi@nvidia.com>
References: <20260901031101.731943-1-cui.tao@linux.dev>
 <apZ-B__OiVcZW46Z@gpd4>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <apZ-B__OiVcZW46Z@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrea,

在 2026/9/1 15:25, Andrea Righi 写道:
> Hi Tao,
> 
> On Tue, Sep 01, 2026 at 11:11:01AM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> ops.cgroup_set_idle() is documented to be invoked when a cgroup
>> transitions between idle and non-idle states, and scx_group_set_weight()
>> already skips value-preserving writes. scx_group_set_idle() delivers
>> every write unconditionally, so rewriting an already-correct cpu.idle
>> value feeds the BPF scheduler a transition callback each time, which
>> toggle- or accounting-based schedulers miscount. Mirror the weight
>> guard and only deliver on an actual change.
>>
>> Verified with a probe scheduler printing each callback: rewriting
>> cpu.idle=1 twice on an already-idle cgroup delivered two callbacks
>> before and none after.
>>
>> Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback")
>> Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed
> 
> This link seems broken, I think the right one is:
> 
> Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed@linux.dev
> 

Thanks! Somehow my vim seems to have eaten the `@linux.dev` part of the Message-ID. I'll fix the Link tag in the next revision.

Thanks for the review!

Best,
Tao

>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> Other than that looks good to me.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> 
> Thanks,
> -Andrea
> 
>> ---
>>  kernel/sched/ext/ext.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index 8041c87a3562..8b3625107b72 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -4933,7 +4933,8 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
>>  	percpu_down_read(&scx_cgroup_ops_rwsem);
>>  	sch = scx_tg_knob_sched(tg);
>>  
>> -	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle))
>> +	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle) &&
>> +	    tg->scx.sched_idle != idle)
>>  		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
>>  
>>  	/* Update the task group's idle state */
>> -- 
>> 2.43.0
>>

