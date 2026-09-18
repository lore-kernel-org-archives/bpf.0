Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7835830216D
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 03:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702191; cv=none; b=p3lHf9tmpQQM5Z30NdsES3p8JKcEB7xldnMbijGIU3tUpeVPicfjHVfoXiRdwlTHyEVxyrfQKXKmdPGKPMls3X+y+f/2yladxHcxzHBEdrsMEdhRK91j2/q6ll3OVamgr/TLKo8uBEQGyMsGMOb3MCYB5WTSoq5H2najBQxgcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702191; c=relaxed/simple;
	bh=GjwKTkyZJCqHWuj8I0GHCPt/R2L2kod3fukmEnAL+PU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fQmrD7Rprf2NE97yzDz3fC7HQfZ0NH7/Hs1PSotpBcZSjS9v4vXOi2jOpjcmUXoeZHaCeh2k72l3m0qR1nH9plD46FtX0m1Zo76qtvucK4fmx+9os6Q1KQTBRK+BrnBcruucUhuQSTAe6AJW0gLvKZwcbQGeiBnpM6uaiyALyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1q/PlhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1q/PlhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A401F000FF;
	Fri, 18 Sep 2026 03:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702190;
	bh=SBiOwHSPZEg5ixqCKmLQhqSWkR46Z9oX0WTx+EFlp/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1q/PlhLE4Dn6rgHN/YeQB8cQ/+RfiraBUNXMbzXlI+DYP68IT1roa3Zoq0s7bCas
	 kb8IHYZRPYAzudFowkwce8+zujRTvFu83nS1goseErZtTfIzq7Hj6ex6YCXt81Lsgd
	 Pog9Lu+/2klT1vjFQ/PnIzrdXis2qNcfkTCvkz5Ey6C6BW1W30eBJ06h6zkYlMyV8U
	 TVe1rfXyUMgzCX0TkH6hH5cw5qMCLUG/PcO/YkaaexA72K/pjKFuxrxplLsR4VRvK1
	 SmCmWpZj39JBCBNX8zyjFpG6vdnr9RiHoSxhcifIMlczjUmp3w4W1ggzCD4b0ubDwS
	 7FFe4Urm97d+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 1/5] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org, tj@kernel.org
In-Reply-To: <20260918031751.1255420-2-cui.tao@linux.dev>
References: <20260918031751.1255420-1-cui.tao@linux.dev>
 <20260918031751.1255420-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:29:49 +0000
Message-Id: <20260918032949.C3A401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] block: double put of BPF model refcount causes UAF
--

commit 2eda7a01a5e699f80e0a5c6532ed592350e8c63c
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add BPF struct_ops cost model support

This commit adds the iocost_model_ops struct_ops to allow a bound BPF
model to replace the builtin linear model on a device.

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2745bffcd5eef..c4e8c8e09bf23 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
[ ... ]
> @@ -3550,19 +3695,42 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
[ ... ]
>  unlock:
>  	spin_unlock_irq(&ioc->lock);
> =20
> +	/* resolve the name outside ioc->lock; see ioc_bpf_model_prepare() */
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
> +			spin_unlock_irq(&ioc->lock);
> +			if (IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST_BPF) && old) {
> +				iocost_bpf_model_put(old);
> +				/*
> +				 * a racing writer may have committed the same
> +				 * model after we resolved it; our resolved
> +				 * reference is then redundant
> +				 */
> +				if (old =3D=3D new)
> +					iocost_bpf_model_put(new);

[Severity: Critical]
In ioc_cost_model_write(), if a user writes the same model name twice, or
writes parameter updates to an already bound model, ioc_bpf_model_commit()
will return the same pointer as new (so old =3D=3D new).

Since we only acquired one new reference in ioc_bpf_model_prepare(), calling
iocost_bpf_model_put() on both old and new will drop two references from the
same object.

Can this underflow the reference count and cause a use-after-free on the IO
submission path in calc_cost()?

> +			}
> +		}
> +	}
> +
>  	blk_mq_unquiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918031751.1255=
420-1-cui.tao@linux.dev?part=3D1
