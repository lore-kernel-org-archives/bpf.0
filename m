Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B53B71A7;
	Sun, 27 Sep 2026 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483265; cv=none; b=skYakHgMI17KI9OVVjc69JetSmccaq0evUcWIPw9BjOV9NL0F2XU/SW2j5qKAawHY21ye7mF1OdmTD6Zp67kV7pGqCzWpqFPIPvI6eQoCmNI8kG+o1W/8wCyJgK7fog92U7f/GMcHXvXVl8ZyE4jNtXUd6yMH/eeTDGJmAvffbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483265; c=relaxed/simple;
	bh=mF+IVYQ25Jj0D5mkKnCFLeG21QF/iu0ZDUXBznkuQKE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHUL71OTb3YzLqa1tfgXNRoDBuNnQCAGeBmKx5kyOSBSL4FsatL7orIU+OnPQxRo/LhlO7S4PWUGw5oWJ0h4UXPVaFNZpZVXwWsqlY/eXGtMjDRL+SfxYZjznb7R76TXsj+7PypkAkTCImKSnzWoSXpHjtBbjRPs2JmqfUiBns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcJJWxso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcJJWxso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96731F000FF;
	Sun, 27 Sep 2026 04:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790483263;
	bh=Hbyz+0Xyi2kVahmo5rU2i5aoyITLPxscJrcGYaOHRWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fcJJWxsohS/Ul02QIZUf4FqoFi3IEXN/4d4nG0zHBYWomyx6a5Uhq0j1S3CbZJB9j
	 WnnvTMRrA8jbJ9a6IDvnADt824Iv/vwn58oW4gyPiZKPlr+M1ny4MH2o1S1Cgb+vt9
	 GRC40IZ5OmxUpNTkNzSC97JDruwt5dTvq45jMHCx4jnuPGQwPQgMRimyEQrimcMkzf
	 w1X7xujTxvTxXd/GQvUe3NCD30bWZ9tnbBEEAnugiNdPRctEf46Pe21swA+3O+CvOW
	 xcU+m6RU5tFLf7MigtfNkvCFvY7DPkcfeI6ew2QO8hGzwtmuQRuqCNduOvfGio5t4v
	 Lk096mfgjO96w==
