Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CAC3E7BA9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372180; cv=none; b=D146H6ucl42D6hGpO1pb24jspcq/eThLWokg835/Q960x7LuDCWlHuE400XNVXUIfh6/Nz0oJ/B9Vi8QDHIBvtGEFkzURx4IDDcq71YA50/K4aVBlYgpuUZ2j4m6i/m4LcBfzmJgazUEYuGNLxspXsmT43Z9f/cPqVHMeVqzu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372180; c=relaxed/simple;
	bh=/WJgMa4cEk1gyRRAbHaR1lr3lZExWd30PaQwgCmuETI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QBqF/a8MW1cOAeRcFT6ESbkGrF+7tftDMxl7mqkhQWruaHmmfHU3RRtYZOJ/XW6BWgY4P/egolLTmk8Dp/22iYoxseth+x1gnouxAMPOdFOJ3zr5NgQr93Ojsk37VnjHBa2SqnWCey3S/S+GWdY17Rvbn7LLvvL5b6yCGm314QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbQ3yPID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbQ3yPID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F2A1F000FF;
	Mon, 14 Sep 2026 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372178;
	bh=8lJomVYYRls5+kWLl/CEBGgTd0NlCyZwbFUZLKPN+4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbQ3yPIDVH6Sz+Fp3sSHsUDJGvpNsIlZRN7Ke7RaVtHImOMtX9GFseVvfQSogqoQ1
	 HekCyOej9oVVcDgCrWbTMBOjbW698+7nRA+6a6CwxFQKrIGzv2f0GriimShbiu1dNN
	 jEba7i5WFjEdhgEaAyuc8Zw6GLP9uGlWTkgDT0zFjILRSlfx/krc3dCIYeAWbfsPFt
	 SVM51EJBmGsThSaIfZ9cFZvEf0mUllWOrKyOOA2672HxK7r6KpzaOWIVnmHWRXuf/y
	 JgYHj+BdKOu/Z/sLikJ2MFLLM6wz1Inyn4qh0x8YCAntl/Oxr7Gt1f/uK4o1nSSuxY
	 gDJf3dH3Kgljw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/5] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <20260914073356.791518-2-cui.tao@linux.dev>
References: <20260914073356.791518-1-cui.tao@linux.dev>
 <20260914073356.791518-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:49:37 +0000
Message-Id: <20260914074938.48F2A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Kernel panic due to NULL pointer dereference in the bio charging p=
ath when a BPF struct_ops map is loaded without implementing calc_cost.
- [Medium] The cgroup interface breaks save/restore symmetry because `ctrl=
=3Dbpf` is printed on read but rejected on write.
- [Medium] Any write to io.cost.model that updates linear coefficients with=
out explicitly specifying model=3D... silently unbinds the active BPF model.
--

commit 7407199b3c34d6a89c70eca2c0e70034c01c2bd7
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add BPF struct_ops cost model support

This commit introduces a BPF struct_ops-based cost model for the IO
controller, allowing the replacement of the built-in linear model. It
provides lifecycle callbacks and integration with the IO charging path
to price IO operations based on the bound BPF model.

> diff --git a/block/blk-iocost-bpf.c b/block/blk-iocost-bpf.c
> new file mode 100644
> index 0000000000000..7ad88600c203a
> --- /dev/null
> +++ b/block/blk-iocost-bpf.c

[ ... ]

> +/*
> + * kdata is seeded from the CFI stubs, so calc_cost is never NULL; a
> + * model which did not implement it inherits the stub, which prices
> + * every IO at 0.  Compare against the stub to reject it.
> + */
> +static int bpf_iocost_validate(void *kdata)
> +{
> +	struct iocost_model_ops *ops =3D kdata;
> +
> +	if (ops->calc_cost =3D=3D bpf_iocost_calc_cost_stub)
> +		return -EINVAL;

[Severity: High]
Does this validation catch the case where a user provides an incomplete
BPF map without a calc_cost implementation? The BPF subsystem does not
copy cfi_stubs values into kdata for unimplemented members, so they
remain NULL. Comparing ops->calc_cost to the stub address might fail to
detect a NULL value, allowing an invalid model to be registered.

> +	return 0;
> +}

[ ... ]

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2745bffcd5eef..3cc21092cf47f 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c

[ ... ]

