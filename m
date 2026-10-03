Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB78371D02
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790992330; cv=none; b=U9gJlvgdhqIwhp27KESDXCDcwWCaZjeFz6/8jYGxna3fGQG89FOvLIlbgtQjKrKR//u34bBE0+Nr0k2bsToLbIoBeXuFFu31v0QbctzHl3S5Tk5CStunxB0FOj3BLhRJWyqhE6qvJPY0Sa4Lya7QKxk92YyNnD1F1XVC2MXN5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790992330; c=relaxed/simple;
	bh=6AfikPfbY13BrAqXE7S28OKu3X7Yn96T1Vg7/mFyE0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j7YlWxZRu+y1ymleO8HQVOe3VuvwgNz5sN9UbMkkodzA++TbyK7d+yFLeTQjIPlpQq0mMTc4njuJ2/WXeQefxV6Nm1qS9uEvzRV2/jpDJJeROExHs9U9es10ZnD4C07WNR1eU2Q64pvGkIH+p8ds/47fbUTcsY6hwo2Zd3TPAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsjTYuh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsjTYuh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9261F000FF;
	Sat,  3 Oct 2026 01:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790992328;
	bh=O6acYUcqVO5cyoOAqD004klCNKWeF26ZTlorbNB7p/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lsjTYuh0TI6O4pleWABP/7MpLnO+s0VVk51guWZ7ptV9YflyfLa52r3ZTw0M7jTHg
	 xj6wVfEKkA9w4V8KhXuEiEGAVxDbE+3A2TS+yYclj0V/1LiPeOLhKHIc+yK5wnvXSH
	 FM655TWvkLHGSQeYrkooli4137oG06ck6aZBowgtADuUzk1MnZl/lSse8juB20dtSz
	 n8mAsCA6+NXHd0Y8BxR15ikx+S/agPLPQB9EIz11btyAUiXp2kKJfrO9PcyDJoODHO
	 Y9yS/oHtf0NW5Z2fsJLyCoexAfnIqmOmBepYH8gp265nryJjU6cL1Vl/v4wOGVuleI
	 LQBSfjRiBToJw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 1/4] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, mkoutny@suse.com, bpf@vger.kernel.org, hannes@cmpxchg.org
In-Reply-To: <20261003013033.149288-2-cui.tao@linux.dev>
References: <20261003013033.149288-1-cui.tao@linux.dev>
 <20261003013033.149288-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:52:07 +0000
Message-Id: <20261003015208.1D9261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] bpf: UAF on ioc in ioc_bpf_detach due to lockless fetch before=
 freeze
- [Critical] bpf: UAF on struct_ops map due to concurrent modification of o=
ps->q
- [High] bpf: TOCTOU race in ioc_bpf_detach reading ops->q leads to UAF on =
queue
- [High] bpf: ioc_bpf_detach fails to verify ops->link causes cross-link te=
ardown
--

commit d8ef9c16531866711abee0afcce05f21400897b9
Author: Tao Cui <cui.tao@linux.dev>
Subject: blk-iocost: add BPF struct_ops cost model support

This patch adds BPF struct_ops support to blk-iocost, allowing BPF
programs to provide custom IO pricing models. The struct_ops is attached
per-device and replaces the built-in linear model for IO cost
calculations.

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2745bffcd5eef..581b485434411 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c

[ ... ]

> @@ -2888,6 +2959,45 @@ static void ioc_rqos_queue_depth_changed(struct rq=
_qos *rqos)
>  	spin_unlock_irq(&ioc->lock);
>  }
> =20
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +/*
> + * Eject the model on device removal.  The caller holds rq_qos_mutex
> + * and blkcg_deactivate_policy() has already run, so every existing
> + * blkg got iocg_free() from ioc_pd_free() and no walk is needed.
> + *
> + * bdev is read into a local before ops->q is cleared: once q is
> + * NULL, .unreg returns without taking any lock and the map holding
> + * ops can be freed, so ops must not be touched afterwards.
> + */
> +static void ioc_bpf_eject(struct ioc *ioc)
> +{
> +	struct request_queue *q =3D ioc->rqos.disk->queue;
> +	struct iocost_model_ops *ops;
> +	struct block_device *bdev;
> +
> +	spin_lock_irq(&q->queue_lock);
> +	spin_lock(&ioc->lock);
> +	ops =3D (struct iocost_model_ops *)rcu_dereference_protected(
> +			ioc->attached, lockdep_is_held(&ioc->lock));
> +	if (!ops) {
> +		spin_unlock(&ioc->lock);
> +		spin_unlock_irq(&q->queue_lock);
> +		return;
> +	}
> +	bdev =3D ops->bdev;
> +	rcu_assign_pointer(ioc->attached, NULL);
> +	rcu_assign_pointer(ioc->model, NULL);
> +	spin_unlock(&ioc->lock);
> +	WRITE_ONCE(ops->q, NULL);

[Severity: Critical]
Is it possible for this ejection to clear ops->q when the map has been
re-attached to a different queue?

If a user attaches the same struct_ops map to multiple devices, ops->q gets
overwritten. If the first device is then removed, ioc_bpf_eject() clears
ops->q. This can cause subsequent unreg operations for other active links
to fail to detach the map, resulting in a use-after-free when the map is
freed but the surviving queues still use it.

> +	WRITE_ONCE(ops->link, NULL);
> +	spin_unlock_irq(&q->queue_lock);
> +
> +	blkdev_put_no_open(bdev);
> +}

