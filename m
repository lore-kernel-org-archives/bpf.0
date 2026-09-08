Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72A494828;
	Tue,  8 Sep 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856463; cv=none; b=QjqRondDXwW2Ksb5PrafFoAqjnqdI9jHwexKylvIqBju2sGPU/L8UHJutgtQODGcOar6IvzMQ5hj35qthQPyweujgCkkjl5rWLkgFPv5V/eI4zJPzrFiqJpmcTYXIga+HqJpHCd0VsoLBAYHjFjx66Tpt2GAlGYQzdEwonVJivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856463; c=relaxed/simple;
	bh=Wa2kTZZwN0z/drsZcaEVzxsqDDwPqjBFMMQ3RBDlMCA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgCRDWrsthUXgbZdfkhxn/ZoE3S8G2SuwZaJ+JRGkaxja8pCRPlwbHuPBa03csh0m8u8sbBkwpuf0F0kao0FFhTUXslzYHCYT279+7fT+cz/fPDuZA6uvi8n61vSvi0pXunGu/udZNXQZ4CSnAKLBlUP7vHT0nyuwvdSxhKJrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+3J/Oun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+3J/Oun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9771F00A3F;
	Tue,  8 Sep 2026 08:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788856461;
	bh=N1wFBKZQAVF3Cdnl7Lvm0lYcAGhDbtfwLxbgeCUDzfY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e+3J/Oun433AYwU2cOCK3b47XOKL+UTgJvHwVv9DcwIfD/OL/L0Rm8DGgE5QtFTuP
	 F8PZlifA66UiEsNsMg3NaERNLth3q04YjinKN3ByMkqJEMmIUtgEjHIl17TVm7fNKv
	 kZXxivYxfIPeCmkN6ajxYlPVp6aafX8R50WaZwqwsx5ERQOYgDxyfoJdu9lr8zLU3z
	 b5kNH6kKXQCYmLVpkKoX4cGFhkN4lxJ6cDyyENBUG9oQhTQ27pcWEcNgDudfZ714+z
	 KkmuDZLHIhTLbbWeksGzq88pnMkdm8XuVUr+jbLCd8IuOLBmrHQl912xGQ6hqAJ8O/
	 f+7+5eV7PfeGg==
