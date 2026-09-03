Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399C3EDE4A;
	Thu,  3 Sep 2026 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462923; cv=none; b=HZr0L0PdulM3oBxY9AbsgSICopazpXJhCttaKLxbJg9ARFY96WPmIsw6/U+nBS8xcOV2Pe0tMOrywzUz0xKngRl/lw9I/KLFIeZWMU6qMZFSB1r22j9xZkU7ZtoZ6u0mXlpb7ABXfjZ6XkLW6PqHppSEtl+sZ8bPPwLMa9i7xP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462923; c=relaxed/simple;
	bh=2kRHocSS0K9M5XLU5wcd0d6+YCutctqbb0B/nUnOsso=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gqQgJLY4A/3VU16nvNOktUpXxAeD7mvDJ4MTbmYmYi1vaAcYRiDw/SiRvyExmSzJ3R6gbIGQjsvO9v99TTm59gf3WZpLTnCNN7xRdRebGv9bo0r1faEnEY3iDgQNICoNLEobGBa+cC3HFOEFwvLJDvJUn2Pb89KuHmtFsGnIIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahdrnic9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahdrnic9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DF41F00A3D;
	Thu,  3 Sep 2026 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788462903;
	bh=+Q1c8/p7y/g9tRE4fygS3nl8S/X7t2/O9o2LcrqyRJg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ahdrnic9Q1fhcxSRj/y9H3QVrCGO2/F1TK0+mHxKl4SkznSkon2pX6brhjkC4WyMa
	 RQw/UEN+GmjtP3d/hd1gd7tXSD60aFRPgGZsFFah6FNHAEay2Q8vu0oBj9FMavIAEV
	 YjGLlyNLRu/tZiU8o2dWtbySOK04FRmnYijacJwIBNqn553WoKCMytCNJo05BwJGWQ
	 ju2oZuA4K6M9i0ohEnbCHOAdzQaXPTu1JhCe952PMZAEHSUb1jevJXYTS87XmOOLSS
	 UGWfG2hozZoG+3QMEN2lMmJGs0/3tuF9iS1HwjfC++176502w3NZQkqI3GrX0Et+J1
	 MQxSdBsXK0gHQ==
Subject: Re: [v10,net-next,2/2] octeontx2-pf: add mqprio bandwidth offload for
 NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, john.fastabend@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, sdf@fomichev.me, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:15:01 +0000
Message-ID: <178846290196.3394541.5288115406015228702@kernel.org>
In-Reply-To: <20260831131014.2639581-3-rkannoth@marvell.com>
References: <20260831131014.2639581-3-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider:

Critical: 0 · High: 4 · Medium: 6 · Low: 1

- [High] Stale scheduler bookkeeping makes the new liveness guard
  `otx2_mqprio_mdq_allocated()` (otx2_tc.c:1710) useless:…
- [High] The stated rollback is incomplete: `otx2_mqprio_restore_old()`
  (otx2_tc.c:1715-1772) restores the per-queue rate cache,…
- [High] Heap out-of-bounds write in `otx2_mqprio_restore_old()`: it
  indexes the freshly allocated `pfvf->mqprio.min_rate[]`/`max_rate[]`…
- [High] The error-path rollback in `otx2_setup_tc_mqprio()` never
  executes for an initial (non-replacing) mqprio add: `cleanup:` calls…
- [Medium] Undisclosed user-visible impact of the new failure path:
  `otx2_mqprio_restart_netdev()` sets `OTX2_FLAG_INTF_DOWN` and calls…
- [Medium] Inconsistent netdev TC state after a failed `tc qdisc
  replace`: the `cleanup:` path calls `otx2_mqprio_restore_old()`, which…
- [Medium] Teardown asymmetry in `otx2_teardown_tc_mqprio()`: in the
  `if_up` branch the return value of `otx2_mqprio_down()` is saved but…
- [Medium] The interface is reopened and its TX queues are made runnable
  before the new mqprio shapers and TC mapping are programmed:…
