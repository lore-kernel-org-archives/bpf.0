Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125225CC79;
	Sat, 12 Sep 2026 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789175036; cv=none; b=oPoAFGTd39FJiqWP2s0K5vDM6VbAbzKVp/gExNDRw52XEqTr44L/qtLaPT5qwxI3+LOmA/mR+jtoh0ap8aM/dYaGY7jeXckkcaVBV8xvZLDtiW91G/iicbCORiZYNn8gvqeWwUexUxYM1V87Qpy1ndY+qvxUjDFBNpqJZusIFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789175036; c=relaxed/simple;
	bh=SzV4R6abWUlCEgmA6bDuW/WvPQYrJktEavBBoDd+zKY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDBnNEuHTmlLOghwGlDHFcLaYMjeIPJELy42uCvIdTAPLC/TN5DpbPQkpje9tAqFfg3+nXmO97MSFrz+ZQhx9GbMGcqoinoH7QG/1QYyfbuxLI74+BLmxIDKZ01ErXduEVSXSXGrmTGB0jSQYTGXbpNzQ8eXhffOT/30C4bievw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tih1SEZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tih1SEZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0131F000FF;
	Sat, 12 Sep 2026 01:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789175034;
	bh=kVoZbZquZsDUnqENDu8hpM4MhPdRTqpQyP1gH83w+h4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tih1SEZr2tQhfxrVjIUOV8iGqgJ4IQpzLj23ygtC+Q1TAQq4OMdC7hDtJtXXIZ+NF
	 cp3vCfbNxfUzj4xa+ZgEmXQO+qYofdteCeOORYkeSI4jPmP4KXxVE+nx4CPjlDQgpX
	 IT8jMZUm3Kb9UQsCblj3KBJtxqet3QFaXGzeOAe39j6bYoJhZtJwddbeMX4OAPrlP0
	 SLp3GkCOgS6kG5ta/9eWljfG4DgA7VspobQtyawe5LkqUWnuB5qTRmdJ5wWeGwAk1W
	 3Dy28LXFTr/GKusVRO062QbuJ4gQ3k2UNxeCH8DVcR/hBdZsvVhfbXEo5c2Seed08/
	 ov5p1iW4cNyXQ==
