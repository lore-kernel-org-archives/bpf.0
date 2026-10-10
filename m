Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F32F12DA;
	Sat, 10 Oct 2026 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626472; cv=none; b=EJU29zb+SKPMQOPY6rJc6d+C6eOCbNwJdJVih26NJmgPvEHwKnpv1jL2X/vx+62kNQOPD8YTToilPHsxe1JoOCkMfeU1JHrteGgksxdi8rDw02I+XxmW4LUbZWWT3nAuJlITxUx2wrYRH8l202djB6fPY0EHV3okp0M3F7JS+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626472; c=relaxed/simple;
	bh=Uy4Zgscg1ge02wraNnWSHdPA+/LmHWlZWemo79hfFg8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1Wr3TrlK7LED8kLsyUNDFBEEFgMjQe2mkTV6OUnSs9yUu4iZhmpOSzPfhGrMs5y8pKhGeG1x2gzqaKYlAOJ34fA5uLr55WT8GtoSvoC6NHu0wXBSazsXX7HmynUupO6fnUYnNGrH6w117Faa4FC64MUmQHM9KaJgd+YuFybS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxQ4jOLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxQ4jOLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E61F000FF;
	Sat, 10 Oct 2026 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791626470;
	bh=d2kvKv3iooc1J5ThXDq0yuf6hHJQMTe2xhwJvYhfXMU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oxQ4jOLWI2QYb5bW6fVUNKJybacwy/tq2cOYt2uhjg+iI59i5m9SEPz1NcF43iz/l
	 RR8P/YFiWPIw9xiZutxafXI5K8X/RhQdQu+pldjg/a62iwIOSv6J+XvvUwdlqw9Xz1
	 MBq+5erZhQnDMFP15ecpgaBKoLdDiWK5ic4bL2NDOmbyJbJT4ssfW4OGlIP4N54reV
	 RLrvcSPbMUxhl6TZg4WG25KF7BlGM33BLF3PK1cy111yycxYAR8aIiyU+ekBILI0sD
	 P/K84CvOvZ5P4pJ1vlLvGSHNZiZroiySOn3Y+ZioxwmQSp6v1b65sp9jKAMEJ5jBLa
	 nU3S006ckpveA==
Subject: Re: [PATCH v19 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Sat, 10 Oct 2026 10:01:08 +0000
Message-ID: <179162646892.434549.7222119532595039059@kernel.org>
In-Reply-To: <20261006094357.840823-2-rkannoth@marvell.com>
References: <20261006094357.840823-2-rkannoth@marvell.com>
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

Critical: 0 · High: 1 (3) · Medium: 1 (5) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] otx2_sync_flags_from_rep() (otx2_common.h:625-634) updates the
  shared priv->flags word with a plain read-modify-write:…
- [Medium] The commit message presents this as a cleanup to atomic
  bitops, but the patch also fixes a user-visible representor bug and…

Pre-existing issues:
- [High] Use-after-free of the representor's delayed stats work.
- [High] In rvu_rep_destroy() (rep.c:641-642),
  `free_netdev(rep->netdev);` is followed by `kfree(rep->flow_cfg);`.
- [High] rvu_rep_mcam_flow_init() (rep.c:54-91) builds and sends
  NPC_MCAM_ALLOC_ENTRY messages in the shared PF<->AF mailbox…
- [Medium] otx2_tc_del_flow() (otx2_tc.c:1196-1198) clears
  OTX2_FLAG_TC_MARK_ENABLED when…
- [Medium] rvu_rep_setup_tc_cb() (rep.c:115-116) ignores the return value
  of rvu_rep_mcam_flow_init().
- [Medium] In otx2_config_hwtstamp_set() (otx2_pf.c), the
  HWTSTAMP_TX_ONESTEP_SYNC case sets OTX2_FLAG_PTP_ONESTEP_SYNC and…
- [Medium] Representor flow configuration memory leaks.
- [Medium] A representor's flow_cfg->mark_flows starts at 0 because
  rvu_rep_mcam_flow_init() allocates flow_cfg zeroed and never calls…
