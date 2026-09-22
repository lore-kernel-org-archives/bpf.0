Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAA54CF52;
	Tue, 22 Sep 2026 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082057; cv=none; b=GceaZ8NQGGCttZmZKPZdgVDqos8HbhdixOXc8BekLdNrJmfsNAr6ekM0iAwTn3fzNn0oV6lDGAIZ1TUn0kdmsxdSdyOT8uO9GAML5SCsAbEwMuaaPLa6dC/E53T5B9c+p23z6y6if49CY4m33JxA4+QKH2HNf00Z3k+SguQiJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082057; c=relaxed/simple;
	bh=ng7PK7fJmtnium6xebCjlUlKV4lU9oMBz31QtSDQEBI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOLGNWHFZxl6gIfQmgJ43znlY5VG3nmB3qIRU3lNxQQLya7WzCqJOd9qWZ8Dim8dXxiz0ukCub00wt2x+o1xZZm49uGKfUSMghbGK26DDjq6tWN3OnV7oANN1tST5wdtalwF5KBrR3f0wMHoPdy6hV3NXEhG1IxXIpFKjtnk//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO1cAdwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO1cAdwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F441F00893;
	Tue, 22 Sep 2026 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082055;
	bh=aW9kPE5tNdN0+P2Y8RhxTlP8EaQK1CN1U/osGDQll8s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mO1cAdwCJpBOXpg6rZC7X/HHmJc7ax8Ox9TaHsk32m3k7THUzWis32iV3utmlaPoH
	 3tVxUsMo8PV8y00FUy2uE54qInmrkIyMFa4iaYHuVNGEOvso90mW5Rq+KcO/s6/0It
	 1EBvgkgT5ImjZGFZy9SYjuj/ty3JKdrU7mXzmEasm/TBH9UVRCpDyz9xEsKMa4op4b
	 vbX1rdQwhA1fSWoqWiWi+AHlW2+TU9PpMIWn4XxjmyMJSwyjvhnhW82YQye5O8rWTP
	 X51sff0jrSLq5bbPomvJec8yGGzCcxTWimiHqJaJdJidBuPdN+xz2I0d42rRA8C1rB
	 lxdm6UNokkK2A==
Subject:
 Re: [PATCH net-next v7 11/14] net: lan966x: add PCIe FDMA MTU change support
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
Date: Tue, 22 Sep 2026 13:00:53 +0000
Message-ID: <179008205354.2160803.17637640817184992984@kernel.org>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-11-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-11-0ecc179c8a2c@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] MTU change during or after PCIe FDMA teardown runs the full
  reload on freed/quiesced state: unbounded napi_disable() while holding…
- [High] The new resize readiness check publishes lan966x->rx.lan966x
  before the PCI FDMA rings exist, so an MTU change can race with ring…
- [Medium] The new PCIe resize path retires DMA rings and tears down
  their ATU outbound window without ever confirming the hardware is…
- [Low] FDMA_PCI_DB_SIZE_MAX / FDMA_PCI_MAX_MTU perform unsigned
  arithmetic with no underflow guard and no BUILD_BUG_ON, even though…

Pre-existing issues:
- [High] The hazard the new PCIe reload path documents and avoids is
  still live in the sibling platform reload path, which this series…
- [High] The two implementers of lan966x_fdma_ops::fdma_resize now
  disagree about the 'rings not built yet' precondition, and the…
- [Medium] Window in which DEV_MAC_MAXLEN_CFG exceeds the DCB buffer
  size, combined with a missing SOF/EOF check in…

--

net: lan966x: add PCIe FDMA MTU change support

This adds MTU change support to the PCIe FDMA path by reallocating the
contiguous ATU-mapped RX and TX rings at the new size and falling back to
the old buffers on failure.  It also caps the PCIe DCB ring at 256 entries
and advertises a derived dev->max_mtu (FDMA_PCI_MAX_MTU) when the FDMA is
in use.

