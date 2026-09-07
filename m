Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDA230BD5;
	Mon,  7 Sep 2026 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767889; cv=none; b=DFJdCeMep/BErTJBWnmNPAArQFSBIPhQO1q0zCGhVcnIRINQvHlr3y2stD+DtE04c7pJy9EidOQ6teoYaBuyUL5/Rho7FXW7jpbYda2ssu8txWtn8uZkVmH4Gbt3BDk51JAh3e++IterRe1grjfbKe0ko2qgtcgfVXi4O8HlBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767889; c=relaxed/simple;
	bh=JS95J/RqmqXXixjFAgAMItM/GBDHM1AG+3lAS7w6Cfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGjUWdCV+Bzmrw+D4KOVTAaGet+FjvlOaYIwLyJCyn/qm0ierOIWBUQEgk/dtdeBJVzdWH2FTRfyB4/G1m9R9SkkGkNUBHjGH/xU6X0O6LLTNlvCF7QY9KX2/XN1/M9JU+iVrqvdzd90KMBnu6VOh8S9jl7pW9tU79Ufx2i5IlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fksH5s14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fksH5s14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEE61F00A3A;
	Mon,  7 Sep 2026 07:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788767886;
	bh=W0xr1egxRRUm7sh2JKAxqTOTdyVlZNnwJG1C5Otgx6E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fksH5s14vTWaFTtA5+HH5veOE/pojcNOOUNhwBHVQnR/XMj1DTHnmITpj6SdJZ/L9
	 UbWt48ieJkPLMxJtcvrwxrMENqApuSeMznI8OnqEOZ5TsmRx/vbUOWpKPa1QgJjLWT
	 /ZiUVeI2gPKRbdPsdYQzttCmLGm5c6NQ7PNUMQMXZyuOqWkgzQxXJVdEK9bCrSKMnh
	 5mbvp+mNTSzPghhNilu0IQGBgde6mLs6SXhpK3XuidGov+50LTEPd1Vmi+OULl8sKh
	 cDhEsi7zTHW0IJ5LiVIPMRXur9X0RyNAMchMg+ZCjBwEFYu4ILiE7QSPY37Dh0jfWt
	 /3Mao7QlLGmoQ==
