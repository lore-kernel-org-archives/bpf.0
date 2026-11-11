Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432750;
	b=wV90KKg/33GFXdQvqK4Z7StbMmjm5kKrWJLG6unvEdljMmMGrIDFu5g/p0EBkGAalo0g
	 y8C0Gl4PNztB0CWbzRX2s1bi2ExwFrTQ+TUU7FP6QgqOV54GC6SCim/CWG2486zO7XIBI
	 7eh0Urh8BFGE3joBUDu56g+foaTbnHj8PqLcQ+WxzjOVelrE5Avg9mo6urCyCH27I8ExU
	 2qfI0ubBFeWyYHiDXM2SwVdDzJ1W5BsEne6xVwgXSDp4lya+awDN3mOvAi8L5u5Q8wZnT
	 S62xINipmzbkJaNve//nZgcSfbzRwhfQzxr//rIHyvEXlqDN/+LRUUW2BMUXLGpE6UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432750;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kxbf3l4PwwrW7Y1vn02v3Jh0QNwyNuvNiAlETx11VVU=;
	b=i53u7WH9dq0hKSM9BfGJO8IVBevf5bZakzDYYmZyYS77R7uAGnIcNuoUZT0g9G7WgJ+R
	 eo3rEjwYoK2XwKd+QBPRLk4tRXXHT0cQstVQ+ASKVNKT3/MyKozoHKwAQOuGIt30MclHY
	 u/Qrv/PjKEH5U0hXOSxW48r3Qa39eQ47NPbzuka8bqxjL4bABc3bhP8drceSApRHWPrvX
	 26spoOA0lLq0oqqPEb8cQhjvtHH8wj41dCxaxp347orP9ZBmIRDs6g20fxLuj84hu/z1T
	 eCRwJCOJCi1ym2o6kDZYERtWv5gfY28K0FIJy9HYEeoiXS6xKhfknGe77HvxBrWWxhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTa0TVer;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB4606A321;
	Wed, 11 Nov 2026 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTa0TVer
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC561F00A05;
	Wed, 11 Nov 2026 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432750;
	bh=kxbf3l4PwwrW7Y1vn02v3Jh0QNwyNuvNiAlETx11VVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kTa0TVergh5/vhkjlPJ95P9Ugbh++VcANgAPwAIvyxfUWa6ZwDTlDrDH3uIed8sbt
	 cBJbQ43WwegcEOpcmD/Vph7kcIBYctPfiSyRb2SjagySZ583JwwyyWHRqNa3LhDdwU
	 rflZT0UvUq5ugSjYknZc1uSTdwts8Sb6Eqjky6+4Wx+6qnnUILUjWdQiX4JyjGdw35
	 xCudE/wsLKsZYY8IT96fO4RxCk2pvvgHLlBLzJW9MANSF0A/xXbooOU7jXECtnPRix
	 gcUNAMayO1a9D2qpCqzo6qPjDxj/r6jh4MPXq3i2o1Hnmsoe+COOFvBQtO/HDWkb9P
	 kuM4Zyb7ln2qA==
Subject: Re: [PATCH v21 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sgoutham@marvell.com, horms@kernel.org
Date: Wed, 11 Nov 2026 21:32:28 +0000
Message-ID: <179443274883.2199510.3348914597691786144@kernel.org>
In-Reply-To: <20261109033154.2161803-2-rkannoth@marvell.com>
References: <20261109033154.2161803-2-rkannoth@marvell.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 (4) · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] otx2_sync_flags_from_rep()
  (drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h) is the only…
- [Medium] The commit message hides that this patch fixes a real bug, and
  it has no Fixes: tag.
- [Medium] Before this patch, `priv->flags = rep->flags` always cleared
  OTX2_FLAG_INTF_DOWN on the eswitch PF context before calling into the…
- [Low] The commit message says the flags now use atomic bitops and that
  otx2_sync_flags_from_rep() publishes representor flags "without…

