Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068B5B206;
	Sun, 27 Sep 2026 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483263; cv=none; b=OJENh1oA7oNyvJZ9PUXEChkyxyFp1RBJZ9cOzzPZYzR7o5EDfU9bZ18OpouOy3aukHBGE2LNKA0JorzO496ZN4EaVFPcAVvVYZLRnaIk/pFNmdJjvinhRfD4s+u55O+ekdmXVKwaFTDIgokB/uf6CGydM/wfJDHfHN9T32kr38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483263; c=relaxed/simple;
	bh=eznP2ZVsDBqqiWEUKfnr4lrOhH7KzyoIYViEwtD/2Ww=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdyKPX4A0ssZLkRTDE73OOT242qlU+dgD+5i323E6u3dqehU+IyYtItTT0aleepKTsqxLXky6Wp5XDhSUUlyHn3q7WvTQ0riwEEqBQS1xeB7ZWEoePktSf3upzoIuZAG5iEjC4xpd7RlIE3Nl83aSvmiZrloMaunj5TE4BRtj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07E01F00898;
	Sun, 27 Sep 2026 04:27:40 +0000 (UTC)
Subject: Re: [PATCH v17 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Sun, 27 Sep 2026 04:27:40 +0000
Message-ID: <179048326032.2160803.2429626279202965081@kernel.org>
In-Reply-To: <20260923032217.1732753-2-rkannoth@marvell.com>
References: <20260923032217.1732753-2-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (4) · Medium: 1 (4) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch says it moves every flag writer to atomic
  set_bit()/clear_bit(), but its only new cross-context writer,…
- [Medium] The patch is presented as a mechanical conversion to atomic
  bitops, but it also silently fixes a real bug in the representor TC…
- [Low] The new comment on OTX2_REP_SYNC_FLAGS_MASK
  (otx2_common.h:511-512) says only…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  rvu_rep_mcam_flow_init() (rep.c:35-104) sends mailbox messages with…
- [High] This problem wasn't introduced by this patch, but
  rvu_rep_destroy() only does kfree(rep->flow_cfg).
- [High] This problem wasn't introduced by this patch, but
  rvu_rep_get_stats64() (rep.c:397) queues rep->stats_wrk with a 100ms…
- [High] This problem wasn't introduced by this patch, but in
  rvu_rep_destroy() rep is netdev_priv() of a netdev allocated with…
- [Medium] This problem wasn't introduced by this patch, but
  rvu_rep_setup_tc_cb() calls rvu_rep_mcam_flow_init() whenever…
- [Medium] This problem wasn't introduced by this patch, but
  otx2_tc_del_flow() (otx2_tc.c:1196-1198) clears…
- [Medium] This problem wasn't introduced by this patch, but in
  otx2_config_hwtstamp_set() only the HWTSTAMP_TX_OFF case clears…
- [Medium] This problem wasn't introduced by this patch, but the
  representor flow_cfg is kzalloc'd in rvu_rep_mcam_flow_init(), and…

--

octeontx2: use atomic bitops for PF/VF and rep flags

This commit converts the otx2_nic and rep_dev flags from u64 masks to
unsigned long bitmaps accessed with set_bit(), clear_bit() and test_bit()
helpers. It adds otx2_sync_flags_from_rep(), which copies a masked set of
representor flags onto the shared PF context. It also moves the
representor VF initialized flag to OTX2_FLAG_REP_VF_INITIALIZED.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 5850bc1870a1d..b146ca4be5db1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -482,6 +482,41 @@ struct pf_irq_data {

[ ... ]

> +	OTX2_FLAG_REP_VF_INITIALIZED,
> +	OTX2_FLAG_MAX,
> +};
> +
> +/* Representor-owned flags copied onto the PF mailbox context in
> + * rvu_rep_setup_tc_cb().  All other bits are owned by the PF/VF netdev.
> + */
> +#define OTX2_REP_SYNC_FLAGS_MASK				\
> +	(BIT(OTX2_FLAG_MCAM_ENTRIES_ALLOC) |			\
> +	 BIT(OTX2_FLAG_NTUPLE_SUPPORT) |			\
> +	 BIT(OTX2_FLAG_TC_FLOWER_SUPPORT) |			\
> +	 BIT(OTX2_FLAG_REP_VF_INITIALIZED))

[Severity: Low]
Is this ownership description accurate for OTX2_FLAG_TC_MARK_ENABLED?

The representor tc path is rvu_rep_setup_tc_cb()->otx2_setup_tc_cls_flower(priv).
Along that path, otx2_tc_parse_actions() sets the bit on the shared priv
and otx2_tc_del_flow() clears it. Both decisions depend on the
representor's own flow_cfg->mark_flows, because of:

	priv->flow_cfg = rep->flow_cfg;

The bit is not in OTX2_REP_SYNC_FLAGS_MASK and never appears in
rep->flags, so it now carries over from one representor to the next. A
mark rule delete on one representor can then turn off skb->mark delivery
in otx2_rcv_pkt_handler() for mark rules that remain on another
representor.

[ ... ]

> @@ -593,6 +607,32 @@ struct otx2_nic {
>  	unsigned long		*af_xdp_zc_qidx;
>  };

[ ... ]

> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned long src = READ_ONCE(*src_flags);
> +	unsigned long new_flags;
> +
> +	new_flags = (READ_ONCE(dst->flags) & ~OTX2_REP_SYNC_FLAGS_MASK) |
> +		    (src & OTX2_REP_SYNC_FLAGS_MASK);
> +	WRITE_ONCE(dst->flags, new_flags);
> +}

