Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2443C06A
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573557; cv=none; b=BssjNvWo4+bRIrYkr4Q5jIe/khoQjmyRd12bdHVl+Q2S0dE0x/O7xRZivFYxOGWDP6urvKR7l/p9Fm3v6bdR+oSImkfyvO082p+4LDd0xGXKSglYVWbYGI0fc1HjhvPv4W6kH9SZ1rUl6ZrSaG//jqRL8FH4SGbCecldkc0ShoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573557; c=relaxed/simple;
	bh=kUuLQ1hXQZ/pEwwaJ2TL3iGxkHo2uA99Ce6sNQQixuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kcBZ8qL/oxBTgOgQ1eefmzWJhLbMCCDksINfJeXdO7dbxqu0bJVISXRSTJCgOlX8lh/kT2z43i1ciSb3kUZkPkq1YMqZyMrOb8RxcqeOGawh3pxmHuoz3fcC0C2wJzPPSURLEL8kPJz+uOl0CkyH3rSU5LUbjiQAi53wLLFRT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM0hdBjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM0hdBjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A650C1F00893;
	Thu,  4 Jun 2026 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780573555;
	bh=0X74QcJD4ZqS/QVW+GMGuezxBRe9IvPkuiZiCalJVpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aM0hdBjLOfa2T2qiEv68hlqE2d1uVydQ5rrjj7NH3k7LmvgyxGXb724ON3mieXlZf
	 GzSKE8xZHrHt0TLEbJ/OnWp0S0Dt9fugftj5m3nc45B45zH18nt7wDWUtE81bW/k21
	 Xv3vH/qmIrNxJLR72xUXTq88RK/gabmeo3xbc8bnL0UHgjF05tGjas10qdIbCwjCT1
	 9trkiQRASlWsnOjy+YKYcjs13ovT5pZsnAxC3hflbR71cQkgCb3XvDWx7FTFicr3Kd
	 F369Sbo9ATkXW9bduTkZQBNTy5Os8DEwkaiAd5rixuYrStXGUJujLj4uB5SjA6wFlt
	 K4IPjg7Ykt7ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: lan966x: restore XDP RXQ page pool on reload
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604112846.1420908-1-lgs201920130244@gmail.com>
References: <20260604112846.1420908-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 11:45:55 +0000
Message-Id: <20260604114555.A650C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The newly added XDP memory model rollback loop in `lan966x_fdma_re=
load()` unconditionally unregisters and re-registers the mem model without =
checking for memory allocation failures.

Pre-existing issues:
- [Critical] Failure to restore `rx.page_order` and `rx.max_mtu` in the `la=
n966x_fdma_reload()` error path leads to buffer overflows during XDP proces=
sing.
- [High] Ignored return value of `xdp_rxq_info_reg_mem_model()` in `lan966x=
_fdma_rx_alloc_page_pool()` leads to corrupted page pool lifecycle.
- [High] Ignored return value of `fdma_dcbs_init()` in `lan966x_fdma_rx_all=
oc()` leads to partially initialized RX rings and kernel panics.
- [High] Incorrect DMA address synced for CPU in `lan966x_fdma_rx_check_fra=
me()` causes stale data reads.
--

commit 8b9f21e42e8db3d429f28a032ed49f4eb0966779
Author: Guangshuo Li <lgs201920130244@gmail.com>

net: lan966x: restore XDP RXQ page pool on reload failure
   =20
lan966x_fdma_rx_alloc_page_pool() registers the newly allocated page pool
with each port's XDP RXQ. During an FDMA reload, this registration is
performed before fdma_alloc_coherent() is called.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc09..76654b44baf2b 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -855,6 +855,21 @@ static int lan966x_fdma_reload(struct lan966x *lan96=
6x, int new_mtu)
>  restore:
>  	lan966x->rx.page_pool =3D page_pool;
>  	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));

[Severity: Critical]
This is a pre-existing issue, but rx.page_order and rx.max_mtu are not rest=
ored
in this error path.

In lan966x_fdma_reload(), rx.page_order and rx.max_mtu are updated before
calling lan966x_fdma_rx_alloc().

If the allocation fails, the driver state remains corrupted. When packet
reception resumes, lan966x_xdp_run() calls xdp_init_buff() using the corrup=
ted
rx.page_order:

drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c:lan966x_xdp_run() {
    xdp_init_buff(&xdp, PAGE_SIZE << lan966x->rx.page_order,
                  &port->xdp_rxq);
}

