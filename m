Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761842;
	b=U5DXUmtvz5IKPxwzIsCFjnw9R3aO6asU8e22p/dGXnNu0XnTIsr/Ws6spoJEjXDYHan/
	 cY1Qe4MluLx5n/KeotLoG/EDnof6oHGUI8u0ISqLEadHQbH+NToqf6KUV5fQps7ESwc7c
	 yPZbrbrS4f6PoWxxjNvEVPvqJzGubC1SBa9cqoKDRaYXS03+I7xFrR6FMOZ2ut05hO1xa
	 Lyq+1NANQ5LeeUr0bZZYpPM0q1/7CBPGY+jNo48s2B/oRUgkSOpNysZOV/jeMl/YOasm6
	 XidfGFU9mnrYPltsWPpjBT/vk4dvRdOkn6ux7W1x7rVHVd0G/pdP4Glvb6kDrSt4Scw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761842;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/FRJJdL6CQMwvtZFodOraQbPi4+U/oruI+Lr854GPHk=;
	b=mkYEezurQw6Qg8f+N2PYhVimIvNvBY0ZZldRhQwv26nGP+0OWP7dAUtfGj/f/0MY2HUF
	 tEkJQNMG1mkuE6smnFjp6v6y8Al+JKulwVe5h3WQmivRbUCQUhplRwdkHP5xFLQjwEguw
	 TB99Y1Dxqhai5quieo9aDjQScdIIZ379age/kiQBwC8XwNv77RcGUecWeTcEKXsdCF8Td
	 l9JpwxcUMYfyhSjCWZYyQ8uTHgr/Vwm8Uls36vOwr6A4Pst3SUDcMgRMyJEHi6SFhApnf
	 qz8ztS6lYFrfQ+7h84aE1kc7Z4LplpSb5F/yq42ghQMSnIFX5ijQ7J89+uor7mCJWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JVDBLKx6;
	arc=none smtp.remote-ip=95.215.58.26
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC66606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEC66606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JVDBLKx6
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WLjcs1BuslCa+sXmCi3MWXmmtwqrhEu+vc6c5YnF6PY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793761839; v=1; x=1794366639;
 b=JVDBLKx6Gkk3LD8v/vkzLpSpUPVF9R7xj9EB0b3shvo0xeMAis+xkHdIaGvoC/TRPglYxciR
 ZLNB2liRatBHSQhEvX0BOFoCPVcXwPd04rwq43lIU97m3pQI7KDnDoz6aC6yum01cmBy6JUpJAq
 IemJFZeMyUVZpENPgEnJ4ABg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ff8335f15ee4639e;
	Wed, 04 Nov 2026 03:10:26 +0000
X-Mizu-Trace-ID: ff8335f15ee4639e
X-Migadu-Flow: FLOW_OUT
Message-ID: <c3b1989e-5421-4933-837d-e52ff259eb93@linux.dev>
Date: Wed, 4 Nov 2026 11:10:18 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, bpf@vger.kernel.org, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Subject: Re: [RFC PATCH v12 1/4] blk-iocost: add BPF struct_ops cost model
 support
To: sashiko-reviews@lists.linux.dev
References: <20261103132613.1952975-1-cui.tao@linux.dev>
 <20261103132613.1952975-2-cui.tao@linux.dev>
 <sashiko-outbox-195400@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <sashiko-outbox-195400@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

在 2026/11/3 21:51, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] blk-iocost: lock order inversion between queue freeze and rq_qos_mutex
This was discussed in the v10 round. The attach/detach order in
this series matches ioc_qos_write(). The reverse order in
ioc_cost_model_write() predates this series. Tejun's conclusion
at the time was:

> The attach and detach order matches ioc_qos_write().
> The reverse order in ioc_cost_model_write() predates this series
> and is better fixed separately. An earlier attempt to convert it
> ran into blk_iocost_init()'s percpu allocation under the freeze.

https://lore.kernel.org/all/aV5OwAvw1sRF1IW1@fedora/

So I don't think this is a regression introduced by this series.
The pre-existing ordering issue should be addressed separately.

> - [Medium] blk-iocost: stale autop timestamps across model attach/detach
Confirmed. While a model is attached, ioc_autop_idx() returns early,
leaving the timestamps at their pre-attach values. As a result, the
first evaluation after detach can exceed AUTOP_CYCLE_NSEC immediately.