- [Medium] `otx2_mqprio_up()` programs MDQ CIR/PIR one TX queue at a time
  (one mailbox transaction per queue, each arming the shaper with the…
- [Medium] Memory allocation failure during qdisc deletion aborts
  teardown, leaking active hardware shapers.
- [Low] Undocumented change to the AF driver: a new
  `dev_err_ratelimited()` is added to `is_valid_txschq()` in…

--

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO handling for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE, shaping each non-QoS TX queue through MDQ
CIR/PIR and restarting the netdev to reprogram the TX scheduler
hierarchy.  Committed mqprio state is tracked in mq_offload_snap
snapshots, with rollback from the previous snapshot when a replace fails.

A few questions about the new state machine and the scheduler bookkeeping
it relies on.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad067..c9a4326d725d8 100644
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
The changelog describes only PF-side mqprio bandwidth offload and does not
mention the AF driver at all.  This hunk changes is_valid_txschq() so that
every ownership mismatch on the mailbox path now emits a host log line,
reached from rvu_mbox_handler_nix_txschq_cfg() -> is_txschq_config_valid()
-> is_valid_txschq().  Any PF or VF, including guest VFs, can produce these
lines by asking to program a scheduler queue it does not own.

Would it make sense to split this into its own patch, or at least describe
it in the changelog?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 175992188c18a..5c502c9d7c83f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -615,6 +615,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)
>  }
>  EXPORT_SYMBOL(otx2_get_mac_from_af);
>  

[ ... ]

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

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index c995f29008590..79a82e4454546 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1980,6 +1980,12 @@ int otx2_open(struct net_device *netdev)
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
otx2_mqprio_up() programs MDQ CIR/PIR one queue per mailbox transaction and
returns on the first failure:

		err = otx2_nix_tm_set_queue_shaper(pfvf, txq, min_rate,
						   max_rate);
		if (err) {
			netdev_err(netdev,
				   "mqprio: failed to restore shaper for txq %d: %d\n",
				   txq, err);
			return err;
		}

Queues 0..k-1 are then left shaped and the rest run at line rate, with no
rollback, while this caller only logs "continuing without bandwidth limits"
and proceeds with pf->mqprio.rate_limit still true and the TC layout still
advertised (qopt->hw was already reported as TC_MQPRIO_HW_OFFLOAD_TCS).

Should the partially applied shapers be cleared here, so the driver's view
and the device's view do not stay divergent until the next explicit mqprio
operation?

>  	/* Register NAPI handler */
>  	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
>  		cq_poll = &qset->napi[qidx];

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..3f835eb977d3b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -1600,14 +1609,700 @@ static int otx2_setup_tc_block(struct net_device *netdev,
>  					  nic, nic, ingress);
>  }
>  

[ ... ]

> +static bool otx2_mqprio_mdq_allocated(struct otx2_nic *pfvf)
> +{
> +	return pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_MDQ] != 0;
> +}

[Severity: High]
Does this predicate really tell whether the scheduler nodes are still
owned?  otx2_txschq_stop() frees the TL/SMQ nodes and zeroes
hw.txschq_list[][], but leaves hw.txschq_cnt[] untouched:

otx2_common.c:otx2_txschq_stop() {
	...
	/* Clear the txschq list */
	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
			pfvf->hw.txschq_list[lvl][schq] = 0;
	}
	...
}

hw.txschq_cnt[] is only ever assigned in otx2_txsch_alloc(), so after
ndo_stop() this still reports MDQ allocated.
otx2_nix_tm_clear_queue_shaper() then iterates txschq_cnt[SMQ] entries of
the zeroed list and emits NIX_AF_MDQX_PIR(0)/CIR(0) writes;
otx2_get_smq_idx() returns 0 for the same reason, so otx2_mqprio_up()
programs the cached rates onto MDQ index 0.

One way in is ip link set dev X down followed by tc qdisc del dev X root:
otx2_teardown_tc_mqprio() calls otx2_mqprio_restore_old(), which has no
netif_running() guard (unlike otx2_mqprio_down()).  The AF then rejects the
write in is_valid_txschq() - the same mismatch the new
dev_err_ratelimited() above logs - and that mbox error makes
otx2_mqprio_restore_old() return before otx2_mqprio_clear_sw() ever runs.

mqprio_disable_offload() discards the driver return value, so the qdisc
disappears while pfvf->mqprio.rate_limit stays true, which keeps
ethtool -L, XDP attach and PFC rejected and makes every later otx2_open()
re-widen the SMQ allocation and re-apply the stale rates.

