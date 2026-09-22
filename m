Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41D3033E6;
	Tue, 22 Sep 2026 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043557; cv=none; b=jAlKYa0QEzYi/w6XqkIS/Vn9lSZ+EmIv5vyAl8qbmNAZ8nadhYGQm+JucDRHjkL49tnrEzr6iynrEFuP5mzyARECnbJDl9BmU0uiloHdbjvMz9EYRrbtrNogn7JSCfrx4rO5eSFjuDJMjhsybpTZkaSQ7J+irzjFHV4DecF0mDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043557; c=relaxed/simple;
	bh=Wl1OV6i0t7jWGlSAjvClm7QFBxpkjEUHgss8l0I88/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnAtJjVa9ltAKGamx/YZ2+uh86OcUYOJ/qWWjvLP3Acuck5fTZ1m7ryUhgagB7arJlDdIJl8+xUsKSYaNygwW+09L+zbDl3f5BIT/l1GlA+krt9KqgmN/NWPhWoVyK3A405uSoWA8oXOO2+p89X7zFQx+BKuu6S0i9jXtrui0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxAirdEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxAirdEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FCF1F00893;
	Tue, 22 Sep 2026 02:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043555;
	bh=M/jemvFxHw157KRe6bMdeUxGvI6vdLOyuWc68xjHTUA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fxAirdEFhkgYwYPH0S7YxVO/T5XzAv3Sm+wor7vdzq5j//voeIhMIcSZBMUwMZqjW
	 zhCOWJl4ARe+c/Pa0KSVLsj+LLjLCKQ+Wbx6m6csFBSywHfilCIMiZ/uiz2z6ZFjeQ
	 rbniy6hX4vr3YZP6QRKDhC2TIo7XJlIIIsdUjxEFw2w+L5spfJ62FhPyhN29u15zXQ
	 QVXpTAotRrzF9zzR3jOYi/0DpClKWnXEONHlJN0lENZtG22v6bs4+VH7bBJw84NqUy
	 ECni4/JdfDHBzRLVR1TjkgOOgaAwne2WH1gIyAmH+yNdmRcAoNs+NUqBNzGIG4LQWz
	 +w36UgX/Mzx3A==
Subject: Re: [PATCH v16 net-next 2/2] octeontx2-pf: add mqprio bandwidth
 offload for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Tue, 22 Sep 2026 02:19:13 +0000
Message-ID: <179004355373.2160803.6964448826928226346@kernel.org>
In-Reply-To: <20260918015906.1255204-3-rkannoth@marvell.com>
References: <20260918015906.1255204-3-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 17 potential
issue(s) to consider.

Critical: 0 · High: 7 · Medium: 9 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] otx2_mqprio_restart_netdev() manipulates the core-owned
  __LINK_STATE_START bit directly (clear_bit()/set_bit()) to fake…
- [High] When otx2_nix_tm_clear_queue_shaper() fails, otx2_mqprio_down()
  deliberately returns the error and keeps pfvf->mqprio.rate_limit =…
- [High] otx2_mqprio_netdev_tc_work() reads pfvf->mqprio.rate_limit and
  pfvf->old_mq_snap before taking rtnl_lock() and never re-validates…
