Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281593;
	b=KiSsLWTrRJivoMv9Sj4X/tVsjyvagbhU4qvpgpUbxO5HFhoJrqtVVPQJ32w36YJd2lH2
	 BtjNjp/50OHviPXWQkhg2aNZPQ5DhiVx7UDV28b6xIfvcGVPo0B5uucxE3pZ9oOKV6vq9
	 O3Lqewz+uqWTXNpVs3JA4d/MDotTKyuDAKZb4DenRPCUnNHEmz46iUxRdXZyid2PGlmjD
	 GL/zLGC7eoPzC+EzZ4pqOrPjYU4ZbY+6AhtzldcF4KDEMxVAQjuButzZKGYKDBgXiTTG3
	 HOA3n0r1hvMsIOgAnd1wJTsjN5RF9BR99Ba3uQFo4LSbDnmgUUVWXqeb5qZI1Uh85jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ivTCwqZfAs63WKu5s6FUXBvc87AJUzL5nXIDEGMzr0k=;
	b=I+FZe+tHj9xrCxZyAy5Kvi2mNbrGM4InTPlBwCCXPCaPxMG8TOoj4g2a+lBV5YgHz3wl
	 Rys9spEMNr66o3emNfmE70m4pgYgdh6ebVAD0+lRMD+11gX8c8ODSTmpd7yYlOFSAnn72
	 aTgf8ZartyZp8J0oUqVko6gOIE/C13YkxCirEZ7KEPD12tOFQksiXW6yAoudSu36UPTlk
	 bHNelwaao44vUQ7NeeWjN48/TIlLs+dd3KPvhBH8Ix+XZ/umlhDXczkO7KPR3vRzz4ZzB
	 4taK6VgB8oMhEWSmCVwrDNePiAdzZodp/1a3G7+ECE6sZTw4q5pw60LWHsPDiHv79tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOTeAssB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1C606A331
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOTeAssB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABD61F008A2;
	Tue, 10 Nov 2026 03:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281592;
	bh=ivTCwqZfAs63WKu5s6FUXBvc87AJUzL5nXIDEGMzr0k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EOTeAssBgthhQJR+wRT0KDfdWppM6i4OwmJWc+2iExvSKUG6/zYkwPczZ+v0eHoT1
	 WcgHLbIQbAeTzSD+42oMMu/mxsF/EDsOMcHhK6NBaQKMkI6nX079p7M4xvoR4ExsjM
	 wV4Lh6GMZ/hgVDQNCM8KHQcjACGb22/AznfdqCbLpr/kCvpnd5gdrsuU0GTxCDhova
	 4yt3zIaH9N04sYiUk3kjmGQbYTykrFXrb40xFq6eepPDfZHviiENkE1UQJ9vKQXO+L
	 cDveKyWBg11q3a75wHAjneTwXL0KthEKUnfGySkNQEbrt48G04Ws3TY/OlHgaUra4p
	 bXCPxENhtxVkg==
Message-ID: <sashiko-outbox-206123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 net-next 2/2] octeontx2: add mqprio bandwidth
 offload for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, bpf@vger.kernel.org
In-Reply-To: <20261109033154.2161803-3-rkannoth@marvell.com>
References: <20261109033154.2161803-1-rkannoth@marvell.com>
 <20261109033154.2161803-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:33:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Medium] octeontx2: otx2_teardown_tc_mqprio() commits aborted replace
  without graft
- [Medium] octeontx2: skipped netdev restart on shaper clear error in
  otx2_teardown_tc_mqprio()
- [Medium] octeontx2-pf: premature otx2_mcam_flow_del() in otx2_probe()
  error path
- [Medium] octeontx2: otx2_mqprio_clear_sw() wipes netdev TC layout on
  taprio replace
- [Medium] octeontx2: incomplete rollback and state loss in
  otx2_mqprio_restore_old()
- [Medium] octeontx2: broken mqprio replace rollback in
  otx2_mqprio_restart_netdev()
- [Medium] octeontx2: lost netdev TC state on rejected replace in
  otx2_setup_tc_mqprio()
--

