Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740634CF490;
	Mon, 19 Oct 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375343; cv=none; b=dloPlLuaGi4CyajajO2MXZCW7cqp4i0RGMwcbDjEdBSmQmM7eW7a71wrKM2rfyy2Wv0zYbJuA6M+XjI4TwaksZRbJisYx60wqwpgv5Rw7R9Gvg5zB5BnZUKt2ByWUo1FG7zJ73C3tboYz8hwRPue3B+dhOQLathaW0nC09k8yY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375343; c=relaxed/simple;
	bh=CrBEXDkDCcDmwYhULFFB5lb91VniCalfTSpXaxGMiic=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYLjFPpBW+XJBiSReFaRMhQYhfwxkvMTW5NyQ88wHJQ4ct26cvxotv3uEXW/YQno2NV3T5fdQ4jAprpabIbc7pk9OcTnTmDchmN0115xZDoYgT/dBxIcthEM0PAD0mUbN37nQi1wOBBofGchf246sZhSDZ8yOVY10gCp3IYN1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YRJBelM/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YRJBelM/"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J1ISu83916939;
	Sun, 18 Oct 2026 19:01:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	9WhfbnZcg2XfwJLiKDkusGE7adgYss24aV3D+wlPVs=; b=YRJBelM/QUYLZqrbr
	GMNScRT+kYizNuvQQpX9fiJd1ErqcsiTQTa4n6aOGR61RS0dAQVz/weoqgjIibeF
	fn+zbgXWtPFQR7JHtgYlojH/hS88PbA7rEQ+n0i2MXAAoKSdnhk+U7+DrfGXUhLp
	Nlwjipywy1/bzdxT5zLtpPHtX0Y1Od1vlGXB7FXEVqS2CvvI2NKK22IdxqOwizkL
	+pCvoU5sQ/+vlLevsHdyrNwmnzEo4TA16m/M3jAylOqGFc9qtb5P8g2BSd/UyhDT
	3h3IBBWqKdZwQwN875c0ipY1r6XCGDa6c3P+eApm9AN4EZ/7ll1e6nJCBWeV37J1
	nd/SA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hc6cj3suc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 19:01:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Oct 2026 19:01:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Oct 2026 19:01:43 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 30C043F70B8;
	Sun, 18 Oct 2026 19:01:37 -0700 (PDT)
Date: Mon, 19 Oct 2026 07:31:37 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>,
        <horms@kernel.org>
Subject: Re: [PATCH v20 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <atV491xfWzf9YqV_@rkannoth-OptiPlex-7090>
References: <20261014023431.1775238-3-rkannoth@marvell.com>
 <179229176763.3135.4109423332542874325@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179229176763.3135.4109423332542874325@kernel.org>
X-Proofpoint-ORIG-GUID: DiDLC41SboqihpT9M6sc8GEcUlZkR3Gf
X-Authority-Analysis: v=2.4 cv=L7KI0OT8 c=1 sm=1 tr=0 ts=6ad57a08 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=c8XjreaX63J_zlD7CjUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAwNyBTYWx0ZWRfX1wN4V3DUWSHo
 CIroJ9b1zBcZbMXmN5NDWoHkEqvch0GJrMyyPaHrQAREVSIxgFwJfNny9Cej4G0Hi1ykaBllJ2W
 lfU/DUF3SPe0aeqkfMJP2zvbbkQvE9qamzjliCHmBSuy1yj5uDZp3vDDrLOc+kiehHEDO4oV/HR
 XJ4HHj8rp4cPr9C///xA5Oz0qWKXMtrk9ok49Sz95LPkIGfh67ZwTBKF+EX1uoNQO84HA2h8PqD
 RGHWzycra22Eh1FkC12z2AD7EhYoCC0xTQcCLB8gXzRPq4BtG2rwUPaeZKWEaTV/GV1l+LLniI2
 aa/YvnzcfTf1gUa00pqUUfPUc7h+HoekiQ9O5K+KDddYhcz5IJfvDWvQySckU/mkDsRHQ78cBCn
 X+lih5cDFrA7sn5ttSZ8BLYrtWqu1x6969QQvYTdVzjX+WMcFABbkCX6RU0Y/8hh0avVg2zV10d
 sLqEptKISBOp1TP784g==
X-Proofpoint-GUID: DiDLC41SboqihpT9M6sc8GEcUlZkR3Gf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAwNyBTYWx0ZWRfX6MVA7hZYsOlw
 aRPxdJIuOKyg+CLKSswdEpIOTRtfy1jwBmaLqX+fMllPR3r1Fu8CdLygRX7EwY1Egz6ckKwIvf6
 R5bEa1WeycOLSqD/rWXIcDsaIpSi9NA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_01,2026-10-14_01,2025-10-01_01

On 2026-10-18 at 08:19:27, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 7 (1) · Low: 3
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] When hw-tc-offload is off, otx2_teardown_tc_mqprio() can
>   commit a replace that the qdisc core rejected.
This needs the AF mailbox write in otx2_nix_tm_clear_queue_shaper() to fail, so it is very rare.
The failure is not silent: otx2_mqprio_down() logs a netdev_warn() with the error code, and
otx2_teardown_tc_mqprio() returns the error with an extack message and a netdev_err().
Software state is always released, as the core cannot veto qdisc teardown.
Any stale shaper is dropped when the TX schedulers are reallocated on the next stop/open.

