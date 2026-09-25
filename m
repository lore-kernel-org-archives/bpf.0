Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42B471437;
	Fri, 25 Sep 2026 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363527; cv=none; b=aZvPVv+Vm6EtXq8B3xePXdD9jULt7tMD37P+H3O3B4HIPGx9yuogRl3vtSteGcMN69UcQcivAhxY5soSwegBN84OxtujLgTyrB3dfxcdwHA+kwJoG0m+ZMIZTGsHz2Cz/igAh5+gKhfpgfNjxrtnXraT1c83H+zr1abMi+pVpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363527; c=relaxed/simple;
	bh=rgi29i6UFdCCMsHHSzDcksPAqlD5gB9Z5GMxTeN1104=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WHfaI5de/8fM9nqe/AAK9gb+YJ37XfV8I8PI0QQ2nS7zo1BiS1cpBocPVZ075Se3Do255bXVilyfRmFOtYxDbqluQYdx3E3cOL6K72qqFOiOl3gi1j6/hLowYlJy3IWot7MclfmlVSEiLeIFwkPKl9fWKw4yd4EWvrJDexnGKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7bKiq69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7bKiq69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819CC1F00893;
	Fri, 25 Sep 2026 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363521;
	bh=C9PyPbAN1dnOqUxdj85Y3ZzNfk2hgIo1QkMqTiVfzxQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h7bKiq69Q9kCzElLozJ/5BY5UWP8Q+KIyKD0xq2osePiQrhgIBNtztrrg3/zimMu8
	 IK6nmJkD/58ovcWAA8PgV2WS3e6kzkZWrhrkQHq8497pXuKVjOgvyBAj8+qsWNodDr
	 j9SIuVbY/mJe5diUJaLi2CPu3EIuBDv3SK6NZosLuzstDk7wL/yIJN+bxK6OyVjIuw
	 Gw3UAGkegtMwFimKT7TdUmryUp12F+af2Nt2y1pGVhR61yr4qzUzAK1mrabpUKc6iz
	 AK2bLRBcHn4IQmUu+JGTwplSQzvSJj8V0OoP+JU9ehywi25EXdDjCHzlacIKEv2pqG
	 r//k6b5H2YAjQ==
Subject: Re: [PATCH net v3 05/10] net: stmmac: unwind partially allocated DMA
 configurations
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 richard.genoud@bootlin.com, alastair@d-silva.org, mripard@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com
Date: Fri, 25 Sep 2026 19:11:59 +0000
Message-ID: <179036351907.2160803.4428772816232476933@kernel.org>
In-Reply-To:
 <20260924-submit-stmmac-reset-fixes-v1-v3-5-c031e3f3a282@gmail.com>
References:
 <20260924-submit-stmmac-reset-fixes-v1-v3-5-c031e3f3a282@gmail.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Possible double free of a saved RX skb.
- [Medium] Baseline decision: discard, because it is resolved later in
  the series.

Pre-existing issues:
- [Low] Baseline decision: discard, because it is resolved later in the
  series.
- [Low] Baseline decision: discard, because it predates this patch and is
  resolved later in the series.

--

net: stmmac: unwind partially allocated DMA configurations

This commit lets the RX and TX DMA free paths handle partially allocated
queues, and releases RX resources when TX allocation fails. It propagates
xdp_rxq_info_reg_mem_model() errors and clears XSK RXQ bindings. It also
frees any saved partial RX skb and NULLs the released resource pointers.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f7e91ae214483..3b918cf898067 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -1884,17 +1887,19 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
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

[Severity: Low]
This problem already existed before this patch, but is the XSK pool bound
here to an xdp_rxq that is about to be freed?

On the stmmac_open() path, __init_dma_rx_desc_rings() works on the
temporary dma_conf from stmmac_setup_dma_desc(). __stmmac_open() then
copies that conf:

	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));

After that, stmmac_open() calls kfree(dma_conf). Nothing rebinds the pool
to &priv->dma_conf.rx_queue[queue].xdp_rxq, so the pool's rxq pointers
seem to point into freed memory.

The next patch in the series, "net: stmmac: keep DMA configurations at
stable addresses", appears to fix this. It keeps the allocated dma_conf
and removes the memcpy.

>  	} else {
> -		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
> -						   MEM_TYPE_PAGE_POOL,
> -						   rx_q->page_pool));
> +		ret = xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
> +						 MEM_TYPE_PAGE_POOL, rx_q->page_pool);
> +		if (ret)
> +			return ret;

[Severity: Medium]
Now that this error is returned, how do the per-queue callers handle it?

stmmac_enable_rx_queue() returns void. When this call fails, it releases
the queue and returns:

	ret = __init_dma_rx_desc_rings(priv, &priv->dma_conf, queue, GFP_KERNEL);
	if (ret) {
		__free_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
		netdev_err(priv->dev, "Failed to init RX desc.\n");
		return;
	}