Subject: Re: [PATCH v11 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Mon, 07 Sep 2026 07:58:05 +0000
Message-ID: <178876788524.219967.14761524604287067816@kernel.org>
In-Reply-To: <20260902015500.2985371-1-rkannoth@marvell.com>
References: <20260902015500.2985371-1-rkannoth@marvell.com>
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
issue(s) to consider:

Critical: 0 · High: 4 · Medium: 5 · Low: 0

- [High] The mqprio replace/rollback state machine depends on receiving
  TC_SETUP_ROOT_QDISC/TC_ROOT_GRAFT, but that notification is gated on…
- [High] otx2_mqprio_restart_netdev() calls ndo_stop() and then
  ndo_open(); if ndo_open() fails it sets OTX2_FLAG_INTF_DOWN and calls…
- [High] In otx2_teardown_tc_mqprio(), when otx2_mqprio_down() fails it
  returns early *without* calling otx2_mqprio_clear_sw(), so…
- [High] In otx2_teardown_tc_mqprio(), when the replace-rollback branch
  is taken and otx2_mqprio_restore_old() fails, the function returns…
- [Medium] The commit message claims 'failed setup restores the old
  snapshot' and the driver logs 'mqprio: replace failed; prior…
- [Medium] The driver installs netdev TC state with netdev_set_num_tc() +
  netdev_set_tc_queue() but tears it down with netdev_set_num_tc(netdev,…
- [Medium] otx2_mqprio_up() programs MDQ CIR/PIR with one mailbox
  transaction per TX queue and returns on the first failure without…
- [Medium] otx2_mqprio_mdq_allocated() derives 'MDQ nodes exist' from
  pfvf->hw.txschq_cnt[], but otx2_txschq_stop() only zeroes…
- [Medium] With bandwidth offload active the patch parents every per-
  queue MDQ under a single TL4 (schq_list[NIX_TXSCH_LVL_TL4][0] in…

--

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE, programming per-queue MDQ CIR/PIR through the NIX
TX scheduler mailbox.  The TX scheduler hierarchy is rebuilt by bouncing the
netdev through ndo_stop()/ndo_open() on mqprio add, replace and delete, and
the configuration is tracked in mq_offload_snap snapshots so a failed
replace can be rolled back.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 175992188c18a..5c502c9d7c83f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -615,6 +615,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)
>  }
>  EXPORT_SYMBOL(otx2_get_mac_from_af);
>
> +static int
> +otx2_nix_tmq_reg_write(struct otx2_nic *pfvf, int cnt,
> +		       u64 reg_addr[MAX_REGS_PER_MBOX_MSG],
> +		       u64 reg_val[MAX_REGS_PER_MBOX_MSG])
> +{

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

[Severity: Medium]
Is the txschq_cnt[] loop bound trustworthy after the TX schedulers have been
freed?  otx2_txschq_stop() zeroes txschq_list[][] but leaves txschq_cnt[]
untouched:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:otx2_txschq_stop() {
	...
	/* Clear the txschq list */
	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
			pfvf->hw.txschq_list[lvl][schq] = 0;
	}
	...
}

So otx2_mqprio_mdq_allocated() still returns true for freed nodes, and this
loop then runs txschq_cnt[SMQ] times with smq == 0 every iteration, writing
NIX_AF_MDQX_PIR(0)/NIX_AF_MDQX_CIR(0).  otx2_get_smq_idx() has the same
problem via "qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]" returning index 0
of the zeroed list.

The path reaching this: otx2_mqprio_restart_netdev() -> ndo_open() fails ->
otx2_open() error path -> otx2_free_hw_resources() -> otx2_txschq_stop(), then
back in otx2_setup_tc_mqprio() at "cleanup:" -> otx2_mqprio_restore_old(),
which calls otx2_nix_tm_clear_queue_shaper() with no netif_running() guard
(unlike otx2_mqprio_down()).

Normally the AF rejects schq 0 in is_valid_txschq() (firing the new
dev_err_ratelimited() added by this patch), and the rollback then reports a
self-inflicted "prior configuration rollback failed".  But if schq 0 is mapped
back to this pcifunc as a PFC or HTB SMQ, would that unrelated queue's shaper
be overwritten with the mqprio rate?  Should otx2_txschq_stop() also zero
txschq_cnt[]?

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

[Severity: Medium]
This batch loop aborts on the first mailbox failure, leaving an unknown subset
of MDQ shapers still enabled with no way for the caller to know which.
otx2_mqprio_up() has the same shape - it returns on the first
otx2_nix_tm_set_queue_shaper() failure without undoing the shapers already
accepted by the AF.

Combined with the handling in otx2_open():

	err = otx2_mqprio_up(pf);
	if (err)
		netdev_err(pf->netdev,
			   "mqprio: failed to restore shapers during open: %d; continuing without bandwidth limits\n",
			   err);

the device then enables packet I/O with low-numbered queues shaped and later
queues unshaped, while mqprio.rate_limit, the cached min_rate[]/max_rate[]
and the qdisc's TCA_HW_OFFLOAD state all claim the full configuration is in
force.  Is the message "continuing without bandwidth limits" accurate here,
given limits are partially applied?

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
> +}
> +

[ ... ]

> @@ -651,7 +787,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
>  						(u64)hw->smq_link_type);
>  		req->num_regs++;
>  		/* MDQ config */
> -		parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
> +		if (pfvf->mqprio.rate_limit)
> +			parent = schq_list[NIX_TXSCH_LVL_TL4][0];
> +		else
> +			parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
> +

[Severity: Medium]
Parenting every MDQ under TL4[0] creates what looks like the first multi-child
TL4 in this non-QoS path, but nothing programs the parent's
NIX_AF_TL4X_TOPOLOGY (RR_PRIO / PRIO_ANCHOR).  Each MDQ gets
NIX_AF_MDQX_SCHEDULE with only the DWRR quantum, so PRIO is 0; round-robin
sharing needs the parent's RR_PRIO to be 0 too.

Does the AF guarantee TL4 TOPOLOGY is zero on allocation?  From what I can
see it does not - nix_reset_tx_schedule() only rewrites PARENT and SCHEDULE,
nix_reset_tx_shaping() only CIR/PIR, and the only TOPOLOGY write in
rvu_nix.c is NIX_AF_TL1X_TOPOLOGY.  Meanwhile the HTB path does program TL4
TOPOLOGY with non-zero values:

drivers/net/ethernet/marvell/octeontx2/nic/qos.c:otx2_qos_txschq_set_parent_topology() {
	...
	if (parent->level == NIX_TXSCH_LVL_TL4)
		cfg->reg[0] = NIX_AF_TL4X_TOPOLOGY(parent->schq);
	...
	cfg->regval[0] = (u64)parent->prio_anchor << 32;
	cfg->regval[0] |= ((parent->child_dwrr_prio != OTX2_QOS_DEFAULT_PRIO) ?
			    parent->child_dwrr_prio : 0)  << 1;
	...
}

If a TL4 recycled from a prior HTB hierarchy carries RR_PRIO != 0, would all
the mqprio MDQs become static-priority children anchored at a stale
PRIO_ANCHOR, starving some TX queues despite correct CIR/PIR?

>  		req->reg[1] = NIX_AF_MDQX_PARENT(schq);
>  		req->regval[1] = parent << 16;
>  		req->num_regs++;

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