- [High] Every early validation return in otx2_setup_tc_mqprio()
  (interface not UP, wrong shaper, no CIR+PIR, SDP rep, PFC enabled, XDP…
- [High] A successful mqprio replacement is rolled back when
  NETIF_F_HW_TC is not enabled, which is the default for these devices.
- [High] Replacing a software mqprio root with an offloaded mqprio
  succeeds but loses the newly installed traffic-class layout.
- [High] The new mqprio.netdev_tc_work dereferences pfvf->netdev and
  pfvf->old_mq_snap and mutates core netdev TC state, but…
- [Medium] Two changes to code shared by all PF/VF configurations are
  bundled into this feature patch with no mention in the commit message:…
- [Medium] The commit message claims failed setup 'rolls back via netdev
  restart' and the code reports 'mqprio: replace failed; prior…
- [Medium] otx2_mqprio_max_rate_bytes_ps() derives a maximum *rate*
  (bytes/s) from the NIX *burst-size* constants MAX_BURST_SIZE (130816…
- [Medium] The driver reconstructs the core qdisc replace state machine:
  otx2_mqprio_keep_netdev_tc() strcmp()s…
- [Medium] otx2_txschq_stop() now zeroes pfvf->hw.txschq_cnt[] on every
  interface stop, but otx2_get_smq_idx() computes 'idx = qidx %…
- [Medium] A failed mqprio replacement can leave the surviving old qdisc
  inconsistent with both the driver's cached state and the programmed…
- [Medium] pf->refill_wrk (devm_kcalloc'd array of INIT_DELAYED_WORK'd
  struct refill_work, allocated in otx2_config_nix_queues() from…
- [Medium] INIT_WORK(&nic->mqprio.netdev_tc_work,
  otx2_mqprio_netdev_tc_work) is performed in otx2_init_tc(), which runs…
- [Medium] otx2_nix_tm_set_queue_shaper() programs both MDQ PIR and CIR
  via otx2_get_txschq_rate_regval(pfvf, rate, 0), and burst == 0 in…
- [Low] Two new comments describe the hard-coded burst value 65536 in the
  HTB shaper path as 'the kernel-side default burst when HTB does not…

--

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO offload with TC_MQPRIO_SHAPER_BW_RATE for
PF and VF netdevs, programming per-queue MDQ CIR/PIR through the NIX TX
scheduler mailbox.  Because the scheduler cannot be reprogrammed live, add,
replace, delete and rollback all rebuild the hierarchy by bouncing the
netdev through ndo_stop()/ndo_open(), with rates cached in software and
restored from otx2_mqprio_up() on open.

A few questions below about the state machine, the netdev bounce, the rate
limits and the new work item.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index b421cb75e44b..5bad2466da0c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -615,6 +615,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)

[ ... ]

> +	/* MQPRIO exposes only min/max rate, not burst.  Pass burst 0 so
> +	 * otx2_get_egress_burst_cfg() programmes the largest burst the NIX
> +	 * encoding supports (CN10K_MAX_BURST_SIZE on CN10K).  This differs
> +	 * from the 65536 byte default used in the HTB path, which is a
> +	 * kernel-side default when no explicit burst is configured, not a
> +	 * hardware cap.
> +	 *
> +	 * mqprio setup restarts the netdev (otx2_mqprio_restart_netdev),
> +	 * which resets MDQ shapers to zero.  Program both PIR and CIR on
> +	 * every update so omitted rates are applied explicitly rather than
> +	 * relying on stale hardware state.
> +	 */
> +	req->reg[n] = NIX_AF_MDQX_PIR(smq);
> +	if (maxrate) {
> +		rate = otx2_convert_rate(maxrate);
> +		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 0);
> +	} else {
> +		req->regval[n] = 0;
> +	}

[Severity: Medium]
Does passing burst 0 here make the configured rate ineffective for bursty
traffic?  In otx2_get_egress_burst_cfg() the burst == 0 case selects the
largest encodable bucket:

	} else {
		/* burst 0: largest encodable burst (CN10K_MAX_BURST_SIZE on
		 * CN10K), not a minimal burst.
		 */
		*burst_exp = MAX_BURST_EXPONENT;
		*burst_mantissa = max_mantissa;
	}

That encodes 130,816 bytes on OTx2 and 8,453,888 bytes on CN10K.  With
max_rate 2 Mbps and an 8.45 MB bucket, an idle queue accumulates roughly
33 seconds worth of credit that can be released at line rate before CIR/PIR
starts limiting.

The HTB path uses 65536 bytes for the same registers.  Was a smaller,
rate-derived burst considered for the mqprio path?

