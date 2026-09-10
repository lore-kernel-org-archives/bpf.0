Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0D490C00;
	Thu, 10 Sep 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045557; cv=none; b=iT849wNasxvn/q6gOjambpgbMaVq1qGU5IYWMZKfTTCAjKgYin99wqSW92D1QcPF4yjIZk5/K1PQX/ENXmheDtpRnM31/7F3yIfdXYUF65EEwgjuRwtSkS1ZvAyVNgKNAIl5aQzjObuzVUiZ96DVDYADtMb79e1AK7CmcqcD3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045557; c=relaxed/simple;
	bh=3MjUcIDPftNtv/doowUtVKbtOO4aZEwH8fEs4QjGcSc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2NCK9s53r5V3iFFfEAKYpHpue6qcRsNhCHoTrV/Uujlp3vH4WlD8Cc/COPRftnzvRl1ch4LXuEy5I3crYqoL0hvpH8x/VW4I6HN1pr0+OAGVfXbDOZKj1lKFUts2NJ1eBZk2ikqsLyPgbGwG8kxrll+uLqbMgA1R5yRm05rwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMVbN06t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMVbN06t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752C71F000FF;
	Thu, 10 Sep 2026 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045554;
	bh=MEARMROxwEnqR/mfCzYtDxrp/hAYhtP/dZwuqgrxQ9A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eMVbN06tBehl96YDs0m9/79PxxoZaGFh947PiTzoibfVrQKRRFR5AuoCpxIY59NJS
	 qquiHZI+ox8WyjtWuSIskE5zP/xZmciimZFH0IhAGPQSWgIhhlAvZWiw/GWIQnQXxg
	 nZlCEzrVEDQ4CtnnWpAq1dlcg2nMYvBeSsd3ivl/vVqqd9/fcTblmq8dfodcHqMDEX
	 HnuVwr7bqBuwIucK/Bk/XEysXy+JF3Ze9F9a15QvS60pA/9/Yrpky6W4LG3TvGjuej
	 dX3zUGDl46gXMkGHGSJvAPK1JGpivGJg14DEu6e35XUms5sFS1ixQ5ggzvJ1VTC8pZ
	 kkSfKGwQzJ6HA==
Subject: Re: [PATCH net-next v6 13/14] misc: lan966x-pci: dts: extend cpu reg
 to cover PCIE DBI space
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
Date: Thu, 10 Sep 2026 13:05:53 +0000
Message-ID: <178904555304.219967.9327319194988391867@kernel.org>
In-Reply-To: <20260909-lan966x-pci-fdma-v6-13-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-13-6f48dab9d671@microchip.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Claimed patch-ordering / bisectability bug: the "cpu" reg window
  is enlarged from 0x100000 to 0x800000 only in this commit, while the…

--

misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space

This grows the "cpu" register window of the switch node in the lan966x PCI
device tree overlay from 0x100000 to 0x800000 so that the PCIE DBI and iATU
registers at offset 0x400000+ are covered. Those registers are programmed
when the FDMA engine sets up the ATU outbound windows.

No Link: tags in the commit header.

> diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
> index 7b196b0a0eb6..7bb726550caf 100644
> --- a/drivers/misc/lan966x_pci.dtso
> +++ b/drivers/misc/lan966x_pci.dtso
> @@ -135,7 +135,7 @@ lan966x_phy1: ethernet-lan966x_phy@2 {
>  
>  				switch: switch@e0000000 {
>  					compatible = "microchip,lan966x-switch";
> -					reg = <0xe0000000 0x0100000>,
> +					reg = <0xe0000000 0x0800000>,
>  					      <0xe2000000 0x0800000>;
>  					reg-names = "cpu", "gcb";

[Severity: Low]

This isn't a bug, just a question about the ordering of the series.

The earlier commits "net: lan966x: add PCIe FDMA support", "net: lan966x: add
PCIe FDMA MTU change support" and "net: lan966x: add PCIe FDMA XDP support"
already derive regs[TARGET_PCIE_DBI] from the "cpu" base plus 0x400000, and
fdma_pci_atu_init() writes at DBI + 0x300000 + idx * 0x200:

drivers/net/ethernet/microchip/fdma/fdma_pci.c
static void __iomem *fdma_pci_atu_addr_get(void __iomem *addr, int offset, int idx)
{
	return addr + FDMA_PCI_ATU_ADDR + FDMA_PCI_ATU_IDX_SIZE * idx + offset;
}

That lands roughly 0x700000 from the "cpu" base, i.e. outside the 0x100000
mapping that exists until this commit. Would it be clearer to move this
overlay change before the driver commits that compute the DBI offset, so
that the mapping is never smaller than the offsets the driver derives from
it?

For what it is worth, the intermediate commits do look safe in practice,
since the ATU access in lan966x_fdma_pci_init() is gated:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
	if (!lan966x->fdma)
		return 0;
	...
	fdma_pci_atu_init(&lan966x->atu, lan966x->regs[TARGET_PCIE_DBI]);

and lan966x->fdma is only set when the node names an "fdma" interrupt in
lan966x_probe():

	lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
	if (lan966x->fdma_irq > 0) {
		...
		lan966x->fdma = true;
	}

The overlay here still carries only interrupt-names = "xtr", "ana", and the
"fdma" interrupt is added by the following commit, so the enlarged window is
in place before the FDMA path can be enabled. Is that ordering intentional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
