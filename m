Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432752;
	b=b0Bd8XJfqRa9IouB0qFFxs5MHiQZRFbZrgIhIg5cKAJcC/7Ory62SDYQvaGmCwkp8k2J
	 cBzkce+za/cyPYT42HEQPcIjjOjWRXZapjHvFZ/TUVCiIqD90pclwy6Xi5i0BYLpzs2CT
	 qsm4RcMOum43meyt1SuzwXG9toAEKUPknKFkVJU8gHlSIqrIn69QkKQLVLG1PHYVifCVw
	 CEYSTeNSb6U97sB1239Cv0GU9Cs5y6LpbrK6HX3+bgaWOfRHlwqatPZ7fUkpUW2ti3MSG
	 gVhUZUwPnQ973DBrRXibpojY+D40Uf9w2Sl4q/Jdil4zzAq65XDxtQ98MFA3H0216wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432752;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ik02p+uK2YLh80l4u9gkdlHPsZgpxQf+NuL8GUZ56cc=;
	b=VFXKZPGQj6wFRzH+H1sK5/9bO/4JKUqtzgQF3DqWzMWt+raGacIOWVVnQS53U33UZ6PA
	 gDAwGIltwWPWurPG43mFxTnyGz4Bj81rMvPKvCpVtX4zKSk56bIO8wvORWLfciauGWkQq
	 qJeOfP4bTY3kjMeuWB2NdqYC05gvxOAhFLE+wwlj2C39A4qVJsqWDumFa06KUkZRgHLS4
	 /rKh/vK6MtPcOdZyZFnOc0Aaj5VeJh1yklL3qqIWHONwB55oaS7SFFCra71w4Ml586Xv7
	 qi2/fCkU2WPRgxgvLeTw46DF2WIuf72WXbW6mrfLSiVqrNhklHshzDRJMFIkNtEZDLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K97nDBnU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3562606A335;
	Wed, 11 Nov 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K97nDBnU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19EF1F00A05;
	Wed, 11 Nov 2026 21:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432751;
	bh=ik02p+uK2YLh80l4u9gkdlHPsZgpxQf+NuL8GUZ56cc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K97nDBnUT5eF2raZIJztqibpydtRYUx0Li7ClBS+37Q7yCRh8Agu8qdi+BBadXgob
	 Xy9p/XexdfkaZ22/GQQRL8r80+N528rssBmnxMG+u3zMWj3jxWrW872zAz5eNI7BQn
	 4EfUBH0ASGK+rCLgsdFhFcXyuqJHB/CX1hWtvq78WKHDKUJZIqwcl7dpcacjSDqoY/
	 g0BUaXpbEWqQg99vxfKJVrtyv9DiNewyF70C1I3pV2wHFs6xBoLKkAGP4agTWQePVT
	 P1poOba3v6+BIM55K3sQMxRPkNimUobF7oAMflz9SkhLFFiNGDNkqmn53Y6RfB1ZY6
	 8pUNxTZDzfRTw==
