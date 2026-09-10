Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0844BFE97
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046265; cv=none; b=IVDNCZ+heRCZ3pio8T9ds3cKZ5Y2nNfOCoODHw1joXIY40rc6w+SBQtj+rmJLlcj73lcji1fqgZy7nh1rWBAEBUyAbbNKGg6bWCp9/H3tEKIMDLdq+6Hu01Occ0sFZ9e5iupIa+jsxpsm4ttRejr9UlEDjjnev5vWB6V+otaovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046265; c=relaxed/simple;
	bh=Qqjff9wQxb7ZUCq1kjivCsdOSuKxx66UHLM+MRyhMCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBAsC0LVMKnjtbCBq2wQ2Z56UZ6QfBFunSRBEEeEvv79W6rOjyPdpx3aD4UJpogh4t4sGSzOx04BwgFYOcvf9XCgY9t516HXIJTdsNBbwqM/8EnDbyaJU5Drqu0KQqhS6XHt3his6lKYIjuK4sQ51PdeoUUst7ZECH6XYVnXiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL3FCyNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL3FCyNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E191F000FF;
	Thu, 10 Sep 2026 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046264;
	bh=UmYBhAP0sTbiO25pPZBJF5+Tt7/2d+Tq+nN0SWtJlFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PL3FCyNXs6dhIXhKkm39r8s0k5S2BuVyeo63vcU/xgJ2mScrplLIfW/h+h+52Muwv
	 GbF+6gWmzmjw2sfcNULORG6cSoBR/cg/SE4vswhavqF7jpwW34MbZTfsNHdGURCjOn
	 5KXsZvWS4LZTJ+mmqtnOD57hqbE2cO/6XaGyDfTP+NA4Ho+lQDlq85ygSHfg/LrznL
	 8X1dhMM5c1LEb/jUzH6uySgUWWHXtx1xnOr+B9y0LDmKxJUd6D7w2SSc0kapAcORyg
	 FlGNpqvWVnOU83gO5xE+5ALpQftGcWHdlT/aMxbjuUB/R0/Shz5wBepToPXxfG/7p4
	 Bdie0BkBFjnFg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/5] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20260910125817.223354-2-cui.tao@linux.dev>
References: <20260910125817.223354-1-cui.tao@linux.dev>
 <20260910125817.223354-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:17:43 +0000
Message-Id: <20260910131743.D8E191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unregistered but active BPF models miss blkcg_offline notification=
s, leading to per-cgroup state leaks.
- [High] BPF cost model is entirely bypassed during request-level sizing (f=
or completed requests), silently falling back to the builtin linear model.
- [Medium] Partial configuration application on the error path when BPF mod=
el binding fails breaks transactional semantics.
- [Medium] Non-atomic configuration update in ioc_cost_model_write allows i=
nterleaved mixed state (TOCTOU-like).
--

commit 74ed4cc46ea69cb83c7676b643c08876cce22ab0
Author: Tao Cui <cuitao@kylinos.cn>
Date:   Thu Sep 10 12:58:13 2026 +0000

    blk-iocost: add BPF struct_ops cost model support

    Add the iocost_model_ops struct_ops: a bound BPF model fully replaces
    the builtin linear model on a device.  calc_cost() receives the full
    bio->bi_opf (including REQ_PREFLUSH and REQ_FUA), the IO size, the
    start sector (sector_t), the issuing blkcg and the iocost-specific call
    metadata (the merge-path indicator), and is called from both the
    bio charging path and the request-level sizing path, so a model
    owns pricing for every IO on the device.  The builtin cursor is
    not exposed: a model is expected to track its own stream state.

[ ... ]

> diff --git a/block/blk-iocost-bpf.c b/block/blk-iocost-bpf.c
> new file mode 100644
> index 0000000000000..aec6df2795990
> --- /dev/null
> +++ b/block/blk-iocost-bpf.c
[ ... ]
> +void iocost_notify_blkcg_offline(struct blkcg *blkcg)
> +{
> +	struct iocost_bpf_model *m;
> +
> +	guard(mutex)(&iocost_bpf_reg_lock);
> +	list_for_each_entry(m, &iocost_bpf_models, list) {
> +		if (m->ops->blkcg_offline)
> +			m->ops->blkcg_offline(blkcg);
> +	}
> +}
[Severity: High]
Does this skip unregistered but active models?

