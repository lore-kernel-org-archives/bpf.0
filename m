Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69017453A56;
	Fri,  2 Oct 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929881; cv=none; b=ApAK6/3xLpVNRZJGNqdRS5bXrYPzPCmPNLj8dPleRwhKvzNUY6l4+bRbdxs8SYjyB3bAg0nOaET6vDp+CptHyPdD8wi4CLZaMRRzFnd8ozEtFAJKbwsRd2gO7PVffPzEsmhxpCXONVZD+rBWOOnQKOI/seMBVqUlAhyQrPzq+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929881; c=relaxed/simple;
	bh=kY/4EC3FZ9ed0nBMvG1coxxFbimZ3jW6wC6Wa+kNBcI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jGTJzMZxoMITmSo735TYP344BCCRcL4IcGtMgdO34euq1FLa+7XDCxrUvesMGObxG+8Jq3KCut7rDTXsnPfOdbxZTxJNJ0eyrUXU5yg+VVPXDU47IOl5eueJe1NWhZSm+tDJ5vI2ykLUN0aCsjkmhRIzJYQu8f1dUnGbvnj5I7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlUwC4Go; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlUwC4Go"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14701F00898;
	Fri,  2 Oct 2026 08:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929877;
	bh=VCpKyCnbhPWeYiGDHXNS1xxcgBuMTu6JYYf8sfvuhNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PlUwC4GoanEqUCgRPHtRhRy2XN++apI1I2N7d5jEE8JMt7krziAzngErp4gp1dLl3
	 lSoT/NXUG0LU6wYhV+h+Q1Ts/mbHkpZ7DMSJZnVLSN3/GY5p2MbcWvt6AcE+xDK7/m
	 NMBaD3s8TuTXZnwmuhUh+V7X8PeX0asKl8/Cwp1u561Zgj8nNXV9NWaXH9fw5XaUUP
	 Hqy+NtGKwgbfVcACY7Ei/6khiOjoxDC/wRnrflW61VZDP8w/KlQfqF+Z+odZ6YbCH/
	 AUGWuadM3HjEFBLFlJNtSMiAuSdVfLLLejqQ2pIu7wiYe3demvxOCBidLXk1k0c9Kx
	 Xhv5huWRKu4yQ==
Subject: Re: [PATCH v18 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Fri, 02 Oct 2026 08:31:16 +0000
Message-ID: <179092987640.434549.18150206247500512313@kernel.org>
In-Reply-To: <20260929022915.2704627-3-rkannoth@marvell.com>
References: <20260929022915.2704627-3-rkannoth@marvell.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 6 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] otx2_remove() and otx2vf_remove(), and the err_unreg_netdev
  probe error labels, call otx2_shutdown_tc_mqprio() before…
- [Medium] Deleting the offload leaves old_mq_snap allocated, and that
  stale snapshot permanently blocks TX channel reduction.
- [Medium] Teardown can fail, but the tc core cannot veto it, so the
  driver ends up holding offload state for a qdisc that no longer exists.
