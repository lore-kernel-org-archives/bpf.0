Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D13FADEE
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468208; cv=none; b=QF0kjbAeS1SV/X5NRqqV1lyhypQYfhrmPbCKDadxSwnRlVzsJA6c94BGhec+kdVQN+FEdoy5UOsq6LFXRooi4RBcXcf39s9ca1xVt37yTLZudVdxWpC8Kv/WYi0RAg/8j5qXT8ny+bpProyzaqGm6/HlY2wHG8xPyKzYUx2ymqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468208; c=relaxed/simple;
	bh=dWuRhp0+/Y6Fj2tGmnYXSum0C/nX5rF9WuqqsXUD8nY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XmmCRXtqtBf2yjv+653hmN+KCa1hFNLj7ZYM4sZmCDtbFtakWDmLCkVpuHSDyooJqEJJ5XJZLgn/dqlp8yRhEjBu0rIOu3LcAVoH4lLVL8WTIZAmyc47PZnmzRUWmM8uqm1TP5E2op9qYW0qdX1KRgS8LFhG5AtoduBUM7h++Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q83LsjRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q83LsjRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DACC19425;
	Wed, 29 Apr 2026 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468208;
	bh=dWuRhp0+/Y6Fj2tGmnYXSum0C/nX5rF9WuqqsXUD8nY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q83LsjRZipcaUc2vkCRiDT5TaF/vOuzVnKUWSsEQJ+qRnIeEtZiqwUUvu1pYowh5O
	 9MExEoeEuka65kFMNGW49B8jnzKxykez69An3l0wv+KCwGaV0mnf5aHn619A+tV/D8
	 AGJVJ2hHSgi4zLq0RHmYnMd2I6qSFwh7fmxnB4BMIxV27IFjEo9UD4PlMHINjXijyY
	 SzITN/Hu5kJhagytR2FvfYXpdy9dJY4xqQKcK+PynLe/Sc0/pVRkKjQ9JKJvS44zcW
	 fFwkVcv1cRuKj4+1rsxDgdk1+yUHSdiVEX5xENhsRMaYDF2ObTeerXOROt69yNp4Lf
	 4PwnZNzTyNEhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 11/13] net: lan966x: add PCIe FDMA XDP
 support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-lan966x-pci-fdma-v2-11-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-11-d3ec66e06202@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:10:07 +0000
Message-Id: <20260429131008.73DACC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) race condition in XDP pr=
ogram execution causes NULL pointer dereference.
- [Critical] Double addition of `XDP_PACKET_HEADROOM` misaligns DMA/virtual=
 pointers, causing buffer overruns and memory corruption.
- [High] Hardware FCS is incorrectly exposed to XDP payload and causes data=
 truncation on XDP_PASS.
- [High] Integer underflow on runt frames leads to out-of-bounds memory acc=
esses.
- [High] Discrepancy in FCS length handling between TX paths causes informa=
tion leak or payload corruption.
- [Medium] `lan966x_fdma_pci_xmit_xdpf()` fails to pad short frames to mini=
mum Ethernet length.
--

commit 99263814b4c5264a0eb9e0faa0f7f6b6f10d121f
Author: Daniel Machon <daniel.machon@microchip.com>
Subject: net: lan966x: add PCIe FDMA XDP support

Add XDP support for the PCIe FDMA path. The implementation operates on
contiguous ATU-mapped buffers with memcpy-based XDP_TX, unlike the
platform path which uses page_pool.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 61a62dbcc313..8d867b7edd39 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -15,7 +17,8 @@ static int lan966x_fdma_pci_dataptr_cb(struct fdma *fdm=
a, int dcb, int db,
> =20
>  	addr =3D fdma_dataptr_dma_addr_contiguous(fdma, dcb, db);
> =20
> -	*dataptr =3D fdma_pci_atu_translate_addr(fdma->atu_region, addr);
> +	*dataptr =3D fdma_pci_atu_translate_addr(fdma->atu_region, addr) +
> +		   XDP_PACKET_HEADROOM;

Is it possible that XDP_PACKET_HEADROOM is being added twice here? Looking =
at
fdma_dataptr_dma_addr_contiguous(), the headroom is already implicitly adde=
d:

fdma_api.h:fdma_dataptr_dma_addr_contiguous() {
    return fdma->dma + ... + XDP_PACKET_HEADROOM;
}

Could this double addition push the pointers past the allocated db_size
boundary for MTU-sized packets and corrupt adjacent memory?

[ ... ]
> +static int lan966x_fdma_pci_xmit_xdpf(struct lan966x_port *port,
> +				      void *ptr, u32 len)
> +{
[ ... ]
> +	virt_addr =3D fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0) +
> +		    XDP_PACKET_HEADROOM;

Would this also suffer from the same double XDP_PACKET_HEADROOM addition,
since fdma_dataptr_virt_addr_contiguous() likely includes it?

[ ... ]
> +	fdma_dcb_add(fdma,
> +		     next_to_use,
> +		     0,
> +		     FDMA_DCB_STATUS_INTR |
> +		     FDMA_DCB_STATUS_SOF |
> +		     FDMA_DCB_STATUS_EOF |
> +		     FDMA_DCB_STATUS_BLOCKO(0) |
> +		     FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + len));