> +
> +	/* CIR+PIR support is required and checked at mqprio setup. */
> +	req->reg[n] = NIX_AF_MDQX_CIR(smq);

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
> @@ -844,6 +987,7 @@ void otx2_txschq_stop(struct otx2_nic *pfvf)
>  
>  	/* Clear the txschq list */
>  	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
> +		pfvf->hw.txschq_cnt[lvl] = 0;
>  		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
>  			pfvf->hw.txschq_list[lvl][schq] = 0;
>  	}

[Severity: Medium]
Can this new zeroing produce a division by zero in otx2_get_smq_idx()?
That helper has no zero check:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:otx2_get_smq_idx() {
	...
	idx = qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ];
	smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][idx];
	...
}

After a failed otx2_open() that unwinds through err_free_txsch with pf->pfc_en
set, otx2_txschq_stop() zeroes txschq_cnt[] but that unwind does not call
otx2_pfc_txschq_stop(), so pfvf->pfc_alloc_status[prio] stays true.  A later
'dcb pfc set' clearing such a priority takes the disable branch of
otx2_pfc_txschq_update(), which clears pfc_alloc_status[prio] and then calls
otx2_pfc_update_sq_smq_mapping() -> otx2_get_smq_idx(pfvf, prio), i.e.
prio % 0.

On arm64 the divide returns 0 rather than trapping, so the SQ context ends up
programmed with SMQ index 0 (which this same loop just zeroed); on a
64BIT && COMPILE_TEST build it is a divide-error Oops, and UBSAN flags it.
Before this patch the counts retained their last non-zero values after a
stop, so the divisor was never 0.

Would a zero check in otx2_get_smq_idx(), or leaving the counts alone here,
be preferable?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 32582b6347ea..5ff99ad986d0 100644
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
> +

[Severity: Medium]
Does this new failure branch leak pf->refill_wrk?

The array is allocated in otx2_config_nix_queues(), reached from
otx2_init_hw_resources() just above:

	pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
					sizeof(struct refill_work), GFP_KERNEL);

The only place it is cancelled and freed is otx2_stop():

	for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
	devm_kfree(pf->dev, pf->refill_wrk);

and that function returns early when OTX2_FLAG_INTF_DOWN is set.  Neither
err_free_hw nor err_free_mem touches it, and the next open overwrites the
pointer.

Because an otx2_mqprio_up() failure is sticky (the cached rates are
unchanged), each 'ip link set up' retry leaks another cq_cnt-sized array
until device detach.  The gap in the unwind chain itself predates this
patch, but this adds a new and easily repeated branch into it.

>  	/* Register NAPI handler */
>  	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
>  		cq_poll = &qset->napi[qidx];
> @@ -2205,6 +2214,7 @@ int otx2_open(struct net_device *netdev)
>  	free_irq(vec, pf);
>  err_disable_napi:
>  	otx2_disable_napi(pf);
> +err_free_hw:
>  	otx2_free_hw_resources(pf);
>  err_free_mem:
>  	otx2_free_queue_mem(qset);
> @@ -2280,6 +2290,7 @@ int otx2_stop(struct net_device *netdev)
>  	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
>  		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
>  
> +	synchronize_net();
>  	otx2_free_queue_mem(qset);

[Severity: Medium]
Could the commit message mention this hunk and the txschq_cnt zeroing in
otx2_txschq_stop()?  Both change code shared by every PF/VF configuration,
not just the mqprio path:

 - synchronize_net() here runs on every interface down (and via
   rtnl_is_locked() that is synchronize_rcu_expedited()), for all users.
 - zeroing pfvf->hw.txschq_cnt[lvl] changes a global invariant, since that
   value is the modulo divisor in otx2_get_smq_idx().

What problem do they fix, and are they required by this feature or
independent fixes that could be separate patches?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index ddb46b580c3b..edd7c02efb47 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -31,6 +34,20 @@
>  
>  #define MCAST_INVALID_GRP		(-1U)
>  #define RATE_MANTISSA_BITS		8
> +/* Min per-queue egress shaping rate the NIX TLX encoder supports (2 Mbps). */
> +#define OTX2_MQPRIO_MIN_RATE_BYTES_PS	250000ULL
> +
> +static u64 otx2_mqprio_max_rate_bytes_ps(struct otx2_nic *pfvf)
> +{
> +	u64 max_burst;
> +
> +	if (is_dev_otx2(pfvf->pdev))
> +		max_burst = MAX_BURST_SIZE;
> +	else
> +		max_burst = CN10K_MAX_BURST_SIZE;
> +
> +	return (max_burst * 1000000ULL) / 8ULL;
> +}