[Severity: High]
Widening the SMQ request from 1 to hw.non_qos_queues makes reopen failure much
more likely, and the AF rejects the whole request rather than allocating fewer:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:nix_check_txschq_alloc_req() {
	...
	if (free_cnt < req_schq || req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
	    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
		return NIX_AF_ERR_TLX_ALLOC_FAIL;
	...
}

On silicon with hw->cap.nix_fixed_txschq_mapping the reported free_cnt for the
SMQ level is at most 1, so any request > 1 always fails there.  The SMQ pool is
also shared across all PFs/VFs of the NIX block, so exhaustion is a normal
runtime condition.

When that reopen fails, otx2_mqprio_restart_netdev() has already run ndo_stop()
and its error path does:

		pfvf->flags |= OTX2_FLAG_INTF_DOWN;
		/* visible to otx2_stop() on other cpus */
		smp_wmb();
		netif_close(netdev);

netif_close() clears IFF_UP, so an ordinary "tc qdisc add/replace/del dev X
root mqprio" can leave the interface administratively down with connectivity
lost until a manual "ip link set up".  The commit message says only

	"The full stop/open cycle clears carrier, stops all TX queues, tears
	 down IRQs/NAPI and drops in-flight traffic."

and

	"in-flight traffic will be dropped"

Should the commit message also state that a failed mqprio add/replace, or even
a successful delete, can leave the netdev down?

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
Should this snapshot also record qopt->prio_tc_map[]?  The core installs the
new priority mapping right after the driver's setup succeeds:

net/sched/sch_mqprio.c:mqprio_init() {
	...
	/* Always use supplied priority mappings */
	for (i = 0; i < TC_BITMASK + 1; i++)
		netdev_set_prio_tc_map(dev, i, qopt->prio_tc_map[i]);
	...
}

otx2_mqprio_restore_old() then restores only num_tc/count/offset, so a rollback
after that point leaves the new configuration's prio_tc_map in effect over the
old configuration's num_tc and tc_to_txq.  skb_tx_hash() reads
dev->tc_to_txq[netdev_get_prio_tc_map(dev, prio)], so packets can be steered
into ranges that disagree with the MDQ shapers just reprogrammed, or into a tc
with count 0.

Relatedly, otx2_mqprio_clear_sw() tears down with netdev_set_num_tc(netdev, 0)
rather than netdev_reset_tc().  netdev_set_num_tc() only resets XPS and
sb-channels and writes dev->num_tc, so tc_to_txq[] and prio_tc_map[] keep stale
contents on the device.  Would netdev_reset_tc() be the right pairing here?

> +
> +struct otx2_mqprio {
> +	u32	flags;
> +	u64	*min_rate;
> +	u64	*max_rate;
> +	bool	rate_limit;
> +	bool	replace_setup_done;
> +	bool	replace_graft_done;
> +};
> +

[ ... ]

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

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..5efa0b4d27d53 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -1600,14 +1609,706 @@ static int otx2_setup_tc_block(struct net_device *netdev,

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
> +

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
> +		netdev_err(pfvf->netdev,
> +			   "mqprio: failed to clear hardware shapers: %d; some TX queues may retain bandwidth limits\n",
> +			   err);
> +		return err;
> +	}
> +
> +	otx2_mqprio_clear_sw(pfvf);
> +
> +	return 0;
> +}

[Severity: High]
This early return skips otx2_mqprio_clear_sw(), so mqprio.rate_limit stays
true and the rate caches stay populated.  The caller then restarts anyway:

	if (if_up) {
		int down_err, err;

		down_err = otx2_mqprio_down(pfvf);
		err = otx2_mqprio_restart_netdev(netdev, false);

and otx2_mqprio_restart_netdev() only ever sets rate_limit, never clears it.
So ndo_open() sees rate_limit == true and:

  - otx2_txsch_alloc() re-requests the wide mqprio SMQ hierarchy
  - otx2_txschq_config() re-parents every MDQ under TL4[0]
  - otx2_open() -> otx2_mqprio_up() re-programs every cached MDQ shaper

Meanwhile the qdisc goes away regardless, because mqprio_disable_offload()
discards the driver's return value:

net/sched/sch_mqprio.c:mqprio_disable_offload() {
	...
	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
				      &mqprio);
	...
}

Does that leave the offload latched on with no qdisc behind it - dev->num_tc
still populated, and the new rate_limit gates in otx2_set_channels(),
otx2_xdp_setup() and otx2_dcbnl_ieee_setpfc() refusing those operations until
the driver is unbound?  Should the software state be cleared even when the
shaper clear fails?

