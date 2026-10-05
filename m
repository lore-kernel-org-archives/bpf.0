Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D3314B66;
	Mon,  5 Oct 2026 04:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175106; cv=none; b=h1UUfkqCrda1ktTqDWSD1Dr4sii9Y/Xoby3t2I4tAFIrhUPjaHJ6WVwqk9jpfXuRCyXVtxRLhiCBC8ZHN+u0EYqfNCeDq30i0z8d3VyzVqWHYvs2hJsEiGmW+LAUX6jgtcnmUMcL0uOqOcZLEdK11b4RDmogbGFEAiugJPNGxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175106; c=relaxed/simple;
	bh=15ur8fqV1OLEwbA54O5NhgsVr+d/c5hhHH+1oZwTt/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7w0bQogqHqxUULE7tUrEseROQ6xjeoGvfFNKU8M4NiQBsJw0BYCRXS45K6e/7jpxh3oV8rjHl2muwv2tlww9R+WuvugtSvApKamRFyo2IebQMJ8R7GwNuZuctYy5apQvgdFAQCm5ZPZaQwVqXCSixoKOKHvSzBtgJFuSbBjUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dpi0nWYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dpi0nWYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6E91F00893;
	Mon,  5 Oct 2026 04:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791175103;
	bh=prj36X89FCSiP6RVyAsb7oBjYhBNv9z/wSeGzLB7KRc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dpi0nWYXHA/+IYTGJOk0pSaQ6hjK8U1RAeN8W44IaSHQGKhVHKyjF9bcuzD7i7q8S
	 xlQ8N0sU6nceYvUxyu37VA3To8++ILJNp5BuASsFom8uqrjj+mYuygeZfFBEzUn6UD
	 hkMwYEw1ASK2kt8kOMOF7XNTvUCvfvu2LzI0YnDTq3x79JXuQXhe864xVRQ3KfN4cG
	 tO4fw6iP6f+x6BdBGzMJYrbm2g4COZsHe29DIcJm14PnbIltMB57zalVAQRvFoV3XI
	 sgcnBvR9thh2nRy8dSqYmbDzoJWcfnHhwdOtgL/xz5RcNKy8T1aeKF1pF1RNUl53KB
	 enEKt//dERFEg==
Subject: Re: [PATCH net-next v4 4/4] net: stmmac: restore EST before starting
 DMA on open and resume
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 lorenzo.bianconi@oss.qualcomm.com, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, linux@armlinux.org.uk,
 edumazet@google.com, davem@davemloft.net, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, fancer.lancer@gmail.com, horms@kernel.org,
 maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 05 Oct 2026 04:38:21 +0000
Message-ID: <179117510159.434549.6990304999484677101@kernel.org>
In-Reply-To:
 <20260930-stmmac-est-reapply-after-open-v4-4-9d4366587b73@gmail.com>
References:
 <20260930-stmmac-est-reapply-after-open-v4-4-9d4366587b73@gmail.com>
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

- [Medium] The patch gives stmmac_resume() a new way to fail: if
  stmmac_setup_est() returns an error, resume jumps to error_stop_dma…
- [Medium] __stmmac_open() can now fail at the new est_error exit
  (stmmac_main.c:4205-4207).
- [Medium] In __stmmac_open(), stmmac_start_all_dma() now runs after
  phylink_start() (stmmac_main.c:4211 -> 4216).

--

net: stmmac: restore EST before starting DMA on open and resume

