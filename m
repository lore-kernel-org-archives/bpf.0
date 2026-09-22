Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3A5452AD;
	Tue, 22 Sep 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082049; cv=none; b=hvKeULvMCGLrIeU1LF/jQu73tYxK/tJ2F3an/wYF7JBD5v+AIRT4YitrXbejRHw/ldRYkMo1k2+qtYorJshUN1y4nEg0lzn6hzPQk+rMMcI6mvxgfv7mui2DdnNb5256eQ3KgRcCwH05+HAn5m0uc5ARtq7wNw0xqIBMjZ3pVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082049; c=relaxed/simple;
	bh=lvWx9Oof7Vlfl5hjylKlm2KWrsX4bz7OL20/2WOp8U4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jH+3aQt4jl7gXDR85AuG360ot79lb5pBKtOrRgrfekxxJK6TwfYi05G4I7JjmCRap09ms/vvragG/O1Z73u9EpRikzKUkofaU9Hm3B+zs1DXYhDzVuxzNt4Xf/N+m9ES2lCHQ35mZtBl5lPjEhRBQfhEomN6so4NKrKZE/OSmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRPTBL+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRPTBL+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8788A1F00893;
	Tue, 22 Sep 2026 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082047;
	bh=V4FQJyTtich7Xd0fPE4aggJwTMoPHLYytpxN+tlo12A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dRPTBL+8EYOK//gXkK2UDLjNaV7QqJt34T3qv58Y6qaC1fq6DcKOwZDrO4fg695qf
	 Gr8iGkoeu+TZVtROxsUmICGLD22kxZdmN1t0AewU7odp3M2r+tvigK+YdNOPn/sj+J
	 zZqsDEG4E6Ag/Z3kxCFOksR6/3VCTwD1ZmkDkdnaBIzOLF4Xp6Thy/LGGXSvidPs8x
	 UfWHhImJKn7MUILEn6WrS4QE9ZkaeYajxJFxRG/RXbgbjkndkVl+SKOVoRpvoNCCPD
	 pAqftyxna2E3c1kposXZWl57r6Ipl88tVudKrMRI3CLjgbNczj2yt3aONuaX+uP9QO
	 EpSE4VIAxd0fA==
Subject: Re: [PATCH net-next v7 04/14] net: lan966x: add FDMA LLP register
 write helper
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 22 Sep 2026 13:00:46 +0000
Message-ID: <179008204609.2160803.35249597205544955@kernel.org>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-4-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-4-0ecc179c8a2c@microchip.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] By moving the FDMA_DCB_LLP/LLP1 writes out of
  lan966x_fdma_tx_activate() into lan966x_fdma_tx_alloc()…
- [Low] The patch deletes the comment 'When activating a channel, first
  is required to write the first DCB address and then to activate it'…

Pre-existing issues:
- [High] lan966x_fdma_rx_alloc() (lan966x_fdma.c:135) and
  lan966x_fdma_tx_alloc() (line 217) discard the return value of…

--

net: lan966x: add FDMA LLP register write helper

This moves the FDMA_DCB_LLP/LLP1 register writes out of
lan966x_fdma_rx_start() and lan966x_fdma_tx_activate() into the RX/TX
allocation functions, adding a shared lan966x_fdma_llp_configure() helper
plus one extra call in the lan966x_fdma_reload() restore path.  The stated
motivation is that the upcoming PCIe FDMA path programs ATU-translated
addresses into these registers.

A few questions below.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 41d4ec7f2f57..b8344fd5e5ad 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -109,6 +109,13 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
>  	return 0;
>  }
>  
> +static void lan966x_fdma_llp_configure(struct lan966x *lan966x, u64 addr,
> +				       u8 channel_id)
> +{
> +	lan_wr(lower_32_bits(addr), lan966x, FDMA_DCB_LLP(channel_id));
> +	lan_wr(upper_32_bits(addr), lan966x, FDMA_DCB_LLP1(channel_id));
> +}
> +
>  static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
>  {
>  	struct lan966x *lan966x = rx->lan966x;
> @@ -128,6 +135,8 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
>  	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
>  		       FDMA_DCB_STATUS_INTR);
>  
> +	lan966x_fdma_llp_configure(lan966x, fdma->dma, fdma->channel_id);
> +
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since the new LLP write now
sits right after it: should lan966x_fdma_rx_alloc() check the return value
of fdma_dcbs_init() before arming the channel?

fdma_dcbs_init() is fallible and stops at the first failing descriptor:

drivers/net/ethernet/microchip/fdma/fdma_api.c:fdma_dcbs_init() {
	for (i = 0; i < fdma->n_dcbs; i++) {
		err = fdma_dcb_add(fdma, i, info, status);
		if (err)
			return err;
	}
}

and lan966x_fdma_rx_dataptr_cb() returns -ENOMEM when
page_pool_dev_alloc_pages() fails, without updating rx->page[dcb][db] or
*dataptr.  So under memory pressure the chain is left truncated, the
remaining DB dataptrs stay 0, and rx->page[] keeps its previous contents
while this function still returns 0 and now also programs the LLP.