A few questions below about the new reload path and the new size macros.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 5d6902459f20..940425beec2f 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> @@ -358,7 +358,7 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
>  	lan966x->rx.lan966x = lan966x;
>  	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
>  	rx_fdma->channel_id = FDMA_XTR_CHANNEL;
> -	rx_fdma->n_dcbs = FDMA_DCB_MAX;
> +	rx_fdma->n_dcbs = FDMA_PCI_DCB_MAX;
>  	rx_fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
>  	rx_fdma->priv = lan966x;
>  	rx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);

[Severity: High]
Can an MTU change race with ring construction here?  lan966x_fdma_pci_init()
sets rx.lan966x before it fills in channel_id/n_dcbs/n_dbs/db_size/size and
before the two sleeping allocations in lan966x_fdma_pci_rx_alloc() and
lan966x_fdma_pci_tx_alloc().

The netdevs are already live at that point: lan966x_probe() runs the whole
port loop, including lan966x_probe_port()->register_netdev() and
lan966x_port_init()->lan966x_fdma_netdev_init()->netif_napi_add()+
napi_enable(), and only calls ops->fdma_init() afterwards, without holding
RTNL.

So an rtnl-held ndo_change_mtu in that window sees rx.lan966x != NULL, passes
the new guard in lan966x_fdma_pci_resize(), finds a max_mtu that differs from
the partially initialised rx.max_mtu, and enters __lan966x_fdma_pci_reload().
Both contexts then write the same lan966x->rx.fdma / lan966x->tx.fdma:

  lan966x_fdma_pci_reload()
      lan966x_fdma_rx_disable(&lan966x->rx)   /* channel_id still 0 */
      lan966x->rx.fdma.atu_region = NULL;     /* under probe's feet */
      lan966x_fdma_pci_rx_alloc(&lan966x->rx) /* second ring */

Does this leak probe's ring plus its ATU region (only
FDMA_PCI_ATU_REGION_MAX == 6 exist), or trip WARN_ON(fdma->atu_region) /
-ENOSPC in fdma_pci_atu_region_map()?  And on the failure branch,
lan966x_fdma_pci_reset_mem() dereferences tx->fdma.atu_region->base_addr,
which is NULL in a snapshot taken before probe allocated it.

[ ... ]

> @@ -391,9 +391,156 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
>  	return 0;
>  }
>  
> +/* Reset existing rx and tx buffers. */
> +static void lan966x_fdma_pci_reset_mem(struct lan966x *lan966x)
> +{
> +	struct lan966x_rx *rx = &lan966x->rx;
> +	struct lan966x_tx *tx = &lan966x->tx;
> +
> +	memset(rx->fdma.dcbs, 0, rx->fdma.size);
> +	memset(tx->fdma.dcbs, 0, tx->fdma.size);
> +
> +	fdma_dcbs_init(&rx->fdma,
> +		       FDMA_DCB_INFO_DATAL(rx->fdma.db_size - XDP_PACKET_HEADROOM),
> +		       FDMA_DCB_STATUS_INTR);
> +
> +	fdma_dcbs_init(&tx->fdma,
> +		       FDMA_DCB_INFO_DATAL(tx->fdma.db_size),
> +		       FDMA_DCB_STATUS_DONE);
> +
> +	lan966x_fdma_llp_configure(lan966x,
> +				   tx->fdma.atu_region->base_addr,
> +				   tx->fdma.channel_id);
> +	lan966x_fdma_llp_configure(lan966x,
> +				   rx->fdma.atu_region->base_addr,
> +				   rx->fdma.channel_id);
> +}
> +

[ ... ]

> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
> +	struct fdma tx_fdma_old = lan966x->tx.fdma;
> +	struct fdma rx_fdma_old = lan966x->rx.fdma;
> +	u32 old_mtu = lan966x->rx.max_mtu;
> +	int err;
> +
> +	napi_disable(&lan966x->napi);
> +	lan966x_fdma_tx_disable_netdev(lan966x);
> +	lan966x_fdma_rx_disable(&lan966x->rx);
> +	lan966x_fdma_tx_disable(&lan966x->tx);

