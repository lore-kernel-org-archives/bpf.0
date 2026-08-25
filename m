Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D84EEB3
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635251; cv=none; b=CIQqE3M11B2coPUNmURvKwfQSdKfpxRYV5tnXX4J1wtdW9MDdnyuv4HtffKryhRSROkchXSwoivxaaa6vay+u42T60qBr5bI4aLhiP+FwCK8j8p/ohErxkj03FVZeHRiSuVYImHmoahKylVD813wkcecgOwVcbhNl1cy2N15yB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635251; c=relaxed/simple;
	bh=jKOn6c3JwfhU0blNNANNdH5tsYtF/WHHWEBVop/x5Q0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NIDZO6sVA0jca7t1QiBucm3/DZ8POIoVwzG33Ka+H1ns7flejqHvtttcvYmPgHosjZMveMAQxvN8cb8RN3tr6h7Qd42URqVIXj9qguXK/DPayRQy68Ju7lDIn/0lWSQReaKigRC+KwzaCt+HsdLAfUMGs+Vw0D/MAq3/eP2umZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tTgCxtIv; arc=none smtp.client-ip=95.215.58.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tTgCxtIv"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jKOn6c3JwfhU0blNNANNdH5tsYtF/WHHWEBVop/x5Q0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787635248; v=1; x=1788240048;
 b=tTgCxtIvAsNhhwcFoegrDRwkL7cj1ejHSamQ3OqRxx3Wa9YADlgwVAbc3tyA7E2sWpB/9gNf
 KYSQNNSUxhKUR3LRHoCHCumA53KOgtjGvX1E+oEgRZQ9JycaxoEkU5SSrGZGS15yd0xusNF1Jxm
 Ze2JBPUjNz/jL/3p4SYFMOuU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 9f60c523c4f772b1;
	Tue, 25 Aug 2026 05:20:48 +0000
X-Mizu-Trace-ID: 9f60c523c4f772b1
X-Migadu-Flow: FLOW_OUT
Message-ID: <b53c61a1-4d7d-4232-941f-d48b0563d4ed@linux.dev>
Date: Tue, 25 Aug 2026 13:20:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, changwoo@igalia.com, suzhidao@xiaomi.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v3 2/2] sched_ext: rename tg->scx.idle to
 tg->scx.sched_idle
To: tj@kernel.org, void@manifault.com, arighi@nvidia.com
References: <20260825023557.27881-1-cui.tao@linux.dev>
 <20260825023557.27881-3-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260825023557.27881-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

在 2026/8/25 10:35, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> A bare "idle" reads as CPU idle state in sched_ext (ops.update_idle(),
> idle cpumasks, scx_bpf_pick_idle_cpu()). cpu.idle is the cgroup analog
> of the SCHED_IDLE policy, so name the task_group field sched_idle to
> match scx_cgroup_init_args.sched_idle.
> 
> Pure rename, no behavior change.
> 

While testing this series, I noticed that scx_group_set_idle() delivers
ops.cgroup_set_idle() on every successful cpu.idle write, even rewrites
of the current value, although the kerneldoc says the callback is
invoked on transitions. scx_group_set_weight() and
scx_group_set_bandwidth() both skip unchanged values, so this seems
like an oversight.

The fix is a one-line guard, but it reads the field renamed here, so
I'll post it on top of this series once it lands.

Thanks,
Tao

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  include/linux/sched/ext.h | 2 +-
>  kernel/sched/ext/ext.c    | 8 ++++----
>  kernel/sched/ext/sub.c    | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 582d7cd4a983..7b9cdb65deef 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -323,7 +323,7 @@ struct scx_task_group {
>  	u64			bw_period_us;
>  	u64			bw_quota_us;
>  	u64			bw_burst_us;
> -	bool			idle;
> +	bool			sched_idle;
>  #endif
>  };
>  
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 82cf8f57e15c..4a9c38297093 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4682,7 +4682,7 @@ void scx_tg_init(struct task_group *tg)
>  	tg->scx.weight = CGROUP_WEIGHT_DFL;
>  	tg->scx.bw_period_us = default_bw_period_us();
>  	tg->scx.bw_quota_us = RUNTIME_INF;
> -	tg->scx.idle = false;
> +	tg->scx.sched_idle = false;
>  }
>  
>  /**
> @@ -4765,7 +4765,7 @@ int scx_tg_online(struct task_group *tg)
>  				  .bw_period_us = tg->scx.bw_period_us,
>  				  .bw_quota_us = tg->scx.bw_quota_us,
>  				  .bw_burst_us = tg->scx.bw_burst_us,
> -				  .sched_idle = tg->scx.idle };
> +				  .sched_idle = tg->scx.sched_idle };
>  
>  			ret = SCX_CALL_OP_RET(sch, cgroup_init,
>  					      NULL, tg->css.cgroup, &args);
> @@ -4935,7 +4935,7 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
>  		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
>  
>  	/* Update the task group's idle state */
> -	tg->scx.idle = idle;
> +	tg->scx.sched_idle = idle;
>  
>  	percpu_up_read(&scx_cgroup_ops_rwsem);
>  }
> @@ -5186,7 +5186,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
>  				.bw_period_us = tg->scx.bw_period_us,
>  				.bw_quota_us = tg->scx.bw_quota_us,
>  				.bw_burst_us = tg->scx.bw_burst_us,
> -				.sched_idle = tg->scx.idle,
> +				.sched_idle = tg->scx.sched_idle,
>  			};
>  
>  			ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL, css->cgroup, &args);
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 385302d19914..a17d84db93bd 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1361,7 +1361,7 @@ static s32 scx_cgroup_claim_subtree(struct scx_sched *sch)
>  			.bw_period_us = tg->scx.bw_period_us,
>  			.bw_quota_us = tg->scx.bw_quota_us,
>  			.bw_burst_us = tg->scx.bw_burst_us,
> -			.sched_idle = tg->scx.idle,
> +			.sched_idle = tg->scx.sched_idle,
>  		};
>  
>  		if (tg->scx.sched != parent ||
> @@ -1465,7 +1465,7 @@ static void scx_cgroup_return_subtree(struct scx_sched *sch)
>  			.bw_period_us = tg->scx.bw_period_us,
>  			.bw_quota_us = tg->scx.bw_quota_us,
>  			.bw_burst_us = tg->scx.bw_burst_us,
> -			.sched_idle = tg->scx.idle,
> +			.sched_idle = tg->scx.sched_idle,
>  		};
>  
>  		/* the first pass must have transferred everything */

