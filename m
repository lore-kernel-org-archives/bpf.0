Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A163B9
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608179; cv=none; b=YHQ82XDmo8V983/Sealu2BBqIQmx+TixOxI9KPRR/xbfC2+elHtzHGvakwWN4va5SSZgwtoPfn39MTBLI7q4uGCnMuuTsReWxPNDvgLFTf10FZC/PfjAudo3qLq0YXM85RQYUhGDfEwADtv+GtctvoNY5uuAaVgHd8cxIG6XgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608179; c=relaxed/simple;
	bh=fbYjc1SnW16fO2Hi7YSubHklJbEpTgqSYE0sgGScESY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hemmoPBwhhv4V9fDl8P4k7Z6F80yyQlHHApT13H8qHLWhzWp4mPTGviGG+r9GZBv/pmGJFxlDB8VF1E//hvsXHkFg5b36ROcSd2yQlKp1x7FIdOdLXEKRiVL/y6ls1JVh7Xd45ENnIWL9S116yxVJy9jACHIDk9WljGKKEJblkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf9+Jc7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf9+Jc7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADB7C2BCB7;
	Fri,  1 May 2026 04:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608179;
	bh=fbYjc1SnW16fO2Hi7YSubHklJbEpTgqSYE0sgGScESY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kf9+Jc7Yfb8GY9YyXACmLNcamNZ+RL69KOobZc5MasF25NqFkPv6yGTJUc+mKym83
	 diZ2TPQ0/OC99Lf68eRf/GLNgVolxS88en+QvKNgrqJJ7fChHsLUucPSU4OYQTZ/5i
	 sLjmSVdAeaUI/KP0vkMxutn2quFGoBWuZcD+GFsWA9HQ33A3+MDTfyIvJZkB3xcrWd
	 HIoPZozXN/vMsZJnjlcErkU68BxDDSStmFpHHbZeClfxT47pLC6uQ2mylYu35j/C/h
	 7paf4ozmrRco0rwDi8pI5gkxHkKxHsqjGHUMS2EEhUwob36JObylNL/Vo0dHh3leyN
	 5hRD5QCSpJ8Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] net: mana: check xdp_rxq registration before unreg
 in mana_destroy_rxq()
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430035935.1859220-2-dipayanroy@linux.microsoft.com>
References: <20260430035935.1859220-2-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 04:02:58 +0000
Message-Id: <20260501040259.4ADB7C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Ignored return values for XDP memory model registration leads to p=
age pool leaks
- [High] Hardware state corruption by requesting destruction of handle 0 in=
 TX queue error path
--

commit 981d87e9d96d90f1ed0564dfd6bbd85f261ecd6d
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>
net: mana: check xdp_rxq registration before unreg in mana_destroy_rxq()

When mana_create_rxq() fails before xdp_rxq_info_reg() is called, the error
path calls mana_destroy_rxq(). Guard xdp_rxq_info_unreg() with
xdp_rxq_info_is_reg() to prevent unregistering a never-registered xdp_rxq.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index a654b3699c4c..dfb4ba9f7664 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2520,7 +2520,9 @@ static void mana_destroy_rxq(struct mana_port_conte=
xt *apc,
>  		napi_disable_locked(napi);
>  		netif_napi_del_locked(napi);
>  	}
> -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +
> +	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
> +		xdp_rxq_info_unreg(&rxq->xdp_rxq);

This problem wasn't introduced by this patch, but it is a pre-existing logic
error not fixed later in the series.

In mana_create_rxq(), the calls to xdp_rxq_info_reg() and
xdp_rxq_info_reg_mem_model() are wrapped in WARN_ON() but their negative
return codes are never assigned to err or handled:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_create_rxq() {
    ...
	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
				 cq->napi.napi_id));
	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
					   rxq->page_pool));

	napi_enable_locked(&cq->napi);
    ...
}

If xdp_rxq_info_reg_mem_model() fails (e.g., due to an ida_alloc failure
under memory pressure), the warning is printed but the queue creation
successfully completes.

Consequently, rxq->xdp_rxq is left with a zeroed mem_info.type
(MEM_TYPE_PAGE_ORDER0).

When an XDP program drops or redirects packets, will xdp_return_frame() read
the incorrect memory type and call put_page() instead of returning the page
to the page_pool?

Does this permanently leak the page_pool inflight count, resulting in an
indefinite system hang when page_pool_destroy() is called during interface
teardown?

>  	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);

This problem wasn't introduced by this patch, but it is a pre-existing flaw.

While a subsequent patch in the series ('net: mana: Skip WQ object destruct=
ion
for uninitialized RXQ') fixes a similar issue for RX queues by checking for
INVALID_MANA_HANDLE, the same issue remains unaddressed for TX queues.

In mana_create_txq(), apc->tx_qp is zero-allocated. The initialization loop
assigns tx_object =3D INVALID_MANA_HANDLE only when it reaches index i.

If initialization fails early (e.g., at i =3D 0), the error path calls
mana_destroy_txq(), which iterates over all apc->num_queues and
unconditionally calls mana_destroy_wq_obj():

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_create_txq() {
    ...
	apc->tx_qp =3D kzalloc_objs(struct mana_tx_qp, apc->num_queues);
    ...
	for (i =3D 0; i < apc->num_queues; i++) {
		apc->tx_qp[i].tx_object =3D INVALID_MANA_HANDLE;
    ...
		err =3D mana_create_wq_obj(apc, apc->port_handle, GDMA_SQ,
					 &wq_spec, &cq_spec,
					 &apc->tx_qp[i].tx_object);

		if (err)
			goto out;
    ...
out:
	netdev_err(net, "Failed to create %d TX queues, %d\n",
		   apc->num_queues, err);
	mana_destroy_txq(apc);
	return err;
}

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_destroy_txq() {
    ...
	for (i =3D 0; i < apc->num_queues; i++) {
    ...
		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
    ...
}

For all unvisited queues, tx_object will be 0 (from kzalloc).

Since mana_destroy_wq_obj() does not validate the handle, could this
inadvertently ask the hardware to destroy handle 0, which might be a valid,
unrelated queue, and corrupt the hardware state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430035935.1859=
220-1-dipayanroy@linux.microsoft.com?part=3D1
