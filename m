Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D404D955E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644732; cv=none; b=GZOTMBKigjnuk4wmxJjzY7DeHIFrXJV5FeTpbA9oHvj911F41QRpV9egkxt6knjkauKT2SmdacMk7f15yl2Qdj8Sl19al20NLFO0ru/7LfSuyHf8gpxYLvaIfbtEIC4/7tVIesQd8awqiJbn+OSA2/GktUvzdT5fT8CZ8INbt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644732; c=relaxed/simple;
	bh=OifrjkcRx3WikaxZMJQdUYBsiCwxf4GSdFAhPHSSlR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe1iEhkzc+02m4G70a3cDCpZzMNUwC6+Xpn/Ul86QaICIwUudQTvEiObdgbrDhtV37swxTAGUdxmgpWxso14EJbEyGffQrVLTDYdQ8WKrWHXV9A11zSiUScxuze/Kg7/QZHetQv/AV9VCdVEdxYV9X/MnToIWRGZ3thbutLD3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnlCEGHp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnlCEGHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789644729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kf5PZO7n/y9bFSo9T+iptbNx779dEcwmMV3+dW0B+Ws=;
	b=YnlCEGHppU1a9QMxd3Yz47s8Hjm4C0ZlStfcJZPMIM1e1yZpkmu8rn5M5GblWzBMP/iK7Q
	vjiGtruwF2Z+Tgsyh7DPjWbX+5bK0iVnOgu2/9TboxQNBjpQ3YBaostOXLuW/K0YWYyUO2
	dEWjC7zBu9cV5vtjJAjaIgvsi6Zc+Qg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-bvIYm_czPV-B67IO5Xlogw-1; Thu,
 17 Sep 2026 07:32:05 -0400
X-MC-Unique: bvIYm_czPV-B67IO5Xlogw-1
X-Mimecast-MFC-AGG-ID: bvIYm_czPV-B67IO5Xlogw_1789644723
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C9B1195395F;
	Thu, 17 Sep 2026 11:32:03 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83CFD214;
	Thu, 17 Sep 2026 11:31:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	sgoutham@marvell.com
Subject: Re: [PATCH v15 net-next 2/2] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Thu, 17 Sep 2026 13:31:50 +0200
Message-ID: <20260917113150.171042-1-pabeni@redhat.com>
In-Reply-To: <20260911105521.689565-3-rkannoth@marvell.com>
References: <20260911105521.689565-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO channel-mode offload with
TC_MQPRIO_SHAPER_BW_RATE, programming per-queue MDQ CIR/PIR through the
NIX TX scheduler mailbox. Since the scheduler hierarchy cannot be
reprogrammed live, every mqprio add, replace, delete and rollback bounces
the netdev through ndo_stop()/ndo_open(), with the TC layout and rates
tracked in mq_offload_snap snapshots for rollback.

A few questions on the commit message first.

> Use atomic bit operations when updating OTX2_FLAG_PORT_UP and
> OTX2_FLAG_INTF_DOWN on asynchronous and netdev-restart paths.
>
> Add a ratelimited AF debug message when validating TX scheduler queue
> ownership to aid mqprio hierarchy setup failures.

[Severity: Low]
The first paragraph appears to describe the immediately preceding commit
("octeontx2: use atomic bitops for PF/VF and rep flags"), which is what
converted the flags field to bit numbers and introduced otx2_set_flag().
The only new flag write added here is the
otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN) call in
otx2_mqprio_restart_netdev(), which simply inherits that conversion.
Should this paragraph be dropped?

For the second paragraph, the AF change adds dev_err_ratelimited() in
is_valid_txschq(), which is an error-level print rather than a debug
message, and it is reachable from VF mailbox requests. Could the wording
match the log level used, or should the print be pr_debug/dev_dbg level?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index d80d2c00bd843..2d1ab8c761c40 100644
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

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 7e09c1444a6d5..6e7132f27b621 100644
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
Should the snapshot also record prio_tc_map[]?

sch_mqprio installs three pieces of netdev state for an offloaded mqprio,
and the priority map is applied from the new qopt after the driver
callback returns success:

net/sched/sch_mqprio.c:mqprio_init() {
	...
	/* Always use supplied priority mappings */
	for (i = 0; i < TC_BITMASK + 1; i++)
		netdev_set_prio_tc_map(dev, i, qopt->prio_tc_map[i]);
	...
}

otx2_mqprio_restore_old() only replays num_tc and the per-TC
count/offset pair:

	netdev_set_num_tc(netdev, snap->num_tc);
	for (tc = 0; tc < snap->num_tc; tc++)
		netdev_set_tc_queue(netdev, tc, snap->count[tc],
				    snap->offset[tc]);

