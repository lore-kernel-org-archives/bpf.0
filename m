Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624123;
	b=LPb49Q+wqwf2jocgCRxbjHdtiYspj7yEW1FFXOQ9PuB43MFMpw4HlU25nXuHJYuTi7x0
	 1yjchNhqiasmrCZ1gloMxKGGPdVuUPZ24SwThFi1r/SIJSnEb2+xpjiuz9Ev820SVIwbI
	 M8BMKf6nAgBGSR+Cp9rKNX/IcHGnWD737F7R4cHknztB36D7mt4iBG/KvTnY4l5VeOp0u
	 doJga96MJjUgpls6frnCz6ppWXq+VdOP76iS/dPD/pKuUss4mtfVy7M/MlPlh05NGQzfi
	 HLCPIHoSkfBBmVWR/S+8rzeCFt85UT7gVx0f/sx6EbX7D9OZ+mjxiRfuiUOm8ovwzeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624123;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wAC+JdlNSh6ZSzeM4G6YrlNMLlUw7L1HmDhHG3TaP6A=;
	b=GFfY1Ht/4H1BUOcW7rBbhthU4B/f73MFOq9JbJA0NWmBvYuUHMrzDrxGYwrnKZtXveVy
	 AFaCn3ucYVBdIh7pv7dbFoHUQedIeB0HuRjQOjzouLsT/fYlK4CoEPCe/vTDjcDEYtFO2
	 kKTXY1B9vxiHzAS0wJ2Uw9SR/8usi1Oks5xPqGE4Hh/JY9QaCGWmvAbPdY3ZNccsbkn4X
	 Rp1a4vkU2HUPYa0CA0c2G5gbqeMB6uq17ZgnVGNwLiDz7SjdrvDCuFB2Zrc3mzK2BKA+8
	 PgKwZL+eewOOC/ethrV5NCYdy+ZULb4w1P+1P0G/E4g6s8SNcoByftJwPfm5DuJDG7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mu/Q+Gy+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC235606A330;
	Sat, 14 Nov 2026 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mu/Q+Gy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30BE1F000C4;
	Sat, 14 Nov 2026 02:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794624123;
	bh=wAC+JdlNSh6ZSzeM4G6YrlNMLlUw7L1HmDhHG3TaP6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mu/Q+Gy+KUxU7r2a0mdyC0L6ZKirxmajY0ZhtMxXdzcz9jcKBEYfrG2yOK0+2IzSr
	 a38P9tXzyF+mBryWgUMudnMjSfF9DC548DQCzmZY+dOsWUKOXz/WIESpb/pDqdn25H
	 a+FqTEA/wWtKU55L2Gwy9+7qQWyeqgAhq76iOX2vQLjjfM+pdMySoBwCCFOt5Dr//f
	 X7HMpaEQU6IEtw0azdyqutAZiZF+t1EoVjZMCC01xkchVh0mutsOnw3hjBI4Q0nQcW
	 EpWVodcgQ+Bxt4qXraRX4vld6duQL7bwYde94bj+ei3GgoEdOMefUy79kAmK5b9n22
	 1lTe/Sm2m7K2g==
Date: Fri, 13 Nov 2026 18:42:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <pabeni@redhat.com>,
 <sdf@fomichev.me>, <sgoutham@marvell.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v21 net-next 2/2] octeontx2: add mqprio bandwidth
 offload for NIX TX schedulers
Message-ID: <20261113184202.678ed2f7@kernel.org>
In-Reply-To: <20261109033154.2161803-3-rkannoth@marvell.com>
References: <20261109033154.2161803-1-rkannoth@marvell.com>
	<20261109033154.2161803-3-rkannoth@marvell.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 09:01:53 +0530 Ratheesh Kannoth wrote:
> Add TC_SETUP_QDISC_MQPRIO offload with TC_MQPRIO_SHAPER_BW_RATE on PF and
> VF netdevs. Program per-queue MDQ CIR/PIR via the NIX TX scheduler mailbox;
> when active, allocate one SMQ per non-QoS queue under TL4[0].
> 
> The TX scheduler cannot be reprogrammed live, so add/replace/delete and
> failed setup bounce the netdev through ndo_stop()/ndo_open(). Cache rates
> in software and restore them from otx2_mqprio_up() on open, failing closed
> on error.
> 
> Stage tc replace in mq_offload_snap snapshots committed on TC_ROOT_GRAFT or
> replaced-qdisc teardown.
> 
> Require a running interface with CIR+PIR support. Reject offload with PFC,
> XDP, HTB, SDP representors, per-TC rates on multi-queue classes, and
> ethtool channel changes while active.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../marvell/octeontx2/nic/otx2_common.c       | 143 ++-
>  .../marvell/octeontx2/nic/otx2_common.h       |  34 +
>  .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
>  .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  34 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 936 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  28 +-
>  .../net/ethernet/marvell/octeontx2/nic/qos.c  |  11 +
>  8 files changed, 1179 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index f4047b0d5d96..b4a738cf9a8b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -615,6 +615,139 @@ void otx2_get_mac_from_af(struct net_device *netdev)
>  }
>  EXPORT_SYMBOL(otx2_get_mac_from_af);
>  
> +static int
> +otx2_nix_tmq_reg_write(struct otx2_nic *pfvf, int cnt,
> +		       u64 reg_addr[MAX_REGS_PER_MBOX_MSG],
> +		       u64 reg_val[MAX_REGS_PER_MBOX_MSG])
> +{
> +	struct mbox *mbox = &pfvf->mbox;
> +	struct nix_txschq_config *req;
> +	int i, err;
> +
> +	mutex_lock(&mbox->lock);
> +	req = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
> +	if (!req) {
> +		mutex_unlock(&mbox->lock);
> +		return -ENOMEM;
> +	}
> +
> +	req->lvl = NIX_TXSCH_LVL_MDQ;
> +	req->num_regs = cnt;
> +
> +	for (i = 0; i < cnt; i++) {
> +		req->reg[i] = reg_addr[i];
> +		req->regval[i] = reg_val[i];
> +	}
> +
> +	err = otx2_sync_mbox_msg(mbox);
> +	mutex_unlock(&mbox->lock);
> +
> +	return err;
> +}
> +
> +int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf)
> +{
> +	u64 reg_addr[MAX_REGS_PER_MBOX_MSG];
> +	u64 reg_val[MAX_REGS_PER_MBOX_MSG];
> +	int err, smq, i, cnt = 0;
> +
> +	for (i = 0; i < pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]; i++) {
> +		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][i];
> +
> +		reg_addr[cnt] = NIX_AF_MDQX_PIR(smq);
> +		reg_val[cnt] = 0;
> +		cnt++;
> +
> +		reg_addr[cnt] = NIX_AF_MDQX_CIR(smq);
> +		reg_val[cnt] = 0;
> +		cnt++;
> +
> +		if (cnt < MAX_REGS_PER_MBOX_MSG - 1)
> +			continue;
> +
> +		err = otx2_nix_tmq_reg_write(pfvf, cnt,
> +					     reg_addr, reg_val);
> +		if (err)
> +			goto fail;
> +		cnt = 0;
> +	}
> +
> +	if (cnt) {
> +		err = otx2_nix_tmq_reg_write(pfvf, cnt,
> +					     reg_addr, reg_val);
> +		if (err)
> +			goto fail;
> +	}
> +
> +	return 0;
> +fail:
> +	return err;

just return err; why the label ?


> +struct mq_offload_snap {
> +	u64 min_rate[TC_QOPT_MAX_QUEUE];
> +	u64 max_rate[TC_QOPT_MAX_QUEUE];
> +	u32 flags;
> +	__u8 num_tc;
> +	__u16 count[TC_QOPT_MAX_QUEUE];
> +	__u16 offset[TC_QOPT_MAX_QUEUE];
> +	__u8 prio_tc_map[TC_QOPT_BITMASK + 1];

Why is this using __u types?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 4fe473d9ea0d..5428b3d1b332 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -287,6 +287,14 @@ static int otx2_set_channels(struct net_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (pfvf->mqprio.rate_limit &&
> +	    (channel->tx_count != pfvf->hw.tx_queues ||
> +	     channel->rx_count != pfvf->hw.rx_queues)) {
> +		netdev_info(dev,
> +			    "Not permitted to change channel count while MQ prio is active\n");

Why? This seems quite limiting.
User has to remove the root qdisc to change the queue count?

> +		return -EINVAL;
> +	}
> +
>  	if (if_up)
>  		dev->netdev_ops->ndo_stop(dev);

> +	if (prog && pf->mqprio.rate_limit) {
> +		netdev_err(dev,
> +			   "XDP: cannot attach while mqprio bandwidth offload is active\n");

Again - why?

> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (prog && dev->mtu > MAX_XDP_MTU) {
>  		netdev_warn(dev, "Jumbo frames not yet supported with XDP\n");
>  		return -EOPNOTSUPP;

> +static void otx2_mqprio_free_cache(struct otx2_nic *pfvf)
> +{
> +	devm_kfree(pfvf->dev, pfvf->mqprio.min_rate);
> +	devm_kfree(pfvf->dev, pfvf->mqprio.max_rate);

devm_kfree() is a red flag, either this is something tied to the
lifetime of the driver, or you need to clean this up. Saying that
something "doesn't leak because it was devm_kmalloc()ed" is invalid.
Drivers don't get re-probed in real life, memory parked in devm_ is 
as bad as leaked.

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> +{
> +	struct otx2_nic *pfvf = netdev_priv(netdev);
> +	const struct net_device_ops *ops = netdev->netdev_ops;
> +	bool running = netif_running(netdev);
> +	int err;
> +
> +	/* TODO: Explore live TX scheduler reprogramming to avoid a full
> +	 * ndo_stop()/ndo_open() bounce on every mqprio change.
> +	 */
> +	netdev_dbg(netdev,
> +		   "mqprio: restarting interface to reprogram TX scheduler\n");
> +
> +	if (running) {
> +		clear_bit(__LINK_STATE_START, &netdev->state);

Messing with internal netdev state like this from the driver is
obviously unacceptable.

> +		smp_mb__after_atomic(); /* Commit netif_running(). */
> +	}

> +	/* TODO: per-TC TL4 shapers or equal per-queue MDQ split for multi-queue TC rates. */
> +	netdev_err(netdev,
> +		   "mqprio: %s rate for tc %d not supported with %u queues\n",
> +		   name, tc, qcount);
> +	NL_SET_ERR_MSG_FMT_MOD(extack,
> +			       "mqprio: tc %d rate needs 1 queue (has %u)",
> +			       tc, qcount);

Doubling out output to extack and dmesg is not okay, user space should
look at the extack. And a decade after it was added it mostly does.

You are at v21 this is nowhere near the acceptable quality. You should
probably give up.
