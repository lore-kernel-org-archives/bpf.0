Received: from mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AB468C1D
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061516; cv=none; b=VbOoMbcq/y74oo4ekYN2lUgbjnbWalGriYCGNB1wMwnn5Qw4XCOxywUpm8vUXPVkEj3IavIgg0yBQLUTZwRtdk35ZSnTEiJG/CnGvquwlubUwwerQqsg+RghAQht5f01gfSQm/7MiDDnkjDzsamD0YQXeYirMh1vpK+vd3+hC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061516; c=relaxed/simple;
	bh=MNNbsfqEg64V79LFUtQz5lVKVEX8FokcixHJCigxHzE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FrpFLZNX0pLqSdmBTHNVHIL8kXgmXhGmuVc/TDpk+N3iH6czPi/C/ErcKrOBsgcSO03iLj+g80H6PgoHyHMV9Pgju4/MusCbPT58/Ncy0739ykbkhM006BZcCRxqMzwzH7+TVEXfYjttOS0SezK5G+74BYUJdRoX/hgsC/gF8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m3vVfe3h; arc=none smtp.client-ip=95.215.58.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m3vVfe3h"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MNNbsfqEg64V79LFUtQz5lVKVEX8FokcixHJCigxHzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787061512; v=1; x=1787666312;
 b=m3vVfe3hYSLzxdsHbSz/rX3J1u9fqAWD2XisemfNJQWIlfjhEYKXLWtLGT3rDJgQVd4cjwBS
 TbLQXwUFHBs6P+GRKFjuEG+3LDFKMXN/NWVHOHJ8k2WQrX0u1ePQBoYjG+7OWe6N3lc3wlHUose
 alEqXHW84t2uByzUY29J8PE4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id a762077461864aa3;
	Tue, 18 Aug 2026 13:58:32 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <ceb9f4e0-5fe3-426a-bdc7-42d918f87fab@linux.dev>
Date: Tue, 18 Aug 2026 21:58:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, arighi@nvidia.com, changwoo@igalia.com,
 suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH RFC] sched_ext: warn when cpu.max is set but the BPF
 scheduler doesn't implement bandwidth control
To: tj@kernel.org, void@manifault.com
References: <20260818135328.174152-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260818135328.174152-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi, tejun

在 2026/8/18 21:53, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The kernel stores cpu.max bandwidth parameters in the task_group and
> passes them to the BPF scheduler via ops.cgroup_set_bandwidth() and
> scx_cgroup_init_args, but does not enforce the quota itself. If the
> loaded BPF scheduler doesn't implement the callback, cpu.max is
> silently ignored -- the cgroup gets unlimited CPU regardless of the
> configured quota.
> 
> Of the example schedulers, only scx_qmap implements the callback --
> and only to bpf_printk() the parameters, so no in-tree scheduler
> actually enforces the quota. Measured with scx_simple: a
> cgroup with cpu.max = "50000 100000" (50% of one CPU) and one
> busy task used 9946ms of CPU in 10 seconds with nr_throttled
> remaining 0.
> 
> Print a one-time warning when a finite quota is configured on a
> cgroup while the active scheduler lacks the callback, so users and
> container orchestrators know the quota is not enforced.
> 

Some background on how I found this: I was testing how sched_ext
interacts with cgroup CPU controls in a VM, and the cpu.max case stood
out:

    cgroup with cpu.max = "50000 100000" (50% of one CPU),
    one busy task, scx_simple loaded

    sched_ext : 9946ms of CPU in 10s, nr_throttled = 0
    CFS       : ~5000ms in 10s, throttling as expected

The same happens with scx_flatcg and scx_central -- neither they nor
scx_simple implement ops.cgroup_set_bandwidth(), so the quota is
silently ignored. grep shows scx_qmap is the only in-tree user of the
callback -- and its implementation just bpf_printk()s the parameters, so
even there the quota is not enforced. Outside the
tree, lavd implements its own bandwidth accounting, but as far as I can
tell rusty and bpfland don't, which suggests users on those schedulers
are running containers with cpu.max that does nothing.

That's why I drafted the warning patch -- but I'm not sure a warning is
the right approach. Some alternatives I can think of:

  1. pr_warn_once() as in this patch (minimal, but the quota is still
     not enforced)
  2. refuse to enable sched_ext (or the cgroup support) when a finite
     quota exists and the callback is missing
  3. kernel-side fallback enforcement, e.g. throttle in
     scx_next_task_picked()/dispatch path based on tg->scx.bw_quota_us

Is the missing enforcement considered the BPF scheduler's responsibility
by design (and just under-documented), or would a kernel fallback be
welcome? If it's the former, maybe sched-ext.rst should mention that
cpu.max requires ops.cgroup_set_bandwidth() from the loaded scheduler.

Happy to work on whichever direction you prefer.

Thanks,
Tao

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/sched/ext/ext.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10af28a9f2c0..de786d0b928a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4953,6 +4953,12 @@ void scx_group_set_bandwidth(struct task_group *tg,
>  	     tg->scx.bw_burst_us != burst_us))
>  		SCX_CALL_OP(sch, cgroup_set_bandwidth, NULL,
>  			    tg_cgrp(tg), period_us, quota_us, burst_us);
> +	else if (scx_cgroup_enabled && sch &&
> +		 !SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
> +		 quota_us != RUNTIME_INF)
> +		pr_warn_once("sched_ext: BPF scheduler \"%s\" does not implement "
> +			     "ops.cgroup_set_bandwidth(); cpu.max will not be enforced\n",
> +			     sch->ops.name);
>  
>  	tg->scx.bw_period_us = period_us;
>  	tg->scx.bw_quota_us = quota_us;

