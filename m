Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55237D10F
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468207; cv=none; b=moxiUqcdsMSgupRJ91cS+SRiI4p9owu9dbDGPGlr/GRuBrb4sQIgnyhJRtv36wgON6IDRkMLT5PUNqTldGwGB5gjK0wE/AwED5vBXg0BzW/dg5XxkpNlEzbLcz5PgnrggvjHxYRWLwg8H9vXe3HQlWuWCjYD5aec6FkD1BA/gFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468207; c=relaxed/simple;
	bh=MqACZ3UvRsS38TdXxtJ7z/d7kU3NCyY7ls2K40pGjk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WDvXM3ex60zjFI4uin5Ln7BkAJlQSTvsGHHFM3TJZacRRcdVQp55jmCY2q+CYo1iczocbDawCffCYk2PYM0ArZ94FVYosE56fohakPKPoMbh3cONCYdKUv2+WYYQVFSlfpWzDc89LDUTWyeH8OX7RkNHYFr0a2Dg02feTLwc/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/gffVjR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/gffVjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F98FC19425;
	Wed, 29 Apr 2026 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468207;
	bh=MqACZ3UvRsS38TdXxtJ7z/d7kU3NCyY7ls2K40pGjk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=U/gffVjROs7VMN9MhDGvAdB+uatcSBQxF3/WrFjKxiDATDmLPRjywrrvTANCUsGWk
	 fHVaiJH3Itm8hVsuXSLL8gYpU8rtmgOiWBkRAUTMjOzInvX4p+BbQP2Q7Re2JK4F+h
	 LMBex2+O2qtPxnWOTOW+6YdDo0MrVB49y8Cumla5c1Jt4NVlTMxdoMYPk8NsnolvP0
	 so7JIbH46msqaOz5RHrtAnR8cR+dAO+BCnw+4sXHGOsbTf/4UmXIYsHyKf9V7JBlyE
	 tpjwsm++Jy4cU1JAU5YLrOrZPeWL/p2ULywNdbf/4uGaW2yJA3/eYEBQUCmtpQt0HF
	 GI6z2cr6lz94Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 10/13] net: lan966x: add PCIe FDMA MTU
 change support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-lan966x-pci-fdma-v2-10-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-10-d3ec66e06202@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:10:06 +0000
Message-Id: <20260429131007.3F98FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NAPI is enabled after unmasking hardware interrupts, causing a rac=
e condition that permanently stalls the RX/TX queues.
--

commit 1f509ad580a86a49efbb1d85d8112806e4ae3d36
Author: Daniel Machon <daniel.machon@microchip.com>
net: lan966x: add PCIe FDMA MTU change support

This commit adds MTU change support for the PCIe FDMA path. When the MTU
changes, contiguous ATU-mapped RX and TX buffers are reallocated with the
new size, or restored to the old ones on failure.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index bda9679a03e1..61a62dbcc313 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -306,9 +311,154 @@ static int lan966x_fdma_pci_init(struct lan966x *la=
n966x)
>  	return 0;
>  }
> =20
[ ... ]
> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
[ ... ]
> +	/* Free and unmap old memory. */
> +	fdma_free_coherent_and_unmap(lan966x->dev, &rx_fdma_old);
> +	fdma_free_coherent_and_unmap(lan966x->dev, &tx_fdma_old);
> +
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +	napi_enable(&lan966x->napi);

Is there a race condition here between unmasking the hardware interrupts and
enabling NAPI?

lan966x_fdma_rx_start() unmasks hardware interrupts for the RX channel. If =
an
interrupt fires immediately after this call but before napi_enable() execut=
es,
the IRQ handler will run, mask the interrupt in hardware, and call
napi_schedule().

Because napi_enable() hasn't been called yet, the NAPI state is still
disabled, so napi_schedule_prep() will fail and NAPI won't be scheduled. On=
ce
napi_enable() finally runs, the poll schedule is already lost and the hardw=
are
interrupt remains permanently masked, stalling the queues.

Should napi_enable() be called before lan966x_fdma_rx_start() to ensure any
immediate interrupts are properly scheduled?

> +
> +	return err;
> +restore:
> +
> +	/* No new buffers are allocated at this point. Use the old buffers,
> +	 * but reset them before starting the FDMA again.
> +	 */
> +
> +	memcpy(&lan966x->tx.fdma, &tx_fdma_old, sizeof(struct fdma));
> +	memcpy(&lan966x->rx.fdma, &rx_fdma_old, sizeof(struct fdma));
> +
> +	lan966x->rx.max_mtu =3D old_mtu;
> +
> +	lan966x_fdma_pci_reset_mem(lan966x);
> +
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +	napi_enable(&lan966x->napi);

This same sequence appears here in the restore path. Does it have the same
potential issue with missed interrupts?

> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-lan966x-pc=
i-fdma-v2-0-d3ec66e06202@microchip.com?part=3D10
