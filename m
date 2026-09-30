Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7093A7F7C;
	Wed, 30 Sep 2026 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743909; cv=none; b=HtzcBzT0JYmId8MFe+yQwcfETr5jUwvFqHh/o9cHlu3J/A4ep5JSUwLe18oiG76sUA8teLZh9/NX4SzuR+kkfO5oDnHsmxP7sqLhzg6nn4QdeCn7S8k+lsjVz8nc1nuBfTIOeuSyelm3SHRO8+7Fn21BsM9NExtYFaAQmQ/PkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743909; c=relaxed/simple;
	bh=Xredob3MSfLcyo+/z/V1qymC+bqAAE+bUtc/ddD9x4g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRZrnrfh7VHTPw/OzqzT7whtTapxDCt9noqczp2iy5G0cAH6oEp5DhCRfxobbDJ58FPXt3Uy6nVRYx6RffRTlWYPXX5pLwtyG2Kk7LRV8H+6yqJMXSPWv6W8K9oWz8zHWvlKHgsGJuQ9zbNP+ssa3fFRgetKWD41Twt5HxYb6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o28MrT+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o28MrT+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3EE1F00899;
	Wed, 30 Sep 2026 04:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743907;
	bh=EFI2abLaq7r5ln28SXHp0wwhyj1uvWz9+Rc2B5EajZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o28MrT+cTAK2hKCfUuwOqfdbh0uE5kNV5pSvFrB9l9kArbdwz3Djk04BoYVq8pFBW
	 NuKEbbsUQ009SiQiGa0O4Cn8/Q6MndKnIRb2EC5QsRSC7m6gRSayfn+966mJ1Exoyg
	 VAIYpCtv81k4vnQgzxRloQFvb+GE5BxUdICaYZ6nDW/ExFl3EDuwrw4XNAz5h6tVwm
	 71uz0B2CVS9rCm/aB3+7CSeg/8NpdREzc92/SGLlhca13G/yxEyZJPoYWFSrCK1jKk
	 wjlQXvQJVCVBgzSG3JGUxAgOpttbi2w/xPmzyaOIPBHfGkuDsxfE2i6JmgabFgf1SP
	 pwGS7Y4VTfbfg==
Subject: Re: [PATCH net v4 08/15] net: stmmac: keep DMA configurations at
 stable addresses
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 linusw@kernel.org, martin.blumenstingl@googlemail.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, horms@kernel.org,
 bjorn@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com,
 wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 edumazet@kernel.org, richard.genoud@bootlin.com, alastair@d-silva.org,
 mripard@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com, linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
Date: Wed, 30 Sep 2026 04:51:44 +0000
Message-ID: <179074390401.434549.11527425474596894554@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-8-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-8-ec1c0250b3c9@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] stmmac_change_mtu() now calls netif_device_detach(dev) before
  __stmmac_release()/__stmmac_open().
- [Medium] stmmac_xsk_wakeup() now decides only on test_bit(queue,
  priv->af_xdp_zc_qps).

Pre-existing issues:
- [High] At this commit, when __stmmac_open() fails after
  stmmac_hw_setup() (for example in stmmac_request_irq()), the irq_error…

--

net: stmmac: keep DMA configurations at stable addresses

This commit changes priv->dma_conf from an embedded struct into a pointer
to the allocated configuration, so XDP rxq metadata and AF_XDP pool
references keep pointing at valid storage. Per-queue MSI handlers now use
the persistent channel objects as their context, and new quiesce helpers
drain transmitters and NAPI before the TX timers are cancelled. The MTU
reopen path is also wrapped in netif_device_detach()/netif_device_attach().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1cc68c1cf37dc..c4ba97d57b47e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4222,7 +4223,7 @@ static int __stmmac_open(struct net_device *dev,
>  	phylink_stop(priv->phylink);
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
> -		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> +		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
>  
>  	stmmac_release_ptp(priv);
>  init_error:

[ ... ]

> @@ -4275,34 +4277,54 @@ static int stmmac_open(struct net_device *dev)
>  err_runtime_pm:
>  	pm_runtime_put(priv->device);
>  err_dma_resources:
> +	priv->dma_conf = old_conf;
>  	free_dma_desc_resources(priv, dma_conf);
>  	kfree(dma_conf);
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue that this patch did not introduce, but can
the DMA engine still be using these rings when they are freed?

Say __stmmac_open() fails after stmmac_hw_setup(), for example in
stmmac_request_irq(). The irq_error path only does this:

irq_error:
	phylink_stop(priv->phylink);

	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);

	stmmac_release_ptp(priv);

