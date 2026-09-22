Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040154DAF2;
	Tue, 22 Sep 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082060; cv=none; b=YR5eA8gQ1pvDCRtzveLULToYH2UShvdxypXyeK3QI863R0ENKOCy9t83AIjJ2C8NLWa4/vUzY77lXAgulUdiuzsurphRej87mwO8Dkn1kWoX8b9MEm2XeNOO6TN6+UObMw1ZbMSvZxNIoE3OJ/EsdgxhTnnaXlnXKFw7Vmjs1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082060; c=relaxed/simple;
	bh=DqDpdIsUd+jtuEVLbDym52RxrrtoVHe82WeatP1LnZ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jwobyo6jG7b0ercvzXmdKYFZ+431J/xM/hpWWtqRdmCx/Ohl0fLxourOk0XiW8WibVslZEzSGaG3aWMMEzfMI1xgYZn9igU/zfiqud5tHEBrkdLFtDlVHkxI23H5UrHrYVcBXq52OvzbPrKRjp6R7tN578gfpsT3BCNStFGdL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbCExJVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbCExJVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C288B1F000FF;
	Tue, 22 Sep 2026 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082059;
	bh=PUsE9yYFqfPx684JqjlrnAsRdOemuN8nrgTdith8yn4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GbCExJVhEnJ2Oegj8CtUT6F1lylujYvC6TeY7mLJUwf4r3rcGvUKcn7LpxyobrlfV
	 IL2nRpcq+JIXRVArIX4SfHStrYWrCjme5+rCSZJkWaJFDWpqbB1oV1zNHqeL+IZr8a
	 l6QdFm1b4de1XzpmjzN2xl0+c6bHtCnSv1J80IKKH5fPTsM8mOgtPrhP/YUO2SwG0l
	 NrLalpnF4eEZEyuLOhQpFj68RDPIMNLPmILeom64sTwPy0RUzNMXsW3v1b2c7Jscow
	 LharGAJwsEpsm/35u7e9DMtaZD1MpB40jT82t2DtVDFG67eyaxL0FSgLx1B5deEhNv
	 I4boPJiSTx/DA==
Subject: Re: [PATCH net-next v7 13/14] misc: lan966x-pci: dts: extend cpu reg
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
Date: Tue, 22 Sep 2026 13:00:57 +0000
Message-ID: <179008205732.2160803.970343877489221523@kernel.org>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-13-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-13-0ecc179c8a2c@microchip.com>
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

- [Low] Claimed DT-overlay/driver mismatch: the overlay whose "cpu" reg
  is extended for the ATU registers still declares only interrupts = <12…

--

misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space

This grows the "cpu" reg region of the lan966x switch node in the PCI
overlay from 0x100000 to 0x800000 so the iATU outbound window registers
at offset 0x400000+ fall inside the mapping.

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
>  

[Severity: Low]
At this commit the same switch node still only declares:

	interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
		     <9 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "xtr", "ana";

so lan966x_probe() does not find a named "fdma" interrupt:

	lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
	if (lan966x->fdma_irq > 0) { ... lan966x->fdma = true; }

and lan966x_fdma_pci_init() returns early before the ATU setup:

	if (!lan966x->fdma)
		return 0;

which leaves the enlarged "cpu" window without a consumer until the next
patch in the series, "misc: lan966x-pci: dts: add fdma interrupt to
overlay", adds <14 IRQ_TYPE_LEVEL_HIGH> and the "fdma" name to this node.

Is it worth folding the two overlay changes into one patch, or ordering
the interrupt patch first, so the tree is never in the intermediate state?
The driver falls back to register based extraction/injection in the
meantime, so this looks harmless either way.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
