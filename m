Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092256;
	b=hvGvzIHwI1iijyPV81jlX2CYpxkPDjlJZP/MQdqp4Q4Du1Az3uq4+6BFccyo7cFO59AF
	 UrJxCfaNobLU1LryVhpMwX66VzfMi71bVbn7kLMTrcsH2JyJhwlXDEVpp00Xt8kTyoTwR
	 WbAdGrKE/6nXHO+Lp2DQSfAQmPIquxpaJrgT6uW+agxxFPXorkw8fraF6hnRC4uCQTVU3
	 QpRcN1WkjK4spOpRRZOyACkVT/M6hNNzPCKFbr+uyEBamDhIWWHZoVs10Bl6/hZ4Sc+m+
	 6o6S3mQzsQP2SKkcGnKpbABytrW7vZgVE/MvCFARhrNccPEMci7y+u7G/T2S3FwoOeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092256;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uGJBMOzeGvE2Nb+TZ2KRWS5LM8HfN0Oo/8rnIRB4zSs=;
	b=foF+ChvYyOb5lTCOUfccQ9xd3jGo7MNdHfwuFC3j/RFqVZzSIWyJjonF1kXTup+Z9fn1
	 xTu/nj3ro6JHu1LmgwlPHJdEcuwpss5DUNn5bH0twNwiBY2AD1A6SrneuwaCfA8xzZBRy
	 kpO+iwoXJPdB+RfwVlXagdnNfLqV+62WfroAyp37RoSdAFLaEnB+9C5W/WAhPXdQ8qJ5i
	 XWHKinIztZLqOTOTycvSYmqAw/ZfiJ6sXTGGmOhfRI82Su3QyUNsmcVPOmOfJl1pfsQiT
	 gmtKf/XTWS1LHEVH1WqSyJMt6xrGTeptMXs9lWz8FabTPnvjDqwWAwk+iYn1fOLqiSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbNMM3s5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8334606A32A;
	Tue, 27 Oct 2026 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbNMM3s5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AEC1F031E1;
	Tue, 27 Oct 2026 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092255;
	bh=uGJBMOzeGvE2Nb+TZ2KRWS5LM8HfN0Oo/8rnIRB4zSs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KbNMM3s58kunelRF3V/7PEtxaciElEGQUR4fCSgo9Uzw7Qvj/y7mze/HfbTb7dAWL
	 9tSY5hNQGCNDR3QfNL5KiCdD7Wj/Q1VZN/bHjwufVZO9K2he3lpcs3gmSGxiQ4JpV7
	 n1d0IkKPps2yxzyOv8MVhiNhdfWF1rE94IuXfSs9WLvU5Ts0PLUgbrtSffMwYsUa9N
	 If2VqsBU31BRRuhKZ8AQGqPw0laFcOU54J2hObG6eMpzKNHJs0bs1Z2qsYxMUJHoC+
	 ffzBeUlXTXFep45t5iY7mpE/pWbxYWRhmZvSbaElcO79TpDccbJ0IGJeLxrhtELnfo
	 rcXv2e8NiTSNA==