[Severity: High]
What happens if an MTU change lands after the PCIe FDMA has already been torn
down?  lan966x_fdma_pci_deinit() disables NAPI and frees both coherent rings,
but it leaves lan966x->rx.lan966x set, lan966x->fdma true and fdma->dcbs
dangling.  It also runs before the netdevs are unregistered and without RTNL:

  lan966x_remove()
      lan966x->ops->fdma_deinit(lan966x);
      lan966x_cleanup_ports(lan966x);   /* unregister_netdev() here */

The new guard in lan966x_fdma_pci_resize() only rejects "rings not built
yet", so an ndo_change_mtu in that window passes it and reaches this
function.  Three things then follow in order:

napi_disable(&lan966x->napi) on an already-disabled NAPI.  Does
napi_disable_locked() spin forever in

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC))
		usleep_range(20, 200);

since nothing clears those bits until napi_enable()?  That task holds RTNL,
so unregister_netdev() in lan966x_remove() can never complete.

If that is somehow passed, the success path below calls
fdma_free_coherent_and_unmap() on the stale rx_fdma_old/tx_fdma_old
snapshots, so dma_free_coherent(dev, fdma->size, fdma->dcbs, fdma->dma) runs
a second time on the multi-MB blocks deinit already released.

And the restore: path calls lan966x_fdma_pci_reset_mem(), which memsets up to
rx->fdma.size bytes into freed DMA memory and then dereferences
tx->fdma.atu_region->base_addr, which fdma_free_coherent_and_unmap() already
set to NULL.

Would a "rings are live" state check (or clearing rx.lan966x and dcbs in
deinit, or unregistering the netdevs before fdma_deinit) close this?

[Severity: Medium]
Is the hardware guaranteed to be quiesced at this point?  Both
lan966x_fdma_rx_disable() and lan966x_fdma_tx_disable() are void and swallow
the result of

	readx_poll_timeout_atomic(lan966x_fdma_channel_active, lan966x,
				  val, !(val & BIT(fdma->channel_id)),
				  READL_SLEEP_US, READL_TIMEOUT_US);

so a -ETIMEDOUT never reaches this caller, and the EQ_AVAIL drain poll in
__lan966x_fdma_pci_reload() is discarded too (see below).  If either poll
times out, the extraction/injection engine still owns the old DCB ring while
this function reprograms FDMA_DCB_LLP and then calls
fdma_free_coherent_and_unmap(&rx_fdma_old), which does:

  fdma_free_coherent_and_unmap()
      fdma_pci_atu_region_unmap(fdma->atu_region);  /* ENA=0, translation cleared */
      fdma->atu_region = NULL;
      fdma_free_coherent(dev, fdma);                /* pages returned */

On the PCIe path the ATU window is the address translation itself, so
in-flight writes land on a disabled outbound window or into memory already
handed back to the DMA allocator.  Should a timeout abort the resize and
propagate the error so the MTU change is rejected instead?

> +
> +	lan966x->rx.max_mtu = new_mtu;
> +
> +	/* Must be NULL'ed in order to realloc them. */
> +	lan966x->rx.fdma.atu_region = NULL;
> +	lan966x->tx.fdma.atu_region = NULL;
> +
> +	lan966x->tx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
> +	lan966x->tx.fdma.size = fdma_get_size_contiguous(&lan966x->tx.fdma);
> +	lan966x->rx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
> +	lan966x->rx.fdma.size = fdma_get_size_contiguous(&lan966x->rx.fdma);
> +
> +	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
> +	if (err)
> +		goto restore;
> +
> +	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
> +	if (err) {
> +		fdma_free_coherent_and_unmap(lan966x->dma_dev,
> +					     &lan966x->rx.fdma);
> +		goto restore;
> +	}
> +
> +	/* Free and unmap old memory. */
> +	fdma_free_coherent_and_unmap(lan966x->dma_dev, &rx_fdma_old);
> +	fdma_free_coherent_and_unmap(lan966x->dma_dev, &tx_fdma_old);
> +
> +	/* Order matters: napi_enable() must precede the wakes, or a TX that
> +	 * completes first clears FDMA_INTR_DB_ENA with nothing scheduled to
> +	 * restore it, leaving RX dead until the next reload.
> +	 */
> +	napi_enable(&lan966x->napi);
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);

