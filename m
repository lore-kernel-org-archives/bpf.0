Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FB4D0CD4
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644723; cv=none; b=HuDCvmOFbxAY1Zuki6iUj5clS2Dn8cjvCK7fGuxZRP4qO7TwN9a+cF/dcoK0vnAXN7MXe8XJnisIJydKAAaUvPEb50wPm8I0yuhFjeMPgRh1d3MRdsAr6PIotx5IdMOu3BBBfQNVSwe6/xSOPaDCBejvGDIAQ5++B6rDvWN2cLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644723; c=relaxed/simple;
	bh=0bw2h4ZOBh8AX1fT1vO8VUPWMePWJL8GfH0pZQCRJdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ5FbEyYvSI/MyQomRaCetLly9Ntr6kjC66Kevrx42CUl8rP6T0yQDd1NdsrlqYaskDlmXLtOHXVnnjG4iZy5qzmCj8xQM0v9AzgvsEHupDGqnlbSZkJ/c1iS4paeAKf/wQUexyCkCr4ZcenebIg9ehq/awvij+Z9YIu4KnWzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0kkaBSG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0kkaBSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789644718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnb//tFsg5BzopXonGLKWW1kkIfpGNCbJFvLNraa3dE=;
	b=T0kkaBSGUb3GoPJExljG/SrIcTZOaL0ovAADvsumk6Yse0m7PTtLMq7YKMswcPoAbFa4PE
	dy6S+Lx0r3JcJkk+P2po029ck893+MoKvDKxr2k6Lmytd2+C6Qulck2NgZ5Jw+haYo4p1U
	+g9yB+jssC+XrYXL1KNGk4ADx8+NqOc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-x-ZNq-MfO2Kr4hNT3B7XRQ-1; Thu,
 17 Sep 2026 07:31:52 -0400
X-MC-Unique: x-ZNq-MfO2Kr4hNT3B7XRQ-1
X-Mimecast-MFC-AGG-ID: x-ZNq-MfO2Kr4hNT3B7XRQ_1789644710
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 064321802658;
	Thu, 17 Sep 2026 11:31:50 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 133F3180034F;
	Thu, 17 Sep 2026 11:31:44 +0000 (UTC)
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
Subject: Re: [PATCH v15 net-next 1/2] octeontx2: use atomic bitops for PF/VF and rep flags
Date: Thu, 17 Sep 2026 13:31:38 +0200
Message-ID: <20260917113138.170959-1-pabeni@redhat.com>
In-Reply-To: <20260911105521.689565-2-rkannoth@marvell.com>
References: <20260911105521.689565-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2: use atomic bitops for PF/VF and rep flags

The patch converts struct otx2_nic::flags and struct rep_dev::flags from
u64 bitmasks to unsigned long bitmaps accessed with set_bit/clear_bit/
test_bit, adds otx2_set_flag()/otx2_clear_flag()/otx2_test_flag() helpers,
and replaces the representor to PF flag publication with a new
otx2_sync_flags_from_rep() helper.  RVU_REP_VF_INITIALIZED is folded into
the shared flag namespace as OTX2_REP_VF_INITIALIZED (bit 21).

A few questions below, mostly around the new sync helper and around
pre-existing issues in the representor paths that the patch touches.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index eecee612b7b2c..7e09c1444a6d5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -491,28 +491,29 @@ struct otx2_nic {
>  	u16			tx_max_pktlen;
>  	u16			rbsize; /* Receive buffer size */
>  
> -#define OTX2_FLAG_RX_TSTAMP_ENABLED		BIT_ULL(0)

[ ... ]

> +#define OTX2_FLAG_TC_MARK_ENABLED		17
> +#define OTX2_FLAG_REP_MODE_ENABLED		18
> +#define OTX2_FLAG_PORT_UP			19
> +#define OTX2_FLAG_IPSEC_OFFLOAD_ENABLED		20
> +#define OTX2_REP_VF_INITIALIZED			21
> +	unsigned long		flags;
>  	u64			*cq_op_addr;
>  
>  	struct bpf_prog		*xdp_prog;
> @@ -594,6 +595,34 @@ struct otx2_nic {
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
> +	for (flag = 0; flag <= OTX2_REP_VF_INITIALIZED; flag++) {
> +		if (test_bit(flag, src_flags))
> +			set_bit(flag, &dst->flags);
> +		else
> +			clear_bit(flag, &dst->flags);
> +	}
> +}
> +

[Severity: Critical]

This isn't a bug introduced by this patch, since the previous code did
priv->flags = rep->flags, but the new helper codifies the behaviour, so this
looks like the natural place to fix it.

Which bits can rep->flags ever hold?  The only writers are
rvu_rep_mcam_flow_init():

	if (allocated) {
		set_bit(OTX2_FLAG_MCAM_ENTRIES_ALLOC, &rep->flags);
		set_bit(OTX2_FLAG_NTUPLE_SUPPORT, &rep->flags);
		set_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags);
	}

