Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB535C1B0;
	Sun, 18 Oct 2026 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291770; cv=none; b=aTV8kMt6RsDa7XP0/dEOu9bcXke9/zmlgYnY8dnrtkvqn+gU7EfDaMYCFG8f+NumQ9p46XFErdp4avet+Mi3lGVnqxBOq/D7enlzkeT2ZX8XbAZcn0/cA3UdHXSK5dBTZli0t9NRZYGatBUXYaxfD0ym3TCOxWaYXBg8FYYWWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291770; c=relaxed/simple;
	bh=hQkZd+KgfTOKTJK5RWN9fppSeYN8zGP7gQ4D304U9ZU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uy7sDAvb4ZfjUIFFuB2r1MroCk//kmRNkkYLqTcFbnQIS/5Ei4SafInpfLv9hmRIUT7TP5OBdpj6Flr8/dgRAifTZJPBQ7zE4Y8bGpZ5sHLHq/sl+uSPyxkSKBfmns14GntdcxrZ+ruVl2Eh6w/+vF40zwm45VeA421/fwC71Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiCaystD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiCaystD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1951F000C4;
	Sun, 18 Oct 2026 02:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291767;
	bh=1/AZMh1szWMZkOI88p2Ti+9TKmMxR4iiObi05RewDD0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JiCaystDBL6MzqD8xW+1kOUGQ6ygP4/krE8ltCYkPJWb0YfyjV4yh93MUtP5aa67S
	 iqvSVgzOwP/1rJPaLIeKaAbWrQ75D8E8dXjZp8MhLKmPv86Hs8V8euDryhWjWSq6HE
	 LrlAo2oFZLN0+vfK0W0muL4LNwDgaHmMaMfGzmILQT3/IyouyxLjPuDElENRGL8I7H
	 fXblbXfT+xN/oDU3vQ4mfwfR2PMUVbyga99FKgbK+B0s/fAZnctoIwkD1tRoVRs/81
	 Lg4grLw2Go2uIgz7WAnKZ6219D/B9Yh+/kpmzHjf3kVZ+4A6zDZANNQGOAVLTH21kf
	 2arsvtNBbOd1g==