[Severity: High]
The commit moves the flag writers to atomic bitops, but this helper
reads, modifies and writes the whole word non-atomically. Can a
concurrent set_bit() or clear_bit() on a PF-owned bit get lost here?

rvu_rep_setup_tc_cb() holds only rtnl. The devlink eswitch mode path
holds the devlink instance lock but not rtnl. rvu_rep_destroy() does:

	rvu_eswitch_config(priv, false);
	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
	rvu_rep_free_cq_rsrc(priv);
	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
		...
		unregister_netdev(rep->netdev);

The representor netdevs are still registered at the point where
INTF_DOWN is set, so they can still receive tc callbacks:

CPU1 (tc flower on representor)     CPU2 (eswitch mode legacy)
otx2_sync_flags_from_rep()
  READ_ONCE(dst->flags)  /* INTF_DOWN=0 */
                                    rvu_rep_destroy()
                                      otx2_set_flag(priv, INTF_DOWN)
  WRITE_ONCE(dst->flags, new_flags)
                         /* INTF_DOWN=0 again */

If INTF_DOWN is lost, otx2_napi_handler() may re-enable CQ interrupts
through NIX_LF_CINTX_ENA_W1S while rvu_rep_free_cq_rsrc() is tearing them
down. Later, rvu_rep_remove() does:

	if (!otx2_test_flag(priv, OTX2_FLAG_INTF_DOWN))
		rvu_rep_destroy(priv);

Would that run rvu_rep_destroy() a second time on the already freed
priv->reps, representor netdevs and napi array?

The opposite interleaving is also possible. A sync racing with the
otx2_clear_flag(priv, OTX2_FLAG_INTF_DOWN) in rvu_rep_napi_init() could
write back a stale INTF_DOWN=1.

Would copying each masked bit with assign_bit(), or using a cmpxchg loop,
avoid this?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index c0e2100de1d93..32582b6347ea4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -2537,8 +2537,8 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
>  
>  	switch (config->tx_type) {
>  	case HWTSTAMP_TX_OFF:
> -		if (pfvf->flags & OTX2_FLAG_PTP_ONESTEP_SYNC)
> -			pfvf->flags &= ~OTX2_FLAG_PTP_ONESTEP_SYNC;
> +		if (otx2_test_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC))
> +			otx2_clear_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
>  
>  		cancel_delayed_work(&pfvf->ptp->synctstamp_work);
>  		otx2_config_hw_tx_tstamp(pfvf, false);
> @@ -2549,7 +2549,7 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
>  					   "One-step time stamping is not supported");
>  			return -ERANGE;
>  		}
> -		pfvf->flags |= OTX2_FLAG_PTP_ONESTEP_SYNC;
> +		otx2_set_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
>  		schedule_delayed_work(&pfvf->ptp->synctstamp_work,
>  				      msecs_to_jiffies(500));
>  		fallthrough;

