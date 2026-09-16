Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E0472F74;
	Wed, 16 Sep 2026 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601755; cv=none; b=pLwToPqkmYC0RGMaohyx8mqIId3iLrMcd3MWVXXBJjBTySMoI/Zx3wW/FgH2agZFCSqOYpj6IltmkvLdkvHTFjJaxnkLINBgO5ZiA4lH+tu0Xan76shrWQqiDlOGXFR9NjCjYime0IjtlefWQZONuJzZqTAyd249BMBzmSUR1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601755; c=relaxed/simple;
	bh=3XrkVpBBDaIWMPsLA6cogZNywQ3Q3HMqhiwnM5wqTV8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQ9d6Pr6IorPQBDhSRvfFFjS6+iWUTyXAek2PUX2Z8YncGbO0mTEftBt3rvJDad7Rh7ishzNTQuvBq7bUas09JdgltODR5j84pyOEuxnk81nOBZ/tg8kqVMB+NBXYcpSsXO4B5ka++gwgbKa7W1w4Y/XB79/ZpFIV3LMwk1T5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNF+l05K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNF+l05K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C291F000FF;
	Wed, 16 Sep 2026 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601753;
	bh=K64uFQ946ZNoUNBCENKlKa4LFBeIPqkCZlP3ODK7fBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SNF+l05KQvuhuLCx/O+UM0Nv6FJpAAJC2YX1U9xuFsN8atYclT09Gl5O6LYDGTXmA
	 pLllZ7nhYp3XW3XqK1sJNLtpGuSWlHxZIQp1lovzeY1FMU4GGKcs406vCx8bEBmQlt
	 kQZPBiJ1Hw5fQaM8mApJ5oudl2PK26l2w/GijCakN1GJq3GYAL/tX1wx1rmG9LGynT
	 2s19T6xMXs87bnoWgUrfTrsQ98GOsmK1xGLDqgy6FoagLJjVJ1AHqF9ibcA68RJpPc
	 gxUcx8qJZsGOsTrJ8Drqd7gZfFhaGka+0i9sa1hEz8t4kG68EEToCMGKX5jBOu7yik
	 j7gSZ0UtFvkeQ==
Subject: Re: [PATCH v3 net 1/7] net: enetc: consistenly track dropped frames
 in enetc_xdp_xmit()
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, zefir.kurtisi@westermo.com, claudiu.manoil@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, ioana.ciornei@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 16 Sep 2026 23:35:51 +0000
Message-ID: <178960175181.22033.9527194886866325710@kernel.org>
In-Reply-To: <20260915222735.1016937-2-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-2-vladimir.oltean@nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] enetc_xdp_xmit()
  (drivers/net/ethernet/freescale/enetc/enetc.c:1817-1820) still returns…

Pre-existing issues:
- [Medium] The accumulation added by this patch,
  `tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;`…

--

net: enetc: consistenly track dropped frames in enetc_xdp_xmit()

This makes enetc_xdp_xmit() account for every frame in the batch that was
not handed to hardware, instead of only counting a single drop on
enetc_xdp_tx() failure.  The drop counter is now bumped by the remainder
num_frames - xdp_tx_frm_cnt, which also covers the too-many-fragments and
enetc_xdp_frame_to_xdp_tx_swbd() failure cases.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 80f0082f6c633..e7ecdf8ef67c8 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c

[ ... ]

> @@ -1854,6 +1853,7 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  		enetc_update_tx_ring_tail(tx_ring);
>  
>  	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
> +	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;

[Severity: Medium]
Should the early exit at the top of enetc_xdp_xmit() also be counted here?
That path returns before this new accumulation runs:

drivers/net/ethernet/freescale/enetc/enetc.c:enetc_xdp_xmit() {
	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
		     !netif_carrier_ok(ndev)))
		return -ENETDOWN;
	...
}

On a negative return, bq_xmit_all() in kernel/bpf/devmap.c discards the
whole batch:

	sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_send, bq->q, flags);
	if (sent < 0) {
		err = sent;
		sent = 0;
	}
	for (i = sent; unlikely(i < to_send); i++)
		xdp_return_frame_rx_napi(bq->q[i]);

So all num_frames frames are dropped, but "Tx ring N XDP drops" in
ethtool -S stays unchanged.

The XDP_TX producer of the same counter in enetc_clean_rx_ring_xdp() does
count the identical condition:

		case XDP_TX:
			tx_ring = priv->xdp_tx_ring[rx_ring->index];
			if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags))) {
				enetc_xdp_drop(rx_ring, orig_i, i);
				tx_ring->stats.xdp_tx_drops++;
				break;
			}

Given that the commit message says frames "will not be transmitted" should
be tracked by drop counters, does leaving the -ENETDOWN case uncounted give
the same counter two different meanings depending on which in-driver path
produced the drop?  tx_ring is derivable there as
priv->xdp_tx_ring[smp_processor_id()], so the early return could bump the
counter by num_frames before returning.

[Severity: Medium]
This isn't a bug introduced by this patch, but the new accumulation inherits
an unsynchronized read-modify-write on tx_ring->stats.xdp_tx_drops, the same
way the existing xdp_tx += line does.  The fields in struct
enetc_ring_stats are plain unsigned long, with no per-CPU separation and no
u64_stats_sync.

The same ring's counters are also written from NAPI in
enetc_clean_rx_ring_xdp():

			tx_ring = priv->xdp_tx_ring[rx_ring->index];
			...
				tx_ring->stats.xdp_tx_drops++;

enetc_xdp_xmit() picks the ring with smp_processor_id() while XDP_TX picks it
with rx_ring->index, so both can target the same tx_ring from different CPUs
once RX IRQ affinity is not the identity mapping (enetc_setup_irqs() only
installs a hint via irq_set_affinity_hint(), and userspace can rewrite
/proc/irq/*/smp_affinity).

The only lock held is enetc_lock_mdio(), which is a shared read_lock() and
compiles away unless the errata static branch is enabled:

drivers/net/ethernet/freescale/enetc/enetc_hw.h:enetc_lock_mdio() {
	if (static_branch_unlikely(&enetc_has_err050089))
		read_lock(&enetc_mdio_lock);
}

Can increments be lost this way, and is it worth converting these ring stats
to u64_stats_sync while touching the accounting?

>  
>  	enetc_unlock_mdio();
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915222735.1016937-1-vladimir.oltean%40nxp.com
