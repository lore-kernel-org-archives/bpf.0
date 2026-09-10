Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E548EC60
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045315; cv=none; b=S7vsp9BN0Z6HSmMlm+cCqV5uhcaZpYMFSAykDSFol285SjRp15JkcAVJyTehyZFt96aqzuhdSwsBI51Md3ycyF1sH2rToNQQn+ML9l/El0kyuBXhQ//2mO4iu+ZR/9/6xyx7PnCslXShL6/kku1FUxZQu+tAGt4fEhCdC1JSufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045315; c=relaxed/simple;
	bh=3u3L0jS5mN21vSMhqHoMqXaRSCYebK82JOztoawc1ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HcyYK21f7XkKGOmeDYIY5X7yLr+Q4mcCCT2Aym2UUppkfuKKtFxvH7+HzgwueL7Fp3YUr2UMeUrBR3annhb0NFki2gEwkPmn3GlLLkUzYWYnnyZyH8DQGLofN8K14WrpdzyD82+qSwlgO08Lot9k/8Hpja/fw6j1NjYYr/orUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4gxmb5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4gxmb5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A521F00898;
	Thu, 10 Sep 2026 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045311;
	bh=F9Nc8g1oGDkMF37eA4tqocpSFo8Rmi/usGPci/jv57g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4gxmb5xd4tqaOk+C+Mkl56LD1IKkRKRUz5te7QgjFEAZeD/rSbqYN2ranD24FoV4
	 Wss+7fUAUDkxuFyg5EwIhx9X0vWG5Py3QMWO3HmYfDZsMfhuRMGhS6cOWTQafdhIM9
	 /6b5wfA7tcBJlP2Wj1yCgBtIsBwzzo/WdsT3pbJw4F0gbxZv7+EkzAJ6676xpSWE/2
	 e7y/dFazVtwpK4tdJaYaUhwkWPlUGsDzLiM7g8+MwYu5T33JGipgVZagu5Sf6kpOd5
	 GHv7f8ElWDuYaXRrIF9939V2V6nyt974KDajhjV/whVxpotkKU9SgaUnyQwMEjacLh
	 s0JoztZHhOkUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 09/14] net: lan966x: add shutdown callback
 to stop FDMA on reboot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909-lan966x-pci-fdma-v6-9-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
 <20260909-lan966x-pci-fdma-v6-9-6f48dab9d671@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:01:51 +0000
Message-Id: <20260910130151.B2A521F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Early return in `lan966x_shutdown` bypasses required `ANA_ANAINTR`=
 masking for non-FDMA configurations.
- [High] Concurrent XDP redirect operations can re-arm the FDMA TX channel =
after `lan966x_shutdown` has disabled it.

Pre-existing issues:
- [High] Missing `dma_wmb()` and incorrect ordering when appending a DCB to=
 the FDMA ring.
- [High] Teardown race in `lan966x_remove` causing use-after-free and doubl=
e-free with concurrent `ndo_change_mtu`.
--

commit 3c2ffa8799eedb58249177a7fb0968ccfc34255a
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add shutdown callback to stop FDMA on reboot

This commit adds a shutdown callback to disable NAPI, stop TX queues,
and disable RX/TX channels. It also masks interrupts to prevent the
FDMA engine from asserting the shared PCIe INTx line across a host reboot.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 11094a381ec2a..d6ce1e3e373fd 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
[ ... ]
> @@ -1324,9 +1324,35 @@ static void lan966x_remove(struct platform_device =
*pdev)
>  	debugfs_remove_recursive(lan966x->debugfs_root);
>  }

[Severity: High]
This is a pre-existing issue, but does this teardown sequence in
lan966x_remove() contain a use-after-free or double-free race?

It appears that lan966x->ops->fdma_deinit(lan966x) is called to free the DMA
memory before lan966x_cleanup_ports() unregisters the netdevs, all without
holding rtnl_lock().

Can a concurrent "ip link set mtu" trigger ndo_change_mtu() and race to free
and reallocate the exact same coherent DMA memory?

> +static void lan966x_shutdown(struct platform_device *pdev)
> +{
> +	struct lan966x *lan966x =3D platform_get_drvdata(pdev);
> +
> +	if (!lan966x->fdma)
> +		return;
> +

[Severity: High]
Does this early return bypass the required ANA_ANAINTR masking for non-FDMA
configurations?

If the switch is used on PCIe without FDMA (register-based I/O), this will
return early because !lan966x->fdma, failing to mask ANA_ANAINTR which is
armed unconditionally.

Will the shared INTx line remain asserted across a warm reboot, causing a h=
ost
interrupt storm?

> +	/* The reload paths disable this NAPI under rtnl; serialize with them. =
*/
> +	rtnl_lock();
> +
> +	if (lan966x->fdma_ndev)
> +		napi_disable(&lan966x->napi);
> +
> +	lan966x_fdma_tx_disable_netdev(lan966x);
> +
> +	lan966x_fdma_rx_disable(&lan966x->rx);
> +	lan966x_fdma_tx_disable(&lan966x->tx);
> +
> +	lan_wr(0, lan966x, FDMA_INTR_ENA);
> +	lan_wr(0, lan966x, FDMA_INTR_DB_ENA);

[Severity: High]
Can concurrent XDP redirect operations re-arm the FDMA TX channel after it
has been disabled here?

lan966x_shutdown() disables the TX channel and clears tx->activated. Howeve=
r,
if a concurrent XDP_REDIRECT from another device calls ndo_xdp_xmit() ->
lan966x_fdma_xmit_xdpf() -> lan966x_fdma_tx_start(), it will see tx->activa=
ted
is false and take the activation path:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_tx_start=
() {
	if (likely(lan966x->tx.activated)) {
		lan966x_fdma_tx_reload(tx);
	} else {
		/* Because it is first time, then just activate */
		lan966x->tx.activated =3D true;
		lan966x_fdma_tx_activate(tx);
	}
}

Since ndo_xdp_xmit() runs without rtnl_lock() and ignores stopped netdev
queues, will it actively re-arm FDMA_INTR_DB_ENA and FDMA_CH_ACTIVATE
post-shutdown, leaving hardware channels active across a warm reboot and
causing memory corruption?

> +	lan_wr(0, lan966x, ANA_ANAINTR);
> +
> +	rtnl_unlock();
> +}

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing dma_wmb()
and incorrect ordering when appending a DCB to the FDMA ring?

In __fdma_dcb_add(), the new DCB is linked into the active hardware ring
before its struct fields are initialized:

drivers/net/ethernet/microchip/fdma/fdma_api.c:__fdma_dcb_add() {
	err =3D dcb_cb(fdma, dcb_idx, &fdma->last_dcb->nextptr);
	if (unlikely(err))
		return err;

	fdma->last_dcb =3D dcb;

	dcb->nextptr =3D FDMA_DCB_INVALID_DATA;
	dcb->info =3D info;
}

Because dcb_cb() writes to the previous DCB's nextptr without a memory
barrier, can the hardware engine immediately follow the updated nextptr and
read the uninitialized new DCB, leading to DMA faults or memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-lan966x-pc=
i-fdma-v6-0-6f48dab9d671@microchip.com?part=3D9
