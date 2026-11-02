Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619701;
	b=nHapjpNFovuxvoE6v0OnMW6L2HG+yOC5zAVdNERwkRVkirV3q1yHhsK91/c/bN+kb+pi
	 XftnbMlJ75q/e4JgBT8HY6k6mvS8rAuCeO7B5AcdykH82k3O5xbNKckobs6on+IjR+yLu
	 qpDctR779XNmfxygv24uXKRPL0UYUhaoGE2D3X7GmXjvIZ5F2v04SS5oV/ey4WlglfZ0R
	 fV5PgCcAeh8XPvLjNBCxtp7KmKiHAjTaN5RB4UVclf3cFbpKkBW/SGxF+yED/ulm+Gfz2
	 hoYhavV9WmQQskce9OnbhDNPp68oRDapQNnggNOWLJ6TmzyKMsUDZlYTwpQw4SW9N2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D7JmBEmGxLSymZEgdcnCU2t6UAxvf8KOZhQUE4OtCSk=;
	b=u7lKxjABSe2bszkzvGupZN8nO8k3PO1IP3kdDlYgeCJ4h1OEBUUbGjGRGeRkAcNYGeRC
	 5Ja6/ZWYbeI4a1W30DDchBiRA4TehFB1ssYaxFRTlUG0E+5TJnTM2gQeFkSQ7+HzwZ3ho
	 fSEumGJUuabe2+Z9I5zlPaH76igomLPT7hcvIDb/vtoZ/lS/3FwlKg3G1kkiFK3LvaQIk
	 jdd9colG0fOnEY2XJ+tcdU9nLQyhb5AB0AXA4aJSU5cnmuUHtmktlKIKjE7u85O18KCFH
	 ExjRqr1Pts3JsD/3YooRBBZNnTnfAIGOaTXhMmQMlRJrd3q2W3/H+iCX1UHw/LwyV2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xtt5IeDR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF30606A32C;
	Mon,  2 Nov 2026 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xtt5IeDR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102AB1F00A17;
	Mon,  2 Nov 2026 11:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619701;
	bh=D7JmBEmGxLSymZEgdcnCU2t6UAxvf8KOZhQUE4OtCSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xtt5IeDR89+p0IFG3i/oji1M7Ob6cWmPDAL2Bqsm52BigcI4+W4gfzBSBhkvWa3Ll
	 bp9Qi5GCpO7jnE8RomT7sZbhYkAZpnUdGGsUU8e5ap9rb7v3vYvzjb86vXpZAEehS3
	 YstXcs5mQmqtQZx1iGVq0adDtIP0/ySLSRk+oiZq/VkdN8FL0ZZCQsREEtAZAAVlqy
	 ks7nWXXmH0TtZJ2jJwXlIJk8dqjLfV6zY05pO1Om4obASa68/LM4Cjs2Jf8rsiqtVI
	 N0YJ8TR8j3B6e2Rq8iKed6uPT7RblHrU+A9yyCIu3bGYlk2kqYCpksuntO3bJHMhyk
	 1RKitP+UOGEtg==
Date: Mon, 2 Nov 2026 11:41:35 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev-bot+sashiko@kernel.org, horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net] net: lan966x: don't free XDP buffers in fdma tx
 clear with budget 0
Message-ID: <20261102114135.GZ257209@horms.kernel.org>
References: <20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c@microchip.com>
 <179339596952.3131.4206946876532380801@kernel.org>
 <20261102085339.ixdqujaly75yldp7@DEN-DL-M70577.microsemi.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102085339.ixdqujaly75yldp7@DEN-DL-M70577.microsemi.net>

On Mon, Nov 02, 2026 at 09:53:39AM +0100, Daniel Machon wrote:

...

> > net: lan966x: don't free XDP buffers in fdma tx clear with budget 0
> > 
> > This patch makes lan966x_fdma_tx_clear_buf() skip completed XDP_TX and
> > ndo_xdp_xmit DCBs when netpoll calls it with a budget of 0. That way the
> > page pool and XDP return APIs are not called with hardirqs disabled. The
> > skipped buffers are left for the next NAPI poll, and skbs are still freed
> > via napi_consume_skb().
> > 
> > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > index 21668bbcc9063..1fbe910c5ec38 100644
> > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > @@ -353,6 +353,12 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
> > >               if (!fdma_db_is_done(db))
> > >                       continue;
> > >
> > > +             /* XDP and page pool APIs can't be used with a budget of 0.
> > > +              * Leave these buffers for the next NAPI poll.
> > > +              */
> > > +             if (!weight && !dcb_buf->use_skb)
> > > +                     continue;
> > 
> > [Severity: Medium]
> > Can this starve netconsole transmits on the port that owns the FDMA NAPI?
> > 
> > skbs and XDP frames get slots from the same ring through
> > lan966x_fdma_get_next_dcb(), which only checks the used bit:
> > 
> > lan966x_fdma_get_next_dcb() {
> >         ...
> >                 if (!dcb_buf->used &&
> >                     !fdma_is_last(&tx->fdma, &tx->fdma.dcbs[i]))
> >                         return i;
> >         ...
> > }
> > 
> > If heavy XDP_TX or ndo_xdp_xmit traffic fills every usable slot, a
> > netpoll skb ends up here in lan966x_fdma_xmit():
> > 
> >         next_to_use = lan966x_fdma_get_next_dcb(tx);
> >         if (next_to_use < 0) {
> >                 netif_stop_queue(dev);
> >                 return NETDEV_TX_BUSY;
> >         }
> > 
> > __netpoll_send_skb() then polls between retries:
> > 
> > netpoll_poll_dev()->poll_one_napi()->napi->poll(napi, 0)
> >   ->lan966x_fdma_tx_clear_buf(lan966x, 0)
> > 
> > With the new check, every completed XDP DCB is skipped. No slot is freed,
> > clear stays false, and lan966x_fdma_wakeup_netdev() is never called.
> > 
> > Once the retries run out, the skb is put on npinfo->txq and handed to
> > delayed work, and later messages queue behind it. In normal operation a
> > later IRQ-driven NAPI poll frees the DCBs and output only comes late.
> > 
> > During a panic, with the other CPUs stopped and hardirqs off, would that
> > work ever run? If not, the netconsole output is lost.
> > 
> > Before this patch, the budget-0 poll freed those slots, so netpoll could
> > make progress.
> 
> Seems right, however, AFAICT, this is only an issue if the panic hits while the
> ring is completely full of finished XDP frames. Freeing those frames from
> netpoll is what napi.rst forbids: with a budget of 0 the driver cannot call any
> XDP or page pool APIs, and doing so is the splat this patch fixes.
> 
> The only other way I see is to give XDP its own FDMA injection channel, so XDP
> frames can never take the slots netpoll needs. lan966x has free injection
> channels for that, but it is a rework for net-next, not a fix for net.

Yes, agreed.

Reviewed-by: Simon Horman <horms@kernel.org>

