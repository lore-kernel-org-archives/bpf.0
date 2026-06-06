Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5F23EAB8
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748107; cv=none; b=VBzTxyiWjJgrI8s3IZo3CWp5AJQArXTuLxO8YEUzRKhyiFJgqoK96Vt/tl6OMKHMUC+K4fXmJlfxmHfYf97FBYKa7l1DvSzIq2yKHBqBsj6GV64Liy0Pc70DcmoRl3c2GNOB2dQJ1Bm8yZm+JjTCA6SEouU8HGVTEWavkw6zTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748107; c=relaxed/simple;
	bh=xhRJ01ZftqcEY2+M9L4zz37yVsX+PeLaGj8iQ5/EgWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mU27EoJdawVgdgwfQ4A8k2tMrusRtqq2dmnWLbgi7dyfmc/e2tIqymvulFva+/gTPGtTsimOwN0Df1C3UOBMaXchjlpSYhtjGAFY/gDi2CN1h6utvWzqE4L2PCOb6fqgnjUlMpTnac4+uJpkGWCGKyUMdEyYfkFiHdPXaZo87h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Res++YM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Res++YM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F201F00898;
	Sat,  6 Jun 2026 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748106;
	bh=PvLaESpIjMmPxWA5FJ3Wt+Exeu4fcpyZXwZ/8L8st9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Res++YM+nj7i9MCXkWf8OLSrUxL4dd/B7IfOLJ+1/f99A2k3zSG2sgJaKi4bihEtc
	 AlU+n0lAzAxKS411aETkK37JNno9lGj4KIiuM1ojWMofnNRRxuwx17ZXwvki8lU7Y0
	 ZUHdKwbs4Vsax8xHYNoT0aMlRD1gLhE/zd2HbAFKoRHIJh3+AljyqYu3ktmhPyV7sy
	 n9OH1j/weLaxBcagtvkT5oG1JyhQYR4j7z7gCJPA71olDkOUiuBlzBqxzZxJVREFVB
	 tnW/T6xf7HnMq8Rpb87kqXHaVk3eS3Trq9+LGatqLf1BaY6aWdJzUcwQGhxYZnRivw
	 dqjQeYZdt4HzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/4] net: mvpp2: refill RX buffers before XDP or
 skb use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605121332.147397-4-mail@tk154.de>
References: <20260605121332.147397-4-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:15:05 +0000
Message-Id: <20260606121506.13F201F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incomplete DMA sync when recycling an XDP-modified page during SKB=
 allocation failure.

Pre-existing issues:
- [High] Variable swap leading to invalid memory access in mvpp2_buff_hdr_p=
ool_put().
- [High] Acquiring a spinlock with preemption disabled causes a sleep-in-at=
omic bug on PREEMPT_RT.
--

commit 9aeeec1a49aec085a29bfd1f85e72ffb42da9a5c
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: refill RX buffers before XDP or skb use

This patch adjusts the RX error path to prevent returning a buffer to the
hardware BM pool if it has already been handed to XDP or attached to an skb.
It refills the BM pool earlier so that if allocation fails, the original
still-owned buffer can safely be returned to the hardware pool.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 3372ed27cc8d6..481daafdc1cbc 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c

[ ... ]

> @@ -4008,8 +4008,21 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  			skb =3D slab_build_skb(data);
>  		if (!skb) {
>  			netdev_warn(port->dev, "skb build failed\n");
> -			goto err_drop_frame;
> +			if (pp) {
> +				page_pool_put_page(pp, virt_to_head_page(data),
> +						   rx_bytes + MVPP2_MH_SIZE,
> +						   true);

[Severity: High]
Does this truncate the DMA sync size if the packet length was modified by X=
DP?

Earlier in mvpp2_rx(), an XDP program might have been executed which could
reduce the packet length using helpers like bpf_xdp_adjust_tail, updating
rx_bytes to a smaller value.

If build_skb() subsequently fails here, we use this reduced rx_bytes for the
page pool DMA sync. Because the sync does not cover the tail of the buffer
that the CPU may have fetched into its cache, can this lead to memory
corruption when the hardware DMA writes a new packet and the dirty CPU cache
lines are evicted over it?

In mvpp2_run_xdp(), this appears to be handled properly by calculating
max(sync, len).

> +			} else {
> +				dma_unmap_single_attrs(dev->dev.parent, dma_addr,
> +						       bm_pool->buf_size,
> +						       DMA_FROM_DEVICE,
> +						       DMA_ATTR_SKIP_CPU_SYNC);
> +				mvpp2_frag_free(bm_pool, pp, data);
> +			}
> +			goto err_drop_frame_retired;
>  		}

[ ... ]

> @@ -4048,13 +4052,14 @@ static int mvpp2_rx(struct mvpp2_port *port, stru=
ct napi_struct *napi,
>  		continue;
> =20
>  err_drop_frame:
> -		dev->stats.rx_errors++;
> -		mvpp2_rx_error(port, rx_desc);
>  		/* Return the buffer to the pool */
>  		if (rx_status & MVPP2_RXD_BUF_HDR)
>  			mvpp2_buff_hdr_pool_put(port, rx_desc, pool, rx_status);

[Severity: High]
This is a pre-existing issue, but does mvpp2_buff_hdr_pool_put() swap the
physical and DMA addresses?

Looking at mvpp2_buff_hdr_pool_put():

static void mvpp2_buff_hdr_pool_put(...)
{
        ...
        phys_addr =3D mvpp2_rxdesc_dma_addr_get(port, rx_desc);
        dma_addr =3D mvpp2_rxdesc_cookie_get(port, rx_desc);

        do {
                buff_hdr =3D (struct mvpp2_buff_hdr *)phys_to_virt(phys_add=
r);

It appears phys_addr is initialized with the DMA address, and dma_addr with
the physical address. Because of this swap, we call phys_to_virt() on a DMA
address. On systems where the DMA address and physical address differ (like
when an IOMMU is active), could this cause an invalid memory access?

>  		else
>  			mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);

[Severity: High]
This is also a pre-existing issue, but does mvpp2_bm_pool_put() acquire a
spinlock while preemption is disabled?

Looking at mvpp2_bm_pool_put():

static inline void mvpp2_bm_pool_put(...)
{
        unsigned int thread =3D mvpp2_cpu_to_thread(port->priv, get_cpu());
        unsigned long flags =3D 0;

        if (test_bit(thread, &port->priv->lock_map))
                spin_lock_irqsave(&port->bm_lock[thread], flags);

Since get_cpu() executes preempt_disable(), we conditionally attempt to
acquire the bm_lock spinlock immediately after. On PREEMPT_RT kernels, where
standard spinlocks are mapped to sleepable rt_mutexes, won't this cause a
sleep-in-atomic bug when this code path is hit?

> +err_drop_frame_retired:
> +		dev->stats.rx_errors++;
> +		mvpp2_rx_error(port, rx_desc);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121332.1473=
97-1-mail@tk154.de?part=3D3
