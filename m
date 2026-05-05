Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600B4A3411
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005380; cv=none; b=Oy00IUFOF4qvyI+Vk/FC4CxbFP3emywYzzkRjKWN0raowlGGG0yjTfr3cGxXxkY3zwMuJ29wxoM4U1uVqntKvFLgF4vFIwBCGRajaHWRRGFaUNf9hm1af+eCXDDMSTImrv0WFLngnGGvjsGaKaeiJk9ZYKNmvlxTsCR/nvVJA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005380; c=relaxed/simple;
	bh=xIUCIC/OIKPrv3d6jm6ew4/gv0XPiWxpARBX4DBfuL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bVjhB6vsVu3YJx8dZ4s+mCi56V/s2NvPk+yZ7aeqjc2bEsUTCvYFyrkFvkSYZen/GKv89+ch6Phu65eG+5xKCKzxvovr3fvaEIwskeKsVKcr3PmAIZW+GLwZCToMjetGenTHRT9gZZEtW9g7/dZWzZ7pAwarBgY5dt9mm7XoF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWi27B2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWi27B2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EA4C2BCC7;
	Tue,  5 May 2026 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005380;
	bh=xIUCIC/OIKPrv3d6jm6ew4/gv0XPiWxpARBX4DBfuL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PWi27B2PEMpGYwpk/1e+wrXIfb5YiI0rOZkRHe+VY2hzc0BC5MUcyKPQc/GQgQzie
	 RbYMmOUhPWD4HFh9OVFX5Jx9l5RgoiUwNstJO0wM1RpIxTts/rnXVW8bgX6dtvVuaZ
	 jhuhSyhAClEBvqbeg2pFT3axrlXcNfxe1QE4zjcjsONOBO/lkvIo0bNUgXP1cGbzOR
	 DYt6UhvcG2SM5qqyQ8Fc6bFVADhukeXfajujo/Sk2KSS538Tvv8NfanZneH7x6TO7V
	 40KR36czg0LoEKixTKcUQLI90BD40Mjk/RNI3UNWLGC00CXlaTATnS7rargqtC0Sya
	 raF5cAnJ8Najg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 11/13] net: lan966x: add PCIe FDMA XDP
 support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-11-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-11-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:59 +0000
Message-Id: <20260505182300.50EA4C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Out-of-bounds memory access due to incorrect XDP `data_hard_st=
art` calculation.
--

commit a924fb52292b32258a27064e54f04210cd1ffa58
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA XDP support

This commit adds XDP support for the PCIe FDMA path. The implementation
operates on contiguous ATU-mapped buffers with memcpy-based XDP_TX, unlike
the platform path which uses page_pool.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 491ddc337760..48ed5aeb1aff 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -107,7 +109,118 @@ static bool lan966x_fdma_pci_tx_size_fits(struct fd=
ma *fdma, u32 len)
[ ... ]
> +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> +			       u32 data_len, void **xdp_data, u32 *xdp_len)
> +{
[ ... ]
> +	xdp_init_buff(&xdp, fdma->db_size, &port->xdp_rxq);
> +
> +	/* Headroom includes the IFH; BPF may grow into it via adjust_head.
> +	 * The IFH is rebuilt on XDP_TX and unread on XDP_PASS.
> +	 */
> +	xdp_prepare_buff(&xdp,
> +			 data - XDP_PACKET_HEADROOM,
> +			 XDP_PACKET_HEADROOM + IFH_LEN_BYTES,
> +			 data_len,
> +			 false);

Does this calculate an out-of-bounds pointer for the hard_start?

Looking at lan966x_fdma_pci_rx_check_frame(), the data parameter passed here
is virt_addr, which is retrieved via fdma_dataptr_virt_addr_contiguous().
This pointer represents the start of the DMA-mapped database block.

If data is the start of the allocated buffer, subtracting XDP_PACKET_HEADRO=
OM
would set xdp->data_hard_start to point 256 bytes before the allocated memo=
ry.

If an XDP program calls bpf_xdp_adjust_head() to prepend headers, could this
allow it to overwrite adjacent memory, such as the preceding DMA database
block or hardware DCB descriptors?

> +
> +	act =3D bpf_prog_run_xdp(xdp_prog, &xdp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D11
