Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D9443C07;
	Sat, 10 Oct 2026 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626474; cv=none; b=Bz8rQJcIROjVAaAFqqmnc67px4w1YeQ/zRIPOgwJDEDNVw0gkm0mHNg/xqCd7lYdMgUgJtqVwh8q8tF1QacrWv7sNl0iJz0pnNOO9T51FXCN0zlWFWONeGuTAQMbToQ6PT/g/qXRPvVi519iLnPiAWp65yPEiqPS3WzQdsGheIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626474; c=relaxed/simple;
	bh=+FQur4VFy7uj/RIKzwoQocnLSfXs7yo/Vb7abjvecUA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ty5m/R2XfY48ZssPmk1tfZ9QcrcZjsOXTYAbv4UiHS2Sx6P4gvEZjZ/SFZ4jMfmf+/8A+e7PNAEnqO7Me2el0fsUD6IIPeHCylC+DO/EP3tTECZvG8S0DDkkW7GYD/10KzkKZlDqfb5ga5cQFY0Og4HdQ8UyUA2K7HMR3FKlzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAQzK/db; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAQzK/db"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBFC1F00893;
	Sat, 10 Oct 2026 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791626472;
	bh=bx4xiWLjf2t11udCOErt2pbpQnUofDXT+bvvX290VPo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RAQzK/dbLwbZZTKVa0dIwO7TqUHEI2dfceWYOn8YEFczXwTDdx+bhgzKdef6aF3Eb
	 ibz83pbjNaftWAHO6OY5eWE5EAmm7x8nqjK7dQYq5RlcSVVPi+YRab98YKOZYBu5is
	 vocTM4OpXJ1mFS9R1kUQW/Ldj6nCY8guObXoJiIOJd7uFrmQGmfEYld8DHt8Jg+xel
	 IoQ3iXp/O/JFqdyIpua76sqDjCIV1pLgpEzvNJnt8Muh4Ix0U5LkWm0bkkrDNT5BV2
	 8HQjJwfGo7REAnPxJH3Tu5JSdjn60MjJicH6dntZhy5uqV6+HaeLKiCLLofwkjULiB
	 i0hPB33EupZzg==
Subject: Re: [PATCH v19 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com
Date: Sat, 10 Oct 2026 10:01:10 +0000
Message-ID: <179162647058.434549.12221340477037180415@kernel.org>
In-Reply-To: <20261006094357.840823-3-rkannoth@marvell.com>
References: <20261006094357.840823-3-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 9 (1) · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] There is a use-after-free race on the deferred netdev_tc_work
  during device removal.
- [Medium] Offload state is leaked when qdisc teardown fails.
- [Medium] The snapshot lifetime is not tied to the offload lifetime, so
  TX channels can never be reduced once mqprio offload has been used,…
- [Medium] A failed tc command can leave the interface administratively
  down, and the commit message does not say so.
- [Medium] The TX scheduler topology is not programmed for the shared
  TL4.
- [Medium] The driver works around core mqprio behaviour with
  asynchronous work, which leaves a window where num_tc is 0 while the…
- [Medium] otx2_mqprio_keep_netdev_tc() only checks whether the new root
  qdisc is "mqprio" (strcmp(qdisc->ops->id, "mqprio")).
- [Medium] The driver commits a rejected config on a failed qdisc replace
  when hw-tc-offload is disabled, which is the default.
- [Medium] If rollback fails before the restart, the interface keeps
  transmitting with the rejected replacement's limits.
- [Medium] If ndo_open() fails during a rollback, the installed qdisc's
  offload state is discarded, so the next open runs with no limits.
- [Low] Two comments in otx2_mqprio_restart_netdev() contradict the code
  and the core API.
- [Low] The comment added in otx2_config_sched_shaping() says 65536 is
  "the kernel-side default burst when HTB does not supply an explicit…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  adds new triggers for it.
- [Low] This problem wasn't introduced by this patch, but the patch adds
  a new path into it.

--

octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This adds TC_SETUP_QDISC_MQPRIO offload with bw_rlimit shaping on octeontx2
PF and VF netdevs. Per-queue MDQ CIR/PIR is programmed through the AF
mailbox, and one SMQ is allocated per non-QoS queue under TL4[0]. Every
add, replace and delete bounces the netdev through ndo_stop()/ndo_open().
Rates are cached in software and restored on open, and a replace is staged
in mq_offload_snap snapshots that are committed on TC_ROOT_GRAFT or when
the replaced qdisc is torn down.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 836601fc10d8e..c95177602bf95 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

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

