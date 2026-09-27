Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB6311C36;
	Sun, 27 Sep 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524207; cv=none; b=RyNHnlVLo6LOn87lxql9s6dI8TKpc/wzP6HxUCoFZT2Zi4ENdkCTtOUG8BoFYfLGRChEofhnI3mf0lUXyEJclKzUe4WUK/LNsJ+gH3/L6QVrzhHlvYVj1WYiByRF/A2JGE7Vfjyewd7bs2QR8tgnfp7Szox+vxsewOoW8HCxAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524207; c=relaxed/simple;
	bh=SsIlTe/COksALkcnNGKniH0Jyx+LYtC8MaMwYjfRIdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SA9ZerxlhTi8yVGrGazeCMsdHw1Nztilf8LWTPiu+cTKFLnLgO4Dqc4Y3EgFsgzQC63d3UqcGbcls/ioOQR4Wmw28XETogbP5Q26+X7Hlm9jXMx18dhDixW9RSm3aw8YHSdkekMnv4zvPxAdVRNyImjZJKb7iAUsHrXpeh5ZYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoembLsq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoembLsq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527C91F00898;
	Sun, 27 Sep 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790524206;
	bh=eLKk0DCCAYmM/9NM67jewK32zLHnYmhVguo1OF6SALQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QoembLsqzRRnMa6XmbYO/4uvYI39KDkMS0OHgaWvJfzlx/y7P0Kw89iDk9a9mQJuE
	 h3YxCsjZlit4TEm9u6mRDIztCmSksMlLCINHD9nXn79461JLpM+49CDMMDXcUph9mw
	 cat6GRKzt7mSQrJ3E/hvEHR60OJ9eI2csOgtCxLnYl0BTklIbChuxNU0Nd3J/5rf9o
	 pPZDYYRQV6Em9l+CL2OPJYbzfmwMG8OziDoukbiE8MokR2JvYnLMgNEFuuOWtIbmTE
	 SBwN4071jlguCPnuoNPBlPHlRnt6dH6tYzXqbq9RBWpKcOMlC2kejCDzJpe8BcOaQ1
	 jtk1oYxxhceaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 13/15] net: stmmac: retain DMA memory until
 hardware shutdown completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-sunxi@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-13-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
 <20260926-submit-stmmac-reset-fixes-v1-v4-13-ec1c0250b3c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 15:50:05 +0000
Message-Id: <20260927155006.527C91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] net: stmmac: GMAC4/XGMAC DMA memory corruption on resume due t=
o missed descriptor reinit
- [Critical] net: stmmac: hardware UAF/memory corruption on failed DMA shut=
down for AF_XDP
--

commit d5468125f4e40d54601ca95b471fb3b78f38dc5d
Author: James Hilliard <james.hilliard1@gmail.com>

net: stmmac: retain DMA memory until hardware shutdown completes

This commit updates the stmmac driver to wait for the hardware DMA to
actually stop before releasing the descriptor rings and buffers. If the
hardware fails to idle, it falls back to a global reset or explicitly
retains the memory to prevent use-after-free by the hardware. It also
updates AF_XDP pools to handle the delayed release properly.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -2481,14 +2554,36 @@ static int alloc_dma_desc_resources(struct stmmac=
_priv *priv,
> +static void stmmac_detach_xsk_buffers(struct stmmac_priv *priv,
> +				      struct stmmac_dma_conf *dma_conf)
> +{
> +	u32 queue;
> +
> +	/* Socket teardown cannot retain the pool itself. Drop software-only
> +	 * references, but keep each xsk_dma reference: hardware can still reach
> +	 * the mapped UMEM pages even after the pool and its heads are freed.
> +	 */
> +	for (queue =3D 0; queue < MTL_MAX_RX_QUEUES; queue++) {
> +		struct stmmac_rx_queue *rx_q =3D &dma_conf->rx_queue[queue];
> +
> +		if (!rx_q->xsk_pool)
> +			continue;
> +		dma_free_rx_xskbufs(priv, dma_conf, queue);

[Severity: Critical]
Does this code cause a hardware use-after-free when the DMA engine fails
to stop?

This function is explicitly called by the new quarantine logic below when
dma_owned is true, meaning the hardware is still actively processing.
However, dma_free_rx_xskbufs() unconditionally executes xsk_buff_free()
to return the UMEM buffers to the AF_XDP pool.

While the pages are pinned via xsk_pool_dma_get(), returning them to the
pool allows userspace applications to immediately reallocate and reuse
these memory chunks. Since the hardware DMA is still active and programmed
with these physical addresses, the MAC can asynchronously overwrite the
in-use userspace memory with incoming network packets.

[ ... ]
> @@ -3350,6 +3476,19 @@ static int stmmac_init_dma_engine(struct stmmac_pr=
iv *priv)
>  		netdev_err(priv->dev, "Failed to reset the dma\n");
>  		return ret;
>  	}
> +	stmmac_dma_reset_complete(priv);
> +	priv->dma_reset_needed =3D false;
> +
> +	if (reinit) {
> +		stmmac_reinit_dma_desc(priv);
> +	} else if (priv->datapath =3D=3D STMMAC_DATAPATH_SUSPENDED) {
> +		/* Suspend only requested a stop. Do not modify its descriptors
> +		 * or release pending TX buffers until this reset has completed.
> +		 */
> +		stmmac_reset_queues_param(priv);
> +		stmmac_free_tx_skbufs(priv);
> +		stmmac_clear_descriptors(priv, priv->dma_conf);
> +	}

[Severity: Critical]
Can this fallback path corrupt memory during device resume?

When reinit is false, this code falls back to stmmac_clear_descriptors().
stmmac_clear_descriptors() simply ORs the OWN bit into des3. If there
were pending RX packets when the device suspended, the MAC may have already
written status bits into the descriptors, such as bit 25 RS1V in GMAC4.

By preserving these status bits and setting the OWN bit, the descriptor
is returned to the MAC in Read Format. The MAC then misinterprets these
leftover status bits as physical address bits. For example, bit 25 becomes
BUFFER2_VALID_ADDR, and the packet length becomes the upper 32 bits of
the secondary address. The MAC will then blindly DMA into this random
64-bit physical address.

[ ... ]
> @@ -8721,12 +8969,7 @@ int stmmac_resume(struct device *dev)
> =20
>  	mutex_lock(&priv->lock);
> =20
> -	stmmac_reset_queues_param(priv);
> -
> -	stmmac_free_tx_skbufs(priv);
> -	stmmac_clear_descriptors(priv, priv->dma_conf);
> -
> -	ret =3D stmmac_hw_setup(ndev);
> +	ret =3D stmmac_hw_setup(ndev, false, false);

[Severity: Critical]
Should the reinit parameter be passed as true here instead of false?

Passing false skips the newly introduced stmmac_reinit_dma_desc() rebuild
logic in stmmac_init_dma_engine(), directly triggering the fallback path
described above and causing memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-submit-stm=
mac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com?part=3D13