This incorrectly tells the XDP subsystem that the buffer size is the new, l=
arger
size, while the backing pages are drawn from the old page_pool.

Could a BPF program using bpf_xdp_adjust_tail legitimately expand the packet
into unallocated memory, causing an out-of-bounds write?

> +	/*
> +	 * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
> +	 * each port's XDP RXQ before the allocation failed. The new pool is
> +	 * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool's
> +	 * registration before restarting RX.
> +	 */
> +	for (int i =3D 0; i < lan966x->num_phys_ports; i++) {
> +		if (!lan966x->ports[i])
> +			continue;
> +
> +		xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq);
> +		xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> +					   MEM_TYPE_PAGE_POOL, page_pool);

[Severity: High]
Does this code handle memory allocation failures safely?

The newly added loop unconditionally calls xdp_rxq_info_reg_mem_model(), wh=
ich
allocates memory internally and can fail.

The return value is ignored here. If it fails (which is highly likely if the
rollback was triggered by an OOM condition), the port's XDP RX queue is left
without a registered memory model (type =3D 0).

Subsequently, when RX resumes, pages belonging to the page_pool will be
incorrectly freed using page_frag_free() instead of being returned to the p=
ool.

Could this turn a safe error rollback path into memory corruption and page =
pool
leaks?

> +	}
> +
>  	lan966x_fdma_rx_start(&lan966x->rx);
> =20
>  	lan966x_fdma_wakeup_netdev(lan966x);

[Severity: High]
This isn't a bug introduced by this patch, but does
lan966x_fdma_rx_alloc_page_pool() leave the port in an inconsistent state if
memory registration fails?

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_alloc=
_page_pool() {
    xdp_rxq_info_unreg_mem_model(&port->xdp_rxq);
    xdp_rxq_info_reg_mem_model(&port->xdp_rxq, MEM_TYPE_PAGE_POOL,
                               rx->page_pool);
    ...
    return PTR_ERR_OR_ZERO(rx->page_pool);
}

The return value of xdp_rxq_info_reg_mem_model() is ignored.

If the registration fails due to an out-of-memory condition, the function s=
till
returns 0 because it relies on PTR_ERR_OR_ZERO(rx->page_pool).

This leaves the port's XDP RX queue with a default or zeroed memory model t=
ype.
Any packets received and subsequently returned or dropped by XDP will be fr=
eed
via the wrong deallocation path (page_frag_free() instead of page pool
recycling).

Could this lead to severe memory corruption?

[Severity: High]
This is a pre-existing issue, but does lan966x_fdma_rx_alloc() ignore the
initialization failure from fdma_dcbs_init()?

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_alloc=
() {
    ...
    fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
                   FDMA_DCB_STATUS_INTR);

    return 0;
}

If page allocation fails midway, fdma_dcbs_init() returns -ENOMEM. However,
lan966x_fdma_rx_alloc() ignores this return value and unconditionally retur=
ns 0.

Consequently, the driver continues as if the ring is fully populated, but s=
ome
rx->page[dcb][db] entries will be NULL.

Later, when cleaning up via lan966x_fdma_rx_free_pages(),
page_pool_put_full_page() is called with these NULL pointers.

Can this cause a kernel panic?

[Severity: High]
This is a pre-existing issue, but does lan966x_fdma_rx_check_frame() add
XDP_PACKET_HEADROOM a second time when syncing the DMA buffer?

In lan966x_fdma_rx_dataptr_cb(), the DMA pointer db->dataptr is initialized=
 to
page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM.

However, when syncing the buffer for the CPU:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_check=
_frame() {
    dma_sync_single_for_cpu(lan966x->dev,
                            (dma_addr_t)db->dataptr + XDP_PACKET_HEADROOM,
                            FDMA_DCB_STATUS_BLOCKL(db->status),
                            DMA_FROM_DEVICE);
}

The code calls dma_sync_single_for_cpu() with (dma_addr_t)db->dataptr +
XDP_PACKET_HEADROOM, effectively adding the headroom twice.

This means the sync starts 512 bytes into the buffer instead of 256.

When the CPU subsequently reads the IFH header and packet data from
page_address(page) + XDP_PACKET_HEADROOM, it accesses unsynchronized memory.

Could this lead to stale reads and data corruption on non-coherent
architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604112846.1420=
908-1-lgs201920130244@gmail.com?part=3D1
