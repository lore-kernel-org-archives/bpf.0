Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157677;
	b=KiRPYxZGX9l1Ig07q5JENCFYOn7uXGYmBJb7xdiE6vTDymKTlnHwDIUgUUeh8KoMYgj7
	 JAhNQp5jvNNSNNZPRIkmKJacJ96GSvXOQsolhuWxyLHQK4x3Sn5nICToCIZrg0Na3R6Nm
	 QNTnnYnpH+Ntwv5z0w7L7m9D0e7sL4Ci5UVxyd7wRgRaGpuKvivJpRFJwqEua39ptc7qY
	 Cgye6bwo35fJQ5QLgSkr8waEN+yNltDymYfgrgnd5XOuGT5QqXgxW8d5uQ55a86/fJvqu
	 BajsglnwzVAEOvUE6ZV8IT2lXbilNNrGVnIEVRg90n6wbM0YYTRds+4kVi8Wj3TnVpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157677;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wP737PCJGYShOq4BRXU6RG/HvtngMGBhbdjrd3PF9kU=;
	b=RRzPinHP6MuxdX017aruILbJUw1djNIJpa+dyyAP0T+Lck3BdRihbuYsiufF6KTVFg45
	 91h4BU4Xk0ek1bAADMpvfAG+djK8fitDbQ/UxtwaBBGaJjQLuCRppCsv7MjCXsCUsPd5S
	 u87Ka5TQKycGtS+e6SdUCgWugmdV0b59/u165pgt9IXeMQu0ZBVT2DwIhb6sKA1jwppau
	 Jyg+8lPHPBCDg+GhSwWyZzLkA7VrBOw7/CwEH+vbWdugW+SYAjQOrf4iwkKTPiKqqrv0+
	 SHJHJrm/Nj+tVM3Tfr6v6Sjm+p3qI9otzc3ak5gw7G4RjrGsEPv5iHbNcxLGTzhj4XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGgu+SeY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C5606A320;
	Fri, 20 Nov 2026 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGgu+SeY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799FC1F000C4;
	Fri, 20 Nov 2026 06:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157676;
	bh=wP737PCJGYShOq4BRXU6RG/HvtngMGBhbdjrd3PF9kU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aGgu+SeYwfCyfdb2jIb4Zma8mdFEyiqEdQoX4JgSKyUjB+x5sinccKalBgNjapIKn
	 JgtX756vIw8UTUHyjjI4cHrmDvGOI/dfIct+RVgHz42oobfzOhi6KE8unCowBoQpQa
	 Vr5de9g6e1/fvgJcqvxUtlp2wyYc1hkCkIRNoYMuPediZE+bpaB8X7VhZpbmNq7GfG
	 kEsNpRs6fFAD6G/ciWM3muNNBpx22pO9n88TDoij1GFSvK0uwjLCJpf7Omfb+KPJoc
	 4cWfDFbG80nci+4T7r0lJiDxN7RHI/zwvNDPGzaYxpTFa24XitRcQQ7ZjpVlKAibVk
	 hUlkXdVxCXXDw==
Subject:
 Re: [PATCH net] net: stmmac: fix num tx queues in stmmac_xdp_get_tx_queue()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, olteanv@gmail.com, 0x1207@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Fri, 20 Nov 2026 06:54:35 +0000
Message-ID: <179515767503.3136.16869341951535795256@kernel.org>
In-Reply-To: <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
References: <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says a TX queue passed to
  netdev_get_tx_queue() must be below dev->real_num_tx_queues while…
- [Low] The commit message's reason for the change is technically wrong.
- [Low] stmmac_xdp_get_tx_queue() now bounds the queue index by
  priv->xmit_qdisc.num_tx_queues and assumes it equals…
- [Low] stmmac_xdp_get_tx_queue() (stmmac_main.c:5411) reads
  priv->xmit_qdisc.num_tx_queues with a plain load from NAPI softirq and…
- [Low] For XDP_TX, the TX queue is computed twice per RX NAPI poll: -
  stmmac_xdp_xmit_back() (stmmac_main.c:5436) calls…

--

net: stmmac: fix num tx queues in stmmac_xdp_get_tx_queue()

This commit makes stmmac_xdp_get_tx_queue() wrap the CPU index by
priv->xmit_qdisc.num_tx_queues instead of plat->tx_queues_to_use. The goal
is to keep XDP TX inside the real TX queue set when mqprio offload has
reduced real_num_tx_queues.

> The TX queue returned by stmmac_xdp_get_tx_queue() is passed to
> netdev_get_tx_queue(), so it must be lower than dev->real_num_tx_queues.

[Severity: Low]
Is this reasoning accurate? netdev_get_tx_queue() only requires the index
to be below num_tx_queues, not real_num_tx_queues:

include/linux/netdevice.h:netdev_get_tx_queue() {
	DEBUG_NET_WARN_ON_ONCE(index >= dev->num_tx_queues);
	return &dev->_tx[index];
}