[Severity: High]
This isn't a bug introduced by this patch, but the hazard this comment
describes looks like it is still live in the sibling register-path reload,
which the series leaves untouched and the commit message does not mention.

lan966x_fdma_reload() uses exactly the order this comment forbids, in both
its success and its restore path:

	lan966x_fdma_rx_start(&lan966x->rx);	/* re-arms RX bit in DB_ENA */
	... page_pool_put_full_page() over 512 DCBs ...
	fdma_free_coherent();
	page_pool_destroy();
	lan966x_fdma_wakeup_netdev(lan966x);
	napi_enable(&lan966x->napi);

The mechanism matches what the comment states.  lan966x_fdma_irq_handler()
does:

	if (db) {
		lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
		lan_wr(db, lan966x, FDMA_INTR_DB);

		napi_schedule(&lan966x->napi);
	}

With NAPI disabled, napi_schedule_prep() returns false and only sets
NAPIF_STATE_MISSED; napi_enable_locked() clears SCHED/NPSVC but does not
re-check MISSED, so no poll runs and the only code that restores DB_ENA
(the lan_wr(0xff, lan966x, FDMA_INTR_DB_ENA) after napi_complete_done()) is
never reached.  Since DB_ENA is now 0, no further DB interrupt can be raised
either.

The TX channel is not disabled during that window, so an in-flight TX
completion or RX DB interrupt there appears to mask all FDMA interrupts
permanently until another MTU change happens to reload.  Should the platform
path get the same ordering fix?

> +
> +	return err;
> +restore:
> +
> +	/* No new buffers are allocated at this point. Use the old buffers,
> +	 * but reset them before starting the FDMA again.
> +	 */
> +
> +	memcpy(&lan966x->tx.fdma, &tx_fdma_old, sizeof(struct fdma));
> +	memcpy(&lan966x->rx.fdma, &rx_fdma_old, sizeof(struct fdma));
> +
> +	lan966x->rx.max_mtu = old_mtu;
> +
> +	lan966x_fdma_pci_reset_mem(lan966x);
> +
> +	napi_enable(&lan966x->napi);
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +
> +	return err;
> +}

[Severity: Medium]
This is a pre-existing ordering issue, but does this patch widen it
noticeably?  lan966x_port_change_mtu() programs the new frame length before
the buffers are grown:

	lan_wr(DEV_MAC_MAXLEN_CFG_MAX_LEN_SET(LAN966X_HW_MTU(new_mtu)),
	       lan966x, DEV_MAC_MAXLEN_CFG(port->chip_port));
	WRITE_ONCE(dev->mtu, new_mtu);

	if (!lan966x->fdma)
		return 0;

	err = lan966x->ops->fdma_resize(lan966x);

and only restores the old value after the callback returns.  On the PCIe path
the callback now does real work: the CPU-queue flush, a
usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC), two multi-megabyte coherent
allocations, and on this restore: path a full RX/TX restart with db_size and
DATAL back at the old smaller value while the larger MAXLEN is still
programmed.

With n_dbs == 1 the FDMA bounds each write by DATAL but continues an
oversized frame in the next DCB, and lan966x_fdma_pci_rx_check_frame() only
validates BLOCKL:

	blockl = FDMA_DCB_STATUS_BLOCKL(db->status);
	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
		return FDMA_ERROR;

