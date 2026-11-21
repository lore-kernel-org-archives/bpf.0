Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795247373;
	b=0Dq3MoyX5p1bGTrUTQDEaI7cjjrl1+jvioX+Q7Jz/iKjxfZJ+oKf4Zhfoip5vzZXGYRX
	 7n+A+rtUGFjYgOUqiPTE9L6uMoFPtcM1WIq2jekaxAWhji7/Rl5/cuukLQNXXAAUc570X
	 Sj3gH6ZRMgZeoyI4RPhGQkVrR2kVUz70gPhsMwxSFNvRas7VflO0x3CfgvjAvTLJxUO8E
	 mjvbjz4KssZ1xqr+rqCLrw2g4eUrSe/+CjaNPeJh1cul0Mjzv3biA1l+YDzA44s0ehxnI
	 zLRqcAV4eeEYtcBaFxGJvO/nmmwJHtTgxs60zcR2Ju7vtZ8prvrF735GKZAFqDxayxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795247373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vFgGw10nYgLi3aoWNLz3n3pkCqk3EH1b7Mf09Unos8Y=;
	b=JX6Qe6VZyowCzXiGNMSQIrw0i0YDHhLLtGzqRmEnqlcMdr7C7JH4E7RSk4llM70BrEOq
	 yKpRAniDIv9GwSbckE2NusAT9fqNOT4NLFM8ELGZZSpw4OTb8IYeY+I4p14xHCNnqIU9Q
	 lrC/mLxlIHB6IwXhb3q/2CkdqvQy4QfhVQErIBGHD6p6pHYbFxuaNdayecLL29SqhwSIM
	 sCr8zWOzW8fEz7PmxfXT/ypgascn2WJDsSZDoXuscT+uCBIoAysK4RAKLMi9EHC8PgY2n
	 4irnBuWQ+4t8k9s6hXnvEtQQMqWpYBjyv7Mp5JIbOsmzhYSzx80p1qQ0QwZD5bNGEnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="orCn5/in";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4D606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orCn5/in
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70011F000C0;
	Sat, 21 Nov 2026 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795247373;
	bh=vFgGw10nYgLi3aoWNLz3n3pkCqk3EH1b7Mf09Unos8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=orCn5/in4bqTyHMbcA/V+9BfW3crLJv+NJuVoEfXLQNoPON0mm/KGwsyHBE+g1crq
	 VG2FkFJ0rxGammyFnFooq9nWBSzNov3i2nVdABZ4JdfacboVHPMOCul1VUCWjGfqWu
	 K5tN8j/pPjMGp/kjmY8kPQDkqdg7kbIp6zzvETN3JdvWy59XFtwiKarb+qXF7uIaJi
	 AtWxvlV1yVmYdm3P6xck8+ETrU8brA5mxaKGUd95iynSXHtM69zvK6dCP36gEg+YAd
	 2M2Iu9fxcx706PK8b/qx/C/aFHwIANPOkPk9YZSXF+j8LM1N3d5ssyv7/WTTM+r9RG
	 V18EaMW4SI9lw==
Message-ID: <sashiko-outbox-226803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anandu Padinhare" <Anandu.Padinhare@electrifex.com>
Cc: =?utf-8?b?YnBmQHZnZXIua2VybmVsLm9yZw==?= <bpf@vger.kernel.org>
In-Reply-To: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:49:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: stmmac: stmmac_rx() runs receive loop before
  stmmac_rx_refill() on retry
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [Critical] net: stmmac: XDP buffer race window in
  stmmac_disable_all_queues() [1]
- [High] net: stmmac: missing datapath and PM runtime checks in
  stmmac_setup_tc() [2]
--

commit 23d224e20637c2030c16317bc5eb885c790893b3
Author: Anandu Padinhare <Anandu.Padinhare@electrifex.com>

net: stmmac: retry a failed RX refill from a timer

This commit adds a per-channel timer that schedules RX NAPI when fewer than
16 RX descriptor slots remain with the DMA, so failed page_pool allocations
in stmmac_rx_refill() are retried without relying on new RX interrupts.

Link: https://lore.kernel.org/netdev/20260331195927.3353cc6d@kernel.org/
Link: https://lore.kernel.org/netdev/20260402174049.0ac088cc@kernel.org/

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index a685ce4638f61..ad9873aaf2dba 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -284,6 +312,10 @@ static void __stmmac_disable_all_queues(struct stmma=
c_priv *priv)
>  		if (queue < tx_queues_cnt)
>  			napi_disable(&ch->tx_napi);
>  	}
> +
> +	/* With NAPI disabled no poll can re-arm the refill timers */
> +	for (queue =3D 0; queue < rx_queues_cnt; queue++)
> +		timer_delete_sync(&priv->channel[queue].rx_refill_timer);
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but in
stmmac_disable_all_queues() [1], doesn't calling synchronize_rcu()
before __stmmac_disable_all_queues() leave a window where NAPI is still
enabled and can queue new AF_XDP zero-copy buffers after the RCU grace
period finishes?

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_disable_all_queues=
() {
	/* synchronize_rcu() needed for pending XDP buffers to drain */
	for (queue =3D 0; queue < rx_queues_cnt; queue++) {
		rx_q =3D &priv->dma_conf.rx_queue[queue];
		if (rx_q->xsk_pool) {
			synchronize_rcu();
			break;
		}
	}

	__stmmac_disable_all_queues(priv);
}

