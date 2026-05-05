Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45747DD67
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005376; cv=none; b=M6FJIXhEAr1sT8zc2HTB9god6lQi2Z4t9byjzIvUP5J/77ABnAV/DjadyGhx1RQWsc1Qc+YZSafZx6iUZ/LpfozBmRc0X1QN56cbfF2y+PEciqV9MSHlIS/NLwpV/lQ6XnAODITuFf5gEqeiEreJuau/HyCt6kOg+nUJ08Jn8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005376; c=relaxed/simple;
	bh=fIvhx9DVa86xZW+DrCmgn/10oq9gS1M2q5na7TU2CE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HvXRAj5fRdEEt3x4/wJuyFov0f/P/3hxZ8ccGZao81+sQK35wZ7DNM74Uj3d+bkzY+f5YynJfY9x6EMFs3KiAVfGDjegrbBkYbWlNCg6ErhDlto2GOiy7vR0xTfGwA1eCWfrcRXYpZlYHEsKfhZGxGfbvrsBUm6eKKrmlgcgbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8rI4DhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8rI4DhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A5C2BCB4;
	Tue,  5 May 2026 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005376;
	bh=fIvhx9DVa86xZW+DrCmgn/10oq9gS1M2q5na7TU2CE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=r8rI4DhYfyD4w7cxYPEwvUk4Wd1sU9vhND+gEDBkLHwvoTBCtn1akjUAmytJmjiid
	 AJJzjDRMJUcF7zTqqG8eS5r0HxxO0DddGaZ5j7ChhiW6OPm1nhR+hct0BRwMKtyoPs
	 biwxG/qqCEkML6yw0DZVUqELDyuH2PSAFHbKfHNX5IQhPYD76mS4sHd+zMp++fVq/e
	 zdjf2chWtFWYqnihJPm2OXloAEQdGjSZpLHYO8mH9dG3OEOHOL/Y+mAPDyQdmWYrBm
	 8Oi6KORTs2L2vL1rrldd7RYgj7bFwb831H33oPuxWQiPzv9T08nsAv84J2bcqZ/Q55
	 7B+hUmlQC0oCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 04/13] net: lan966x: add FDMA LLP register
 write helper
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-4-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-4-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:55 +0000
Message-Id: <20260505182255.D58A5C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing FDMA LLP register initialization in MTU reload error path.
- [High] Use-After-Free of XDP page pool on MTU change failure.
--

commit ae2cbe38c82a69007425f5328bd647889e5a3f50
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA LLP register write helper

The FDMA Link List Pointer (LLP) register points to the first DCB in the
chain and must be written before the channel is activated. This tells
the FDMA engine where to begin DMA transfers. Move the LLP register writes
from the channel start/activate functions into the allocation functions.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc09..6c5761e886d47 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
[ ... ]
> @@ -127,6 +134,9 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *r=
x)
>  	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
>  		       FDMA_DCB_STATUS_INTR);
> =20
> +	lan966x_fdma_llp_configure(lan966x, (u64)fdma->dma,
> +				   fdma->channel_id);
> +
>  	return 0;
>  }

This isn't a bug introduced by this patch, but there seems to be a pre-exis=
ting
flaw in the MTU reload error path related to how lan966x_fdma_rx_alloc() ha=
ndles
the XDP page pool.

During lan966x_fdma_reload(), lan966x_fdma_rx_alloc() first calls
lan966x_fdma_rx_alloc_page_pool(), which unregisters the old XDP memory mod=
el
and registers the newly allocated page pool.

If fdma_alloc_coherent() subsequently fails, the error path destroys the
new page pool and lan966x_fdma_reload() jumps to the restore block:

lan966x_fdma_reload() {
    ...
	err =3D lan966x_fdma_rx_alloc(&lan966x->rx);
	if (err)
		goto restore;
    ...
restore:
	lan966x->rx.page_pool =3D page_pool;
	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
	lan966x_fdma_rx_start(&lan966x->rx);
}

Since the old page pool is never re-registered to port->xdp_rxq, does this
leave the XDP subsystem holding a dangling pointer to the destroyed new page
pool, potentially causing a use-after-free when incoming packets attempt to
manage or return pages?

[ ... ]
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
>  	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
>  	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
>  	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |

By removing the LLP initialization from lan966x_fdma_rx_start(), what happe=
ns in
the MTU reload error path?

If an MTU reallocation fails (e.g., due to memory pressure) in
lan966x_fdma_reload(), the code jumps to the restore block, copies back the=
 old
FDMA state, and restarts the channel via lan966x_fdma_rx_start():

lan966x_fdma_reload() {
    ...
restore:
	lan966x->rx.page_pool =3D page_pool;
	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
	lan966x_fdma_rx_start(&lan966x->rx);
    ...
}

Because lan966x_fdma_rx_start() no longer writes the FDMA_DCB_LLP register,
will the hardware channel be reactivated without its DMA pointer being reset
to the beginning of the old ring (fdma_rx_old.dma)?

Could this cause the DMA engine to fetch from a stale or undefined address
and break RX functionality after a failed MTU change? Note that this issue
does not appear to be fixed by subsequent patches in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D4