- [Low] otx2_config_hwtstamp_set() ignores the return values of
  otx2_config_hw_tx_tstamp() and otx2_config_hw_rx_tstamp().

--

octeontx2: use atomic bitops for PF/VF and rep flags

This converts the otx2_nic and rep_dev flag words from u64 masks to
unsigned long bitmaps that are accessed with set_bit/clear_bit/test_bit.
It adds otx2_sync_flags_from_rep() to copy a masked set of representor
flags onto the shared PF context. It also moves the representor VF
initialized flag to OTX2_FLAG_REP_VF_INITIALIZED (bit 21).

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index fda6c4487c4fb..3bc57dd104515 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

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
Can this read-modify-write lose concurrent updates to PF-owned bits?

Every other writer of priv->flags now uses atomic set_bit()/clear_bit().
This helper instead reads the whole word, masks it, and writes the whole
word back.

rvu_rep_setup_tc_cb() runs under rtnl. otx2_devlink_eswitch_mode_set()
holds only the devlink instance lock:

CPU0 (tc filter add ... dev <rep>, rtnl held)
rvu_rep_setup_tc_cb()
  otx2_sync_flags_from_rep()
    READ_ONCE(dst->flags)

CPU1 (devlink dev eswitch set ... mode legacy, no rtnl)
otx2_devlink_eswitch_mode_set()
  rvu_rep_destroy()
    otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN)

CPU0
    WRITE_ONCE(dst->flags, new_flags)

INTF_DOWN is outside OTX2_REP_SYNC_FLAGS_MASK, but CPU0's stale word still
overwrites it.

If that happens, otx2_napi_handler() no longer sees INTF_DOWN during
teardown and can re-enable CQ interrupts. On a later PCI remove,
rvu_rep_remove() also sees INTF_DOWN clear and runs teardown again:

    if (!otx2_test_flag(priv, OTX2_FLAG_INTF_DOWN))
        rvu_rep_destroy(priv);

The second rvu_rep_destroy() would walk qset->napi in
rvu_rep_free_cq_rsrc() after otx2_free_queue_mem() has already set it to
NULL. It would then unregister and free priv->reps[] and priv->reps a
second time.

The reverse case also looks possible. rvu_rep_napi_init() runs
otx2_clear_flag(priv, OTX2_FLAG_INTF_DOWN) after the rep netdevs are
registered, so they can already get TC callbacks. If that clear is lost,
CQ interrupts are never re-enabled and the representor datapath stalls.

The commit message says this helper publishes the flags "without clearing
PF-owned bits". For that to hold, does this need a try_cmpxchg() loop on
dst->flags, or assign_bit() for each bit in OTX2_REP_SYNC_FLAGS_MASK?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 7dc0ce669d0b7..777e7156badb7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -2511,9 +2511,9 @@ static int otx2_config_hw_tx_tstamp(struct otx2_nic *pfvf, bool enable)
>  
>  	mutex_unlock(&pfvf->mbox.lock);
>  	if (enable)
> -		pfvf->flags |= OTX2_FLAG_TX_TSTAMP_ENABLED;
> +		otx2_set_flag(pfvf, OTX2_FLAG_TX_TSTAMP_ENABLED);
>  	else
> -		pfvf->flags &= ~OTX2_FLAG_TX_TSTAMP_ENABLED;
> +		otx2_clear_flag(pfvf, OTX2_FLAG_TX_TSTAMP_ENABLED);
>  	return 0;
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but otx2_config_hw_tx_tstamp()
and otx2_config_hw_rx_tstamp() can return -ENOMEM or a mailbox error
before they update these flags. otx2_config_hwtstamp_set() ignores both
return values and finishes with:

    pfvf->tstamp = *config;

    return 0;

Does this report a failed enable to user space as success? The getter
would then return a configuration that was never applied.

[ ... ]

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
This is a pre-existing issue, but only HWTSTAMP_TX_OFF clears
OTX2_FLAG_PTP_ONESTEP_SYNC.