> - [Medium] A failed shaper clear during mqprio delete leaves the hardware
>   rate-limiting with no qdisc behind it.

This needs hw-tc-offload turned off and an mqprio replace that the qdisc core then rejects
. That combination is rare, and no valid config is affected. The driver logs
the failed teardown or rollback with netdev_err()/extack, so the user knows the offload state may
not match the qdisc. The next qdisc delete or replace re-syncs the hardware state.

> - [Medium] otx2_mqprio_restore_old() returns early on errors, and neither
>   caller repairs or quiesces the device afterwards.

Rollback only reaches these paths if an AF mailbox call or a small kcalloc fails while
restoring the old config. That is an unlikely double-fault, since the failed replace has
already been rejected. In both cases otx2_mqprio_restore_old() logs a netdev_err() saying
the hardware limits may not match the qdisc, so the user is told. The next stop/open
rebuilds the TX scheduler, so I don't plan extra recovery logic for this rare case.

> - [Medium] If the restart inside a rollback fails, the committed offload
>   state is lost for good.

This needs a failed ndo_open() during rollback of an already failed replace, which is a rare
double failure (e.g. a mailbox error or an allocation failure). In that case
otx2_mqprio_restore_old() logs "mqprio: rollback netdev restart failed: %d; qdisc rates may not
be enforced", and the open failure itself is reported to the user. The interface is left down,
so no traffic runs unshaped.

> - [Medium] The new err_free_hw unwind in otx2_open() leaks
>   pf->refill_wrk.

This path is only taken on a mailbox failure while restoring mqprio shapers during open, which is
rare, and the failure is reported with netdev_err(). refill_wrk is allocated with devm_kcalloc(),
so it is not lost. It stays on devres and is freed on driver unload, and the next successful
open or config allocates a fresh array. The older error labels behave the same way, so this
patch adds no new leak class.

> - [Medium] otx2_mqprio_restart_netdev() hand-rolls a close/open:
>   clear_bit(__LINK_STATE_START), then ops->ndo_stop()/ndo_open().

This is pre-existing: otx2_change_mtu(), otx2_set_channels() and otx2_xdp_setup() already use
the same stop/open pattern without netpoll exclusion. It is also rare, as it needs netconsole
active and a poll racing with an mqprio bounce. This patch adds no new mechanism, only one more
caller. Any netpoll fix belongs in a common helper for all of these paths, in a separate patch.

> - [Medium] In mqprio mode, the scheduler topology for the shared TL4 is
>   never programmed.