Subject: Re: [PATCH v12 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Tue, 08 Sep 2026 08:34:19 +0000
Message-ID: <178885645961.219967.4520397442844422130@kernel.org>
In-Reply-To: <20260903023324.3078284-1-rkannoth@marvell.com>
References: <20260903023324.3078284-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 5 · Low: 2

- [High] otx2_mqprio_restore_old() is reached from
  otx2_setup_tc_mqprio()'s `cleanup:` label after…
- [Medium] The mqprio 'replace' rollback scheme depends on receiving
  TC_SETUP_ROOT_QDISC/TC_ROOT_GRAFT, but the core suppresses that…
- [Medium] When an offloaded mqprio is replaced by a qdisc that programs
  the netdev TC layout itself without offload (e.g. `tc qdisc replace…
- [Medium] A failed mqprio offload does not merely get rejected:
  otx2_mqprio_restart_netdev() force-marks the interface down…
- [Medium] On a failed `tc qdisc replace`, otx2_mqprio_restore_old() re-
  installs the previous netdev TC layout with…
- [Medium] If otx2_mqprio_up() fails partway through its per-queue loop
  (mailbox/AF error on one NIX_AF_MDQX_PIR/CIR write), the MDQ shapers…
- [Low] otx2_mqprio_restore_old() calls otx2_mqprio_alloc_cache(pfvf,
  false), whose non-replacing path frees the existing min_rate/max_rate…
- [Low] The commit message says 'Add a ratelimited AF debug message when
  validating TX scheduler queue ownership', but the code adds…

--

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE, programming per-queue MDQ CIR/PIR through the
NIX TX scheduler mailbox and rebuilding the TX scheduler hierarchy by
bouncing the netdev through ndo_stop()/ndo_open() on mqprio add, replace
and delete.

A few questions about the new code below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad06..c9a4326d725d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -331,8 +331,12 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
>  			return true;
>  	}
>  
> -	if (map_func != pcifunc)
> +	if (map_func != pcifunc) {
> +		dev_err_ratelimited(rvu->dev,
> +				    "pcifunc %x map pcifunc %x not equal, lvl=%u schq=%u\n",
> +				    pcifunc, map_func, lvl, schq);
>  		return false;
> +	}
>  
>  	return true;
>  }

[Severity: Low]
The commit message says:

  "Add a ratelimited AF debug message when validating TX scheduler queue
   ownership to aid mqprio hierarchy setup failures."

but the code adds dev_err_ratelimited(), not a debug print.  Should this be
dev_dbg_ratelimited() instead?

is_valid_txschq() is a plain ownership predicate, and returning false is a
normal outcome when a VF sends a nix_txschq_config mailbox message naming a
scheduler queue it does not own.  Is it intended that a guest can make the
host AF emit error-level output?

Would it also make sense to split this AF logging change out of the NIC
feature patch?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 175992188c18..a519e0a97a2b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -615,6 +615,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)

[ ... ]

> +int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf,
> +				 int txq, u64 minrate, u64 maxrate)
> +{
> +	struct mbox *mbox = &pfvf->mbox;
> +	struct nix_txschq_config *req;
> +	int err, smq, n = 0;
> +	u64 reg_addr[2];
> +	u64 reg_val[2];
> +	u64 rate;
> +
> +	if (!maxrate && !minrate) {
> +		smq = otx2_get_smq_idx(pfvf, txq);

[ ... ]

> +	smq = otx2_get_smq_idx(pfvf, txq);

[ ... ]

> @@ -779,6 +919,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
>  		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
>  	}
>  
> +	if (pfvf->mqprio.rate_limit)
> +		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
> +

[Severity: Medium]
Is there a pre-check that the widened SMQ request can actually be satisfied
before the working configuration is torn down?

The AF rejects the whole allocation when the shared pool is short:

af/rvu_nix.c:nix_check_txschq_alloc_req() {
	if (free_cnt < req_schq || req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
	    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
		return NIX_AF_ERR_TLX_ALLOC_FAIL;
}

free_cnt comes from the pool shared with the other PF/VFs on the NIX block
(and is capped at 1 when hw->cap.nix_fixed_txschq_mapping is set), so an
N-SMQ request can fail where the previous single-SMQ open succeeded.

That failure propagates otx2_init_hw_resources() -> otx2_open() ->
otx2_mqprio_restart_netdev(), which then sets OTX2_FLAG_INTF_DOWN and calls
netif_close().  So a rejected mqprio offload can leave a previously working
interface administratively down, needing a manual "ip link set up".

The commit message describes only "bouncing the netdev through ndo_stop()
and ndo_open()" and "Reject offload unless the interface is running ...";
should it also state that a failed offload attempt can leave the link down?

>  	rc = otx2_sync_mbox_msg(&pfvf->mbox);
>  	if (rc)
>  		return rc;
> @@ -844,6 +987,7 @@ void otx2_txschq_stop(struct otx2_nic *pfvf)
>  
>  	/* Clear the txschq list */
>  	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
> +		pfvf->hw.txschq_cnt[lvl] = 0;
>  		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
>  			pfvf->hw.txschq_list[lvl][schq] = 0;
>  	}

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index c0e2100de1d9..db77c69a4942 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2007,6 +2007,12 @@ int otx2_open(struct net_device *netdev)
>  	if (err)
>  		goto err_free_mem;
>  
> +	err = otx2_mqprio_up(pf);
> +	if (err)
> +		netdev_err(pf->netdev,
> +			   "mqprio: failed to restore shapers during open: %d; continuing without bandwidth limits\n",
> +			   err);
> +

[Severity: Medium]
Is the "continuing without bandwidth limits" message accurate when
otx2_mqprio_up() fails partway through its loop?

otx2_mqprio_up() issues one otx2_nix_tm_set_queue_shaper() mailbox per txq
and returns on the first error:

		err = otx2_nix_tm_set_queue_shaper(pfvf, txq, min_rate,
						   max_rate);
		if (err) {
			netdev_err(netdev,
				   "mqprio: failed to restore shaper for txq %d: %d\n",
				   txq, err);
			return err;
		}

Each earlier iteration already committed NIX_AF_MDQX_PIR/CIR with the enable
bit set by otx2_get_txschq_rate_regval(), so txq 0..n-1 stay shaped while the
log says no limits are in effect, and mqprio.rate_limit stays true.

Should this path call otx2_nix_tm_clear_queue_shaper() (or otherwise unwind
the already written MDQ registers) before continuing?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf52..4090296edfc5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -1600,14 +1609,709 @@ static int otx2_setup_tc_block(struct net_device *netdev,

[ ... ]

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

[Severity: Low]
Can the rollback path lose the rate caches of the still-active offload here?

otx2_mqprio_restore_old() calls otx2_mqprio_alloc_cache(pfvf, false), which
takes the non-replacing path: otx2_mqprio_free_cache() runs first, and if
either devm_kcalloc() then fails both pointers are left NULL and -ENOMEM is
returned.

At that point mqprio.rate_limit is still set, so ethtool -L and XDP stay
blocked, but a later ndo_open() silently skips restoration because
otx2_mqprio_up() returns early:

	if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate)
		return 0;

Since the arrays are already the right size, could the restore path reuse
them the way the "replacing" branch does, or allocate the new ones before
releasing the old?

[ ... ]

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

[Severity: Medium]
Does the restored TC layout survive the error return to the qdisc layer?

On a failed replace the driver returns an error from
ndo_setup_tc(TC_SETUP_QDISC_MQPRIO), so sch_mqprio never records the
offload:

net/sched/sch_mqprio.c:mqprio_enable_offload() {
	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
					    &mqprio);
	if (err)
		return err;

	priv->hw_offload = mqprio.qopt.hw;
}

qdisc_create() then calls ops->destroy() for the failed instance, and with
hw_offload unset:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

so dev->num_tc goes to 0 right after the driver restored snap->num_tc, while
mqprio.rate_limit stays true and the old MDQ shapers remain programmed.  Is
that combination (hardware shaping N classes, dev->num_tc == 0, stale
tc_to_txq) intended?

> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* otx2_mqprio_restart_netdev() clears rate_limit when ndo_open() fails. */
> +	pfvf->mqprio.rate_limit = true;
> +
> +	err = otx2_mqprio_up(pfvf);
> +	if (err)
> +		return err;

[Severity: High]
Should the otx2_mqprio_mdq_allocated() guard cover otx2_mqprio_up() as well?

This function is reached from the cleanup: label of otx2_setup_tc_mqprio()
after otx2_mqprio_restart_netdev() failed, i.e. after ndo_open() failed and
otx2_free_hw_resources() -> otx2_txschq_stop() ran.  That path now also
zeroes the counters this patch added:

	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
		pfvf->hw.txschq_cnt[lvl] = 0;
		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
			pfvf->hw.txschq_list[lvl][schq] = 0;
	}

otx2_mqprio_mdq_allocated() correctly returns false there, so the shaper
clear is skipped, but rate_limit is forced true and otx2_mqprio_up() is
called anyway.  otx2_mqprio_up() has no netif_running()/MDQ-allocated
precondition, unlike otx2_mqprio_down():

	if (netif_running(pfvf->netdev) &&
	    otx2_mqprio_mdq_allocated(pfvf))
		err = otx2_nix_tm_clear_queue_shaper(pfvf);

For the first txq with a cached non-zero rate this reaches
otx2_nix_tm_set_queue_shaper() -> otx2_get_smq_idx():

	idx = qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ];
	smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][idx];

Can this divide by zero?  And where the division does not trap, idx becomes
qidx into the zeroed list, so smq == 0 and the driver writes
NIX_AF_MDQX_PIR(0)/CIR(0) for a node this PF_FUNC does not own — the exact
case the new AF dev_err_ratelimited() in is_valid_txschq() reports.

That makes the rollback fail deterministically, leaving rate_limit true,
cur_mq_snap unfreed and the interface down.  ndo_open() failure is
reachable: the widened SMQ request can hit NIX_AF_ERR_TLX_ALLOC_FAIL, and
otx2_open() can also fail in otx2_hw_set_mtu(), otx2_rss_init() or
request_irq().

> +	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
> +
> +	return 0;
> +}

[ ... ]

> +static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev = pfvf->netdev;
> +
> +	pfvf->mqprio.rate_limit = false;
> +	otx2_mqprio_clear_replace_state(pfvf);
> +	netdev_set_num_tc(netdev, 0);
> +	otx2_mqprio_free_cache(pfvf);
> +}

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
> +
> +	/* Skip the netdev restart when mqprio offload was not active. */
> +	if (!had_mqprio)
> +		return 0;
> +
> +	if (if_up) {
> +		int down_err, err;
> +
> +		down_err = otx2_mqprio_down(pfvf);
> +		err = otx2_mqprio_restart_netdev(netdev, false);
> +		if (err)
> +			return err;
> +		return down_err;
> +	}

[Severity: Medium]
What happens when an offloaded mqprio is replaced by a qdisc that is not
offloaded, for example:

  tc qdisc replace dev eth0 root mqprio num_tc 4 ... hw 0

The new instance programs the netdev TC layout itself in mqprio_init() (with
qopt->hw == 0 it calls netdev_set_num_tc()/netdev_set_tc_queue() directly),
and it never reaches otx2_setup_tc_mqprio(), so replace_setup_done stays
false.

qdisc_graft() installs the new qdisc first and only then destroys the old
one:

net/sched/sch_api.c:qdisc_graft() {
		qdisc_offload_graft_root(dev, new, old, extack);
	...
			notify_and_destroy(net, skb, n, classid, old, new, extack);
}

So the old instance's mqprio_destroy() -> mqprio_disable_offload() reaches
otx2_teardown_tc_mqprio() with replace_setup_done false and had_mqprio true,
taking the branch above: otx2_mqprio_down() -> otx2_mqprio_clear_sw() runs
netdev_set_num_tc(netdev, 0), wiping the mapping the new qdisc just
installed, and otx2_mqprio_restart_netdev(netdev, false) bounces the link.

Does the live software mqprio then keep selecting TX queues correctly with
dev->num_tc == 0?  Is the unrequested stop/open bounce expected in this
case?

[ ... ]

> +	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
> +	if (err)
> +		goto cleanup;

[ ... ]

> +cleanup:
> +	qopt->hw = 0;
> +	if (replacing) {
> +		int restore_err = otx2_mqprio_restore_old(pfvf);

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

[Severity: Medium]
Is TC_ROOT_GRAFT guaranteed to be delivered whenever the mqprio setup call
was?

mqprio_enable_offload() invokes ndo_setup_tc(TC_SETUP_QDISC_MQPRIO)
unconditionally, but the graft notification is gated on the offload feature
bit:

net/sched/sch_api.c:qdisc_offload_graft_helper() {
	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
		return;
}

With "ethtool -K eth0 hw-tc-offload off" (NETIF_F_HW_TC is in hw_features
for both PF and VF here), a successful

  tc qdisc replace dev eth0 root mqprio ... hw 1

sets replace_setup_done but never replace_graft_done, so the subsequent
teardown of the replaced instance takes the rollback branch in
otx2_teardown_tc_mqprio():

		if (pfvf->mqprio.replace_graft_done)
			otx2_mqprio_snap_commit(pfvf);
		else
			err = otx2_mqprio_restore_old(pfvf);

Does that leave hardware shapers and the netdev TC layout on the previous
configuration while tc reports the new one?

The commit message states the "successful graft is recorded through
TC_ROOT_GRAFT" without mentioning the feature-flag dependency; should that
be noted, or the setup path gated the same way?

>  int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  		  void *type_data)
>  {
>  	switch (type) {
> +	case TC_QUERY_CAPS:
> +		return otx2_setup_tc_query_caps(type_data);
>  	case TC_SETUP_BLOCK:
>  		return otx2_setup_tc_block(netdev, type_data);
>  	case TC_SETUP_QDISC_HTB:
>  		return otx2_setup_tc_htb(netdev, type_data);
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return otx2_setup_tc_mqprio(netdev, type_data);
> +	case TC_SETUP_ROOT_QDISC:
> +		return otx2_setup_tc_root(netdev_priv(netdev), type_data);
>  	default:
>  		return -EOPNOTSUPP;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903023324.3078284-1-rkannoth%40marvell.com
