Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2764E431D;
	Wed, 16 Sep 2026 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601756; cv=none; b=M1rfCNl1L1z2fc96T7CxPJ4pLlgUy41h446SshaMdS0ssPF3MC6szxtplPdV2qhLoe+JMXZJE48CJORMLf1YRtBZz9cH+K7qY8f3V1V83vxEW4+ugI/0i2V/WV0NTfJWiPUsjq9xvw3XJk9dYWLb+90CMSw4E7myMm19azYCSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601756; c=relaxed/simple;
	bh=+1Y1U2A1X0DLtKFoVOEFN+i8aBNeNqmRvHkkotyM5bo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYYNPxIgkCMyLFjcyYHhtj/AeiCCcinLGQef64rpyWibW36ytoVasxA1CXzDalYC52hQDEtOwuKW2TFt4hb54a7ICkAVDzdHsk7LLql+cWzYq11u1qoM6l7/xHq5TKV1lZ8BpcegPl1UnhVtpLLSuLyJdS4kRdIZuFgpPEGCiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7LfBTkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7LfBTkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BC11F00893;
	Wed, 16 Sep 2026 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601755;
	bh=61S/09OrrYyBQjZx5ziNbSb8zxVSQhl4L+nVYNxvb20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R7LfBTkD7wNs24z0KV6do14KfujSmJmImcoR0I3ghDBJNbABeCNgWL98Gj1kxqdBt
	 MmjDCykoAuLr8Z+oniKlLnH1Z5nE3Z0xbOQiodlpq6Hx7XoUPalVE9loaRN/1FPnj3
	 S1hJj65ZxpS0Ub/4F0ajoTufDepgOlsF0Hgi/vdOzrufCINDgsYX5ROgQ2jLdg3ydi
	 GdbRlch+LcQu2wthmgCQxRbSynwubacfMfr478O96rv8BDPPRq+L4lnq8umU6jims4
	 V+rv1B5rfU+vzAtyDVlR9v3L0IyIjOyG6KZgRNXnqmbizfm1BWj+vrcyP5Uxfv2C+4
	 EVIoOdtnfCb+w==
Subject: Re: [PATCH v3 net 2/7] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, zefir.kurtisi@westermo.com, claudiu.manoil@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, ioana.ciornei@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 16 Sep 2026 23:35:53 +0000
Message-ID: <178960175356.22033.16334133797759581630@kernel.org>
In-Reply-To: <20260915222735.1016937-3-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-3-vladimir.oltean@nxp.com>
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
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

