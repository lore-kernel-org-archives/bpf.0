Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3B4562AF
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543614; cv=none; b=JffIdReHSlMGNfC1KhNFcm9ddbVFUgExuiZmqu39BFLOi9wNCndax2ivEU+jv1AQYp7SoC5Ys0wynr6ghmJd3frttGXHGBha+HBgZNHo97Xk38gBc/IJ5iie6FrYqk76P/BTW5T00otCKId2/hif2U1dulp+obntCR2YEJbyHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543614; c=relaxed/simple;
	bh=mv1hzN8Db689gZBJCF9Dedv6KFhD6K7BNvgmryLG/XM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0AG77vOX9H2hn46mMDYYj2o4UDKQQ/7DlvoVemI3eCmbQNzyTin19T3SjAIoAqf7el/vBfrNdNGSrxLBh/dt5EwvsMWjiE0cKllix+pmrB8SIPrigAj4xEbAVwUHscDSZzTRwIqHX7cQQ5J4opiilcSjNcj1cOoeXBCvFCEtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV011s3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV011s3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D501F00893;
	Wed, 16 Sep 2026 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543603;
	bh=gJHz5e0w9OVry2SAxAQ+SSYjJDNkEdloBd+vniY5hrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gV011s3enbRkkoSa/ArqNCUf/r8i+PG+LD/DFvWaWOthOXWh0nZUlG3OdY4mge+4Q
	 SmO++Id5H3wFXFdVARc7M8DqTH69NydNuL/1uDFNM2RpyY5Oxy8jGmUJkBMxyBmwVS
	 udcDQkgbIUbqSidz4leYeR143XJElJ9AwIT9226xV1qlW6BWXppTph1c2+YznUNl+p
	 pwzOS5HeYm098GWFI111RXs0F4KeeN3RSe5P7AVVHcL5ok4lfHyxu1U8BMOhOwsCQm
	 DkelSCGihTzDT83v2gG+rgQSGMa438nZUcHB4ZkEXF6TTKtJbo4EMsFQ0L+Amhavfp
	 mHaw8gd6/iu4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] blk-iocost: add BPF struct_ops cost model support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: mkoutny@suse.com, tj@kernel.org, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <20260916071740.1068341-2-cui.tao@linux.dev>
References: <20260916071740.1068341-1-cui.tao@linux.dev>
 <20260916071740.1068341-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:26:42 +0000
Message-Id: <20260916072643.28D501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: premature removal from lifecycle list causes map/memory leaks
--

commit e92f1828b80c32e5c3b26c9b38e384109bedf0de
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add BPF struct_ops cost model support

Add the iocost_model_ops struct_ops: a bound BPF model fully replaces
the builtin linear model on a device.

> diff --git a/block/blk-iocost-bpf.c b/block/blk-iocost-bpf.c
> new file mode 100644
> index 0000000000000..7f1f9a2e51cb2
> --- /dev/null
> +++ b/block/blk-iocost-bpf.c

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
[Severity: High]
If a single registered BPF iocost model is bound to multiple block devices
and one of them unbinds it, does this skip the cleanup block entirely on
subsequent unbinds?

Because the model is prematurely removed from the lifecycle list below,
subsequent unbinds will fail to find it in the loop above.=20

This causes iocost_bpf_model_put() to return early, permanently leaking BPF
struct_ops map references and iocost_bpf_model structures, as well as missi=
ng
blkcg online/offline notifications for active bindings.

> +		bool freed =3D refcount_dec_and_test(&m->refs);
> +
> +		/* leave the notify list with the last binding: the
> +		 * remaining ref is either the registry's (node still on
> +		 * iocost_bpf_models) or zero and the node is freed
> +		 */
> +		if (freed || !list_empty(&m->list))
> +			list_del(&m->lifecycle);
[Severity: High]
Can this condition cause the model to be removed from the lifecycle list on
the very first unbind?

The condition !list_empty(&m->list) evaluates to true unconditionally for
any registered model because m->list remains actively linked in the
registry (iocost_bpf_models) until it is unregistered.

> +		mutex_unlock(&iocost_bpf_reg_lock);
> +		bpf_struct_ops_put(ops);
> +		if (freed)
> +			kfree(m);
> +		return;
> +	}
> +	mutex_unlock(&iocost_bpf_reg_lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916071740.1068=
341-2-cui.tao@linux.dev?part=3D1