Subject: Re: [PATCH v21 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com, horms@kernel.org
Date: Wed, 11 Nov 2026 21:32:30 +0000
Message-ID: <179443275039.2199510.3340754433806692028@kernel.org>
In-Reply-To: <20261109033154.2161803-3-rkannoth@marvell.com>
References: <20261109033154.2161803-3-rkannoth@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Replacing an offloaded mqprio with a software taprio stops TX
  on the interface.
- [Medium] With mqprio rate limiting active, otx2_txsch_alloc() requests
  hw.non_qos_queues SMQs but still only one TL4.
- [Medium] Setup and teardown use different notions of 'offload enabled'.
- [Medium] When otx2_mqprio_down() fails, otx2_teardown_tc_mqprio()
  returns immediately and skips otx2_mqprio_restart_netdev(netdev,…
- [Medium] The new otx2_mqprio_up() failure branch in otx2_open() jumps
  to the new err_free_hw label.
- [Medium] octeontx2-pf: premature otx2_mcam_flow_del() in otx2_probe()
  error path
- [Low] The commit message leaves out several changes that reach code
  paths unrelated to mqprio.
- [Low] otx2_mqprio_restart_netdev(), called from ndo_setup_tc, clears
  and sets __LINK_STATE_START on netdev->state directly.
- [Low] The new comment in otx2_config_sched_shaping() calls 65536 'the
  kernel-side default burst when HTB does not supply an explicit value'.
- [Low] The comment on otx2_mqprio_keep_netdev_tc() says it detects a new
  software mqprio that installed its TC layout before the old offloaded…
- [Low] In otx2_setup_tc_mqprio(), the cleanup path for a failed replace
  is entered mid-loop when otx2_nix_tm_set_queue_shaper() fails.

--

octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload with the bw_rlimit shaper
for octeontx2 PF and VF netdevs. It programs per-queue MDQ CIR/PIR through
the NIX TX scheduler mailbox.

The TX scheduler cannot be reprogrammed live, so every mqprio add, replace
and delete bounces the netdev through ndo_stop()/ndo_open(). Cached rates
are restored from otx2_mqprio_up(), and replace operations are staged in
snapshots.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index f4047b0d5d963..b4a738cf9a8b7 100644
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

[Severity: Medium]
With rate_limit set, otx2_txsch_alloc() asks for hw.non_qos_queues SMQs
but still only one TL4. Every MDQ then becomes a child of TL4[0] with
MDQ_SCHEDULE = dwrr_val (priority 0).

Is NIX_AF_TL4X_TOPOLOGY for TL4[0] programmed anywhere on this path?

As far as I can tell, TL4X_TOPOLOGY is only written from nic/qos.c. The AF
reset clears only PARENT and SCHEDULE:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:nix_reset_tx_schedule() {
	case NIX_TXSCH_LVL_TL4:
		tlx_parent   = NIX_AF_TL4X_PARENT(schq);
		tlx_schedule = NIX_AF_TL4X_SCHEDULE(schq);
}

The HTB teardown in otx2_qos_free_hw_schq() does reset the topology, but
only best-effort. If the mailbox fails it warns and frees the schq anyway.

TL4[0] may have been last used by another function, or by an HTB teardown
whose reset failed. Can it then keep a non-zero RR_PRIO/PRIO_ANCHOR? If
so, the priority-0 MDQ children would not form a single DWRR group, and
per-queue shaping could behave unexpectedly.

The patch acknowledges this later with:

	netdev_warn_once(netdev,
			 "mqprio: bandwidth offload uses TL4[0] without explicit topology programming; verify scheduling if limits look wrong\n");

Would it make sense to program TL4[0] TOPOLOGY with an RR_PRIO that
matches the MDQ priority when several MDQs are attached?

[ ... ]

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

[Severity: Medium]
Does this new error path leak pf->refill_wrk?

otx2_init_hw_resources()->otx2_config_nix_queues() has just allocated it:

	pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
					sizeof(struct refill_work), GFP_KERNEL);

err_free_hw only runs otx2_free_hw_resources() and otx2_free_queue_mem().
Neither of them frees refill_wrk. The only devm_kfree() of it is in
otx2_stop().

When the open fails from otx2_mqprio_restart_netdev(), OTX2_FLAG_INTF_DOWN
is set before netif_close(). otx2_stop() then returns early, so the
allocation is never released.

With rate_limit active, a persistent shaper mailbox failure would leak
cq_cnt * sizeof(struct refill_work) on every admin up attempt until the
driver is unbound.

The older error labels after otx2_init_hw_resources() have the same gap.
This patch adds a new way to reach it from userspace.

[ ... ]

> @@ -2281,6 +2291,7 @@ int otx2_stop(struct net_device *netdev)
>  	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
>  		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
>  
> +	synchronize_net();
>  	otx2_free_queue_mem(qset);

[Severity: Low]
This isn't a bug, but several changes here affect paths outside mqprio,
and the commit message does not mention them.

synchronize_net() now runs on every ndo_stop. That covers admin down,
otx2_change_mtu(), ethtool channel and ring changes, XDP attach/detach,
and the reset task. Under RTNL it becomes synchronize_rcu_expedited().

What race does it close? If it fixes an existing problem with
otx2_free_queue_mem(), could it go in a separate patch with a Fixes: tag?

otx2_txschq_stop() now zeroes hw.txschq_cnt[] for every caller. After a
stop, otx2_get_smq_idx() returns 0 instead of the last SMQ. Existing users
such as otx2_pfc_update_sq_smq_mapping() and otx2_qos_disable_sq() will
see this.

The PF and VF probe/remove ordering also changes:

  - otx2_init_tc() and otx2vf_mcam_flow_init() now run before
    register_netdev()
  - otx2_shutdown_tc() moves to right after unregister_netdev()
  - the error labels are rewired

There are also comment-only edits in qos.c and otx2_get_egress_burst_cfg().

Could the commit message describe these changes, or could they be split
out?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 8877af348a090..b34a86259e786 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

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

[Severity: Low]
The replace path in otx2_setup_tc_mqprio() can reach cleanup because
otx2_nix_tm_set_queue_shaper() failed partway through the loop. At that
point pfvf->mqprio.min_rate[]/max_rate[] and pfvf->mqprio.flags already
hold part of the new config, and rate_limit is true.

If otx2_mqprio_alloc_cache() fails here, we return before refilling the
cache from old_mq_snap. Does that leave the partially-new rates cached
with rate_limit still set, while the old qdisc stays root?

The same applies if otx2_nix_tm_clear_queue_shaper() fails further down.
The cache is restored, but the hardware keeps the partially-new shapers.

On the restore_err branch in otx2_setup_tc_mqprio(), no deferred TC
restore is scheduled. num_tc therefore stays 0 after mqprio_destroy() of
the failed qdisc. From then on, otx2_mqprio_up() would re-apply the mixed
rate set on every ndo_open().

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

[Severity: Low]
Can this match the offloaded mqprio that is being destroyed, and not only
a new software mqprio?

dev_shutdown() puts the root qdisc while dev->qdisc still points at it:

net/sched/sch_generic.c:dev_shutdown() {
	qdisc_put(rtnl_dereference(dev->qdisc));
	rcu_assign_pointer(dev->qdisc, &noop_qdisc);
}

When offload is active, mqprio_destroy() leaves num_tc to the driver:

net/sched/sch_mqprio.c:mqprio_destroy() {
	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);
}