and rvu_rep_state_evt_handler(), which sets or clears
OTX2_REP_VF_INITIALIZED.

Given that, does the else branch above erase PF owned state from the shared
eswitch context (priv is rep->mdev) on the very first tc filter add on any
representor, namely OTX2_FLAG_REP_MODE_ENABLED, OTX2_FLAG_INTF_DOWN,
OTX2_FLAG_PORT_UP and OTX2_FLAG_TC_MARK_ENABLED?
OTX2_FLAG_REP_MODE_ENABLED is only ever set in rvu_rep_probe(), so is there
anything that restores it for the remaining life of the PCI device?

With that bit gone, otx2_tx_napi_handler() takes the non representor path:

	if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
		ndev = pfvf->reps[qidx]->netdev;
	else
		ndev = pfvf->netdev;
	...
		if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
			qidx = 0;
		txq = netdev_get_tx_queue(ndev, qidx);
		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);

but rvu_rep_setup_tc_cb() has just stored priv->netdev = rep->netdev, and
rvu_rep_create() allocates every representor with alloc_etherdev(), i.e.
num_tx_queues is 1.  Can netdev_get_tx_queue(ndev, qidx) with qidx up to
rep_cnt - 1 then index past dev->_tx[0], so that
netdev_tx_completed_queue() and netif_tx_wake_queue() write outside the
netdev_queue array?

Two further effects of the same sweep: otx2_rcv_pkt_handler() stops doing
skb->mark = parse->match_id, because OTX2_FLAG_TC_MARK_ENABLED is only ever
produced in priv by otx2_tc_parse_actions() and is never mirrored back into
rep->flags, and clearing OTX2_FLAG_INTF_DOWN removes the guard in
otx2_napi_handler() that keeps NIX_LF_CINTX_ENA_W1S from re-arming CINTs
that rvu_rep_free_cq_rsrc() has just disabled.

Would copying only the representor owned bits (MCAM_ENTRIES_ALLOC,
NTUPLE_SUPPORT, TC_FLOWER_SUPPORT, REP_VF_INITIALIZED) and leaving the PF
owned bits untouched be a better fit here?

Separately, the loop bound hard-codes the current highest flag, so a bit 22
added later silently stops being synced.  Could a BUILD_BUG_ON or an
explicit mask be used instead?

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

This is a pre-existing issue and not introduced by this patch, but the
patch rewrites the statement, so a note here.

Is the sense of the test inverted?  mark_flows is initialised with
refcount_set(&flow_cfg->mark_flows, 1) in otx2_mcam_entry_init() and is
incremented once per rule in otx2_tc_parse_actions():

		otx2_set_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
		refcount_inc(&nic->flow_cfg->mark_flows);

With two mark rules installed the counter is 3.  Deleting one leaves 2, so
refcount_dec_and_test() returns false and OTX2_FLAG_TC_MARK_ENABLED is
cleared while a mark rule is still programmed in the MCAM.
otx2_rcv_pkt_handler() then stops executing skb->mark = parse->match_id for
the surviving rule.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 8d2d607bc92f9..f65ba44db60b6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

[ ... ]

> @@ -513,7 +513,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
>  		     ((u64)cq->cq_idx << 32) | processed_cqe);
>  
>  #if IS_ENABLED(CONFIG_RVU_ESWITCH)
> -	if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
> +	if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
>  		ndev = pfvf->reps[qidx]->netdev;
>  	else
>  #endif
> @@ -526,7 +526,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
>  
>  		if (qidx >= pfvf->hw.tx_queues)
>  			qidx -= pfvf->hw.xdp_queues;
> -		if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
> +		if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
>  			qidx = 0;
>  		txq = netdev_get_tx_queue(ndev, qidx);
>  		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);