[ ... ]

> @@ -777,6 +914,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
>  		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
>  	}
>  
> +	if (pfvf->mqprio.rate_limit)
> +		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
> +
>  	rc = otx2_sync_mbox_msg(&pfvf->mbox);

[Severity: Medium]
With rate_limit set, otx2_txsch_alloc() asks for hw.non_qos_queues SMQs
but still only one TL4. otx2_txschq_config() then parents every MDQ to
schq_list[NIX_TXSCH_LVL_TL4][0] and writes NIX_AF_MDQX_SCHEDULE with only
the DWRR weight, so PRIO is 0.

Is NIX_AF_TL4X_TOPOLOGY ever programmed for that shared TL4? The HTB path
writes the parent topology for multi-child nodes in
otx2_qos_txschq_set_parent_topology():

    cfg->reg[0] = NIX_AF_TL4X_TOPOLOGY(parent->schq);
    cfg->regval[0] = (u64)parent->prio_anchor << 32;

The AF's nix_reset_tx_schedule() clears only PARENT and SCHEDULE on
allocation. It does not clear TOPOLOGY.

TL4[0] could still hold a non-zero PRIO_ANCHOR/RR_PRIO, for example after
a failed HTB topology reset, which otx2_qos_reset_schq_topology() only
warns about. In that case, could the sibling MDQs be arbitrated in a way
that doesn't give the per-queue min/max rates, while qopt->hw still
reports TC_MQPRIO_HW_OFFLOAD_TCS?

The netdev_warn_once() in otx2_setup_tc_mqprio() ("uses TL4[0] without
explicit topology programming") seems to acknowledge this.

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
Can TX channels ever be reduced again once mqprio offload has been used?

After a successful setup, otx2_mqprio_snap_commit() leaves old_mq_snap
allocated. otx2_mqprio_clear_sw() and otx2_mqprio_down() only drop
rate_limit and the rate cache. Only otx2_shutdown_tc_mqprio() frees the
snapshots, and otx2_mqprio_restore_old() can also return early without
freeing cur_mq_snap.

So after this sequence:

    tc qdisc add dev ethX root mqprio ... hw 1 ...
    tc qdisc del dev ethX root
    ethtool -L ethX tx <fewer>

the ethtool command keeps failing with -EINVAL until the driver is
unbound.

The snapshot is only used when rate_limit is true, and the rate_limit
check above already blocks channel changes in that case. What does this
second check protect?

The commit message says channel changes are rejected "while active",
which doesn't match this behaviour. It also doesn't mention that the
!replacing && otx2_mqprio_keep_netdev_tc() check in otx2_setup_tc_mqprio()
rejects replacing a software (hw 0) mqprio with an offloaded one.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 777e7156badb7..f51161e8b5949 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2008,6 +2008,15 @@ int otx2_open(struct net_device *netdev)
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

[Severity: Low]
This is a pre-existing issue, but this patch adds another path into it.
otx2_init_hw_resources() -> otx2_config_nix_queues() allocates
pf->refill_wrk with devm_kcalloc() on every open. The only free is in
otx2_stop():

    cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
    devm_kfree(pf->dev, pf->refill_wrk);

The new err_free_hw path unwinds through otx2_free_hw_resources(), which
doesn't free it. After a failed open, otx2_stop() returns early because
OTX2_FLAG_INTF_DOWN is set.

Does each otx2_mqprio_up() failure during open then leak one refill_wrk
array until unbind? The existing err_disable_napi and later labels leak
it the same way.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 8877af348a090..c05a7009a863b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -1600,14 +1619,907 @@ static int otx2_setup_tc_block(struct net_device *netdev,

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
> +	if (err) {
> +		netdev_err(netdev,
> +			   "mqprio: rollback failed to allocate rate cache: %d\n",
> +			   err);
> +		return err;
> +	}

[ ... ]

> +	otx2_mqprio_apply_snap_netdev(netdev, snap);
> +
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "mqprio: rollback shaper clear failed: %d; hardware limits may not match qdisc\n",
> +				   err);
> +			return err;
> +		}
> +	}

[Severity: Medium]
If either of these early returns is taken, what state is the running
interface left in?

If otx2_mqprio_alloc_cache() fails, the existing cache and the MDQ
shapers still hold the rejected replacement's rates.

If otx2_nix_tm_clear_queue_shaper() fails, the cache and netdev layout
have already been switched back to old_mq_snap, but the hardware shapers
are only partly cleared.