Consider a switch straight from HWTSTAMP_TX_ONESTEP_SYNC to
HWTSTAMP_TX_ON. The flag stays set and synctstamp_work is not cancelled.
otx2_config_hw_tx_tstamp() also returns early, because TX timestamping is
already enabled.

otx2_set_txtstamp() then still takes the one-step path for PTP Sync
packets:

    if (unlikely(otx2_test_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC) &&
                 otx2_ptp_is_sync(skb, &ptp_offset, &udp_csum_crt))) {

Would this rewrite the origin timestamp and skip SKBTX_IN_PROGRESS? If
so, the two-step TX timestamp requested with TX_ON would never be
delivered.

[ ... ]

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
This is a pre-existing issue. When nic->flow_cfg comes from a
representor, rvu_rep_mcam_flow_init() allocates it zeroed. Unlike
otx2_mcam_entry_init(), it never calls refcount_set(&flow_cfg->mark_flows, 1).

Won't this refcount_inc() then run on 0 for the first skbedit mark rule
on a representor? That would print the "refcount_t: addition on 0;
use-after-free" warning and leave mark_flows saturated.

[ ... ]

> @@ -1195,12 +1195,12 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  	/* Disable TC MARK flag if they are no rules with skbedit mark action */
>  	if (flow_node->req.match_id)
>  		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
> -			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
> +			otx2_clear_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);

[Severity: Medium]
This isn't a bug introduced by this patch, but is this condition inverted?

mark_flows starts at 1 in otx2_mcam_entry_init(), and
otx2_tc_parse_actions() increments it for each mark rule, so N mark rules
give a count of N + 1. Deleting any one of them leaves the count at
N >= 1. refcount_dec_and_test() then returns false and TC_MARK_ENABLED is
cleared.

After that, wouldn't the remaining mark rules stop setting skb->mark in
otx2_rcv_pkt_handler()?

This logic appears to come from commit 6a57f091622a12.

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
>  
>  	INIT_LIST_HEAD(&rep->flow_cfg->flow_list);

[Severity: High]
This isn't a bug introduced by this patch, but rvu_rep_mcam_flow_init()
builds and sends NPC_MCAM_ALLOC_ENTRY messages without taking
priv->mbox.lock. It then unlocks the mutex anyway:

    while (allocated < count) {
        req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&priv->mbox);
    ...
exit:
    ...
    mutex_unlock(&priv->mbox.lock);

The caller, rvu_rep_setup_tc_cb(), doesn't hold the lock either. Other
users of the same mailbox do take it, for example rvu_rep_get_stats() in a
kworker and rvu_eswitch_config() from devlink.

Can this interleave messages in the shared AF mailbox? Can the unbalanced
mutex_unlock() release a lock that another task holds?

If otx2_mbox_get_rsp() then matches the wrong response, rsp->entry_list[]
could be copied into rep->flow_cfg->flow_ent[]. Later flow installs would
then target MCAM entries this pcifunc does not own.

Even without any concurrency, the first tc flower command on a
representor would trigger a bad unlock balance warning with lockdep or
DEBUG_MUTEXES. This code appears to come from commit 6c40ca957fe5.

[Severity: Medium]
This is also a pre-existing issue. rvu_rep_mcam_flow_init() always
allocates a new rep->flow_cfg and flow_cfg->flow_ent without freeing any
earlier allocation:

    rep->flow_cfg = kzalloc_objs(struct otx2_flow_config, 1);

rvu_rep_setup_tc_cb() calls it on every callback while TC_FLOWER_SUPPORT
is clear. The flag stays clear if the AF grants zero MCAM entries, the
mailbox fails, or the flow_ent allocation fails. Does each REPLACE,
DESTROY or STATS callback then leak the previous flow_cfg and flow_ent?

The teardown path has related leaks. rvu_rep_destroy() frees only
rep->flow_cfg, not flow_cfg->flow_ent. otx2_destroy_tc_flow_list() is
only called from the PF and VF drivers, so the otx2_tc_flow nodes on a
representor's flow_list_tc also look leaked.

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
rvu_rep_mcam_flow_init() is ignored here.

