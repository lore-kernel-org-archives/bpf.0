Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A43921CE;
	Wed, 30 Sep 2026 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743907; cv=none; b=VvA7vZXcfNJjVWWfzm6FJFVsbmekhAJPj/5Wr00+EZ5mvBGfpzdN9Twu0K9gT+Qg9hQ71tvqcCVNXYRuGdHcuHqvx5LVs/hrauQsma2BBuDzc9L41vZ4EJofuBYWJzQ7e2cChWs95sOXprXc+bFsz87OQvYSI3Wo+lIaWzBgRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743907; c=relaxed/simple;
	bh=zc0R2iLFrMmXDOQTkbLKrFkaQCBcXB6FUDJt5lXVha8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5oR1b48D0RL4Wob0I9bJFvcUOoWbziIac/bU2lDeusFbRleaNZkM+qFLnhrLZW2euxtJfLacCUMZTfTTNnlpuigVaOIRcn2aDzAxFS1jfM0z9DJHSHkL5E0OWKh6rbbw/1RnEgtFrJR0t6X0YWMA3bs9j4ZQ6R+PlpDnhPv71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWqwv//l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWqwv//l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3578D1F000FF;
	Wed, 30 Sep 2026 04:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743903;
	bh=y0tqHTN782R1/Eq2XbWjZv31M7aizWc4nWnFwpEFDy8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PWqwv//lPCq+GoUOZ7p1n/8JQORXjV/T8K+LmgEkuhnLx2oR8BdraKtycsMGExwip
	 /KDHXtgIFSd1cI4utSNly7lvgBbDeXzTAkKzMZnyg/8oZ+Nw6UrK4+hAcQZo95Yw/x
	 A2ZJvOBgkEJTMccjmyALHu83KCZn4++7Qs/EnkhvDm9Y4Y38V/6D90lBoNJ97JnE+I
	 LTWadXwYmpUNas6o6VHXI/bIDobbVLnrWlUrbhIQZ5Xax7xjm5bSKxtfzZDQL+snV+
	 afyPTkNQPixd86dhi1Afl/FZEwv4sv3XMcxeDbyHWOGhMOxxXduWHkOqT2/fwzlE5A
	 T4u9T/rb8ftPQ==
Subject: Re: [PATCH net v4 07/15] net: stmmac: unwind partially allocated DMA
 configurations
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
Date: Wed, 30 Sep 2026 04:51:40 +0000
Message-ID: <179074390079.434549.4487423701456206830@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-7-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-7-ec1c0250b3c9@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (2) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, __init_dma_rx_desc_rings() returns
  xdp_rxq_info_reg_mem_model() failures, and…
- [Medium] The stmmac_rx() hunk fixes a use-after-free and double-free
  that already exists in the RX NAPI hot path, but the commit message…

Pre-existing issues:
- [High] At this commit, __init_dma_rx_desc_rings() calls
  xsk_pool_set_rxq_info(pool, &rx_q->xdp_rxq) on the temporary dma_conf…
- [High] At this commit, stmmac_xdp_enable_pool() and
  stmmac_xdp_disable_pool() disable only the selected queue's NAPI.
- [Medium] stmmac_suspend() does not clear saved partial-RX state, and
  neither does stmmac_resume().

--

net: stmmac: unwind partially allocated DMA configurations

The RX/TX DMA allocation failure paths now free only the buffer arrays and
coherent memory that were actually allocated. RX resources are also freed
when TX allocation fails. RXQ memory model registration errors are now
propagated, and teardown clears XSK RXQ bindings, saved partial packets
and released pointers. stmmac_rx() now takes ownership of the saved
partial RX state when the poll starts.

> Take ownership of saved partial RX state at poll entry by clearing the
> saved flag and skb pointer immediately. Preserve incomplete state if the
> next descriptor is still DMA-owned. A budget-one completion must not
> leave an already delivered or freed skb reachable by the new teardown
> cleanup.
>
> Fixes: 71fedb0198cb ("net: stmmac: break some functions into RX and TX scopes")

[Severity: Medium]

Is this paragraph describing a use-after-free that already exists in
stmmac_rx()? As written, it only mentions the new teardown cleanup.

Before this patch, the saved state was restored only under:

    if (!count && rx_q->state_saved) {
        skb = rx_q->state.skb;
        ...
    } else {
        rx_q->state_saved = false;
        ...
    }

Suppose stmmac_rx() runs with limit == 1 and the saved partial frame
completes in that call:

- The skb goes to napi_gro_receive() or dev_kfree_skb().
- count becomes 1, and the loop exits before the else branch can clear
  state_saved.
- The trailing test is false:

    if (status & rx_not_ls || skb) {

So state_saved stays true, and state.skb still points at the skb that was
already delivered or freed. The next poll restores it and passes it to
skb_add_rx_frag(), napi_gro_receive() or dev_kfree_skb().

A budget of 1 looks reachable without privileges. The EPIOCSPARAMS
handler in ep_eventpoll_ioctl() requires CAP_NET_ADMIN only when
busy_poll_budget > NAPI_POLL_WEIGHT.

The saved-state logic seems to come from ec222003bd94 ("net: stmmac:
Prepare to add Split Header support"), not from 71fedb0198cb.

Could the stmmac_rx() change go in its own patch? Its commit message
could describe the use-after-free, with a Fixes tag pointing at
ec222003bd94.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bdebc5bfa2b8b..1cc68c1cf37dc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -1889,17 +1892,19 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
>  	rx_q->xsk_pool = stmmac_get_xsk_pool(priv, queue);
>  
>  	if (rx_q->xsk_pool) {
> -		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
> -						   MEM_TYPE_XSK_BUFF_POOL,
> -						   NULL));
> +		ret = xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
> +						 MEM_TYPE_XSK_BUFF_POOL, NULL);
> +		if (ret)
> +			return ret;
>  		netdev_info(priv->dev,
>  			    "Register MEM_TYPE_XSK_BUFF_POOL RxQ-%d\n",
>  			    queue);
>  		xsk_pool_set_rxq_info(rx_q->xsk_pool, &rx_q->xdp_rxq);

