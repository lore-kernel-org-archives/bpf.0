Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963A3C1D53
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638991; cv=none; b=tO2dmV6pL/XZso8Dztov5zSrnlDZHX/fis+43p2+5zNFzsEQFznRH2nslGtm2ZXGf7gLVeA20v6forzwQ6zpVEbt1hZTIMfvS3/xEPsijAtgNTrKiqwSJhWvrtQlMPEWfyHEgex2xxvGaF/ay6RR2Z4ZcuMq3oRbbNY111xNSSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638991; c=relaxed/simple;
	bh=6q7j5Ff4GbGeQY3dCFVc6z7uFHjXuAyD8kY5kMwE+iI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mwn6pV6FH/ZkKVQ1gW9QNT5Le93nz0cxGMQGtq5mCtxmJtzQqqECEA8HxzF2tM3b5T2izasCgJas25Hu6BMY2a6ukoas8z6cl9vD4WE+ble6c682ywzSxGTwWl/ZFaxzkkNEPolfXej7s0imnKZK25ft4ytrifb8zYzeJT/GPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FX/qktNc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FX/qktNc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6q7j5Ff4GbGeQY3dCFVc6z7uFHjXuAyD8kY5kMwE+iI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787638986; v=1; x=1788243786;
 b=FX/qktNc1rxa0BtGahLxT/kqHJmLDTq1SSQIoXwHxnV46HknR+oUH/fMdn8rNnqtocrwb8K0
 nMu3WzMQ5SOmgpDFh1haBn6lAIBDJuRBPPZro0a1rdrsWDmXfs9dr5Oxf15i0cikMznetoN1VHZ
 nML/3SCMeynmqENefgUNrfdY=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 3176caf5f8563946;
	Tue, 25 Aug 2026 06:22:56 +0000
X-Mizu-Trace-ID: 3176caf5f8563946
X-Migadu-Flow: FLOW_OUT
Message-ID: <42b9aed5-15aa-47da-897a-0c966ffbd59a@linux.dev>
Date: Tue, 25 Aug 2026 14:22:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, sched-ext@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Allow ops.cgroup_set_weight/idle() to be
 sleepable
To: sashiko-reviews@lists.linux.dev
References: <20260825052336.46746-1-cui.tao@linux.dev>
 <20260825053648.EF7D41F000E9@smtp.kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260825053648.EF7D41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

在 2026/8/25 13:36, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Concurrent cgroup writes to `cpu.weight`, `cpu.shares`, or `cpu.idle` can permanently desynchronize the core scheduler and BPF scheduler state, and cause data races on SCX fields.
> --
> 
> --- Patch [1]: [PATCH] sched_ext: Allow ops.cgroup_set_weight/idle() to be sleepable ---
> commit 1a01a0e2918fcf8ca79c6152b56ecfa3e223935c
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> sched_ext: Allow ops.cgroup_set_weight/idle() to be sleepable
> 
> ops.cgroup_set_weight() and ops.cgroup_set_idle() are delivered from
> scx_group_set_weight() and scx_group_set_idle(), which run from the
> cpu.weight and cpu.idle cgroup interface write paths. This patch adds
> them to the allow-list so these callbacks can allocate on demand.
> 
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index c539d15cda637..dd4ecc0b5201d 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -8079,7 +8079,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
>>  	case offsetof(struct sched_ext_ops, cgroup_init):
>>  	case offsetof(struct sched_ext_ops, cgroup_exit):
>>  	case offsetof(struct sched_ext_ops, cgroup_prep_move):
>> +	case offsetof(struct sched_ext_ops, cgroup_set_weight):
>>  	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):
>> +	case offsetof(struct sched_ext_ops, cgroup_set_idle):
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does making these operations
> sleepable widen a race condition where concurrent cgroup writes could
> permanently desynchronize the core scheduler and BPF scheduler state?
> 
> Looking at kernel/sched/core.c:cpu_weight_write_u64(), the core scheduler is
> updated inside sched_group_set_shares() (which takes and drops shares_mutex),
> leaving a gap before the BPF scheduler is updated:
> 
> kernel/sched/core.c:cpu_weight_write_u64() {
>     ...
> 	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
> 	if (!ret)
> 		scx_group_set_weight(css_tg(css), cgrp_weight);
>     ...
> }
> 
> Inside scx_group_set_weight(), the SCX scheduler state and tg->scx.weight
> are updated without serialization (holding only a read lock):
> 
> kernel/sched/ext/ext.c:scx_group_set_weight() {
>     ...
> 	SCX_CALL_OP(sch, cgroup_set_weight, NULL, tg_cgrp(tg), weight);
> 
> 	tg->scx.weight = weight;
>     ...
> }
> 
> The same pattern exists in kernel/sched/core.c:cpu_idle_write_s64() calling
> scx_group_set_idle() and updating tg->scx.idle.
> 
> If two threads concurrently write to cpu.weight or cpu.idle, they serialize on
> shares_mutex but drop it before calling the SCX functions. Because this patch
> allows ops.cgroup_set_weight and ops.cgroup_set_idle to sleep, could the
> threads execute out of order? 
> 
> If Thread B's core scheduler update runs after Thread A's, but Thread B's BPF
> callback finishes before Thread A's, the final state in the core scheduler
> would be B, while the SCX state ends up as A. Can this lead to incorrect
> functional behavior and data races on tg->scx.weight and tg->scx.idle?
> 

That race is pre-existing: the window between
sched_group_set_shares() dropping its lock and scx_group_set_weight()
running is unserialized even without a sleepable callback. Making
the callbacks sleepable only widens the window.

Michal's "Lift cgroup update locking to core to prevent CFS/SCX
divergence" series covers both updates with core-side locking and
fixes it, so this patch doesn't grow a fix for it.

Thanks.

>>  #endif
>>  	case offsetof(struct sched_ext_ops, cpu_online):
> 
> [ ... ]
> 

