Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881245563B;
	Fri,  2 Oct 2026 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929879; cv=none; b=DF/a1Ot44kp0yZerlcLl7ldHCpG368lOtNldGtiAurf9J+LY4OB2jxb6ys9/HtJqtLpM8nhZdA1H1sWgQaL0qocZw64rpdPkrlHVKClj3mNVAtTXV4ebJT9eO+rkGaDk8IopVeFvuChrjcSk09K6Zw25zOq3+LejgOj+NoOjrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929879; c=relaxed/simple;
	bh=xGfaxgorjbhVrGN85b+Ignt28kbopsTT0bZF5QVU24M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZW8fyRl6qRsefxjxJYIEez2iScbrywxUCaMwOHj2Un3AaDoNJcJZbEMGOFjKLmd0VSHupWDL1mxj3qudjR/pkCZCzEfqsCHJe6OQATin4s5lV+aV3/ISHpvvbcNVuV+VXC8h7EEEPvo0qNkL0EnFCSdTpzRgI3nkMUQdQaz6eY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShzY/3t+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShzY/3t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C071F000FF;
	Fri,  2 Oct 2026 08:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929876;
	bh=Eg7jBxu7SnjxakHMR90WIQd6MF4hErQAhZvodeG1928=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ShzY/3t+2lJZFmLNylwcFARWqjC7rT0umIoUT27MFQPT6euw4fdFFgRTBRzu2r2Zp
	 PD54L+G4H4YCXYXCNIGLoyn35pTyeW4XWxzye60L+m8Zci3oPvx44hlEhhph4vPihc
	 28amvQuegR1J9D1kdUhvG1vM1O3/O7VJfWrvs3UFvQ+O6sg8U/fdAOkH3MmwyEkArL
	 TrGxRRoGpYB64dkd2pDuDqpAamu6LCTKa/vWeJtn8d1ommMaCRw8GQzaqycct1Gb1n
	 vgvjhw92CT0+X5YeYmsb5T5UtKogsxjAur6bb3OCCSQqIIXm7yp7eJUaWsPca9X2nE
	 mcV+oOnfchiAQ==
Subject: Re: [PATCH v18 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Fri, 02 Oct 2026 08:31:14 +0000
Message-ID: <179092987490.434549.16075378413092077912@kernel.org>
In-Reply-To: <20260929022915.2704627-2-rkannoth@marvell.com>
References: <20260929022915.2704627-2-rkannoth@marvell.com>
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

Critical: 0 · High: 1 (3) · Medium: 1 (5) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] otx2_sync_flags_from_rep() (otx2_common.h:625-634) updates the
  shared rep-PF flags word with a plain, non-atomic read-modify-write:…
- [Medium] The patch quietly fixes a serious representor bug but gives it
  neither a Fixes: tag nor a description.

Pre-existing issues:
- [High] rvu_rep_destroy() (rep.c:637-643) calls free_netdev(rep->netdev)
  and then kfree(rep->flow_cfg).
- [High] rep->stats_wrk is a delayed_work inside rep_dev, which is
  net_device private data.
- [High] rvu_rep_mcam_flow_init() (rep.c:54-91) builds and sends NPC MCAM
  alloc mailbox messages (otx2_mbox_alloc_msg_npc_mcam_alloc_entry(),…
- [Medium] otx2_tc_del_flow() (otx2_tc.c:1197-1198) clears
  OTX2_FLAG_TC_MARK_ENABLED on every delete of a mark flow, even when…
- [Medium] rvu_rep_setup_tc_cb() (rep.c:115-121) ignores the return value
  of rvu_rep_mcam_flow_init() and then publishes rep->flow_cfg to…
- [Medium] rvu_rep_mcam_flow_init() (rep.c:43-52) always overwrites
  rep->flow_cfg with a new kzalloc and never frees the previous one.
- [Medium] rvu_rep_mcam_flow_init() allocates rep->flow_cfg with kzalloc
  and never calls refcount_set(&flow_cfg->mark_flows, 1).
- [Medium] rvu_rep_state_evt_handler() (rep.c:297-309) uses the result of
  rvu_rep_get_repid() as an index into priv->reps[] without checking it,…

--

octeontx2: use atomic bitops for PF/VF and rep flags

This commit changes the otx2_nic and rep_dev flags words from u64 masks
to unsigned long bitmaps, accessed with set_bit/clear_bit/test_bit. It adds
otx2_sync_flags_from_rep(), which merges the representor-owned flags into
the representor PF's flags with a masked WRITE_ONCE. It also moves the
representor VF-initialized flag to bit 21.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 5850bc1870a1d..b146ca4be5db1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

[ ... ]

> @@ -593,6 +607,32 @@ struct otx2_nic {
>  	unsigned long		*af_xdp_zc_qidx;
>  };
>  
> +static inline void otx2_set_flag(struct otx2_nic *nic, unsigned int flag)
> +{
> +	set_bit(flag, &nic->flags);
> +}

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
Can this read-modify-write lose a concurrent atomic update to the same word?
Every other writer of priv->flags now uses set_bit()/clear_bit(). This one
reads the whole word and writes it back non-atomically.

rvu_rep_setup_tc_cb() calls this under rtnl from the flower block callback.
rvu_rep_destroy() can run from otx2_devlink_eswitch_mode_set() with only the
devlink lock held, while the rep netdevs are still registered:

CPU1 (tc callback, rtnl held)
otx2_sync_flags_from_rep()
    READ_ONCE(dst->flags)              <- INTF_DOWN clear

CPU2 (devlink eswitch mode legacy)
rvu_rep_destroy()
    otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);

