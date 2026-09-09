Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DA59C976;
	Wed,  9 Sep 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988853; cv=none; b=uhyInRLwrRjgEbqbc5gvLHc3aEA81TyFXTXnmL9ciabMcsCZB6u3d7XYhiKiumf2c6ftAf4cUFIX0H31X8pO71m/RMA4o8/O4UL+2SFW8kEFRyiypgRqIkLY94yQEeDOElScQyAyhdNgjP2Nfr9rwiJB3C1Kgf1E3WoBBMxOceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988853; c=relaxed/simple;
	bh=ihE0nPOwRfHD+C0TiiMwDs4CA6HaCp7lf+a/NYoLEu8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KfM9tKbwVGxVqRlPQBht/84IVprkq+yGJ+IEocHrW3U8XBW3DuEBBAnBzTsIGn3ve2CFtPiOTDxqrytMyOtFlmZTFpchYd01bMM86K07MX3a/1rWjyvDIsair8gw2JKKnJDjKKAv3GI09+oWtq0jLMh/UtxSLMuUk0Pw1DH7N3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm4BpCy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm4BpCy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FE01F000FF;
	Wed,  9 Sep 2026 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788988850;
	bh=5Vc3g6j6CDkQxgEcrg6m76JXKsHztXiDPHa/BaB3UP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bm4BpCy8YBHIhnQ3mTt4Algz+xqN3KCyNJH6UgPNaUWqSTNoZs4GhbFwfAXawZxY1
	 BWigfusE1YnHd5bpufvpliVCuCanrHMFqC1oqk4ZICLzsDNg8SHzn86oHB3v5A82AB
	 6qB2XM2tOeIQmHvDsJuckzSbk0MKMCDk26KEX1hgZ3pBy2B46MpPbhrga+4dRF1r9W
	 XLmOLHfwQaIs+A1LX/OSUsAA5rsew4F7gZbKYYTw5v4X8VhVa5jt9ec6pTjncp6XS8
	 XQhfT+NirkFPJBTLuQyOrvK7CnC4/it4WCJ4Mcj1o5xr7Id9swotggtoE2Gw9Olx0z
	 764ymlZ7Fbsyw==