Subject: Re: [PATCH net 3/6] net: stmmac: drop multi-buffer frames in XDP mode
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 27 Oct 2026 09:10:54 +0000
Message-ID: <179309225404.3134.13890305235467768199@kernel.org>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-3-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-3-efb37e19f5bd@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch cites only `Fixes: 5fabb01207a2` ("net: stmmac: Add
  initial XDP support").

Pre-existing issues:
- [High] Without an XDP program, stmmac_rx() still re-parses the rest of
  a frame as a new frame when napi_build_skb() fails on a non-last…
- [Medium] stmmac_rx() adds its per-poll local counters to the device-
  wide `priv->xstats.rx_dropped` and `priv->xstats.rx_errors` (plain…

--

net: stmmac: drop multi-buffer frames in XDP mode

This patch makes stmmac_rx() drop frames that span more than one
descriptor, or that use the second buffer of a descriptor, while an XDP
program is attached. Discarded buffers are no longer returned to the page
pool, so stmmac_rx_refill() can reuse them in place. The re-parse of the
remaining descriptors after an XDP_CONSUMED verdict is also removed.

> Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")

[Severity: Low]
Should this also carry a Fixes tag for 88095728511e ("net: stmmac: fix rx
Scatter-Gather support")? Two of the failures described in the commit
message seem to come from that commit, not from the initial XDP support.

First, the buf1_len underflow. Before 88095728511e, stmmac_rx_buf1_len()
returned min_t(unsigned int, dma_buf_sz, plen) for the last descriptor. A
tail re-parsed after XDP_CONSUMED therefore got dma_buf_sz bytes.

88095728511e changed the return to:

	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);

It also moved the XDP-mode FCS strip into the if (!skb) block:

	if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
		buf1_len -= ETH_FCS_LEN;

Together, these two changes let a 0-3 byte buf1_len underflow.

Second, the second-buffer case. Before 88095728511e, stmmac_rx_buf2_len()
started with:

	if (!priv->sph_active)
		return 0;

stmmac_xdp_set_prog() clears sph_active while XDP is enabled, so buf2_len
was always 0 in XDP mode. That check is now:

	if (!stmmac_rx_check_buf2_cap(priv))
		return 0;

So "GMAC4/XGMAC always provide a second data buffer per descriptor" has
only been true since 88095728511e. The new buf2_len drop fixes a condition
that commit introduced.

The last patch in this series ("net: stmmac: fix XDP RX buffer DMA sync
length") already carries Fixes: 88095728511e.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3fa2c15222d88..30a2774d722b7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5903,18 +5903,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
> +		/* We do not support SG in XDP mode */
> +		if (unlikely(!error && (status & rx_not_ls) &&
> +			     stmmac_xdp_is_enabled(priv))) {
> +			rx_dropped++;
> +			error = 1;
> +		}
>  
>  		if (unlikely(error)) {
> +			if (status & rx_not_ls)
> +				goto read_again;
> +
>  			dev_kfree_skb(skb);
>  			goto next;
>  		}

[Severity: High]
This is a pre-existing issue, and this patch did not introduce it. The new
error-and-drain handling only runs when stmmac_xdp_is_enabled() is true.
Without an XDP program, can the same re-parse still happen when
napi_build_skb() fails on a non-last descriptor?

The failure branch in stmmac_rx() leaves skb == NULL and error == 0:

	skb = napi_build_skb(page_address(buf->page),
			     rx_q->napi_skb_frag_size);
	if (!skb) {
		page_pool_recycle_direct(rx_q->page_pool,
					 buf->page);
		buf->page = NULL;
		rx_dropped++;
		count++;
		goto drain_data;
	}
	...
drain_data:
	if (likely(status & rx_not_ls))
		goto read_again;

The next descriptor of the same hardware frame then passes the error check
and is handled as the start of a new frame.

SPH is active by default on SPH-capable GMAC4/XGMAC when no XDP program is
attached. In that case stmmac_rx_buf1_len() returns 0 for this descriptor:

	if (priv->sph_active && len)
		return 0;

napi_build_skb() then builds an skb with an empty linear area, and the
payload is only in a buf2 frag. pskb_trim(skb, len) does nothing, because
the stale len is larger than skb->len.

With the default hw_vlan_en, nothing pulls the header into the linear area
before this call chain:

	eth_type_trans()
	  eth_skb_pull_mac()
	    skb_pull_inline(skb, ETH_HLEN)
	      __skb_pull()
	        BUG()

Under memory pressure, could an on-link peer panic the machine this way by
sending a frame larger than one buffer? GMAC_CONFIG_JE is set in
GMAC_CORE_INIT, so such frames are accepted even at MTU 1500.

Without SPH, the stack instead gets a frame whose Ethernet header comes
from the middle of the peer's payload.

This path is still unchanged at the end of the series. The VLAN rework in
"net: stmmac: fix VLAN tag stripping on short and non-linear RX frames"
adds pskb_may_pull() only to the software stmmac_rx_vlan() path.

Would it drain the frame correctly to set error = 1 in the
napi_build_skb() failure branch, as this patch does for XDP mode?

> @@ -5926,6 +5931,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
>  		len += buf2_len;
>  
> +		/* Drop the packet if it is split over buf1 and buf2 on a
> +		 * single descriptor if the interface is running in XDP mode.
> +		 */
> +		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> +			rx_dropped++;
> +			goto next;
> +		}

[Severity: Medium]
This isn't a bug introduced by this patch. The new drop paths add to
rx_dropped, which stmmac_rx() folds into a device-wide counter at the end:

	priv->xstats.rx_dropped += rx_dropped;
	priv->xstats.rx_errors += rx_errors;

These are plain unsigned long fields in struct stmmac_extra_stats. They
are updated with a non-atomic read-modify-write, and no shared lock is
held.

Each RX queue has its own NAPI instance. Can two queues polled on
different CPUs lose each other's increments here? The napi_syncp section
just before this only protects the per-queue rxq_stats.

The race goes back to 133466c3bbe171 ("net: stmmac: use per-queue 64 bit
statistics where necessary").

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com