[Severity: Medium]
Should the maximum rate be derived from the burst-size constants?

MAX_BURST_SIZE (130816) and CN10K_MAX_BURST_SIZE (8453888) are byte-count
caps of the TLX BURST_EXPONENT/BURST_MANTISSA encoder and carry no rate
meaning.  The rate ceiling comes from MAX_RATE_EXPONENT (0xF) and
MAX_RATE_MANTISSA (0xFF) in otx2_get_egress_rate_cfg(), i.e.
2 * ((256 + 255) << 15) / 256 = 130,816 Mbps on both OTx2 and CN10K.

The OTx2 arithmetic happens to coincide (130816 * 1e6 / 8 = 16.352 GB/s =
130,816 Mbps), but on CN10K this advertises ~1.0567e12 B/s, about 8.45 Tbps,
roughly 65x the real ceiling.

In otx2_mqprio_rate_valid() the remaining checks do not close the gap:

	if (rate_bytes_ps > otx2_mqprio_max_rate_bytes_ps(pfvf))
		return false;

	if (rate_bytes_ps > div_u64(U64_MAX, 8))
		return false;

	mbps = otx2_convert_rate(rate_bytes_ps);
	return ilog2(mbps / 2) <= MAX_RATE_EXPONENT;

ilog2(65535) is 15, so 130,817..131,071 Mbps still pass and are then
silently floored to 130,816 Mbps by the mantissa clamp in
otx2_get_egress_rate_cfg().  For min_rate/CIR that means the hardware
guarantees less than what was accepted.

The 'rate_bytes_ps > div_u64(U64_MAX, 8)' test also looks unreachable, since
the earlier ceiling check already rejects everything above ~1e12.

[ ... ]

> +static void otx2_mqprio_netdev_tc_work(struct work_struct *work)
> +{
> +	struct otx2_mqprio *mqprio = container_of(work, struct otx2_mqprio,
> +						  netdev_tc_work);
> +	struct otx2_nic *pfvf = container_of(mqprio, struct otx2_nic, mqprio);
> +
> +	if (!pfvf->mqprio.rate_limit || !pfvf->old_mq_snap)
> +		return;
> +
> +	rtnl_lock();
> +	otx2_mqprio_apply_snap_netdev(pfvf->netdev, pfvf->old_mq_snap);
> +	rtnl_unlock();
> +}

[Severity: High]
Are these two fields safe to test before taking rtnl_lock()?

Both mqprio.rate_limit and old_mq_snap are written only under RTNL, and this
work is always queued while the caller already holds RTNL, so the worker
necessarily blocks and runs in some later RTNL section.  A 'tc qdisc del' in
that window runs otx2_teardown_tc_mqprio() -> otx2_mqprio_clear_sw():

	pfvf->mqprio.rate_limit = false;
	otx2_mqprio_clear_replace_state(pfvf);
	if (!otx2_mqprio_keep_netdev_tc(pfvf))
		netdev_set_num_tc(netdev, 0);
	otx2_mqprio_free_cache(pfvf);

That clears rate_limit and zeroes num_tc, but does not free old_mq_snap and
does not cancel this work.  The worker then wins the lock and re-installs
num_tc, tc_to_txq and prio_tc_map for an offload that no longer exists.

Since otx2_set_channels() only blocks queue-count changes while
mqprio.rate_limit is true, a subsequent channel reduction can then leave the
re-published offset+count beyond real_num_tx_queues, so
skb_tx_hash()/netdev_pick_tx() pick queue indices outside the valid range.

Should the guard be re-evaluated inside the rtnl_lock() section?

[ ... ]