Note also the comment on otx2_mqprio_down() saying the guard avoids
"sending shaper clears to freed queues" - is that guarantee actually
provided?  Should the check look at hw.txschq_list[], or should
otx2_txschq_stop() clear txschq_cnt[]?

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
> +
> +	memset(pfvf->mqprio.min_rate, 0, num_txq * sizeof(*pfvf->mqprio.min_rate));
> +	memset(pfvf->mqprio.max_rate, 0, num_txq * sizeof(*pfvf->mqprio.max_rate));
> +	pfvf->mqprio.flags = 0;
> +
> +	for (tc = 0; tc < snap->num_tc; tc++) {
> +		u64 min_rate = snap->min_rate[tc];
> +		u64 max_rate = snap->max_rate[tc];
> +
> +		if (min_rate)
> +			pfvf->mqprio.flags |= TC_MQPRIO_F_MIN_RATE;
> +		if (max_rate)
> +			pfvf->mqprio.flags |= TC_MQPRIO_F_MAX_RATE;
> +
> +		for (txq = snap->offset[tc];
> +		     txq < snap->offset[tc] + snap->count[tc]; txq++) {
> +			pfvf->mqprio.min_rate[txq] = min_rate;
> +			pfvf->mqprio.max_rate[txq] = max_rate;
> +		}
> +	}

[Severity: High]
Can this write past pfvf->mqprio.min_rate[] and max_rate[]?  Those arrays
are sized by the current hw.non_qos_queues in otx2_mqprio_alloc_cache(),
while snap->offset[]/count[] were validated against a possibly larger queue
count at setup time.  otx2_mqprio_validate_txqs() only runs on the setup
path, so there is no bounds re-validation here.

A sequence that reaches it:

1. mqprio bandwidth offload configured with 8 TX queues, committed as
   old_mq_snap (offsets up to 8)
2. tc qdisc replace whose ndo_open() fails inside
   otx2_mqprio_restart_netdev(); that path calls otx2_mqprio_clear_sw()
   (clearing rate_limit) and closes the interface, then cleanup: calls
   otx2_mqprio_restore_old(), which sets mqprio.handle again
3. ethtool -L dev X tx 2 is now accepted, because the new guard in
   otx2_set_channels() only refuses while mqprio.rate_limit is true
4. ip link set up runs otx2_alloc_queue_mem(), which recomputes
   hw.non_qos_queues = tx_queues + xdp_queues = 2
5. tc qdisc del dev X root of the still installed old qdisc matches
   mqprio.handle, so otx2_mqprio_restore_old() allocates two-entry arrays
   and writes indices 0..7

That would be 48 bytes past each 16 byte devm_kcalloc() buffer.  Should the
restore path clamp txq against the current hw.non_qos_queues?

> +
> +	pfvf->mqprio.handle = snap->handle;

[Severity: High]
Does the rollback restore a configuration that is actually active?
otx2_mqprio_restore_old() restores the rate cache, mqprio.handle and the
netdev TC mapping, but never restores pfvf->mqprio.rate_limit.  When the
replace failed inside otx2_mqprio_restart_netdev(), its ndo_open() error
path already ran otx2_mqprio_clear_sw(), which cleared rate_limit.

rate_limit is the only thing that widens the SMQ allocation:

otx2_common.c:otx2_txsch_alloc() {
	if (pfvf->mqprio.rate_limit)
		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
}

and the only thing that parents the MDQs under TL4[0] in
otx2_txschq_config(); otx2_mqprio_up() also returns immediately when it is
false.  So the restored configuration is inert (single SMQ, all TX queues
collapsed onto it by otx2_get_smq_idx(), no shapers) while the driver logs
"mqprio: replace failed; prior configuration restored".

A later tc qdisc del of the surviving qdisc then matches the restored
mqprio.handle, runs otx2_mqprio_restore_old() again and hits
if (!had_mqprio) return 0; in otx2_teardown_tc_mqprio() because had_mqprio
is rate_limit, so otx2_mqprio_clear_sw() never runs.  The netdev keeps a
non-zero num_tc and tc_to_txq[] mapping with no mqprio qdisc installed;
mqprio_destroy() also skips netdev_set_num_tc(dev, 0) because the old
qdisc has hw_offload set.

> +
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
> +
> +	err = otx2_mqprio_up(pfvf);
> +	if (err)
> +		return err;
> +
> +	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
> +
> +	return 0;
> +}

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> +{
> +	struct otx2_nic *pfvf = netdev_priv(netdev);
> +	const struct net_device_ops *ops = netdev->netdev_ops;
> +	int err;
> +
[ ... ]
> +	err = ops->ndo_stop(netdev);
> +	if (err)
> +		return err;
> +
> +	/* Set before ndo_open() so otx2_txsch_alloc() widens SMQ allocation. */
> +	if (rate_limit)
> +		pfvf->mqprio.rate_limit = true;
> +
> +	err = ops->ndo_open(netdev);
> +	if (err) {
> +		netdev_err(netdev,
> +			   "Failed to restart device after mqprio change: %d\n",
> +			   err);
[ ... ]
> +		otx2_mqprio_clear_sw(pfvf);
[ ... ]
> +		pfvf->flags |= OTX2_FLAG_INTF_DOWN;
> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}
> +
> +	return err;
> +}

