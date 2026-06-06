Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD952F5468
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760735; cv=none; b=gVjOeUYOHNSwAi6ulFVSIr6u7BSyk5HVZbMR4AF4cOGxxRQZkT1O2NOjwiKJwWOo2g4extUm0CqUrqT3fRy9ObHT36TcE9pQcDIcd54MoLARyIj9sr9NrIY3uynoT54YSITLwyJCQF3MW44NPNX8n/FrbRrphCVFHxzABD9m28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760735; c=relaxed/simple;
	bh=HQe8S9lwI4y6y2nJNOO41eiGRf9hvSYdkQjD/WQgICY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXSWT7j6zxaKbfWPVzLVJ2xYsxJtm3E8AkqxLYL+b0TSr5ZxGeSTe049PAprL8lSSsZ2xKhjdFluhf6EcHCC67JKzCT1wye7vuMY3GEdmUWbgwLPFlhDznwJbPlkIVfBNkcJYId5uB/Boy0PQdpxVS3s5+akTkjMr/HhMqSkGXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMPavB/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMPavB/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812B61F00898;
	Sat,  6 Jun 2026 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780760734;
	bh=iIUXDt0+q85L3X4rSFni/hiHIs87VIisd8NobuJg6Rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lMPavB/Ap+cvqV/vuvjoYrieHFaQnn1t03KDUgYrDLPFBsF0dDJ6hrQEXJBxw01cH
	 rOZpfOJZ/avYS8SBADpk1YqwcoxEGbNowjsoFVIDcVzFtxOK8M3n/En8v3P98yLSbE
	 l1h7wJ054B49Vm7iEC39Nkz7l5KprzBHMULdXcVpD75rsFnddwu96TQDTIp5F1VnpE
	 FiOIF/0pmVEp43guVGuqfH+OiBh/7wjK+6xLAvdUQUAY881/WaV96gL4OYGkzBaOv/
	 uXVAWU2iPHCg4qW/MaMd1BD5dEjmiEzwVDpu+ayDkegr6V1Op1QgVhyh1Jx0u4z7yn
	 Gf3srx8Rhu11g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/4] net: mvpp2: sync RX data at the hardware
 packet offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605154457.163304-2-mail@tk154.de>
References: <20260605154457.163304-2-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:45:34 +0000
Message-Id: <20260606154534.812B61F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In the `mvpp2_rx` error path for `build_skb()` failure, the driver=
 passes the potentially shrunk `rx_bytes` to `page_pool_put_page()`, failin=
g to sync the entire CPU-touched region back to the device.
--

commit f0a643ac2be4e337423088cdfdd2a25a0f4e5e19
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: sync RX data at the hardware packet offset
   =20
mvpp2 programs the RX queue packet offset, so hardware writes received
data at dma_addr + MVPP2_SKB_HEADROOM. The current CPU sync starts at
dma_addr and only covers rx_bytes + MVPP2_MH_SIZE bytes, which syncs the
unused headroom and misses the same number of bytes at the packet tail.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index f442b874bb593..92a701f4fe3f5 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3946,9 +3946,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  			dma_dir =3D DMA_FROM_DEVICE;
>  		}
> =20
> -		dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
> -					rx_bytes + MVPP2_MH_SIZE,
> -					dma_dir);
> +		dma_sync_single_range_for_cpu(dev->dev.parent, dma_addr,
> +					      MVPP2_SKB_HEADROOM,
> +					      rx_bytes + MVPP2_MH_SIZE,
> +					      dma_dir);

[Severity: High]
Does this regression also affect the build_skb() error path in mvpp2_rx()?

If an XDP program modifies the packet payload and shrinks the packet length
(e.g., via bpf_xdp_adjust_tail()), rx_bytes becomes smaller than the
originally received packet size.

If build_skb() subsequently fails, the error path calls:

    if (pp) {
        page_pool_put_page(pp, virt_to_head_page(data),
                           rx_bytes + MVPP2_MH_SIZE,
                           true);

Since page_pool_put_page() syncs this truncated rx_bytes length back to the
device, could the CPU cache lines at the tail of the original packet remain
unflushed?=20

When the page is recycled and non-coherent hardware DMA writes a new packet
into the buffer, might the dirty CPU cache lines be evicted and silently
overwrite the new packet's data?

> =20
>  		/* Buffer header not supported */
>  		if (rx_status & MVPP2_RXD_BUF_HDR)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605154457.1633=
04-1-mail@tk154.de?part=3D1
