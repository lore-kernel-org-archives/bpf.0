Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713875;
	b=jix6F/pnw1SrNVnxA2I4H/ErxDoxnkDY3kl6k1/Xb5O3YvGqkgh309s3CVu59Y8RTJ40
	 l/lLKv0VvJUWXgVC4gjujjTZDaY3MtrdjtU1Pb3vHN0EQArwFI76Uw6L0sR5KuMp+An4q
	 00UDdTlJ1USxSeJSC7W2VjBq4eUFr0mrecIm2byGgQujcwAcSYJZNcSY/1VOAqlriybbx
	 rigcfJry3I2lt0CONgEZug06rtPDD+Bx/h4TzTR02OACAr/0/Hhxl1jXsVvRhCG3Zz1BF
	 JJ4+LU7mSh6u8iqurRxEpFr8TSED6yOYUTju/XE/Hu2+fHHQEmwW9paokDYLUaOtKeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lGutsc94r0JazOCcjMk3sN1HMqzMqeqmLc7sc5c4MuI=;
	b=a/9LNvTxY1ByDmLrz8+QYYZtq1VPXVX4VtOWBWq9oMRFTTROIQZ+neTG5/ovfp+BwO7e
	 FaSd3kFdeOo0eMmNnEYI6XONjbqcqqbuNpT7SgCpaLtZLaOJSVIY3OjZqJHEn/s5xpZwR
	 S0fc617xz/xe061+Qir30Aa3N0m+ZgnR756VT20GwCRpxfECS04zd+4ZRYj5M31Uxff/2
	 4tj7WsBAhEPzQBimAS31fdvATZsJdpgT0xcKmUlJ/OAkZkAyOMReMD8N/y50tHNvhtTqq
	 R1CtKRjbLUw9vEGglwpZHnKZ/0eCy+uGQOra3p18ZrKSOBa5KgdmhnEzFbdTwLjpztg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB6+Idik;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB295606D830
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB6+Idik
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6A01F0093A;
	Tue,  3 Nov 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793713874;
	bh=lGutsc94r0JazOCcjMk3sN1HMqzMqeqmLc7sc5c4MuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XB6+IdikH0ZbiaCSK2f0TbyUzQV1gCwFf0G31aoE+YyyqDUrT1woAmWL0MfjqL+TP
	 I1l0mELi47lDJZvROC6CavHlDhb0mntfCujAiqiXO9AZbxyQaDOz9zAfxxRl1QkTHF
	 ZyUvNe+H/ZtIfC6O1SXu6wD+s5rCB65J6RDdDkof5OCyfZAHhnXuC7w//fBHyGcFtU
	 uVGN4j8atAMsFSbmx/2NWhHOHrzliqT2weG4UT+DdKnu88P6aWNJBvSGBqnPZI68C6
	 3UbGr6DycdD2b2dXxR4AV6v4wOxdyYvpU5YiYMlp7fH/qWW/DY9dlJUq1Cqz7lQOyj
	 j/SgU1GY/9YHQ==
Message-ID: <sashiko-outbox-195400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v12 1/4] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261103132613.1952975-2-cui.tao@linux.dev>
References: <20261103132613.1952975-1-cui.tao@linux.dev>
 <20261103132613.1952975-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:51:13 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] blk-iocost: lock order inversion between queue freeze and rq_qos_m=
utex
- [Medium] blk-iocost: stale autop timestamps across model attach/detach
--

commit 145ca796c6aa0e9492a94bdce49377cc07f92750
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add BPF struct_ops cost model support

This commit adds BPF struct_ops support (iocost_model_ops) to blk-iocost so
a BPF program can calculate per-bio vtime costs and provide page transfer
coefficients for a target block device. It also extends io.cost.model to
switch between the linear and attached BPF cost models while suspending
ctrl=3Dauto profile stepping when a BPF model is active.

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index a81488c755cab..0f9c695b685af 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c

[ ... ]

> @@ -806,7 +844,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gend=
isk *disk)
>  		return AUTOP_SSD_DFL;
> =20
>  	/* if user is overriding anything, maintain what was there */
> -	if (ioc->user_qos_params || ioc->user_cost_model)
> +	if (ioc->user_qos_params || ioc->user_cost_model || ioc_model(ioc))
>  		return idx;
> =20
>  	/* step up/down based on the vrate */

[ ... ]

