Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795618DF80
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837767; cv=none; b=QpaVSCZ5kxAv49SS4vbSqOg/cNemLXdOBZVm0hmbqhEQ7IKccC19BSnGaXBA9UVprcKvSTTdt8yrXdRO2AcWjkyK36beHxEbSXrH8oK0Fefv5mZDScXtIEt5Zn0iAou0NDCoPzMKiRD0wYjuLRhkBjgGsEbkEwI1DQuGYPcTH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837767; c=relaxed/simple;
	bh=LeqP7zdpPSW8w0yzFcur2Manes8xWGZC95IBymG6LAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S/F5VoAxS+8BhKBMKB4c03V+hqBhdZwwXGH+aFun1sYEwNlCm0wNm4kRNXl5sX9EPsl+um05wajUt1jyiHhHTKkW8HikkICQcrWsivWcgGRaDZUF/tvV0Aj6Vmy/oub5xhh8Pkr6vwC9npTfQawMmf1NGRRAUP4CZ9MzvQWVyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNVOFgKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNVOFgKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8CC1F000E9;
	Sat, 15 Aug 2026 23:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837765;
	bh=12Oskv9zG0IMS8oiwT9sJQp8pcShZ5UFc62F/SK8EVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KNVOFgKlY4TIAy1HVtnvDljJOcEzPg5h1v2YK9uHuJJbze6oNsTKwnE/TLmMYPTxp
	 F7yhBxeq/NRQ1ABKDvGuj72aQqUuSTicOCYjdqEuhnfeh2XT4mcxpmYdpHte9tu9sw
	 XMFltcktrs604oDmQxpjmqoK0eAud3xARPZ9KdUMnG8dY9p5gWM9bqUR3vwZLsEVyJ
	 N+q2hV/trft8DumIMUEY4vUg9wTGDtAsUa9aujuaul2j+66JGHsdGHTXa8H6Z5N+Kz
	 NpRbkUE6Zk0OaujjjpphNcKnr04YCbIwu5f736UglWbBF8Flj9ghb1mzX6hd77FjC2
	 onMFBWdXQqDfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 4/6] gve: don't register xsk pool on pre-existing
 queues in RDA mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814234845.773189-5-joshwash@google.com>
References: <20260814234845.773189-1-joshwash@google.com>
 <20260814234845.773189-5-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:49:25 +0000
Message-Id: <20260815234925.7F8CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Enabling XSK pools in QPL mode registers the memory model dyna=
mically without disabling NAPI or restarting queues, leading to data races =
and kernel panics.
- [Critical] Disabling XSK pools in QPL mode fails to restart queues, causi=
ng in-flight XSK buffers to be incorrectly freed as normal shared pages.
- [High] `gve_xsk_pool_disable()` incorrectly unregisters the newly created=
 `PAGE_POOL` memory model for RDA queues, destroying the active page pool a=
nd causing memory corruption/leaks.
--

--- Patch [4]: [PATCH net 4/6] gve: don't register xsk pool on pre-existing=
 queues in RDA mode ---
commit 9bd2a484cf9beb93c90ecf2a602f481574145671
Author: Joshua Washington <joshwash@google.com>

gve: don't register xsk pool on pre-existing queues in RDA mode

This commit addresses a race condition in RDA mode when enabling XSK pools =
on
pre-existing queues without re-creating them. It ensures that the XSK pool =
is
only registered with current queues if XSK buffers are allocated on-the-fly,
as is the case in QPL mode.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1654,20 +1654,18 @@ static int gve_xsk_pool_enable(struct net_device =
*dev,
>  	if (!priv->xdp_prog || !netif_running(dev))
>  		return 0;
> =20
> -	err =3D gve_reg_xsk_pool(priv, dev, pool, qid);
> -	if (err)
> -		goto err_xsk_pool_dma_mapped;
> -
> -	/* Stop and start RDA queues to repost buffers. */
> -	if (!gve_is_qpl(priv)) {
> +	if (gve_is_qpl(priv)) {
> +		err =3D gve_reg_xsk_pool(priv, dev, pool, qid);
> +		if (err)
> +			goto err_xsk_pool_dma_mapped;

[Severity: Critical]
This isn't a bug introduced by this patch, but does enabling XSK pools in Q=
PL
mode lead to a race condition since it registers the memory model dynamical=
ly
without disabling NAPI or restarting queues?

If the NAPI softirq processes pre-existing standard buffers that were posted
before the pool was enabled, and the XDP program returns XDP_TX or
XDP_REDIRECT, gve_xdp_tx_dqo() will see rx->xsk_pool =3D=3D true:

drivers/net/ethernet/google/gve/gve_rx_dqo.c:gve_xdp_tx_dqo() {
    ...
    if (unlikely(!xdpf)) {
        if (rx->xsk_pool)
            xsk_buff_free(xdp);
        return -ENOSPC;
    }
    ...
}

Will this cause xsk_buff_free() to incorrectly assume the stack-allocated
xdp_buff is a struct xdp_buff_xsk, leading to a kernel NULL pointer
dereference?

> +	} else {
> +		/* Stop and start RDA queues to repost buffers. */
>  		err =3D gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
>  		if (err)
> -			goto err_xsk_pool_registered;
> +			goto err_xsk_pool_dma_mapped;
>  	}
>  	return 0;
> =20
> -err_xsk_pool_registered:
> -	gve_unreg_xsk_pool(priv, qid);
>  err_xsk_pool_dma_mapped:
>  	clear_bit(qid, priv->xsk_pools);

[Severity: Critical]
This is a pre-existing issue, but does disabling XSK pools in QPL mode fail=
 to
restart queues, leaving in-flight XSK UMEM buffers to be processed with an
unregistered memory model?

In gve_xsk_pool_disable():

    napi_disable(napi_tx);
    gve_unreg_xsk_pool(priv, qid);
    smp_mb();
    napi_enable(napi_rx);

If the QPL queues are not restarted, previously allocated XSK buffers remai=
n in
the hardware RX ring.

When these XSK buffers are processed by the resumed NAPI, will they be
initialized with the MEM_TYPE_PAGE_SHARED memory model instead of
MEM_TYPE_XSK_BUFF_POOL?

Could this lead to xdp_return_frame() calling page_frag_free() on an AF_XDP
UMEM address instead of returning it to the XSK pool, corrupting the page
allocator?

[Severity: High]
This is a pre-existing issue, but does gve_xsk_pool_disable() incorrectly
unregister the newly created PAGE_POOL memory model for RDA queues?

In gve_xsk_pool_disable():

    if (!gve_is_qpl(priv) && priv->xdp_prog) {
        err =3D gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
        if (err)
            return err;
    }
    ...
    gve_unreg_xsk_pool(priv, qid);

For RDA mode, gve_configure_rings_xdp() properly initializes and registers =
the
new queue with MEM_TYPE_PAGE_POOL.

However, immediately after the restart, the driver unconditionally calls
gve_unreg_xsk_pool():

drivers/net/ethernet/google/gve/gve_main.c:gve_unreg_xsk_pool() {
    ...
    if (xdp_rxq_info_is_reg(&rx->xdp_rxq))
        xdp_rxq_info_unreg_mem_model(&rx->xdp_rxq);
    ...
}

Will this actively invoke page_pool_destroy() on the newly created page pool
and reset the memory type to MEM_TYPE_PAGE_SHARED?

If so, could packets from this queue bypass page_pool_put_full_netmem() on
free, causing memory leaks and a use-after-free since the page pool was mar=
ked
for destruction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814234845.7731=
89-1-joshwash@google.com?part=3D4