Subject: Re: [PATCH v17 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Sun, 27 Sep 2026 04:27:41 +0000
Message-ID: <179048326167.2160803.14066345950790975084@kernel.org>
In-Reply-To: <20260923032217.1732753-3-rkannoth@marvell.com>
References: <20260923032217.1732753-3-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 (1) · Low: 2 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Committing an mqprio replace depends on a TC_ROOT_GRAFT
  notification that the qdisc core only sends when NETIF_F_HW_TC is in…
- [High] otx2_shutdown_tc() now runs before unregister_netdev() and
  without RTNL in otx2_remove() (otx2_pf.c:3646), otx2vf_remove()…
- [Medium] The patch turns on NETIF_F_HW_TC in netdev->features at probe,
  and the commit message does not say so.
- [Medium] If clearing the MDQ shapers fails during mqprio teardown, the
  driver keeps an active shaping configuration that no qdisc owns…
- [Medium] Rollback after a failed replace can leave the old, still-
  installed offloaded qdisc running without its configured limits.
- [Medium] Moving otx2_shutdown_tc() ahead of unregister_netdev() in
  otx2_remove() (otx2_pf.c:3646) and otx2vf_remove() (otx2_vf.c:845)…
- [Medium] otx2_mqprio_clear_sw() (called on every mqprio teardown and on
  restart failure) clears rate_limit and frees the rate caches, but…
- [Low] The comment in otx2_nix_tm_set_queue_shaper() says the mqprio
  netdev restart (otx2_mqprio_restart_netdev) 'resets MDQ shapers to…
- [Low] Two comments in otx2_mqprio_restart_netdev() say that a failed
  open is handled 'without calling ndo_stop() again', and that…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but mqprio
  offload setup now triggers it: an existing egress matchall hardware…
- [Low] This problem wasn't introduced by this patch, but the patch adds
  a new trigger for it.
- [Low] After a failed replace, the driver undoes mqprio_destroy()'s
  netdev_set_num_tc(dev, 0) through a system-workqueue item that takes…

--

octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload with TC_MQPRIO_SHAPER_BW_RATE
on octeontx2 PF and VF netdevs. It programs per-queue MDQ CIR/PIR through
the AF mailbox. The TX scheduler cannot be reprogrammed live, so every
mqprio add, replace and delete bounces the netdev through
ndo_stop()/ndo_open(). Replace is staged in mq_offload_snap snapshots that
are committed on TC_ROOT_GRAFT.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index b421cb75e44b5..8b922d719491f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

[ ... ]

> +int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf,
> +				 int txq, u64 minrate, u64 maxrate)
> +{

[ ... ]

> +	/* MQPRIO exposes only min/max rate, not burst.  Use the same 65536
> +	 * byte default as the HTB shaper path.
> +	 *
> +	 * mqprio setup restarts the netdev (otx2_mqprio_restart_netdev),
> +	 * which resets MDQ shapers to zero.  Program both PIR and CIR on
> +	 * every update so omitted rates are applied explicitly rather than
> +	 * relying on stale hardware state.
> +	 */

[Severity: Low]
Is this comment accurate? With rate_limit set, the ndo_open() inside
otx2_mqprio_restart_netdev() calls otx2_mqprio_up(). That writes the
cached previous CIR/PIR values back to every MDQ with a non-zero rate.

otx2_setup_tc_mqprio() says the opposite:

	/* otx2_mqprio_up() may have restored the previous configuration during
	 * the restart above. Clear every MDQ shaper before applying the new
	 * mapping ...

It also adds an explicit otx2_nix_tm_clear_queue_shaper() to compensate.
Could this comment be corrected, so that nobody later drops that clear
as redundant?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 32582b6347ea4..5f1d8287b00e4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2007,6 +2007,15 @@ int otx2_open(struct net_device *netdev)
>  	if (err)
>  		goto err_free_mem;
>  
> +	/* Fail closed: abort open if cached mqprio shapers cannot be restored. */
> +	err = otx2_mqprio_up(pf);
> +	if (err) {
> +		netdev_err(pf->netdev,
> +			   "mqprio: failed to restore shapers during open: %d\n",
> +			   err);
> +		goto err_free_hw;
> +	}

[Severity: Low]
This isn't a bug introduced by this patch, but this adds another way to
reach it. otx2_init_hw_resources() -> otx2_config_nix_queues() allocates
pf->refill_wrk:

	pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
					sizeof(struct refill_work), GFP_KERNEL);

Only otx2_stop() frees it:

	devm_kfree(pf->dev, pf->refill_wrk);

None of the otx2_open() error labels after otx2_init_hw_resources() free
it, and that includes the new err_free_hw. After a failed open,
OTX2_FLAG_INTF_DOWN makes the next otx2_stop() return early. The next
successful open then overwrites the pointer.

Does each otx2_mqprio_up() failure here leak one refill_wrk array until
the driver is unbound?

[ ... ]

> @@ -3344,8 +3361,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	netdev->features |= netdev->hw_features;
>  
>  	/* HW supports tc offload but mutually exclusive with n-tuple filters */
> -	if (otx2_test_flag(pf, OTX2_FLAG_TC_FLOWER_SUPPORT))
> +	if (otx2_test_flag(pf, OTX2_FLAG_TC_FLOWER_SUPPORT)) {
>  		netdev->hw_features |= NETIF_F_HW_TC;
> +		netdev->features |= NETIF_F_HW_TC;
> +	}

[Severity: Medium]
Is it intended to turn hw-tc-offload on by default? The commit message
doesn't mention it. otx2vf_probe() makes the same change for every VF.

On the PF, the earlier "netdev->features |= netdev->hw_features;" has
already put NETIF_F_NTUPLE into netdev->features. So after probe both
features are on, even though the comment directly above says they are
mutually exclusive.