[Severity: Medium]
This isn't a bug introduced by this patch, but only the HWTSTAMP_TX_OFF
case clears OTX2_FLAG_PTP_ONESTEP_SYNC and cancels synctstamp_work.

If the user switches directly from HWTSTAMP_TX_ONESTEP_SYNC to
HWTSTAMP_TX_ON, does the one-step flag stay set?

If it does, otx2_set_txtstamp() keeps taking the one-step branch for PTP
Sync packets and never sets SKBTX_IN_PROGRESS. otx2_snd_pkt_handler() then
never calls skb_tstamp_tx(), so the two-step TX timestamp is never
delivered.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..ddb46b580c3b6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -505,7 +505,7 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
>  			mark = act->mark;
>  			req->match_id = mark & OTX2_RX_MATCH_ID_MASK;
>  			req->op = NIX_RX_ACTION_DEFAULT;
> -			nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
> +			otx2_set_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
>  			refcount_inc(&nic->flow_cfg->mark_flows);
>  			break;

[Severity: Medium]
This isn't a bug introduced by this patch, but for representors
nic->flow_cfg is the kzalloc'd rep->flow_cfg from
rvu_rep_mcam_flow_init(). mark_flows is never set with refcount_set()
there. Only otx2_mcam_entry_init() does that, and only on the PF path.

Does refcount_inc() on 0 here trigger the refcount_warn_saturate()
"addition on 0; use-after-free" warning and saturate the counter?

Once the counter is saturated, every later mark rule delete on the
representor clears TC_MARK_ENABLED.

[ ... ]

> @@ -1195,12 +1195,12 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  	/* Disable TC MARK flag if they are no rules with skbedit mark action */
>  	if (flow_node->req.match_id)
>  		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
> -			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
> +			otx2_clear_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);

[Severity: Medium]
This is a pre-existing issue, but is this condition inverted?

On the PF, mark_flows starts at 1 in otx2_mcam_entry_init() and each mark
rule increments it. With two mark rules installed the count is 3.
Deleting one rule leaves 2, so refcount_dec_and_test() returns false and
the flag is cleared.

otx2_rcv_pkt_handler() then stops setting skb->mark for the rule that is
still installed.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7a..7df82c22cc12b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -93,9 +93,9 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
>  	rep->flow_cfg->max_flows = allocated;
>  
>  	if (allocated) {
> -		rep->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
> -		rep->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
> -		rep->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
> +		set_bit(OTX2_FLAG_MCAM_ENTRIES_ALLOC, &rep->flags);
> +		set_bit(OTX2_FLAG_NTUPLE_SUPPORT, &rep->flags);
> +		set_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags);
>  	}

[Severity: High]
This is a pre-existing issue, but rvu_rep_mcam_flow_init() sends mailbox
messages without taking priv->mbox.lock. It calls
otx2_mbox_alloc_msg_npc_mcam_alloc_entry(), otx2_sync_mbox_msg() and
otx2_mbox_get_rsp(), and then unlocks at the exit label:

exit:
	...
	mutex_unlock(&priv->mbox.lock);

Neither this function nor its caller rvu_rep_setup_tc_cb() takes the
lock.

Can this release a mutex held by another mbox user, such as the
rvu_rep_get_stats() delayed work? Can it also let the mailbox buffers be
used by two tasks at once?