If len from the XDP program is less than ETH_ZLEN, will the hardware drop t=
he
runt frame or transmit it with garbage padding? The standard
lan966x_fdma_pci_xmit() path explicitly pads short frames to ETH_ZLEN.

Also, does ETH_FCS_LEN need to be included in the block length here?
lan966x_fdma_pci_xmit() includes it. If the hardware expects the MAC FCS sp=
ace
to be included in the block length, could omitting it here cause the MAC to
replace the last 4 bytes of the XDP payload with the FCS?

[ ... ]
> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *s=
rc_port,
> +					   void **data, u32 *data_len)
>  {
[ ... ]
>  	virt_addr =3D fdma_dataptr_virt_addr_contiguous(fdma,
>  						      fdma->dcb_index,
>  						      fdma->db_index);
> +	ifh =3D virt_addr + XDP_PACKET_HEADROOM;

This looks like a third instance of double-adding XDP_PACKET_HEADROOM.

[ ... ]
> +	/* Present the Ethernet frame (no IFH); may be overridden by XDP. */
> +	*data =3D ifh + IFH_LEN_BYTES;
> +	*data_len =3D FDMA_DCB_STATUS_BLOCKL(db->status) - IFH_LEN_BYTES;

What happens if the hardware returns a runt or corrupted frame where
FDMA_DCB_STATUS_BLOCKL is less than IFH_LEN_BYTES (28)? Will this unsigned
subtraction underflow to a large value and cause out-of-bounds memory acces=
ses
during XDP processing?

Additionally, if the block length includes the Ethernet FCS, does this pass
the FCS into the XDP program as part of the packet payload?

> +	if (!lan966x_xdp_port_present(port))
> +		return FDMA_PASS;
> +
> +	return lan966x_xdp_pci_run(port, virt_addr, *data_len, data, data_len);
>  }

Can a concurrent XDP program detach cause a NULL pointer dereference here?

lan966x_xdp_port_present() checks if port->xdp_prog is set:

lan966x_main.h:lan966x_xdp_port_present() {
    return !!port->xdp_prog;
}

If it returns true, lan966x_xdp_pci_run() reads the pointer a second time:

lan966x_fdma_pci.c:lan966x_xdp_pci_run() {
    struct bpf_prog *xdp_prog =3D port->xdp_prog;
    ...
    act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
}

If lan966x_xdp_setup() detaches the program via xchg(&port->xdp_prog, NULL)
between these two reads, could xdp_prog be NULL when passed to
bpf_prog_run_xdp()? Should the pointer be read exactly once using READ_ONCE=
()
or rcu_dereference() to ensure it remains valid?

[ ... ]
>  static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *=
rx,
> -						     u64 src_port)
> +						     u64 src_port, void *data,
> +						     u32 data_len)
>  {
[ ... ]
>  	if (likely(!(skb->dev->features & NETIF_F_RXFCS)))
>  		skb_trim(skb, skb->len - ETH_FCS_LEN);

If the XDP program modifies the packet length (for instance, stripping an
encapsulation header) and returns XDP_PASS, will subtracting a hardcoded
ETH_FCS_LEN from the newly modified length blindly truncate legitimate payl=
oad
data?

[ ... ]
> @@ -180,9 +278,10 @@ static int lan966x_fdma_pci_xmit(struct sk_buff *skb=
, __be32 *ifh,
> =20
>  	skb_tx_timestamp(skb);
> =20
> -	virt_addr =3D fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
> +	virt_addr =3D fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0) +
> +		    XDP_PACKET_HEADROOM;

This appears to be a fourth instance where XDP_PACKET_HEADROOM is added on =
top
of a pointer that already includes it.

Also, further down in this function, FDMA_DCB_STATUS_BLOCKL includes
ETH_FCS_LEN, unlike lan966x_fdma_pci_xmit_xdpf(). If the hardware actually
appends the FCS automatically and doesn't expect ETH_FCS_LEN to be part of =
the
block length space, will adding it here transmit uninitialized buffer memory
over the network?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-lan966x-pc=
i-fdma-v2-0-d3ec66e06202@microchip.com?part=3D11