This happens on unregister, and in __dev_change_net_namespace(), which
calls netif_close() and then dev_shutdown(). In both cases
otx2_mqprio_clear_sw() would see "mqprio" and skip
netdev_set_num_tc(netdev, 0).

After a netns move, the stale TC layout would stay while only the default
mq is attached. skb_tx_hash() would keep limiting queue selection to the
old TC offset/count until a new mqprio is installed.

> +static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev = pfvf->netdev;
> +
> +	pfvf->mqprio.rate_limit = false;
> +	otx2_mqprio_clear_replace_state(pfvf);
> +	if (!otx2_mqprio_keep_netdev_tc(pfvf)) {
> +		struct Qdisc *root = rtnl_dereference(netdev->qdisc);
> +
> +		if (root && root->ops && !strcmp(root->ops->id, "taprio"))
> +			netdev_warn(netdev,
> +				    "mqprio: offload teardown cleared the TC layout of the new %s\n",
> +				    root->ops->id);
> +		netdev_set_num_tc(netdev, 0);
> +	}

[Severity: Medium]
Does replacing an offloaded mqprio with a software taprio stop TX on the
interface?

Consider "tc qdisc replace dev X root taprio ..." without full offload:

  1. taprio_change() installs its layout with netdev_set_num_tc() and
     netdev_set_tc_queue().
  2. qdisc_graft() publishes taprio as dev->qdisc and destroys the old
     mqprio.
  3. Because hw_offload is set, mqprio_destroy() calls ndo_setup_tc()
     with hw=0.
  4. otx2_teardown_tc_mqprio() reaches otx2_mqprio_clear_sw(), either
     directly or through otx2_mqprio_down()/otx2_mqprio_restart_netdev().

