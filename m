Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114836;
	b=yjm+6ij7/GBeAde7t8y9ghdaBfjWQ13BZLYgJZZai5qTWnVGPK1tuh4DNwJ4QR2JoDmB
	 /l6h4BxBT9Z1kHfKscT1N7GTTRJAp9P+qXwx+KwUSQl28/UqujAlOlOwh+yZQbNrcaUoS
	 w3H17evLIFfutN+e8PlRsx0hnEMQjnMl61l+Dtyz4mRU0VO3dcX0hi2EoZ0TkMTqpg1I3
	 dS8EMV+UPsW6OiteREf2mWWpo8CoEUShd650+Ew87vtWirT26jBKTELGMeFZVGj8nTOVH
	 Mn+scl3kXdYZPBbhDkSQtNxHWSo7OjdLF5ihy8EAyfvhC5MSXWLVyZ9c0/XC1SA84Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114836;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Kugn4FylwABJ5llnTbzWYENzG7rdv6plsE22DSTsGM=;
	b=sICmthV1oiDqYpXgvS8UeuqDQoLnvCGjdTWJy/QmSJeOyDc6olrb8wVV1/Rg2jr4sHSV
	 +a5TMV0AnG6FnOaT4kN7os9Zz7MJvfnFSQaIJ/+kBNC9WQ6dna17cxPdP2i7zICRDxaPn
	 nqhGwvEljNIEvPFX30VUYLUj5e8lmhBv24HvUHulO5uYtFL7/vxUYyJ+t2h8XUuxp8XGR
	 BBlCbXuWmj9rjL4Wh7OcZBdVfYN1LAbGkSLbzLHll/oNGUCma9fdPUGiCmNgxZEIrDrsV
	 B600ob+BDzfUB2hOXdhKbM08Lz8FObT5SsI0zLeuZVd23C+ocHiC1N10WE6ZEnftaqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep2rf2wW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51887606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep2rf2wW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27711F01828;
	Tue, 27 Oct 2026 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114836;
	bh=3Kugn4FylwABJ5llnTbzWYENzG7rdv6plsE22DSTsGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ep2rf2wWkM3saBfdCgKMiQHg6Cji/gB/t/VAAk5+5OtOC0O3V1bQmBVR8cPmv7/J+
	 tAIc26Ovy4th0+NWqbkEneyTXs/KaT8crYbNPpfD+uF3OOyFz0EwlPxKbr3lwCKIzZ
	 37+RkEdKVU0tzGbSDQYvWrdjU50KXBSRyQpnWoIqSy9pqW2j0zSE5GHyeuueT6dDhf
	 Kz0/q+XrqLr7eiY5AR4jak6RIutpGXqWrKCPdn2h/C3zufBKELYH3h6DN8xC3sWPA4
	 t8d0lw9S+vnzYiMozBukRhz+1n1i9TsTOVNUI4DalPP77VFgEBytNlkkHCIA153/8L
	 0YOUa2MTaKjYw==
Message-ID: <sashiko-outbox-186833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] net: stmmac: rebuild RX descriptors before
 restarting DMA on resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Bourgoin" <thomas.bourgoin@foss.st.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261027150556.51209-2-thomas.bourgoin@foss.st.com>
References: <20261027150556.51209-1-thomas.bourgoin@foss.st.com>
 <20261027150556.51209-2-thomas.bourgoin@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:27:15 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] net: stmmac: stmmac_resume_descriptors() fails to restore chai=
ned des3 links
- [High] net: stmmac: stmmac_resume_rx_descriptors() fails on empty or part=
ial XSK pool
- [Medium] net: stmmac: stmmac_init_rx_buffers() ignores flags and uses GFP=
_ATOMIC
--

commit 8d3c0459b1ad22247b62f5f4182ad5e15b2eab5d
Author: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

net: stmmac: rebuild RX descriptors before restarting DMA on resume