I'll clear both timestamps in ioc_detach_model() so the cooldown
restarts fresh on detach. The io.cost.model write path already resets
them through its forced refresh when switching between models, so
crossing evidence collected while a BPF model drives vrate won't
affect builtin profile stepping.

Thanks,
Tao
> --
> 
> commit 145ca796c6aa0e9492a94bdce49377cc07f92750
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> blk-iocost: add BPF struct_ops cost model support
> 
> This commit adds BPF struct_ops support (iocost_model_ops) to blk-iocost so
> a BPF program can calculate per-bio vtime costs and provide page transfer
> coefficients for a target block device. It also extends io.cost.model to
> switch between the linear and attached BPF cost models while suspending
> ctrl=auto profile stepping when a BPF model is active.
> 
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index a81488c755cab..0f9c695b685af 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
> 
> [ ... ]
> 
>> @@ -806,7 +844,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
>>  		return AUTOP_SSD_DFL;
>>  
>>  	/* if user is overriding anything, maintain what was there */
>> -	if (ioc->user_qos_params || ioc->user_cost_model)
>> +	if (ioc->user_qos_params || ioc->user_cost_model || ioc_model(ioc))
>>  		return idx;
>>  
>>  	/* step up/down based on the vrate */
> 
> [ ... ]
> 
>> @@ -2908,10 +2968,33 @@ static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
>>  	spin_unlock_irq(&ioc->lock);
>>  }
>>  
>> +/* Called by .unreg and by device removal, whichever is first. */
>> +static void ioc_detach_model(struct ioc *ioc)
>> +{
>> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
>> +	const struct iocost_model_ops *ops = ioc->attached;
>> +
>> +	lockdep_assert_held(&ioc->rqos.disk->queue->rq_qos_mutex);
>> +
>> +	if (!ops)
>> +		return;
>> +
>> +	spin_lock_irq(&ioc->lock);
>> +	rcu_assign_pointer(ioc->model, NULL);
>> +	ioc->attached = NULL;
>> +	ioc->attached_link = NULL;
>> +	spin_unlock_irq(&ioc->lock);
> 
> [Severity: Medium]
> When ctrl=auto is active under the builtin linear model and vrate_pct crosses
> too_fast_vrate_pct or too_slow_vrate_pct in ioc_autop_idx(), the current
> timestamp is recorded in ioc->autop_too_fast_at or ioc->autop_too_slow_at,
> requiring AUTOP_CYCLE_NSEC (10 seconds) of sustained condition before stepping
> ioc->autop_idx.
> 
> When a BPF model is attached in ioc_bpf_reg() and later detached in
> ioc_detach_model(), ioc->model is updated without calling
> ioc_refresh_params(ioc, true) or clearing ioc->autop_too_fast_at and
> ioc->autop_too_slow_at, unlike ioc_cost_model_write() and ioc_qos_write():
> 
> block/blk-iocost.c:ioc_refresh_params_disk() {
>     ...
> 	idx = ioc_autop_idx(ioc, disk);
> 	p = &autop[idx];
> 
> 	if (idx == ioc->autop_idx && !force)
> 		return false;
>     ...
> 	ioc->autop_idx = idx;
> 	ioc->autop_too_fast_at = 0;
> 	ioc->autop_too_slow_at = 0;
>     ...
> }
> 
> While the BPF model is active, ioc_autop_idx() returns idx early at the
> ioc_model(ioc) check before reaching the timestamp update and reset logic, and
> ioc_refresh_params_disk(ioc, false, disk) returns false early because
> idx == ioc->autop_idx, leaving any pre-attachment timestamp in
> ioc->autop_too_fast_at or ioc->autop_too_slow_at intact.
> 
> Once the BPF model is detached via ioc_bpf_unreg() -> ioc_detach_model(), on
> the first timer tick (ioc_timer_fn() -> ioc_refresh_params(ioc, false) ->
> ioc_autop_idx()), if vrate_pct is past the threshold,
> now_ns - ioc->autop_too_fast_at (or autop_too_slow_at) includes the entire
> time the BPF model was attached.
> 
> Could this cause ioc_autop_idx() to immediately exceed AUTOP_CYCLE_NSEC and
> step ioc->autop_idx (resetting vtime_rate) on the first tick after detach
> instead of waiting for a full AUTOP_CYCLE_NSEC cycle? Should ioc_bpf_reg() and
> ioc_detach_model() reset the autop timestamps or call
> ioc_refresh_params(ioc, true) under ioc->lock?
> 
> [ ... ]
> 
>> @@ -3559,7 +3644,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>  			continue;
>>  		case COST_MODEL:
>>  			match_strlcpy(buf, &args[0], sizeof(buf));
>> -			if (strcmp(buf, "linear"))
>> +			if (!strcmp(buf, "linear"))
>> +				model = NULL;
>> +			else if (!strcmp(buf, "bpf") && ioc->attached)
>> +				model = ioc->attached;
>> +			else
>>  				goto unlock;
>>  			continue;
>>  		}
>> @@ -3579,6 +3668,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>  	} else {
>>  		ioc->user_cost_model = false;
>>  	}
>> +	rcu_assign_pointer(ioc->model, model);
>>  	ioc_refresh_params(ioc, true);
>>  
>>  	ret = 0;
>> @@ -3626,6 +3716,166 @@ static struct blkcg_policy blkcg_policy_iocost = {
>>  	.pd_stat_fn	= ioc_pd_stat,
>>  };
>>  
>> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
>> +static int ioc_bpf_reg(void *kdata, struct bpf_link *link)
>> +{
>> +	struct iocost_model_ops *ops = kdata;
>> +	struct block_device *bdev;
>> +	struct request_queue *q;
>> +	unsigned int memflags;
>> +	struct ioc *ioc;
>> +	int ret;
>> +
>> +	bdev = blkdev_get_no_open(new_decode_dev(ops->dev), false);
>> +	if (!bdev)
>> +		return -ENODEV;
>> +
>> +	q = bdev_get_queue(bdev);
>> +	if (bdev_is_partition(bdev) || !queue_is_mq(q)) {
>> +		blkdev_put_no_open(bdev);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	/* the order of ioc_qos_write() */
>> +	memflags = blk_mq_freeze_queue(q);
>> +	mutex_lock(&q->rq_qos_mutex);
> 
> [Severity: High]
> In ioc_bpf_reg(), blk_mq_freeze_queue(q) is called before acquiring
> q->rq_qos_mutex, which establishes the lock order:
> 
>   q->io_lockdep_map -> q->q_lockdep_map -> q->rq_qos_mutex
> 
> However, in ioc_cost_model_write() (which is used to toggle between
> model=linear and model=bpf), blkg_conf_open_bdev(&ctx) acquires
> q->rq_qos_mutex first, and unlike ioc_qos_write(), ioc_cost_model_write() does
> not drop q->rq_qos_mutex before calling blk_iocost_init() and
> blk_mq_freeze_queue(q):
> 
> block/blk-iocost.c:ioc_cost_model_write() {
> 	blkg_conf_init(&ctx, input);
> 
> 	ret = blkg_conf_open_bdev(&ctx); // locks q->rq_qos_mutex
> 	if (ret)
> 		return ret;
>     ...
> 	ioc = q_to_ioc(q);
> 	if (!ioc) {
> 		ret = blk_iocost_init(ctx.bdev->bd_disk);
> 		if (ret)
> 			goto close_bdev;
> 		ioc = q_to_ioc(q);
> 	}
> 
> 	memflags = blk_mq_freeze_queue(q); // locks q->io_lockdep_map -> q->q_lockdep_map
>     ...
> }
> 
> This establishes the opposite lock order in ioc_cost_model_write():
> 
>   q->rq_qos_mutex -> q->io_lockdep_map -> q->q_lockdep_map
> 
> In addition, paths that hold q->rq_qos_mutex without freezing the queue first
> (such as ioc_cost_model_write() -> blk_iocost_init() and ioc_weight_write() ->
> blkg_conf_prep()) perform GFP_KERNEL allocations under q->rq_qos_mutex without
> memalloc_noio_save(), which can enter fs_reclaim and wait on a frozen queue.
> 
> Can attaching a BPF model via ioc_bpf_reg() and writing to io.cost.model via
> ioc_cost_model_write() trigger a lockdep circular locking dependency splat or
> an ABBA deadlock between queue freeze and q->rq_qos_mutex? Should
> ioc_cost_model_write() release and re-acquire q->rq_qos_mutex around
> blk_mq_freeze_queue(q) the same way ioc_qos_write() does?
> 

