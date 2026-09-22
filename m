Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027412576E;
	Tue, 22 Sep 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043555; cv=none; b=Jc0jnfmWYa54Gmx9Oz42jIfECvvVCqofUXZp9dsN++j6EyDpFLjSI60IYmvwXidKOCt4oFjKcxnnyJpNQfvdCuXDMTdJEMw5td/qyG+D8zgTqvXiSz74CRbU/gQA0AAk4iaAp6ylgMZTgX1aRykvYUXJyn02MfpFCTNB9uD4ejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043555; c=relaxed/simple;
	bh=36w0uOA8xBUaSBh4BRElZGfhoptdqCNPDyWorbQqLPY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsR2wX+miu9lr96JsEGe4VnTJ9+oxDmiLE75/Z2AyG5ENmkF/rI+APXh3j/NEolbgaWX7k9Wh7blhSW6fS5eONXcGhqeMzU+/lGw/Bm3+1tKdT92g6XPRgaSm68uigo+jEe9GDYPffWvqatdD5CKP0ftroGfJF7NlIjyW/Kq1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJYiFBv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJYiFBv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF261F000FF;
	Tue, 22 Sep 2026 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043553;
	bh=zMsBvXOafKOzcs4SC4OLE50vp4X4cJX15R8xbJczKT8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XJYiFBv675+yy1IIwwrTQmX2ahbbzYobMkHih1WvdHr+u2h7A3b2KMlOL2IwMmEtW
	 pkrAtSv6Xn7EbMVXLkPoaN7zVGBPqV4C8H55+rrHwsTh0MwHxo+4uZRhZlvY79LZr9
	 HJEFe+4UTn3ZKVayvUfYyrAopWEMk2dyMkQdlDRNjbQV9CEFyfn9vNn0VfQmacV4Fp
	 R0Fj1QYU0IXf74VAIIWhWK3jCW7mTWcgiWzAV2fwIK7PDuYWoGwjgxmFUimaIlbt/C
	 YcGa3Wfx+33OaeYDjLHS33Tn1jGOjXw7A8DOGeZxvSDcK5rSuTM1vyc3agmYvOPmnU
	 rEmmXaHnf4e4g==