> +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> +{
[ ... ]
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			return err;
> +	}
[ ... ]
> +	if (netif_running(netdev)) {
> +		err = otx2_mqprio_restart_netdev(netdev, true);
> +		if (err)
> +			return err;
> +	} else if (pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]) {
> +		err = otx2_mqprio_up(pfvf);
> +		if (err)
> +			return err;
> +	}

[Severity: Medium]
What state is the interface left in when the rollback itself fails?

This function is fallible at four points (otx2_mqprio_alloc_cache(),
otx2_nix_tm_clear_queue_shaper(), otx2_mqprio_restart_netdev() and
otx2_mqprio_up()), and the software rates are installed before hardware is
touched.  Each early 'return err' precedes the restart/up that would rebuild
the configuration.

otx2_nix_tm_clear_queue_shaper() is also split into several mailbox batches:

	err = otx2_nix_tmq_reg_write(pfvf, cnt, reg_addr, reg_val);
	if (err)
		goto fail;

so an error can be returned after earlier batches already zeroed some MDQ
CIR/PIR registers.

The caller only logs restore_err and returns, so the interface keeps running
with partially programmed or fully cleared limits that no longer match the
software cache, while the surviving old qdisc still reports hw_offload.  If
ndo_open() failed during the rollback, otx2_mqprio_restart_netdev() also
calls otx2_mqprio_clear_sw(), leaving the old offloaded qdisc installed with
rate_limit disabled.

> +/* Offloaded mqprio replaced by software mqprio installs netdev TC layout in
> + * mqprio_init() before the old offload instance is destroyed during graft.
> + */
> +static bool otx2_mqprio_keep_netdev_tc(struct otx2_nic *pfvf)
> +{
> +	struct Qdisc *qdisc = rtnl_dereference(pfvf->netdev->qdisc);
> +
> +	return qdisc && qdisc->ops && !strcmp(qdisc->ops->id, "mqprio");
> +}

[Severity: Medium]
Is a driver expected to inspect netdev->qdisc and strcmp() the qdisc
ops->id string to infer which stage of a graft it is in?  There is no
exported contract for that, so this ties the driver to the internal
ordering of qdisc_graft()/notify_and_destroy().

Related: otx2_setup_tc_root() treats the generic TC_ROOT_GRAFT notification
as a private "my replace committed" flag while dropping the discriminators
the core supplies.  qdisc_offload_graft_root() in net/sched/sch_api.c fills
in both:

	struct tc_root_qopt_offload graft_offload = {
		.command	= TC_ROOT_GRAFT,
		.handle		= new ? new->handle : 0,
		.ingress	= (new && new->flags & TCQ_F_INGRESS) || ...

and the notification is emitted for every root graft, including
ingress/clsact.  Could the commit point be derived from state the driver
owns instead?

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
> +
> +	otx2_mqprio_clear_sw(pfvf);
> +
> +	return 0;
> +}

[Severity: High]
Who consumes this error?  In net/sched/sch_mqprio.c the teardown caller has
a void interface and discards the return value:

static void mqprio_disable_offload(struct Qdisc *sch)
{
	...
		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
					      &mqprio);

and mqprio_destroy() destroys the qdisc unconditionally.  So when
otx2_nix_tm_clear_queue_shaper() fails (otx2_nix_tmq_reg_write() returns
-ENOMEM on message-alloc failure, and propagates mailbox timeout / AF
errors), the qdisc goes away while the driver keeps mqprio.rate_limit true,
the rate cache allocated and netdev->num_tc set, with no qdisc left to retry
teardown.

>From then on otx2_set_channels(), otx2_xdp_setup(), otx2_dcbnl_ieee_setpfc()
and otx2_qos_root_add() reject forever, otx2_txsch_alloc() keeps requesting
non_qos_queues SMQs, otx2_txschq_config() keeps re-parenting MDQs to TL4[0],
and the stale rates are re-applied on every open.

Worse, since the replace state machine keys off mqprio.rate_limit, a later
'tc qdisc add ... mqprio hw 1' is then classified as a replace, and its
deletion takes the replace-commit branch in otx2_teardown_tc_mqprio() that
returns 0 without any shaper clear, clear_sw or netdev restart.

