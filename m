Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EE3E5EC5;
	Mon, 28 Sep 2026 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553712; cv=none; b=uwuXRvcdSJfUyjY/EssoFXnUvBcNCreWkIgKSm4EMSc3oF6qFTpx5BeoYb7nB8axtRnuDam1JNinavtbxrH/QHg0rN9dfXkl/xJ7I/PVbh6b4OwUxsmMAwuzavdJrd+wx0bDssqqpQ/ZciPOCqy9AnPGrcxSSh+0jhd1IOACKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553712; c=relaxed/simple;
	bh=Rf5LFtbKgirp7BAdZ8D8lA0xrLXRdwZqeqd+7bU+p6g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4hoJvYggY4ytT+v3B5ckJB11HyO7t8TNZjIpktW+C1u9UgXv53tC5USqY/nVSx2Mrld8WpvMaF+u414JOwoUOD2xnoySY/6IDKl25k7P9X33U8ZyQ/ZwkcvEDrNAAVb8wuqgEqwTPDrNMCcDDe2ZYAyN8e7bIgLGWQEJtIsGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSi7Fego; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSi7Fego"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CFC1F0089C;
	Mon, 28 Sep 2026 00:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553706;
	bh=xPs3qfsZ57G0vhkqXTsHYPVMzbUQwqgfWy2emIIlW38=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DSi7FegoMB5CoSe2ee0aMHlEYxoHNmMyKwgj9I4cd99HZh6MaoyDiLM/0zzQcFFNN
	 IopowZqei4vrg+F1PcbUFmOLMPKi3bILMQEOm52rJVampEGDFvn+pACvkE7mXIFgn0
	 daUJ2+NxSX+evGOobYfJJVoBz4a2EnnfHAIlF7VNvcnTI7pJxIJ5kHVrGnqgmGi9lX
	 3rHUv8mV1D/7VrFUqljnCpzaL8yYMaheGUMVyjKb5UlLb8KlGJ9ckL5XNHU/IgR9Ud
	 fT3+qv9NRVC+OgUr6CVxY7q0LMAVcPfwt26x2AliGAPYKW1bfAKQc2HT+YBebX/zql
	 7ic2Wq6xUI7Cw==
Subject:
 Re: [PATCH net-next v2 6/8] eth: mpnic: add a netdevice and basic Tx handling
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:45 +0000
Message-ID: <179055370515.3145.17058486989024667735@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-6-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-6-4badc9b58b9e@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The netdev registered by this patch has no statistics
  reporting, and Tx drops are not counted anywhere.
- [Medium] mpnic_open() undoes the netif_device_detach() that this patch
  adds to mpnic_mmio_err(), and reports success on a dead device.
- [Low] Concern: mpnic_netdev_alloc() calls
  alloc_etherdev_mq(sizeof(*mpn), MPNIC_MAX_RXQS), which leaves…

--

eth: mpnic: add a netdevice and basic Tx handling

This commit registers the mpnic network interface and adds a transmit
path. Each skb gets a metadata descriptor followed by address/length
descriptors. A completion is requested only when xmit_more is not set. The
index of the deferred metadata descriptor is latched, so that dropping a
packet can still ring the doorbell for packets already queued.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> new file mode 100644
> index 0000000000000..6d5007be6cadb
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> @@ -0,0 +1,180 @@

[ ... ]