Subject: Re: [PATCH v14 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com, cursoragent@cursor.com
Date: Sat, 12 Sep 2026 01:03:52 +0000
Message-ID: <178917503269.219967.2398157169238372750@kernel.org>
In-Reply-To: <20260908062437.251739-1-rkannoth@marvell.com>
References: <20260908062437.251739-1-rkannoth@marvell.com>
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

Critical: 0 · High: 4 (1) · Medium: 4 · Low: 0

- [High] otx2_mqprio_down() returns -errno on a mailbox failure while
  clearing MDQ shapers and deliberately skips otx2_mqprio_clear_sw();…
- [High] The mqprio replace-commit path depends on the driver receiving
  TC_SETUP_ROOT_QDISC/TC_ROOT_GRAFT, but qdisc_offload_graft_helper()…
- [High] The driver writes netdev_set_num_tc()/netdev_set_tc_queue() from
  its own rollback and teardown paths while the TC core mutates the same…
- [High] The patch converts only three write sites of the u64 pf->flags
  word to atomic bit operations (OTX2_FLAG_PORT_UP in the asynchronous…
- [Medium] otx2_txschq_stop() now zeroes pfvf->hw.txschq_cnt[lvl] for
  every level.
- [Medium] otx2_mqprio_restore_old() calls otx2_mqprio_alloc_cache(pfvf,
  false), and with replacing==false that helper first calls…
- [Medium] otx2_mqprio_restart_netdev() open-codes part of
  __dev_close_many(): it clears __LINK_STATE_START, issues…
- [Medium] With mqprio bandwidth offload the driver now parents N MDQ/SMQ
  nodes under a single TL4 node (otx2_txschq_config(): `if…

Pre-existing issues:
- [High] pfvf->refill_wrk is devm_kcalloc()'d and its delayed works
  INIT_DELAYED_WORK()'d in otx2_config_nix_queues()…

--

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE, programming per-queue MDQ CIR/PIR through the NIX
TX scheduler mailbox.  Because the TX scheduler hierarchy cannot be
reprogrammed live, every mqprio add/replace/delete bounces the netdev
through ndo_stop()/ndo_open().  Configuration is tracked in
mq_offload_snap snapshots so a failed replace can be rolled back.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 175992188c18a..a519e0a97a2b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

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
>  		req->reg[1] = NIX_AF_MDQX_PARENT(schq);
>  		req->regval[1] = parent << 16;
>  		req->num_regs++;

[Severity: Medium]

Who programs the arbitration configuration of TL4[0] once N MDQs are
parented under it?

This path writes only TL4X_PARENT/TL4X_SCHEDULE for the parent and
MDQX_SCHEDULE = dwrr_val for each child (PRIO field 0).  Grepping the tree,
NIX_AF_TL4X_TOPOLOGY is never written by the AF driver, and in the PF driver
it is written only by the HTB code:

  qos.c:otx2_qos_txschq_set_parent_topology() {
      ...
      cfg->reg[0] = NIX_AF_TL4X_TOPOLOGY(parent->schq);
      cfg->regval[0] = (u64)parent->prio_anchor << 32 | ... child_dwrr_prio << 1;
      ...
  }

So for the mqprio hierarchy, TL4[0]'s PRIO_ANCHOR/RR_PRIO is whatever the
register happens to hold - the reset value, or a stale value left behind by a
previously destroyed HTB tree on the same TL4 index, since the AF free path
resets only link cfg, shaping and schedule registers.

If the stale RR_PRIO does not match the children's PRIO of 0, are the MDQs
arbitrated as static-priority children instead of a DWRR group, starving all
but one queue?  A sequence like "configure HTB, delete HTB, then enable
mqprio bw_rlimit" would reuse that TL4 with the previous arbitration
configuration.

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
> @@ -844,6 +987,7 @@ void otx2_txschq_stop(struct otx2_nic *pfvf)
>  
>  	/* Clear the txschq list */
>  	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
> +		pfvf->hw.txschq_cnt[lvl] = 0;
>  		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
>  			pfvf->hw.txschq_list[lvl][schq] = 0;
>  	}

[Severity: Medium]

Does zeroing txschq_cnt[] here create a modulo-by-zero for the existing
consumer in otx2_get_smq_idx()?

  otx2_common.h:otx2_get_smq_idx() {
      ...
      idx = qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ];
      smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][idx];
      ...
  }

Before this hunk the count retained its last non-zero value once the
interface had been opened; now it reads back as 0 after every stop.

The reachable non-mqprio consumer is the dcbnl path, which is not gated on
netif_running():

  otx2_pfc_txschq_update() -> update_sq_smq_map label
      -> otx2_pfc_update_sq_smq_mapping()
             cn10k_sq_aq->sq.smq = otx2_get_smq_idx(pfvf, prio);

So: bring the interface up, enable PFC, "ip link set dev ethX down", then
disable PFC.  On arm64 UDIV returns 0 rather than trapping, so the result is
idx 0 and smq = txschq_list[SMQ][0] == 0, i.e. the driver programs an SQ
context with a scheduler queue it does not own - which is exactly what the
new AF is_valid_txschq() message reports - and the otx2_sync_mbox_msg()
return value there is not checked.  On architectures where integer division
traps this would be a divide error instead.

The new mqprio code guards against the zero count itself (via
otx2_mqprio_mdq_allocated() and "else if (txschq_cnt[SMQ])"); should this
pre-existing consumer get the same guard?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index c0e2100de1d93..68ad2f3d22277 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -907,11 +907,13 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
>  
>  	if (info->event == RVU_EVENT_PORT_STATE) {
>  		if (info->evt_data.port_state) {
> -			pf->flags |= OTX2_FLAG_PORT_UP;
> +			set_bit(__builtin_ctzll(OTX2_FLAG_PORT_UP),
> +				(unsigned long *)&pf->flags);
>  			netif_carrier_on(netdev);
>  			netif_tx_start_all_queues(netdev);
>  		} else {
> -			pf->flags &= ~OTX2_FLAG_PORT_UP;
> +			clear_bit(__builtin_ctzll(OTX2_FLAG_PORT_UP),
> +				  (unsigned long *)&pf->flags);
>  			netif_tx_stop_all_queues(netdev);
>  			netif_carrier_off(netdev);
>  		}

[Severity: High]

The commit message says:

  "Use atomic bit operations when updating OTX2_FLAG_PORT_UP and
   OTX2_FLAG_INTF_DOWN on asynchronous and netdev-restart paths."

Does converting only some writers of pf->flags actually close the race?

The same u64 word is still updated with plain read-modify-write elsewhere in
otx2_open():

  pf->flags &= ~OTX2_FLAG_INTF_DOWN;
  pf->flags &= ~OTX2_FLAG_PORT_UP;

and on its error path:

  pf->flags |= OTX2_FLAG_INTF_DOWN;

with the same pattern in otx2_vf.c, rep.c and otx2_ethtool.c.

Atomic bitops give no protection against a concurrent non-atomic RMW on the
same word.  This handler runs from the mbox workqueue without RTNL, so can
its set_bit(PORT_UP) + netif_tx_start_all_queues() (or the clear_bit path) be
erased by a concurrent otx2_open() store on another CPU, leaving PORT_UP
inconsistent with the actual carrier and queue state?  The same applies to
INTF_DOWN, which gates the driver's fast-path teardown checks.

Would converting pf->flags to unsigned long / DECLARE_BITMAP and switching
all writers (or taking a lock) be a better fit than mixing the two access
styles?

> @@ -2007,6 +2009,14 @@ int otx2_open(struct net_device *netdev)
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
> @@ -2205,6 +2215,7 @@ int otx2_open(struct net_device *netdev)
>  	free_irq(vec, pf);
>  err_disable_napi:
>  	otx2_disable_napi(pf);
> +err_free_hw:
>  	otx2_free_hw_resources(pf);
>  err_free_mem:
>  	otx2_free_queue_mem(qset);

[Severity: High]

This isn't a bug introduced by this patch, but does the new error path make
the refill_wrk leak reachable much more often?

pf->refill_wrk is devm_kcalloc()'d and its delayed works initialized in
otx2_config_nix_queues(), reached from otx2_init_hw_resources():

  otx2_common.c:otx2_config_nix_queues() {
      pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
                                      sizeof(struct refill_work), GFP_KERNEL);
      ...
  }

The only cancel/free site is otx2_stop():

  for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
          cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
  devm_kfree(pf->dev, pf->refill_wrk);

None of otx2_open()'s error labels, including the new err_free_hw, cancel
those delayed works or free the array.  And otx2_mqprio_restart_netdev()
deliberately marks the interface down before netif_close():

  set_bit(__builtin_ctzll(OTX2_FLAG_INTF_DOWN),
          (unsigned long *)&pfvf->flags);
  smp_wmb();
  netif_close(netdev);

so otx2_stop() returns immediately at its "if (pf->flags &
OTX2_FLAG_INTF_DOWN) return 0;" check and the cleanup never runs.

Does each failed open therefore leak one refill_wrk devres block and leave
initialized (possibly already queued) delayed works behind?  Their handler
does:

  qidx = wrk - pfvf->refill_wrk;
  cq = &pfvf->qset.cq[qidx];

after otx2_free_queue_mem() freed qset->cq.  The new synchronize_net() in
otx2_stop() does not help here because otx2_stop() is skipped by design.
This is now repeatable via "tc qdisc add/replace/del ... mqprio".

> @@ -2226,7 +2237,8 @@ int otx2_stop(struct net_device *netdev)
>  	netif_carrier_off(netdev);
>  	netif_tx_stop_all_queues(netdev);
>  
> -	pf->flags |= OTX2_FLAG_INTF_DOWN;
> +	set_bit(__builtin_ctzll(OTX2_FLAG_INTF_DOWN),
> +		(unsigned long *)&pf->flags);
>  	/* 'intf_down' may be checked on any cpu */
>  	smp_wmb();

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..045b4573ce14e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

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

Should the rollback path pass replacing == true here?

With replacing == false, otx2_mqprio_alloc_cache() first calls
otx2_mqprio_free_cache(), which devm_kfree()s and NULLs the currently live
min_rate/max_rate arrays, and only then attempts the two devm_kcalloc()s.  If
either allocation fails it frees again and returns -ENOMEM, leaving both
caches NULL while mqprio.rate_limit is still true.

restore_old() returns that error without reconciling the state, and
otx2_mqprio_up() begins with:

  if (!pfvf->mqprio.min_rate || !pfvf->mqprio.max_rate)
          return 0;

so every subsequent ndo_open() programs no MDQ CIR/PIR while the driver still
reports the offload as active and keeps rejecting PFC/XDP/HTB and channel
changes.  The arrays are already the required size at this point, so the
reuse+memset path in the same helper would avoid destroying live state.

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
> +
> +	netdev_set_num_tc(netdev, snap->num_tc);
> +	for (tc = 0; tc < snap->num_tc; tc++)
> +		netdev_set_tc_queue(netdev, tc, snap->count[tc],
> +				    snap->offset[tc]);

[Severity: High]

Does this restore survive the caller?

On a failed replace the error propagates back to qdisc_create()'s
init-failure path, which calls mqprio_destroy() on the new instance with
priv->hw_offload still 0 (mqprio_enable_offload() assigns it only on
success):

  net/sched/sch_mqprio.c:mqprio_destroy() {
      if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
              mqprio_disable_offload(sch);
      else
              netdev_set_num_tc(dev, 0);
      ...
  }

So num_tc, tc_to_txq[] and prio_tc_map[] are zeroed right after this function
restored them, while the old offloaded mqprio is still root and
mqprio.rate_limit is still true with MDQ shapers programmed.

Also, netdev_set_num_tc() memsets prio_tc_map[], and nothing here restores
it - is the priority-to-TC mapping lost even when the restore does stick?

> +
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			return err;
> +	}

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

[Severity: High]

Can this zero the TC mapping of a qdisc that was just created?

Consider replacing an offloaded mqprio with a software one:

  tc qdisc add     dev ethX root mqprio hw 1 mode channel shaper bw_rlimit ...
  tc qdisc replace dev ethX root mqprio hw 0 num_tc N ...

mqprio_init() installs the new mapping first:

  net/sched/sch_mqprio.c:mqprio_init() {
      netdev_set_num_tc(dev, qopt->num_tc);
      for (i = 0; i < qopt->num_tc; i++)
              netdev_set_tc_queue(dev, i, qopt->count[i], qopt->offset[i]);
      ...
  }

Then the old offloaded instance is destroyed, reaching
otx2_teardown_tc_mqprio() -> otx2_mqprio_down() / otx2_mqprio_restart_netdev(false),
both of which call otx2_mqprio_clear_sw() and its unconditional
netdev_set_num_tc(netdev, 0).

Does the live software mqprio then run with dev->num_tc == 0, so
netdev_pick_tx()/skb_tx_hash() no longer confine traffic to each traffic
class's queue range, and dumps report num_tc 0?

> +
> +/* Tear down mqprio bandwidth offload: clear per-queue shapers,
> + * mqprio_rate_limit, netdev TC mappings, and the cached rates.  Called on
> + * explicit mqprio teardown (tc qdisc del) and error cleanup, not on
> + * routine netdev stop/open cycles where the offload stays active.
> + */
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
> +			   "mqprio: failed to clear hardware shapers: %d\n",
> +			   err);
> +		return err;
> +	}
> +
> +	otx2_mqprio_clear_sw(pfvf);
> +
> +	return 0;
> +}

[Severity: High]

The v14 changelog says:

  "Return an error from otx2_mqprio_down() if clearing hardware shapers
   fails instead of clearing software state anyway."

Can this error reach anybody who acts on it?

The teardown during qdisc destruction comes from:

  net/sched/sch_mqprio.c:mqprio_disable_offload() {
      ...
      dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
                                    &mqprio);
  }

The return value is discarded there, and mqprio_destroy() is void, so the
qdisc is destroyed regardless.

Meanwhile the driver keeps mqprio.rate_limit == true, netdev num_tc != 0 and
the cached rate arrays, because otx2_mqprio_clear_sw() was skipped.  From
then on:

  - otx2_qos_root_add() rejects HTB
  - otx2_xdp_setup() rejects XDP
  - otx2_dcbnl_ieee_setpfc() rejects PFC
  - otx2_set_channels() rejects channel changes
  - otx2_txsch_alloc() keeps widening the SMQ allocation
  - otx2_mqprio_up() re-applies the stale rates on every ndo_open()

and the qdisc instance is gone, so there is no user-visible path left to
clear it.  otx2_sync_mbox_msg() can fail on an AF timeout, which is why the
check exists.  Would clearing the software state unconditionally (or
recovering locally) be safer than returning an error nobody reads?

> +
> +int otx2_mqprio_up(struct otx2_nic *pfvf)
> +{

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

[Severity: Medium]

This open-codes part of __dev_close_many() but leaves out
netpoll_poll_disable()/netpoll_poll_enable() (and the NETDEV_GOING_DOWN
notification).  Is that safe when netpoll is attached?

netpoll_poll_dev() is serialized only by ni->dev_lock plus a netif_running()
check:

  net/core/netpoll.c:netpoll_poll_dev() {
      if (!ni || down_trylock(&ni->dev_lock))
              return;
      ...
      if (!netif_running(dev) || netif_local_xmit_active(dev)) {
              up(&ni->dev_lock);
              return;
      }
      ...
      poll_napi(dev);
  }

A poll that passed that netif_running() check just before the clear_bit()
above can then run concurrently with otx2_stop()'s
napi_disable()/netif_napi_del() and otx2_free_queue_mem(), which frees the
qset->napi array holding those NAPI structs.  With netconsole bound to ethX,
could a printk during "tc qdisc add/replace/del ... mqprio" touch freed NAPI
state?

The transmit side looks covered: __netpoll_send_skb() and queue_process()
both re-check netif_running(), and the bit is cleared before dev_deactivate().

> +	if (err) {
> +		if (running) {
> +			set_bit(__LINK_STATE_START, &netdev->state);
> +			dev_activate(netdev);
> +		}
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

Is this callback ever invoked for otx2 netdevs in the default configuration?

  net/sched/sch_api.c:qdisc_offload_graft_helper() {
      if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
              return;
      ...
  }

tc_can_offload() tests dev->features & NETIF_F_HW_TC, and otx2 adds that bit
to hw_features only after features was derived from hw_features:

  otx2_pf.c:otx2_probe() {
      ...
      netdev->features |= netdev->hw_features;
      ...
      if (pf->flags & OTX2_FLAG_TC_FLOWER_SUPPORT)
              netdev->hw_features |= NETIF_F_HW_TC;
      ...
  }

otx2_vf.c has the same ordering, so dev->features lacks NETIF_F_HW_TC unless
the user turns hw-tc-offload on.

mqprio_enable_offload()/mqprio_disable_offload() are not gated by
tc_can_offload(), so the driver's setup and teardown callbacks still run.
Does that mean a successful "tc qdisc replace ... mqprio hw 1 mode channel
shaper bw_rlimit" over an already-offloaded mqprio leaves
replace_setup_done == true and replace_graft_done == false, so the old
instance's teardown takes the rollback branch in otx2_teardown_tc_mqprio():

  if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
          err = 0;
          if (pfvf->mqprio.replace_graft_done)
                  otx2_mqprio_snap_commit(pfvf);
          else
                  err = otx2_mqprio_restore_old(pfvf);

and otx2_mqprio_restore_old() reprograms the previous rates and TC layout
while the kernel keeps the new mqprio qdisc installed and reports hw offload
success?  The user's new rates would then never be applied, and the error is
discarded because mqprio_destroy() is void.

Would driving the commit from the mqprio teardown itself, rather than from a
graft notification the core may never deliver, avoid depending on
NETIF_F_HW_TC being enabled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908062437.251739-1-rkannoth%40marvell.com