- [High] drivers/net/ethernet/freescale/enetc/enetc.c, enetc_xdp_xmit():
  the new doorbell condition `if (unlikely(k && ((flags &…
- [Low] The commit message of "net: enetc: ensure enetc_xdp_xmit() calls
  enetc_update_tx_ring_tail()" carries a Fixes: 9d2b68cc108d tag (making…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the function
  it modifies contains an unsynchronised shared-TX-ring race.

--

net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()

This changes the condition under which enetc_xdp_xmit() rings the TX
doorbell, since the old "k != xdp_tx_frm_cnt" test could never be true,
and removes the now redundant xdp_tx_frm_cnt variable in favour of the
loop index k.

A couple of questions below.

> The correct condition on which we should ring the doorbell is when at
> least one frame was sent, and either the caller required us to flush, or
> we couldn't enqueue the entire passed array.

[Severity: Low]
The patch carries a Fixes: tag but does not describe any user-visible
symptom of the old code.  Was one observed?

Looking at bq_enqueue() in kernel/bpf/devmap.c, the current frame is always
stored right after the bulk transmit:

	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
		bq_xmit_all(bq, 0);
	...
	bq->q[bq->count++] = xdpf;

so bq->count >= 1 whenever __dev_flush() runs, and bq_xmit_all() does not
take its "if (unlikely(!cnt)) return;" early exit.  The pre-patch code then
rang the doorbell unconditionally on that XDP_XMIT_FLUSH call in the same
NAPI poll, which would make the dead "k != xdp_tx_frm_cnt" condition a
latency issue rather than a lost-frame issue.

Could the commit message say what the practical effect was, so that stable
backporters can judge the risk?

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index e7ecdf8ef67c8..c9c23e994f6d1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c

[ ... ]

> @@ -1845,19 +1844,17 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  						    &xdp_redirect_arr[i]);
>  			break;
>  		}
> -
> -		xdp_tx_frm_cnt++;
>  	}
>  
> -	if (unlikely((flags & XDP_XMIT_FLUSH) || k != xdp_tx_frm_cnt))
> +	if (unlikely(k && ((flags & XDP_XMIT_FLUSH) || k < num_frames)))
>  		enetc_update_tx_ring_tail(tx_ring);

[Severity: High]
Can the new "k &&" term drop a doorbell that the caller explicitly asked
for with XDP_XMIT_FLUSH?

enetc_xdp_tx() only writes the BDs and advances tx_ring->next_to_use.  The
hardware producer index is written only here:

static void enetc_update_tx_ring_tail(struct enetc_bdr *tx_ring)
{
	/* includes wmb() */
	enetc_wr_reg_hot(tx_ring->tpir, tx_ring->next_to_use);
}

Now consider the devmap bulk path in kernel/bpf/devmap.c:

bq_enqueue()
	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
		bq_xmit_all(bq, 0);		/* flags == 0, no doorbell */

__dev_flush()
	bq_xmit_all(bq, XDP_XMIT_FLUSH);	/* the only flush */
	bq->dev_rx = NULL;
	__list_del_clearprev(&bq->flush_node);

The flags == 0 call enqueues all its frames (k == num_frames) and
legitimately defers the doorbell.  If the following XDP_XMIT_FLUSH call
breaks at the very first frame, k == 0 and enetc_update_tx_ring_tail() is
now skipped, so the BDs written by the earlier call are never announced to
hardware.  The bq and its flush-list entry are cleared right afterwards, so
there is no retry.

k == 0 on that flush call looks reachable through any of the loop's early
breaks:

	if (unlikely((shinfo->nr_frags + 1) > ENETC_MAX_SKB_FRAGS))
		break;
	...
	if (unlikely(xdp_tx_bd_cnt < 0))		/* DMA map error */
		break;
	...
	if (unlikely(!enetc_xdp_tx(tx_ring, xdp_redirect_arr,
				   xdp_tx_bd_cnt))) {		/* ring full */

The ring-full variant looks self-perpetuating: the un-announced BDs keep
enetc_bd_unused() low, every later call fails at frame 0, and the doorbell
is skipped again.  enetc_clean_tx_ring() cannot release those xdp_frames or
their DMA mappings because hardware never completes descriptors it was not
told about, and the dedicated per-CPU XDP TX ring is outside
real_num_tx_queues so the TX watchdog does not cover it.  The XDP_TX path
has the same shape:

enetc_clean_rx_ring_xdp()
	if (xdp_tx_frm_cnt)
		enetc_update_tx_ring_tail(tx_ring);

so it does not re-synchronise TPIR either.

Since writing TPIR with an unchanged next_to_use is idempotent, is there
anything gained by the "k &&" term?  Would keeping the flush branch
unconditional be preferable, e.g.

	if (unlikely((flags & XDP_XMIT_FLUSH) || (k && k < num_frames)))

The condition is unchanged at the end of the series (381447d90b1f).

>  
> -	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
> -	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
> +	tx_ring->stats.xdp_tx += k;
> +	tx_ring->stats.xdp_tx_drops += num_frames - k;
>  
>  	enetc_unlock_mdio();

[Severity: High]
This isn't a bug introduced by this patch, but while touching
enetc_xdp_xmit() it may be worth looking at what serialises this ring
against the stack TX path.

enetc_xdp_xmit() picks the ring per-CPU and holds no TX queue lock:

	tx_ring = priv->xdp_tx_ring[smp_processor_id()];

The only lock taken is enetc_lock_mdio(), which in enetc_hw.h is

	if (static_branch_unlikely(&enetc_has_err050089))
		read_lock(&enetc_mdio_lock);

i.e. a reader lock for an unrelated MDIO erratum, so it gives no mutual
exclusion between two producers.

The XDP rings are a slice of the same array the stack uses:

enetc_alloc_msix()
	first_xdp_tx_ring = priv->num_tx_rings - num_possible_cpus();
	priv->xdp_tx_ring = &priv->tx_ring[first_xdp_tx_ring];

and they are only hidden from the stack when a program is attached:

enetc_num_stack_tx_queues()
	if (priv->xdp_prog)
		return num_tx_rings - num_possible_cpus();

	return num_tx_rings;

enetc_pf_netdev_setup() advertises NETDEV_XDP_ACT_NDO_XMIT unconditionally,
and devmap only tests that flag, so ndo_xdp_xmit() can be called into this
device with priv->xdp_prog == NULL.  In that case every ring, including the
xdp_tx_ring range, is also reachable from

enetc_start_xmit()
	tx_ring = priv->tx_ring[skb->queue_mapping];

under only that queue's __netif_tx_lock.  Can the two producers then race on
the same next_to_use and tx_swbd slot, overwriting bookkeeping (leaking the
previous skb and its DMA mapping) and leaving enetc_clean_tx_ring() freeing
entries that do not match what hardware consumed?

The overlap looks unavoidable when num_tx_rings == num_possible_cpus():
first_xdp_tx_ring becomes 0, and enetc_setup_xdp_prog()'s check

	if (priv->min_num_stack_tx_queues + num_xdp_tx_queues >
	    priv->num_tx_rings) {

prevents attaching a program at all, yet ndo_xdp_xmit() still targets rings
0..nr_cpus-1, which are pure stack queues.

i40e and ice return -ENXIO from ndo_xdp_xmit when XDP TX rings are not
reserved.  Would a similar check fit here?

>  
> -	return xdp_tx_frm_cnt;
> +	return k;
>  }
>  EXPORT_SYMBOL_GPL(enetc_xdp_xmit);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915222735.1016937-1-vladimir.oltean%40nxp.com