[Severity: Medium]
Should the changelog mention that a failed tc qdisc add or replace can
leave the interface administratively down?  It only says the hierarchy is
reprogrammed "through ndo_stop() and ndo_open() on every mqprio add,
replace, or delete", which reads as a traffic hiccup, while this path sets
OTX2_FLAG_INTF_DOWN and calls netif_close(), so recovery needs an explicit
ip link set up.

The reopen now asks the AF for hw.non_qos_queues SMQs instead of one, so
ndo_open() failure is considerably more likely than before when the shared
scheduler pool is short.

[ ... ]

> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	bool had_mqprio = pfvf->mqprio.rate_limit;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	struct net_device *netdev = pfvf->netdev;
> +	bool if_up = netif_running(netdev);
> +	bool rollback;
> +	int err;
> +
> +	qopt->hw = 0;
> +
> +	/* tc qdisc replace runs setup on the new mqprio before destroying the
> +	 * old one. Ignore teardown from the replaced instance once the new
> +	 * handle is committed in otx2_setup_tc_mqprio().
> +	 */
> +	if (mqprio->handle && mqprio->handle != pfvf->mqprio.handle) {
> +		if (pfvf->cur_mq_snap)
> +			otx2_mqprio_snap_commit(pfvf);
> +		return 0;
> +	}

[Severity: High]
Does this early return turn the cleanup: path of otx2_setup_tc_mqprio()
into a no-op for an initial, non replacing mqprio add?
pfvf->mqprio.handle is assigned only after every goto cleanup site, and
mqprio->handle is sch->handle, which is set before ops->init runs:

net/sched/sch_api.c:qdisc_create() {
	...
	sch->handle = handle;
	...
	if (ops->init) {
		err = ops->init(sch, tca[TCA_OPTIONS], extack);
	...
}

The handle is auto allocated by qdisc_alloc_handle() when the user omits
it, so it is always non-zero and always differs from pfvf->mqprio.handle on
the failure path.  The teardown then merely commits a snapshot that was
never applied as old_mq_snap and returns 0.

Failures that reach cleanup: after otx2_mqprio_restart_netdev() already
succeeded include a devm_kcalloc() -ENOMEM in otx2_mqprio_alloc_cache() and
any mbox error from otx2_nix_tm_clear_queue_shaper() or
otx2_nix_tm_set_queue_shaper().  In that case qdisc creation fails and
mqprio_destroy() resets the netdev TC count (hw_offload is 0), but the
driver keeps mqprio.rate_limit true with the widened SMQ/TL4[0] hierarchy
and partially programmed MDQ shapers, with no qdisc present.

> +
> +	if (mqprio->handle && mqprio->handle == pfvf->mqprio.handle &&
> +	    pfvf->old_mq_snap) {
> +		rollback = pfvf->cur_mq_snap;
> +
> +		err = otx2_mqprio_restore_old(pfvf);
> +		if (err)
> +			return err;
> +		if (rollback)
> +			return 0;
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
On a plain tc qdisc del of a committed offload this branch is taken
too: mqprio->handle matches pfvf->mqprio.handle and old_mq_snap is
set, while cur_mq_snap is NULL, so rollback is false and the intent is
to fall through to the real teardown below.  But
otx2_mqprio_restore_old() is still executed on the way there, and the
first thing it does is otx2_mqprio_alloc_cache(pfvf, false), which
frees the existing min_rate/max_rate arrays and re-allocates them with
devm_kcalloc().

So an -ENOMEM in a path that is only re-deriving state we are about to
throw away aborts the delete: we return here before
otx2_mqprio_down(), otx2_mqprio_restart_netdev() and
otx2_mqprio_clear_sw() run.  The MDQ CIR/PIR values stay programmed
and pfvf->mqprio.rate_limit stays true, but the qdisc is destroyed
anyway because mqprio_disable_offload() has a void return and never
sees the error.  Worse, alloc_cache()'s failure path calls
otx2_mqprio_free_cache(), so mqprio.min_rate/max_rate are now NULL:
the interface keeps rate_limit set - refusing ethtool -L, XDP attach
and PFC, and re-widening the SMQ allocation on every otx2_open() -
while the cached rates that otx2_mqprio_up() would need are gone and
the hardware limits linger with no qdisc to explain them.

Should the delete path skip otx2_mqprio_restore_old() entirely when
cur_mq_snap is NULL, since there is no replace to roll back?  Or
should teardown log the restore failure and continue to
otx2_mqprio_down() regardless, so a deletion requested by user space
always ends with the hardware and software state cleared?

[Severity: Medium]
When otx2_mqprio_down() fails here, is restarting the interface anyway the
intended behaviour?  On an mbox error otx2_mqprio_down() returns before
otx2_mqprio_clear_sw(), so rate_limit, mqprio.handle and the rate cache all
survive, and otx2_mqprio_restart_netdev(netdev, false) never clears
rate_limit - it only ever sets it:

	if (rate_limit)
		pfvf->mqprio.rate_limit = true;

So the reopen re-allocates one SMQ per queue and otx2_open()'s
otx2_mqprio_up() re-programs every cached shaper for a qdisc that is being
destroyed.  mqprio_disable_offload() has a void return, so user space never
learns about it.

> +
> +	/* ndo_stop() already freed the TX scheduler TL nodes; drop software
> +	 * state only.
> +	 */
> +	otx2_mqprio_clear_sw(pfvf);
> +	return 0;
> +}
> +
> +static int otx2_setup_tc_mqprio(struct net_device *netdev,
> +				struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	err = otx2_mqprio_stage_cur(pfvf, mqprio);
> +	if (err)
> +		return err;
> +
> +	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
> +	if (err)
> +		goto cleanup;
> +
> +	err = otx2_mqprio_alloc_cache(pfvf, replacing);
> +	if (err)
> +		goto cleanup;
> +
> +	/* otx2_mqprio_up() may have restored the previous configuration during
> +	 * the restart above. Clear every MDQ shaper before applying the new
> +	 * mapping so queues dropped from the TC layout do not keep stale
> +	 * limits in hardware.
> +	 */
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			goto cleanup;
> +	}

[Severity: Medium]
Is there a window here where traffic egresses with no shapers, or with a
half applied TC map?  otx2_mqprio_restart_netdev() has already reopened the
device, and on an already up link otx2_open() reaches
otx2_handle_link_event() -> netif_tx_start_all_queues(), so TX is running
again before this code clears every MDQ shaper, programs the queues one
mailbox at a time, and finally publishes netdev_set_num_tc() followed by
the individual netdev_set_tc_queue() entries.

RTNL does not serialize against the transmit path, and for a newly created
qdisc tc_modify_qdisc() calls qdisc_create() (and therefore this callback)
before qdisc_graft() does dev_deactivate(), so the core does not quiesce
the datapath either.  A transmitting CPU can see num_tc published before
the matching tc_to_txq[] entry is set.

> +
> +	pfvf->mqprio.flags = mqprio->flags;
> +

[ ... ]

> +	netdev_set_num_tc(netdev, pfvf->cur_mq_snap->num_tc);
> +	for (i = 0; i < pfvf->cur_mq_snap->num_tc; i++)
> +		netdev_set_tc_queue(netdev, i, pfvf->cur_mq_snap->count[i],
> +				    qopt->offset[i]);
> +
> +	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
> +	pfvf->mqprio.handle = mqprio->handle;
> +
> +	if (!replacing)
> +		otx2_mqprio_snap_commit(pfvf);
> +
> +	return 0;
> +
> +cleanup:
> +	qopt->hw = 0;
> +	if (replacing) {
> +		int restore_err = otx2_mqprio_restore_old(pfvf);
> +
[ ... ]
> +		} else {
> +			netdev_err(netdev,
> +				   "mqprio: replace failed; prior configuration restored\n");
> +			if (extack)
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "mqprio: replace failed; prior configuration restored");
> +		}
> +		return err ? err : -EIO;
> +	}

[Severity: Medium]
otx2_mqprio_restore_old() re-applies netdev_set_num_tc() and
netdev_set_tc_queue(), but this path then returns an error to the core.
mqprio_enable_offload() propagates it without setting priv->hw_offload, so
mqprio_init() fails and qdisc_create() runs:

net/sched/sch_api.c:qdisc_create() {
err_out4:
	/* Even if ops->init() failed, we call ops->destroy() */
	if (ops->destroy)
		ops->destroy(sch);
	...
}

and mqprio_destroy() takes the non offloaded branch:

	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);

Does that wipe the mapping the driver just restored, even though the old
mqprio qdisc is still grafted with hw_offload set?  The end state has the
driver keeping rate_limit, the cached rates, the programmed MDQ CIR/PIR and
the TL4 flattened hierarchy, while the netdev has no TC mapping at all, so
queue selection no longer follows the surviving qdisc's layout.

> +	otx2_teardown_tc_mqprio(pfvf, mqprio);
> +	return err;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131014.2639581-1-rkannoth%40marvell.com