The MAC is still enabled at that point. The RX/TX DMA channels that
stmmac_hw_setup()->stmmac_start_all_dma() started are also still
running.

stmmac_open() then calls free_dma_desc_resources() and kfree() on
dma_conf here. stmmac_change_mtu() does the same on its failure path, and
stmmac_xdp_open() follows the same pattern.

Could the hardware keep reading or writing freed descriptor memory and
page_pool buffers?

A later commit in this series, "net: stmmac: retain DMA memory until
hardware shutdown completes", appears to fix this. It makes the
__stmmac_open() and stmmac_xdp_open() failure paths call
stmmac_drain_dma(), and it keeps configurations owned by DMA until a
confirmed reset.

[ ... ]

> @@ -6216,19 +6239,22 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  			return PTR_ERR(dma_conf);
>  		}
>  
> +		netif_device_detach(dev);
>  		__stmmac_release(dev);
>  
>  		ret = __stmmac_open(dev, dma_conf);
>  		if (ret) {
> +			priv->dma_conf = old_conf;
>  			free_dma_desc_resources(priv, dma_conf);
>  			kfree(dma_conf);
>  			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
>  			return ret;
>  		}
>  
> -		kfree(dma_conf);
> +		kfree(old_conf);
>  
>  		stmmac_set_rx_mode(dev);
> +		netif_device_attach(dev);
>  	}

[Severity: Medium]
Does the interface stay detached for good if __stmmac_open() fails here?

netif_device_detach() runs unconditionally. netif_device_attach() is only
reached on the success path. When stmmac_hw_setup() or
stmmac_request_irq() fails, stmmac_change_mtu() returns with
__LINK_STATE_PRESENT still cleared.

At this point in the series, neither stmmac_release() nor stmmac_open()
calls netif_device_attach(). __dev_open() refuses to open a device that
is not present, so a later "ip link set up" looks like it would fail with
-ENODEV until the driver is rebound or the system goes through
suspend/resume.

A later commit in the series, "net: stmmac: track datapath and power
ownership across failed reopening", adds netif_device_attach() to
stmmac_release() ("Allow a fresh open after a failed MTU reopen or
resume") and reworks this path, so the end of the series looks fine.
Should the failure branch here also reattach, so the series bisects
cleanly?

[ ... ]

> @@ -7305,11 +7321,9 @@ int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags)
>  	    queue >= priv->plat->tx_queues_to_use)
>  		return -EINVAL;
>  
> -	rx_q = &priv->dma_conf.rx_queue[queue];
> -	tx_q = &priv->dma_conf.tx_queue[queue];
>  	ch = &priv->channel[queue];
>  
> -	if (!rx_q->xsk_pool && !tx_q->xsk_pool)
> +	if (!test_bit(queue, priv->af_xdp_zc_qps))
>  		return -EINVAL;

[Severity: Medium]
Can this new check schedule rxtx_napi on a queue whose rings were never
set up?

In stmmac_xdp_enable_pool() the bit is set before the queue enables,
which return void:

	set_bit(queue, priv->af_xdp_zc_qps);

	if (need_update) {
		stmmac_enable_rx_queue(priv, queue);
		stmmac_enable_tx_queue(priv, queue);
		napi_enable(&ch->rxtx_napi);

		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);

stmmac_enable_rx_queue() and stmmac_enable_tx_queue() just log and return
if allocation fails.

If both fail, the old check (!rx_q->xsk_pool && !tx_q->xsk_pool) returned
-EINVAL. The new check passes because the bit is set, so rxtx_napi gets
scheduled. stmmac_napi_poll_rxtx()->stmmac_rx_zc() would then run on
unallocated rings with rx_q->xsk_pool == NULL.

A later commit in the series, "net: stmmac: use the tracked datapath
restart for XSK pool changes", replaces the void per-queue helpers with
stmmac_xdp_release()/stmmac_xdp_open(). On open failure it clears the bit
and returns an error.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