After a rollback of a replacement whose setup succeeded but which was
never grafted (for example qdisc_create() failing at err_out4 with
TCQ_F_MQROOT and then calling ops->destroy()), dev->prio_tc_map[] still
describes the abandoned layout while num_tc/tc_to_txq describe the old
one, so skb_tx_hash() steers traffic to queues whose MDQ shapers belong
to a different configuration.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 32582b6347ea4..1e17f8d49fd44 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2007,6 +2007,14 @@ int otx2_open(struct net_device *netdev)
>  	if (err)
>  		goto err_free_mem;
>  
> +	err = otx2_mqprio_up(pf);
> +	if (err) {
> +		netdev_err(pf->netdev,
> +			   "mqprio: failed to restore shapers during open: %d\n",
> +			   err);
> +		goto err_free_hw;
> +	}
> +
>  	/* Register NAPI handler */
>  	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
>  		cq_poll = &qset->napi[qidx];
> @@ -2205,6 +2213,7 @@ int otx2_open(struct net_device *netdev)
>  	free_irq(vec, pf);
>  err_disable_napi:
>  	otx2_disable_napi(pf);
> +err_free_hw:
>  	otx2_free_hw_resources(pf);
>  err_free_mem:
>  	otx2_free_queue_mem(qset);

[Severity: Medium]
This isn't a bug introduced by this patch, but does this new error label
leak pf->refill_wrk?

pf->refill_wrk is allocated (and its delayed works initialised) inside
otx2_init_hw_resources() -> otx2_config_nix_queues():

	pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
					sizeof(struct refill_work), GFP_KERNEL);

The only place it is cancelled and freed is otx2_stop():

	for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
	devm_kfree(pf->dev, pf->refill_wrk);

None of the otx2_open() error labels, including the new err_free_hw,
cancel the works or free the array, so each failed open leaks one array
until driver detach. This unbalanced lifecycle is shared by all the
pre-existing labels, but this patch adds a new one and makes ndo_open()
failure routinely reachable from userspace through
otx2_mqprio_restart_netdev() on tc qdisc add/replace/del.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index ddb46b580c3b6..70d99ae3defb5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -1600,14 +1609,750 @@ static int otx2_setup_tc_block(struct net_device *netdev,
>  					  nic, nic, ingress);
>  }
>  
> +/* Free the per-queue min/max rate caches. */
> +static void otx2_mqprio_free_cache(struct otx2_nic *pfvf)
> +{
> +	devm_kfree(pfvf->dev, pfvf->mqprio.min_rate);
> +	devm_kfree(pfvf->dev, pfvf->mqprio.max_rate);
> +	pfvf->mqprio.min_rate = NULL;
> +	pfvf->mqprio.max_rate = NULL;
> +	pfvf->mqprio.flags = 0;
> +}
> +
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
Can a failed replace lose the active configuration permanently here?

otx2_mqprio_free_cache() releases the live caches before the two
devm_kcalloc() calls, so on -ENOMEM both min_rate and max_rate are NULL.
otx2_mqprio_restore_old() bails out before rebuilding anything:

	err = otx2_mqprio_alloc_cache(pfvf, false);
	if (err)
		return err;

At that point the old qdisc is still installed and mqprio.rate_limit is
still true, but the rates are gone. The next open cannot recover them
either, because otx2_mqprio_up() treats missing caches as success:

	if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate)
		return 0;

Would allocating into temporary pointers and only swapping them in on
success avoid destroying the live state?

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit);
> +
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
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			return err;
> +	}

[Severity: Medium]
Does this early return leave hardware and software state out of sync?

By the time this runs, the software cache has already been rewritten from
old_mq_snap, and the failed replace has already programmed some MDQ
CIR/PIR registers with the new rates in the
otx2_nix_tm_set_queue_shaper() loop of otx2_setup_tc_mqprio(). Returning
here skips both

	pfvf->mqprio.rate_limit = true;

and the netif_running() restart, so the interface keeps running with
per-queue shapers holding a partially applied configuration that the
driver's bookkeeping no longer describes, until some unrelated stop/open
cycle happens. Should a failure here force the netdev restart so the AF
resets shaping on freshly allocated MDQs?

> +
> +	/* Rebuild the TX scheduler via netdev restart when running; otx2_mqprio_up()
> +	 * alone is insufficient after a failed replace that already bounced the
> +	 * interface. If open failed, TX schedulers were freed; defer shaper restore
> +	 * to the next successful ndo_open() via otx2_mqprio_up().
> +	 */
> +	pfvf->mqprio.rate_limit = true;
> +
> +	if (netif_running(netdev)) {
> +		err = otx2_mqprio_restart_netdev(netdev, true);
> +		if (err)
> +			return err;
> +	} else if (pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]) {
> +		err = otx2_mqprio_up(pfvf);
> +		if (err)
> +			return err;
> +	}
> +
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

> +int otx2_mqprio_up(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev = pfvf->netdev;
> +	int txq, err;
> +
> +	if (!pfvf->mqprio.rate_limit)
> +		return 0;
> +
> +	if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate)
> +		return 0;