Subject: Re: [PATCH v20 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com, horms@kernel.org
Date: Sun, 18 Oct 2026 02:49:26 +0000
Message-ID: <179229176614.3135.15223480028363952634@kernel.org>
In-Reply-To: <20261014023431.1775238-2-rkannoth@marvell.com>
References: <20261014023431.1775238-2-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 (3) · Medium: 1 (5) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] otx2_sync_flags_from_rep() (otx2_common.h:625-634) updates
  priv->flags with a non-atomic read-modify-write: `new =…
- [Medium] The commit message presents this patch as a cleanup that
  switches flag updates to atomic bitops.

Pre-existing issues:
- [Critical] rvu_rep_get_stats64() calls
  schedule_delayed_work(&rep->stats_wrk, 100ms) whenever…
- [High] rvu_rep_setup_tc_cb() ignores the return value of
  rvu_rep_mcam_flow_init() and then publishes rep->flow_cfg as…
- [High] rvu_rep_destroy() reads rep->flow_cfg after freeing the memory
  that holds rep.
- [High] rvu_rep_mcam_flow_init() builds and sends AF mailbox messages on
  priv->mbox (otx2_mbox_alloc_msg_npc_mcam_alloc_entry() /…
- [Medium] The new comment on OTX2_REP_SYNC_FLAGS_MASK says only
  MCAM_ENTRIES_ALLOC, NTUPLE_SUPPORT, TC_FLOWER_SUPPORT and…
- [Medium] In otx2_tc_del_flow(), deleting any marked flower rule clears
  OTX2_FLAG_TC_MARK_ENABLED even if other marked rules are still…
- [Medium] rvu_rep_mcam_flow_init() zero-allocates rep->flow_cfg with
  kzalloc_objs() and never sets mark_flows to 1.
- [Medium] In otx2_config_hwtstamp_set() (otx2_pf.c), a direct switch
  from HWTSTAMP_TX_ONESTEP_SYNC to HWTSTAMP_TX_ON leaves…
- [Medium] The representor flow_cfg lifecycle leaks memory in two ways.

--

octeontx2: use atomic bitops for PF/VF and rep flags

This converts the otx2_nic and rep_dev flags from u64 masks to unsigned
long bitmaps updated with set_bit()/clear_bit()/test_bit(). It also adds
otx2_sync_flags_from_rep(), which copies a masked set of representor-owned
bits onto the shared PF context. The representor VF-initialized flag moves
to OTX2_FLAG_REP_VF_INITIALIZED (bit 21).

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 3c7275d545bba..0dc4c44e521d9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -482,6 +482,41 @@ struct pf_irq_data {
>  	int mdevs;
>  };
>  
> +enum otx2_flag_bits {
> +	OTX2_FLAG_RX_TSTAMP_ENABLED,

[ ... ]

> +	OTX2_FLAG_TC_MARK_ENABLED,
> +	OTX2_FLAG_REP_MODE_ENABLED,
> +	OTX2_FLAG_PORT_UP,
> +	OTX2_FLAG_IPSEC_OFFLOAD_ENABLED,
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

[Severity: Medium]
This isn't a bug introduced by this patch, but does this comment get the
owner of OTX2_FLAG_TC_MARK_ENABLED right?

On the representor path, rvu_rep_setup_tc_cb() points priv->flow_cfg at
rep->flow_cfg. otx2_tc_parse_actions() then does:

    otx2_set_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
    refcount_inc(&nic->flow_cfg->mark_flows);

So the bit lives on the shared priv, but the counter is per-rep.
otx2_tc_del_flow() then clears the shared bit based on one rep's counter.

Say rep A and rep B both have skbedit mark rules and the rule on rep B is
deleted. Wouldn't otx2_rcv_pkt_handler() then stop setting skb->mark for
rep A's traffic?

    if (otx2_test_flag(pfvf, OTX2_FLAG_TC_MARK_ENABLED))
        skb->mark = parse->match_id;

Before this patch, priv->flags = rep->flags wiped the bit on every
callback, so representor marking was already broken. This patch changes
how it fails, but the new comment now describes TC_MARK_ENABLED as owned
by the PF/VF netdev.

[ ... ]

> @@ -593,6 +607,32 @@ struct otx2_nic {
>  	unsigned long		*af_xdp_zc_qidx;
>  };
>  

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
Can this read-modify-write lose a concurrent set_bit() or clear_bit() on
priv->flags?

Every other writer of this word now uses atomic bitops. Any update that
lands between the READ_ONCE() and the WRITE_ONCE() here is overwritten
with the stale value.

rvu_rep_setup_tc_cb() runs from the flower block callback under rtnl
only. rvu_rep_destroy() and rvu_rep_create()->rvu_rep_napi_init() are
called from otx2_devlink_eswitch_mode_set() holding only the devlink
instance lock. During that time the rep netdevs and their TC blocks are
still registered:

CPU1 (tc flower on a rep)
rvu_rep_setup_tc_cb()
  otx2_sync_flags_from_rep()
    new_flags = (READ_ONCE(dst->flags) & ~MASK) | ...

CPU2 (devlink eswitch mode legacy)
rvu_rep_destroy()
  otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);

CPU1
    WRITE_ONCE(dst->flags, new_flags);   <- INTF_DOWN lost

If INTF_DOWN is lost, otx2_napi_handler() would re-arm the CQ interrupt
through NIX_LF_CINTX_ENA_W1S during teardown. rvu_rep_remove() would
later see INTF_DOWN clear and call rvu_rep_destroy() a second time on the
already freed priv->reps.

The opposite direction looks possible too. The clear of INTF_DOWN in
rvu_rep_napi_init() could be undone, and the representor datapath would
never get its interrupts re-enabled.

Would set_mask_bits(&dst->flags, OTX2_REP_SYNC_FLAGS_MASK,
src & OTX2_REP_SYNC_FLAGS_MASK), or a try_cmpxchg() loop, match what the
commit message says about atomic bitops and "without clearing PF-owned
bits"?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 7dc0ce669d0b7..777e7156badb7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -2538,8 +2538,8 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
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
> @@ -2550,7 +2550,7 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
>  					   "One-step time stamping is not supported");
>  			return -ERANGE;
>  		}
> -		pfvf->flags |= OTX2_FLAG_PTP_ONESTEP_SYNC;
> +		otx2_set_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
>  		schedule_delayed_work(&pfvf->ptp->synctstamp_work,
>  				      msecs_to_jiffies(500));
>  		fallthrough;

[Severity: Medium]
This is a pre-existing issue, but what clears OTX2_FLAG_PTP_ONESTEP_SYNC
when the mode switches straight from HWTSTAMP_TX_ONESTEP_SYNC to
HWTSTAMP_TX_ON?

Only the HWTSTAMP_TX_OFF case clears it. The HWTSTAMP_TX_ON case only
does:

    case HWTSTAMP_TX_ON:
        otx2_config_hw_tx_tstamp(pfvf, true);
        break;

otx2_set_txtstamp() would keep taking the one-step branch for PTP Sync
packets. It rewrites the origin timestamp and never sets
SKBTX_IN_PROGRESS, so the requested two-step mode isn't applied until
there is an OFF request in between.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index dee38d5c7f65b..8877af348a090 100644
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
This isn't a bug introduced by this patch, but for representors, is
mark_flows ever initialized before this refcount_inc()?

rvu_rep_mcam_flow_init() allocates rep->flow_cfg with kzalloc_objs() and
never sets mark_flows. The only refcount_set(&flow_cfg->mark_flows, 1) is
in otx2_mcam_entry_init(), which representors don't use.

A rule such as "tc filter add dev <rep> ... action skbedit mark N" would
then go through:

rvu_rep_setup_tc_cb()->otx2_setup_tc_cls_flower()->otx2_tc_add_flow()
  ->otx2_tc_prepare_flow()->otx2_tc_parse_actions()
    refcount_inc(&nic->flow_cfg->mark_flows);   /* from 0 */

That fires the "addition on 0; use-after-free" warning in
refcount_warn_saturate() and saturates the counter. After that,
refcount_dec_and_test() in otx2_tc_del_flow() always returns false.

otx2_sync_flags_from_rep() now keeps TC_MARK_ENABLED on priv across
callbacks, so this broken counter is the only thing that decides when the
flag gets cleared.

[ ... ]

> @@ -1195,12 +1195,12 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  	/* Disable TC MARK flag if they are no rules with skbedit mark action */
>  	if (flow_node->req.match_id)
>  		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
> -			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
> +			otx2_clear_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);

[Severity: Medium]
This is a pre-existing issue, but is this condition inverted?

otx2_mcam_entry_init() sets mark_flows to 1, and each FLOW_ACTION_MARK
adds one. With two marked rules the count is 3. Deleting one brings it to
2, refcount_dec_and_test() returns false, and the flag is cleared.

Because of the base reference, deleting mark rules never brings the
counter to 0. Wouldn't every delete of a marked rule clear
OTX2_FLAG_TC_MARK_ENABLED, so that otx2_rcv_pkt_handler() stops setting
skb->mark for the rules still installed?

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
This isn't a bug introduced by this patch, but does
rvu_rep_mcam_flow_init() ever take priv->mbox.lock?

It allocates and sends AF messages without the lock:

    while (allocated < count) {
        req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&priv->mbox);
        ...
        if (otx2_sync_mbox_msg(&priv->mbox))
            goto exit;

and then unlocks unconditionally at the exit label:

exit:
    ...
    mutex_unlock(&priv->mbox.lock);

Its only caller, rvu_rep_setup_tc_cb(), holds rtnl but not the mbox
mutex. rvu_rep_get_stats(), rvu_eswitch_config() and the otx2_tc_*
helpers all serialize on priv->mbox.lock.

Can these MCAM allocation messages interleave with the stats work's
mailbox traffic and corrupt the shared mbox region?

And if another task holds mbox.lock at that point, doesn't this
mutex_unlock() release that task's critical section?

[Severity: Medium]
This is also a pre-existing issue, but do rep->flow_cfg and its flow_ent
leak here?

rvu_rep_mcam_flow_init() allocates a new flow_cfg and flow_ent on every
call and never frees the previous ones. It also doesn't free flow_cfg
when the flow_ent kcalloc() fails:

    rep->flow_cfg = kzalloc_objs(struct otx2_flow_config, 1);
    ...
    rep->flow_cfg->flow_ent = kcalloc(count, sizeof(u16), GFP_KERNEL);
    if (!rep->flow_cfg->flow_ent)
        return -ENOMEM;

rvu_rep_setup_tc_cb() calls it again on every TC callback while
TC_FLOWER_SUPPORT stays clear, including FLOW_CLS_STATS from dumps.
TC_FLOWER_SUPPORT stays clear after a flow_ent allocation failure, a
mailbox failure, or an MCAM allocation that returns zero entries.

Separately, rvu_rep_destroy() only does kfree(rep->flow_cfg).
flow_cfg->flow_ent is never freed, and the MCAM entries allocated for the
rep's pcifunc are never released to the AF.

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

[Severity: High]
This isn't a bug introduced by this patch, but what happens when
rvu_rep_mcam_flow_init() returns -ENOMEM here?

The return value is dropped, and rep->flow_cfg is published below in one
of two broken states:

- NULL, if kzalloc_objs() failed.
- With zeroed list heads, if the flow_ent kcalloc() failed, because that
  path skips INIT_LIST_HEAD().

FLOW_CLS_REPLACE bails out early because TC_FLOWER_SUPPORT is clear.
FLOW_CLS_DESTROY, however, goes straight to:

otx2_setup_tc_cls_flower()->otx2_tc_del_flow()
  ->otx2_tc_get_entry_by_cookie()
      list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list)

Wouldn't that dereference a NULL flow_cfg, or follow a NULL ->next from a
zeroed list head? tc core issues the destroy when a skip_sw replace fails,
and when a non-skip_hw filter is deleted.

>  
>  	priv->netdev = rep->netdev;
> -	priv->flags = rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);
>  	priv->pcifunc = rep->pcifunc;
>  	priv->flow_cfg = rep->flow_cfg;

[Severity: Medium]
This change looks like it fixes a real bug, but the commit message only
hints at it:

  ... giving lockless NAPI readers a consistent word without clearing
  PF-owned bits.

  Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
  (bit 21).

Before this patch, priv->flags = rep->flags overwrote every PF-owned bit
on the shared rep PF otx2_nic. rvu_rep_probe() sets
OTX2_FLAG_REP_MODE_ENABLED on priv, but rep->flags never has it, so any
flower callback on a representor cleared it.

The old RVU_REP_VF_INITIALIZED was BIT_ULL(0), the same bit as
OTX2_FLAG_RX_TSTAMP_ENABLED. The callback only proceeds when that bit is
set, so the copy also set RX_TSTAMP_ENABLED on priv.

With REP_MODE_ENABLED cleared, otx2_tx_napi_handler() uses pfvf->netdev,
which the callback has just set to the last rep's netdev. It also stops
forcing qidx to 0:

    if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
        qidx = 0;
    txq = netdev_get_tx_queue(ndev, qidx);

That means netdev_tx_completed_queue() could update a netdev_queue past
the single TX queue that alloc_etherdev() allocates for the rep.

Should the commit message describe this representor TX/RX breakage and
carry a Fixes: tag so it gets picked up for stable? Something like:

Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")

[ ... ]

> @@ -382,7 +382,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
>  {
>  	struct rep_dev *rep = netdev_priv(dev);
>  
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
>  		return;
>  
>  	stats->rx_packets = rep->stats.rx_frames;

[Severity: Critical]
This is a pre-existing issue, but is stats_wrk ever cancelled before the
rep netdev is freed?

Further down, rvu_rep_get_stats64() does:

    schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

stats_wrk is embedded in struct rep_dev, which is netdev_priv(rep->netdev).
Neither rvu_rep_destroy() nor the rvu_rep_create() error path calls
cancel_delayed_work_sync() before free_netdev().

unregister_netdev() itself re-arms the work through the RTM_DELLINK
message:

unregister_netdev()->...->rtnl_fill_ifinfo()->rtnl_fill_stats()
  ->dev_get_stats()->rvu_rep_get_stats64()
    schedule_delayed_work(&rep->stats_wrk, ...)

Any stats read does the same, including unprivileged ones such as
/proc/net/dev or ip -s link.

About 100ms after free_netdev(), wouldn't the timer fire from freed
memory? rvu_rep_get_stats() would then do container_of() on the freed rep,
dereference rep->mdev and take priv->mbox.lock.

There is also an ordering question in rvu_rep_create().
INIT_DELAYED_WORK(&rep->stats_wrk, rvu_rep_get_stats) runs only after
register_netdev(). Can the RTM_NEWLINK stats fill schedule the work before
it is initialized?

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
This isn't a bug introduced by this patch, but doesn't the rest of this
loop read rep after it has been freed?

        unregister_netdev(rep->netdev);
        rvu_rep_devlink_port_unregister(rep);
        free_netdev(rep->netdev);
        kfree(rep->flow_cfg);

In rvu_rep_create(), rep comes from netdev_priv(ndev), so it lives inside
the netdev allocation. Once unregister_netdev() has completed,
free_netdev() normally drops the last device reference and frees that
memory.

kfree(rep->flow_cfg) then loads the pointer from freed memory. With slab
poisoning that means kfree() of a poison value. With init_on_free,
flow_cfg leaks. KASAN would report the access on every
rvu_rep_destroy().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014023431.1775238-1-rkannoth%40marvell.com
