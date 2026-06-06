Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BC3AFAE3
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760737; cv=none; b=FfpI1NsHGYf/5k7KW3oufXQ85uaHU2tuScZ1463Nei3dvv1SAUcuU+PpqrmS1RRfBCk78N78nfariptuZG88KVQKxzYRUFhCtSJ5MKgZPE5r6LDn84My+lLamYJScrIUy8mN2iDbEzdWAQjXudl55HOJ+Nyh8kb0ODBernAKiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760737; c=relaxed/simple;
	bh=HFT8f9HdpLzFFRWQfzjBf7LkkjqawgVDMySFCirybjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YKJJz9CbIKUFyJsvQHJ/iIKC3L/JSRXAwHt44m3T8Xyy+SBDtGKOYoxPiJTcxumpAO9maTbj2kf9Kh1xzRzeZ4e29L3hdFJ5sTTWtGwYzJmmrfp+A/baZyMIrNH6L1fOwA46j405oJMe65BeGVfY11O6n6UczwzwJ7sHGYbVJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km9yLtPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km9yLtPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B901F00899;
	Sat,  6 Jun 2026 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780760735;
	bh=kPl2iw2jp0J0RYQWWVU7kcZsCwXH5NeWvV0zSIjy9Xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=km9yLtPj3xjm60XISFwU3kd6dXE2536lhplDed1U92ij0y2dqxcB6Fu4FZjhY11lb
	 HEnhDOXIf0629Ss/WYqmvmyz+JP4gAQY1tq8dD1hsJtQrchHqQOV03wKSGb6mPnaKk
	 DXBUf80ielxAS6eYoAaPbh8vjBVUNkk0x6qfZf/2G+8kHXzcFpTw8kCbOCjJsDtnpZ
	 /EtOCrPvJtyicqw3VB+Ijo04NY7IdsgVGBp5wvE1TjZuioZR2fgKmVO/peU4gKb+w3
	 FB0F/NwtwKEJEZk13EIsm2txW/zYKVefsZ41inQWTbelVi9Sjp6KtxDGVZcDrSGDeZ
	 3uQi+X97rKAYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/4] net: mvpp2: refill RX buffers before XDP or
 skb use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605154457.163304-4-mail@tk154.de>
References: <20260605154457.163304-4-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:45:34 +0000
Message-Id: <20260606154535.87B901F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pre-existing bug in `mvpp2_buff_hdr_pool_put` where `phys_addr=
` and `dma_addr` are swapped, leading to a potential crash during `phys_to_=
virt()`.
- [High] Unratelimited `netdev_err` and `netdev_warn` calls in the NAPI pol=
l loop can cause syslog flooding and CPU livelock.
- [High] Missing `dma_sync_single_for_device` when dropping packets and ret=
urning them to the hardware pool.
--

commit 475b5364852b812377b363f98f67c255857f76d2
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: refill RX buffers before XDP or skb use

This commit reorders the RX processing in the mvpp2 driver to refill
the hardware buffer manager (BM) pool before handing the current
descriptor buffer over to XDP or allocating an skb. If the refill
fails, the packet is dropped and the original buffer is returned to
the pool.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 3372ed27cc8d6..481daafdc1cbc 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3971,6 +3971,12 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  		else
>  			frag_size =3D bm_pool->frag_size;
> =20
> +		err =3D mvpp2_rx_refill(port, bm_pool, pp, pool);
> +		if (err) {
> +			netdev_err(port->dev, "failed to refill BM pools\n");

[Severity: High]
This isn't a bug introduced by this patch, but since this log is inside the
high-frequency NAPI poll loop, could persistent memory pressure cause syslog
flooding and CPU livelock? Should this use netdev_err_ratelimited() instead?

> +			goto err_drop_frame;
> +		}
> +
>  		if (xdp_prog) {

[ ... ]

> @@ -4008,8 +4008,21 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  			skb =3D slab_build_skb(data);
>  		if (!skb) {
>  			netdev_warn(port->dev, "skb build failed\n");

[Severity: High]
This is a pre-existing issue, but similar to the refill error above, could
this cause syslog flooding under memory pressure? Would it be better to use
netdev_warn_ratelimited() here?

> -			goto err_drop_frame;
> +			if (pp) {

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

[Severity: Critical]
This is a pre-existing issue, but this patch makes the err_drop_frame path
more likely to be hit on refill failure. Looking at
mvpp2_buff_hdr_pool_put(), the physical and DMA addresses appear to be
extracted backwards:

mvpp2_buff_hdr_pool_put() {
    phys_addr =3D mvpp2_rxdesc_dma_addr_get(port, rx_desc);
    dma_addr =3D mvpp2_rxdesc_cookie_get(port, rx_desc);
    ...
    buff_hdr =3D (struct mvpp2_buff_hdr *)phys_to_virt(phys_addr);
}

Does this cause an invalid memory dereference since phys_addr actually
contains an IOVA instead of the physical address?

>  		else
>  			mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);

[Severity: High]
This is a pre-existing issue, but early in mvpp2_rx(), ownership of the
packet buffer is explicitly transferred to the CPU via
dma_sync_single_range_for_cpu().

If a subsequent error is detected and we jump to the err_drop_frame label,
the buffer is returned directly to the hardware BM pool without calling
dma_sync_single_range_for_device().

Does this violate the DMA API rules and potentially cause memory corruption
for the next packet if dirty cache lines are written back?

> +err_drop_frame_retired:
> +		dev->stats.rx_errors++;
> +		mvpp2_rx_error(port, rx_desc);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605154457.1633=
04-1-mail@tk154.de?part=3D3