[Severity: High]

This isn't a bug introduced by this patch, but this binds the pool to
the xdp_rxq of whichever dma_conf is being initialized. On open, that is
the temporary conf built by stmmac_setup_dma_desc(). __stmmac_open()
then copies it:

    memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));

and stmmac_open() frees the temporary:

    kfree(dma_conf);

Does that leave the XSK pool's xdp.rxq pointing into freed memory? ZC
receive paths could then dereference it, for example stmmac_xdp_xmit_back()
reading xdp->rxq->mem.type, or xsk_rcv_check().

The clearing this patch adds at teardown does not cover the open path.

This dates back to ba39b344e924. The next patch in the series, "net:
stmmac: keep DMA configurations at stable addresses", appears to fix it
by storing the allocated conf pointer in priv instead of copying it.

>  	} else {
> -		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
> -						   MEM_TYPE_PAGE_POOL,
> -						   rx_q->page_pool));
> +		ret = xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
> +						 MEM_TYPE_PAGE_POOL, rx_q->page_pool);
> +		if (ret)
> +			return ret;

[Severity: High]

With these errors now returned, what happens on the XSK pool
enable/disable path? stmmac_enable_rx_queue() returns void:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_enable_rx_queue() {
    ...
	ret = __init_dma_rx_desc_rings(priv, &priv->dma_conf, queue, GFP_KERNEL);
	if (ret) {
		__free_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
		netdev_err(priv->dev, "Failed to init RX desc.\n");
		return;
	}
    ...
}

stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool() then continue
anyway:

	stmmac_enable_rx_queue(priv, queue);
	stmmac_enable_tx_queue(priv, queue);
	napi_enable(&ch->rxtx_napi);

__free_dma_rx_desc_resources() now sets buf_pool, page_pool, dma_rx and
dma_erx to NULL. Can the re-enabled NAPI poll reach stmmac_rx() or
stmmac_rx_zc() and dereference those NULL pointers? In the enable path,
stmmac_xsk_wakeup() also kicks the poll.

This path could already crash on allocation failure before this patch.
The patch adds mem-model registration failure as another trigger.

A later patch in the series, "net: stmmac: use the tracked datapath
restart for XSK pool changes", replaces these void helpers with
stmmac_xdp_release()/stmmac_xdp_open() and checks the error. So this is
fixed by the end of the series, but it is still exposed at this commit.

[ ... ]

> @@ -2206,10 +2227,16 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
>  
>  	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
>  
> -	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
> +	if (addr)
> +		dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
>  
>  	kfree(tx_q->tx_skbuff_dma);
>  	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff_dma = NULL;
> +	tx_q->tx_skbuff = NULL;
> +	tx_q->dma_etx = NULL;
> +	tx_q->dma_entx = NULL;
> +	tx_q->dma_tx = NULL;

[Severity: High]

This is a pre-existing issue, but stmmac_xdp_enable_pool() and
stmmac_xdp_disable_pool() disable only the selected channel's NAPI.
stmmac_disable_tx_queue() then frees the ring:

	stmmac_stop_tx_dma(priv, queue);
	__free_dma_tx_desc_resources(priv, &priv->dma_conf, queue);

At that point only RTNL and ch->lock are held. Other TX producers take
only the netdev TX queue lock:

- stmmac_xmit()
- stmmac_xdp_xmit()
- XDP_TX from other RX queues, which pick a TX queue by CPU

Can these still touch tx_skbuff_dma[], dma_tx and cur_tx while the ring
is being freed?

Before this patch that would be a use-after-free. With the new NULL
assignments it becomes a NULL dereference instead.

In the final state of the series, stmmac_xdp_release() detaches the
netdev and quiesces all queues before freeing. ndo_xdp_xmit also checks
netif_device_present() under the TX lock.

>  }

[ ... ]

> @@ -5740,6 +5770,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
>  				    rx_q->dma_rx_phy, desc_size);
>  	}
> +	if (in_progress) {
> +		skb = rx_q->state.skb;
> +		error = rx_q->state.error;
> +		len = rx_q->state.len;
> +		rx_q->state.skb = NULL;
> +		rx_q->state_saved = false;
> +	}

[Severity: Medium]

This is a pre-existing issue, but does anything clear the saved
partial-RX state across suspend/resume? stmmac_resume() resets the ring
and DMA:

	stmmac_reset_queues_param(priv);

	stmmac_free_tx_skbufs(priv);
	stmmac_clear_descriptors(priv, &priv->dma_conf);

	ret = stmmac_hw_setup(ndev);

rx_q->state_saved, state.skb, state.len and state.error are left as
they were, and stmmac_suspend() does not clear them either.

If suspend happened mid-frame, the first poll after resume would restore
the stale skb and len here. It would then treat the first new frame at
descriptor 0 as a continuation and append that frame's buffers as frags.

With split header active, the stale len is also passed to
stmmac_rx_buf1_len() and stmmac_rx_buf2_len(). buf1_len would be 0
because len is non-zero. In stmmac_rx_buf2_len(), plen - len could
underflow if the new frame is shorter than the stale len.

The state is only cleared in stmmac_reinit_dma_desc() and
__free_dma_rx_desc_resources(). The SUSPENDED branch of
stmmac_init_dma_engine() later in the series does not clear it either.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
