Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743372C11E6
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786772644; cv=none; b=DCCEth2LBbsAgUyDWHgdWmQr/qakm8quvF3B5zytkczStPCsnUcGbrWjbN3F9iqHbkSizcPArdMv0+8EST//Ptv208TLjYOTMQFufwKWvblFwKPKt+KYH589GW5lIFC75mbqUDO8lfzBwAx5JPLrLNTxQEGqCcE6iZSRjL4iyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786772644; c=relaxed/simple;
	bh=8M2PINbWuHVRS4IFw+NHAtUDhE/+9smDV7B8yZAgwxA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E1nSPJeuCxn9SJlW1Tn0sz2UT31HX4rj0tZOlShE/hSYm3+HbBw3sYxbu1YW2SchMCl2KPvpd3rcvOacD/C373Sspk7aKNqs/osXixh4MwWT+PWxN6VnPvPT9FWh1tyAau0zFG/r19gZwAXbB9HMXtqAdJA9GQaeVyyIpX3Wyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oIUE/E+4; arc=none smtp.client-ip=95.215.58.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oIUE/E+4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8M2PINbWuHVRS4IFw+NHAtUDhE/+9smDV7B8yZAgwxA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786772639; v=1; x=1787377439;
 b=oIUE/E+41UTPLWEQIou6EH7Nvah0vJuVuQiLCXubsNQuiyphTIyC0Ifx4Bs3zUQoCAcgCUAG
 jS7wzG9el4kubeMaUFcnV5gaa5+xgaXJL0HqNVqIW0d+cn5T4/rXiyTouGF8wzy0pvoRTK0Nig/
 bz1L4mAV3Wc5FpJ6I1naSiQc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id c2923518412e5bae;
	Sat, 15 Aug 2026 05:43:59 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <68283707-192f-41d8-a3f2-f38386622aeb@linux.dev>
Date: Sat, 15 Aug 2026 13:43:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, sched-ext@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Don't BUG_ON a destroyed DSQ in
 process_deferred_reenq_users
To: sashiko-reviews@lists.linux.dev
References: <20260815022017.3305427-1-cui.tao@linux.dev>
 <20260815023458.C97F81F000E9@smtp.kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260815023458.C97F81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/15 10:34, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Lockless double-read of `dsq->id` creates a Time-Of-Check to Time-Of-Use (TOCTOU) race that can still falsely trigger the `BUG_ON`, crashing the kernel.
> 
> Pre-existing issues:
> - [Critical] Dereferencing `dsq->id` in `process_deferred_reenq_users()` causes a Use-After-Free because an RCU grace period can complete while the target CPU is idle, freeing `dsq` before it is accessed.
> --
> 
> --- Patch [1]: [PATCH v2] sched_ext: Don't BUG_ON a destroyed DSQ in process_deferred_reenq_users ---
> commit f1934b9161ead6ceeb2cb6d00c64a01e1a233104
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> sched_ext: Don't BUG_ON a destroyed DSQ in process_deferred_reenq_users
> 
> This commit attempts to fix a BUG_ON triggered when process_deferred_reenq_users()
> encounters a destroyed DSQ. It adds a check to skip processing if the DSQ ID 
> has been set to SCX_DSQ_INVALID.
> 
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index 18183062f751c..1a059e5f09e80 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -4332,6 +4332,10 @@ static void process_deferred_reenq_users(struct rq *rq)
>>  		/* see schedule_dsq_reenq() */
>>  		smp_mb();
>>  
>> +		/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq */
> 
> [Severity: Critical]
> This is a pre-existing issue, but does dereferencing dsq->id here outside of
> the rq->scx.deferred_reenq_lock critical section expose the pointer to a
> concurrent kfree() in the RCU teardown path?
> 
> If CPU B is idle (in an RCU Extended Quiescent State), and CPU A queues a
> deferred reenq for a DSQ to CPU B and calls destroy_dsq(), the RCU grace
> period can end immediately without waiting for CPU B. The RCU callback
> free_dsq_rcufn then runs on CPU C and calls exit_dsq().
> 
> Concurrently, if CPU B wakes up, enters process_deferred_reenq_users(),
> removes dru from the list, and drops the lock:
> 
> CPU B:
> scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
> 	...
> 	list_del_init(&dru->node);
> }
> // CPU B is now at the dsq->id check
> 
> CPU C's exit_dsq() then evaluates the list without locks:
> 
> CPU C:
> exit_dsq() {
> 	...
> 	if (WARN_ON_ONCE(!list_empty(&dru->node))) {
> 		// Skips lock because list is empty
> 	}
> 	...
> 	kfree(dsq);
> }
> 
> Would CPU B then read from the freed dsq memory when checking dsq->id?
> 
I think this one doesn't exist. schedule_dsq_reenq() queues the dru on the inserting CPU's own rq (rq = this_rq()), not on a remote CPU, and process_deferred_reenq_users() runs with rq->lock held, so the CPU cannot pass through a quiescent state between dequeuing the dru and reading dsq->id. A grace period cannot complete underneath it. The residual case where the dru is never processed is what the WARN and forced delete in exit_dsq() cover.
>> +		if (unlikely(dsq->id == SCX_DSQ_INVALID))
>> +			continue;
>> +
>>  		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
> 
> [Severity: High]
> Because dsq->id is accessed twice consecutively without READ_ONCE(), can
> the compiler emit two separate memory loads?
> 
> If a concurrent destroy_dsq() sets dsq->id = SCX_DSQ_INVALID exactly
> between the two loads, the first load would see a valid user DSQ ID and
> bypass the continue. The second load would then observe SCX_DSQ_INVALID.
> 
> Since SCX_DSQ_INVALID evaluates to true for SCX_DSQ_FLAG_BUILTIN,
> wouldn't this still trigger the BUG_ON?
> 
Fair in theory. The two loads are adjacent and will be merged by the compiler in practice, but folding them into a single READ_ONCE() would close it for good. Happy to do that in a follow-up.
>>  		reenq_user(rq, dsq, reenq_flags);
>>  	}
> 