The TL4 is a shared resource. The HTB teardown path does not clear NIX_AF_TL4X_TOPOLOGY or reset
it to defaults, so a reused TL4 can already carry stale values today. This is not specific to
mqprio. With no explicit programming, the TL4 keeps its default topology, and the MDQs under
TL4[0] share the same PRIO 0 and DWRR arbitration. Hence the netdev_warn_once() in the patch.

> - [Low] After a failed replace, the netdev TC layout is restored only
>   later, from a work item, so there is a window with num_tc == 0.
> - [Low] The new comment in otx2_config_sched_shaping() (qos.c) says 65536
>   is 'the kernel-side default burst when HTB does not supply an explicit…
> - [Low] Two offload restrictions are missing from the commit message's
>   list of rejections.
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   otx2_reset_task() checks netif_running() before rtnl_lock() and then…
>
> --
>
> octeontx2: add mqprio bandwidth offload for NIX TX schedulers
>
> This adds TC_SETUP_QDISC_MQPRIO offload with the bw_rlimit shaper on
> octeontx2 PF and VF netdevs. It programs per-queue MDQ CIR/PIR through the
> AF mailbox and allocates one SMQ per non-QoS queue under TL4[0]. Every
> mqprio add, replace and delete bounces the netdev through ndo_stop() and
> ndo_open(). Rates are cached in software and staged in mq_offload_snap
> snapshots that are committed on TC_ROOT_GRAFT or on teardown of the
> replaced qdisc.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index 836601fc10d8e..c95177602bf95 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>
> [ ... ]
>
> > @@ -651,7 +784,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
> >  						(u64)hw->smq_link_type);
> >  		req->num_regs++;
> >  		/* MDQ config */
> > -		parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
> > +		if (pfvf->mqprio.rate_limit)
> > +			parent = schq_list[NIX_TXSCH_LVL_TL4][0];
> > +		else
> > +			parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
> > +
> >  		req->reg[1] = NIX_AF_MDQX_PARENT(schq);
> >  		req->regval[1] = parent << 16;
> >  		req->num_regs++;
>
> [ ... ]
>
> > @@ -777,6 +914,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
> >  		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
> >  	}
> >
> > +	if (pfvf->mqprio.rate_limit)
> > +		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
> > +
> >  	rc = otx2_sync_mbox_msg(&pfvf->mbox);
> >  	if (rc)
> >  		return rc;
>
> [Severity: Medium]
> With rate_limit set, this requests non_qos_queues SMQs but still only one
> TL4. otx2_txschq_config() then points every MDQ's NIX_AF_MDQX_PARENT at
> schq_list[NIX_TXSCH_LVL_TL4][0]. The only thing it writes to
> NIX_AF_MDQX_SCHEDULE is the DWRR quantum, so every MDQ gets PRIO 0.
>
> Where is NIX_AF_TL4X_TOPOLOGY (PRIO_ANCHOR / RR_PRIO) programmed for that
> TL4? The only TOPOLOGY writes I can find are the TL1 defaults in
> otx2_txschq_config() and the HTB paths in qos.c, for example
> otx2_qos_txschq_set_parent_topology():
>
> 	cfg->reg[0] = NIX_AF_TL4X_TOPOLOGY(parent->schq);
> 	...
> 	cfg->regval[0] = (u64)parent->prio_anchor << 32;
>
> On the AF side, nix_reset_tx_schedule() resets only PARENT and SCHEDULE for
> TL4, so a reused TL4 could keep a stale RR_PRIO / PRIO_ANCHOR. Would the
> N PRIO 0 children still be arbitrated as a single DWRR group?
>
> The netdev_warn_once() in otx2_setup_tc_mqprio() says the offload "uses
> TL4[0] without explicit topology programming", yet the driver still reports
> TC_MQPRIO_HW_OFFLOAD_TCS. Should the TL4 topology be programmed explicitly
> before offload is reported as successful?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index 777e7156badb7..f51161e8b5949 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -2008,6 +2008,15 @@ int otx2_open(struct net_device *netdev)
> >  	if (err)
> >  		goto err_free_mem;
> >
> > +	/* Fail closed: abort open if cached mqprio shapers cannot be restored. */
> > +	err = otx2_mqprio_up(pf);
> > +	if (err) {
> > +		netdev_err(pf->netdev,
> > +			   "mqprio: failed to restore shapers during open: %d\n",
> > +			   err);
> > +		goto err_free_hw;
> > +	}
> > +
> >  	/* Register NAPI handler */
> >  	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
> >  		cq_poll = &qset->napi[qidx];
>
> [ ... ]
>
> > @@ -2206,6 +2215,7 @@ int otx2_open(struct net_device *netdev)
> >  	free_irq(vec, pf);
> >  err_disable_napi:
> >  	otx2_disable_napi(pf);
> > +err_free_hw:
> >  	otx2_free_hw_resources(pf);
> >  err_free_mem:
> >  	otx2_free_queue_mem(qset);
>
> [Severity: Medium]
> Does this new unwind leak pf->refill_wrk? It is allocated on every open via
> otx2_init_hw_resources()->otx2_config_nix_queues():
>
> 	pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
> 					sizeof(struct refill_work), GFP_KERNEL);
>
> Neither otx2_free_hw_resources() nor otx2_free_queue_mem() frees it. The
> only devm_kfree(pf->refill_wrk) is in otx2_stop(), and otx2_stop() returns
> early afterwards because OTX2_FLAG_INTF_DOWN is set. The next open then
> overwrites the pointer, and each leaked array stays on devres until unbind.
>
> The older labels after otx2_init_hw_resources() have the same omission. This
> new label, though, is reached whenever a shaper mailbox write fails during
> any open while mqprio offload is active. That includes the mqprio bounces
> and the MTU, channel and reset reopen paths.
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > index 8877af348a090..b34a86259e786 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>
> [ ... ]
>
> > +static void otx2_mqprio_defer_netdev_tc_restore(struct otx2_nic *pfvf)
> > +{
> > +	if (READ_ONCE(pfvf->mqprio.defer_tc_work))
> > +		return;
> > +	schedule_work(&pfvf->mqprio.netdev_tc_work);
> > +}
>
> [Severity: Low]
> After a failed replace, both the fail_validate and cleanup paths in
> otx2_setup_tc_mqprio() call this to re-apply old_mq_snap later. Before the
> work can take RTNL, mqprio_destroy() runs for the rejected new qdisc (with
> hw_offload unset) and does:
>
> 	else
> 		netdev_set_num_tc(dev, 0);
>
> The old offloaded mqprio remains root and the MDQ shapers stay programmed.
> Until the work runs, netdev_pick_tx() / skb_tx_hash() see num_tc == 0. They
> can then hash traffic onto queues shaped for other TCs.
>
> Is this window intended? Could the layout be restored without going
> through a work item?
>
> > +
> > +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> > +{
> > +	struct mq_offload_snap *snap = pfvf->old_mq_snap;
> > +	struct net_device *netdev = pfvf->netdev;
> > +	u16 num_txq = pfvf->hw.non_qos_queues;
> > +	int tc, txq, err;
> > +
> > +	if (!snap)
> > +		return 0;
> > +
> > +	err = otx2_mqprio_alloc_cache(pfvf, false);
> > +	if (err) {
> > +		netdev_err(netdev,
> > +			   "mqprio: rollback failed to allocate rate cache: %d\n",
> > +			   err);
> > +		return err;
> > +	}
>
> [ ... ]
>
> > +	otx2_mqprio_apply_snap_netdev(netdev, snap);
> > +
> > +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> > +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> > +		if (err) {
> > +			netdev_err(netdev,
> > +				   "mqprio: rollback shaper clear failed: %d; hardware limits may not match qdisc\n",
> > +				   err);
> > +			return err;
> > +		}
> > +	}
>
> [Severity: Medium]
> What state is the device left in when either of these early returns is
> taken?
>
> If otx2_mqprio_alloc_cache() fails, nothing has been restored yet. The
> hardware and the caches still hold the rejected replacement, and rate_limit
> stays true.
>
> If otx2_nix_tm_clear_queue_shaper() fails, the cache has already been
> rebuilt from old_mq_snap, but neither the restart nor otx2_mqprio_up()
> runs. The MDQs then hold a mix of new and cleared CIR/PIR values.
>
> Neither caller repairs this. otx2_teardown_tc_mqprio() only clears the
> replace flags and returns the error, which mqprio_disable_offload() ignores.
> The cleanup label in otx2_setup_tc_mqprio() only logs.
>
> Should a failed rollback force the device back to a known state?
>
> > +
> > +	/* Rebuild the TX scheduler via netdev restart when running; otx2_mqprio_up()
> > +	 * alone is insufficient after a failed replace that already bounced the
> > +	 * interface. If open failed, TX schedulers were freed; defer shaper restore
> > +	 * to the next successful ndo_open() via otx2_mqprio_up().
> > +	 */
> > +	pfvf->mqprio.rate_limit = true;
> > +
> > +	if (netif_running(netdev)) {
> > +		err = otx2_mqprio_restart_netdev(netdev, true);
> > +		if (err) {
> > +			netdev_err(netdev,
> > +				   "mqprio: rollback netdev restart failed: %d; qdisc rates may not be enforced\n",
> > +				   err);
> > +			return err;
> > +		}
>
> [Severity: Medium]
> The comment above says shaper restore is deferred to the next successful
> ndo_open(). Does that still hold if ndo_open() fails inside this restart?
>
> On that failure, otx2_mqprio_restart_netdev() calls otx2_mqprio_clear_sw()
> (rate_limit = false, rate caches freed), sets OTX2_FLAG_INTF_DOWN and calls
> netif_close(). This function then returns without reinstating rate_limit or
> the cache. The old offloaded mqprio qdisc stays installed.
>
> On the next ip link set up, otx2_txsch_alloc() allocates a single SMQ and
> otx2_mqprio_up() returns immediately:
>
> 	if (!pfvf->mqprio.rate_limit)
> 		return 0;
>
> Wouldn't the interface then run without any bandwidth limits while the
> qdisc still reports hardware-offloaded rates?
>
> [ ... ]
>
> > +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> > +{
> > +	struct otx2_nic *pfvf = netdev_priv(netdev);
> > +	const struct net_device_ops *ops = netdev->netdev_ops;
> > +	bool running = netif_running(netdev);
> > +	int err;
>
> [ ... ]
>
> > +	if (running) {
> > +		clear_bit(__LINK_STATE_START, &netdev->state);
> > +		smp_mb__after_atomic(); /* Commit netif_running(). */
> > +	}
> > +
> > +	err = ops->ndo_stop(netdev);
>
> [Severity: Medium]
> This open-codes a close/open but skips the netpoll exclusion that
> __dev_close_many() takes before ndo_stop():
>
> 	/* Temporarily disable netpoll until the interface is down */
> 	netpoll_poll_disable(dev);
>
> netpoll_poll_dev() checks netif_running() only once, after
> down_trylock(&ni->dev_lock). A poll that passed that check before the
> clear_bit() could still be in poll_one_napi()->otx2_napi_handler() while
> otx2_stop() runs.
>
> In otx2_stop(), napi_synchronize() waits for NAPI_STATE_SCHED but not for
> NAPI_STATE_NPSVC. otx2_free_hw_resources() also frees the CQ/SQ resources
> before otx2_disable_napi() runs. With netconsole active, could this be a
> use-after-free of the CQ rings?
>
> otx2_change_mtu(), otx2_set_channels() and otx2_xdp_setup() already have
> the same gap. This helper adds a new trigger on every mqprio add, replace,
> delete and rollback. During the bounce, unlocked netif_running() readers
> also see false while IFF_UP stays set.
>
> [ ... ]
>
> > +	err = ops->ndo_open(netdev);
> > +	if (!err && running) {
> > +		set_bit(__LINK_STATE_START, &netdev->state);
> > +	} else if (err) {
>
> [ ... ]
>
> > +		otx2_mqprio_clear_sw(pfvf);
> > +		/* ndo_open() rolls back on failure; mark the interface down so
> > +		 * otx2_stop() returns early when netif_close() runs.  Caller
> > +		 * holds RTNL; netif_close() is used since it needs no extra
> > +		 * locking (dev_close() would also take the netdev ops lock).
> > +		 */
> > +		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
> > +		/* visible to otx2_stop() on other cpus */
> > +		smp_wmb();
> > +		netif_close(netdev);
> > +	}
>
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch, but
> otx2_reset_task() checks netif_running() before it takes RTNL:
>
> 	if (!netif_running(pf->netdev))
> 		return;
>
> 	rtnl_lock();
> 	otx2_stop(pf->netdev);
> 	pf->reset_count++;
> 	otx2_open(pf->netdev);
>
> A reset task that is waiting on RTNL can reopen a device that was closed in
> the meantime. This netif_close() becomes one more such close. otx2_stop()
> returns early because of OTX2_FLAG_INTF_DOWN, and otx2_open() allocates
> hardware, NAPI and IRQs while IFF_UP is clear.
>
> Would a later ip link set up then open the device a second time? The same
> race exists with an ordinary dev_close().
>
> [ ... ]
>
> > +static bool otx2_tc_can_offload(struct net_device *netdev)
> > +{
> > +	return !!(netdev->hw_features & NETIF_F_HW_TC);
> > +}
>
> [Severity: Low]
> On the PF, otx2_probe() adds NETIF_F_HW_TC to hw_features only when
> OTX2_FLAG_TC_FLOWER_SUPPORT is set, and that flag depends on MCAM entries
> being allocated:
>
> 	if (otx2_test_flag(pf, OTX2_FLAG_TC_FLOWER_SUPPORT))
> 		netdev->hw_features |= NETIF_F_HW_TC;
>
> So PFs without flower MCAM entries reject mqprio bandwidth offload with
> -EOPNOTSUPP, even though MDQ shaping has nothing to do with flower. Is that
> intended?
>
> Because this tests hw_features rather than features, turning hw-tc-offload
> off does not disable mqprio offload. That is inconsistent with the
> tc_can_offload() check in otx2_teardown_tc_mqprio().
>
> The commit message lists the rejected configurations:
>
>   "Reject offload with PFC, XDP, HTB, SDP representors, per-TC rates on
>   multi-queue classes, and ethtool channel changes while active."
>
> That list leaves out this restriction. It also leaves out the rejection, in
> otx2_setup_tc_mqprio(), of replacing a software mqprio root with an
> offloaded one ("delete existing mqprio before re-enabling hw/sw offload").
> Could both be documented?
>
> > +
> > +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> > +				   struct tc_mqprio_qopt_offload *mqprio)
> > +{
>
> [ ... ]
>
> > +	/* tc qdisc replace runs setup on the new mqprio before destroying the
> > +	 * old one. replace_setup_done and TC_ROOT_GRAFT distinguish stale
> > +	 * old-instance teardown from graft failure after setup.
> > +	 * qdisc_offload_graft_helper() skips TC_ROOT_GRAFT unless hw-tc-offload
> > +	 * is enabled in netdev->features; commit without graft in that case.
> > +	 */
> > +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> > +		err = 0;
> > +		if (pfvf->mqprio.replace_graft_done || !tc_can_offload(netdev)) {
> > +			otx2_mqprio_snap_commit(pfvf);
> > +		} else {
>
> [Severity: Medium]
> Can this commit a replace that the qdisc core rejected?
>
> In otx2_probe() and otx2vf_probe(), NETIF_F_HW_TC is added to hw_features
> after netdev->features |= netdev->hw_features. So by default
> tc_can_offload() is false, while otx2_tc_can_offload() still accepts mqprio
> offload.
>
> Take a tc qdisc replace ... mqprio ... hw 1 shaper bw_rlimit ... with an
> estimator, issued over an active offloaded mqprio. mqprio_init() succeeds,
> the driver reprograms the hardware, and TCQ_F_MQROOT is set. Then
> qdisc_create() rejects the qdisc:
>
> 	if (tca[TCA_RATE]) {
> 		err = -EOPNOTSUPP;
> 		if (sch->flags & TCQ_F_MQROOT) {
> 			...
> 			goto err_out4;
>
> err_out4 calls ops->destroy(). mqprio_destroy() has hw_offload set, so it
> calls back into the driver and we end up here. replace_setup_done and
> cur_mq_snap are set and !tc_can_offload() is true. The rejected config is
> committed into old_mq_snap and left in hardware, while the old qdisc is
> still root.
>
> In this configuration TC_ROOT_GRAFT is never delivered, because
> qdisc_offload_graft_helper() returns early:
>
> 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
> 		return;
>
> That means this branch cannot tell a successful graft from a failed
> create. Later rollbacks would also restore this wrong snapshot.
>
> [ ... ]
>
> > +	/* Skip the netdev restart when mqprio offload was not active. */
> > +	if (!had_mqprio)
> > +		return 0;
> > +
> > +	if (if_up) {
> > +		err = otx2_mqprio_down(pfvf);
> > +		if (err) {
> > +			if (extack)
> > +				NL_SET_ERR_MSG_FMT_MOD(extack,
> > +						       "mqprio: teardown incomplete (%d)",
> > +						       err);
> > +			netdev_err(netdev,
> > +				   "mqprio: offload teardown incomplete (%d); driver state may not match removed qdisc\n",
> > +				   err);
> > +			return err;
> > +		}
> > +
> > +		err = otx2_mqprio_restart_netdev(netdev, false);
>
> [Severity: Medium]
> Doesn't this early return skip the step that otx2_mqprio_down() relies on?
> If otx2_nix_tm_clear_queue_shaper() fails there, otx2_mqprio_clear_sw() has
> already released the software state, and the comment in otx2_mqprio_down()
> says:
>
> 	/* The core cannot veto qdisc teardown, so always release software
> 	 * state.  The netdev restart that follows reallocates the TX
> 	 * scheduler, which drops any shaper left programmed.
> 	 */
>
> mqprio_disable_offload() ignores the return value of ndo_setup_tc(), so the
> qdisc is removed anyway. Until some unrelated stop/open, the MDQs keep their
> PIR/CIR values and the multi-SMQ topology under TL4[0].
>
> Should the restart still run when otx2_mqprio_down() fails?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > index f160b1618efa2..9ef55a6db50b7 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > @@ -118,6 +118,9 @@ static void otx2_config_sched_shaping(struct otx2_nic *pfvf,
> >  	/* configure PIR */
> >  	maxrate = (node->rate > node->ceil) ? node->rate : node->ceil;
> >
> > +	/* 65536 is the kernel-side default burst when HTB does not supply an
> > +	 * explicit value, not the NIX hardware maximum (CN10K_MAX_BURST_SIZE).
> > +	 */
> >  	cfg->regval[*num_regs] =
> >  		otx2_get_txschq_rate_regval(pfvf, maxrate, 65536);
> >  	(*num_regs)++;
>
> [Severity: Low]
> This isn't a bug, but is this comment accurate? struct tc_htb_qopt_offload
> has no burst or cburst field, so HTB offload never supplies an explicit
> burst and the driver always uses this fixed constant.
>
> The same wording appears in otx2_nix_tm_set_queue_shaper() ("Use the same
> 65536 byte default as the HTB shaper path").
>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014023431.1775238-1-rkannoth%40marvell.com