Here the root is detected as "taprio" and the warning is printed, but
netdev_set_num_tc(netdev, 0) still runs.

otx2 returns -EOPNOTSUPP for TAPRIO caps, so taprio uses
taprio_dequeue_tc_priority():

net/sched/sch_taprio.c:taprio_dequeue_tc_priority() {
	int num_tc = netdev_get_num_tc(dev);
	...
	for (tc = num_tc - 1; tc >= 0; tc--) {
}

With num_tc == 0 this loop never runs, so dequeue always returns NULL.

Should the TC layout also be kept for taprio, or for any new root that
owns it?

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> +{

[ ... ]

> +	if (running) {
> +		clear_bit(__LINK_STATE_START, &netdev->state);
> +		smp_mb__after_atomic(); /* Commit netif_running(). */
> +	}

[ ... ]

> +		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
> +		/* visible to otx2_stop() on other cpus */
> +		smp_wmb();
> +		netif_close(netdev);
> +	}

[Severity: Low]
Is it ok for a driver to clear and set __LINK_STATE_START directly from
ndo_setup_tc()? I couldn't find another driver under drivers/net that
does this. The bit is owned by the core open/close helpers.

When ndo_open() fails, netif_close() is also called from inside the qdisc
operation. A failed "tc qdisc add/replace/del ... mqprio" can then take
the interface administratively down. That includes a delete, which the
core cannot veto. IFF_UP is cleared and NETDEV_GOING_DOWN/NETDEV_DOWN are
sent.

The commit message only says the netdev is bounced through
ndo_stop()/ndo_open(). Could it mention that a tc command can close the
interface?

[ ... ]

> +static bool otx2_tc_can_offload(struct net_device *netdev)
> +{
> +	return !!(netdev->hw_features & NETIF_F_HW_TC);
> +}
> +
> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		err = 0;
> +		if (pfvf->mqprio.replace_graft_done || !tc_can_offload(netdev)) {
> +			otx2_mqprio_snap_commit(pfvf);
> +		} else {

[Severity: Medium]
otx2_tc_can_offload() checks netdev->hw_features. This check uses the
core tc_can_offload(), which checks netdev->features. Can the two
disagree in the default configuration?

Both otx2_probe() and otx2vf_probe() add NETIF_F_HW_TC to hw_features
after "netdev->features |= netdev->hw_features". So hw-tc-offload is off
by default, and qdisc_offload_graft_helper() never sends TC_ROOT_GRAFT:

net/sched/sch_api.c:qdisc_offload_graft_helper() {
	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
		return;
}

As a result, this branch always commits.

Suppose a replacement mqprio passes otx2_setup_tc_mqprio() and then fails
later in qdisc_create(). For example, an estimator on a TCQ_F_MQROOT
qdisc goes to err_out4 and ->destroy().

Wouldn't the rejected config be committed as old_mq_snap? The hardware
shapers and netdev TC layout would keep enforcing it while the old qdisc
stays root.

Separately, on the PF NETIF_F_HW_TC is only in hw_features when
OTX2_FLAG_TC_FLOWER_SUPPORT is set. Is it intended that MDQ shaping is
refused on PFs without flower/MCAM support? The commit message says the
feature applies to PF and VF netdevs, without that qualification.

[ ... ]

> +	if (if_up) {
> +		err = otx2_mqprio_down(pfvf);
> +		if (err) {
> +			if (extack)
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "mqprio: teardown incomplete (%d)",
> +						       err);
> +			netdev_err(netdev,
> +				   "mqprio: offload teardown incomplete (%d); driver state may not match removed qdisc\n",
> +				   err);
> +			return err;
> +		}
> +
> +		err = otx2_mqprio_restart_netdev(netdev, false);

[Severity: Medium]
If otx2_nix_tm_clear_queue_shaper() fails inside otx2_mqprio_down(), the
software state has already been released through otx2_mqprio_clear_sw().
otx2_mqprio_down() explains this as:

	/* The core cannot veto qdisc teardown, so always release software
	 * state.  The netdev restart that follows reallocates the TX
	 * scheduler, which drops any shaper left programmed.
	 */

On this error path, though, we return before otx2_mqprio_restart_netdev(),
so no restart follows. Doesn't that leave the MDQ CIR/PIR limits and the
widened SMQ allocation in place, with rate_limit false and num_tc 0?

mqprio_disable_offload() is void, so "tc qdisc del" looks successful to
the user. The stale limits would remain until an unrelated
ndo_stop()/ndo_open().

Should the restart still happen when the clear fails?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> index 2ede0b84e5f52..732fff75ab0be 100644
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

[Severity: Low]
This isn't a bug, but is this comment accurate? struct tc_htb_qopt_offload
has no burst member, so HTB offload can never supply an explicit burst,
and 65536 is always used.

The comment in otx2_nix_tm_set_queue_shaper() ("Use the same 65536 byte
default as the HTB shaper path") repeats the same idea.

[ ... ]

> @@ -3420,11 +3437,13 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	otx2_sriov_vfcfg_cleanup(pf);
>  err_pf_sriov_init:
>  	otx2_unregister_dl(pf);
> -	otx2_shutdown_tc(pf);
>  err_mcam_flow_del:
>  	otx2_mcam_flow_del(pf);
>  err_unreg_netdev:
> +	otx2_shutdown_tc_mqprio(pf);
>  	unregister_netdev(netdev);
> +err_shutdown_tc:
> +	otx2_shutdown_tc(pf);
>  err_ipsec_clean:
>  	cn10k_ipsec_clean(pf);
>  err_mcs_free:

[Severity: Medium]
Does the new label ordering stop otx2_shutdown_tc() from doing
anything on the late probe error paths?

Before this patch, err_pf_sriov_init ran otx2_shutdown_tc() and only
then fell through to otx2_mcam_flow_del(). With this patch, a failure
in otx2_register_dl(), otx2_sriov_vfcfg_init(), the af_xdp_zc_qidx
bitmap_zalloc() or otx2_dcbnl_set_ops() unwinds like this:

  err_mcam_flow_del:  otx2_mcam_flow_del()
  err_unreg_netdev:   otx2_shutdown_tc_mqprio(), unregister_netdev()
  err_shutdown_tc:    otx2_shutdown_tc()

otx2_mcam_flow_del() goes through otx2_destroy_mcam_flows(), which
clears OTX2_FLAG_MCAM_ENTRIES_ALLOC.

otx2_shutdown_tc() then calls otx2_destroy_tc_flow_list(). That
function returns early when OTX2_FLAG_MCAM_ENTRIES_ALLOC is clear, so
it no longer walks flow_cfg->flow_list_tc.

Any otx2_tc_flow nodes added while the netdev was registered are
therefore never freed. The window is small, and installing flower
rules needs CAP_NET_ADMIN.

The ordering is also now the reverse of otx2_remove() after this
patch. There, otx2_shutdown_tc() runs right after unregister_netdev(),
and otx2_mcam_flow_del() runs later.

The unwind already reaches err_del_mcam_entries by fallthrough from
err_shutdown_tc/err_ipsec_clean/err_mcs_free. err_del_mcam_entries
calls otx2_mcam_flow_del() again, so the call at err_mcam_flow_del
looks redundant.

Could that first call be dropped, with the labels folded, so the probe
error path mirrors otx2_remove()? Or is there a reason the MCAM flows
have to be deleted before unregister_netdev() here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109033154.2161803-1-rkannoth%40marvell.com