> +static int mpnic_open(struct net_device *netdev)
> +{
> +	struct mpnic_net *mpn = netdev_priv(netdev);
> +	int err;
> +

[ ... ]

> +	mpnic_enable(mpn);
> +	mpnic_napi_enable(mpn);
> +
> +	netif_tx_wake_all_queues(netdev);
> +	netif_carrier_on(netdev);
> +
> +	return 0;

[Severity: Medium]
Can this undo the netif_device_detach() that this patch adds to
mpnic_mmio_err(), and report a successful open on a dead device?

Suppose the device goes away while the interface is down. mpnic_enable()
ends with mpnic_wrfl(), which reads MPNIC_BDQ_SPARE. If that read returns
all ones, mpnic_mmio_err() clears uc_addr0 and calls
netif_device_detach().

__dev_open() has already set __LINK_STATE_START before calling ndo_open.
So the detach clears __LINK_STATE_PRESENT and stops the Tx queues:

__dev_open()
  set_bit(__LINK_STATE_START, &dev->state)
  mpnic_open()
    mpnic_enable()
      mpnic_wrfl()
        mpnic_rd64(mpd, MPNIC_BDQ_SPARE)
          mpnic_mmio_err()
            netif_device_detach()
    mpnic_napi_enable()
    netif_tx_wake_all_queues()
    netif_carrier_on()
    return 0

mpnic_open() then wakes every queue again, turns the carrier on and
returns 0. The interface ends up IFF_UP, with carrier and awake Tx queues,
while it is marked not present.

Would mpnic_xmit_frame() then keep mapping skbs and writing to the cached
ring->doorbell until the ring fills, with nothing ever completing? The dev
watchdog would not fire either, because it requires
netif_device_present().

mpnic_netdev_register() checks mpnic_present() before register_netdev()
for this same reason. Does mpnic_open() need a similar check after enabling
the device, so it can unwind and return an error?

The version of mpnic_open() at the end of the series only adds
mpnic_fill(), so it seems to behave the same way.

[ ... ]

> +struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
> +{
> +	struct net_device *netdev;
> +	struct mpnic_net *mpn;
> +	unsigned int queues;
> +
> +	netdev = alloc_etherdev_mq(sizeof(*mpn), MPNIC_MAX_RXQS);
> +	if (!netdev)
> +		return NULL;

[Severity: Low]
alloc_etherdev_mq() uses MPNIC_MAX_RXQS for both the Tx and the Rx queue
count. Only the Tx count is trimmed later, in mpnic_netdev_register():

    err = netif_set_real_num_tx_queues(netdev, mpn->num_tx_queues);

Doesn't that leave real_num_rx_queues at 1024 at this commit? Sysfs and
netlink would then list 1024 rx-N queues that have nothing behind them.

This looks resolved later in the series by "eth: mpnic: add basic Rx
handling". There, mpnic_netdev_register() and mpnic_set_netif_queues()
switch to netif_set_real_num_queues() with num_rx_queues.

There is also a smaller point. The Tx queue count comes from
MPNIC_MAX_RXQS, but mpn->tx[] in struct mpnic_net is sized by
MPNIC_MAX_TXQS. Both are 1024u today, so the
mpn->tx[skb_get_queue_mapping(skb)] lookup in mpnic_xmit_frame() cannot
overflow.

Would alloc_etherdev_mqs() with MPNIC_MAX_TXQS and MPNIC_MAX_RXQS express
the intent more precisely?

[ ... ]

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index aaa3a3e99a138..b1fb0d3902a7a 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> +static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
> +					 struct mpnic_ring *ring)
> +{
> +	__le64 *meta = &ring->desc[ring->tail];
> +	u32 tail = ring->tail;
> +
> +	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
> +		goto err_drop;

[ ... ]

> +	if (mpnic_tx_map(ring, skb, meta))
> +		goto err_free;
> +
> +	return NETDEV_TX_OK;
> +
> +err_free:
> +	dev_kfree_skb_any(skb);
> +	ring->tx_buf[tail] = NULL;
> +	ring->tail = tail;
> +err_drop:
> +	mpnic_tx_flush_doorbell(ring);
> +
> +	return NETDEV_TX_OK;
> +}

[Severity: Medium]
Should these drop paths count the dropped skb somewhere?

- A skb_put_padto() failure goes to err_drop with no log and no counter.
- An mpnic_tx_map() failure (oversized head or frag, or
  dma_mapping_error()) only logs a rate-limited netdev_err() before
  dev_kfree_skb_any().

Neither path calls dev_core_stats_tx_dropped_inc() or updates any counter.

More broadly, mpnic_netdev_ops only provides ndo_open, ndo_stop,
ndo_validate_addr and ndo_start_xmit:

- There is no ndo_get_stats64.
- pcpu_stat_type is not set.
- dev->stats is never updated.

The per-packet totals in mpnic_clean_twq0() only go to
netif_txq_completed_wake() for BQL.

Won't dev_get_stats() report zero for tx_packets, tx_bytes and tx_dropped
while traffic is flowing? The last patch in the series, "eth: mpnic: add
basic Rx handling", still doesn't add a stats callback.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
