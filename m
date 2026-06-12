Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F33090C6
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290709; cv=none; b=tUuC+YtiHePO9mVNCwAAVQ6HcS+Q+ttFQvskfHc13PoSg4H6neaDgxV4fjBO7UaoQPq6/9N0mcB0xtgD9e/65LpoDthOZkwePrAPfm4hO9EvLXs1MpYXUBVwYti0VXLFVoDeBhVkTvXlhfp8/WetVwWTKwEkIQug1PYAHEz2Wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290709; c=relaxed/simple;
	bh=hlyrtnX0tyGyG27N4e2zXL4/5d/1+toWf8Jd2h7x89I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xs+JkkSorsPr6ineLq9m4CTJReE+8qHMpC2h7S8nfMv2RUz5N5hAGVc0sFp5hMxvknDPldB7xHpYsAnPSC0X1B0Flg7aEXCPw57zxgcgI/q8MEynvnbhtjPU9YKeYd5dGe9Riu9ZedQEckYwBchEj2eUVRoB7ZXvZM2Lkez1Muo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFRC+w6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFRC+w6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB711F00A3D;
	Fri, 12 Jun 2026 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781290707;
	bh=lXhOAHZfX3nTcQAvM5ZZCdHwoJnwEREfZN8ihEHdq6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFRC+w6oQhv4p51H24NtaA/Kawx5tfzcq8FMBbiYEvGDwhpIn76xNE0RTyanfcYPc
	 4mX0xizM4kcJb5u3mLimFirVVVa3hXgDQF3rMICDC40F7S6DFTtC2vXBn+fBsn173G
	 wUs1VdGw4EgvCmdvbPjwpSJ6O6fvT91uvLmqUcKbEQI9mOf7DBHc5QeINRwnUw2kKm
	 5uaAv7TNRGpw6HIRTHYKU3MHac+PUoNW+CAIQXYiqUTtyrhIaYp8kqo8c4zLEud/nM
	 nLYUhShHbtbzrj+fOP063p3QMcSVyF/6vvw6iZkteX5SjeM/zu6uR7KhYQrqGsc235
	 VpS5pZpmUlo8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/4] net: ti: icssg-prueth: Fix AF_XDP fill ring
 alloc and wakeup condition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611185744.2498070-2-m-malladi@ti.com>
References: <20260611185744.2498070-2-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:58:27 +0000
Message-Id: <20260612185827.BBB711F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer underflow in `pkt_len -=3D 4` leads to massive XDP out=
-of-bounds read/write in Zero Copy mode and skb_over_panic in standard mode.
- [High] In `icssg_napi_rx_poll()`, when zero-copy is enabled, `num_rx` is =
overwritten instead of accumulated across multiple flows, and the full `bud=
get` is passed to each flow.
--

commit c6fd345481cd54bff877bdb42096a81eabfe43d0
Author: Meghana Malladi <m-malladi@ti.com>

net: ti: icssg-prueth: Fix AF_XDP fill ring alloc and wakeup condition

This patch fixes AF_XDP fill ring allocation by introducing an allocation
budget based on available descriptors. It prevents pool exhaustion errors
and spurious XSK wakeups by avoiding allocations when the descriptor pool
is empty.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index a28a608f9bf4b..55a696912811f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -927,6 +927,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac=
, u32 flow_id,
>  	struct cppi5_host_desc_t *desc_rx;
>  	struct prueth_swdata *swdata;
>  	dma_addr_t desc_dma, buf_dma;
> +	int avail_desc, alloc_budget;

[Severity: High]
This isn't a bug introduced by this patch, but could icssg_napi_rx_poll()
mishandle the budget and num_rx values when calling emac_rx_packet_zc()
for multiple flows?

In icssg_napi_rx_poll():

    if (rx_chn->xsk_pool) {
        num_rx =3D emac_rx_packet_zc(emac, flow, budget);
    } else {

Because num_rx is overwritten instead of accumulated across multiple flows,
and the full budget is unconditionally passed to each flow, might the driver
process up to N * budget packets per NAPI cycle? If the last flow evaluated
processes 0 packets while previous flows processed many, could NAPI
incorrectly assume no work was done and drop out of polling mode?

[Severity: Critical]
This is a pre-existing issue, but does unconditionally subtracting 4 from
pkt_len cause an integer underflow if a short descriptor is received?

In emac_rx_packet_zc():

    pkt_len =3D cppi5_hdesc_get_pktlen(desc_rx);
    /* firmware adds 4 CRC bytes, strip them */
    pkt_len -=3D 4;
    ...
    xsk_buff_set_size(xdp, pkt_len);

If the hardware provides a malformed descriptor with a length less than 4,
the unsigned subtraction could underflow, resulting in a large 32-bit value.
When passed to xsk_buff_set_size(), this sets a malformed data_end, which
could allow an XDP program to perform out-of-bounds reads or writes.

The same integer underflow exists in the standard RX path in
emac_rx_packet():

    pkt_len -=3D 4;
    ...
    skb_put(skb, pkt_len);

Passing the underflowed length to skb_put() might directly trigger a kernel
panic via skb_over_panic(). Should there be a bounds check before the
subtraction?

>  	struct xdp_buff *xdp;
>  	int xdp_status =3D 0;
>  	int count =3D 0;
> @@ -993,16 +994,13 @@ static int emac_rx_packet_zc(struct prueth_emac *em=
ac, u32 flow_id,
>  	if (xdp_status & ICSSG_XDP_REDIR)
>  		xdp_do_flush();
> =20
> -	/* Allocate xsk buffers from the pool for the "count" number of
> -	 * packets processed in order to be able to receive more packets.
> -	 */
> -	ret =3D prueth_rx_alloc_zc(emac, count);
> +	avail_desc =3D k3_cppi_desc_pool_avail(rx_chn->desc_pool);
> +	alloc_budget =3D min_t(int, budget, avail_desc);
> +
> +	ret =3D prueth_rx_alloc_zc(emac, alloc_budget);
> =20
>  	if (xsk_uses_need_wakeup(rx_chn->xsk_pool)) {
> -		/* If the user space doesn't provide enough buffers then it must
> -		 * explicitly wake up the kernel when new buffers are available
> -		 */
> -		if (ret < count)
> +		if (ret < alloc_budget)
>  			xsk_set_rx_need_wakeup(rx_chn->xsk_pool);
>  		else
>  			xsk_clear_rx_need_wakeup(rx_chn->xsk_pool);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611185744.2498=
070-1-m-malladi@ti.com?part=3D1