The core reset clears the MTL_EST registers. This patch replays the cached
taprio/EST schedule after timestamp initialization in __stmmac_open() and
stmmac_resume(). It also moves stmmac_start_all_dma() out of
stmmac_hw_setup() and into its callers, so DMA starts only after the EST
replay succeeds.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e93f3238be1fb..2104eaef8806f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4200,12 +4199,22 @@ static int __stmmac_open(struct net_device *dev,
>  	if (ret)
>  		goto ptp_error;
>  
> +	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
> +	 * registers, so re-apply the taprio offload after PTP is up.
> +	 */
> +	ret = stmmac_setup_est(priv);
> +	if (ret < 0)
> +		goto est_error;

[Severity: Medium]
What state is the interface left in if this new exit is taken during an MTU
change?

The est_error exit comes after the memcpy() at the top of __stmmac_open()
has overwritten priv->dma_conf. It also comes before stmmac_init_coalesce(),
phylink_start() and the NAPI enable.

stmmac_change_mtu() reopens the device in place:

stmmac_change_mtu() {
    ...
		__stmmac_release(dev);

		ret = __stmmac_open(dev, dma_conf);
		if (ret) {
			free_dma_desc_resources(priv, dma_conf);
			kfree(dma_conf);
			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
			return ret;
		}
    ...
}

After this failure the interface stays IFF_UP. priv->dma_conf still holds
the descriptor, buffer and page pool pointers that were just freed. The
txtimers hold the zeroed hrtimers copied from the new dma_conf, because
stmmac_init_coalesce() was skipped.

The next close, ring parameter change or XDP change goes through
__stmmac_release(). Every NAPI is already disabled at that point. Would
stmmac_disable_all_queues() then hang forever in napi_disable() under
RTNL?

If execution got past that point, hrtimer_cancel() would run on
uninitialized hrtimers. free_dma_desc_resources(priv, &priv->dma_conf)
would then free the same rings a second time. Until then, readers such as
the debugfs descriptors_status file would dereference the freed
descriptor memory.

The ptp_error and irq_error exits already used this weak unwind. What
changes is that an EST register write timeout (readl_poll_timeout() in
est_write()) during a routine MTU change can now reach it. Before this
patch the device kept running, just without its EST schedule.

>  	stmmac_init_coalesce(priv);
>  
>  	phylink_start(priv->phylink);
>  
>  	stmmac_vlan_restore(priv);
>  
> +	/* Restore the installed schedule before starting DMA. */
> +	stmmac_start_all_dma(priv);

[Severity: Medium]
Can starting DMA after phylink_start() race with the phylink resolve
worker?

phylink_start() calls phylink_enable_and_run_resolve(), which queues
pl->resolve. phylink_resolve() does not take RTNL, so it can call
stmmac_mac_link_up() while __stmmac_open() is still running here.

stmmac_mac_link_up() sets speed and duplex with an unlocked
read-modify-write of MAC_CTRL_REG:

	old_ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
	ctrl = old_ctrl & ~priv->hw->link.speed_mask;
	...
	if (ctrl != old_ctrl)
		writel(ctrl, priv->ioaddr + MAC_CTRL_REG);

For each channel, stmmac_start_all_dma() does its own unlocked
read-modify-write of the same register. On dwmac4/5:

dwmac4_dma_start_tx() {
    ...
	value = readl(ioaddr + GMAC_CONFIG);
	value |= GMAC_CONFIG_TE;
	writel(value, ioaddr + GMAC_CONFIG);
}

dwmac4_dma_start_rx() does the same for GMAC_CONFIG_RE. GMAC_CONFIG has
the same offset as MAC_CTRL_REG. On XGMAC, dwxgmac2_dma_start_tx() does the
same on XGMAC_TX_CONFIG, which holds the speed field.

Consider this interleaving:

__stmmac_open()                      phylink_resolve worker
dwmac4_dma_start_tx()
  value = readl(GMAC_CONFIG)
                                     stmmac_mac_link_up()
                                       writel(ctrl, MAC_CTRL_REG)
  writel(value | TE, GMAC_CONFIG)

The open path writes back the stale speed and duplex. stmmac_mac_set() in
the worker only checks that TE/RE are set, so it does not correct this.
Would the link then report up while the MAC runs at the wrong speed or
duplex until the next link change?

Before this patch, DMA started inside stmmac_hw_setup(), before
phylink_start(), so these accesses could not overlap. stmmac_resume() is
not affected because DMA starts there before phylink_resume().

Would moving stmmac_start_all_dma() before phylink_start() close this
window and still replay EST before DMA starts?

>  	ret = stmmac_request_irq(dev);
>  	if (ret)
>  		goto irq_error;

[ ... ]

> @@ -8420,6 +8430,10 @@ int stmmac_resume(struct device *dev)
>  	}
>  
>  init_coalesce:
> +	ret = stmmac_setup_est(priv);
> +	if (ret < 0)
> +		goto error_stop_dma;

[Severity: Medium]
Does this error path leave the device half resumed?

error_stop_dma stops DMA, clears MAC TX/RX, powers down the serdes and
returns. It does not re-enable NAPI or call netif_device_attach().

stmmac_suspend() had already done this:

	netif_device_detach(ndev);

	stmmac_disable_all_queues(priv);

The interface is still IFF_UP. A later "ip link set down" would then run
this on NAPIs that are already disabled:

__stmmac_release()
  stmmac_disable_all_queues()
    napi_disable()
      napi_disable_locked()

napi_disable_locked() would then loop forever while holding RTNL:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

A stmmac_init_timestamping() failure could already reach this incomplete
unwind. This patch adds an EST trigger, most realistically an est_write()
register timeout. A failed EST reprogram used to be harmless at resume,
but now it leaves the device in this state.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73%40gmail.com