Neither path restarts the device, reapplies the old rates or frees
cur_mq_snap. The caller in otx2_teardown_tc_mqprio() just returns the
error, and mqprio_disable_offload() ignores it. The cleanup caller in
otx2_setup_tc_mqprio() only logs it.

Can the old qdisc then stay installed while the interface keeps
transmitting with the new or partially cleared limits?

> +
> +	/* Rebuild the TX scheduler via netdev restart when running; otx2_mqprio_up()
> +	 * alone is insufficient after a failed replace that already bounced the
> +	 * interface. If open failed, TX schedulers were freed; defer shaper restore
> +	 * to the next successful ndo_open() via otx2_mqprio_up().
> +	 */
> +	pfvf->mqprio.rate_limit = true;
> +
> +	if (netif_running(netdev)) {
> +		err = otx2_mqprio_restart_netdev(netdev, true);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "mqprio: rollback netdev restart failed: %d; qdisc rates may not be enforced\n",
> +				   err);
> +			return err;
> +		}

[Severity: Medium]
What happens to the restored state if ndo_open() fails inside this
restart? otx2_mqprio_restart_netdev() handles an open failure with:

    otx2_mqprio_clear_sw(pfvf);
    ...
    netif_close(netdev);

That sets rate_limit to false and frees the rate cache that was just
rebuilt from old_mq_snap. restore_old() then returns without rebuilding
it, while the old offloaded qdisc stays installed.

On the next ip link set up, otx2_open() -> otx2_mqprio_up() sees
!rate_limit and returns 0, and otx2_txsch_alloc() asks for a single SMQ.

Doesn't the interface then come up and pass traffic without any of the
qdisc's shapers? That seems to contradict the "failing closed on error"
wording in the commit message.

[ ... ]

> +/* Offloaded mqprio replaced by software mqprio installs netdev TC layout in
> + * mqprio_init() before the old offload instance is destroyed during graft.
> + */
> +static bool otx2_mqprio_keep_netdev_tc(struct otx2_nic *pfvf)
> +{
> +	struct Qdisc *qdisc = rtnl_dereference(pfvf->netdev->qdisc);
> +
> +	return qdisc && qdisc->ops && !strcmp(qdisc->ops->id, "mqprio");
> +}
> +
> +static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev = pfvf->netdev;
> +
> +	pfvf->mqprio.rate_limit = false;
> +	otx2_mqprio_clear_replace_state(pfvf);
> +	if (!otx2_mqprio_keep_netdev_tc(pfvf))
> +		netdev_set_num_tc(netdev, 0);
> +	otx2_mqprio_free_cache(pfvf);
> +}

[Severity: Medium]
Is mqprio the only root qdisc that installs a netdev TC layout before the
old root is destroyed? taprio_change(), called from taprio_init(), also
does netdev_set_num_tc(), netdev_set_tc_queue() and
netdev_set_prio_tc_map() for a software taprio.

Take this command run over an offloaded mqprio:

    tc qdisc replace dev ethX root taprio ...   (software mode)

qdisc_graft() publishes dev->qdisc as the taprio and then destroys the old
mqprio:

mqprio_destroy()
  mqprio_disable_offload()
    otx2_setup_tc_mqprio()        /* qopt->hw == 0 */
      otx2_teardown_tc_mqprio()
        otx2_mqprio_down()
          otx2_mqprio_clear_sw()
            netdev_set_num_tc(netdev, 0)

Since ops->id is "taprio" here, wouldn't this wipe the layout the live
taprio just installed and break its TC based classification?

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

[Severity: Medium]
Can the driver keep this offload state with no qdisc owning it? On
tc qdisc del the path is:

mqprio_destroy()
  mqprio_disable_offload()
    otx2_setup_tc_mqprio()        /* qopt->hw == 0 */
      otx2_teardown_tc_mqprio()
        otx2_mqprio_down()

mqprio_disable_offload() is void and ignores the return value. The qdisc
is destroyed even if otx2_nix_tm_clear_queue_shaper() gets a mailbox
error here.

That leaves rate_limit set, the rate cache populated, the SMQ allocation
widened and the MDQ shapers programmed. otx2_open() -> otx2_mqprio_up()
then reapplies the shapers on every open, and XDP, HTB, PFC and channel
changes stay rejected.

The next tc qdisc add ... mqprio hw 1 computes replacing = rate_limit =
true and sets replace_setup_done. The old root is now the default mq,
whose destroy only sends TC_SETUP_QDISC_MQ, so cur_mq_snap is never
committed.

