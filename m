Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947835028D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229629; cv=none; b=N7aqryBPlBD+NIwNbEbx2quBoy6L78hoqoFxwq3OUDf4aQCqQyzKNPqUIdEIAWkuPXo2SiFn8nJpmVEVYKvSKCyV8FTSnV9kjN8fhPWgqso3E0JRizA+CksGvGUPrnbmuiM+qyai7t2LsuTqk+/biSCP2v0xspGVWznBIjHKRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229629; c=relaxed/simple;
	bh=UYPV0/iG7yqbi4O2tSFli/zibku2ksw0Q7fm9ihoLBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QnQwzuPA59YeMta9y4QTcSafGgId1RVF7NBisrIDQqxHVnN5WpWPjupUpm12iO/sKXGb8Qwskt9typVlgad30KIGd3jEgOQrsKr5w+dafZBuBHQ8bRkJGedKK8sUXRmKkU0OFJM8L8HYDVmx93wikAGWGeUtquLTcfMmXj23pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmwRw1UC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmwRw1UC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3E41F000FF;
	Thu, 24 Sep 2026 06:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229628;
	bh=x6aB/edzbgnrPiKsli8KpSwyWZtK4MQG4BjUyAl54SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmwRw1UCLPVSGusB8VmZ7O/gX/ZS2ELC2ths8+BCI01x8SB+dREGv8mW25TaMHtEA
	 xpX/E7KVJAiIUpU/Rb6yADFPertqUMXWpgtZtQe3FMDSDPOVJyzSwDBqX9dvafIa+9
	 KoJajQr9X3ugkIXu0rLB3nuemcjtk6CKa6MBu26KClmRzXyaUkbUa+aoYsAimXtkfl
	 E52MA+xaNSy4B3Ajhhv3RfQQs4dZydQliR9hmgQoROHWjZpzwucuscTzvKeJBUJ4Tr
	 Frv5ICFz5+uMfbPI1PnOVcDY22FlvMlZ5fTgrr067ZPzRtBz0t+5Nfx82wjX6CKv3s
	 oFTkQqA8ZVmyQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 1/4] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <20260924054549.2271705-2-cui.tao@linux.dev>
References: <20260924054549.2271705-1-cui.tao@linux.dev>
 <20260924054549.2271705-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:00:27 +0000
Message-Id: <20260924060027.AE3E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] block: direct 64-bit division in calc_size_vtime_cost()
--

commit 848a45831f82ba85b8460e41c4e1203c6310b105
Author: Tao Cui <cuitao@kylinos.cn>
blk-iocost: add BPF struct_ops cost model support

This commit adds the iocost_model_ops BPF struct_ops type, allowing BPF
programs to replace the built-in linear cost model for blk-iocost. It attac=
hes
per-device following the hid_bpf_ops model and takes over pricing for every=
 IO
on the device.

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2745bffcd5eef..21e4f8cbd9f25 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c

[ ... ]

> @@ -2594,10 +2620,41 @@ static void calc_size_vtime_cost_builtin(struct r=
equest *rq, struct ioc *ioc,
>  	}
>  }
> =20
> +/*
> + * Called from the request completion path, where no ioc->lock is
> + * held; the model pointer is read under RCU, matching the bio-side
> + * calc_vtime_cost().
> + */
>  static u64 calc_size_vtime_cost(struct request *rq, struct ioc *ioc)
>  {
>  	u64 cost;
> -
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
> +	const struct iocost_model_ops *model;
> +
> +	rcu_read_lock();
> +	model =3D rcu_dereference(ioc->model);
> +	if (model && (req_op(rq) =3D=3D REQ_OP_READ ||
> +		      req_op(rq) =3D=3D REQ_OP_WRITE)) {
> +		unsigned int pages =3D
> +			blk_rq_stats_sectors(rq) >> IOC_SECT_TO_PAGE_SHIFT;
> +		u64 coeff =3D req_op(rq) =3D=3D REQ_OP_READ ?
> +			model->read_vtime_per_page :
> +			model->write_vtime_per_page;
> +
> +		rcu_read_unlock();
> +		/* sub-page IO: nothing to transfer-price */
> +		if (!pages)
> +			return 0;
> +		/* zero transfer cost is a legal model; guard the division */
> +		if (!coeff)
> +			return 0;
> +		/* pages * coeff can wrap and dodge the clamp below */
> +		if (coeff > VTIME_PER_SEC || pages > VTIME_PER_SEC / coeff)

[Severity: Low]
Does this direct 64-bit division cause build failures on 32-bit architectur=
es?

Using the division operator for 64-bit integers like VTIME_PER_SEC / coeff=
=20
forces the compiler to emit a call to __udivdi3, which is omitted in the=20
Linux kernel and results in an undefined reference link-time error when=20
CONFIG_BLK_CGROUP_IOCOST_BPF is enabled.=20

Could this be changed to use div64_u64() instead?

> +			return VTIME_PER_SEC;
> +		return min(pages * coeff, VTIME_PER_SEC);
> +	}
> +	rcu_read_unlock();
> +#endif
>  	calc_size_vtime_cost_builtin(rq, ioc, &cost);
>  	return cost;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924054549.2271=
705-1-cui.tao@linux.dev?part=3D1