Subject: Re: [PATCH v16 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Tue, 22 Sep 2026 02:19:12 +0000
Message-ID: <179004355217.2160803.3882434893952030819@kernel.org>
In-Reply-To: <20260918015906.1255204-2-rkannoth@marvell.com>
References: <20260918015906.1255204-2-rkannoth@marvell.com>
X-sashiko-severity: Medium
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

Critical: 0 (1) · High: 0 (4) · Medium: 2 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The changelog misdescribes the patch.
- [Medium] The new helper otx2_sync_flags_from_rep() replaces the single-
  word store `priv->flags = rep->flags;` with a loop of 22 independent…

Pre-existing issues:
- [Critical] otx2_sync_flags_from_rep() copies the *entire* flag
  namespace (bits 0..OTX2_FLAG_MAX-1) from a representor's…
- [High] rvu_rep_mcam_flow_init() unconditionally allocates rep->flow_cfg
  (kzalloc_objs) and rep->flow_cfg->flow_ent (kcalloc) on every…
- [High] rvu_rep_destroy() dereferences the representor structure after
  the memory holding it has been freed: `rep` is obtained from…
- [High] rvu_rep_get_stats64() re-arms the per-representor delayed work
  `rep->stats_wrk` (100 ms) on every statistics read, but nothing…
- [High] rvu_rep_mcam_flow_init() calls `mutex_unlock(&priv->mbox.lock)`
  at its exit label but never acquires that mutex anywhere in the…
- [Medium] In otx2_tc_del_flow() the TC-mark bookkeeping is inverted: `if
  (!refcount_dec_and_test(&flow_cfg->mark_flows)) otx2_clear_flag(nic,…
- [Medium] In otx2_config_hwtstamp_set(), OTX2_FLAG_PTP_ONESTEP_SYNC is
  only cleared in the HWTSTAMP_TX_OFF case.
- [Medium] otx2_config_hwtstamp_set() ignores the return values of
  otx2_config_hw_rx_tstamp() and otx2_config_hw_tx_tstamp().

--

octeontx2: use atomic bitops for PF/VF and rep flags

This converts struct otx2_nic::flags and struct rep_dev::flags from u64
bitmask constants to an unsigned long bitmap driven by set_bit()/
clear_bit()/test_bit(), adds otx2_set_flag()/otx2_clear_flag()/
otx2_test_flag() wrappers, and introduces otx2_sync_flags_from_rep() to
copy representor state into the shared PF mailbox context.  The
representor "VF initialized" bit moves out of rep.h into the shared
enum.

No Link: tags in the commit header.

A few questions about the changelog and about some paths this touches.

> Replace non-atomic u64 flag read-modify-write with unsigned long
> bitmaps and set_bit/clear_bit/test_bit access across the NIC driver.

[Severity: Medium]

Which concurrent writer pairs are being fixed here?  The changelog states
a race motivation but no symptom, no reproducer and no Fixes: tag, so it
is hard to tell whether this is a bug fix or a net-next cleanup.

> Define representor VF initialization as OTX2_REP_VF_INITIALIZED (bit 21)
> in the shared flag namespace.

The enum added to otx2_common.h spells this OTX2_FLAG_REP_VF_INITIALIZED,
not OTX2_REP_VF_INITIALIZED.

Moving this bit also looks like it silently fixes a real collision.  In
the baseline, rep.h had:

	#define RVU_REP_VF_INITIALIZED		BIT_ULL(0)

and otx2_common.h had:

	#define OTX2_FLAG_RX_TSTAMP_ENABLED	BIT_ULL(0)

while rvu_rep_setup_tc_cb() did:

	priv->flags = rep->flags;

So a representor whose VF was reported initialized turned on
OTX2_FLAG_RX_TSTAMP_ENABLED on the representor PF context, and
otx2_set_rxtstamp() then does:

	timestamp = pfvf->ptp->convert_rx_ptp_tstmp(*(u64 *)data);

rvu_rep_probe() never calls otx2_ptp_init(), so pfvf->ptp is NULL there.
Should the bit relocation be split into its own patch with a Fixes: tag
so it can be picked up for stable?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 5850bc1870a1..90cf302bbe6d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

[ ... ]

> @@ -593,6 +598,34 @@ struct otx2_nic {
>  	unsigned long		*af_xdp_zc_qidx;
>  };
>  
> +static inline void otx2_set_flag(struct otx2_nic *nic, unsigned int flag)
> +{
> +	set_bit(flag, &nic->flags);
> +}
> +
> +static inline void otx2_clear_flag(struct otx2_nic *nic, unsigned int flag)
> +{
> +	clear_bit(flag, &nic->flags);
> +}
> +
> +static inline bool otx2_test_flag(struct otx2_nic *nic, unsigned int flag)
> +{
> +	return test_bit(flag, &nic->flags);
> +}
> +
> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned int flag;
> +
> +	for (flag = 0; flag < OTX2_FLAG_MAX; flag++) {
> +		if (test_bit(flag, src_flags))
> +			set_bit(flag, &dst->flags);
> +		else
> +			clear_bit(flag, &dst->flags);
> +	}
> +}
> +

[Severity: Medium]

Can readers now observe intermediate states that never existed before?
The previous code published the whole word with a single store:

	priv->flags = rep->flags;

This loop turns that into 22 independent read-modify-write operations on
a word that is read locklessly from softirq context in otx2_napi_handler(),
otx2_rcv_pkt_handler() and otx2_tx_napi_handler().  Per-bit atomics do
not give an atomic snapshot of the word.

otx2_tx_napi_handler() samples the same bit twice:

	if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
		ndev = pfvf->reps[qidx]->netdev;
	...
		if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
			qidx = 0;
		txq = netdev_get_tx_queue(ndev, qidx);

If the bit changes between the two reads, ndev and the qidx clamp
disagree.

The loop also reads src_flags one bit at a time while
rvu_rep_state_evt_handler() concurrently does
set_bit()/clear_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags) from the
mailbox up-notify handler, so the copied state can straddle a transition.

Would composing the value in a local unsigned long and publishing it with
a single store (or serialising the word against the NAPI readers) be
better here?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index c0e2100de1d9..32582b6347ea 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -2478,9 +2478,9 @@ static int otx2_config_hw_rx_tstamp(struct otx2_nic *pfvf, bool enable)
>  
>  	mutex_unlock(&pfvf->mbox.lock);
>  	if (enable)
> -		pfvf->flags |= OTX2_FLAG_RX_TSTAMP_ENABLED;
> +		otx2_set_flag(pfvf, OTX2_FLAG_RX_TSTAMP_ENABLED);
>  	else
> -		pfvf->flags &= ~OTX2_FLAG_RX_TSTAMP_ENABLED;
> +		otx2_clear_flag(pfvf, OTX2_FLAG_RX_TSTAMP_ENABLED);
>  	return 0;
>  }

[Severity: Medium]

This is a pre-existing issue and not something this patch introduces, but
can the flag and the saved configuration get out of sync here?

otx2_config_hw_rx_tstamp() (and otx2_config_hw_tx_tstamp()) return early
on mailbox failure, before reaching these lines:

	req = otx2_mbox_alloc_msg_cgx_ptp_rx_enable(&pfvf->mbox);
	...
	if (!req) {
		mutex_unlock(&pfvf->mbox.lock);
		return -ENOMEM;
	}

	err = otx2_sync_mbox_msg(&pfvf->mbox);
	if (err) {
		mutex_unlock(&pfvf->mbox.lock);
		return err;
	}

otx2_config_hwtstamp_set() discards those return values, then does:

	pfvf->tstamp = *config;

	return 0;

so ndo_hwtstamp_get() reports timestamping enabled while
otx2_set_rxtstamp()/otx2_set_txtstamp() still see the flag clear.  Should
the errors be propagated?

[ ... ]

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

This is also pre-existing rather than introduced here, but is
OTX2_FLAG_PTP_ONESTEP_SYNC left stale on a direct transition from
HWTSTAMP_TX_ONESTEP_SYNC to HWTSTAMP_TX_ON?

The flag is only cleared in the HWTSTAMP_TX_OFF case, and a second
SIOCSHWTSTAMP with tx_type = HWTSTAMP_TX_ON enters the shared
case HWTSTAMP_TX_ON: directly.  pfvf->tstamp records the new request,
but otx2_set_txtstamp() still takes the one-step branch:

	if (unlikely(otx2_test_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC) &&
		     otx2_ptp_is_sync(skb, &ptp_offset, &udp_csum_crt))) {

so Sync packets keep getting originTimestamp/correction rewritten and the
SKBTX_IN_PROGRESS path is skipped.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf52..ddb46b580c3b 100644
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

This isn't a bug introduced by this patch, but is the test inverted?

mark_flows starts at the sentinel value 1 in otx2_mcam_entry_init():

	refcount_set(&flow_cfg->mark_flows, 1);

and otx2_tc_parse_actions() does refcount_inc() per marked rule.  With two
marked rules installed the counter is 3; deleting one leaves 2,
refcount_dec_and_test() returns false, and the negation therefore clears
OTX2_FLAG_TC_MARK_ENABLED while a marked rule is still installed.
otx2_rcv_pkt_handler() then stops doing:

	if (otx2_test_flag(pfvf, OTX2_FLAG_TC_MARK_ENABLED))
		skb->mark = parse->match_id;

for the surviving rule.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7..7df82c22cc12 100644
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

This is pre-existing and not caused by this patch, but can repeated tc
commands leak rep->flow_cfg and rep->flow_cfg->flow_ent without bound?

The three set_bit() calls only run when allocated is non-zero, and
OTX2_FLAG_TC_FLOWER_SUPPORT is the only gate against re-entry:

rvu_rep_setup_tc_cb()
	if (!test_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags))
		rvu_rep_mcam_flow_init(rep);

If the AF hands out zero entries, or the mbox alloc/sync fails and takes
one of the goto exit paths, the flag stays clear and every later tc
command re-enters:

rvu_rep_mcam_flow_init()
	rep->flow_cfg = kzalloc_objs(struct otx2_flow_config, 1);
	...
	rep->flow_cfg->flow_ent = kcalloc(count, sizeof(u16), GFP_KERNEL);

overwriting the previous pair with no unwind.  The function also returns 0
on that path and the caller ignores the return value.

Separately, rvu_rep_destroy() only does kfree(rep->flow_cfg), so
rep->flow_cfg->flow_ent looks like it is leaked for every representor at
teardown.

[Severity: High]

Still pre-existing rather than new here, but does this function unlock a
mutex it never took?  A few lines above these set_bit() calls:

	if (allocated)
		sort(&rep->flow_cfg->flow_ent[0], allocated,
		     sizeof(rep->flow_cfg->flow_ent[0]), mcam_entry_cmp, NULL);

	mutex_unlock(&priv->mbox.lock);

There is no mutex_lock(&priv->mbox.lock) anywhere in
rvu_rep_mcam_flow_init(), and rvu_rep_setup_tc_cb() does not hold it
either.  The mailbox traffic in the loop above
(otx2_mbox_alloc_msg_npc_mcam_alloc_entry(), otx2_sync_mbox_msg(),
otx2_mbox_get_rsp()) also runs without the lock, unlike
otx2_alloc_mcam_entries(), rvu_rep_notify_pfvf(), rvu_rep_get_stats() and
rvu_eswitch_config(), which all bracket alloc/sync with the mutex.  Can
this unlock break the critical section of whichever thread legitimately
owns the mailbox?

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
>  	priv->netdev = rep->netdev;
> -	priv->flags = rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);
>  	priv->pcifunc = rep->pcifunc;
>  	priv->flow_cfg = rep->flow_cfg;

[Severity: Critical]

This isn't a regression introduced by this patch, since the old
priv->flags = rep->flags had the same effect, but can this write past the
representor netdev's _tx[] array?

rep->flags only ever carries MCAM_ENTRIES_ALLOC / NTUPLE_SUPPORT /
TC_FLOWER_SUPPORT (from rvu_rep_mcam_flow_init()) and
REP_VF_INITIALIZED (from rvu_rep_state_evt_handler()).  The helper's else
branch therefore clears every PF-owned bit on the live datapath context,
including OTX2_FLAG_REP_MODE_ENABLED, which is set once in
rvu_rep_probe() and never restored:

rvu_rep_probe()
	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
	otx2_set_flag(priv, OTX2_FLAG_REP_MODE_ENABLED);

With that bit cleared, the next TX completion takes the non-rep branch in
otx2_tx_napi_handler() while priv->netdev is the representor netdev that
this function just installed:

	ndev = pfvf->netdev;
	...
		if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
			qidx = 0;
		txq = netdev_get_tx_queue(ndev, qidx);
		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);

Representors are allocated with alloc_etherdev(sizeof(*rep)) in
rvu_rep_create(), so num_tx_queues is 1, while qidx here runs up to
rep_cnt - 1.  netdev_get_tx_queue() only warns under DEBUG_NET and still
returns the pointer:

	DEBUG_NET_WARN_ON_ONCE(index >= dev->num_tx_queues);
	return &dev->_tx[index];

so netdev_tx_completed_queue() and netif_tx_wake_queue() then read and
write BQL state past the end of _tx[].

Clearing OTX2_FLAG_INTF_DOWN in the same loop also defeats the teardown
gating in rvu_rep_remove():

	if (!otx2_test_flag(priv, OTX2_FLAG_INTF_DOWN))
		rvu_rep_destroy(priv);

and clearing OTX2_FLAG_TC_MARK_ENABLED silently disables skb->mark for
already installed skbedit-mark rules.  Should the sync be restricted to
the bits a representor actually owns?

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

This is a pre-existing issue rather than one added here, but can
rep->stats_wrk still be queued after the representor is freed?

The tail of this function re-arms the work on every statistics read:

	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

and the worker dereferences the containing rep_dev plus the shared
mailbox:

rvu_rep_get_stats()
	rep = container_of(del_work, struct rep_dev, stats_wrk);
	priv = rep->mdev;

	mutex_lock(&priv->mbox.lock);

stats_wrk lives in the netdev private area, but nothing cancels it:
rvu_rep_destroy() free_netdev()s each representor, rvu_rep_free_cq_rsrc()
only synchronises NAPI and IRQs, and rvu_rep_rsrc_free() cancels only
pool_refill_work.  Is a cancel_delayed_work_sync(&rep->stats_wrk) missing
before free_netdev()?

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

This ordering is pre-existing and not changed by this patch, but does the
loop below read rep after the memory holding it is freed?

	free_netdev(rep->netdev);
	kfree(rep->flow_cfg);

rep_dev is the netdev private area:

rvu_rep_create()
	ndev = alloc_etherdev(sizeof(*rep));
	...
	rep = netdev_priv(ndev);

so free_netdev() releases the allocation that contains rep, and the next
statement reads rep->flow_cfg out of it and hands whatever it finds to
kfree().  Should flow_cfg be freed before free_netdev()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918015906.1255204-1-rkannoth%40marvell.com