Pre-existing issues:
- [Critical] rvu_rep_state_evt_handler()
  (drivers/net/ethernet/marvell/octeontx2/nic/rep.c) does `rep_id =…
- [High] rep->stats_wrk is set up with INIT_DELAYED_WORK in
  rvu_rep_create().
- [High] In rvu_rep_destroy()
  (drivers/net/ethernet/marvell/octeontx2/nic/rep.c),…
- [High] rvu_rep_mcam_flow_init()
  (drivers/net/ethernet/marvell/octeontx2/nic/rep.c) builds and sends…
- [High] Any PF or VF, including a VF owned by a guest since the PF
  forwards all VF mbox messages to AF, can send REP_EVENT_NOTIFY with…
- [Medium] rvu_rep_setup_tc_cb() calls rvu_rep_mcam_flow_init(rep) on
  every tc callback while OTX2_FLAG_TC_FLOWER_SUPPORT is clear in…

--

octeontx2: use atomic bitops for PF/VF and rep flags

This converts the otx2_nic and rep_dev flags from u64 masks to unsigned
long bitmaps, updated through set_bit()/clear_bit()/test_bit() helpers.
In rvu_rep_setup_tc_cb(), the full-word assignment is replaced by
otx2_sync_flags_from_rep(), which copies a mask of representor-owned bits
onto the eswitch PF context. The representor VF-initialized flag moves
from BIT_ULL(0) in rep.h to OTX2_FLAG_REP_VF_INITIALIZED (bit 21).

> Switch PF/VF and representor flags from non-atomic u64 masks to unsigned
> long bitmaps with set_bit/clear_bit/test_bit.  Add helpers and
> otx2_sync_flags_from_rep() to publish representor-owned flags onto the PF
> mailbox context with a masked WRITE_ONCE, giving lockless NAPI readers a
> consistent word without clearing PF-owned bits.

[Severity: Low]
Is "without clearing PF-owned bits" accurate? otx2_sync_flags_from_rep()
does a plain READ_ONCE()/mask/WRITE_ONCE() read-modify-write of
dst->flags. Every other writer of that word now uses set_bit() or
clear_bit().

If an atomic update to a PF-owned bit lands between the read and the
write, it gets overwritten. So the guarantee only holds when nothing else
is writing at the same time. There are more details on this below, at
otx2_sync_flags_from_rep().

Could the commit message also say which concurrent update problem the
atomic conversion is meant to fix?

> Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
> (bit 21).

[Severity: Medium]
Is this only a relocation? Before this patch, rvu_rep_setup_tc_cb() did:

    priv->flags = rep->flags;

That overwrote the whole flags word of the eswitch PF otx2_nic, including
OTX2_FLAG_REP_MODE_ENABLED, which rvu_rep_probe() sets.

The removed RVU_REP_VF_INITIALIZED was also BIT_ULL(0), the same bit as
OTX2_FLAG_RX_TSTAMP_ENABLED. The callback only gets past its first check
when that bit is set, so the bit was copied onto priv every time.

Once REP_MODE_ENABLED was cleared, otx2_tx_napi_handler() stopped taking
these branches:

    if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
        ndev = pfvf->reps[qidx]->netdev;
    ...
    if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
        qidx = 0;
    txq = netdev_get_tx_queue(ndev, qidx);

Instead it fell back to pfvf->netdev, which rvu_rep_setup_tc_cb() had
pointed at rep->netdev. That netdev comes from alloc_etherdev() and has a
single TX queue, and qidx was no longer clamped. Doesn't that index past
dev->_tx[] and then write DQL state beyond it?

If so, this patch includes a fix. Would a Fixes: tag and a description of
the old behaviour help with stable backports?

The mask also changes one more behaviour: OTX2_FLAG_TC_MARK_ENABLED now
stays set in priv instead of being cleared on every representor tc
callback. Is that intended, and is it worth mentioning in the commit
message?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 8417af94a02a0..f3158e293d864 100644
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
Can this lose concurrent updates to PF-owned bits in priv->flags?

The only caller is rvu_rep_setup_tc_cb(), which runs from the tc block
callback under rtnl. Other writers of the same word don't hold rtnl. One
example is the devlink eswitch path:

otx2_devlink_eswitch_mode_set()
    case DEVLINK_ESWITCH_MODE_LEGACY:
        rvu_rep_destroy(pfvf);
            otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);

This runs under the devlink lock only; unregister_netdev() takes rtnl
later. rvu_rep_napi_init() clears INTF_DOWN on the same devlink path, and
the mbox up-handler work sets and clears OTX2_FLAG_PORT_UP.

If one of those set_bit()/clear_bit() calls lands between the READ_ONCE()
and the WRITE_ONCE() here, the stale word gets written back.

If the INTF_DOWN set is lost, the eswitch PF still looks up after
teardown. otx2_napi_handler() can then re-arm the CINT, and
rvu_rep_remove() runs destroy a second time:

    if (!otx2_test_flag(priv, OTX2_FLAG_INTF_DOWN))
        rvu_rep_destroy(priv);

That second destroy calls unregister_netdev()/free_netdev() on netdevs
that are already freed, and calls kfree(priv->reps) a second time.

If the INTF_DOWN clear in rvu_rep_napi_init() is lost instead, the CQ
interrupts are never re-enabled, because otx2_napi_handler() returns
early:

    if (otx2_test_flag(pfvf, OTX2_FLAG_INTF_DOWN))
        return workdone;

Would updating only the masked bits with assign_bit(), or using a cmpxchg
loop, avoid this?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 7dc0ce669d0b7..777e7156badb7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -907,11 +907,11 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
>  
>  	if (info->event == RVU_EVENT_PORT_STATE) {
>  		if (info->evt_data.port_state) {
> -			pf->flags |= OTX2_FLAG_PORT_UP;
> +			otx2_set_flag(pf, OTX2_FLAG_PORT_UP);
>  			netif_carrier_on(netdev);
>  			netif_tx_start_all_queues(netdev);
>  		} else {
> -			pf->flags &= ~OTX2_FLAG_PORT_UP;
> +			otx2_clear_flag(pf, OTX2_FLAG_PORT_UP);
>  			netif_tx_stop_all_queues(netdev);
>  			netif_carrier_off(netdev);
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but can any PF or VF forge
this event for a PF it doesn't own?

On the AF side, rvu_mbox_handler_rep_event_notify() only range-checks the
target:

    if (!is_pf_func_valid(rvu, req->pcifunc))
        return -EINVAL;

It doesn't check that the sender is rvu->rep_pcifunc.
rvu_rep_up_notify() then forwards the event and evt_data to
rvu_get_pf(event->pcifunc). The PF forwards VF mailbox messages to AF
through otx2_forward_vf_mbox_msgs(), so a VF owned by a guest can send
this as well.

On the victim PF, port_state=0 stops TX and drops carrier. port_state=1
sets OTX2_FLAG_PORT_UP, and from then on otx2_handle_link_event() ignores
real CGX link events until the next otx2_open():

    if (otx2_test_flag(pf, OTX2_FLAG_PORT_UP))
        return;

Should AF reject REP_EVENT_NOTIFY from anything other than the
representor PF?

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
This is a pre-existing issue, but where does rvu_rep_mcam_flow_init()
take priv->mbox.lock? The loop allocates and sends NPC_MCAM_ALLOC_ENTRY
messages on priv->mbox without the lock, and the exit path then does:

exit:
    ...
    mutex_unlock(&priv->mbox.lock);

Neither this function nor rvu_rep_setup_tc_cb() calls mutex_lock().

Suppose another context holds the mutex at that point, such as the
rvu_rep_get_stats() worker. Doesn't this release that holder's lock and
let mailbox messages from both contexts interleave? If nobody holds it,
this is an unbalanced unlock, which lockdep would report.

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
This isn't a bug introduced by this patch, but does this leak
rep->flow_cfg and rep->flow_cfg->flow_ent?

rvu_rep_mcam_flow_init() always assigns new kzalloc()/kcalloc() results
to rep->flow_cfg and rep->flow_cfg->flow_ent. It only sets
OTX2_FLAG_TC_FLOWER_SUPPORT when allocated > 0.

So if AF returns no entries, a mailbox call fails, or the flow_ent
allocation fails, the next tc callback calls it again and the previous
allocations are lost. The return value is also ignored here.

Separately, rvu_rep_destroy() only does kfree(rep->flow_cfg), so flow_ent
is never freed on teardown.

>  
>  	priv->netdev = rep->netdev;
> -	priv->flags = rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);

[Severity: Medium]
Does this change how otx2_tc_del_flow() handles representor rules during
teardown?

The old full-word assignment always cleared OTX2_FLAG_INTF_DOWN on priv,
because rep->flags never carried that bit. With the mask, priv keeps its
real INTF_DOWN value.

rvu_rep_destroy() sets INTF_DOWN before unregister_netdev(rep->netdev).
Unregistering sends FLOW_CLS_DESTROY through this callback, and for
police rules otx2_tc_del_flow() then skips the policer and mcast group
cleanup:

    if (otx2_test_flag(nic, OTX2_FLAG_INTF_DOWN))
        goto free_mcam_flow;

otx2_free_hw_resources() skips cn10k_free_all_ipolicers() for
otx2_rep_dev() devices, and AF's nix_lf_free handler doesn't free
bandwidth profiles. Can each switch from switchdev to legacy mode leak
ingress policer leaf profiles?

There is a similar change in rvu_rep_create(). Between register_netdev()
and rvu_rep_napi_init(), otx2_tc_add_flow() now rejects representor
offload with "Interface not initialized". Is that intended?

[ ... ]

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

[Severity: Critical]
This is a pre-existing issue, but what happens here when
rvu_rep_get_repid() doesn't find info->pcifunc? It returns -EINVAL:

    for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++)
        if (priv->rep_pf_map[rep_id] == pcifunc)
            return rep_id;
    return -EINVAL;

In that case priv->reps[-22] is read from memory before the array, and
set_bit() or clear_bit() writes through that pointer. priv->reps can also
be NULL before switchdev mode is enabled. It can also be freed memory,
because rvu_rep_destroy() calls kfree() on it without setting it to NULL.

Can a VF reach this? AF's rvu_mbox_handler_rep_event_notify() only checks
is_pf_func_valid(). rvu_rep_up_notify() forwards the sender's event bits
and only sets the header pcifunc:

    msg->hdr.pcifunc = event->pcifunc;
    msg->event = event->event;

So the body pcifunc arrives as 0. A REP_EVENT_NOTIFY with
event=RVU_EVENT_PFVF_STATE aimed at the representor PF would reach this
handler through
otx2_mbox_up_handler_rep_event_up_notify()->rvu_event_up_notify(), and
the lookup would miss.

Should rep_id be checked here, and should AF validate the sender?

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
This isn't a bug introduced by this patch, but is rep->stats_wrk ever
cancelled? rvu_rep_get_stats64() ends with:

    schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

The only cancel_delayed_work_sync() in rep.c is for priv->refill_wrk.

rvu_rep_destroy() and the rvu_rep_create() error unwind both call
free_netdev(rep->netdev). That frees the rep_dev (netdev_priv) while the
delayed work embedded in it may still be pending. unregister_netdev()
itself sends link notifications that call ndo_get_stats64, so the work is
likely armed during teardown.

Wouldn't rvu_rep_get_stats() then run about 100ms later on freed memory?

    rep = container_of(del_work, struct rep_dev, stats_wrk);
    priv = rep->mdev;

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
This is a pre-existing issue, but the rest of this loop does:

        unregister_netdev(rep->netdev);
        rvu_rep_devlink_port_unregister(rep);
        free_netdev(rep->netdev);
        kfree(rep->flow_cfg);

rep comes from netdev_priv() of a netdev that rvu_rep_create() allocated
with alloc_etherdev(sizeof(*rep)). Isn't rep->flow_cfg read after
free_netdev() has already freed that memory?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109033154.2161803-1-rkannoth%40marvell.com