> @@ -2571,10 +2577,28 @@ static void calc_vtime_cost_builtin(struct bio *b=
io, struct ioc_gq *iocg,
> =20
>  static u64 calc_vtime_cost(struct bio *bio, struct ioc_gq *iocg, bool is=
_merge)
>  {
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +	const struct iocost_model_ops *model;
>  	u64 cost;
> =20
> -	calc_vtime_cost_builtin(bio, iocg, is_merge, &cost);
> -	return cost;
> +	rcu_read_lock();
> +	model =3D rcu_dereference(iocg->ioc->model);
> +	if (model) {
> +		cost =3D model->calc_cost(bio->bi_opf, bio->bi_iter.bi_size,

[Severity: High]
If bpf_iocost_validate() allowed an empty calc_cost through, could this
lead to a NULL pointer dereference here in the bio charging path? A
missing bounds check here combined with the validation hole might cause a
deterministic kernel panic reachable by a privileged user loading an
incomplete BPF map.

> +					bio->bi_iter.bi_sector,
> +					iocg_to_blkg(iocg)->blkcg,
> +					is_merge ? IOCOST_COST_F_MERGE : 0);
> +		rcu_read_unlock();
> +		return min(cost, VTIME_PER_SEC);
> +	}
> +	rcu_read_unlock();
> +#endif

[ ... ]

> @@ -3438,12 +3493,30 @@ static u64 ioc_cost_model_prfill(struct seq_file =
*sf,
>  		return 0;
> =20
>  	spin_lock_irq(&ioc->lock);
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +	{
> +		const struct iocost_model_ops *model =3D
> +			rcu_dereference_protected(ioc->model,
> +					lockdep_is_held(&ioc->lock));
> +
> +		seq_printf(sf, "%s ctrl=3D%s model=3D%s "
> +			   "rbps=3D%llu rseqiops=3D%llu rrandiops=3D%llu "
> +			   "wbps=3D%llu wseqiops=3D%llu wrandiops=3D%llu\n",
> +			   dname, model ? "bpf" :
> +				   ioc->user_cost_model ? "user" : "auto",

[Severity: Medium]
When a BPF model is active, this prints "ctrl=3Dbpf". Does this break the
cgroup interface save/restore symmetry? ioc_cost_model_write() below
seems to reject the "ctrl=3Dbpf" string.

> +			   model ? model->name : "linear",
> +			   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS],
> +			   u[I_LCOEF_RRANDIOPS], u[I_LCOEF_WBPS],
> +			   u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
> +	}
> +#else

[ ... ]

> @@ -3512,6 +3632,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
>  	spin_lock_irq(&ioc->lock);
>  	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
>  	user =3D ioc->user_cost_model;
> +	bpf_model[0] =3D '\0';

[Severity: Medium]
If a user writes an update to linear coefficients (e.g., rbps=3D1000)
without explicitly specifying "model=3D...", bpf_model remains an empty
string because it is not initialized with the currently active model's
name. Could this inadvertently cause the active BPF model to be silently
unbound when the configuration is applied later in this function?

> =20
>  	ret =3D -EINVAL;
> =20
> @@ -3533,11 +3654,16 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
>  				user =3D true;
>  			else
>  				goto unlock;

[Severity: Medium]
It appears that if the input contains "ctrl=3Dbpf" (as output by
ioc_cost_model_prfill), it hits the "else" branch and goes to unlock,
failing the write. Cgroup attributes usually need to parse their own
output to support configuration backup and restore (like systemd or
cgroup-tools). Could this prevent restoring valid saved configurations?

> +			bpf_model[0] =3D '\0';
>  			continue;
>  		case COST_MODEL:

[ ... ]

> @@ -3550,19 +3676,41 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
>  		user =3D true;
>  	}
> =20
> -	if (user) {
> -		memcpy(ioc->params.i_lcoefs, u, sizeof(u));
> -		ioc->user_cost_model =3D true;
> -	} else {
> -		ioc->user_cost_model =3D false;
> -	}
> -	ioc_refresh_params(ioc, true);
> -
>  	ret =3D 0;
> =20
>  unlock:
>  	spin_unlock_irq(&ioc->lock);
> =20
> +	/*
> +	 * Resolve the model name outside ioc->lock (the registry lookup
> +	 * takes a mutex), so a bad name rejects the whole write before
> +	 * anything is applied.  The resolved model is this write's own
> +	 * state, not per-device state, so concurrent writers cannot
> +	 * clobber each other's staged model.  On success, re-take the
> +	 * lock to apply the coefficients and swap the model in one go.
> +	 */
> +	if (!ret) {
> +		const struct iocost_model_ops *new, *old;
> +
> +		new =3D ioc_bpf_model_prepare(bpf_model);
> +		if (IS_ERR(new)) {
> +			ret =3D PTR_ERR(new);
> +		} else {
> +			spin_lock_irq(&ioc->lock);
> +			if (user) {
> +				memcpy(ioc->params.i_lcoefs, u, sizeof(u));
> +				ioc->user_cost_model =3D true;
> +			} else {
> +				ioc->user_cost_model =3D false;
> +			}
> +			ioc_refresh_params(ioc, true);
> +			old =3D ioc_bpf_model_commit(ioc, new);

[Severity: Medium]
If the BPF model name wasn't explicitly provided during this write,
bpf_model is "", making new NULL. ioc_bpf_model_commit() then unbinds the
existing BPF model, falling back to the linear model. Since users have
legitimate reasons to tune linear coefficients while a BPF model is active
(for request sizing), this silent unbinding could drop their QoS policy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914073356.7915=
18-1-cui.tao@linux.dev?part=3D1