When that new mqprio is deleted, otx2_teardown_tc_mqprio() takes the
replace_setup_done && cur_mq_snap branch. It commits and returns 0
without clearing shapers or restarting.

The non-replacing cleanup path in otx2_setup_tc_mqprio() also ignores the
result of the teardown:

    otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
    otx2_teardown_tc_mqprio(pfvf, mqprio);
    return err;

The core can't veto this teardown, so should the software state be
released unconditionally?

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

[ ... ]

> +	err = ops->ndo_open(netdev);
> +	if (!err && running) {
> +		set_bit(__LINK_STATE_START, &netdev->state);
> +	} else if (err) {
> +		netdev_err(netdev,
> +			   "Failed to restart device after mqprio change: %d\n",
> +			   err);
> +		/* ndo_open() already tore down TX scheduler resources on failure;
> +		 * netif_running() is false here (__LINK_STATE_START stays clear
> +		 * until open succeeds). Drop mqprio software state only instead
> +		 * of sending shaper clears to freed queues.
> +		 */
> +		otx2_mqprio_clear_sw(pfvf);
> +		/* ndo_open() rolls back on failure; mark the interface down so
> +		 * otx2_stop() returns early when netif_close() runs.  Caller
> +		 * holds RTNL; dev_close() would deadlock.
> +		 */
> +		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}

[Severity: Medium]
Is it intended that a failed tc command can take the interface
administratively down? netif_close() clears IFF_UP and sends
NETDEV_GOING_DOWN and NETDEV_DOWN. A failed tc qdisc add, replace, del or
rollback therefore leaves the link down until an admin brings it back.

The open can fail for reasons unrelated to the request. For example, the
AF may refuse the hw.non_qos_queues SMQs that otx2_txsch_alloc() now
requests, or otx2_mqprio_up() may fail.

This function also sets and clears the core-owned __LINK_STATE_START bit
itself from inside ndo_setup_tc.

The commit message describes "failing closed" only for shaper restore in
ndo_open(). Could it also mention that tc setup, replace and delete can
close the device?

[Severity: Low]
Is the dev_close() part of this comment accurate? In this tree,
dev_close() is:

net/core/dev_api.c:dev_close() {
	netdev_lock_ops(dev);
	netif_close(dev);
	netdev_unlock_ops(dev);
}

It doesn't take RTNL, so there is no RTNL deadlock to avoid.

The block comment above this function also says "Do not call
dev_deactivate()/dev_activate() here". However, netif_close() ->
__dev_close_many() calls dev_deactivate_many() and runs the down
notifiers from inside ndo_setup_tc. Could these comments be brought in
line with the code?

[ ... ]

> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		err = 0;
> +		if (pfvf->mqprio.replace_graft_done || !tc_can_offload(netdev)) {
> +			otx2_mqprio_snap_commit(pfvf);
> +		} else {
> +			err = otx2_mqprio_restore_old(pfvf);

[Severity: Medium]
Can this commit a configuration that the core rejected?

otx2_probe() and otx2vf_probe() add NETIF_F_HW_TC to hw_features only
after features |= hw_features. By default, tc_can_offload() is false and
TC_ROOT_GRAFT is never delivered. otx2_tc_can_offload() checks
hw_features, so mqprio setup still runs.

In that state, this branch can't tell two cases apart: teardown of the
old instance after a graft, and destruction of a new instance that failed
after init. For example:

    tc qdisc replace dev ethX root handle 2: mqprio hw 1 ... \
        shaper bw_rlimit ... estimator 1sec 8sec

otx2_setup_tc_mqprio() succeeds, programs the new MDQ shapers and sets
replace_setup_done. qdisc_create() then rejects TCA_RATE for a
TCQ_F_MQROOT qdisc:

    if (tca[TCA_RATE]) {
        err = -EOPNOTSUPP;
        if (sch->flags & TCQ_F_MQROOT) {
            ...
            goto err_out4;

err_out4 -> mqprio_destroy(new) then lands here and commits.

Doesn't the old qdisc then stay root while the hardware shapers, rate
cache, old_mq_snap and netdev TC mapping all hold the rejected config?
otx2_mqprio_up() would also reapply it on every open.

[ ... ]

> +static int otx2_setup_tc_mqprio(struct net_device *netdev,
> +				struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	err = otx2_mqprio_stage_cur(pfvf, mqprio);
> +	if (err)
> +		goto fail_validate;
> +
> +	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
> +	if (err)
> +		goto cleanup;

[Severity: Medium]
This isn't a bug introduced by this patch, but the new restart adds more
ways to trigger it. An egress matchall police filter programs
NIX_AF_TL4X_PIR on txschq_list[NIX_TXSCH_LVL_TL4][0] in
otx2_set_matchall_egress_rate() and sets
OTX2_FLAG_TC_MATCHALL_EGRESS_ENABLED. The rate and burst are not cached
for replay.

Every mqprio add, replace, delete or rollback bounces the netdev here.
ndo_stop() frees the TL4, and the AF clears its shaping through
nix_reset_tx_shaping() when it is reallocated. Neither otx2_open() nor
otx2_mqprio_up() replays the matchall rate, and otx2_setup_tc_mqprio()
doesn't reject the combination.

Does the filter then stay marked as offloaded with no hardware limit
behind it? The same loss already happens on ip link down/up, MTU changes
and ethtool -L.

[ ... ]

> +fail_validate:
> +	/* Failed replace destroys the new qdisc with hw_offload unset, so
> +	 * mqprio_destroy() clears netdev TC after we return. Re-apply the
> +	 * prior layout when validation fails before any hardware change.
> +	 */
> +	if (replacing)
> +		otx2_mqprio_defer_netdev_tc_restore(pfvf);
> +	return err;

[Severity: Medium]
Is there a window here where the old offload is still active but
dev->num_tc is 0? When a replace fails here, qdisc_create() unwinds via
err_out4 -> mqprio_destroy() on the new instance. With hw_offload unset,
that runs:

    if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
        mqprio_disable_offload(sch);
    else
        netdev_set_num_tc(dev, 0);

The restore is queued to system_wq and can only run after the caller
drops RTNL. Until then, rate_limit and the old shapers are still in
place, but skb_tx_hash() ignores the prio to TC mapping. Traffic can then
go out on queues shaped for other TCs.

Other RTNL holders that get the lock first (another tc command, a dump, a
teardown) also see num_tc == 0. otx2_mqprio_netdev_tc_work() later
reapplies old_mq_snap without checking whether the layout changed in the
meantime. The successful-rollback branch in the cleanup path uses the
same deferral.

Could the commit message explain this approach and the window it leaves?

[ ... ]

> @@ -1625,10 +2537,25 @@ int otx2_init_tc(struct otx2_nic *nic)

[ ... ]

> +void otx2_shutdown_tc_mqprio(struct otx2_nic *nic)
> +{
> +	WRITE_ONCE(nic->mqprio.defer_tc_work, true);
> +	/* Publish defer_tc_work before cancel_work_sync(). */
> +	smp_wmb();
> +	cancel_work_sync(&nic->mqprio.netdev_tc_work);
> +	rtnl_lock();
> +	otx2_mqprio_snap_destroy(nic);
> +	rtnl_unlock();
> +}
> +EXPORT_SYMBOL(otx2_shutdown_tc_mqprio);

[Severity: High]
Can the work be queued again after this cancel_work_sync()? The flag is
written and the work cancelled without holding RTNL.
otx2_mqprio_defer_netdev_tc_restore() runs under RTNL and does a separate
check followed by schedule_work():

CPU A (failing tc qdisc replace, holds RTNL)
otx2_mqprio_defer_netdev_tc_restore()
    READ_ONCE(pfvf->mqprio.defer_tc_work) == false

CPU B (otx2_remove() or otx2vf_remove())
otx2_shutdown_tc_mqprio()
    WRITE_ONCE(nic->mqprio.defer_tc_work, true)
    cancel_work_sync()     /* nothing queued yet */
    rtnl_lock()            /* blocks */

CPU A
    schedule_work(&pfvf->mqprio.netdev_tc_work)
    /* returns, RTNL dropped */

CPU B then destroys the snapshots, calls unregister_netdev() and later
free_netdev(). It never calls cancel_work_sync() or flush_work() again.

If system_wq hasn't run the item by then, isn't the work_struct in
netdev_priv freed while still queued? otx2_mqprio_netdev_tc_work() would
then read defer_tc_work from freed memory.

Setting the flag under rtnl_lock(), or cancelling the work again after
unregister_netdev(), would close this.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> index f160b1618efa2..9ef55a6db50b7 100644
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
Is this comment accurate? struct tc_htb_qopt_offload carries quantum,
rate, ceil and prio but no burst. HTB offload can never supply a burst,
so 65536 is a driver constant passed every time rather than a fallback.

The new comment in otx2_nix_tm_set_queue_shaper() describes it the same
way ("the same 65536 byte default as the HTB shaper path").

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006094357.840823-1-rkannoth%40marvell.com
