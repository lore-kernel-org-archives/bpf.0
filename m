Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E24908BD;
	Thu, 10 Sep 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045558; cv=none; b=HYdFrrvwuuyflFw3QtSQ6hx/4WK0Zdsgzi97knVgeER+mQfEQGdiWg6XeY5+rP/QHPahTmerJ3fJn5wfGhsEbdt/zmTe9TT6g3Gmx/K4ehT/egp0GG8V6vZLVoBFH+SJelMob3V+xphpyniF9YtI1p711fIP7byY8Xr8IKt/RWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045558; c=relaxed/simple;
	bh=8xrp+PLWGWnGNr1R2Q9RlDhdl4OMwI9ky7GEV/tOcfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAaR3hxlZ0oSmFVmUiLSxBqQBMKSJpw5TQHmM4Kj5bOFViYLYthkVvEu+6S8O9cYYk3WxAa3E3BRh7/SaWCCUMgaNdNsp3iZsyld1c0xJ2Cfhdr01/ZlkTOb4XoDOwzNynNOi2Bv8Gn7OJZsxKv10iE7YCLx5CLLSwsDSNH9LbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5oDrT12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5oDrT12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACEE1F00893;
	Thu, 10 Sep 2026 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045556;
	bh=Cdo+rmDstdi/wv4Vrglb7Q5HOr6Q/8S05d4OuI8eWG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J5oDrT12yCwmsUKLG9nicehVw3jTNlBNGaqYxZOQe1B+nB8odrDQ8RSpt5b9+85bZ
	 gC2zUpht3+5ySeGRRnC1AuPSehaUspWuKS3cYunfWyMCXY4vf55YEQCsyBv+60BNAS
	 wys4QZN5tTRxpPFN2Cs/xKxjsXYLtPbRYL1sf2y3N3E+e+SsbeDlRTtTeIUsheau1R
	 tVB0zRpKAWj+KC7CwgGycXPPJdgQGQtVW6mJ5+a5tbfsuGTuiyc1fJ8T/zlHf4Vgsf
	 6W007kjJKQNvwpOjkVqQ3NYtM3evI6aUsTWp0g12lhvUBOsyh+Z45r8DXMiu+V+qTe
	 bPBM5ZGbpBESA==
Subject: Re: [PATCH net-next v6 14/14] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 10 Sep 2026 13:05:54 +0000
Message-ID: <178904555475.219967.711870735307370384@kernel.org>
In-Reply-To: <20260909-lan966x-pci-fdma-v6-14-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-14-6f48dab9d671@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The FDMA interrupt is hooked up (and thereby unmasked in the
  OIC) long before any FDMA state exists.

--

misc: lan966x-pci: dts: add fdma interrupt to overlay

This adds OIC interrupt 14 as the "fdma" named interrupt to the lan966x
PCI device tree overlay, so FDMA-based injection/extraction can be used
when the switch is reached over PCIe.

> diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
> index 7bb726550caf..5bb12dbc0843 100644
> --- a/drivers/misc/lan966x_pci.dtso
> +++ b/drivers/misc/lan966x_pci.dtso
> @@ -141,8 +141,9 @@ switch: switch@e0000000 {
>  
>  					interrupt-parent = <&oic>;
>  					interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
> +						     <14 IRQ_TYPE_LEVEL_HIGH>,
>  						     <9 IRQ_TYPE_LEVEL_HIGH>;
> -					interrupt-names = "xtr", "ana";
> +					interrupt-names = "xtr", "fdma", "ana";

[Severity: Medium]
With source 14 now named "fdma", platform_get_irq_byname(pdev, "fdma")
starts succeeding on the PCIe path, and lan966x_probe() requests the
handler right there:

drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_probe() {
	lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
	if (lan966x->fdma_irq > 0) {
		err = devm_request_irq(&pdev->dev, lan966x->fdma_irq,
				       lan966x_fdma_irq_handler, 0,
				       "fdma irq", lan966x);
		...
		lan966x->fdma = true;
	}
}

Is this ordering safe?  The OIC maps and unmasks source 14 at
devm_request_irq() time, but at that point no FDMA state exists yet:

- netif_napi_add()/napi_enable() only run later, from
  lan966x_port_init() -> lan966x_fdma_netdev_init() in the per-port
  probe loop, so lan966x->napi is still the zeroed devm_kzalloc()
  memory and napi.poll is NULL.

- the DCB rings, the LLP/ATU windows and the FDMA_CTRL NRESET pulse are
  all done even later, from lan966x->ops->fdma_init() ->
  lan966x_fdma_pci_init().

If the OIC delivers an FDMA interrupt in that window, the handler
schedules NAPI unconditionally:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_irq_handler() {
	db = lan_rd(lan966x, FDMA_INTR_DB);
	err = lan_rd(lan966x, FDMA_INTR_ERR);

	if (db) {
		lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
		lan_wr(db, lan966x, FDMA_INTR_DB);

		napi_schedule(&lan966x->napi);
	}
}

Can this then oops in __napi_poll(), either calling n->poll() while it
is still NULL, or running lan966x_fdma_pci_napi_poll() against
rx->fdma.dcbs == NULL and n_dcbs == 0, where fdma_has_frames() ->
fdma_db_get() dereferences the dcbs array?

How reachable is that window in practice?  The series itself describes
the card arriving with FDMA state from a previous boot.  The commit
"net: lan966x: clear FDMA interrupt stickies after switch reset" says
the stickies "sit in FDMA_INTR_ERR until the FDMA IRQ is requested later
in probe, at which point the handler fires immediately and WARNs", and
"net: lan966x: add shutdown callback to stop FDMA on reboot" says that
on the endpoint "channels stay active and interrupt sources stay armed
across the reset" and that "FDMA_INTR_ENA persists on the card across a
warm reboot".

The sticky clear in lan966x_reset_switch() clears the latched bits at
one instant, but does not mask FDMA_INTR_ENA/FDMA_INTR_DB_ENA and does
not stop the channels.  After a reboot that skips device_shutdown()
(panic reboot, kexec/kdump, watchdog warm reset with the card still
powered), could a still-active channel latch FDMA_INTR_DB again after
the clear and have it delivered as soon as source 14 is unmasked?

Would it be more robust to reset and mask the FDMA block (the
FDMA_CTRL NRESET pulse that already exists in lan966x_fdma_pci_init(),
plus clearing FDMA_INTR_ENA/FDMA_INTR_DB_ENA) before
devm_request_irq(), or to request the FDMA IRQ only after fdma_init()
has built the rings and added the NAPI instance?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