It never checks FDMA_DCB_STATUS_SOF/EOF, so a continuation DB is treated as a
complete frame and lan966x_ifh_get_src_port(virt_addr, src_port) parses
payload bytes as the IFH source port.  src_port is range-checked and data_len
is bounded, so this is not an out-of-bounds access, but can a remote sender
that injects an oversized frame in this window get frames delivered to the
stack attributed to a source port of its choosing?

> +
> +static int __lan966x_fdma_pci_reload(struct lan966x *lan966x, int max_mtu)
> +{
> +	int err;
> +	u32 val;
> +
> +	/* Disable the CPU port. */
> +	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
> +		QSYS_SW_PORT_MODE_PORT_ENA,
> +		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));
> +
> +	/* Flush the CPU queues. */
> +	readx_poll_timeout(lan966x_qsys_sw_status,
> +			   lan966x,
> +			   val,
> +			   !(QSYS_SW_STATUS_EQ_AVAIL_GET(val)),
> +			   READL_SLEEP_US, READL_TIMEOUT_US);

[Severity: Medium]
The return value of this readx_poll_timeout() is discarded, so "CPU queues
drained" is assumed rather than verified before the rings are retired in
lan966x_fdma_pci_reload().  Should a -ETIMEDOUT here abort the resize?

> +
> +	/* Add a sleep in case there are frames between the queues and the CPU
> +	 * port
> +	 */
> +	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> +
> +	err = lan966x_fdma_pci_reload(lan966x, max_mtu);
> +
> +	/* Enable back the CPU port. */
> +	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1),
> +		QSYS_SW_PORT_MODE_PORT_ENA,
> +		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));
> +
> +	return err;
> +}
> +
>  static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
>  {
> -	return -EOPNOTSUPP;
> +	int max_mtu;
> +
> +	/* Nothing to resize until fdma_pci_init() has built the rings; it
> +	 * sizes them from DEV_MAC_MAXLEN_CFG, which the caller already set.
> +	 */
> +	if (!lan966x->rx.lan966x)
> +		return 0;

[Severity: High]
This is a pre-existing gap in the other callback rather than something this
patch introduces, but the two implementers of
lan966x_fdma_ops::fdma_resize now disagree about this precondition.  The
platform one has no equivalent check:

lan966x_fdma.c:lan966x_fdma_change_mtu() {
	max_mtu = lan966x_fdma_get_max_frame(lan966x);
	if (max_mtu == lan966x->rx.max_mtu)
		return 0;

	return __lan966x_fdma_reload(lan966x, max_mtu);
}

lan966x_fdma_init() sets rx.lan966x = lan966x only at its own start, so in
the window between register_netdev() in lan966x_probe_port() and
ops->fdma_init() in lan966x_probe(), rx.max_mtu is 0, the comparison always
differs, and the reload runs against an unbuilt ring:

  __lan966x_fdma_reload()->lan966x_fdma_reload()
      lan966x_fdma_rx_disable(&lan966x->rx)
          struct lan966x *lan966x = rx->lan966x;   /* NULL */
          lan_rmw(..., lan966x, FDMA_CH_DISABLE);  /* lan966x->regs */

lan966x->fdma is already true before the port loop and the NAPI instance is
added and enabled by lan966x_port_init()->lan966x_fdma_netdev_init(), so
nothing else stops the path.  Would the guard be better placed once in the
shared caller lan966x_port_change_mtu(), or duplicated in both callbacks?

> +
> +	max_mtu = lan966x_fdma_get_max_frame(lan966x);
> +	if (max_mtu == lan966x->rx.max_mtu)
> +		return 0;
> +
> +	return __lan966x_fdma_pci_reload(lan966x, max_mtu);
>  }
>  
>  static void lan966x_fdma_pci_deinit(struct lan966x *lan966x)
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index c803619d83e2..2177e2bbfbd3 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -823,7 +823,8 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
>  	port->chip_port = p;
>  	lan966x->ports[p] = port;
>  
> -	dev->max_mtu = ETH_MAX_MTU;
> +	dev->max_mtu = lan966x_is_pci(lan966x) && lan966x->fdma ?
> +		       FDMA_PCI_MAX_MTU : ETH_MAX_MTU;
>  
>  	dev->netdev_ops = &lan966x_port_netdev_ops;
>  	dev->ethtool_ops = &lan966x_ethtool_ops;
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> index 16bc28c8f11f..1877f1916d71 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h