Because NAPI and the refill timers are only stopped inside
__stmmac_disable_all_queues(), polls running during or after
synchronize_rcu() can continue processing XDP buffers right before the XSK
pool and DMA resources are torn down, leading to a use-after-free.

> @@ -328,8 +360,17 @@ static void stmmac_enable_all_queues(struct stmmac_p=
riv *priv)
>  			continue;
>  		}
> =20
> -		if (queue < rx_queues_cnt)
> +		if (queue < rx_queues_cnt) {
> +			/* Disabling the queues cancelled any pending refill
> +			 * retry, but the ring may have been kept as it was.
> +			 * Check it while no poll can run.
> +			 */
> +			bool refill =3D stmmac_rx_refill_needed(priv, queue);
> +
>  			napi_enable(&ch->rx_napi);
> +			if (refill)
> +				stmmac_rx_refill_timer_arm(ch);
> +		}
>  		if (queue < tx_queues_cnt)
>  			napi_enable(&ch->tx_napi);
>  	}

[Severity: High]
This problem wasn't introduced by this patch, but what happens when
stmmac_setup_tc_block_cb() [2] calls __stmmac_disable_all_queues()
and stmmac_enable_all_queues() while the interface is administratively
down?

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_setup_tc_block_cb(=
) {
	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
		return ret;

	__stmmac_disable_all_queues(priv);
	...
	stmmac_enable_all_queues(priv);
}

When the interface is down, NAPI is already disabled and the device is
runtime-suspended, so configuring a TC flower or u32 filter calls
napi_disable() a second time in __stmmac_disable_all_queues() (deadlocking
on NAPI state) and accesses clock-gated MAC registers without waking the
device via pm_runtime_resume_and_get().

> @@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_struct *=
napi, int budget)
>  	u64_stats_update_end(&rxq_stats->napi_syncp);
> =20
>  	work_done =3D stmmac_rx(priv, budget, chan);
> +	if (unlikely(stmmac_rx_refill_needed(priv, chan)))
> +		stmmac_rx_refill_timer_arm(ch);
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
>  		unsigned long flags;

[Severity: Medium]
When the RX ring is completely depleted (CIRC_SPACE is 0) and the DMA has
already written a frame into the final descriptor at rx_q->cur_rx, can
stmmac_rx() leave that frame stranded once the timer poll finally succeeds
in refilling the ring?

In stmmac_rx(), the receive loop runs before stmmac_rx_refill():

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx() {
	while (count < limit) {
		...
		status =3D stmmac_rx_status(priv, &priv->xstats, p);
		/* check if managed by the DMA otherwise go ahead */
		if (unlikely(status & dma_own))
			break;

		next_entry =3D STMMAC_NEXT_ENTRY(rx_q->cur_rx,
					       priv->dma_conf.dma_rx_size);
		if (unlikely(next_entry =3D=3D rx_q->dirty_rx))
			break;
		...
	}
	...
	stmmac_rx_refill(priv, queue);
}

Commit 0bb05e6adfa9 ("net: stmmac: Prevent NULL deref when RX memory
exhausted") defers consuming the last descriptor at rx_q->cur_rx when
next_entry =3D=3D rx_q->dirty_rx until stmmac_rx_refill() advances
rx_q->dirty_rx.  Because the timer-scheduled poll enters the receive loop
before calling stmmac_rx_refill(), two things happen:

1. While allocations keep failing, every 10 ms retry poll runs
   stmmac_rx_status() on the same unconsumed descriptor at rx_q->cur_rx
   before breaking on next_entry =3D=3D rx_q->dirty_rx, repeatedly incremen=
ting
   priv->xstats counters for that frame.
2. Once memory is available again, the receive loop still sees
   next_entry =3D=3D rx_q->dirty_rx and breaks out with work_done =3D=3D 0,=
 after
   which stmmac_rx_refill() refills the ring and advances rx_q->dirty_rx.
   stmmac_napi_poll_rx() then sees stmmac_rx_refill_needed() =3D=3D false a=
nd
   completes NAPI via napi_complete_done(), leaving the already-received
   frame at rx_q->cur_rx unprocessed until another packet arrives on that
   queue.

Calling stmmac_rx_refill() at the start of stmmac_rx() when
stmmac_rx_refill_needed() is true (or checking next_entry =3D=3D rx_q->dirt=
y_rx
before stmmac_rx_status()) would allow the recovery poll to consume the
deferred descriptor and avoid double-counting its status.

[1] https://sashiko.dev/#/bug/linux-644f1987-e595-49b8-bf50-2de2c07a3eaf
[2] https://sashiko.dev/#/bug/linux-3ead95d4-661e-4a8f-a68a-8b257e32b68c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/MA0PR01MB921746F36D=
90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM?part=3D1
