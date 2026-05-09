Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E738AC7D
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315239; cv=none; b=X7kpuNB9HvLLlJYAq2mThviyzdbpvqvPDHg+ECWGJdhyqnSROUUXVCFnSXlANQFxYAa+ICthiLfxtopv8NXPORcWrXmyhgQF2MZFAMV9JuCY4lKq58R3UIqjOkGMxo1RbW1HFWW5JywYBEhi6TFE/73xBLE1lz6B54RSWemjUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315239; c=relaxed/simple;
	bh=XFwjAHXMKnGLKLb9jXdjpm/lZQFTtsQFFvrNU1D5F+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mscKNdm/u1polMB9igg5Se5v2Fx7Wjfcfmr2qFQZDPgaYc0XkDdbzBor98KvF96oqbandGwP+axgUE+8DLhSzuEGJMW538Od6bfVRH+PvO4xiQza7pmgfLqwNADOnMY3l2Dsf42pS4jynyBVrGR+C8oRQ6JOfnR9kOQWWzGcsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUnLTXxn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUnLTXxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70F6C2BCB2;
	Sat,  9 May 2026 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315239;
	bh=XFwjAHXMKnGLKLb9jXdjpm/lZQFTtsQFFvrNU1D5F+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FUnLTXxnFmTpcEWo3xBI46e775D/B79/bCxppc1aG1qiMYHdUrF7OFmwnTzzuO6iT
	 TcJ/wGEivXDcufVmceyaJipKxlvDLJOif8GjFaKuMN92tAqcAodAgIPbkCspfOEj+J
	 1KsrtFF32cWZ6USylOu/npwCquoXJfv6IKfKpGwG8STYPnGI/SPVeb88rU1RDhDmNd
	 nWgSLx5LeZvcfE3Ber8q6TbvshBs7rnbEhlIcim1PLPoLVhZKVF4KC8dLV+U7321K1
	 iARkumOkL602c3JDZvMBH3RpyrP0PqLt6yRDuQHVg+TLtzRK3tqeZx9lAYZlRoCk/T
	 4R2ah2Y0OQ3/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 04/13] net: lan966x: add FDMA LLP register
 write helper
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508-lan966x-pci-fdma-v4-4-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-4-14e0c89d8d63@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:27:18 +0000
Message-Id: <20260509082718.D70F6C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Moving LLP register initialization out of `lan966x_fdma_rx_start()=
` breaks the MTU change error recovery path.
- [High] The return value of `fdma_dcbs_init()` is ignored in `lan966x_fdma=
_rx_alloc()`, causing page leaks and the activation of uninitialized DMA de=
scriptors on failure.
- [High] Destroying the page pool on the error path in `lan966x_fdma_rx_all=
oc()` without unregistering it from the XDP RX queues leaves dangling point=
ers.
- [High] The `restore:` error path in `lan966x_fdma_reload()` contains a se=
vere hardware/software ring desync bug.
--

commit 2fddff57a8bf4d213ae07c8fe84e8040a60982cb
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA LLP register write helper

The patch introduces a helper lan966x_fdma_llp_configure() and moves the
FDMA Link List Pointer (LLP) register initialization from the start/activate
functions into the allocation functions.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc09..6c5761e886d47 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c

[ ... ]

> @@ -127,6 +134,9 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *r=
x)
>  	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
>  		       FDMA_DCB_STATUS_INTR);
> =20
> +	lan966x_fdma_llp_configure(lan966x, (u64)fdma->dma,
> +				   fdma->channel_id);
> +
>  	return 0;
>  }

This isn't a bug introduced by this patch, but does lan966x_fdma_rx_alloc()
leak pages and activate uninitialized DMA descriptors on failure?

During lan966x_fdma_rx_alloc(), fdma_dcbs_init() invokes the callback
lan966x_fdma_rx_dataptr_cb() to populate the DMA buffer rings. This callback
dynamically allocates pages using page_pool_dev_alloc_pages() and returns
-ENOMEM on failure, which causes fdma_dcbs_init() to return -ENOMEM.

However, lan966x_fdma_rx_alloc() completely ignores this return value and
returns 0.

Will this cause all successfully allocated pages up to the failure point to
be leaked, and trick the caller into activating the hardware DMA engine with
partially uninitialized DCBs, leading to IOMMU faults or memory corruption?

This isn't a bug introduced by this patch either, but does the error path in
lan966x_fdma_rx_alloc() leave dangling pointers in the XDP RX queues?

In lan966x_fdma_rx_alloc(), lan966x_fdma_rx_alloc_page_pool() registers the
newly created page pool with the XDP memory model across all physical ports
via xdp_rxq_info_reg_mem_model(), overwriting the old registration.

If the subsequent fdma_alloc_coherent() fails, the error path invokes
page_pool_destroy(rx->page_pool) but fails to restore the old page pool
registration:

	err =3D fdma_alloc_coherent(lan966x->dev, fdma);
	if (err) {
		page_pool_destroy(rx->page_pool);
		return err;
	}

When lan966x_fdma_reload() falls back to the restore: path, it resumes
network operations.

Could this leave a dangling pointer to the destroyed page pool in the
xdp_rxq structures, leading to a use-after-free when XDP processes the next
packet?

> @@ -136,14 +146,6 @@ static void lan966x_fdma_rx_start(struct lan966x_rx =
*rx)
>  	struct fdma *fdma =3D &rx->fdma;
>  	u32 mask;
> =20
> -	/* When activating a channel, first is required to write the first DCB
> -	 * address and then to activate it
> -	 */
> -	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP(fdma->channel_id));
> -	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP1(fdma->channel_id));
> -

Will moving the LLP register configuration into lan966x_fdma_rx_alloc() bre=
ak
the MTU change error recovery path?

In lan966x_fdma_reload(), if the new lan966x_fdma_rx_alloc() fails, the code
jumps to the restore: label, copies back the old software state, and calls
lan966x_fdma_rx_start() to reactivate the channel:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_reload()=
 {
    ...
	err =3D lan966x_fdma_rx_alloc(&lan966x->rx);
	if (err)
		goto restore;
    ...
restore:
	lan966x->rx.page_pool =3D page_pool;
	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
	lan966x_fdma_rx_start(&lan966x->rx);
    ...
}

Because lan966x_fdma_rx_alloc() is bypassed for the restored state, the
hardware channel is activated without configuring the LLP.

Since the LLP must be written before the channel is activated, won't
activating the channel after a disable and discard cycle without
reprogramming the LLP result in a DMA fault or system hang?

This isn't a bug introduced by this patch, but does the restore: error path
in lan966x_fdma_reload() contain a hardware/software ring desync issue?

When MTU allocation fails, the driver restores the fdma_rx_old software
state, which contains the old non-zero dcb_index and db_index from when the
ring was active.

However, before this patch, lan966x_fdma_rx_start() unconditionally set the
hardware LLP register to fdma->dma (index 0).

Does this cause the hardware DMA engine to start writing at DCB 0, while the
software's napi_poll routine resumes polling from the restored non-zero
dcb_index? Could this complete desync between hardware and software ring
indices lead to a dead RX path or the processing of stale memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-lan966x-pc=
i-fdma-v4-0-14e0c89d8d63@microchip.com?part=3D4