If the kzalloc of rep->flow_cfg fails, rep->flow_cfg is NULL. If the
kcalloc of flow_ent fails, the function returns before INIT_LIST_HEAD()
runs on the list heads. In both cases priv->flow_cfg = rep->flow_cfg is
still assigned and the command is still dispatched.

FLOW_CLS_REPLACE returns -ENOMEM early here because TC_FLOWER_SUPPORT is
clear. With skip_sw, fl_hw_replace_filter() then calls
fl_hw_destroy_filter(). The FLOW_CLS_DESTROY callback retries the init.
If the allocation fails again, can
otx2_tc_del_flow()->otx2_tc_get_entry_by_cookie() walk
flow_cfg->flow_list_tc on a NULL or uninitialized flow_cfg?

>  
>  	priv->netdev = rep->netdev;
> -	priv->flags = rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);

[Severity: Medium]
Before this patch, this assignment replaced every flag on the
representor PF's shared otx2_nic with rep->flags. rep->flags only held
RVU_REP_VF_INITIALIZED plus MCAM_ENTRIES_ALLOC, NTUPLE_SUPPORT and
TC_FLOWER_SUPPORT. RVU_REP_VF_INITIALIZED was BIT_ULL(0), the same bit as
OTX2_FLAG_RX_TSTAMP_ENABLED.

As a result, the first tc flower callback on a representor did three
things:

- It cleared the OTX2_FLAG_REP_MODE_ENABLED set by rvu_rep_probe().
  otx2_tx_napi_handler() then used pfvf->netdev instead of
  pfvf->reps[qidx]->netdev and stopped forcing qidx = 0.
  otx2_rcv_pkt_handler() started recording RX queues and setting
  CHECKSUM_UNNECESSARY on rep traffic.

- It set RX_TSTAMP_ENABLED, so otx2_set_rxtstamp() would dereference
  pfvf->ptp, which is never set up for the rep device.

- It cleared TC_MARK_ENABLED and INTF_DOWN.

The masked copy plus moving the rep bit to bit 21 fixes this. The commit
message only hints at it, with "without clearing PF-owned bits" and
"Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
(bit 21)".

Could this be split out as a separate minimal fix with:

Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")

so that stable trees pick it up, rather than being part of a 14-file
conversion?

>  	priv->pcifunc = rep->pcifunc;
>  	priv->flow_cfg = rep->flow_cfg;
>  

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

[Severity: High]
This is a pre-existing issue, but each stats read with VF_INITIALIZED set
ends with:

    schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

rep_dev is embedded in the netdev private area. Neither rvu_rep_destroy()
nor the error unwind in rvu_rep_create() calls
cancel_delayed_work_sync(&rep->stats_wrk) before free_netdev(rep->netdev).
rvu_rep_rsrc_free() only cancels the pool refill work.

Suppose a stats read happens within 100ms of a switch to legacy eswitch
mode or a PCI remove. The read can even come from the notification that
unregister_netdev() itself sends. Can rvu_rep_get_stats() then run on the
freed rep_dev and write rep->stats into freed memory?

Separately, rvu_rep_create() calls
INIT_DELAYED_WORK(&rep->stats_wrk, rvu_rep_get_stats) only after
register_netdev(). Would a stats read in that window schedule an
uninitialized work item?

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
This isn't a bug introduced by this patch, but further down in this loop:

        free_netdev(rep->netdev);
        kfree(rep->flow_cfg);

rep is netdev_priv(rep->netdev), so isn't rep->flow_cfg read from freed
memory here? If that memory has been reused, the kfree() could free an
arbitrary pointer.

Should flow_cfg be freed before free_netdev()? Also, priv->flow_cfg and
priv->netdev are copied from the rep in rvu_rep_setup_tc_cb(), so they
seem to be left pointing at freed objects after this.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006094357.840823-1-rkannoth%40marvell.com
