Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969330;
	b=lvFu3Xzo0OEY/Yr3UyJXbO6NAVGXGIXRcAWC60U1KB8alelPmPINeAVi7FWPiyj2fceM
	 9nPa0hQ3l6KrCQJqyhgegw2ySTEdhPym8Fv8wPL0W2wSdpYcw2GiMncMnntFmBrhxQqjN
	 w63+SkRx38FQ2UFqdyiVMCrjEd8CzsXVStPHCI1vE3wN8yW+98DoDtZQqdz+naG9HfeDS
	 tdOKftZaM9vdCsyuASthpsr5LGloxS/GBFso7+6bNuTWktbtU334kJuwMo1tbcJ2f+Ym/
	 U/GxfXNQ2PSD81BuQwDGqcfYc3/wftQ4UBiLR5sXTX5biv5wiLaFQBdt5VVSTEdOVNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9cgLQkSD3EpnSnQB67qSlMTeWBqxRmaPXyw033TkaEw=;
	b=3g2eQ/cJzvuWej51UhZ8B83X8a4U59sVVsX+zn+HN4/iURJh4Vfl7zAhhJFqiSvXPA2Q
	 T8mD5JMd4AIS3/qZKEsg+RHEalrC8kWlK5ggIZdxnoRccM3Ji7wljNGKbNObUJYXsmU4g
	 pt8L1Rbhanz/vTi2qHdLcnPwzcmyO3iXv9MCWL9dN5vyq272vEguNyI1UAprGUVa24gAV
	 EsIGssJRwIyq+W1Eqzj0d3iCyE1XcNGMGuScCacBOkWbk1L+U9BaxlNSCwnSYx/reXLc/
	 I4Nx7G6w5TMP28F7DZQywOVq2aSSHSzAcHPL211bvO0vzvz5Qv5iMQRgBK6IbeNKzqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMKWWG+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09216606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMKWWG+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14B31F0089F;
	Fri,  6 Nov 2026 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969329;
	bh=9cgLQkSD3EpnSnQB67qSlMTeWBqxRmaPXyw033TkaEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMKWWG+CPv0IGdQjzK0LJoST+OZF1Dv3THQtAQIQNvZqtIQcidFmeyQTbIJj24n+k
	 KE8w1hNY/cDi1ZOa0EpSZoLaX5z/4pgbnY9GYh6E93B4veV02gmjn3iBYokM0BIgPL
	 SW0zJZAnjCYvX7+tsb4Zm0/2RdV8GhmqQQ+kBnBUMjzAouchNx4h2TBTBnPd+6atgn
	 XMBS0NwKnuq8tPMHNn0VIFI+9F1UgXMJWESDfsGjSXn5m/yEar6nqi84LCW2LdSj72
	 4zpqeDx6lxeMP1YnIqjoRlfOWOvHQMQB3D1LJdUWCene5+9NpHY0LLbdS/5QMA9Vq1
	 YhfV+NgYa+5hA==
Message-ID: <sashiko-outbox-201414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v13 1/4] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261106122356.3224638-2-cui.tao@linux.dev>
References: <20261106122356.3224638-1-cui.tao@linux.dev>
 <20261106122356.3224638-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 12:48:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] blk-iocost: stale autop timestamps in ioc_cost_model_write()
--

commit dbe8a0cfe21679fa0e7f03924d92bf48ea6f4959
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add BPF struct_ops cost model support

This commit adds BPF struct_ops support (iocost_model_ops) to allow custom
per-device IO cost models in blk-iocost.

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 1c1fe07a96eaf..876f819d2586f 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c

[ ... ]

> @@ -2976,10 +3036,40 @@ static void ioc_rqos_queue_depth_changed(struct r=
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
> +	/*
> +	 * stepping resumes with the timestamps at their pre-attach
> +	 * values, which would immediately satisfy the 10s cooldown;
> +	 * start it fresh instead
> +	 */
> +	ioc->autop_too_fast_at =3D 0;
> +	ioc->autop_too_slow_at =3D 0;
> +	spin_unlock_irq(&ioc->lock);
> +
> +	/* calc_cost() can still run. The map is freed after an RCU gp. */
> +	bpf_struct_ops_put(ops);
> +#endif
> +}

[ ... ]

> @@ -3632,7 +3725,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_=
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
> @@ -3652,6 +3749,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
>  	} else {
>  		ioc->user_cost_model =3D false;
>  	}
> +	rcu_assign_pointer(ioc->model, model);
>  	ioc_refresh_params(ioc, true);

[Severity: Medium]
Can switching back to model=3Dlinear via io.cost.model evaluate stale
ioc->autop_too_fast_at and ioc->autop_too_slow_at timestamps and trigger an
immediate profile step?

ioc_bpf_reg() attaches the BPF model without clearing those timestamps, and
while the BPF model is active ioc_autop_idx() returns early so they remain =
at
their pre-attach values.  Although ioc_detach_model() zeroes them on detach,
writing model=3Dlinear to io.cost.model sets ioc->model to NULL before call=
ing
ioc_refresh_params(ioc, true), where ioc_refresh_params_disk() calls
ioc_autop_idx() before zeroing autop_too_fast_at and autop_too_slow_at:

block/blk-iocost.c:ioc_refresh_params_disk() {
    ...
	idx =3D ioc_autop_idx(ioc, disk);
	p =3D &autop[idx];

	if (idx =3D=3D ioc->autop_idx && !force)
		return false;

	if (idx !=3D ioc->autop_idx) {
		atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
		ioc->vtime_base_rate =3D VTIME_PER_USEC;
	}

	ioc->autop_idx =3D idx;
	ioc->autop_too_fast_at =3D 0;
	ioc->autop_too_slow_at =3D 0;
    ...
}

Because ioc->model is already NULL when ioc_autop_idx() runs, a pre-attach
timestamp older than AUTOP_CYCLE_NSEC (10s) immediately steps ioc->autop_idx
and resets vtime_rate without waiting for the cooldown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106122356.3224=
638-1-cui.tao@linux.dev?part=3D1
