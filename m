Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55573443E3B
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544055; cv=none; b=mt5nxMK0pqkcR85LgXjUpg9AZ8GShwDKaejjZv1OC29g/tloHvX+xGHcwgSjL4GJT1WOnh9R9MN/Crt9AGCn+Qc5SiWRVCjHkyB2Q5cPbQtX6gNzwJwvLftACp2QozuCs+tIs6udhHQVlwVpZdK285PKwqH+sR5KpLM/lVMT+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544055; c=relaxed/simple;
	bh=NPBz4GRK647GZyygeDgLShrusmt1fpa0p9008oDjI5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NOU6+7OM4nHYa9NFLgUPcFRzBJgOA2ZaqL0rWpk8JGc2qehsBcGdj2FC9CIoWUOkaC/4Zlz3bWld5khltK4idfeXmr1ErtfiwqXt5ptZ4D+JqSbMc2kdzThNCSfndkdC1dWIM0Rsj3b7Wy4sHk1/7VtRyCx8d2HsaPwJhhY6deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOuamUmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOuamUmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92471F000FF;
	Wed, 16 Sep 2026 07:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789544049;
	bh=uGHPASUrQQ8i9Zby659HtrxRPtJm1hj+YPW+CqBgBKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MOuamUmQZU6t4kn7TAwrQ7CoycaRAjkozo5VeU8kTm6ctfPKWHj0i4qI5lPAWFOSu
	 tINDV92nHpM5nhNaMAl6psF+s+YI6uNLlqAp2dTpabNvs2VkdkvdUxbjj0/TiKtrMX
	 1Kj4muZmmGJhOaCfPBA2rhYUEIl2DgAN+gnJKTYrB1hwPpAln2/CMXUPq7nvG6ukIG
	 YjAKEXCtbktjibIBuliYMaJTCDaT/MUWt+7k5tfBoSgdabfYR3S6CuvuSCki9ujtuw
	 ZZ0gf0XfNwgxGd0ET9PdyoL6DNx6Rwtl5s3CWUE0PQknOKY2fzDidnS0zNW8C900Y1
	 rIEZKJTO8HszA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/5] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, bpf@vger.kernel.org
In-Reply-To: <20260916072302.1068871-2-cui.tao@linux.dev>
References: <20260916072302.1068871-1-cui.tao@linux.dev>
 <20260916072302.1068871-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:34:08 +0000
Message-Id: <20260916073408.D92471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf: resource leak and broken blkcg notifications on BPF model unb=
ind
- [High] bpf: coefficient-only writes fail if bound model is unregistered
- [Low] bpf: multi-line comments do not follow modern kernel style
--

commit 4e914860298423131f3423ab63f79ed4a655051f
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add BPF struct_ops cost model support

This commit introduces a BPF struct_ops based cost model for blk-iocost,
replacing the builtin linear model on a device. It implements a
registration framework where sysfs bindings map a registered model to a
device.

> diff --git a/block/blk-iocost-bpf.c b/block/blk-iocost-bpf.c
> new file mode 100644
> index 0000000000000..7f1f9a2e51cb2
> --- /dev/null
> +++ b/block/blk-iocost-bpf.c

[ ... ]

> +const struct iocost_model_ops *iocost_bpf_model_get(const char *name)
> +{
> +	struct iocost_bpf_model *m;
> +	const struct iocost_model_ops *ops =3D ERR_PTR(-ENOENT);
> +
> +	mutex_lock(&iocost_bpf_reg_lock);
> +	list_for_each_entry(m, &iocost_bpf_models, list) {

[Severity: High]
Will this lookup fail to find models that are unregistered but still
actively bound to devices? If a user issues a coefficient-only write on
a device using an unregistered model, ioc_cost_model_write() passes the
name here, but since this only searches the registry (iocost_bpf_models),
it returns -ENOENT and rejects the write.

> +		if (!strcmp(m->ops->name, name)) {

[ ... ]

> +static void bpf_iocost_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct iocost_model_ops *ops =3D kdata;
> +	struct iocost_bpf_model *m;
> +
> +	mutex_lock(&iocost_bpf_reg_lock);
> +	m =3D iocost_bpf_model_lookup(ops);
> +	if (m) {
> +		/* keep the linkage queryable so model_put() can tell a
> +		 * still-registered node (one ref held by the registry)
> +		 * from one kept alive only by device bindings
> +		 */

[Severity: Low]
Does this comment style follow the BPF subsystem requirements? The
standard specifies that multi-line comments should have the opening /*
on its own line.

> +		list_del_init(&m->list);

[ ... ]

> +void iocost_bpf_model_put(const struct iocost_model_ops *ops)
> +{
> +	struct iocost_bpf_model *m;
> +
> +	mutex_lock(&iocost_bpf_reg_lock);
> +	list_for_each_entry(m, &iocost_bpf_lifecycle, lifecycle) {
> +		if (m->ops =3D=3D ops)
> +			break;
> +	}
> +	if (&m->lifecycle !=3D &iocost_bpf_lifecycle) {
> +		bool freed =3D refcount_dec_and_test(&m->refs);
> +
> +		/* leave the notify list with the last binding: the
> +		 * remaining ref is either the registry's (node still on
> +		 * iocost_bpf_models) or zero and the node is freed
> +		 */

[Severity: Low]
Similarly here, this multi-line comment is missing the opening /* on its
own line.

> +		if (freed || !list_empty(&m->list))
> +			list_del(&m->lifecycle);
> +		mutex_unlock(&iocost_bpf_reg_lock);
> +		bpf_struct_ops_put(ops);
> +		if (freed)
> +			kfree(m);
> +		return;
> +	}

[Severity: High]
Can this sequence prematurely detach registered models from the lifecycle
list and leak BPF map references?

When the first device is unbound from a registered model,
!list_empty(&m->list) will evaluate to true. This removes the model from
the lifecycle list early, breaking blkcg notifications.

When subsequent devices are unbound, list_for_each_entry() at the start of
iocost_bpf_model_put() will fail to find the model, causing execution to
jump over this block completely. The bpf_struct_ops_put() call will be
skipped, leading to a map reference leak.

> +	mutex_unlock(&iocost_bpf_reg_lock);
> +}

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2745bffcd5eef..22b2ece52fa58 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c

[ ... ]

> @@ -3591,6 +3628,24 @@ static ssize_t ioc_cost_model_write(struct kernfs_=
open_file *of, char *input,
>  	spin_lock_irq(&ioc->lock);
>  	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
>  	user =3D ioc->user_cost_model;
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +	{
> +		const struct iocost_model_ops *model =3D
> +			rcu_dereference_protected(ioc->model,
> +					lockdep_is_held(&ioc->lock));
> +
> +		/* seed from the bound model so a coefficient-only write
> +		 * keeps it bound; ctrl=3Dauto/user and model=3Dlinear are
> +		 * the explicit ways back to the builtin model
> +		 */

[Severity: Low]
This comment also places text on the same line as the opening /*, which
diverges from the preferred BPF multi-line comment style.

> +		if (model)
> +			strscpy(bpf_model, model->name, sizeof(bpf_model));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916072302.1068=
871-1-cui.tao@linux.dev?part=3D1