Since ndo_stop() frees the hierarchy anyway, would it be better to
reconcile the software state unconditionally here and only warn about the
mailbox failure?

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> +{
> +	struct otx2_nic *pfvf = netdev_priv(netdev);
> +	const struct net_device_ops *ops = netdev->netdev_ops;
> +	bool running = netif_running(netdev);
> +	int err;
[ ... ]
> +	if (running) {
> +		clear_bit(__LINK_STATE_START, &netdev->state);
> +		smp_mb__after_atomic(); /* Commit netif_running(). */
> +	}
> +
> +	err = ops->ndo_stop(netdev);
> +	if (err) {
> +		if (running)
> +			set_bit(__LINK_STATE_START, &netdev->state);
> +		return err;
> +	}
[ ... ]
> +	err = ops->ndo_open(netdev);
> +	if (!err && running) {
> +		set_bit(__LINK_STATE_START, &netdev->state);
> +	} else if (err) {
[ ... ]
> +		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}

[Severity: High]
Can a driver write the core-owned __LINK_STATE_START bit like this?
netif_running() is defined as test_bit(__LINK_STATE_START, &dev->state) and
that bit is set and cleared only by __dev_open()/__dev_close_many().

While it is cleared here the netdev is in a state the core never produces:
IFF_UP set but netif_running() false.  Code that keys off netif_running()
then reads it as "interface down", including otx2_set_channels(),
otx2_xdp_setup(), otx2_mqprio_down() and otx2_mqprio_restore_old().

Separately, is calling netif_close() on its own netdev from inside
ndo_setup_tc() acceptable?  A plain 'tc qdisc add/replace ... mqprio ...
hw 1' would then clear IFF_UP and emit NETDEV_GOING_DOWN/NETDEV_DOWN
(address and route teardown, bond/bridge reactions) as a side effect of a
qdisc operation.

netif_close() also performs dev_deactivate_many(), which is exactly what the
comment a few lines above in this same function forbids:

 * Do not call dev_deactivate()/dev_activate() here.  On replace,
 * qdisc_graft() already deactivates qdiscs around offload teardown;

This path is reachable in practice because the patch widens the SMQ request
to pfvf->hw.non_qos_queues in otx2_txsch_alloc(), so ndo_open() can fail on
AF refusal or a mailbox timeout.

[ ... ]

> +static int otx2_setup_tc_mqprio(struct net_device *netdev,
> +				struct tc_mqprio_qopt_offload *mqprio)
> +{
[ ... ]
> +	if (!if_up) {
> +		netdev_err(netdev, "mqprio: setup requires interface UP\n");
> +		NL_SET_ERR_MSG_MOD(extack, "mqprio: setup requires interface UP");
> +		return -EOPNOTSUPP;
> +	}
[ ... ]
> +		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE &&
> +		    !otx2_mqprio_rate_valid(pfvf, max_rate)) {
> +			netdev_err(netdev,
> +				   "mqprio: max_rate %llu for tc %d is outside hardware limits\n",
> +				   max_rate, tc);
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "mqprio: max_rate %llu for tc %d is outside hardware limits",
> +					       max_rate, tc);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	err = otx2_mqprio_validate_txqs(netdev, extack, qopt);
> +	if (err)
> +		return err;

[Severity: High]
Do these early returns need the same compensation as the cleanup label?

All eleven validation returns above (interface not UP, wrong shaper, no
CIR+PIR, SDP rep, PFC, XDP, HTB, min > max, per-TC multi-queue rate, rate
outside limits, otx2_mqprio_validate_txqs()) bypass cleanup: and therefore
otx2_mqprio_defer_netdev_tc_restore().

When an offload is already active, mqprio_init() of the new instance has
already installed its TC layout, and on error mqprio_destroy() runs with
priv->hw_offload == 0:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

So dev->num_tc becomes 0 while pfvf->mqprio.rate_limit stays true and the
MDQ CIR/PIR shapers stay programmed and get re-applied by otx2_mqprio_up()
on the next open.  The prio->tc->txq mapping of the still-active offload is
silently gone.

A single 'tc qdisc replace dev X root handle 8002: mqprio ... hw 1' with
max_rate below OTX2_MQPRIO_MIN_RATE_BYTES_PS reaches this.

[ ... ]

> +	netdev_set_num_tc(netdev, pfvf->cur_mq_snap->num_tc);
> +	for (i = 0; i < pfvf->cur_mq_snap->num_tc; i++)
> +		netdev_set_tc_queue(netdev, i, pfvf->cur_mq_snap->count[i],
> +				    qopt->offset[i]);
> +
> +	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
> +
> +	if (replacing) {
> +		pfvf->mqprio.replace_setup_done = true;
> +		pfvf->mqprio.replace_graft_done = false;
> +	} else {
> +		otx2_mqprio_snap_commit(pfvf);
> +	}

[Severity: High]
What happens when a software mqprio root is replaced by an offloaded one?

mqprio.rate_limit is false in that case, so 'replacing' is false, the
snapshot is committed and no restore is scheduled.  qdisc_graft() then
destroys the old software instance, whose mqprio_destroy() takes the
'else netdev_set_num_tc(dev, 0);' branch because hw_offload is unset, wiping
the layout just installed here.  mqprio_attach() for the new instance only
attaches child qdiscs; it does not reinstall the layout.

The command reports success and the shapers are programmed, but dev->num_tc
is 0 so skb_tx_hash()/netdev_pick_tx() ignore the requested prio->tc->txq
mapping.  otx2_mqprio_keep_netdev_tc() only covers the opposite direction
(offloaded replaced by software).

> +
> +	return 0;
> +
> +cleanup:
> +	qopt->hw = 0;
> +	if (replacing) {
> +		int restore_err = otx2_mqprio_restore_old(pfvf);
[ ... ]
> +		} else {
> +			netdev_err(netdev,
> +				   "mqprio: replace failed; prior configuration restored\n");
> +			if (extack)
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "mqprio: replace failed; prior configuration restored");
[ ... ]
> +			otx2_mqprio_defer_netdev_tc_restore(pfvf);
> +		}