commit 9864a43cee348b7e8d668cd98a7aae2752988212
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO bandwidth offload support for PF
and VF netdevs by reprogramming NIX TX scheduler MDQ CIR/PIR registers
and bouncing the netdev to allocate one SMQ per non-QoS queue.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 777e7156badb7..f51161e8b5949 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -3420,11 +3437,13 @@ static int otx2_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  	otx2_sriov_vfcfg_cleanup(pf);
>  err_pf_sriov_init:
>  	otx2_unregister_dl(pf);
> -	otx2_shutdown_tc(pf);
>  err_mcam_flow_del:
>  	otx2_mcam_flow_del(pf);
>  err_unreg_netdev:
> +	otx2_shutdown_tc_mqprio(pf);
>  	unregister_netdev(netdev);
> +err_shutdown_tc:
> +	otx2_shutdown_tc(pf);
>  err_ipsec_clean:
>  	cn10k_ipsec_clean(pf);
>  err_mcs_free:

[Severity: Medium]
Does moving otx2_shutdown_tc(pf) below err_mcam_flow_del cause
otx2_destroy_tc_flow_list() to skip freeing flow_cfg->flow_list_tc
entries when probe fails after register_netdev()?

otx2_mcam_flow_del() calls otx2_destroy_mcam_flows(), which frees the
MCAM entries while the netdev is still registered and clears
OTX2_FLAG_MCAM_ENTRIES_ALLOC.  When otx2_shutdown_tc() then calls
otx2_destroy_tc_flow_list(), it sees OTX2_FLAG_MCAM_ENTRIES_ALLOC clear
and returns early without freeing any otx2_tc_flow nodes added while the
netdev was registered:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:otx2_destroy_tc_flow_l=
ist() {
    ...
	if (!otx2_test_flag(pfvf, OTX2_FLAG_MCAM_ENTRIES_ALLOC))
		return;

	list_for_each_entry_safe(iter, tmp, &flow_cfg->flow_list_tc, list) {
		list_del(&iter->list);
		kfree(iter);
		flow_cfg->nr_flows--;
	}
}

err_del_mcam_entries below err_mcs_free already calls
otx2_mcam_flow_del(pf), so err_mcam_flow_del can be dropped.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 8877af348a090..b34a86259e786 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> +{
> +	struct mq_offload_snap *snap =3D pfvf->old_mq_snap;
> +	struct net_device *netdev =3D pfvf->netdev;
> +	u16 num_txq =3D pfvf->hw.non_qos_queues;
> +	int tc, txq, err;
> +
> +	if (!snap)
> +		return 0;
> +
> +	err =3D otx2_mqprio_alloc_cache(pfvf, false);
> +	if (err) {
> +		netdev_err(netdev,
> +			   "mqprio: rollback failed to allocate rate cache: %d\n",
> +			   err);
> +		return err;
> +	}
> +
> +	memset(pfvf->mqprio.min_rate, 0, num_txq * sizeof(*pfvf->mqprio.min_rat=
e));
> +	memset(pfvf->mqprio.max_rate, 0, num_txq * sizeof(*pfvf->mqprio.max_rat=
e));
> +	pfvf->mqprio.flags =3D snap->flags;
> +
> +	for (tc =3D 0; tc < snap->num_tc; tc++) {
> +		u64 min_rate =3D snap->min_rate[tc];
> +		u64 max_rate =3D snap->max_rate[tc];
> +
> +		for (txq =3D snap->offset[tc];
> +		     txq < snap->offset[tc] + snap->count[tc]; txq++) {
> +			pfvf->mqprio.min_rate[txq] =3D min_rate;
> +			pfvf->mqprio.max_rate[txq] =3D max_rate;
> +		}
> +	}
> +
> +	otx2_mqprio_apply_snap_netdev(netdev, snap);
> +
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err =3D otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "mqprio: rollback shaper clear failed: %d; hardware limits may no=
t match qdisc\n",
> +				   err);
> +			return err;
> +		}
> +	}
> +
> +	/* Rebuild the TX scheduler via netdev restart when running; otx2_mqpri=
o_up()
> +	 * alone is insufficient after a failed replace that already bounced the
> +	 * interface. If open failed, TX schedulers were freed; defer shaper re=
store
> +	 * to the next successful ndo_open() via otx2_mqprio_up().
> +	 */
> +	pfvf->mqprio.rate_limit =3D true;
> +
> +	if (netif_running(netdev)) {
> +		err =3D otx2_mqprio_restart_netdev(netdev, true);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "mqprio: rollback netdev restart failed: %d; qdisc rates may not =
be enforced\n",
> +				   err);
> +			return err;
> +		}
> +	} else if (pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]) {
> +		err =3D otx2_mqprio_up(pfvf);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "mqprio: rollback shaper restore failed: %d; qdisc rates may not =
be enforced\n",
> +				   err);
> +			return err;
> +		}
> +	}
> +
> +	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
> +
> +	return 0;
> +}