[ ... ]

> @@ -87,6 +88,33 @@
>  #define FDMA_INJ_CHANNEL		0
>  #define FDMA_DCB_MAX			512
>  
> +/* Ring must fit in one MAX_PAGE_ORDER DMA block; 512 DCBs overflows
> + * at jumbo MTU.
> + */
> +#define FDMA_PCI_DCB_MAX		256
> +
> +#define FDMA_OVERHEAD							\
> +	(IFH_LEN_BYTES +						\
> +	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +		\
> +	 VLAN_HLEN * 2 +						\
> +	 XDP_PACKET_HEADROOM)
> +
> +/* Largest db_size keeping the ATU-padded ring inside one MAX_PAGE_ORDER
> + * block and within the 16-bit DCB DATAL field. Inverts ALIGN(x, R) <= L
> + * into x <= ALIGN_DOWN(L, R) to bound x directly.
> + */
> +#define FDMA_PCI_DB_SIZE_MAX						\
> +	MIN_T(u32,							\
> +	      (ALIGN_DOWN(PAGE_SIZE << MAX_PAGE_ORDER,			\
> +			  FDMA_PCI_ATU_REGION_ALIGN) -			\
> +	       FDMA_PCI_DCB_MAX * sizeof(struct fdma_dcb)) /		\
> +	      (FDMA_PCI_DCB_MAX * FDMA_RX_DCB_MAX_DBS),			\
> +	      ALIGN_DOWN(GENMASK(15, 0), FDMA_PCI_DB_ALIGN))
> +
> +#define FDMA_PCI_MAX_MTU						\
> +	(FDMA_PCI_DB_SIZE_MAX - FDMA_OVERHEAD -				\
> +	 (ETH_HLEN + ETH_FCS_LEN))

[Severity: Low]
Would a BUILD_BUG_ON help here?  Both subtractions are unsigned and
unguarded, and this macro is the only enforcement point for the
MAX_PAGE_ORDER ring-size limit, the 16-bit DATAL limit, and dev->max_mtu.

FDMA_PCI_DCB_MAX * sizeof(struct fdma_dcb) is 256 * 256 = 65536.  If
PAGE_SIZE << MAX_PAGE_ORDER is at or below 128 KB, the first subtraction
wraps and MIN_T(u32, ...) then picks the 65408 branch.  In between, the
second subtraction wraps: with 4 KB pages and MAX_PAGE_ORDER == 5 the
quotient is 256 while FDMA_OVERHEAD + ETH_HLEN + ETH_FCS_LEN is 630, so
FDMA_PCI_MAX_MTU becomes roughly 4G and is assigned straight into
dev->max_mtu, so dev_validate_mtu() accepts anything up to INT_MAX and the
cap this patch installs disappears.

In the other direction, 4 KB pages with MAX_PAGE_ORDER 6 or 7 yield 138 and
1162, i.e. dev->max_mtu below ETH_DATA_LEN, so a plain 1500-byte MTU cannot
be set.  Nothing asserts FDMA_PCI_MAX_MTU >= ETH_DATA_LEN.

The default 4 KB-page, MAX_PAGE_ORDER=10 build does give 16128 and MTU 15498
as the commit message says, and arch/arm/Kconfig declares ARCH_FORCE_MAX_ORDER
as a plain int prompt with no range constraint (it already ships
default "8" if SA1111), so these values are at least legal.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