[Severity: Medium]

This function reads OTX2_FLAG_REP_MODE_ENABLED twice, once to pick ndev and
once to clamp qidx.  The publication of these flags used to be a single word
store, priv->flags = rep->flags, and is now 22 independent set_bit() and
clear_bit() calls in otx2_sync_flags_from_rep(), run from process context in
rvu_rep_setup_tc_cb() with no lock or RCU against the NAPI readers that use
the same otx2_nic (rvu_rep_napi_init() sets cq_poll->dev = priv).

Can a poll running concurrently with the sync observe a combination that
neither the old nor the new state contains, for example ndev =
pfvf->reps[qidx]->netdev from the first test and an unclamped qidx from the
second?

The unconditional clear_bit() in the else branch also discards bits another
context set moments earlier, for instance rvu_rep_napi_init() clearing
INTF_DOWN, otx2_mbox_up_handler_rep_event_up_notify() setting PORT_UP, or
otx2_tc_parse_actions() setting TC_MARK_ENABLED, with no way for those
writers to notice the loss.  For a change whose stated purpose is to make
flag access race free, would restricting the sync to the representor owned
bits keep the single publication step intact?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> index 0e8a6a6486c4a..7808588a0234a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c

[ ... ]

> @@ -172,7 +172,7 @@ int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
>  	struct otx2_cq_poll *cq_poll = NULL;
>  	struct otx2_qset *qset = &pf->qset;
>  
> -	if (pf->flags & OTX2_FLAG_INTF_DOWN)
> +	if (otx2_test_flag(pf, OTX2_FLAG_INTF_DOWN))
>  		return -ENETDOWN;
>  
>  	if (queue_id >= pf->hw.rx_queues || queue_id >= pf->hw.tx_queues)

[Severity: High]

This is a pre-existing issue and not introduced by this patch, but does
converting the gate to test_bit() close the window here?

OTX2_FLAG_INTF_DOWN stays an ad-hoc lockless gate, and nothing protects
qset->napi between this test and its use further down the same function:

	cq_poll = &qset->napi[queue_id];
	if (!cq_poll)
		return -EINVAL;

	if (!napi_if_scheduled_mark_missed(&cq_poll->napi)) {

ndo_xsk_wakeup is reached from xsk_sendmsg() and xsk_poll() without RTNL, so
can this sequence happen?

CPU0 otx2_xsk_wakeup()
    otx2_test_flag(pf, OTX2_FLAG_INTF_DOWN) == false, continues

CPU1 otx2_stop()
    otx2_set_flag(pf, OTX2_FLAG_INTF_DOWN);
    smp_wmb();
    ... synchronize_irq()/napi_synchronize() ...
    otx2_free_queue_mem(qset)
        kfree(qset->napi);
        qset->napi = NULL;

CPU0 then computes &qset->napi[queue_id], and the !cq_poll test only catches
queue_id 0 when the pointer is NULL, so does napi_if_scheduled_mark_missed()
dereference freed or near NULL memory, followed by an MMIO write derived
from cq_poll->cint_idx?  synchronize_irq() and napi_synchronize() do not
wait for a process context wakeup caller that already passed the flag test.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7a..8a8c0088fd204 100644
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
> @@ -109,14 +109,14 @@ static int rvu_rep_setup_tc_cb(enum tc_setup_type type,
>  	struct rep_dev *rep = cb_priv;
>  	struct otx2_nic *priv = rep->mdev;
>  
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_REP_VF_INITIALIZED, &rep->flags))
>  		return -EINVAL;
>  
> -	if (!(rep->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
> +	if (!test_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags))
>  		rvu_rep_mcam_flow_init(rep);

[Severity: Medium]

This is a pre-existing issue and not introduced by this patch.  The return
value of rvu_rep_mcam_flow_init() is discarded, and that function
unconditionally re-assigns both rep->flow_cfg and rep->flow_cfg->flow_ent:

	rep->flow_cfg = kzalloc_objs(struct otx2_flow_config, 1);
	...
	rep->flow_cfg->flow_ent = kcalloc(count, sizeof(u16), GFP_KERNEL);

It only sets the support bits when allocated is non zero, so if the AF
mailbox allocation yields zero entries, or the flow_ent kcalloc fails and
-ENOMEM is returned, does OTX2_FLAG_TC_FLOWER_SUPPORT stay clear so that
every subsequent tc request re-enters the function and leaks the previous
otx2_flow_config plus its flow_ent array?

Also, rvu_rep_destroy() only does kfree(rep->flow_cfg) and never frees
flow_cfg->flow_ent, so does the u16 entry array leak on every representor
teardown even on the success path?

>  	priv->netdev = rep->netdev;
> -	priv->flags = rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);
>  	priv->pcifunc = rep->pcifunc;
>  	priv->flow_cfg = rep->flow_cfg;