tc_can_offload() is now true by default, so ordinary tc flower, matchall
and qdisc configs get pushed to ndo_setup_tc. On the PF, every flower
rule reaches otx2_setup_tc_block_ingress_cb() with ntuple set:

		if (ntuple) {
			netdev_warn(nic->netdev,
				    "Can't install TC flower offload rule when NTUPLE is active");
			return -EOPNOTSUPP;

Egress matchall policing is now offloaded by default as well. Should
this be a separate, documented change?

[ ... ]

> @@ -3622,6 +3643,7 @@ static void otx2_remove(struct pci_dev *pdev)
>  	otx2_cgx_config_linkevents(pf, false);
>  
>  	otx2_unregister_dl(pf);
> +	otx2_shutdown_tc(pf);
>  	unregister_netdev(netdev);

[Severity: Medium]
Does calling otx2_shutdown_tc() before unregister_netdev() skip the
per-flow cleanup for offloaded flower rules? otx2vf_remove() gets the
same reordering.

otx2_shutdown_tc() calls otx2_destroy_tc_flow_list(). That now frees
every otx2_tc_flow node while the filters are still bound:

	list_for_each_entry_safe(iter, tmp, &flow_cfg->flow_list_tc, list) {
		list_del(&iter->list);
		kfree(iter);
		flow_cfg->nr_flows--;
	}

unregister_netdev() then tears down the clsact block and sends
FLOW_CLS_DESTROY for each filter. otx2_tc_del_flow() no longer finds the
cookie:

	flow_node = otx2_tc_get_entry_by_cookie(flow_cfg, tc_flow_cmd->cookie);
	if (!flow_node) {
		netdev_err(nic->netdev, "tc flow not found for cookie 0x%lx\n",
			   tc_flow_cmd->cookie);
		return -EINVAL;
	}

As a result these steps are all skipped:

  - the nix_mcast_grp_destroy mailbox
  - the mark_flows refcount and OTX2_FLAG_TC_MARK_ENABLED handling
  - clearing rq_bmap
  - the policer unmap/free
  - the MCAM delete

Before this patch, otx2_shutdown_tc() ran after unregister_netdev(), so
the list was already empty by then.

The AF frees bandwidth profiles in rvu_nix_lf_teardown(). Mcast/mirror
group entries, though, seem to be freed only by
rvu_nix_mcast_flr_free_entries() on the FLR path. Can those AF entries
leak until an FLR happens?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index ddb46b580c3b6..453c598c6c5db 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> +static void otx2_mqprio_netdev_tc_work(struct work_struct *work)
> +{
> +	struct otx2_mqprio *mqprio = container_of(work, struct otx2_mqprio,
> +						  netdev_tc_work);
> +	struct otx2_nic *pfvf = container_of(mqprio, struct otx2_nic, mqprio);
> +
> +	rtnl_lock();
> +	if (pfvf->mqprio.rate_limit && pfvf->old_mq_snap)
> +		otx2_mqprio_apply_snap_netdev(pfvf->netdev, pfvf->old_mq_snap);
> +	rtnl_unlock();
> +}

[Severity: Low]
This is a pre-existing issue in the core, not one introduced by this
patch. Is there a window where the still-active offloaded mqprio
transmits with dev->num_tc == 0?

After a failed replace, mqprio_destroy() of the new instance calls
netdev_set_num_tc(dev, 0) once the driver callback has returned. Until
this work item gets RTNL, netdev_pick_tx()/skb_tx_hash() spread traffic
over all real TX queues. Packets can then bypass the per-queue MDQ
limits or land on limited queues.

The deferred work narrows that window but cannot close it.

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

[Severity: Medium]
Can rolling back a failed replace leave the old qdisc, which is still
installed, running without its limits?

When otx2_nix_tm_set_queue_shaper() fails in otx2_setup_tc_mqprio(), the
MDQs have already been cleared and some have been reprogrammed. The
cleanup path calls otx2_mqprio_restore_old(). That can return here, or
on the otx2_nix_tm_clear_queue_shaper() failure further down, before any
restart or shaper reprogramming. The caller only logs the failure:

		if (restore_err) {
			netdev_err(netdev,
				   "mqprio: replace failed and prior configuration rollback failed: %d\n",
				   restore_err);

No netdev TC restore is scheduled on that branch either.

The rollback restart can also fail. In that case
otx2_mqprio_restart_netdev() calls otx2_mqprio_clear_sw(), which sets
rate_limit = false and frees the caches, and then closes the netdev. On
the next "ip link set up", otx2_open() -> otx2_mqprio_up() returns 0
because rate_limit is false. The old offloaded qdisc then runs with no
hardware limits.

> +
> +	memset(pfvf->mqprio.min_rate, 0, num_txq * sizeof(*pfvf->mqprio.min_rate));
> +	memset(pfvf->mqprio.max_rate, 0, num_txq * sizeof(*pfvf->mqprio.max_rate));
> +	pfvf->mqprio.flags = snap->flags;
> +
> +	for (tc = 0; tc < snap->num_tc; tc++) {
> +		u64 min_rate = snap->min_rate[tc];
> +		u64 max_rate = snap->max_rate[tc];
> +
> +		for (txq = snap->offset[tc];
> +		     txq < snap->offset[tc] + snap->count[tc]; txq++) {
> +			pfvf->mqprio.min_rate[txq] = min_rate;
> +			pfvf->mqprio.max_rate[txq] = max_rate;
> +		}
> +	}

[Severity: Medium]
Can this write past the end of min_rate[] and max_rate[]?

The arrays are sized to hw.non_qos_queues, but snap->offset[] and
snap->count[] are never checked against that size.

old_mq_snap is released only by otx2_mqprio_snap_commit() or
otx2_shutdown_tc(). otx2_mqprio_clear_sw() clears rate_limit and frees
the caches, but it leaves old_mq_snap in place.

One possible sequence:

  1. With 8 queues, commit an 8-TC offload (old_mq_snap = S_A).
  2. tc qdisc del -> otx2_mqprio_clear_sw(); S_A is kept.
  3. ethtool -L tx 2, which is allowed now that rate_limit is false.
  4. A fresh mqprio add fails in otx2_mqprio_alloc_cache(). The
     teardown's otx2_mqprio_down() mailbox clear then also fails,
     leaving rate_limit = true.
  5. The next add is treated as a replace and fails in
     otx2_nix_tm_set_queue_shaper(). Cleanup then calls
     otx2_mqprio_restore_old(S_A), which allocates 2-entry arrays and
     writes indices 2..7.

The deferred netdev_tc_work would also apply the stale 8-TC layout.
Should old_mq_snap be dropped on teardown, or validated here?

[ ... ]

> +int otx2_mqprio_down(struct otx2_nic *pfvf)
> +{
> +	int err = 0;
> +
> +	if (!pfvf->mqprio.rate_limit)
> +		return 0;
> +
> +	if (netif_running(pfvf->netdev) &&
> +	    otx2_mqprio_mdq_allocated(pfvf))
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +
> +	if (err) {
> +		netdev_warn(pfvf->netdev,
> +			    "mqprio: failed to clear hardware shapers: %d; keeping offload state\n",
> +			    err);
> +		return err;
> +	}

[Severity: Medium]
What happens to the offload state when this clear fails during tc qdisc
del? mqprio_disable_offload() ignores the ndo_setup_tc() return value,
so the qdisc is removed anyway:

		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
					      &mqprio);

On this path otx2_mqprio_clear_sw() is skipped. otx2_teardown_tc_mqprio()
also returns before otx2_mqprio_restart_netdev(netdev, false). Some MDQ
batches may already have been cleared.

rate_limit, the min_rate/max_rate caches and the one-SMQ-per-queue
topology all stay in place:

  - every later otx2_open() asks otx2_txsch_alloc() for non_qos_queues
    SMQs
  - otx2_mqprio_up() re-applies the deleted rates
  - HTB, XDP attach, PFC enable and channel changes stay rejected, with
    no visible qdisc to explain why

The next "mqprio hw 1" add also sees replacing = true. It sets
replace_setup_done without ever committing, because the old root is mq
and no mqprio teardown follows. A later delete then takes the commit
branch in otx2_teardown_tc_mqprio() and returns 0 without clearing
shapers or restarting.

The first-add cleanup in otx2_setup_tc_mqprio() also ignores the return
value of otx2_teardown_tc_mqprio():

	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
	otx2_teardown_tc_mqprio(pfvf, mqprio);
	return err;

The kernel can't be told that the delete failed. Should the software
state be dropped here anyway?

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> +{

[ ... ]

> +	err = ops->ndo_open(netdev);
> +	if (!err && running) {
> +		set_bit(__LINK_STATE_START, &netdev->state);
> +	} else if (err) {
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
> +		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}

[Severity: Low]
This isn't a bug, but is this comment accurate? netif_close() ->
netif_close_many() -> __dev_close_many() does call ops->ndo_stop() when
IFF_UP is set. What makes this safe is that otx2_stop() returns early
when OTX2_FLAG_INTF_DOWN is set, and otx2vf_stop() just calls
otx2_stop().

The header comment of this function uses the same wording: "If open
fails, the interface is left administratively down without calling
ndo_stop() again on resources already torn down by the open error path."

[ ... ]

> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		err = 0;
> +		if (pfvf->mqprio.replace_graft_done)
> +			otx2_mqprio_snap_commit(pfvf);
> +		else
> +			err = otx2_mqprio_restore_old(pfvf);
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		return err;
> +	}

[Severity: High]
When hw-tc-offload is off, does this roll back a replace that actually
succeeded?

Only otx2_setup_tc_root(TC_ROOT_GRAFT) sets replace_graft_done. That
notification comes from qdisc_offload_graft_helper(), which returns
early in this case:

	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
		return;

mqprio_enable_offload() calls ndo_setup_tc without checking
tc_can_offload(). otx2_setup_tc_mqprio() doesn't check it either, so the
setup succeeds. The sequence then becomes:

tc qdisc replace ... mqprio hw 1 shaper bw_rlimit
  mqprio_init()
    otx2_setup_tc_mqprio()       replace_setup_done = true
  qdisc_graft()
    qdisc_offload_graft_root()   skipped, !tc_can_offload()
    notify_and_destroy(old)
      mqprio_destroy()
        otx2_teardown_tc_mqprio()
          otx2_mqprio_restore_old()

The kernel reports the new qdisc and rates. The hardware, however,
enforces the old rates and the netdev uses the old TC layout.

hw-tc-offload is off on any PF without OTX2_FLAG_TC_FLOWER_SUPPORT. An
admin can also run "ethtool -K dev hw-tc-offload off", which
otx2_handle_ntuple_tc_features() allows whenever there are no flower
rules, without checking for active mqprio.

[ ... ]

> +	err = otx2_mqprio_stage_cur(pfvf, mqprio);
> +	if (err)
> +		goto fail_validate;
> +
> +	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
> +	if (err)
> +		goto cleanup;

[Severity: Medium]
This is a pre-existing issue, but this restart makes it easier to hit.
Is an existing egress matchall rate limiter silently lost here?

otx2_set_matchall_egress_rate() programs NIX_AF_TL4X_PIR. The scheduler
free/alloc during the bounce runs the AF's nix_reset_tx_shaping(), which
disables TL4 shaping:

	case NIX_TXSCH_LVL_TL4:
		cir_reg = NIX_AF_TL4X_CIR(schq);
		pir_reg = NIX_AF_TL4X_PIR(schq);

otx2_open() reprograms only three things:

  - TL4 PARENT/SCHEDULE
  - the MDQ shapers, via otx2_mqprio_up()
  - ingress police rules, via otx2_tc_apply_ingress_police_rules()

OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED stays set, so software still
believes the rule is offloaded.

Any ndo_stop()/ndo_open() cycle already loses the rule. Now every mqprio
add, replace and delete bounces the netdev too. Should
otx2_setup_tc_mqprio() reject an active egress matchall, or replay it?

[ ... ]

>  void otx2_shutdown_tc(struct otx2_nic *nic)
>  {
> +	cancel_work_sync(&nic->mqprio.netdev_tc_work);
>  	otx2_destroy_tc_flow_list(nic);
> +	otx2_mqprio_snap_destroy(nic);
>  }

[Severity: High]
Is it safe to run this before unregister_netdev() and without RTNL? In
otx2_remove(), otx2vf_remove() and the probe err_unreg_netdev labels, the
netdev is still registered at this point. tc commands can still reach
ndo_setup_tc under RTNL.

Three parts of this function look racy.

First, the work can be re-queued after cancel_work_sync(). A concurrent
failed mqprio replace (fail_validate, or cleanup with replacing == true)
can call otx2_mqprio_defer_netdev_tc_restore() -> schedule_work() again.
Nothing cancels it afterwards. otx2_mqprio_netdev_tc_work() may then run
after free_netdev() and use container_of() to reach pfvf in freed
netdev_priv memory.

Second, otx2_destroy_tc_flow_list() list_del()s and kfree()s
flow_list_tc nodes. At the same time, otx2_tc_add_to_flow_list(),
otx2_tc_get_entry_by_cookie() and otx2_tc_del_flow() can be walking and
modifying the same list under RTNL. Nodes added after the destroy also
leak, together with their MCAM/policer resources.

Third, otx2_mqprio_snap_destroy() devm_kfree()s cur_mq_snap and
old_mq_snap while otx2_setup_tc_mqprio() may still be using them. One
example is pfvf->cur_mq_snap->num_tc after the netdev bounce.

Before this patch, otx2_shutdown_tc() ran after unregister_netdev(), when
no tc callback could reach the device. Could it stay there, with the
work cancelled after unregister_netdev()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923032217.1732753-1-rkannoth%40marvell.com