By only iterating over the global iocost_bpf_models registry, any model that
has been unregistered but is still bound to a device will miss this
blkcg_offline notification.

Could this result in a resource leak of per-cgroup state in the BPF program
if cgroups are subsequently offlined?

[ ... ]
> +static void bpf_iocost_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct iocost_model_ops *ops =3D kdata;
> +	struct iocost_bpf_model *m;
> +
> +	mutex_lock(&iocost_bpf_reg_lock);
> +	m =3D iocost_bpf_model_lookup(ops);
> +	if (m) {
> +		list_del(&m->list);
> +		bpf_struct_ops_put(ops);
> +		kfree(m);
> +	}
> +	mutex_unlock(&iocost_bpf_reg_lock);
> +}
[Severity: High]
Can removing the model from the broadcast list here cut it off from future
lifecycle events?

The model is eagerly removed from the list when unregistered, which means it
will stop receiving blkcg_offline notifications even if devices are still
actively using it.

[ ... ]
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2745bffcd5eef..182601ad783f0 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
[ ... ]
> @@ -2596,10 +2620,28 @@ static void calc_size_vtime_cost_builtin(struct r=
equest *rq, struct ioc *ioc,
> =20
>  static u64 calc_size_vtime_cost(struct request *rq, struct ioc *ioc)
>  {
> -	u64 cost;
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +	const struct iocost_model_ops *model;
> =20
> -	calc_size_vtime_cost_builtin(rq, ioc, &cost);
> -	return cost;
> +	rcu_read_lock();
> +	model =3D rcu_dereference(ioc->model);
> +	if (model && rq->bio && rq->bio->bi_blkg) {
> +		u64 cost;
> +
> +		cost =3D model->calc_cost(rq->cmd_flags, blk_rq_bytes(rq),
> +					blk_rq_pos(rq),
> +					rq->bio->bi_blkg->blkcg, 0);
[Severity: High]
Is the BPF cost model bypassed during request-level sizing?

During request completion (such as in ioc_rqos_done()), the request has been
fully completed by blk_update_request(), meaning rq->bio is NULL and
blk_rq_bytes(rq) is 0.

Because of the check for rq->bio here, it seems this will always fall back
to calc_size_vtime_cost_builtin(), completely bypassing the BPF model for
completed requests and breaking the API contract.

[ ... ]
> @@ -3563,6 +3674,14 @@ static ssize_t ioc_cost_model_write(struct kernfs_=
open_file *of, char *input,
> =20
>  	if (user) {
>  		memcpy(ioc->params.i_lcoefs, u, sizeof(u));
>  		ioc->user_cost_model =3D true;
>  	} else {
>  		ioc->user_cost_model =3D false;
>  	}
>  	ioc_refresh_params(ioc, true);
[Severity: Medium]
Can this result in partial configuration being applied if binding the BPF
model fails later?

The linear coefficients are irreversibly applied to the device here before
the model validation completes.

> =20
>  	ret =3D 0;
> =20
>  unlock:
>  	spin_unlock_irq(&ioc->lock);
> =20
> +	/*
> +	 * Bind the BPF model outside ioc->lock: the registry lookup
> +	 * takes the registration mutex and the old model's reference
> +	 * is dropped after the swap.
> +	 */
> +	if (!ret)
> +		ret =3D ioc_bpf_model_bind(ioc, bpf_model);
[Severity: Medium]
If ioc_bpf_model_bind() fails (e.g., -ENOENT), does it return an error
without reverting the linear coefficient changes? This could leave a torn
configuration where the old model is paired with new linear coefficients.

Also, since the lock is dropped before binding the new BPF model, is there a
race window for concurrent sysfs writes?

If two threads write to io.cost.model concurrently, Thread B's model could =
be
bound before Thread A's model, pairing Thread A's model with Thread B's
parameters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910125817.2233=
54-1-cui.tao@linux.dev?part=3D1