[Severity: High]

This is a pre-existing issue and not introduced by this patch, but the new
sync helper is part of the same publication step.

Representor owned objects are published into priv here, and priv is the
devm allocated otx2_nic that lives for the whole PCI device lifetime.
rvu_rep_destroy() later frees them:

	unregister_netdev(rep->netdev);
	rvu_rep_devlink_port_unregister(rep);
	free_netdev(rep->netdev);
	kfree(rep->flow_cfg);

without clearing priv->netdev or priv->flow_cfg.  After
devlink dev eswitch set <dev> mode legacy followed by mode switchdev,
rvu_rep_napi_init() clears INTF_DOWN and re-enables NAPI, and since this tc
callback also cleared OTX2_FLAG_REP_MODE_ENABLED, otx2_rcv_pkt_handler()
reads pfvf->netdev->features and otx2_tx_napi_handler() uses
ndev = pfvf->netdev for netdev_get_tx_queue(), netdev_tx_completed_queue()
and netif_tx_wake_queue().

Can that dereference the freed representor netdev, i.e. a use after free
read and write from the NAPI datapath?  The stale priv->flow_cfg is
similarly still advertised as valid by the MCAM/NTUPLE/TC_FLOWER bits the
sync copied into priv->flags.

[ ... ]

> @@ -382,7 +382,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
>  {
>  	struct rep_dev *rep = netdev_priv(dev);
>  
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_REP_VF_INITIALIZED, &rep->flags))
>  		return;
>  
>  	stats->rx_packets = rep->stats.rx_frames;

[Severity: High]

This is a pre-existing issue and not introduced by this patch.  The tail of
this function arms a delayed work on every statistics read:

	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

and the callback rvu_rep_get_stats() recovers rep with
container_of(del_work, struct rep_dev, stats_wrk) and then dereferences
rep->mdev and takes priv->mbox.lock.

struct rep_dev is the private area of an alloc_etherdev() device, and
neither rvu_rep_destroy() nor the post registration error path in
rvu_rep_create() calls cancel_delayed_work_sync(&rep->stats_wrk) before
free_netdev(rep->netdev).  unregister_netdev() does not cancel driver owned
delayed work.

If ip -s link show on a representor is followed within 100 ms by
devlink dev eswitch set <dev> mode legacy, can the pending work run against
the freed netdev allocation?

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

This is a pre-existing issue and not introduced by this patch, but it is in
the function being modified.  A little further down this loop:

	free_netdev(rep->netdev);
	kfree(rep->flow_cfg);

rep is netdev_priv() of a device allocated with alloc_etherdev() in
rvu_rep_create(), so free_netdev() releases the allocation that contains
rep.  Does the following statement then read rep->flow_cfg out of freed
memory and hand whatever it finds to kfree()?

Saving flow_cfg in a local before free_netdev() would avoid the stale read,
and flow_cfg->flow_ent allocated by rvu_rep_mcam_flow_init() still needs a
matching kfree().

[Severity: Medium]

Also pre-existing and not introduced by this patch, on the creation side of
this pair: rvu_rep_create() returns directly if the representor array
allocation fails, right after resources were acquired:

	err = rvu_rep_rsrc_init(priv);
	if (err)
		return -ENOMEM;
	priv->reps = kzalloc_objs(struct rep_dev *, rep_cnt);
	if (!priv->reps)
		return -ENOMEM;

Every later failure jumps to the exit label which calls
rvu_rep_rsrc_free().  Does this second return leak the queue memory from
otx2_alloc_queue_mem() and the NIX/NPA contexts set up by
otx2_init_hw_resources()?

[ ... ]
-- 
This is an AI-generated review.