- [Medium] With default features (NETIF_F_HW_TC is in hw_features but not
  in features on both PF and VF, because it is added to hw_features…
- [Medium] When rollback of a failed replace itself fails, the old qdisc
  can stay attached with partial or missing hardware limits.
- [Medium] With mqprio.rate_limit set, otx2_txsch_alloc() requests
  hw.non_qos_queues SMQs but still only one TL4.
- [Medium] otx2_nix_tm_clear_queue_shaper() is not atomic.
- [Low] In otx2_setup_tc_mqprio(), the extack message for the `!replacing
  && otx2_mqprio_keep_netdev_tc(pfvf)` rejection ends with a newline:…
- [Low] A comment in the ndo_open() failure branch of
  otx2_mqprio_restart_netdev() says "ndo_open() already freed the TX…

Pre-existing issues:
- [Medium] otx2_config_nix_queues() allocates pfvf->refill_wrk with
  devm_kcalloc() on every open.

--

octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload with the bw_rate shaper for
octeontx2 PF and VF netdevs, programming per-queue MDQ CIR/PIR through the
AF mailbox. The TX scheduler cannot be reprogrammed live, so every add,
replace and delete bounces the netdev through ndo_stop()/ndo_open(), and
otx2_mqprio_up() restores the cached rates on open. A replace is staged in
mq_offload_snap snapshots, which are committed on TC_ROOT_GRAFT or when the
replaced qdisc is torn down.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index b421cb75e44b5..511efb0dcc752 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -615,6 +615,139 @@ void otx2_get_mac_from_af(struct net_device *netdev)

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
Is it a problem that this clear is not atomic across batches? Each mailbox
message covers 10 MDQs. As soon as a batch is acknowledged, PIR/CIR for
those queues are zero.

With more than 10 non-QoS queues, a later batch can fail in
otx2_mbox_alloc_msg_nix_txschq_cfg() or otx2_sync_mbox_msg(). By then the
earlier queues are already unshaped, and nothing reprograms them.

In that case otx2_mqprio_down() keeps rate_limit and the cached rates:

    if (err) {
        netdev_warn(pfvf->netdev,
                    "mqprio: failed to clear hardware shapers: %d; keeping offload state\n",
                    err);
        return err;
    }

otx2_mqprio_restore_old() has already written the old rates into the
software cache. It then returns here, before it reaches
otx2_mqprio_restart_netdev():

    if (otx2_mqprio_mdq_allocated(pfvf)) {
        err = otx2_nix_tm_clear_queue_shaper(pfvf);
        if (err)
            return err;
    }

Could a subset of queues end up enforcing neither the old nor the new
limits while the driver still reports the offload as active?

[ ... ]

> @@ -651,7 +784,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
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
With rate_limit set, every MDQ gets TL4[0] as its parent. otx2_txsch_alloc()
now requests hw.non_qos_queues SMQs but still gets a single TL4.
NIX_AF_MDQX_SCHEDULE is written as dwrr_val only, so every MDQ has PRIO=0.

Nothing on this path programs NIX_AF_TL4X_TOPOLOGY for TL4[0]. In the NIC
driver, only the TL1 setup and the HTB code in qos.c write TOPOLOGY. On the
AF side, nix_reset_tx_schedule() clears only the PARENT and SCHEDULE
registers:

    if (tlx_parent)
        rvu_write64(rvu, blkaddr, tlx_parent, 0x0);

    if (tlx_schedule)
        rvu_write64(rvu, blkaddr, tlx_schedule, 0x0);

The TOPOLOGY clear in otx2_qos_free_hw_schq() is best-effort, and another
user of the same scheduler queue could leave any value behind.

If TL4[0] is handed out with a non-zero RR_PRIO or PRIO_ANCHOR, do the N
priority-0 MDQs still form one DWRR group? Or do they look like N
static-priority children claiming the same slot? Should TL4[0]'s topology
be programmed explicitly when rate_limit is set?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 4fe473d9ea0dd..8365826311279 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -287,6 +287,21 @@ static int otx2_set_channels(struct net_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (pfvf->mqprio.rate_limit &&
> +	    (channel->tx_count != pfvf->hw.tx_queues ||
> +	     channel->rx_count != pfvf->hw.rx_queues)) {
> +		netdev_info(dev,
> +			    "Not permitted to change channel count while MQ prio is active\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((pfvf->old_mq_snap || pfvf->cur_mq_snap) &&
> +	    channel->tx_count < pfvf->hw.tx_queues) {
> +		netdev_err(dev,
> +			   "Cannot reduce TX queues after mqprio bandwidth offload was configured\n");
> +		return -EINVAL;
> +	}
> +

[Severity: Medium]
Does this check block TX channel reduction permanently after a single
add/delete cycle?

A successful first add ends in otx2_mqprio_snap_commit(), which leaves
pfvf->old_mq_snap set. A later tc qdisc del then goes through:

otx2_teardown_tc_mqprio()
  otx2_mqprio_down()
    otx2_mqprio_clear_sw()
  otx2_mqprio_restart_netdev(netdev, false)

otx2_mqprio_clear_sw() only calls otx2_mqprio_free_cache(). old_mq_snap and
cur_mq_snap are only freed when a later add commits or when
otx2_shutdown_tc_mqprio() runs on remove.

This condition doesn't look at rate_limit. So ethtool -L dev tx N with a
smaller N keeps returning -EINVAL even though no offload is active or
pending. The commit message only claims:

    Reject offload with PFC,
    XDP, HTB, SDP representors, per-TC rates on multi-queue classes, and
    ethtool channel changes while active.

The commit message also doesn't mention that the new
!replacing && otx2_mqprio_keep_netdev_tc(pfvf) check in
otx2_setup_tc_mqprio() now rejects replacing a software mqprio with an
offloaded one. Could that be documented as well?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 32582b6347ea4..eba1a26593c57 100644
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

[ ... ]

> @@ -2205,6 +2214,7 @@ int otx2_open(struct net_device *netdev)
>  	free_irq(vec, pf);
>  err_disable_napi:
>  	otx2_disable_napi(pf);
> +err_free_hw:
>  	otx2_free_hw_resources(pf);
>  err_free_mem:
>  	otx2_free_queue_mem(qset);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
otx2_config_nix_queues() allocates pfvf->refill_wrk on every open:

    pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
                                    sizeof(struct refill_work), GFP_KERNEL);

None of the otx2_open() error labels free it, and otx2_free_hw_resources()
doesn't release it either. Only otx2_stop() calls
devm_kfree(pf->dev, pf->refill_wrk). After a failed open,
OTX2_FLAG_INTF_DOWN makes a later otx2_stop() return early.

The new err_free_hw branch adds another way into this unwind, and tc can
now trigger stop/open cycles. Does each failed open leave one refill_wrk
array on the devres list until unbind?

[ ... ]

> @@ -3622,7 +3641,9 @@ static void otx2_remove(struct pci_dev *pdev)
>  	otx2_cgx_config_linkevents(pf, false);
>  
>  	otx2_unregister_dl(pf);
> +	otx2_shutdown_tc_mqprio(pf);
>  	unregister_netdev(netdev);
> +	otx2_shutdown_tc(pf);
>  	cn10k_ipsec_clean(pf);
>  	cn10k_mcs_free(pf);
>  	otx2_sriov_disable(pf->pdev);

[Severity: High]
Can this ordering lead to a use-after-free? otx2_shutdown_tc_mqprio() runs
without RTNL while the netdev is still registered, so tc requests can still
reach otx2_setup_tc():

    void otx2_shutdown_tc_mqprio(struct otx2_nic *nic)
    {
        cancel_work_sync(&nic->mqprio.netdev_tc_work);
        otx2_mqprio_snap_destroy(nic);
    }

Suppose a concurrent tc qdisc replace fails while an offload is active,
either at fail_validate or at cleanup with replacing true. It then calls:

otx2_mqprio_defer_netdev_tc_restore()
  schedule_work()

This can happen after cancel_work_sync() has returned. Nothing cancels the
work again before free_netdev(). otx2_mqprio_netdev_tc_work() then does a
container_of() into the freed netdev_priv and reads
pfvf->mqprio.rate_limit, pfvf->old_mq_snap and pfvf->netdev.

There is a second problem. otx2_mqprio_snap_destroy() devm_kfree()s
old_mq_snap and cur_mq_snap with no lock held. Every other user runs under
RTNL: otx2_mqprio_restore_old(), otx2_mqprio_snap_copy(),
otx2_mqprio_snap_commit(), the worker and otx2_set_channels(). For example,
otx2_mqprio_restore_old() could load the pointer just before it is freed:

    struct mq_offload_snap *snap = pfvf->old_mq_snap;

otx2vf_remove() uses the same ordering, and so do the err_unreg_netdev
labels in otx2_probe() and otx2vf_probe(). Should the cancel and the
snapshot free happen after unregister_netdev(), once no more ndo_setup_tc()
calls can arrive?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index ddb46b580c3b6..4bb5b49d4dc70 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -1600,14 +1619,841 @@ static int otx2_setup_tc_block(struct net_device *netdev,

[ ... ]

> +	err = ops->ndo_open(netdev);
> +	if (!err && running) {
> +		set_bit(__LINK_STATE_START, &netdev->state);
> +	} else if (err) {
> +		netdev_err(netdev,
> +			   "Failed to restart device after mqprio change: %d\n",
> +			   err);
> +		/* ndo_open() already freed the TX schedulers on failure while
> +		 * netif_running() may still be true; drop mqprio software state
> +		 * only instead of sending shaper clears to freed queues.
> +		 */
> +		otx2_mqprio_clear_sw(pfvf);

[Severity: Low]
Is this comment accurate? Every caller invokes the function with the device
running. __LINK_STATE_START is cleared before ndo_stop() and set again only
when ndo_open() succeeds. So netif_running() is always false in this
branch, as the function's header comment says:

    Clear __LINK_STATE_START before ndo_stop() so netif_running() is false
    for the duration of the bounce.

[ ... ]

> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		err = 0;
> +		if (pfvf->mqprio.replace_graft_done || !tc_can_offload(netdev))
> +			otx2_mqprio_snap_commit(pfvf);
> +		else
> +			err = otx2_mqprio_restore_old(pfvf);
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		return err;
> +	}

[Severity: Medium]
Does the !tc_can_offload(netdev) case commit a replace that actually failed?

On both PF and VF, NETIF_F_HW_TC is added to hw_features after
features |= hw_features. By default it is therefore not in features, and
qdisc_offload_graft_helper() never sends TC_ROOT_GRAFT:

	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
		return;

Consider a qdisc_create() that fails after mqprio_init() succeeded, for
example:

    tc qdisc replace dev X root handle 1: estimator 1sec 8sec mqprio ... hw 1 shaper bw_rate ...

mqprio_init() has already set TCQ_F_MQROOT, so this check fails:

		if (sch->flags & TCQ_F_MQROOT) {
			NL_SET_ERR_MSG(extack, "Cannot attach rate estimator to a multi-queue root qdisc");
			goto err_out4;
		}

By then otx2_setup_tc_mqprio() has already restarted the netdev,
programmed the new MDQ shapers and netdev TC layout, and set
replace_setup_done. err_out4 destroys the new qdisc and
mqprio_disable_offload() ends up here. otx2_mqprio_snap_commit() runs
instead of otx2_mqprio_restore_old().

tc reports failure and the old qdisc stays root. The hardware, the rate
cache, old_mq_snap and the netdev TC layout keep the rejected
configuration, and later ndo_open() calls re-apply it through
otx2_mqprio_up().

In this configuration, is there a way to tell a successful graft apart from
a failed create?

> +
> +	/* Skip the netdev restart when mqprio offload was not active. */
> +	if (!had_mqprio)
> +		return 0;
> +
> +	if (if_up) {
> +		err = otx2_mqprio_down(pfvf);
> +		if (err)
> +			return err;
> +
> +		return otx2_mqprio_restart_netdev(netdev, false);
> +	}

[Severity: Medium]
What happens to the driver state when otx2_mqprio_down() fails here? The tc
core can't veto the teardown. mqprio_disable_offload() ignores the return
value and the qdisc is freed anyway:

	case TC_MQPRIO_MODE_CHANNEL:
		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
					      &mqprio);
		break;

When otx2_nix_tm_clear_queue_shaper() fails, otx2_mqprio_down() returns
early on purpose ("keeping offload state"). This code then returns before
otx2_mqprio_restart_netdev(netdev, false). So rate_limit, the rate caches,
the widened SMQ allocation and the programmed MDQ shapers all outlive a
qdisc that no longer exists.

The non-replace cleanup: label in otx2_setup_tc_mqprio() gets the same
result. It ignores otx2_teardown_tc_mqprio()'s return value, and the failed
mqprio_init() never records hw_offload, so no second teardown ever comes.

After that:

- XDP, HTB, PFC and ethtool -L stay blocked.
- Each ndo_open() re-applies the stale shapers via otx2_mqprio_up().
- The next tc qdisc add ... mqprio hw 1 sees
  replacing = pfvf->mqprio.rate_limit as true. It sets replace_setup_done
  and doesn't commit.
- A later tc qdisc del takes the replace_setup_done && cur_mq_snap branch
  above, commits, and returns 0 without clearing rate_limit or the hardware
  shapers.

Should teardown drop the software state and bounce the netdev even when
the shaper clear fails?

> +static int otx2_setup_tc_mqprio(struct net_device *netdev,
> +				struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	if (!replacing && otx2_mqprio_keep_netdev_tc(pfvf)) {
> +		netdev_err(netdev,
> +			   "mqprio: delete existing mqprio before re-enabling hw/sw offload\n");
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "mqprio: delete existing mqprio before re-enabling hw/sw offload\n");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Low]
This isn't a bug, but this extack string ends with a newline, unlike the
other extack messages in this patch. The string is sent to user space in
NLMSGERR_ATTR_MSG.

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
> +			if (extack)
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "mqprio: replace failed and prior configuration rollback failed: %d",
> +						       restore_err);
> +		} else {

[Severity: Medium]
When the rollback itself fails, what state is the old qdisc left in? This
branch only reports the error.

Case one: otx2_nix_tm_set_queue_shaper() fails partway through the new
mapping. otx2_mqprio_restore_old() then returns early, either with -ENOMEM
from otx2_mqprio_alloc_cache(pfvf, false) or with an error from
otx2_nix_tm_clear_queue_shaper(). The interface keeps running with the new
rates only partly programmed. On top of that, mqprio_destroy() on the new
instance (hw_offload is 0) clears netdev num_tc.

Case two: the rollback reaches otx2_mqprio_restart_netdev(netdev, true)
and ndo_open() fails. The helper then calls otx2_mqprio_clear_sw(), which
sets rate_limit to false and frees the caches, and then netif_close(). The
old offloaded mqprio stays root. The next ip link set up skips
otx2_mqprio_up() because rate_limit is false, so none of the old qdisc's
rates are enforced.

In either case, could the hardware limits silently disagree with the
offloaded qdisc that is still attached?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929022915.2704627-1-rkannoth%40marvell.com
