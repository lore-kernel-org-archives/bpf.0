Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B530C60F
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790997360; cv=none; b=CtUf1fbauax9/oLmrNYk2fsIYM6vxHhpwbZ/p08W0IfCoNOl5VYQ9A05QAo7bllBaWnwID+EzLD/fsYuNrD3UROPjT/ylLbbEBW7Q4m+c4VhjJtx55Gu8MWcfN8+AEYpaUx2HIQY6v74InF7x+mOsrXvuMX9zdbtkj/9giRx1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790997360; c=relaxed/simple;
	bh=yihSlxuUpgPUsTg3JVzj5YPw0phRzOPn+y4aih8THPY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TlwHd+Tl5Ap5u5hf5kBD0yZOlKzAUWOI06rcncL/nywY50pIctdHzxf+9DCP6X2tHtuJ78PRdYbA0+h6ZL48tTIohVoBdxrPTthCpehVxYQu8KwxaO6vQ1czdQ8IDwFmRvLA5TueV0A7z40jUJC5jfbxiLre+NxNyV2YQTipz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Or1OjZMo; arc=none smtp.client-ip=95.215.58.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Or1OjZMo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yihSlxuUpgPUsTg3JVzj5YPw0phRzOPn+y4aih8THPY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790997355; v=1; x=1791602155;
 b=Or1OjZMoIzS12C+mStuqmfIWgbW6HjG2MjXBBfL4kWWsqmoWytj6UDLZCbVyiSZuPnKbwF5n
 oEueMyqRM1tG/wwFpX3v68fRO736o+rGTpDA5YI4HbyRQGlGLr8rgyGqn6xcKY2yAeLyux9cRnu
 0swFulrqh7xrdx+U985Tk//I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7a91b6cb695afc3;
	Sat, 03 Oct 2026 03:15:55 +0000
X-Mizu-Trace-ID: e7a91b6cb695afc3
X-Migadu-Flow: FLOW_OUT
Date: Sat, 03 Oct 2026 11:15:49 +0800
From: Tao Cui <cui.tao@linux.dev>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: tj@kernel.org, mkoutny@suse.com, bpf@vger.kernel.org, hannes@cmpxchg.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v9_1/4=5D_blk-iocost=3A_a?=
 =?US-ASCII?Q?dd_BPF_struct=5Fops_cost_model_support?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261003015208.1D9261F000FF@smtp.kernel.org>
References: <20261003013033.149288-1-cui.tao@linux.dev> <20261003013033.149288-2-cui.tao@linux.dev> <20261003015208.1D9261F000FF@smtp.kernel.org>
Message-ID: <EE538304-41BD-4844-973F-6E97F44BBE52@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E4=BA=8E 2026=E5=B9=B410=E6=9C=883=E6=97=A5 GMT+08:00 09:52:07=EF=BC=8Csa=
shiko-bot@kernel=2Eorg =E5=86=99=E9=81=93=EF=BC=9A
>Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>- [Critical] bpf: UAF on ioc in ioc_bpf_detach due to lockless fetch befo=
re freeze
>- [Critical] bpf: UAF on struct_ops map due to concurrent modification of=
 ops->q
>- [High] bpf: TOCTOU race in ioc_bpf_detach reading ops->q leads to UAF o=
n queue
>- [High] bpf: ioc_bpf_detach fails to verify ops->link causes cross-link =
teardown

Thank you for catching these issues=2E
I've noted all the reported UAF and TOCTOU races and am working on fixes=
=2E