> @@ -2908,10 +2968,33 @@ static void ioc_rqos_queue_depth_changed(struct r=
q_qos *rqos)
>  	spin_unlock_irq(&ioc->lock);
>  }
> =20
> +/* Called by .unreg and by device removal, whichever is first. */
> +static void ioc_detach_model(struct ioc *ioc)
> +{
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +	const struct iocost_model_ops *ops =3D ioc->attached;
> +
> +	lockdep_assert_held(&ioc->rqos.disk->queue->rq_qos_mutex);
> +
> +	if (!ops)
> +		return;
> +
> +	spin_lock_irq(&ioc->lock);
> +	rcu_assign_pointer(ioc->model, NULL);
> +	ioc->attached =3D NULL;
> +	ioc->attached_link =3D NULL;
> +	spin_unlock_irq(&ioc->lock);

[Severity: Medium]
When ctrl=3Dauto is active under the builtin linear model and vrate_pct cro=
sses
too_fast_vrate_pct or too_slow_vrate_pct in ioc_autop_idx(), the current
timestamp is recorded in ioc->autop_too_fast_at or ioc->autop_too_slow_at,
requiring AUTOP_CYCLE_NSEC (10 seconds) of sustained condition before stepp=
ing
ioc->autop_idx.

When a BPF model is attached in ioc_bpf_reg() and later detached in
ioc_detach_model(), ioc->model is updated without calling
ioc_refresh_params(ioc, true) or clearing ioc->autop_too_fast_at and
ioc->autop_too_slow_at, unlike ioc_cost_model_write() and ioc_qos_write():

block/blk-iocost.c:ioc_refresh_params_disk() {
    ...
	idx =3D ioc_autop_idx(ioc, disk);
	p =3D &autop[idx];

	if (idx =3D=3D ioc->autop_idx && !force)
		return false;
    ...
	ioc->autop_idx =3D idx;
	ioc->autop_too_fast_at =3D 0;
	ioc->autop_too_slow_at =3D 0;
    ...
}

While the BPF model is active, ioc_autop_idx() returns idx early at the
ioc_model(ioc) check before reaching the timestamp update and reset logic, =
and
ioc_refresh_params_disk(ioc, false, disk) returns false early because
idx =3D=3D ioc->autop_idx, leaving any pre-attachment timestamp in
ioc->autop_too_fast_at or ioc->autop_too_slow_at intact.

Once the BPF model is detached via ioc_bpf_unreg() -> ioc_detach_model(), on
the first timer tick (ioc_timer_fn() -> ioc_refresh_params(ioc, false) ->
ioc_autop_idx()), if vrate_pct is past the threshold,
now_ns - ioc->autop_too_fast_at (or autop_too_slow_at) includes the entire
time the BPF model was attached.

Could this cause ioc_autop_idx() to immediately exceed AUTOP_CYCLE_NSEC and
step ioc->autop_idx (resetting vtime_rate) on the first tick after detach
instead of waiting for a full AUTOP_CYCLE_NSEC cycle? Should ioc_bpf_reg() =
and
ioc_detach_model() reset the autop timestamps or call
ioc_refresh_params(ioc, true) under ioc->lock?

[ ... ]

> @@ -3559,7 +3644,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_=
open_file *of, char *input,
>  			continue;
>  		case COST_MODEL:
>  			match_strlcpy(buf, &args[0], sizeof(buf));
> -			if (strcmp(buf, "linear"))
> +			if (!strcmp(buf, "linear"))
> +				model =3D NULL;
> +			else if (!strcmp(buf, "bpf") && ioc->attached)
> +				model =3D ioc->attached;
> +			else
>  				goto unlock;
>  			continue;
>  		}
> @@ -3579,6 +3668,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
>  	} else {
>  		ioc->user_cost_model =3D false;
>  	}
> +	rcu_assign_pointer(ioc->model, model);
>  	ioc_refresh_params(ioc, true);
> =20
>  	ret =3D 0;
> @@ -3626,6 +3716,166 @@ static struct blkcg_policy blkcg_policy_iocost =
=3D {
>  	.pd_stat_fn	=3D ioc_pd_stat,
>  };
> =20
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +static int ioc_bpf_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct iocost_model_ops *ops =3D kdata;
> +	struct block_device *bdev;
> +	struct request_queue *q;
> +	unsigned int memflags;
> +	struct ioc *ioc;
> +	int ret;
> +
> +	bdev =3D blkdev_get_no_open(new_decode_dev(ops->dev), false);
> +	if (!bdev)
> +		return -ENODEV;
> +
> +	q =3D bdev_get_queue(bdev);
> +	if (bdev_is_partition(bdev) || !queue_is_mq(q)) {
> +		blkdev_put_no_open(bdev);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* the order of ioc_qos_write() */
> +	memflags =3D blk_mq_freeze_queue(q);
> +	mutex_lock(&q->rq_qos_mutex);

[Severity: High]
In ioc_bpf_reg(), blk_mq_freeze_queue(q) is called before acquiring
q->rq_qos_mutex, which establishes the lock order:

  q->io_lockdep_map -> q->q_lockdep_map -> q->rq_qos_mutex

However, in ioc_cost_model_write() (which is used to toggle between
model=3Dlinear and model=3Dbpf), blkg_conf_open_bdev(&ctx) acquires
q->rq_qos_mutex first, and unlike ioc_qos_write(), ioc_cost_model_write() d=
oes
not drop q->rq_qos_mutex before calling blk_iocost_init() and
blk_mq_freeze_queue(q):

block/blk-iocost.c:ioc_cost_model_write() {
	blkg_conf_init(&ctx, input);

	ret =3D blkg_conf_open_bdev(&ctx); // locks q->rq_qos_mutex
	if (ret)
		return ret;
    ...
	ioc =3D q_to_ioc(q);
	if (!ioc) {
		ret =3D blk_iocost_init(ctx.bdev->bd_disk);
		if (ret)
			goto close_bdev;
		ioc =3D q_to_ioc(q);
	}

	memflags =3D blk_mq_freeze_queue(q); // locks q->io_lockdep_map -> q->q_lo=
ckdep_map
    ...
}

This establishes the opposite lock order in ioc_cost_model_write():

  q->rq_qos_mutex -> q->io_lockdep_map -> q->q_lockdep_map

In addition, paths that hold q->rq_qos_mutex without freezing the queue fir=
st
(such as ioc_cost_model_write() -> blk_iocost_init() and ioc_weight_write()=
 ->
blkg_conf_prep()) perform GFP_KERNEL allocations under q->rq_qos_mutex with=
out
memalloc_noio_save(), which can enter fs_reclaim and wait on a frozen queue.

Can attaching a BPF model via ioc_bpf_reg() and writing to io.cost.model via
ioc_cost_model_write() trigger a lockdep circular locking dependency splat =
or
an ABBA deadlock between queue freeze and q->rq_qos_mutex? Should
ioc_cost_model_write() release and re-acquire q->rq_qos_mutex around
blk_mq_freeze_queue(q) the same way ioc_qos_write() does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103132613.1952=
975-1-cui.tao@linux.dev?part=3D1
