Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454953D411B;
	Thu, 24 Sep 2026 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215540; cv=none; b=U3gdw9qWjbNx4YV4osvkyITKGat9ADopa8tvav9kqvlEq3y7aFsfzkEXhQ5RnpbwztKem2uqBXsdW9GhU0b4e1LtHz417gD+VPTzbBi/YmbKaCHT2rRHQp/l4VuXfkXVLvsmPLs1y5bzf8+OXa+NRriPe2JYVa68ysHi/GWapSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215540; c=relaxed/simple;
	bh=QFt8TwwCcUOdjULh3N0QbtJbm7C2U6A6Qb+/YRAw8PY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSLNjtWFFk9X/kZF6w1xmkwxrCNzcw+x/VOr6opnUgzxjlhpv3H4gyvc7uIQTrDB+kEGnQ5hy08x7AFI14OXNYMU9SqkMTmAmheQShdfInFhTCuMPo872TIn+YMj2nMk7bltnCfsTb2FKR6mBLvIlPynTkjX10NRXjybM2qXrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBRX4g/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBRX4g/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040821F00893;
	Thu, 24 Sep 2026 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215539;
	bh=Gr88hMe5tgtqFgPTIXLgjdC4FkdywQ7EvvflTBze56c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JBRX4g/dPrWL9pqw8taJFKNu6XZU8FEDEDrSMkKnsUbKuxTBjaG1j05PZWfCNbW7H
	 cEt7ddMNr4Rar4UcgQ/art48kgydEVBuO2jCbxe04jpDZ9+ec6p5JpLBsct0Bkeuco
	 fR8NuTzj0BbIUuiNdvnnKrH4W4DE6+eo/pnx4fe+MkfVvvGx4pDtR+NgWILiQPrZMg
	 BteuBfbgWDQlQTKRGv4s6Wt0fVzhqpdCx87vEvHMGnV+69k739p/1o5qHCto/f5ty/
	 YCsbK5gDMFeuk750EvCVkspyyO9LNgOKGX+ZgAjgGMFfWZJUb4Ou7DkfL8CTtyXEnJ
	 wYrfgYWqXnbpw==
Subject:
 Re: [PATCH net-next 6/8] eth: mpnic: add a netdevice and basic Tx handling
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Thu, 24 Sep 2026 02:05:37 +0000
Message-ID: <179021553756.2160803.6381610175873058359@kernel.org>
In-Reply-To: <20260922-linux-mpnic-v1-6-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-6-236844f53072@gmail.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mpnic_open() (drivers/net/ethernet/meta/mpnic/mpnic_netdev.c)
  can succeed and show a dead device as up.
- [Medium] The new ndo_stop, mpnic_stop() in
  drivers/net/ethernet/meta/mpnic/mpnic_netdev.c, reclaims DMA memory…
- [Medium] No TX traffic or drops are ever accounted.

--

eth: mpnic: add a netdevice and basic Tx handling

This patch registers a netdev for the mpnic driver and adds ndo_open and
ndo_stop. It also adds a basic transmit path that builds one metadata
descriptor plus address/length descriptors per skb, defers doorbells for
xmit_more bursts, and flushes the deferred doorbell when a packet is
dropped. mpnic_mmio_err() now detaches the netdev when MMIO fails.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> new file mode 100644
> index 0000000000000..62dc9018f2f8c
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> @@ -0,0 +1,176 @@

[ ... ]

