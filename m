Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138363B9
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608180; cv=none; b=Qfwu85xUxGOkqf4IXybTtd8cbvdPuo/SfJnhBLDnvErEeMdN7jHap4khzm9rN0VLp+NFbuWwLPPNwJGHKj98uWI7X51vv1QzXRtCi9FYVwhz9/yU3RjI6DZI/doSar2cVcsCN6D9zeAs8mWQjPcC9CCIuSatE4zt2aB5USmOGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608180; c=relaxed/simple;
	bh=e7FCXUg9eXLX6bk0LZGKpTCfpgtx95DCMYLQzN/cKQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f00W5y4WWsmAgCDbu1pvktnvTcO4bxMV8G+Wqs7rJ7HofL5o0pyZiK20zp+xR1v7E756Q6nhVNNRzWksORkfjCiiUJUnQxqeUHRKpGshzq7fjEuShZ39ozkBtBb8pVa+4OXJYwCZmmPW281AdhYSgLQkh/1tQkY9+wtfJIpOMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK0IC7mc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK0IC7mc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59883C2BCB7;
	Fri,  1 May 2026 04:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608180;
	bh=e7FCXUg9eXLX6bk0LZGKpTCfpgtx95DCMYLQzN/cKQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nK0IC7mcub2vAqmzVzYrZ+uWpWxSg0wyTor/FAw/2g0jYt2Y+WLsED796Xyt/gf2u
	 hqszY8R4orO+bNvQpISYSzrjnxQaXNW5pJh4Ia3TPnWlPer8exlE+++s+tqT8g8sVL
	 qHv63QLRIh/oJaIBWGefyh8pGFE7yG9Jl79Jl4TkPN3TGmmPIZf7OA2K9WGnAbF3wE
	 Ev/sWukci4LtwLakIBZLHQxESLP+9Qu48TYWnqUpk/aCKw8Hie6T+82Lx7D+aIOSaq
	 7Q2esJhwgRN5IbQH66LpKscjv8+GoE351AqKb2jwV7VBVfHQYI5YNobleHncygiD7/
	 UUS/+IEflVKHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] net: mana: Skip WQ object destruction for
 uninitialized RXQ
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430035935.1859220-3-dipayanroy@linux.microsoft.com>
References: <20260430035935.1859220-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 04:02:59 +0000
Message-Id: <20260501040300.59883C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Critical Use-After-Free and Double-Free in `mana_create_rxq()`=
 error path.
- [High] Incomplete Fix: The identical bug fixed in `mana_destroy_rxq()` ex=
ists in `mana_destroy_txq()`.
--

commit c317e37e7bd422dc85e0c08611eda7f514d25eef
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Skip WQ object destruction for uninitialized RXQ

This commit adds a check for INVALID_MANA_HANDLE in mana_destroy_rxq()
to prevent sending a bogus destroy command to the hardware when
mana_create_rxq() fails before the WQ object is created.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index dfb4ba9f7664..f2a6ea162dc3 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2524,7 +2524,8 @@ static void mana_destroy_rxq(struct mana_port_conte=
xt *apc,
>  	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
>  		xdp_rxq_info_unreg(&rxq->xdp_rxq);
> =20
> -	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
> +	if (rxq->rxobj !=3D INVALID_MANA_HANDLE)
> +		mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);

Does this incomplete fix leave a regression in the TX queue destruction pat=
h?

In mana_create_txq(), apc->tx_qp is allocated via kzalloc_objs(), defaulting
tx_object to 0. It is set to INVALID_MANA_HANDLE only at the start of each
queue's loop iteration.

If mana_create_txq() fails early, it calls mana_destroy_txq(apc), which
unconditionally iterates over all apc->num_queues and calls:

    mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);

For the failing queue, it sends a destroy command for INVALID_MANA_HANDLE,
and for unreached queues, it sends 0. Should mana_destroy_txq() conditional=
ly
check if tx_object is initialized before destroying it, similar to this fix?

While looking at this error path, I noticed a pre-existing regression that
is noted as fixed in a later commit (fbbff2b6d2993ad net: mana: remove
double CQ cleanup in mana_create_rxq error path).

In mana_create_rxq(), a local pointer cq is assigned to &rxq->rx_cq. If an
error occurs, it calls mana_destroy_rxq(), which frees rxq. Immediately
after, the error path checks if (cq) and calls mana_deinit_cq(apc, cq).

Since cq points into the freed rxq memory, does this result in a
use-after-free and double-free when mana_deinit_cq() reads cq->gdma_cq?

> =20
>  	mana_deinit_cq(apc, &rxq->rx_cq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430035935.1859=
220-1-dipayanroy@linux.microsoft.com?part=3D2
