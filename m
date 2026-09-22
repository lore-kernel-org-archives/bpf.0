Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7567549384;
	Tue, 22 Sep 2026 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082053; cv=none; b=QkfumbJ8pyGi4VFooYfLSc7uCpQicS/kkVCAj5EV8NP7TAIbfoE7LPnNm5dVASsoLVtDYS9gLACz2KyVEnmbKU6co3uTDw4ZHV4hCfwjPENTY8gByV+BYNx0PZV77YVTNgnTpQ+9k0ZQDtac5L0cJUXQbz1tctzNJYhZPdp83qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082053; c=relaxed/simple;
	bh=gfLktZ4UIwJu6MrudPpSLQzSpeRJa6wd41D1h91UUm0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMmaLDWEhuc9fEXnmMVvpF66yHaub9v/AXwgHaPucvirmKVYZ+rFQTCBixfxMRdZ9OeyxFSaNsvIEjpConaymPoWvuqKv5xMUpel7Wpr8DrVIPFGyBFstIAGC3dbAUdmRfZVtk0emxoD91rcCiAY4d1qoM+JqlUw725PGaqicSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGYOQ7y7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGYOQ7y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C131F00893;
	Tue, 22 Sep 2026 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082051;
	bh=w9zYC7enUabnf353gSgpk/pWsHG4HeOTH/3kC4e7ynY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BGYOQ7y7QxC11HqbsgjWRO0zccDz31wFXfq2JixhTtGSTuO+ZLFGaR9FYBGlzcq3R
	 X3nyxXLal6/MTujKteNN9tBIYDT9jXD0hFlXHHa2UPICk1vIlrWU5aDq10EQ/EVwdk
	 XMn8DppGInwnK6LrsL4XYAYRypdCeyJy7kMhVo0f2lrGAJ+2xDRg4ehCz/hQHOYQZM
	 ae+F9TDB0FUdzBSa5l9JOrRJwFnXgRjpCz4fC3Z4/sQpiNiA0rEdaio9OElrVCroFV
	 DvLCyYChaKjUbuJAyp5S/QJe0WzQianHBfXH0EXFMrTeERvyE5DNyxmBn5QBRVkgTw
	 UDSSqdK52mJ0g==
Subject: Re: [PATCH net-next v7 09/14] net: lan966x: add shutdown callback to
 stop the FDMA on reboot
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
Date: Tue, 22 Sep 2026 13:00:49 +0000
Message-ID: <179008204979.2160803.8934931337596115008@kernel.org>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-9-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-9-0ecc179c8a2c@microchip.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] BASELINE DECISION: false (discarded).
- [Low] BASELINE DECISION: false (discarded).
- [Low] The patch fixes an observable pre-existing failure on the
  already-supported PCIe endpoint configuration (the xtr and ana OIC…
- [Low] BASELINE DECISION: false (discarded).

Pre-existing issues:
- [Low] BASELINE DECISION: false (discarded).

--

net: lan966x: add shutdown callback to stop the FDMA on reboot

Adds a .shutdown callback to the lan966x switch driver that, on the PCIe
endpoint instantiation only, frees the xtr/ana/FDMA irqs, masks the
analyzer interrupt, stops and detaches the netdevs, disables both FDMA
channels and unmaps the outbound ATU windows. It also restores
FDMA_INTR_ENA in lan966x_fdma_rx_start() and adds the register defines.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 11094a381ec2..2c1e2bc12024 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1324,9 +1324,65 @@ static void lan966x_remove(struct platform_device *pdev)

[ ... ]

> +	if (!lan966x_is_pci(lan966x))
> +		return;
> +
> +	if (lan966x->xtr_irq > 0)
> +		devm_free_irq(lan966x->dev, lan966x->xtr_irq, lan966x);
> +	if (lan966x->ana_irq > 0)
> +		devm_free_irq(lan966x->dev, lan966x->ana_irq, lan966x);
> +	if (lan966x->fdma_irq > 0)
> +		devm_free_irq(lan966x->dev, lan966x->fdma_irq, lan966x);
> +
> +	lan_wr(0, lan966x, ANA_ANAINTR);

[Severity: Low]
Should this carry a Fixes: tag?

This part of the new callback corrects a failure that already exists on
the shipping PCIe endpoint configuration, independently of the FDMA work
in the rest of the series: the xtr and ana OIC sources, plus the analyzer
enable written unconditionally by lan966x_init()

  drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_init() {
      ...
      lan_rmw(ANA_ANAINTR_INTR_ENA_SET(1),
              ANA_ANAINTR_INTR_ENA,
              lan966x, ANA_ANAINTR);
      ...
  }

stay armed across a host reboot, and nothing released them at shutdown
before this patch, so the shared INTx can be asserted before the driver
re-probes.

Without a Fixes: tag, stable tooling and backporters have no way to tell
which versions are affected. Would the following be the right
provenance?

  Fixes: 185686beb464 ("misc: Add support for LAN966x PCI device")

That is the commit that introduced the PCI endpoint together with its
persistent OIC/INTx routing.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