[Severity: Medium]
Can an error in otx2_mqprio_restore_old() discard the restored rate
cache and leave the surviving mqprio qdisc out of sync with hardware?

If otx2_mqprio_restart_netdev(netdev, true) fails in ops->ndo_open(), it
calls otx2_mqprio_clear_sw(pfvf), which sets pfvf->mqprio.rate_limit to
false and frees pfvf->mqprio.min_rate and max_rate.  Contrary to the
comment above, the next ndo_open() will then see rate_limit =3D=3D false,
allocate only a single SMQ in otx2_txsch_alloc(), and return early in
otx2_mqprio_up(), leaving traffic unshaped while the old offloaded
mqprio qdisc remains attached.

Passing replacing =3D false to otx2_mqprio_alloc_cache() also forces new
allocations instead of reusing the existing arrays, and any early return
from otx2_mqprio_restore_old() skips freeing pfvf->cur_mq_snap and
causes the cleanup path in otx2_setup_tc_mqprio() to skip
otx2_mqprio_defer_netdev_tc_restore(pfvf), so mqprio_destroy() on the
rejected new qdisc resets netdev->num_tc to 0.

> +
> +static void otx2_mqprio_snap_destroy(struct otx2_nic *pfvf)
> +{
> +	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
> +	otx2_mqprio_snap_free(pfvf, &pfvf->old_mq_snap);
> +}
> +
> +/* Offloaded mqprio replaced by software mqprio installs netdev TC layou=
t in
> + * mqprio_init() before the old offload instance is destroyed during gra=
ft.
> + */
> +static bool otx2_mqprio_keep_netdev_tc(struct otx2_nic *pfvf)
> +{
> +	struct Qdisc *qdisc =3D rtnl_dereference(pfvf->netdev->qdisc);
> +
> +	return qdisc && qdisc->ops && !strcmp(qdisc->ops->id, "mqprio");
> +}
> +
> +static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev =3D pfvf->netdev;
> +
> +	pfvf->mqprio.rate_limit =3D false;
> +	otx2_mqprio_clear_replace_state(pfvf);
> +	if (!otx2_mqprio_keep_netdev_tc(pfvf)) {
> +		struct Qdisc *root =3D rtnl_dereference(netdev->qdisc);
> +
> +		if (root && root->ops && !strcmp(root->ops->id, "taprio"))
> +			netdev_warn(netdev,
> +				    "mqprio: offload teardown cleared the TC layout of the new %s\n",
> +				    root->ops->id);
> +		netdev_set_num_tc(netdev, 0);
> +	}
> +	otx2_mqprio_free_cache(pfvf);
> +}

[Severity: Medium]
When tc qdisc replace replaces an offloaded mqprio qdisc with a software
taprio qdisc, does calling netdev_set_num_tc(netdev, 0) here break the
new taprio qdisc?