Subject: Re: [PATCH v13 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Wed, 09 Sep 2026 21:20:49 +0000
Message-ID: <178898884958.219967.9239766686182047063@kernel.org>
In-Reply-To: <20260904031553.3196916-1-rkannoth@marvell.com>
References: <20260904031553.3196916-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 6 · Low: 0

- [High] The new mqprio replace protocol depends on the core delivering
  TC_SETUP_ROOT_QDISC/TC_ROOT_GRAFT, but qdisc_offload_graft_root() ->…
- [Medium] otx2_setup_tc_mqprio()'s `cleanup:` rollback for a failed `tc
  qdisc replace` is silently discarded by the qdisc core.
- [Medium] A failed ndo_open() during the mqprio netdev bounce leaves the
  interface administratively DOWN: otx2_mqprio_restart_netdev() sets…
- [Medium] The advertised mqprio replacement rollback does not restore
  the priority-to-TC map.
- [Medium] Replacing between software mqprio and bandwidth-offloaded
  mqprio clears the newly installed traffic-class mapping in both…
- [Medium] otx2_mqprio_restore_old() aborts the rollback if
  otx2_nix_tm_clear_queue_shaper() fails, returning before…
- [Medium] otx2_mqprio_restore_old() calls otx2_mqprio_alloc_cache(pfvf,
  false), which unconditionally frees the *live* per-queue rate arrays…

--

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO offload with TC_MQPRIO_SHAPER_BW_RATE,
programming per-queue MDQ CIR/PIR through the NIX TX scheduler mailbox and
bouncing the netdev through ndo_stop()/ndo_open() to rebuild the scheduler
hierarchy.  Replace handling stages a new snapshot and rolls back to the
previous one on failure, using TC_ROOT_GRAFT to detect a successful graft.

A few questions below about the replace/rollback protocol and the netdev
bounce.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 175992188c18a..a519e0a97a2b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

[ ... ]

> @@ -779,6 +919,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
>  		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
>  	}
>  
> +	if (pfvf->mqprio.rate_limit)
> +		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
> +
>  	rc = otx2_sync_mbox_msg(&pfvf->mbox);
>  	if (rc)
>  		return rc;

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index eecee612b7b2c..ede7f1113b714 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -483,6 +484,23 @@ struct pf_irq_data {
>  	int mdevs;
>  };
>  
> +struct mq_offload_snap {
> +	u64 min_rate[TC_QOPT_MAX_QUEUE];
> +	u64 max_rate[TC_QOPT_MAX_QUEUE];
> +	__u8 num_tc;
> +	__u16 count[TC_QOPT_MAX_QUEUE];
> +	__u16 offset[TC_QOPT_MAX_QUEUE];
> +};

[Severity: Medium]
Should the snapshot also record the priority-to-TC map?  The snapshot keeps
num_tc, count[], offset[] and the rates, and otx2_mqprio_restore_old()
restores exactly those, but netdev->prio_tc_map is never saved or restored.

mqprio_init() installs the replacement map unconditionally once the driver
offload call has succeeded:

net/sched/sch_mqprio.c:mqprio_init() {
	/* Always use supplied priority mappings */
	for (i = 0; i < TC_BITMASK + 1; i++)
		netdev_set_prio_tc_map(dev, i, qopt->prio_tc_map[i]);
	...
	sch->flags |= TCQ_F_MQROOT;
}

If qdisc_create() then fails after init, for instance because TCA_RATE was
supplied, which is always rejected for a TCQ_F_MQROOT qdisc:

net/sched/sch_api.c:qdisc_create() {
	if (tca[TCA_RATE]) {
		err = -EOPNOTSUPP;
		if (sch->flags & TCQ_F_MQROOT) {
			NL_SET_ERR_MSG(extack, "Cannot attach rate estimator to a multi-queue root qdisc");
			goto err_out4;
	...
}

the old qdisc stays installed and the driver rolls the rates and the queue
layout back, but the device is left with the rejected configuration's
prio_tc_map.  Would packets then be classified into traffic classes that do
not match the queue ranges and rates that are actually in effect?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..abd66b366009a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -1600,14 +1609,714 @@ static int otx2_setup_tc_block(struct net_device *netdev,
> +static int otx2_mqprio_alloc_cache(struct otx2_nic *pfvf, bool replacing)
> +{
> +	u16 num_txq = pfvf->hw.non_qos_queues;
> +
> +	if (replacing && pfvf->mqprio.min_rate && pfvf->mqprio.max_rate) {
> +		memset(pfvf->mqprio.min_rate, 0,
> +		       num_txq * sizeof(*pfvf->mqprio.min_rate));
> +		memset(pfvf->mqprio.max_rate, 0,
> +		       num_txq * sizeof(*pfvf->mqprio.max_rate));
> +		pfvf->mqprio.flags = 0;
> +		return 0;
> +	}
> +
> +	otx2_mqprio_free_cache(pfvf);
> +
> +	pfvf->mqprio.min_rate = devm_kcalloc(pfvf->dev, num_txq,
> +					     sizeof(*pfvf->mqprio.min_rate),
> +					     GFP_KERNEL);
> +	pfvf->mqprio.max_rate = devm_kcalloc(pfvf->dev, num_txq,
> +					     sizeof(*pfvf->mqprio.max_rate),
> +					     GFP_KERNEL);
> +	if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate) {
> +		otx2_mqprio_free_cache(pfvf);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can this lose the live rate cache?  otx2_mqprio_restore_old() calls
otx2_mqprio_alloc_cache(pfvf, false), which frees the existing min_rate and
max_rate arrays before attempting the new devm_kcalloc().  If either
allocation fails, the only copy of the cached rates is already gone and
-ENOMEM is returned early, so:

  - pfvf->mqprio.rate_limit stays true (set earlier by
    otx2_mqprio_restart_netdev()), so the offload still counts as active and
    ethtool channel changes and XDP remain blocked,
  - otx2_mqprio_up() then always bails out:

	if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate)
		return 0;

    so the shapers can no longer be restored on any later ndo_open(),
  - pfvf->cur_mq_snap is left allocated because the trailing
    otx2_mqprio_snap_free() is skipped.

Since non_qos_queues cannot change while rate_limit is set, could the restore
path pass replacing=true and just memset the existing arrays instead of
freeing them first?

> +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> +{
> +	struct mq_offload_snap *snap = pfvf->old_mq_snap;
> +	struct net_device *netdev = pfvf->netdev;
> +	u16 num_txq = pfvf->hw.non_qos_queues;
> +	int tc, txq, err;
> +
> +	if (!snap)
> +		return 0;
> +
> +	err = otx2_mqprio_alloc_cache(pfvf, false);
> +	if (err)
> +		return err;

[ ... ]

> +	netdev_set_num_tc(netdev, snap->num_tc);
> +	for (tc = 0; tc < snap->num_tc; tc++)
> +		netdev_set_tc_queue(netdev, tc, snap->count[tc],
> +				    snap->offset[tc]);
> +

[Severity: Medium]
Does this TC layout restore survive the return to the qdisc core?  When the
replacement setup fails, otx2_setup_tc_mqprio() calls this from the cleanup:
label and then returns a non-zero error.  The failed instance never had
priv->hw_offload set, since mqprio_enable_offload() only assigns it after
ndo_setup_tc() succeeds, and destroy runs anyway:

net/sched/sch_api.c:qdisc_create() {
err_out4:
	/* Even if ops->init() failed, we call ops->destroy()
	 * like qdisc_create_dflt().
	 */
	if (ops->destroy)
		ops->destroy(sch);
}

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

So the still-installed old mqprio qdisc ends up with dev->num_tc == 0 while
pfvf->mqprio.rate_limit stays true and the restored per-queue shapers remain
programmed.  Would traffic then spread over all TX queues, some of which
still carry the restored limits?  The commit message says "failed setup
restores the old snapshot" - does that hold given the core clears num_tc
afterwards?

> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* otx2_mqprio_restart_netdev() clears rate_limit when ndo_open() fails.
> +	 * If open failed, TX schedulers were freed; defer shaper restore to the
> +	 * next successful ndo_open() via otx2_mqprio_up().
> +	 */
> +	pfvf->mqprio.rate_limit = true;
> +
> +	if (pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]) {
> +		err = otx2_mqprio_up(pfvf);
> +		if (err)
> +			return err;
> +	}
> +
> +	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
> +
> +	return 0;
> +}

[Severity: Medium]
What state is left behind if otx2_nix_tm_clear_queue_shaper() fails here?  It
issues a mailbox transaction through otx2_nix_tmq_reg_write() ->
otx2_sync_mbox_msg(), which can time out or be rejected by the AF.  On that
early return the software cache and the netdev TC mapping have already been
rewritten to the old configuration, but:

  - pfvf->mqprio.rate_limit = true is not reached,
  - otx2_mqprio_up() does not run, so the MDQ shapers keep the partially
    applied new rates,
  - pfvf->cur_mq_snap is not freed.

The caller only logs "mqprio: replace failed and prior configuration rollback
failed", so is there anything that re-synchronises hardware with the cached
rates before the next successful ndo_open()?

> +static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev = pfvf->netdev;
> +
> +	pfvf->mqprio.rate_limit = false;
> +	otx2_mqprio_clear_replace_state(pfvf);
> +	netdev_set_num_tc(netdev, 0);
> +	otx2_mqprio_free_cache(pfvf);
> +}

[Severity: Medium]
Can this unconditional netdev_set_num_tc(netdev, 0) wipe a mapping that the
replacement qdisc already installed?

Consider an active bandwidth offload followed by

  tc qdisc replace dev X root mqprio num_tc 2 map ... queues ... hw 0

The new qdisc has qopt->hw == 0, so the driver is never called during
mqprio_init(), which programs the mapping itself:

net/sched/sch_mqprio.c:mqprio_init() {
	} else {
		netdev_set_num_tc(dev, qopt->num_tc);
		for (i = 0; i < qopt->num_tc; i++)
			netdev_set_tc_queue(dev, i, qopt->count[i], qopt->offset[i]);
	}
}

replace_setup_done therefore stays false, and the old offloaded instance is
destroyed afterwards, reaching otx2_teardown_tc_mqprio() with had_mqprio ==
true, which calls otx2_mqprio_down() and otx2_mqprio_restart_netdev(netdev,
false) - both of which end in otx2_mqprio_clear_sw() and this
netdev_set_num_tc(netdev, 0).

The reverse direction, software mqprio replaced by an offloaded one, ends the
same way through mqprio_destroy()'s "else netdev_set_num_tc(dev, 0)" branch
after the driver has installed its mapping.

In both cases the tc command reports success while dev->num_tc ends up 0.  Is
that intended?

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> +{

[ ... ]

> +	err = ops->ndo_open(netdev);
> +	if (err) {
> +		netdev_err(netdev,
> +			   "Failed to restart device after mqprio change: %d\n",
> +			   err);
> +		/* ndo_open() already freed the TX schedulers on failure while
> +		 * netif_running() may still be true; drop mqprio software state
> +		 * only instead of sending shaper clears to freed queues.
> +		 */
> +		otx2_mqprio_clear_sw(pfvf);
> +		/* ndo_open() rolls back on failure; mark the interface down so
> +		 * netif_close() does not invoke ndo_stop() on freed NAPI/queue
> +		 * state. Caller holds RTNL; dev_close() would deadlock.
> +		 */
> +		pfvf->flags |= OTX2_FLAG_INTF_DOWN;
> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}
> +
> +	return err;
> +}

[Severity: Medium]
Should the commit message mention that a tc command can take the link down?
netif_close() here clears IFF_UP and __LINK_STATE_START, so the interface is
left administratively down and needs a manual "ip link set up".

ndo_open() failure is newly resource dependent, because otx2_txsch_alloc()
now asks for hw.non_qos_queues SMQs instead of one:

	if (pfvf->mqprio.rate_limit)
		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;

which the AF can reject when that many MDQ/SMQ nodes are not free, depending
on what other PFs and VFs have allocated.

On the teardown path this also happens with no error visible to user space,
since the return value is dropped:

net/sched/sch_mqprio.c:mqprio_disable_offload() is static void and does

	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);

so "tc qdisc del dev X root" reports success while the link is now down.  Is
that acceptable?

[ ... ]

> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	bool had_mqprio = pfvf->mqprio.rate_limit;
> +	struct net_device *netdev = pfvf->netdev;
> +	bool if_up = netif_running(netdev);
> +	int err;
> +
> +	qopt->hw = 0;
> +
> +	/* tc qdisc replace runs setup on the new mqprio before destroying the
> +	 * old one. replace_setup_done and TC_ROOT_GRAFT distinguish stale
> +	 * old-instance teardown from graft failure after setup.
> +	 */
> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		err = 0;
> +		if (pfvf->mqprio.replace_graft_done)
> +			otx2_mqprio_snap_commit(pfvf);
> +		else
> +			err = otx2_mqprio_restore_old(pfvf);
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		return err;
> +	}

[ ... ]

> +static int otx2_setup_tc_root(struct otx2_nic *pfvf,
> +			      struct tc_root_qopt_offload *root)
> +{
> +	switch (root->command) {
> +	case TC_ROOT_GRAFT:
> +		if (pfvf->mqprio.replace_setup_done)
> +			pfvf->mqprio.replace_graft_done = true;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

[Severity: High]
Is TC_ROOT_GRAFT guaranteed to be delivered to this driver?  The graft
notification is gated on tc_can_offload(), while the mqprio setup and
teardown calls are not:

net/sched/sch_api.c:qdisc_offload_graft_helper() {
	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
		return;
}

net/sched/sch_mqprio.c:mqprio_enable_offload()/mqprio_disable_offload() {
	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);
}

tc_can_offload() tests dev->features & NETIF_F_HW_TC, and in this driver that
bit is added to hw_features after features have already been copied:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c {
	netdev->features |= netdev->hw_features;

	/* HW supports tc offload but mutually exclusive with n-tuple filters */
	if (pf->flags & OTX2_FLAG_TC_FLOWER_SUPPORT)
		netdev->hw_features |= NETIF_F_HW_TC;
}

so hw-tc-offload is off in dev->features by default (and can be turned off
with ethtool at any time).  In that state the mqprio bandwidth offload is
still accepted, but replace_graft_done stays false, and the sequence

  tc qdisc add dev X root mqprio ... hw 1 shaper bw_rlimit
  tc qdisc replace dev X root mqprio ... hw 1 shaper bw_rlimit

reports success while the old instance's teardown takes the
!replace_graft_done branch above and calls otx2_mqprio_restore_old(),
re-applying the previous rates and TC layout.  Does the new configuration end
up silently discarded here?

Separately, otx2_setup_tc_root() ignores root->ingress and root->handle.
Would a clsact or ingress root graft be taken as confirmation of the egress
mqprio graft?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904031553.3196916-1-rkannoth%40marvell.com
