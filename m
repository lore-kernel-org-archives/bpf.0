Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE430E0D3;
	Sun, 25 Jan 2026 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377523; cv=none; b=gV4bGjpax+uDLU33kHRtms2W+9C4/+Uj85e+DD1X4MrOKMzzVYnMm4Zv8Kl0zah3hUp6vs24YIdlOO9e+s1IId/aWROXXpEVCXI/oAMAg4ba0hqYfAUhCCaE8Y3oV1Eu5ITZ6BFGVsjBUSdJfSN+pphWfuhqEFGRiFh0agaS+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377523; c=relaxed/simple;
	bh=2xoo2eyP1Ra2vHGy7A0s6glBdg87bpoHN64gXy3qjvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4Z5di+pniboft07OiGeLtR8yYSs98ovErNZWwgmLESKkLaG9vKpWxo4sU15TeSZnx9LU5bB/VyFdc15C2DWc4M+AtZPcHh1cl5Ezjo21t6MFQj7otw+v3moWMNj9zIV/PZO4f+fhYjRqpNX2i0IOWVFiWy/Qcdv1rzdGsYJSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0StyOsM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0StyOsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695A8C4CEF1;
	Sun, 25 Jan 2026 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769377523;
	bh=2xoo2eyP1Ra2vHGy7A0s6glBdg87bpoHN64gXy3qjvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0StyOsME6oZ5n4CnIzAsuWUk+/sUC80ElOZUfYcELAzUgc+tl1vArUhntV72WNDL
	 guijiV/TOcvQ0Zpr+mmnPyHfuJsaO7lPlX2tFhJzRtLq3n17Zky+bMulOrdKl0mUUW
	 JNuAwGtYKWLb0NYb8nf0/hdQD4WDw3WJNyLbBfXAHxRYbpBwajiq/4C8+gzDVhkL5o
	 I0s4tTh4OZxz6tA9bfZ0ccBiJl7M9nLwlTj4MqWV944oRKTdjufeVlATetZ2pie9VA
	 St8LGJFY1Fi8wruPiPO3Js6F0RpvJLpmpXWQCtNIWlzn51Yqfyf13g2NcX9H58EUkh
	 LLmh8Vvvp9u9g==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	shenwei.wang@nxp.com,
	daniel@iogearbox.net,
	frank.li@nxp.com,
	netdev@vger.kernel.org,
	xiaoning.wang@nxp.com,
	ast@kernel.org,
	sdf@fomichev.me,
	imx@lists.linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Subject: Re: [v4,net-next,15/15] net: fec: add AF_XDP zero-copy support
Date: Sun, 25 Jan 2026 13:45:21 -0800
Message-ID: <20260125214521.3384305-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123022143.4121797-16-wei.fang@nxp.com>
References: <20260123022143.4121797-16-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fec: add AF_XDP zero-copy support

This patch adds AF_XDP zero-copy support for both TX and RX on the FEC
driver, enabling higher performance packet processing through XSK pools.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c19ae60b04d7..d3e54dcf6a4c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c

[ ... ]

> +static int fec_setup_xsk_pool(struct net_device *ndev,
> +			      struct xsk_buff_pool *pool,
> +			      u16 queue)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	bool is_run = netif_running(ndev);
> +	struct fec_enet_priv_rx_q *rxq;
> +	struct fec_enet_priv_tx_q *txq;
> +	bool enable = !!pool;
> +	int err;
> +
> +	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
> +		return -ERANGE;
> +
> +	if (is_run) {
> +		napi_disable(&fep->napi);
> +		netif_tx_disable(ndev);
> +		synchronize_rcu();
> +		fec_enet_free_buffers(ndev);
> +	}
> +
> +	rxq = fep->rx_queue[queue];
> +	txq = fep->tx_queue[queue];
> +
> +	if (enable) {
> +		err = xsk_pool_dma_map(pool, &fep->pdev->dev, 0);
> +		if (err) {
> +			netdev_err(ndev, "Failed to map xsk pool\n");
> +			return err;
                        ^^^^^^^^^^

If xsk_pool_dma_map() fails here when the device was running (is_run ==
true), the function returns without restoring the device state. At this
point NAPI is disabled, TX queues are disabled, and all buffers have been
freed. Should the error path restore the device to a working state similar
to the err_alloc_buffers path below?

The err_alloc_buffers label handles the cleanup for xsk_pool state but it
looks like that error path would also need to call fec_enet_alloc_buffers(),
fec_restart(), napi_enable(), and netif_tx_start_all_queues() to restore
the device when is_run was true.

> +		}
> +
> +		rxq->xsk_pool = pool;
> +		txq->xsk_pool = pool;
> +	} else {
> +		xsk_pool_dma_unmap(rxq->xsk_pool, 0);
> +		rxq->xsk_pool = NULL;
> +		txq->xsk_pool = NULL;
> +	}
> +
> +	if (is_run) {
> +		err = fec_enet_alloc_buffers(ndev);
> +		if (err) {
> +			netdev_err(ndev, "Failed to alloc buffers\n");
> +			goto err_alloc_buffers;
> +		}
> +
> +		fec_restart(ndev);
> +		napi_enable(&fep->napi);
> +		netif_tx_start_all_queues(ndev);
> +	}
> +
> +	return 0;
> +
> +err_alloc_buffers:
> +	if (enable) {
> +		xsk_pool_dma_unmap(pool, 0);
> +		rxq->xsk_pool = NULL;
> +		txq->xsk_pool = NULL;
> +	}
> +
> +	return err;
> +}