> +static int mpnic_open(struct net_device *netdev)
> +{
> +	struct mpnic_net *mpn = netdev_priv(netdev);
> +	int err;
> +
> +	err = mpnic_alloc_napi_vectors(mpn);
> +	if (err)
> +		return err;
> +
> +	err = mpnic_alloc_resources(mpn);
> +	if (err)
> +		goto err_free_napi_vectors;
> +
> +	err = mpnic_set_netif_queues(mpn);
> +	if (err)
> +		goto err_free_resources;
> +
> +	mpnic_enable(mpn);
> +	mpnic_napi_enable(mpn);
> +
> +	netif_tx_wake_all_queues(netdev);
> +	netif_carrier_on(netdev);
> +
> +	return 0;

[Severity: Medium]
Can mpnic_open() return success for a device that has just been
detached?

mpnic_enable() and mpnic_napi_enable() both end with mpnic_wrfl(), which
is mpnic_rd64(mpd, MPNIC_BDQ_SPARE). If that read returns all ones, the
confirmation read is skipped because reg == MPNIC_BDQ_SPARE. As a result,
mpnic_mmio_err() runs. With this patch that handler now does:

	/* Tell the stack the device has lost its PCIe link */
	if (mpd->netdev)
		netif_device_detach(mpd->netdev);

__dev_open() has already set __LINK_STATE_START before calling ndo_open.
netif_running() is therefore true, and the detach stops all tx queues.
mpnic_open() then continues without checking anything:

mpnic_open()
    mpnic_enable()
        mpnic_wrfl()->mpnic_rd64()->mpnic_mmio_err()
            netif_device_detach()->netif_tx_stop_all_queues()
    mpnic_napi_enable()
    netif_tx_wake_all_queues()
    netif_carrier_on()
    return 0

netif_tx_wake_queue() does not check whether the device is present. So
the queues are awake again, carrier is on and IFF_UP gets set, while
__LINK_STATE_PRESENT is clear and uc_addr0 is NULL.

mpnic_xmit_frame() doesn't check presence either. It keeps filling
descriptors and calling writeq() on the cached ring->doorbell. No
completions come back, and dev_watchdog skips non-present devices, so no
tx timeout fires either.

Would it make sense to check mpnic_present() or netif_device_present()
after the enable steps, and unwind if the check fails?

> +
> +err_free_resources:
> +	mpnic_free_resources(mpn);
> +err_free_napi_vectors:
> +	mpnic_free_napi_vectors(mpn);
> +	return err;
> +}
> +
> +static int mpnic_stop(struct net_device *netdev)
> +{
> +	struct mpnic_net *mpn = netdev_priv(netdev);
> +
> +	netif_carrier_off(netdev);
> +
> +	mpnic_napi_disable(mpn);
> +	netif_tx_disable(netdev);
> +
> +	mpnic_disable(mpn);
> +	mpnic_wait_all_queues_idle(mpn->mpd);
> +	mpnic_flush(mpn);
> +
> +	mpnic_reset_netif_queues(mpn);
> +	mpnic_free_resources(mpn);
> +	mpnic_free_napi_vectors(mpn);

[Severity: Medium]
What happens here if mpnic_wait_all_queues_idle() times out? It returns
void and only logs the failure:

mpnic_wait_all_queues_idle() {
    ...
	err = read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
				!non_idle_bitmap, 20, 500000, false, mpd,
				queues, ARRAY_SIZE(queues));
	if (err)
		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
				non_idle_bitmap, err);
}

mpnic_stop() then always carries on with:

mpnic_flush()
    mpnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail)
        unmaps and frees every outstanding skb
mpnic_free_resources()->mpnic_free_ring_resources()
    dma_free_coherent() on the TWQ and TCQ rings

If a Tx block (TWQ/TQS/TDE/TCQ) is still busy after 500 ms, can the
device read from unmapped skb pages or write completions into freed
coherent memory? The TCQ is only disabled by writing TCQ_CTL = 0.

This path has no fallback: no flush retry, no function reset, no clearing
of bus mastering. For comparison, fbnic calls fbnic_tx_flush() and polls
again before giving up.

A related case: if an earlier MMIO failure already cleared uc_addr0,
mpnic_disable() skips all its writes, and mpnic_rd64() returns ~0 for
every idle register. Does the wait then report idle straight away, so
the rings are freed even though the queues were never disabled?

> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index cb4d1427434c9..f4ad8caf6ce66 100644
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
Are these drops counted anywhere?

Both drop paths return NETDEV_TX_OK without calling
dev_core_stats_tx_dropped_inc() or updating any other counter:

  - err_drop, when skb_put_padto() fails
  - err_free, when mpnic_tx_map() fails on a DMA mapping error or an
    oversized head or fragment

The only trace is the rate-limited netdev_err() on the DMA path.

There is also no stats path in general. mpnic_netdev_ops has no
.ndo_get_stats64 or .ndo_get_stats, and netdev->stats is never updated.
mpnic_clean_twq0() passes its totals only to BQL, through
netif_txq_completed_wake().

Won't ip -s link then show tx_packets, tx_bytes and tx_dropped as 0 on an
interface that is transmitting and dropping packets?

The struct net_device_ops statistics comment in include/linux/netdevice.h
says drivers must implement one of the supported statistics mechanisms.
This still seems to be the case at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-linux-mpnic-v1-0-236844f53072%40gmail.com