>--
>
>commit d8ef9c16531866711abee0afcce05f21400897b9
>Author: Tao Cui <cui=2Etao@linux=2Edev>
>Subject: blk-iocost: add BPF struct_ops cost model support
>
>This patch adds BPF struct_ops support to blk-iocost, allowing BPF
>programs to provide custom IO pricing models=2E The struct_ops is attache=
d
>per-device and replaces the built-in linear model for IO cost
>calculations=2E
>
>> diff --git a/block/blk-iocost=2Ec b/block/blk-iocost=2Ec
>> index 2745bffcd5eef=2E=2E581b485434411 100644
>> --- a/block/blk-iocost=2Ec
>> +++ b/block/blk-iocost=2Ec
>
>[ =2E=2E=2E ]
>
>> @@ -2888,6 +2959,45 @@ static void ioc_rqos_queue_depth_changed(struct =
rq_qos *rqos)
>>  	spin_unlock_irq(&ioc->lock);
>>  }
>> =20
>> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
>> +/*
>> + * Eject the model on device removal=2E  The caller holds rq_qos_mutex
>> + * and blkcg_deactivate_policy() has already run, so every existing
>> + * blkg got iocg_free() from ioc_pd_free() and no walk is needed=2E
>> + *
>> + * bdev is read into a local before ops->q is cleared: once q is
>> + * NULL, =2Eunreg returns without taking any lock and the map holding
>> + * ops can be freed, so ops must not be touched afterwards=2E
>> + */
>> +static void ioc_bpf_eject(struct ioc *ioc)
>> +{
>> +	struct request_queue *q =3D ioc->rqos=2Edisk->queue;
>> +	struct iocost_model_ops *ops;
>> +	struct block_device *bdev;
>> +
>> +	spin_lock_irq(&q->queue_lock);
>> +	spin_lock(&ioc->lock);
>> +	ops =3D (struct iocost_model_ops *)rcu_dereference_protected(
>> +			ioc->attached, lockdep_is_held(&ioc->lock));
>> +	if (!ops) {
>> +		spin_unlock(&ioc->lock);
>> +		spin_unlock_irq(&q->queue_lock);
>> +		return;
>> +	}
>> +	bdev =3D ops->bdev;
>> +	rcu_assign_pointer(ioc->attached, NULL);
>> +	rcu_assign_pointer(ioc->model, NULL);
>> +	spin_unlock(&ioc->lock);
>> +	WRITE_ONCE(ops->q, NULL);
>
>[Severity: Critical]
>Is it possible for this ejection to clear ops->q when the map has been
>re-attached to a different queue?
>
>If a user attaches the same struct_ops map to multiple devices, ops->q ge=
ts
>overwritten=2E If the first device is then removed, ioc_bpf_eject() clear=
s
>ops->q=2E This can cause subsequent unreg operations for other active lin=
ks
>to fail to detach the map, resulting in a use-after-free when the map is
>freed but the surviving queues still use it=2E
>
>> +	WRITE_ONCE(ops->link, NULL);
>> +	spin_unlock_irq(&q->queue_lock);
>> +
>> +	blkdev_put_no_open(bdev);
>> +}
>
>[ =2E=2E=2E ]
>
>> +int ioc_bpf_attach(struct iocost_model_ops *ops, struct bpf_link *link=
)
>> +{
>> +	struct block_device *bdev;
>> +	struct request_queue *q;
>
>[ =2E=2E=2E ]
>
>> +	rcu_assign_pointer(ioc->attached, ops);
>> +	rcu_assign_pointer(ioc->model, ops);
>> +	spin_unlock(&ioc->lock);
>> +
>> +	ops->bdev =3D bdev;
>> +	WRITE_ONCE(ops->link, link);
>> +	WRITE_ONCE(ops->q, q);
>
>[Severity: Critical]
>Does this allow concurrent modification of the shared ops state?
>
>ops->q is only protected by the target queue's queue_lock=2E If the same =
map
>is attached to multiple queues, this will clobber ops->q, setting up the
>ejection bug mentioned above=2E
>
>> +
>> +	/* pair iocg_init() with the cgroups which already exist */
>> +	ioc_bpf_walk_iocgs(ioc, ops, true);
>> +
>> +	spin_unlock_irq(&q->queue_lock);
>> +	mutex_unlock(&q->blkcg_mutex);
>
>[ =2E=2E=2E ]
>
>> +/*
>> + * Detach a model: switch back to the builtin model when the attached
>> + * model is in use, clear the attachment, and deliver iocg_free() to
>> + * the cgroups which still exist, under the same freeze and quiesce as
>> + * the attach=2E  The caller has already checked ops->q=2E
>> + */
>> +void ioc_bpf_detach(struct iocost_model_ops *ops, struct bpf_link *lin=
k)
>> +{
>> +	struct request_queue *q =3D READ_ONCE(ops->q);
>
>[Severity: High]
>Does re-reading ops->q here introduce a TOCTOU race?
>
>In bpf_iocost_unreg(), a queue reference is correctly secured using
>blk_get_queue_rcu(q)=2E However, the queue is re-read here=2E If a concur=
rent
>attach overwrites ops->q before this read, the code will operate on a
>different, unreferenced queue=2E This can lead to a use-after-free when
>calling blk_mq_freeze_queue() if the new queue is concurrently destroyed=
=2E
>
>> +	struct block_device *bdev;
>> +	struct ioc *ioc;
>> +	unsigned int memflags;
>> +
>> +	if (!q)
>> +		return;
>> +	ioc =3D q_to_ioc(q);
>
>[Severity: Critical]
>Can this lockless fetch of ioc lead to a use-after-free?
>
>The ioc pointer is fetched here without securing an independent reference=
=2E
>When the function blocks on blk_mq_freeze_queue(q) directly below, a
>concurrent device hot-unplug (e=2Eg=2E del_gendisk) can run rq_qos_exit()=
 and
>free the ioc struct=2E=20
>
>When this thread resumes, the later spin_lock(&ioc->lock) would dereferen=
ce
>the freed ioc pointer=2E
>
>> +	if (!ioc)
>> +		return;
>> +
>> +	bdev =3D ops->bdev;
>> +
>> +	/*
>> +	 * the freeze is taken before rq_qos_mutex like in the attach;
>> +	 * the link is re-checked under the mutex below, as the ejection
>> +	 * or a newer attachment may have won the race meanwhile
>> +	 */
>> +	memflags =3D blk_mq_freeze_queue(q);
>> +	blk_mq_quiesce_queue(q);
>> +
>> +	mutex_lock(&q->rq_qos_mutex);
>> +
>> +	mutex_lock(&q->blkcg_mutex);
>> +	spin_lock_irq(&q->queue_lock);
>> +
>> +	spin_lock(&ioc->lock);
>> +	if (rcu_dereference_protected(ioc->attached,
>> +				      lockdep_is_held(&ioc->lock)) !=3D ops) {
>
>[Severity: High]
>Is there a missing check to verify the link argument here?
>
>ioc_bpf_detach() is passed a link pointer but never validates it against
>READ_ONCE(ops->link)=2E If the same map was attached to another queue via
>a new link, closing the old link could cause this function to mistakenly
>tear down the new link's attachment, leaving the intended link orphaned=
=2E
>
>> +		/* the ejection or a newer link won; nothing to detach */
>> +		spin_unlock(&ioc->lock);
>> +		spin_unlock_irq(&q->queue_lock);
>> +		mutex_unlock(&q->blkcg_mutex);
>> +		mutex_unlock(&q->rq_qos_mutex);
>> +		blk_mq_unquiesce_queue(q);
>> +		blk_mq_unfreeze_queue(q, memflags);
>> +		return;
>> +	}
>