[ ... ]

> +int ioc_bpf_attach(struct iocost_model_ops *ops, struct bpf_link *link)
> +{
> +	struct block_device *bdev;
> +	struct request_queue *q;

[ ... ]

> +	rcu_assign_pointer(ioc->attached, ops);
> +	rcu_assign_pointer(ioc->model, ops);
> +	spin_unlock(&ioc->lock);
> +
> +	ops->bdev =3D bdev;
> +	WRITE_ONCE(ops->link, link);
> +	WRITE_ONCE(ops->q, q);

[Severity: Critical]
Does this allow concurrent modification of the shared ops state?

ops->q is only protected by the target queue's queue_lock. If the same map
is attached to multiple queues, this will clobber ops->q, setting up the
ejection bug mentioned above.

> +
> +	/* pair iocg_init() with the cgroups which already exist */
> +	ioc_bpf_walk_iocgs(ioc, ops, true);
> +
> +	spin_unlock_irq(&q->queue_lock);
> +	mutex_unlock(&q->blkcg_mutex);

[ ... ]

> +/*
> + * Detach a model: switch back to the builtin model when the attached
> + * model is in use, clear the attachment, and deliver iocg_free() to
> + * the cgroups which still exist, under the same freeze and quiesce as
> + * the attach.  The caller has already checked ops->q.
> + */
> +void ioc_bpf_detach(struct iocost_model_ops *ops, struct bpf_link *link)
> +{
> +	struct request_queue *q =3D READ_ONCE(ops->q);

[Severity: High]
Does re-reading ops->q here introduce a TOCTOU race?

In bpf_iocost_unreg(), a queue reference is correctly secured using
blk_get_queue_rcu(q). However, the queue is re-read here. If a concurrent
attach overwrites ops->q before this read, the code will operate on a
different, unreferenced queue. This can lead to a use-after-free when
calling blk_mq_freeze_queue() if the new queue is concurrently destroyed.

> +	struct block_device *bdev;
> +	struct ioc *ioc;
> +	unsigned int memflags;
> +
> +	if (!q)
> +		return;
> +	ioc =3D q_to_ioc(q);

[Severity: Critical]
Can this lockless fetch of ioc lead to a use-after-free?

The ioc pointer is fetched here without securing an independent reference.
When the function blocks on blk_mq_freeze_queue(q) directly below, a
concurrent device hot-unplug (e.g. del_gendisk) can run rq_qos_exit() and
free the ioc struct.=20

When this thread resumes, the later spin_lock(&ioc->lock) would dereference
the freed ioc pointer.

> +	if (!ioc)
> +		return;
> +
> +	bdev =3D ops->bdev;
> +
> +	/*
> +	 * the freeze is taken before rq_qos_mutex like in the attach;
> +	 * the link is re-checked under the mutex below, as the ejection
> +	 * or a newer attachment may have won the race meanwhile
> +	 */
> +	memflags =3D blk_mq_freeze_queue(q);
> +	blk_mq_quiesce_queue(q);
> +
> +	mutex_lock(&q->rq_qos_mutex);
> +
> +	mutex_lock(&q->blkcg_mutex);
> +	spin_lock_irq(&q->queue_lock);
> +
> +	spin_lock(&ioc->lock);
> +	if (rcu_dereference_protected(ioc->attached,
> +				      lockdep_is_held(&ioc->lock)) !=3D ops) {

[Severity: High]
Is there a missing check to verify the link argument here?

ioc_bpf_detach() is passed a link pointer but never validates it against
READ_ONCE(ops->link). If the same map was attached to another queue via
a new link, closing the old link could cause this function to mistakenly
tear down the new link's attachment, leaving the intended link orphaned.

> +		/* the ejection or a newer link won; nothing to detach */
> +		spin_unlock(&ioc->lock);
> +		spin_unlock_irq(&q->queue_lock);
> +		mutex_unlock(&q->blkcg_mutex);
> +		mutex_unlock(&q->rq_qos_mutex);
> +		blk_mq_unquiesce_queue(q);
> +		blk_mq_unfreeze_queue(q, memflags);
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003013033.1492=
88-1-cui.tao@linux.dev?part=3D1