During replacement, taprio_init() -> taprio_change() configures
netdev->num_tc, netdev->tc_to_txq, and netdev->prio_tc_map before
qdisc_graft() publishes the new taprio qdisc and destroys the old mqprio
qdisc.  Resetting num_tc to 0 in otx2_mqprio_clear_sw() causes
taprio_dequeue_tc_priority() (which loops from netdev_get_num_tc(dev) - 1
down to 0) to do zero iterations and stop dequeuing TX packets.
Preserving the netdev TC layout in otx2_mqprio_keep_netdev_tc() when the
new root qdisc is taprio would avoid wiping out taprio's configuration.

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool ra=
te_limit)
> +{
> +	struct otx2_nic *pfvf =3D netdev_priv(netdev);
> +	const struct net_device_ops *ops =3D netdev->netdev_ops;
> +	bool running =3D netif_running(netdev);
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
> +		smp_mb__after_atomic(); /* Commit netif_running(). */
> +	}
> +
> +	err =3D ops->ndo_stop(netdev);
> +	if (err) {
> +		if (running)
> +			set_bit(__LINK_STATE_START, &netdev->state);
> +		return err;
> +	}
> +
> +	/* Set before ndo_open() so otx2_txsch_alloc() widens SMQ allocation.
> +	 * On teardown, drop mqprio software state so ndo_open() does not
> +	 * re-apply bandwidth limits via otx2_mqprio_up() after the kernel
> +	 * removed the qdisc.
> +	 */
> +	if (rate_limit)
> +		pfvf->mqprio.rate_limit =3D true;
> +	else
> +		otx2_mqprio_clear_sw(pfvf);
> +
> +	err =3D ops->ndo_open(netdev);
> +	if (!err && running) {
> +		set_bit(__LINK_STATE_START, &netdev->state);
> +	} else if (err) {
> +		netdev_err(netdev,
> +			   "Failed to restart device after mqprio change: %d; bringing interf=
ace down\n",
> +			   err);
> +		/* ndo_open() already tore down TX scheduler resources on failure;
> +		 * netif_running() is false here (__LINK_STATE_START stays clear
> +		 * until open succeeds). Drop mqprio software state only instead
> +		 * of sending shaper clears to freed queues.
> +		 */
> +		otx2_mqprio_clear_sw(pfvf);
> +		/* ndo_open() rolls back on failure; mark the interface down so
> +		 * otx2_stop() returns early when netif_close() runs.  Caller
> +		 * holds RTNL; netif_close() is used since it needs no extra
> +		 * locking (dev_close() would also take the netdev ops lock).
> +		 */
> +		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}
> +
> +	return err;
> +}

[Severity: Medium]
What happens during a tc qdisc replace if ops->ndo_open() fails in the
first otx2_mqprio_restart_netdev() call in otx2_setup_tc_mqprio()?

When ops->ndo_open() fails, otx2_free_hw_resources() ->
otx2_txschq_stop() zeroes pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ], and
this error path leaves __LINK_STATE_START clear and calls
netif_close(netdev) from inside ndo_setup_tc() (which runs
dev_deactivate_many() and emits NETDEV_GOING_DOWN/NETDEV_DOWN notifiers
mid-qdisc operation).  When otx2_setup_tc_mqprio() then jumps to cleanup
and calls otx2_mqprio_restore_old(), both netif_running(netdev) and
pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ] are 0, so
otx2_mqprio_restore_old() returns 0 without restoring hardware limits,
and cleanup logs and sets extack to "mqprio: replace failed; hardware
limits restored, netdev TC layout restore deferred" even though the
interface was closed.

[ ... ]

> +static bool otx2_tc_can_offload(struct net_device *netdev)
> +{
> +	return !!(netdev->hw_features & NETIF_F_HW_TC);
> +}
> +
> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct netlink_ext_ack *extack =3D mqprio->extack;
> +	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> +	bool had_mqprio =3D pfvf->mqprio.rate_limit;
> +	struct net_device *netdev =3D pfvf->netdev;
> +	bool if_up =3D netif_running(netdev);
> +	int err;
> +
> +	if (!otx2_tc_can_offload(netdev))
> +		return -EOPNOTSUPP;
> +
> +	qopt->hw =3D 0;
> +
> +	/* tc qdisc replace runs setup on the new mqprio before destroying the
> +	 * old one. replace_setup_done and TC_ROOT_GRAFT distinguish stale
> +	 * old-instance teardown from graft failure after setup.
> +	 * qdisc_offload_graft_helper() skips TC_ROOT_GRAFT unless hw-tc-offload
> +	 * is enabled in netdev->features; commit without graft in that case.
> +	 */
> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		err =3D 0;
> +		if (pfvf->mqprio.replace_graft_done || !tc_can_offload(netdev)) {
> +			otx2_mqprio_snap_commit(pfvf);
> +		} else {
> +			err =3D otx2_mqprio_restore_old(pfvf);
> +			if (err && extack)
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "mqprio: rollback failed (%d)",
> +						       err);
> +		}
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		return err;
> +	}

[Severity: Medium]
Does checking !tc_can_offload(netdev) here commit a rejected replacement
instead of rolling back when qdisc_create() fails after mqprio_init()?

