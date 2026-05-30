Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD42773DE
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101878; cv=none; b=k6ycPjNiubI3dW0wjizK92fRf1H8KCkOuprC5tEBVqhyQvtrdy0dVPjWKTBeTV47+IG0OpHkWM7Kx3KlMmzdGHF29utsoC/lbtwy2j12yfzYzEHepdbi2yIzlGU2yFBVqBy6kLX+XfL00auMe59nKsr/VQtlXbw0/1cTb2tb95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101878; c=relaxed/simple;
	bh=MjQuBMSXVPTURdGUVdhWF+5e3aa31/UlwcfpBWzo/eQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ezbPHdw7rsGI6WEZkQnQh6dd3O01EzE0CHgiJx5+eqEyrb0l3y88sl7aNzcKR+OsasXf0tUTy+JyEJTcZTWjf+0ygpkWlOKR/LaV87z+RcvMkEEEK1ZlDT9/VgUzuzE2Wo9YkI9I+mycCu3zNM8RtvV1sBygazXx9fslGhS11M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clWB+9ZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clWB+9ZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC8A1F00893;
	Sat, 30 May 2026 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101877;
	bh=ydPwQAbI5dx36egKt+phySUNhpSXsvgVI3XN4Hlh/9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=clWB+9ZWibIQP5pXyD5LoC923xACMYwP6i/c66nx+r/4v88VYhY7gVzOg2DncF/k1
	 2iW1VrJ/KvohMuvwmqLrDepyYEPLO+lcxn4kf5EQyqmzqkZO4T2mKsxvoUau5SAGD9
	 RNJeJLxqPFejQahE5mMcPh0p6TYLry/A1NyTOmFXUzxxTptnSzEbDTNyoKzC370cWt
	 P+TSfh4n/xaLtO+/6V6R2U1hEkYeXrvL7AhY8cMKYeTB2RwiJlHF6aQzvWfOsV4kCC
	 FmmInydNWFBbCJ1R5cUkiDYenp8Wey2CkZkk2K4E0Ql6eKecQ+gaXkO19CbQ0EvdIv
	 ts+zzfV0OYTUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 04/13] net: lan966x: add FDMA LLP register
 write helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-lan966x-pci-fdma-v5-4-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-4-ca56197ae05b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:37 +0000
Message-Id: <20260530004437.4AC8A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Moving the LLP register configuration to the allocation function b=
reaks the MTU change error recovery path, leaving the RX channel reactivate=
d without a valid LLP.

Pre-existing issues:
- [Critical] The return value of `fdma_dcbs_init()` is ignored in `lan966x_=
fdma_rx_alloc()`, leading to partial initialization and potential memory co=
rruption.
- [Critical] Setting the PTP flag for the TX buffer after handing the DCB t=
o hardware creates a race condition with the TX completion handler.
- [High] The hardware and software DMA states become desynchronized during =
the MTU reload error path due to taking a stale snapshot of the FDMA state =
before stopping the traffic.
- [High] Missing `dma_wmb()` before updating the `nextptr` of the previous =
DCB in `__fdma_dcb_add()`.
--

commit 4390e4c62295adb12eb1d72e9557c5052040eb8a
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA LLP register write helper

This patch introduces a shared helper for configuring the FDMA Link List
Pointer (LLP) register and moves the LLP configuration from the channel
start/activate functions to the allocation functions. This change
prevents the shared start/activate path from overwriting ATU-translated
addresses with DMA addresses in the upcoming PCIe FDMA path.

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

[Severity: Critical]
This isn't a bug introduced by this patch, but is it safe to ignore the
return value of fdma_dcbs_init() here?

If fdma_dcbs_init() fails (e.g., due to page allocation failure in the
data pointer callback), it returns an error code, leaving subsequent
DCBs with uninitialized or zeroed data pointers. Because the return
value is ignored, could the driver incorrectly proceed to activate the
DMA ring, causing the hardware to attempt to DMA incoming packets into
physical address 0?

> +	lan966x_fdma_llp_configure(lan966x, (u64)fdma->dma,
> +				   fdma->channel_id);
> +
>  	return 0;
>  }

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

[Severity: High]
Does moving the LLP register configuration to the allocation function
break the MTU change error recovery path?

During an MTU reload failure, the driver restores the software state and
calls lan966x_fdma_rx_start(), which now fails to write the required
LLP register. Could this activate the hardware DMA channel without a
valid Link List Pointer, leading to DMA failures or hardware stalls?

[Severity: High]
This is a pre-existing issue, but does taking a stale snapshot of the
FDMA state before stopping the traffic cause the hardware and software
DMA states to become desynchronized during the MTU reload error path?

In lan966x_fdma_reload(), the software snapshot fdma_rx_old is taken
before NAPI and the hardware channel are disabled. If packets arrive in
this window, the hardware advances.

On allocation failure, restoring this stale snapshot rolls back the
software indices while the hardware's internal state remains advanced.
Could this permanently desynchronize the ring indices and cause ring
corruption?

>  	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
>  	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
>  	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |

[ ... ]

[Severity: High]
This is a pre-existing issue, but is there a missing dma_wmb() before
updating the nextptr of the previous DCB in __fdma_dcb_add()?

When appending a new DCB to a running TX ring in lan966x_fdma_xmit(),
the CPU updates the new DB's status and data pointers, and then updates
the nextptr of the previous DCB to link it. Without a dma_wmb() separating
these writes, could the CPU or compiler reorder them?

If the hardware polling the previous DCB's nextptr observes the new link
before the new DCB's contents are visible in memory, could this lead to
the hardware reading garbage descriptors?

[Severity: Critical]
This isn't a bug introduced by this patch, but does setting the PTP flag
for the TX buffer after handing the DCB to hardware create a race condition
with the TX completion handler?

In lan966x_fdma_xmit(), the DCB is submitted to the hardware via
__fdma_dcb_add() and lan966x_fdma_tx_start() before the software sets
next_dcb_buf->ptp =3D true.

If the hardware transmits the packet immediately and raises a completion
interrupt, could a concurrent NAPI poll process the completion, read the
stale ptp =3D=3D false state, and free the SKB? Could the submitting CPU th=
en
set the PTP flag on the already freed SKB, causing a use-after-free during
subsequent PTP timestamp processing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-lan966x-pc=
i-fdma-v5-0-ca56197ae05b@microchip.com?part=3D4
