Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51937448B9A
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366353; cv=none; b=Yj4rsnaZAjYZLELmdQ4dsO5F+gesBojz7ImH+CxokMyC/k/z1JcPWV/CqaWaEaTFyM1xWTwWT0+31AvrY5fVYDj7/5AqxDojg6moIxuQsKmyYqkMvnQZTlqqw83EulSAXIKgp+gVwMSrBE0McIgB6IipuKHnltWzG61Kl2RhWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366353; c=relaxed/simple;
	bh=4j//Lg8LIgMAkdLVu2Hc1bV8ssOmAf1iQfB5mrkq1fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iq/2xT+TQcurYpa2R3zpKkfQV3CXFv8dgko9BMMP+mi2omzwNkG6kbhwckve77J3UZLSYWr7Yklxb18QgdqKHVzZWOYkfhUNhiSPQLJDOhqIdgNYCuDmfW8vQ32fLxwakTVHr602xpaJODPzY5oP2MPFxL72o8niUcCHdxN7yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMWeTbBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMWeTbBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB771F00899;
	Fri, 25 Sep 2026 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366352;
	bh=UBHMRIatihNKQaqdK7fJHoy4EzmE5hIpu0VK+4987yI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMWeTbBmAlSBnuWm8dL+sGnSXNbL+TmrYLxcdiTQHlqshd4nJVltblD7kyNlN81RG
	 fgEdmaULTL6XSc83gAU9T0DqmWbyeaS9586uW0f81bQNIq7ajY7uoFESoVcK6KwU7s
	 r5js4hp6+JUJ8jWer1Xto0w/v6Yp+P1bvP72nDN7ArRCWvEmLKvhvKHaddPgBECe/D
	 7PGobbQHXOTCnf1S/271SqrmM0GI5ptbc/ZQeKWtZ8yoohyGl3xFTtlVqLE7twqIVm
	 HYYSLuNjSp83Uh7HTrSJI568/iCqYH0anl3ulXMeoCipEzFzaM3BlHZb2muimnVHwL
	 9eTHz1WqjeJBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 13/15] net: lan966x: add PCIe FDMA XDP
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-lan966x-pci-fdma-v8-13-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
 <20260924-lan966x-pci-fdma-v8-13-201c7b707d8b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:59:11 +0000
Message-Id: <20260925195912.0DB771F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: XDP program shrinking frame below ETH_HLEN causes OOB read in=
 eth_type_trans()
--

commit 65038b88aa7eb3b2b7d79cb17c606497fae0582c
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA XDP support

This commit adds XDP support for the PCIe FDMA path in the lan966x driver.
The implementation operates on contiguous ATU-mapped buffers with
memcpy-based XDP_TX, and updates the receive path to handle frame lengths
returned by the XDP program.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 7185e65dda435..216e9cbcd1580 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -136,7 +138,123 @@ static bool lan966x_fdma_pci_rx_size_fits(struct fd=
ma *fdma, u32 blockl)
[ ... ]
> +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> +			       u32 data_len, void **xdp_data, u32 *xdp_len)
> +{
[ ... ]
> +	act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
> +
> +	*xdp_data =3D xdp.data;
> +	*xdp_len =3D xdp.data_end - xdp.data;
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		return FDMA_PASS;

[Severity: High]
Does this code allow an XDP program to shrink the frame size below the
minimum Ethernet header size (ETH_HLEN)?

If the loaded XDP program shrinks the packet and returns XDP_PASS,
the modified length is accepted here and passed along to the driver's
receive handling without bounds checking to ensure it is at least ETH_HLEN.

[ ... ]
> @@ -168,38 +286,33 @@ static int lan966x_fdma_pci_rx_check_frame(struct l=
an966x_rx *rx, u64 *src_port)
[ ... ]
>  static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *=
rx,
> -						     u64 src_port)
> +						     u64 src_port, void *data,
> +						     u32 data_len)
>  {
[ ... ]
> -	memcpy(skb->data,
> -	       fdma_dataptr_virt_addr_contiguous(fdma,
> -						 fdma->dcb_index,
> -						 fdma->db_index),
> -						 data_len);
> +	memcpy(skb->data, data, data_len);
> =20
>  	skb_put(skb, data_len);
> =20
>  	skb->dev =3D lan966x->ports[src_port]->dev;
> -	skb_pull(skb, IFH_LEN_BYTES);
> -
> -	skb_trim(skb, skb->len - ETH_FCS_LEN);
> =20
>  	skb->protocol =3D eth_type_trans(skb, skb->dev);

[Severity: High]
If data_len was shrunk below ETH_HLEN by the XDP program, will this sequence
cause an out-of-bounds read and potential kernel crash?

eth_type_trans() unconditionally pulls ETH_HLEN bytes from the SKB. Passing
a truncated data_len < ETH_HLEN to skb_put() followed by eth_type_trans()
will read uninitialized memory and can corrupt skb boundaries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-lan966x-pc=
i-fdma-v8-0-201c7b707d8b@microchip.com?part=3D13