> +
> +int otx2_mqprio_up(struct otx2_nic *pfvf)
> +{

[ ... ]

> +	for (txq = 0; txq < pfvf->hw.non_qos_queues; txq++) {

[ ... ]

> +		err = otx2_nix_tm_set_queue_shaper(pfvf, txq, min_rate,
> +						   max_rate);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "mqprio: failed to restore shaper for txq %d: %d\n",
> +				   txq, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		if (pfvf->mqprio.replace_graft_done) {
> +			otx2_mqprio_snap_commit(pfvf);
> +		} else {
> +			err = otx2_mqprio_restore_old(pfvf);
> +			if (err)
> +				return err;
> +		}
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		return 0;
> +	}

[Severity: High]
When otx2_mqprio_restore_old() fails, this "if (err) return err;" bypasses
otx2_mqprio_clear_replace_state() and never frees pfvf->cur_mq_snap.
replace_setup_done stays true and cur_mq_snap stays non-NULL, so does every
later teardown - including a genuine "tc qdisc del" - re-enter this branch
instead of tearing the offload down?  rate_limit, the devm min_rate/max_rate
caches, the netdev TC mapping and the hardware MDQ shapers would then only be
released at device remove.

otx2_mqprio_restore_old() can fail from otx2_mqprio_alloc_cache() (-ENOMEM),
otx2_nix_tm_clear_queue_shaper() or otx2_mqprio_up() (mailbox errors).

The "cleanup:" label in otx2_setup_tc_mqprio() calls
otx2_mqprio_clear_replace_state() before inspecting restore_err; would the
same ordering work here?

[Severity: High]
Is the replace_graft_done signal ever delivered in the default configuration?
qdisc_offload_graft_helper() is gated on tc_can_offload():

net/sched/sch_api.c:qdisc_offload_graft_helper() {
	...
	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
		return;
	...
}

tc_can_offload() tests dev->features & NETIF_F_HW_TC, but otx2_probe() adds
that bit to hw_features only after the last features assignment:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_probe() {
	...
	netdev->features |= netdev->hw_features;
	...
	/* HW supports tc offload but mutually exclusive with n-tuple filters */
	if (pf->flags & OTX2_FLAG_TC_FLOWER_SUPPORT)
		netdev->hw_features |= NETIF_F_HW_TC;
	...
}

so hw-tc-offload is off in dev->features by default (otx2_vf.c has the same
ordering).  The mqprio offload itself has no such gate - mqprio_enable_offload()
calls ndo_setup_tc() unconditionally.

With that, otx2_setup_tc_root() is never invoked, replace_graft_done stays
false, and a *successful* "tc qdisc replace dev X root mqprio ... hw 1" over an
already-offloaded mqprio takes the else branch above and calls
otx2_mqprio_restore_old().  Would that silently revert the hardware MDQ CIR/PIR
values and the netdev TC layout to the previous configuration while the new
qdisc is live and userspace was told the replace succeeded?

The commit message states:

	"successful graft is recorded through TC_ROOT_GRAFT"

Can that mechanism work without NETIF_F_HW_TC enabled?

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

[ ... ]

> +static int otx2_setup_tc_mqprio(struct net_device *netdev,
> +				struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +cleanup:
> +	qopt->hw = 0;
> +	if (replacing) {
> +		int restore_err = otx2_mqprio_restore_old(pfvf);
> +
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		if (restore_err) {
> +			netdev_err(netdev,
> +				   "mqprio: replace failed and prior configuration rollback failed: %d\n",
> +				   restore_err);

[Severity: Medium]
Does the netdev TC layout restored here actually survive?  Returning an error
from otx2_setup_tc_mqprio() makes mqprio_enable_offload() return before setting
priv->hw_offload, mqprio_init() fails, and qdisc_create() still runs destroy:

net/sched/sch_api.c:qdisc_create() {
	...
err_out4:
	/* Even if ops->init() failed, we call ops->destroy()
	 * like qdisc_create_dflt().
	 */
	if (ops->destroy)
		ops->destroy(sch);
	...
}

net/sched/sch_mqprio.c:mqprio_destroy() {
	...
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
	...
}

With hw_offload == 0 the else branch runs, so the netdev_set_num_tc() and
netdev_set_tc_queue() calls that otx2_mqprio_restore_old() just made are wiped.
The old, still-grafted mqprio qdisc keeps reporting its TCs and the restored
per-queue MDQ shapers stay programmed, but dev->num_tc becomes 0 - so TX queue
selection stops honouring the TC ranges while per-queue rate limits remain in
force.

The commit message says "failed setup restores the old snapshot" and the log
says "prior configuration restored".  Is that accurate for the netdev TC part?

> +			if (extack)
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "mqprio: replace failed and prior configuration rollback failed: %d",
> +						       restore_err);
> +		} else {
> +			netdev_err(netdev,
> +				   "mqprio: replace failed; prior configuration restored\n");

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

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902015500.2985371-1-rkannoth%40marvell.com