The old index always had a DMA ring behind it as well, because
tc_setup_dwmac510_mqprio() caps the mqprio queue range at
tx_queues_to_use:

	if (qopt->offset[i] + qopt->count[i] >
	    priv->plat->tx_queues_to_use) {

As far as I can tell, what users see with the old code is XDP frames
bypassing the mqprio/FPE TC-to-queue mapping. In channel mode they can land
on unmapped queues, which tc_mqprio_config_queue_prio() sets to prio 0
under strict priority.

Could the commit message describe that impact instead, so stable
backporters can judge it?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 25894771e9e9f..cf87afd273439 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5408,13 +5408,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
>  				   int cpu)
>  {
> +	unsigned int num_tx_queues = priv->xmit_qdisc.num_tx_queues;

[Severity: Low]
Can this value get out of sync with dev->real_num_tx_queues while the tc
mqprio configuration is being changed?

In tc_setup_dwmac510_mqprio(), real_num_tx_queues is lowered (with
synchronize_net()) before the shadow copy is updated:

	err = netif_set_real_num_tx_queues(ndev, num_tx_queues);
	...
		tc_mqprio_config_queue_prio(priv, qopt);

	priv->xmit_qdisc.num_tx_queues = num_tx_queues;

No grace period follows the store. XDP_TX in NAPI and stmmac_xdp_xmit()
can therefore still pick a queue that was just removed from the real set,
and call netdev_get_tx_queue()/__netif_tx_lock() on it.

stmmac_reset_tc_mqprio() does the updates in the opposite order, and it
ignores the return value of the grow:

	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
	priv->xmit_qdisc.enabled = false;

	netdev_reset_tc(ndev);
	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);

If netif_set_real_num_tx_queues() fails here, the shadow stays above
real_num_tx_queues until the next stmmac_hw_setup(). That is the mismatch
this patch is trying to avoid.

Would it be simpler to read READ_ONCE(priv->dev->real_num_tx_queues)
directly, since that follows the core's publish-then-synchronize_net()
ordering?

[Severity: Low]
This is a plain load from NAPI softirq and ndo_xdp_xmit context.
tc_setup_dwmac510_mqprio() and stmmac_reset_tc_mqprio() write the field
with plain stores under RTNL while the device is up. Will KCSAN report
this as a data race?

This path already uses READ_ONCE() for other values that can be tuned at
runtime, for example in stmmac_xdp_xmit_xdpf():

	tx_coal = READ_ONCE(priv->tx_coal_frames[queue]);

Without an annotation, the compiler may re-load the field inside the loop
below. Suppose a re-load during stmmac_reset_tc_mqprio() returns a larger
value than the one used in the loop test. Then index goes negative, and
the mixed int/unsigned comparison treats it as a very large value.

I have no evidence that any compiler actually does this here. Would it
still be worth adding READ_ONCE() here and WRITE_ONCE() at both writers?

Before this patch the divisor was plat->tx_queues_to_use. That value only
changes in stmmac_reinit_queues(), while the device is released and NAPI
is deleted.

>  	int index = cpu;
>  
>  	if (unlikely(index < 0))
>  		index = 0;
>  
> -	while (index >= priv->plat->tx_queues_to_use)
> -		index -= priv->plat->tx_queues_to_use;
> +	while (index >= num_tx_queues)
> +		index -= num_tx_queues;
>  
>  	return index;
>  }

[Severity: Low]
The divisor can now change at runtime. Can the two calls to this helper
in one RX NAPI poll then return different queues for XDP_TX?

stmmac_xdp_xmit_back() picks the queue for each frame, posts descriptors
and flushes the tail pointer. It does not arm the coalescing timer:

	queue = stmmac_xdp_get_tx_queue(priv, cpu);
	nq = netdev_get_tx_queue(priv->dev, queue);
	...
		stmmac_flush_tx_descriptors(priv, queue);

stmmac_finalize_xdp_rx() then computes the queue again at the end of
stmmac_rx()/stmmac_rx_zc(), and arms the timer on that result:

	queue = stmmac_xdp_get_tx_queue(priv, cpu);

	if (xdp_status & STMMAC_XDP_TX)
		stmmac_tx_timer_arm(priv, queue);

If tc_setup_dwmac510_mqprio() changes xmit_qdisc.num_tx_queues between the
two calls, the frames sit on ring A while the timer is armed on ring B.

stmmac_xdp_xmit_xdpf() only sets IC periodically:

	if (tx_coal && (tx_q->tx_count_frames % tx_coal) < num_frames) {

So up to tx_coal - 1 descriptors on ring A may get neither a completion
interrupt nor a timer to schedule stmmac_tx_clean().

After a shrink, ring A can be outside the new real set and may not be used
again. In that case the page_pool pages and DMA buffers stay held until
ifdown, or until the queue is used again.

stmmac_xdp_xmit() arms the timer on the same queue it flushes, so only
the split XDP_TX path appears to be affected.

[Severity: Medium]
The commit message says the TX queue must be lower than
real_num_tx_queues. Does the AF_XDP zero-copy TX path still violate that?

stmmac_tx_clean() calls stmmac_xdp_xmit_zc() for any queue whose
tx_q->xsk_pool is set, and stmmac_xdp_xmit_zc() uses the queue id
directly:

	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];

The queue id is only checked against plat->tx_queues_to_use, in both
stmmac_xdp_enable_pool() and stmmac_xsk_wakeup():

	if (queue >= priv->plat->rx_queues_to_use ||
	    queue >= priv->plat->tx_queues_to_use)
		return -EINVAL;

The core's xsk_reg_pool_at_qid() accepts any queue_id below
max(real_num_rx_queues, real_num_tx_queues). stmmac_hw_setup() keeps
real_num_rx_queues at rx_queues_to_use.

For example, take tx = rx = 4 and mqprio with 2 TCs on queues 0 and 1.
real_num_tx_queues is then 2. An AF_XDP zero-copy socket bound to queue 3
still transmits on TX queue 3, outside the mqprio TC set.

tc_setup_dwmac510_mqprio() does not check af_xdp_zc_qps either, so
shrinking the queue set after the bind gives the same result.

Should stmmac_xdp_enable_pool(), stmmac_xsk_wakeup() and the mqprio setup
also check against xmit_qdisc.num_tx_queues?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c%40oss.qualcomm.com