In both otx2_probe() and otx2vf_probe(), NETIF_F_HW_TC is added to
netdev->hw_features after netdev->features |=3D netdev->hw_features, so
!tc_can_offload(netdev) is true by default while otx2_tc_can_offload()
still permits mqprio offload.  If a replacement mqprio qdisc succeeds in
mqprio_init() -> otx2_setup_tc_mqprio() (setting replace_setup_done and
cur_mq_snap) but qdisc_create() then fails before qdisc_graft() (for
example when TCA_RATE is passed on a TCQ_F_MQROOT qdisc), err_out4 in
qdisc_create() calls mqprio_destroy() -> otx2_teardown_tc_mqprio() on
the rejected new qdisc.  Because !tc_can_offload(netdev) is true, this
branch calls otx2_mqprio_snap_commit() instead of
otx2_mqprio_restore_old(), leaving the old mqprio qdisc attached while
hardware shapers, software rate caches, and old_mq_snap retain the
rejected replacement configuration.

Checking tc_can_offload(netdev) in otx2_tc_can_offload() so offload
requires NETIF_F_HW_TC in netdev->features would ensure TC_ROOT_GRAFT is
always sent on a successful graft.

> +
> +	/* Skip the netdev restart when mqprio offload was not active. */
> +	if (!had_mqprio)
> +		return 0;
> +
> +	if (if_up) {
> +		err =3D otx2_mqprio_down(pfvf);
> +		if (err) {
> +			if (extack)
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "mqprio: teardown incomplete (%d)",
> +						       err);
> +			netdev_err(netdev,
> +				   "mqprio: offload teardown incomplete (%d); driver state may not m=
atch removed qdisc\n",
> +				   err);
> +			return err;
> +		}
> +
> +		err =3D otx2_mqprio_restart_netdev(netdev, false);

[Severity: Medium]
Does returning early when otx2_mqprio_down() fails skip the netdev
restart that otx2_mqprio_down() relies on?

otx2_mqprio_down() unconditionally calls otx2_mqprio_clear_sw(pfvf)
(setting pfvf->mqprio.rate_limit to false, resetting num_tc, and freeing
the rate caches) and notes in its comment that the following netdev
restart reallocates the TX scheduler and drops any shaper left
programmed.  Returning early here on a shaper-clear error skips
otx2_mqprio_restart_netdev(netdev, false), and because
mqprio_disable_offload() ignores the return value, the qdisc is
destroyed while the interface stays up with the multi-SMQ hierarchy and
stale MDQ rate limits active in hardware, and with rate_limit =3D=3D false
no longer blocking PFC or HTB setup.

[ ... ]

> +static int otx2_setup_tc_mqprio(struct net_device *netdev,
> +				struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct netlink_ext_ack *extack =3D mqprio->extack;
> +	struct otx2_nic *pfvf =3D netdev_priv(netdev);
> +	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> +	bool replacing =3D pfvf->mqprio.rate_limit;
> +	bool if_up =3D netif_running(netdev);
> +	int tc, txq, err, i;
> +
> +	if (!otx2_tc_can_offload(netdev))
> +		return -EOPNOTSUPP;
> +
> +	if (!qopt->hw)
> +		return otx2_teardown_tc_mqprio(pfvf, mqprio);
> +
> +	if (!if_up) {
> +		netdev_err(netdev, "mqprio: setup requires interface UP\n");
> +		NL_SET_ERR_MSG_MOD(extack, "mqprio: setup requires interface UP");
> +		err =3D -EOPNOTSUPP;
> +		goto fail_validate;
> +	}
> +
> +	if (!replacing && otx2_mqprio_keep_netdev_tc(pfvf)) {
> +		netdev_err(netdev,
> +			   "mqprio: delete existing mqprio before re-enabling hw/sw offload\n=
");
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "mqprio: delete existing mqprio before re-enabling hw/sw offload"=
);
> +		return -EOPNOTSUPP;
> +	}

[Severity: Medium]
When rejecting a replace of an existing software mqprio qdisc (hw 0)
with a hardware-offloaded mqprio qdisc (hw 1), does the error unwind in
qdisc_create() wipe out the software mqprio qdisc's netdev TC layout?

When otx2_setup_tc_mqprio() returns -EOPNOTSUPP here (or at the !if_up
check above), qdisc_create() jumps to err_out4 and calls
mqprio_destroy() on the failed new qdisc.  Because priv->hw_offload is 0
on the failed qdisc, mqprio_destroy() calls netdev_set_num_tc(dev, 0),
clearing the num_tc and queue mappings of the still-attached software
mqprio qdisc without old_mq_snap or netdev_tc_work restoring them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109033154.2161=
803-1-rkannoth@marvell.com?part=3D2