In lan966x_fdma_reload() the success branch then runs, which releases every
page in old_pages to the old pool and calls page_pool_destroy(page_pool)
while rx->page[] still references those pages.  A later
lan966x_fdma_rx_free_pages() at deinit, or on the next MTU change, would
then call page_pool_put_full_page() on pages already returned to a
destroyed pool.  In the probe path the same suppressed failure leaves NULL
entries in rx->page[] that lan966x_fdma_rx_free_pages() dereferences
unconditionally.

RX would also stall, since the software dcb_index wraps modulo n_dcbs while
the hardware only walks the truncated part of the ring.

Interestingly the PCIe variant added later in this series does check the
same call, so would it make sense to propagate the error here as well?

> @@ -137,14 +146,6 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
>  	struct fdma *fdma = &rx->fdma;
>  	u32 mask;
>  
> -	/* When activating a channel, first is required to write the first DCB
> -	 * address and then to activate it
> -	 */
> -	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP(fdma->channel_id));
> -	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP1(fdma->channel_id));
> -
>  	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
>  	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
>  	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |

[Severity: Low]
This isn't a bug, but the comment documenting the hardware ordering rule
("first is required to write the first DCB address and then to activate
it") is removed from both lan966x_fdma_rx_start() and
lan966x_fdma_tx_activate(), and is not restated at
lan966x_fdma_llp_configure() or at either FDMA_CH_ACTIVATE site.

The requirement becomes an implicit contract between the allocation and
activation functions, which is what forces the extra open-coded call in the
lan966x_fdma_reload() restore path below.  Could the rule be documented at
the helper, or near the FDMA_CH_ACTIVATE writes?

All activation paths in the current tree do have a matching LLP write
before them, so this is only about the lost documentation.

Also, the commit message says the writes are moved "into the allocation
functions", but a third call site is added in lan966x_fdma_reload(), which
is not an allocation function.  Could that be mentioned as well?

> @@ -215,6 +216,8 @@ static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
>  
>  	fdma_dcbs_init(fdma, 0, 0);
>  
> +	lan966x_fdma_llp_configure(lan966x, fdma->dma, fdma->channel_id);
> +
>  	return 0;
>  
>  out:

[Severity: High]
This is the same pre-existing unchecked fdma_dcbs_init() described above,
on the TX side; it is not introduced by this patch, but the new LLP write
and the unconditional "return 0" now follow it directly.

> @@ -236,14 +239,6 @@ static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
>  	struct fdma *fdma = &tx->fdma;
>  	u32 mask;
>  
> -	/* When activating a channel, first is required to write the first DCB
> -	 * address and then to activate it
> -	 */
> -	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP(fdma->channel_id));
> -	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP1(fdma->channel_id));
> -
>  	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
>  	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
>  	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |

[Severity: Medium]
Can the injection channel now be activated before the LLP has been
programmed during probe?

lan966x_probe() sets lan966x->fdma = true before the port loop that calls
lan966x_probe_port() -> register_netdev(), and only calls
lan966x_fdma_init() afterwards.  lan966x_port_xmit() dispatches purely on
that flag:

drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_port_xmit() {
	spin_lock(&lan966x->tx_lock);
	if (port->lan966x->fdma)
		err = lan966x_fdma_xmit(skb, ifh, dev);
	...
}

lan966x_fdma_init() sets tx.fdma.n_dcbs/n_dbs and the ops before calling
lan966x_fdma_tx_alloc(), and lan966x_fdma_tx_alloc() does not take
tx_lock.  So an xmit landing between fdma_dcbs_init() and the new
lan966x_fdma_llp_configure() would find a valid dcbs_buf and DCB ring and
go:

lan966x_fdma_xmit() -> lan966x_fdma_tx_start() -> lan966x_fdma_tx_activate()

which after this patch writes FDMA_CH_ACTIVATE without programming the
LLP, so the engine would fetch its first DCB from the post-reset LLP value
of 0.  tx->activated is latched true there, so the LLP would never be
programmed for that channel afterwards:

	if (likely(lan966x->tx.activated)) {
		lan966x_fdma_tx_reload(tx);
	} else {
		/* Because it is first time, then just activate */
		lan966x->tx.activated = true;
		lan966x_fdma_tx_activate(tx);
	}

Before this patch tx_activate() wrote the LLP immediately before the
activate bit, so this ordering was not possible.  Note the same probe
window already exposes a pre-existing tx->dcbs_buf == NULL dereference in
lan966x_fdma_get_next_dcb() while n_dcbs is already set, so would
registering the netdevs after lan966x_fdma_init() be the better fix?

> @@ -876,6 +871,9 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>  					   MEM_TYPE_PAGE_POOL, page_pool);
>  	}
>  
> +	lan966x_fdma_llp_configure(lan966x, lan966x->rx.fdma.dma,
> +				   lan966x->rx.fdma.channel_id);
> +
>  	lan966x_fdma_rx_start(&lan966x->rx);
>  
>  	lan966x_fdma_wakeup_netdev(lan966x);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