[ ... ]

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
> +	netdev_info(netdev,
> +		    "mqprio: restarting interface to reprogram TX scheduler; in-flight traffic will be dropped\n");
> +
> +	if (running) {
> +		clear_bit(__LINK_STATE_START, &netdev->state);
> +		smp_mb__after_atomic(); /* Commit netif_running(). */
> +	}
> +	dev_deactivate(netdev, true);
> +
> +	err = ops->ndo_stop(netdev);
> +	if (err) {
> +		if (running) {
> +			set_bit(__LINK_STATE_START, &netdev->state);
> +			dev_activate(netdev);
> +		}
> +		return err;
> +	}

[Severity: High]
Is it safe for a driver to drive dev_deactivate()/dev_activate() from
inside an ndo_setup_tc(TC_SETUP_QDISC_MQPRIO) callback?

On the teardown/replace path this callback runs from
mqprio_destroy() -> mqprio_disable_offload(), which the core invokes from
the middle of qdisc_graft():

net/sched/sch_api.c:qdisc_graft() {
	if (dev->flags & IFF_UP)
		dev_deactivate(dev, false);
	qdisc_offload_graft_root(dev, new, old, extack);
	...
		notify_and_destroy(net, skb, n, classid, old, new, extack);
		if (new && new->ops->attach)
			new->ops->attach(new);
	}
	if (dev->flags & IFF_UP)
		dev_activate(dev);
}

dev_deactivate() does not clear __LINK_STATE_START, so
otx2_teardown_tc_mqprio() sees netif_running() == true and calls
otx2_mqprio_restart_netdev(netdev, false), whose

	set_bit(__LINK_STATE_START, &netdev->state);
	dev_activate(netdev);

clears __QDISC_STATE_DEACTIVATED on the outgoing per-queue child qdiscs
and republishes them into dev_queue->qdisc, since new->ops->attach() has
not run yet. mq_attach()/mqprio_attach() then dev_graft_qdisc() and
qdisc_put() exactly those qdiscs without any further
some_qdisc_is_busy() wait, so a concurrent softirq __qdisc_run() can be
running inside a qdisc that is being reset and freed.

Reproducer would be "tc qdisc replace dev X root mq" on a running
interface carrying traffic with the offload active. The same reentrancy
also purges an unrelated live qdisc on the add path, where
dev_deactivate(netdev, true) is called from within mqprio_init().

Can the offload be restructured so the driver never touches the core's
activate/deactivate state machine from a qdisc callback?

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
Does replacing an offloaded mqprio with a non-offloaded configuration
wipe the TC layout of the qdisc that is already live?

For "tc qdisc replace dev X root mqprio ... hw 0" (or "... root mq"),
mqprio_init() installs the new layout without ever calling
ndo_setup_tc():

net/sched/sch_mqprio.c:mqprio_init() {
	...
	} else {
		netdev_set_num_tc(dev, qopt->num_tc);
		for (i = 0; i < qopt->num_tc; i++)
			netdev_set_tc_queue(dev, i, qopt->count[i], qopt->offset[i]);
	}
	...
}

So replace_setup_done stays false, and the later destruction of the old
offloaded instance reaches this function and takes the full-teardown
branch above, whose otx2_mqprio_clear_sw() runs
netdev_set_num_tc(netdev, 0) on the qdisc the core has just grafted.

The result is dev->num_tc == 0 while a software mqprio expects N traffic
classes, so skb_tx_hash() no longer honours the prio/TC/txq ranges and
mqprio_dump() reports 0 TCs. The netdev is also bounced in that case.

[ ... ]

> +cleanup:
> +	qopt->hw = 0;
> +	if (replacing) {
> +		int restore_err = otx2_mqprio_restore_old(pfvf);
> +
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		if (restore_err) {

[ ... ]

> +		return err ? err : -EIO;
> +	}

[Severity: Medium]
Does the core immediately undo the netdev part of this rollback?

Because otx2_setup_tc_mqprio() returns an error here,
mqprio_enable_offload() propagates it before setting priv->hw_offload,
so when qdisc_create() unwinds via ops->destroy() the core takes the
non-offload branch:

net/sched/sch_mqprio.c:mqprio_destroy() {
	...
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
	...
}

That leaves the old mqprio qdisc installed and the driver offload active
(mqprio.rate_limit true, MDQ CIR/PIR programmed from old_mq_snap) while
dev->num_tc is 0 and tc_to_txq[] is cleared, so traffic spreads over the
whole queue range and tc qdisc show reports 0 TCs for an offloaded
qdisc. This is reachable from any failure after the bounce, for example
an -ENOMEM from otx2_mqprio_alloc_cache() or a mailbox error from
otx2_nix_tm_set_queue_shaper().

[ ... ]
-- 
This is an AI-generated review.

