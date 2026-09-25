Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4824D9F9C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366352; cv=none; b=GPvFxbiYNZ506b6SM2lUUpq9iBSZLPfjrLLBpVe3MKKBIWxh6x9F9x3CJ7+SSRa3N2Fdn9fxqpJvmLEf4CT2AcBGXmuCx/cG4nJrO5fETmD7CiIZ58KfY7Dj4FPASXbCq1E7AX0NKFz4TQa3vH+D3u5xIxoG5Ngx37nEO16wZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366352; c=relaxed/simple;
	bh=rqnfz8R7nkD4RV1WbE8ru95EskJJ4cdcWv/JbHczZ5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPnRxjFv3wHxBXWd3IqkKO64/kyQYyYjuY5IGsUUGNAykdcfvcTgcRF20IVww5Kfvhk/djJ0Q0aATRS9VwmIdJuU73s5R5rDIKvjwzpOLzWQmQV6zIhoPYFjtcEsNbxqfOvYExI5+58qIYPusumrpMQ0Ka+Gc1NqDd9UV1SQfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvUkuR16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvUkuR16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70581F0089D;
	Fri, 25 Sep 2026 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366350;
	bh=Sa905oWtdWOgdpggtKkIhJVmlV+MEI/USaL400D765Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvUkuR163bJ7OQldibUt34t2Cpsf6ViE/IEtFiOv2/M2EpRPiYILotCqpdcqJUQs3
	 zdLs1YfwvUlqpu0FSp4SSvFWzm/CKyzh3KC+FLYOWrpFUkKNtLIEprTVmOo+V5Xd4M
	 hymHJ2J6qy/XCEbUF/3bUfLPTv+bhYwrmCwv34mnDansdAnfzdzbm/j8ZZZv7Z+QPh
	 J5YZK9podzr0pwLVrSnrvnQvUCPfimtPhpKGfs/KYGDBLq7Y3tetsfOcYNsHhD2bQA
	 rjs1bTeopc8vM7K0Qrb9zHWH73YU/qMm3vn9t2+r9JT9EDRTo9HbOFZZNIoV8JktTy
	 ng7zX1py0J/ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 10/15] net: lan966x: add shutdown callback
 to stop the FDMA on reboot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-lan966x-pci-fdma-v8-10-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
 <20260924-lan966x-pci-fdma-v8-10-201c7b707d8b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:59:10 +0000
Message-Id: <20260925195910.A70581F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: lan966x: missing stats_work cancellation in shutdown causes r=
eboot hang
--

commit 2e6f47e0410ffe79c3ff982d925010362cdb3723
Author: Daniel Machon <daniel.machon@microchip.com>
net: lan966x: add shutdown callback to stop the FDMA on reboot

This commit adds a shutdown callback to properly quiesce the lan966x PCIe
endpoint during a host reboot. It stops FDMA channels, disables interrupts,
and unmaps ATU windows to prevent the hardware from continuing to assert
INTx or access host memory across restarts.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 259d81e759076..024ce9f9916c7 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
[ ... ]
> @@ -1324,9 +1324,65 @@ static void lan966x_remove(struct platform_device =
*pdev)
[ ... ]
> +static void lan966x_shutdown(struct platform_device *pdev)
> +{
> +	struct lan966x *lan966x =3D platform_get_drvdata(pdev);
> +
> +	/* As a PCIe endpoint the switch is not reset by the host reboot, so it
> +	 * has to be quiesced here:
> +	 *
> +	 *   Free the irqs and mask the sources: no source can assert INTx.
> +	 *   Disable NAPI: the teardown must not race a poll.
> +	 *   Stop and detach the netdevs: drains xmit, closes ndo_open and MTU.
> +	 *   Stop the FDMA channels: waits for the engine to go idle.
> +	 *   Unmap the ATU windows: revokes the engine's access to host memory.
> +	 */
> +	if (!lan966x_is_pci(lan966x))
> +		return;
> +

[Severity: High]
Does this code leave the stats_work delayed work running after the PCIe
endpoint is disabled?

When the system reboots, the new lan966x_shutdown() callback is executed to
quiesce the hardware. The PCI core subsequently disables the endpoint, but =
if
the stats_work background task fires and calls lan966x_stats_update(), it
will read from the disabled hardware via MMIO.

Accessing memory-mapped PCI registers after the PCI link or memory space has
been disabled typically results in a completion timeout or Unsupported
Request. This escalates to a PCIe AER fault or SError (NMI), panicking the
kernel and hanging the reboot process.

Unlike lan966x_remove(), which explicitly calls
cancel_delayed_work_sync(&lan966x->stats_work), lan966x_shutdown() appears
to omit this cancellation. Could the delayed work fire during reboot after
this shutdown path executes?

> +	if (lan966x->xtr_irq > 0)
> +		devm_free_irq(lan966x->dev, lan966x->xtr_irq, lan966x);
> +	if (lan966x->ana_irq > 0)
> +		devm_free_irq(lan966x->dev, lan966x->ana_irq, lan966x);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-lan966x-pc=
i-fdma-v8-0-201c7b707d8b@microchip.com?part=3D10