This commit reconstructs RX descriptors and restores their DMA buffer
addresses during system resume before clearing descriptors and restarting
DMA, preventing the DMA engine from treating write-back status fields as
buffer addresses.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9ded31150fbe6..198629265c904 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -8425,6 +8414,63 @@ static void stmmac_reset_rx_queue(struct stmmac_pr=
iv *priv, u32 queue)
>  	rx_q->dirty_rx =3D 0;
>  }
> =20
> +static int stmmac_resume_rx_descriptors(struct stmmac_priv *priv,
> +					struct stmmac_dma_conf *dma_conf,
> +					u32 queue)
> +{
> +	struct stmmac_rx_queue *rx_q =3D &dma_conf->rx_queue[queue];
> +	int i;
> +	int ret;
> +
> +	for (i =3D 0; i < dma_conf->dma_rx_size; i++) {
> +		struct dma_desc *p =3D stmmac_get_rx_desc(priv, rx_q, i);
> +		struct stmmac_rx_buffer *buf =3D &rx_q->buf_pool[i];
> +		dma_addr_t dma_addr;
> +
> +		if (rx_q->xsk_pool) {
> +			if (!buf->xdp) {
> +				buf->xdp =3D xsk_buff_alloc(rx_q->xsk_pool);
> +				if (!buf->xdp)
> +					return -ENOMEM;
> +				}
> +			dma_addr =3D xsk_buff_xdp_get_dma(buf->xdp);
> +			stmmac_set_desc_addr(priv, p, dma_addr);
> +			stmmac_set_desc_sec_addr(priv, p, 0, false);

[Severity: High]
Can this break resume when an AF_XDP zero-copy pool is attached with an
empty or partially populated fill ring?

In __init_dma_rx_desc_rings(), an unpopulated XSK pool (such as TX-only
xdpsock) is explicitly allowed:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:__init_dma_rx_desc_rings(=
) {
	if (rx_q->xsk_pool) {
		/* RX XDP ZC buffer pool may not be populated, e.g.
		 * xdpsock TX-only.
		 */
		stmmac_alloc_rx_buffers_zc(priv, dma_conf, queue);
	}
}

Similarly, if RX frames were consumed in stmmac_rx_zc() before suspend
(setting buf->xdp =3D NULL) and the frozen userspace fill ring has fewer th=
an
dma_conf->dma_rx_size buffers available, xsk_buff_alloc() returns NULL.

Returning -ENOMEM here causes stmmac_resume() to abort at error_unlock,
skipping stmmac_hw_setup(), stmmac_enable_all_queues(), and
netif_device_attach() while netif_running(ndev) remains true. Because
stmmac_suspend() already called stmmac_disable_all_queues(), leaving NAPI
disabled on a running interface causes a subsequent stmmac_xdp_disable_pool=
()
or stmmac_release() to call napi_disable() a second time and hang under
rtnl_lock().

Additionally, stmmac_resume_rx_descriptors() does not update
rx_q->buf_alloc_num, which stmmac_hw_setup() -> stmmac_init_dma_engine()
uses to program the hardware RX tail pointer and
stmmac_set_queue_rx_buf_size() uses to select
xsk_pool_get_rx_frame_size(rx_q->xsk_pool).

> +		} else {
> +			ret =3D stmmac_init_rx_buffers(priv, dma_conf, p, i,
> +						     GFP_KERNEL, queue);
> +			if (ret)
> +				return ret;
> +		}
> +	}

[Severity: Medium]
Here GFP_KERNEL is passed as the flags argument to stmmac_init_rx_buffers(),
but does stmmac_init_rx_buffers() actually honour the caller's flags?

Looking at stmmac_init_rx_buffers() in
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:

static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
				  struct stmmac_dma_conf *dma_conf,
				  struct dma_desc *p,
				  int i, gfp_t flags, u32 queue)
{
	struct stmmac_rx_queue *rx_q =3D &dma_conf->rx_queue[queue];
	struct stmmac_rx_buffer *buf =3D &rx_q->buf_pool[i];
	gfp_t gfp =3D (GFP_ATOMIC | __GFP_NOWARN);

It ignores the flags parameter and forces GFP_ATOMIC | __GFP_NOWARN for both
buf->page and buf->sec_page allocations, preventing direct reclaim during
resume and risking avoidable -ENOMEM failures under memory pressure.

> +
> +	return 0;
> +}
> +
> +static int stmmac_resume_descriptors(struct stmmac_priv *priv,
> +				     struct stmmac_dma_conf *dma_conf)
> +{
> +	u32 rx_queue_cnt =3D priv->plat->rx_queues_to_use;
> +	u32 tx_queue_cnt =3D priv->plat->tx_queues_to_use;
> +	u32 queue;
> +	int ret;
> +
> +	for (queue =3D 0; queue < rx_queue_cnt; queue++) {
> +		ret =3D stmmac_resume_rx_descriptors(priv, dma_conf, queue);
> +		if (ret)
> +			return ret;
> +
> +		stmmac_clear_rx_descriptors(priv, dma_conf, queue);
> +	}
> +
> +	for (queue =3D 0; queue < tx_queue_cnt; queue++) {
> +		dma_free_tx_skbufs(priv, &priv->dma_conf, queue);
> +		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
> +	}
> +
> +	return 0;
> +}

[Severity: Critical]
When priv->descriptor_mode =3D=3D STMMAC_CHAIN_MODE and IEEE 1588-2002
timestamping is enabled without extended descriptors (!priv->extend_desc
with priv->hwts_rx_en or priv->hwts_tx_en), doesn't the hardware overwrite
p->des3 with the upper 32 bits of the timestamp on descriptor write-back?

In drivers/net/ethernet/stmicro/stmmac/chain_mode.c, refill_desc3() and
clean_desc3() note that the device overwrites des3 with a timestamp value:

static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
{
	struct stmmac_priv *priv =3D rx_q->priv_data;

	if (priv->hwts_rx_en && !priv->extend_desc)
		/* NOTE: Device will overwrite des3 with timestamp value if
		 * 1588-2002 time stamping is enabled, hence reinitialize it
		 * to keep explicit chaining in the descriptor.
		 */
		p->des3 =3D cpu_to_le32((unsigned int)(rx_q->dma_rx_phy +
				      (((rx_q->dirty_rx) + 1) %
				       priv->dma_conf.dma_rx_size) *
				      sizeof(struct dma_desc)));
}

If an RX or TX descriptor was written back before suspend without being
cleaned by NAPI, p->des3 still holds the timestamp rather than the next
descriptor's physical DMA address. Neither stmmac_resume_rx_descriptors(),
stmmac_clear_rx_descriptors(), nor stmmac_clear_tx_descriptors() calls
stmmac_mode_init() (as __init_dma_rx_desc_rings() and
__init_dma_tx_desc_rings() do) to restore the chained des3 pointers when
priv->descriptor_mode =3D=3D STMMAC_CHAIN_MODE. Could the DMA engine then
fetch the next descriptor from the timestamp address after resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027150556.5120=
9-1-thomas.bourgoin@foss.st.com?part=3D1