> @@ -109,14 +109,14 @@ static int rvu_rep_setup_tc_cb(enum tc_setup_type type,
>  	struct rep_dev *rep = cb_priv;
>  	struct otx2_nic *priv = rep->mdev;
>  
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
>  		return -EINVAL;
>  
> -	if (!(rep->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
> +	if (!test_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags))
>  		rvu_rep_mcam_flow_init(rep);

[Severity: Medium]
This isn't a bug introduced by this patch, but the return value of
rvu_rep_mcam_flow_init() is ignored here. That function also
unconditionally does:

	rep->flow_cfg = kzalloc_objs(struct otx2_flow_config, 1);

If the MCAM allocation returns 0 entries, TC_FLOWER_SUPPORT stays clear.
Does every later tc callback then leak the previous flow_cfg and its
flow_ent array?

If the flow_ent kcalloc() fails, the function returns before
INIT_LIST_HEAD() on flow_list and flow_list_tc. The half-initialized
flow_cfg still becomes priv->flow_cfg, and otx2_tc_get_entry_by_cookie()
later walks a zeroed list head.

If the flow_cfg allocation itself fails, priv->flow_cfg becomes NULL and
is dereferenced.

>  
>  	priv->netdev = rep->netdev;
> -	priv->flags = rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);
>  	priv->pcifunc = rep->pcifunc;
>  	priv->flow_cfg = rep->flow_cfg;

[Severity: Medium]
This change looks like it fixes a real bug, not just a conversion to
bitops. Should it be split out as a standalone fix?

Before this patch, priv->flags = rep->flags cleared
OTX2_FLAG_REP_MODE_ENABLED and OTX2_FLAG_INTF_DOWN on the shared
representor PCI otx2_nic. RVU_REP_VF_INITIALIZED was BIT_ULL(0), so the
copy also set OTX2_FLAG_RX_TSTAMP_ENABLED.

After any tc flower callback on a representor, the shared NAPI paths
behaved differently:

- otx2_tx_napi_handler() used pfvf->netdev, which is the last
  representor's single-queue netdev, and no longer forced qidx to 0. So
  netdev_get_tx_queue(ndev, qidx) could index past the tx queue array.
- otx2_set_rxtstamp() could dereference pfvf->ptp, which is NULL because
  rvu_rep_probe() never calls otx2_ptp_init().
- otx2_rcv_pkt_handler() started calling skb_record_rx_queue() and
  setting CHECKSUM_UNNECESSARY.

The commit message describes this only as:

  "Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
  (bit 21)."

Would it make sense to describe the user visible failure, add the
following tag, and send the fix separately to net so it can reach
stable?

  Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")

[ ... ]

> @@ -382,7 +382,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
>  {
>  	struct rep_dev *rep = netdev_priv(dev);
>  
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but rvu_rep_get_stats64() ends
with:

	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

Here rep is netdev_priv() of the representor netdev. rvu_rep_destroy()
calls free_netdev() on each representor without calling
cancel_delayed_work_sync(&rep->stats_wrk), and nothing else cancels the
work.

If stats are read shortly before the eswitch is switched to legacy mode,
or before the device is removed, can rvu_rep_get_stats() run on the freed
rep and write rep->stats?

[ ... ]

> @@ -632,7 +632,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
>  	int rep_id;
>  
>  	rvu_eswitch_config(priv, false);
> -	priv->flags |= OTX2_FLAG_INTF_DOWN;
> +	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
>  	rvu_rep_free_cq_rsrc(priv);
>  	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
>  		rep = priv->reps[rep_id];

[Severity: High]
This is a pre-existing issue, but further down in this loop:

		free_netdev(rep->netdev);
		kfree(rep->flow_cfg);

rep lives inside the net_device allocation made with
alloc_etherdev(sizeof(*rep)) in rvu_rep_create().

Does kfree(rep->flow_cfg) read the pointer from memory that free_netdev()
has just released? Should flow_cfg be freed, or saved, before
free_netdev()?

[Severity: High]
This isn't a bug introduced by this patch either. kfree(rep->flow_cfg)
frees only the container, so flow_cfg->flow_ent leaks. priv->flow_cfg is
also left pointing at the last representor's flow_cfg, which
rvu_rep_setup_tc_cb() stored there.

The representor PCI device's devlink stays registered after going back
to legacy mode, and the mcam_count params use pfvf->flow_cfg:

otx2_dl_mcam_count_set()
	pfvf->flow_cfg->ntuple_cnt = ctx->val.vu16;
	otx2_alloc_mcam_entries(pfvf, ctx->val.vu16);

Can this write into the freed flow_cfg? otx2_dl_mcam_count_get() and
otx2_dl_mcam_count_validate() also read max_flows and nr_flows from it.

With this patch, MCAM_ENTRIES_ALLOC and TC_FLOWER_SUPPORT also stay set
on priv alongside the dangling pointer.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923032217.1732753-1-rkannoth%40marvell.com