CPU1
    WRITE_ONCE(dst->flags, new_flags)  <- INTF_DOWN cleared again

After that, otx2_napi_handler() can see INTF_DOWN clear and write
NIX_LF_CINTX_ENA_W1S during rvu_rep_free_cq_rsrc(). Later,
rvu_rep_remove() sees !INTF_DOWN and calls rvu_rep_destroy() a second
time, on the freed priv->reps and the NULLed qset->napi.

The commit message says the helper publishes the rep flags "without
clearing PF-owned bits". To guarantee that, would it need a cmpxchg loop,
or assign_bit() for each bit in OTX2_REP_SYNC_FLAGS_MASK?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..ddb46b580c3b6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -1195,12 +1195,12 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  	/* Disable TC MARK flag if they are no rules with skbedit mark action */
>  	if (flow_node->req.match_id)
>  		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
> -			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
> +			otx2_clear_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);

[Severity: Medium]
This is a pre-existing issue, not introduced by this patch, but is this
check inverted?

otx2_mcam_entry_init() starts mark_flows at 1, and otx2_tc_parse_actions()
increments it for every FLOW_ACTION_MARK rule. So refcount_dec_and_test()
never reaches zero here, and the flag is cleared on every mark flow delete.

With two mark rules installed (count 3), deleting one leaves the count at
2 but still clears OTX2_FLAG_TC_MARK_ENABLED. otx2_rcv_pkt_handler() then
stops setting skb->mark for the rule that remains:

	if (otx2_test_flag(pfvf, OTX2_FLAG_TC_MARK_ENABLED))
		skb->mark = parse->match_id;

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
This isn't a bug introduced by this patch, but where is priv->mbox.lock
taken in rvu_rep_mcam_flow_init()? The function sends the NPC MCAM alloc
messages without the lock, then unlocks at the exit label:

exit:
	...
	mutex_unlock(&priv->mbox.lock);

Its only caller, rvu_rep_setup_tc_cb(), does not hold the lock either.

The rvu_rep_get_stats() delayed work uses the same mailbox under mbox.lock
and runs without rtnl. Suppose it holds the lock when the first flower rule
is added on a representor. Can both contexts then build messages in the
shared mailbox at the same time, with this mutex_unlock() releasing the
worker's critical section?

Even without that overlap, lockdep would report a bad unlock balance on
the first flower rule added on each representor.

[Severity: Medium]
This is also a pre-existing issue, not introduced by this patch.
rep->flow_cfg is zero-allocated here and mark_flows is never set, unlike
in the PF path in otx2_mcam_entry_init():

	refcount_set(&flow_cfg->mark_flows, 1);

When a representor installs a flower rule with FLOW_ACTION_MARK,
otx2_tc_parse_actions() does:

	refcount_inc(&nic->flow_cfg->mark_flows);

on a counter that is zero. Does that trigger the "refcount_t: addition on
0; use-after-free" warning and saturate the counter?

With this patch, OTX2_FLAG_TC_MARK_ENABLED is no longer wiped by each
representor tc callback. That makes this refcount the only thing that
clears the flag on the representor PF.

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
>  

[Severity: Medium]
This is a pre-existing issue, not introduced by this patch. The return
value of rvu_rep_mcam_flow_init() is ignored, and rep->flow_cfg is
published to priv->flow_cfg regardless.

If the kzalloc of flow_cfg fails, rep->flow_cfg is NULL. If the kcalloc of
flow_ent fails, the list heads stay zeroed, because INIT_LIST_HEAD() is
only reached at the end of the function.

FLOW_CLS_REPLACE returns early in otx2_tc_add_flow(), since
TC_FLOWER_SUPPORT is clear. But fl_hw_replace_filter() then calls
fl_hw_destroy_filter(). An ordinary tc filter del and stats queries also
reach this callback. In those cases:

otx2_tc_del_flow() / otx2_tc_get_flow_stats()
    otx2_tc_get_entry_by_cookie()
        list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list)

Can this dereference the NULL or zeroed flow_cfg?

[Severity: Medium]
This is a pre-existing issue as well, not introduced by this patch.
rvu_rep_mcam_flow_init() always does:

	rep->flow_cfg = kzalloc_objs(struct otx2_flow_config, 1);

and never frees the previous flow_cfg. If the MCAM allocation returns zero
entries, or an allocation fails, TC_FLOWER_SUPPORT stays clear. Does every
later tc callback on that representor then leak a flow_cfg and its
flow_ent array?

rvu_rep_destroy() also only does kfree(rep->flow_cfg). That seems to leak
flow_cfg->flow_ent on every switchdev/legacy cycle.

>  	priv->netdev = rep->netdev;
> -	priv->flags = rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);

[Severity: Medium]
This change fixes a real bug, but the commit message describes it as a
cleanup. Before this patch, the line:

	priv->flags = rep->flags;

overwrote the whole flags word of the shared representor PF. rep->flags
only held RVU_REP_VF_INITIALIZED (BIT_ULL(0)) and the MCAM, NTUPLE and
TC_FLOWER bits. So the first tc callback cleared the
OTX2_FLAG_REP_MODE_ENABLED bit that rvu_rep_probe() set. It also set bit 0,
which in the otx2_nic namespace is OTX2_FLAG_RX_TSTAMP_ENABLED.

With REP_MODE_ENABLED gone, otx2_tx_napi_handler() uses pfvf->netdev, which
is now the last representor's single-queue netdev. It also no longer
forces qidx to 0, so netdev_get_tx_queue(ndev, qidx) can index past that
netdev's _tx array. The RX path also starts recording the rx queue and
setting CHECKSUM_UNNECESSARY based on the wrong netdev's features.

The stray RX_TSTAMP bit also lets otx2_set_rxtstamp() dereference
pfvf->ptp, which is never set up on the rep PF.

The commit message only says:

    Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
    (bit 21).

Could the commit message describe the bug being fixed and add:

    Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")

Could the fix also be split out from the mechanical bitops conversion, so
it can be picked up for stable?

The change also affects how long OTX2_FLAG_TC_MARK_ENABLED stays set on
the rep PF. It used to be wiped on every tc callback, and now it persists.

>  	priv->pcifunc = rep->pcifunc;
>  	priv->flow_cfg = rep->flow_cfg;
>  
> @@ -303,9 +303,9 @@ static void rvu_rep_state_evt_handler(struct otx2_nic *priv,
>  	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
>  	rep = priv->reps[rep_id];
>  	if (info->evt_data.vf_state)
> -		rep->flags |= RVU_REP_VF_INITIALIZED;
> +		set_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags);
>  	else
> -		rep->flags &= ~RVU_REP_VF_INITIALIZED;
> +		clear_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags);
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but rvu_rep_get_repid() returns
-EINVAL for an unknown pcifunc. rep_id is then used to index priv->reps[]
without a check, before set_bit()/clear_bit() on rep->flags.

Separately, rvu_rep_destroy() does kfree(priv->reps) without clearing the
pointer. The AF could send a PFVF_STATE up-message just before
rvu_eswitch_config(priv, false) is processed. Could that message be
handled after the reps are freed, and write into freed memory here?

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
This is a pre-existing issue, not introduced by this patch.
rvu_rep_get_stats64() ends with:

	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

rep->stats_wrk lives in the net_device private data. Neither
rvu_rep_destroy() nor the exit unwind in rvu_rep_create() calls
cancel_delayed_work_sync() before free_netdev().

The teardown path itself arms the work:

unregister_netdev()
  unregister_netdevice_many_notify()
    rtmsg_ifinfo_build_skb(RTM_DELLINK)
      rtnl_fill_ifinfo()
        rtnl_fill_stats()
          dev_get_stats()
            rvu_rep_get_stats64()
              schedule_delayed_work(&rep->stats_wrk, ...)

Does the timer then fire about 100ms after free_netdev(), on freed memory,
with rvu_rep_get_stats() dereferencing rep->mdev and rep->stats?

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
This isn't a bug introduced by this patch, but further down this loop
does:

		free_netdev(rep->netdev);
		kfree(rep->flow_cfg);

rep is the netdev_priv() area of the netdev that rvu_rep_create() allocates
with alloc_etherdev(sizeof(*rep)). After unregister_netdev(),
free_netdev() normally drops the last device reference and frees that
memory.

Is rep->flow_cfg read here after rep has been freed? Freeing flow_cfg
(and flow_cfg->flow_ent) before free_netdev() would avoid that.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929022915.2704627-1-rkannoth%40marvell.com