With this patch, __free_dma_rx_desc_resources() also sets buf_pool,
dma_rx, dma_erx and page_pool to NULL. After that,
stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool() in stmmac_xdp.c
carry on as usual:

		stmmac_enable_rx_queue(priv, queue);
		stmmac_enable_tx_queue(priv, queue);
		napi_enable(&ch->rx_napi);
		napi_enable(&ch->tx_napi);

Both return 0, so NAPI can run on a released RX queue whose ring pointers
are NULL. stmmac_xdp_set_prog() also ignores the return value of
stmmac_xdp_open().

These callers already behaved this way for the -ENOMEM return from
stmmac_alloc_rx_buffers(). This patch adds a second way to reach it.

Two later patches in the series appear to fix this: "net: stmmac: account
for failed live XDP reopening" and "net: stmmac: use the tracked datapath
restart for XSK pool changes". They check the stmmac_xdp_open() result
and remove the per-queue enable helpers.

[ ... ]

> @@ -2137,10 +2147,16 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	void *addr;
>  
>  	/* Release the DMA RX socket buffers */
> -	if (rx_q->xsk_pool)
> +	if (rx_q->xsk_pool) {
>  		dma_free_rx_xskbufs(priv, dma_conf, queue);
> -	else
> +		xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
> +	} else {
>  		dma_free_rx_skbufs(priv, dma_conf, queue);
> +	}
> +	if (rx_q->state_saved)
> +		dev_kfree_skb_any(rx_q->state.skb);
> +	rx_q->state.skb = NULL;
> +	rx_q->state_saved = 0;

[Severity: High]
Can this free an skb that the driver no longer owns?

This free assumes that state_saved means the driver still owns
rx_q->state.skb. However, stmmac_rx() does not clear the saved state when
it takes it:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx() {
    ...
		if (!count && rx_q->state_saved) {
			skb = rx_q->state.skb;
			error = rx_q->state.error;
			len = rx_q->state.len;
		} else {
			rx_q->state_saved = false;
    ...
}

state_saved is only cleared in the else branch, which runs on a later
iteration with count > 0. With limit == 1, the first iteration can finish
the restored skb. It can pass it to napi_gro_receive(), or free it on the
error path:

		if (unlikely(error)) {
			dev_kfree_skb(skb);
			skb = NULL;
			count++;
			continue;
		}

count is now 1, so the while (count < limit) loop exits. The save block
after the loop is skipped, because skb is NULL and the last descriptor
did not have rx_not_ls set:

	if (status & rx_not_ls || skb) {
		rx_q->state_saved = true;
		rx_q->state.skb = skb;
		...
	}

state_saved stays set, and state.skb points to an skb that was freed or
handed to the stack. A later poll that hits a DMA-owned descriptor right
away breaks before using the skb and saves the same stale pointer again,
so the stale pointer can survive across polls.

No privileges are needed to get a budget of 1. The EPIOCSPARAMS ioctl in
fs/eventpoll.c only requires CAP_NET_ADMIN when busy_poll_budget >
NAPI_POLL_WEIGHT, and stmmac_napi_poll_rx() passes the budget straight to
stmmac_rx(). A frame that spans several descriptors needs a jumbo MTU.

Suppose the interface is then closed (ndo_stop -> free_dma_desc_resources)
or the XSK pool or XDP program is changed. __free_dma_rx_desc_resources()
then calls dev_kfree_skb_any() on the stale pointer. Before this patch,
teardown dropped the stale pointer without freeing it.

The stale state in stmmac_rx() is older than this patch, and so is its
reuse on the next poll. This patch adds a new path that frees it a second
time. A later patch in the series copies the same pattern into
stmmac_reinit_dma_desc(), and stmmac_rx() is still unchanged at the end
of the series.

Could stmmac_rx() clear rx_q->state_saved and rx_q->state.skb as soon as
it takes the saved state?

[ ... ]

> @@ -2411,6 +2438,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
>  		return ret;
>  
>  	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
> +	if (ret)
> +		free_dma_rx_desc_resources(priv, dma_conf);
>  
>  	return ret;
>  }

[Severity: Low]
This one also predates the patch: stmmac_enable_rx_queue() and
stmmac_enable_tx_queue() do not unwind in the same way. When
__alloc_dma_rx_desc_resources() fails:

	ret = __alloc_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc RX desc.\n");
		return;
	}

Does this leak the page_pool, buf_pool and descriptor memory that were
already allocated? stmmac_enable_tx_queue() has the same early return,
which would leak tx_skbuff_dma, tx_skbuff and the TX descriptor memory.

"net: stmmac: use the tracked datapath restart for XSK pool changes",
later in the series, removes both helpers. After that, pool changes go
through stmmac_xdp_open() and alloc_dma_desc_resources().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282%40gmail.com
