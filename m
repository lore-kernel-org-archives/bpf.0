Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BF394470
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468203; cv=none; b=rixJ4Ejoqa4eRhd+hkmy06J0UrsUmbEx+ilgeDUneGxBM69Ampfk44Ew7R3ATplFBqnbha0SedKYebrN1auBOMbVb+edFHTfNKRPc4a0nvvGISKN2BDOUkRbK6Wt/kdZLoU+m3wdvlcU88SGnpkhwobbe5czPrJJT+p1e5ArH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468203; c=relaxed/simple;
	bh=QxGVqbMuXZD+3zhLKhy0ex2AGmaCtiHRrmqk/7PN7cM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0HEbqY38CrHf6VpIxtJA6Bu/nmI3DqpUnoOM+Z/yoovkv+2+jlq24ZQ3UR5rEnbuX+56xyEA3rCnCtxCEkeY47yQ4o7B3hSmtSeK2WdvHv+hizaoPpXYC8JRGjSEPnYOSx7pV7TkJF7h7+TqgrUl5xawfpzosMsDBxxfFlDT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUOAVVUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUOAVVUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B3BC19425;
	Wed, 29 Apr 2026 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468203;
	bh=QxGVqbMuXZD+3zhLKhy0ex2AGmaCtiHRrmqk/7PN7cM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IUOAVVUi7iPVjG42XIxSRIBUi+0mDasU/Zcc5mXKqPzLqwLUSIG9P7fY6kJMGedkq
	 9RsaTqg6dqbFZklIVfZtU7tVX6iojYINBJKA/mwzY0mBqTgPYZiBE9h53gpb/xUiMg
	 7A6ULRSxpPSNJGAdrD1Z9X54GOZOXEBz/Swo+czn0cZQSoz6dBLkGi92RzLEuTpcLN
	 +UedsYPZKj6GEewN8k1t8YNf2UeY2HwQCDSbLp8D0ZMoixam5JcCdGvKWhn/Su9yNi
	 AdZUXNA367bem5z4wl3TdidokVYRMJrJkHl6/q+auludCz+vBAzHo1gdxyXtCS7aNb
	 Rj1v6UtHcWltg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 04/13] net: lan966x: add FDMA LLP register
 write helper
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-lan966x-pci-fdma-v2-4-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-4-d3ec66e06202@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:10:02 +0000
Message-Id: <20260429131002.D9B3BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing Hardware Initialization in Fallback Path
- [High] Ignored return value of `fdma_dcbs_init()` leads to memory corrupt=
ion
- [High] Stale destroyed `page_pool` left in XDP RX queues leading to UAF /=
 Double Free
--

commit e1cc739c153cef02ae9d3a24aa4e6dc773ba0fd8
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA LLP register write helper

This commit moves the LLP register writes from the channel start/activate
functions into the allocation functions. It also introduces a shared
lan966x_fdma_llp_configure() helper to write the LLP registers.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc0..6c5761e886d4 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c

[ ... ]

> @@ -127,6 +134,9 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *r=
x)
>  	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
>  		       FDMA_DCB_STATUS_INTR);

This is existing code, but could the error recovery path here lead to a
use-after-free or double free?

If fdma_alloc_coherent() fails just prior to this, the newly created
page_pool is destroyed. In the lan966x_fdma_reload() fallback path, the old
page_pool pointer is restored in the lan966x->rx structure, but it is never
re-registered with xdp_rxq_info_reg_mem_model().

The xdp_rxq structures will continue holding the mem.id of the destroyed
page_pool. When the queues are eventually torn down, will
xdp_rxq_info_unreg_mem_model() attempt to free the destroyed page_pool?

Also, is it safe to ignore the return value of fdma_dcbs_init() here?

If fdma_dcbs_init() invokes allocation callbacks that fail with -ENOMEM, the
remaining DMA descriptors could be left uninitialized and retain a dataptr
of 0.

By ignoring the failure, won't the driver falsely assume initialization
succeeded and enable hardware DMA, potentially causing the DMA engine to
write incoming frames to physical address 0?

> =20
> +	lan966x_fdma_llp_configure(lan966x, (u64)fdma->dma,
> +				   fdma->channel_id);
> +
>  	return 0;
>  }
> =20
> @@ -136,14 +146,6 @@ static void lan966x_fdma_rx_start(struct lan966x_rx =
*rx)
>  	struct fdma *fdma =3D &rx->fdma;
>  	u32 mask;
> =20
> -	/* When activating a channel, first is required to write the first DCB
> -	 * address and then to activate it
> -	 */
> -	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP(fdma->channel_id));
> -	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
> -	       FDMA_DCB_LLP1(fdma->channel_id));
> -

By moving the LLP register writes out of lan966x_fdma_rx_start(), does this
break the fallback path in lan966x_fdma_reload() used for the AMBA interfac=
e?

If lan966x_fdma_rx_alloc() fails due to memory pressure, the driver jumps to
the restore label, copies back the old RX state, and calls
lan966x_fdma_rx_start() to re-activate the channel.

Because lan966x_fdma_rx_start() no longer writes the LLP register, and the
channel was previously disabled via a hardware DB_DISCARD, will the hardware
be re-activated without its base descriptor pointer configured, leading to
the DMA fetching from a stale or invalid address?

>  	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
>  	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
>  	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |

[ ... ]

> @@ -214,6 +216,9 @@ static int lan966x_fdma_tx_alloc(struct lan966x_tx *t=
x)
> =20
>  	fdma_dcbs_init(fdma, 0, 0);

Similar to the RX side, this is existing code, but does ignoring the return
value of fdma_dcbs_init() here also risk DMA hardware fetching from an
invalid descriptor if allocation fails?

> =20
> +	lan966x_fdma_llp_configure(lan966x, (u64)fdma->dma,
> +				   fdma->channel_id);
> +
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-lan966x-pc=
i-fdma-v2-0-d3ec66e06202@microchip.com?part=3D4
