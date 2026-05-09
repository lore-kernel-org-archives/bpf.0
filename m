Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCA38BF61
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315241; cv=none; b=TV5I8Z1B25rLsXpmYNou8ke0ol/tta49WyqsQ39mneiYUEjHY0UoeczBl6O6EitG4n5lHu0M0OU+QDXJ76IpBLwc6FLklKo1GjxMYLufYcbp4R5tMUfWLb8+00UYuvQMFeNe7hrYFMHw76PPyLbZvB0Fh3FNw8gmKP7kytPvXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315241; c=relaxed/simple;
	bh=8UIjzFXhYe/emk4Junehx/+4VqmOGq0LiHLzNO4FUHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARW7KiDcx8g2BClU+i5n08BBiDoIS86LBtpvdGgOKq+ML6kkIcb8Wd2itKjFQnWDdqAqO3q2XI9diHVgXjtI3Br9vvro6haMYh60O/pn0fhbMvLp3OnkoJ3yVmgRAIA0rg/gD36ZMepduRZ8jsbVaoBH4zTJU6+n2Iws+PmqZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNhyc7iL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNhyc7iL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90866C2BCB4;
	Sat,  9 May 2026 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315241;
	bh=8UIjzFXhYe/emk4Junehx/+4VqmOGq0LiHLzNO4FUHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WNhyc7iLy5NkTAf7nEt7U8cvpRgTqkQJb/f2SINXRf75Lr92wikRjbNDhbsft4qCG
	 pvq9VqKFBAbl4QE0vhGrWORhVote7RIV6DUtoo73WSC26gIcmSTM7LfypaK606tFYk
	 YnATT+cS1xkKHm2vxxYlOURyBLRb2f7j87Ns9pFjbc6GUdcoPsrG2olFYlJtQ2Gtlx
	 2z+NV5Ez9F9VZe/kLhghEh0UH/yyoTPHwr0BNnZUo8SST9gEk1PaL5jwzNzXKZ1ncd
	 UltAY2DeDfqF4w/2WBiPQl3b2xk0aH0Mu504DtRGa4wZzf0GN7bhiBwnY0etIXe1rd
	 mbOfMoTxYutQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 11/13] net: lan966x: add PCIe FDMA XDP
 support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508-lan966x-pci-fdma-v4-11-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-11-14e0c89d8d63@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:27:21 +0000
Message-Id: <20260509082721.90866C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NAPI poll loop exits prematurely on SKB allocation failure or FDMA=
 error, causing permanent RX queue stalls.
--

commit 2fc7864e7fb714463211e299fb04e9b91f05d012
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA XDP support

This commit adds XDP support for the PCIe FDMA path. The implementation
operates on contiguous ATU-mapped buffers with memcpy-based XDP_TX, unlike
the platform path which uses page_pool.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 0568251a95d92..cf3d3afbcc8a4 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> @@ -282,14 +392,26 @@ static int lan966x_fdma_pci_napi_poll(struct napi_s=
truct *napi, int weight)
>  		/* Order DONE read before DCB/frame reads below. */
>  		dma_rmb();
>  		counter++;
> -		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> +		switch (lan966x_fdma_pci_rx_check_frame(rx,
> +							&src_port,
> +							&data,
> +							&data_len)) {
>  		case FDMA_PASS:
>  			break;
>  		case FDMA_ERROR:
>  			fdma_dcb_advance(fdma);
>  			goto allocate_new;

This existing code jumps to allocate_new when encountering an error. If the=
re
are still frames pending in the hardware queue, could breaking out of the l=
oop
early leave NAPI completed while the hardware has already generated an
interrupt for the remaining frames?

Since the driver's interrupt handler has likely already cleared the interru=
pt
status bit, and hardware might only set it on new frame completion, could
this lead to a permanent RX queue stall if the queue is completely full?

> +		case FDMA_TX:
> +			fdma_dcb_advance(fdma);
> +			continue;
> +		case FDMA_DROP:
> +			fdma_dcb_advance(fdma);
> +			continue;

Since these new XDP actions use continue, should FDMA_ERROR be updated
to drop the packet and continue as well, rather than aborting the poll loop?

>  		}
> -		skb =3D lan966x_fdma_pci_rx_get_frame(rx, src_port);
> +		skb =3D lan966x_fdma_pci_rx_get_frame(rx,
> +						    src_port,
> +						    data,
> +						    data_len);
>  		fdma_dcb_advance(fdma);
>  		if (!skb)
>  			goto allocate_new;

Similarly, if SKB allocation fails here, could jumping to allocate_new
abandon remaining pending frames and cause the same RX queue stall?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-lan966x-pc=
i-fdma-v4-0-14e0c89d8d63@microchip.com?part=3D11