[Severity: Medium]
Is "prior configuration restored" accurate at this point?  The netdev TC
layout part (num_tc, tc_to_txq, prio_tc_map) is only scheduled here, and the
worker can decline to do anything at all:

	if (!pfvf->mqprio.rate_limit || !pfvf->old_mq_snap)
		return;

Between mqprio_destroy() of the failed instance running
netdev_set_num_tc(dev, 0) and the work item acquiring RTNL, the surviving
old mqprio qdisc has a TC layout the netdev no longer reflects, and if the
guard fails the restore never happens and nothing is logged.

The commit message says failed setup "rolls back via netdev restart", which
reads as a synchronous, complete rollback.  Could both the message and this
string reflect that the layout restore is asynchronous and best effort?

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
Is TC_ROOT_GRAFT guaranteed to arrive?  In net/sched/sch_api.c the notifier
is skipped when the feature bit is off:

qdisc_offload_graft_helper() {
	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
		return;

while mqprio_enable_offload() calls ndo_setup_tc() directly with no such
check.  In otx2_probe() the bit is offered but not enabled by default:

	netdev->features |= netdev->hw_features;

	/* HW supports tc offload but mutually exclusive with n-tuple filters */
	if (otx2_test_flag(pf, OTX2_FLAG_TC_FLOWER_SUPPORT))
		netdev->hw_features |= NETIF_F_HW_TC;

NETIF_F_HW_TC is added to hw_features after features was assigned, so
tc_can_offload(dev) is false unless the admin runs
'ethtool -K ethX hw-tc-offload on' (otx2_vf.c has the same pattern).

So on a successful 'tc qdisc replace ... mqprio ... hw 1' in the default
configuration, replace_graft_done stays false, and when the old instance is
destroyed otx2_teardown_tc_mqprio() takes:

		else
			err = otx2_mqprio_restore_old(pfvf);

reverting to the previous rates and queue layout even though the new qdisc
was grafted.  The command reports success while the hardware keeps the old
configuration.

[ ... ]

> @@ -1625,13 +2433,17 @@ int otx2_init_tc(struct otx2_nic *nic)
>  		return -EINVAL;
>  	}
>  
> +	INIT_WORK(&nic->mqprio.netdev_tc_work, otx2_mqprio_netdev_tc_work);
> +
>  	return 0;
>  }

