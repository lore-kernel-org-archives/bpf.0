Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F51AA1F4
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101877; cv=none; b=QmI/REieYDwz56vZLqKP8cTocJNKQPlzsy5tkkpNWtOCgbe1pan0/RbPtoAcSv0QivmSeLSjilSiaZ0eCIfozh/+PnfzFHL0loJZIhYJQZLfjDtFEaVf+PDm6S6rWIQKSTp2HmsQyScdBtV9eMjcaW5OeqkBKwvjEEshmT9B2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101877; c=relaxed/simple;
	bh=DNM2D0zMZyUXcGeS2I9M+eDIe7KkdaTGFr74nJYHFFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLgFqIC/vBvCWqjLW7keRVWinrq6c3GNLsc+MWnnqp5DYW3sBeaPcaLBTVHBfx4ndIno0O8t6Bm0wmaqnJEKfr4YcpNz9iMhZCj/B0tZRVFIddjFEeEQjMLvc5zjsCcnooguSGVgftJ/6v20+QThx6RBe1kbCGNRJF6wLBMEIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/BoiSBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/BoiSBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27B01F00893;
	Sat, 30 May 2026 00:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101875;
	bh=p7Rbaz6rJxTxlOtB6YZLyeI4RcwDlloOG2/++UYsV78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/BoiSBFTlPgFzwpb9KfDVMHjidDJUE23q+VnjNkOrlXFdRhcvBinlpIA8vXiSrAS
	 6IuJl6aPWzV+tP2ZsTDCWGWG5hNNMDGXoMYS7yEOSKQB8iBQLMkPj1FDHg1mvQVRHi
	 nsY/en7iWUrVN7S3H++KyW2GwxrnkD1kQ3nOILFgKSRveEe988p9oNUAGTJtwV0fKx
	 DMLhUnrGVHSULd3olzIgPuqksw/0ARvat4xjbWWkeBt3m7a1AQEsvjhXbBiie1yNHT
	 M3cH9jU3Fw4UeSnXa39NNZaoyggcz0jilVx45iT0oK1WkF8X8+rwfV8HC1XNG9s5sf
	 uowAw7gMZB55w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 05/13] net: lan966x: export FDMA helpers for
 reuse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-lan966x-pci-fdma-v5-5-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-5-ca56197ae05b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:35 +0000
Message-Id: <20260530004435.C27B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing dma_wmb() when appending new DMA descriptors to an active =
ring.
- [High] Lack of endianness conversions for hardware DMA descriptor fields,=
 incompatible with PCIe on Big-Endian hosts.
- [High] Missing bounds validation on hardware-provided length before calli=
ng skb_put(), risking kernel panic.
--

commit 71ed27dbfea60bc58684878c1afb6584c28b04fb
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: export FDMA helpers for reuse

This patch makes shared FDMA helpers non-static to allow their reuse by the
PCIe FDMA implementation.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 6c5761e886d47..25e673bdf0841 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c

[ ... ]

> @@ -471,7 +471,7 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(stru=
ct lan966x_rx *rx,
>  	return NULL;
>  }
> =20
> -static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
> +int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but since this helper is being
exported for PCIe reuse, does the platform RX path need bounds validation on
the hardware-provided length?

In lan966x_fdma_rx_get_frame() (called by this NAPI poll function), the
packet length is extracted directly from the hardware descriptor and passed
unconditionally to skb_put():

	skb_put(skb, FDMA_DCB_STATUS_BLOCKL(db->status));

If the hardware returns a length exceeding the allocated SKB data region
minus the XDP headroom, skb_put() will extend the tail beyond skb->end,
resulting in an immediate skb_over_panic(). Should the length be validated
against the available headroom and at least IFH_LEN_BYTES before calling
skb_pull()?

[Severity: High]
This is a pre-existing issue, but since the FDMA implementation is being
exposed for PCIe, could the lack of endianness conversions cause issues on
Big-Endian hosts?

PCIe endpoints use strictly little-endian DMA descriptors. However, the dri=
ver
defines descriptor fields (like status and dataptr in struct fdma_db) as
native u64 and accesses them using native bitwise macros.=20

If this code runs on a Big-Endian architecture with the PCIe device, will t=
he
CPU read and write the status word in Big-Endian, causing the Little-Endian
hardware to interpret it incorrectly and fail?

[Severity: High]
This is a pre-existing issue, but is there a missing dma_wmb() when appendi=
ng
new DMA descriptors to an active ring?

When lan966x_fdma_napi_poll() allocates new pages, it calls fdma_dcb_add()
which initializes the new descriptor's contents and then updates the previo=
us
descriptor's nextptr to link it.

There doesn't appear to be a dma_wmb() executed between writing the new
descriptor's status/data pointers and updating the previous descriptor's
nextptr. Without this barrier, could the CPU reorder the memory writes,
allowing the hardware DMA engine to follow the updated nextptr and read the
new descriptor before its data and status fields are fully written to memor=
y?

>  	struct lan966x *lan966x =3D container_of(napi, struct lan966x, napi);
>  	struct lan966x_rx *rx =3D &lan966x->rx;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-lan966x-pc=
i-fdma-v5-0-ca56197ae05b@microchip.com?part=3D5