[Severity: Medium]
Is this INIT_WORK too late?  otx2_init_tc() runs after register_netdev() in
both otx2_probe() and otx2vf_probe(), so ndo_setup_tc - including the new
TC_SETUP_QDISC_MQPRIO handler that can reach schedule_work() through
otx2_mqprio_defer_netdev_tc_restore() - is reachable from userspace while
the work_struct is still all zeroes and work->func is NULL.

The window also needs 'replacing == true', i.e. a prior successful offload
plus a failing replace in that interval, so it is narrow.  Would moving
otx2_init_tc() before register_netdev(), or the INIT_WORK earlier, close it?

>  EXPORT_SYMBOL(otx2_init_tc);
>  
>  void otx2_shutdown_tc(struct otx2_nic *nic)
>  {
> +	cancel_work_sync(&nic->mqprio.netdev_tc_work);
>  	otx2_destroy_tc_flow_list(nic);
> +	otx2_mqprio_snap_destroy(nic);
>  }
>  EXPORT_SYMBOL(otx2_shutdown_tc);

[Severity: High]
Is this the right place for the cancel?  This is the only cancel_work_sync()
for netdev_tc_work, and both otx2_remove() and otx2vf_remove() call
otx2_shutdown_tc() after unregister_netdev().

A work item queued shortly before removal blocks on rtnl_lock() while
unregister_netdev() closes the device and destroys its qdiscs, then wins the
lock and calls netdev_set_num_tc()/netdev_set_tc_queue()/
netdev_set_prio_tc_map() on a NETREG_UNREGISTERED device (those also walk
dev->_tx and reset XPS).

On the probe unwind the ordering is inverted:

	err_pf_sriov_init:
		otx2_unregister_dl(pf);
		otx2_shutdown_tc(pf);
	err_mcam_flow_del:
		otx2_mcam_flow_del(pf);
	err_unreg_netdev:
		unregister_netdev(netdev);

Paths entering at err_mcam_flow_del skip the cancel entirely, and paths
entering above it cancel while the netdev is still registered and
ndo_setup_tc still reachable, so the work can be re-armed after the cancel
and then run against memory released by free_netdev(), which is a
use-after-free of the struct otx2_nic in the netdev private area.

The mqprio teardown path does not cancel a pending work either; it relies
only on the flag re-check inside the worker.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> index f160b1618efa..9ef55a6db50b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> @@ -118,6 +118,9 @@ static void otx2_config_sched_shaping(struct otx2_nic *pfvf,
>  	/* configure PIR */
>  	maxrate = (node->rate > node->ceil) ? node->rate : node->ceil;
>  
> +	/* 65536 is the kernel-side default burst when HTB does not supply an
> +	 * explicit value, not the NIX hardware maximum (CN10K_MAX_BURST_SIZE).
> +	 */
>  	cfg->regval[*num_regs] =
>  		otx2_get_txschq_rate_regval(pfvf, maxrate, 65536);
>  	(*num_regs)++;

[Severity: Low]
This isn't a bug, but does the "when HTB does not supply an explicit value"
wording describe a condition that exists?  struct tc_htb_qopt_offload has no
burst member (otx2_setup_tc_htb() uses only rate, ceil, prio and quantum),
and both calls here pass the literal 65536 unconditionally, for PIR and for
CIR.  The same wording appears in the new comment in
otx2_nix_tm_set_queue_shaper().

Thanks for considering these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918015906.1255204-1-rkannoth%40marvell.com
