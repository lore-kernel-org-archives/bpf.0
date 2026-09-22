Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25A550DAC;
	Tue, 22 Sep 2026 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082062; cv=none; b=dPQHA9F6ILnP/ZfEd7IPlkAkpYeg+0KKvWvlYz6YXTgpr+CF4+YM0ljIje3hAQo3ufgsTbTV5cN8UuK/9jL37GGv7YgAsW175P0gjoVDslVyyoDu05vzrbOsYUn+J2s9XbUkVWfZ+EC/Kic6aP+gMoeTdTZmbxGXa6R+iLjw2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082062; c=relaxed/simple;
	bh=TnmBcq19iPivSY1KngWuLjMnr/g513y72ncpsujykOo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTH26OdUwNGQlARzInZr+qEnlqSrB1MzF9RSM9ouGF3sMhGRfOYaqz0vUiiM17wBrJ0/oSLF1z+ZyskmQpRIf7S/YPQ2RbfRdH1b0u57qfL0evEsgvo2AA8a9du1yEXgelwAY1oYWAqbXieaxVPGi+L2iifnNrkfQbjH29JqWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e37JHfks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e37JHfks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0551F008A7;
	Tue, 22 Sep 2026 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082061;
	bh=WFwTVnJi02mjfIgr5QoGfThRyGwmOlxJuM0wJDAdo9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e37JHfksb2icoaT+Q32VrrzC0lU/t8K+26CLfF2t4cb61wNxn7kqXGBK8Nzmjru0d
	 u7Bn5x+ADUKOeFdDmrtdoNvhD+sQROCIWXcYJTcpd3Gz7C90ozKPqDQZu85exPmTi7
	 Tv31dQHNCz0ATMdKhulfn/gPfIsC3UV0RTqnQlY2xmlMvnb7Zbvmytz9geZKen4ZFe
	 wlUSfLlBom8V8IYxqtTSq81TYVnbocadczji6ph6CzyAk5wk7o5K8Fs6EWgBFavOYh
	 WTSpp5Fj0QEAR13zvQd1SL5vdyd1yne9MtwWZnNIasdFz7khRSY/O5cQTejdnemJ9N
	 mrWvn8wuai3nw==
Subject: Re: [PATCH net-next v7 14/14] misc: lan966x-pci: dts: add fdma
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
Date: Tue, 22 Sep 2026 13:00:59 +0000
Message-ID: <179008205925.2160803.1332329555699452493@kernel.org>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-14-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-14-0ecc179c8a2c@microchip.com>
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

- [Low] Concern retained for combined policy, but my verification says
  FALSE POSITIVE.

--

misc: lan966x-pci: dts: add fdma interrupt to overlay

This adds OIC interrupt 14 to the switch node of the lan966x PCI device tree
overlay and names it "fdma". With the name present, the lan966x driver picks
up the FDMA interrupt and uses the FDMA-based injection/extraction path for
PCIe instances.

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

[Severity: Low]
This isn't a bug, but would it be worth spelling out in the commit message
that this line alone changes behaviour for every existing PCIe deployment?

The overlay is built into the module (drivers/misc/Makefile adds
lan966x_pci.dtbo.o and lan966x_pci_load_overlay() applies it from
__dtbo_lan966x_pci_begin), so there is no way for a user to opt out of the
new name.

In lan966x_probe() the presence of the name is the only thing that selects
the data path:

	lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
	if (lan966x->fdma_irq > 0) {
		...
		lan966x->fdma = true;

and lan966x_probe_port() then derives the advertised MTU ceiling from it:

	dev->max_mtu = lan966x_is_pci(lan966x) && lan966x->fdma ?
		       FDMA_PCI_MAX_MTU : ETH_MAX_MTU;

So after this patch PCIe ports report FDMA_PCI_MAX_MTU instead of
ETH_MAX_MTU, and ndo_change_mtu rejects values above that cap.

FDMA_PCI_MAX_MTU is derived from PAGE_SIZE << MAX_PAGE_ORDER, which the
preceding commit "net: lan966x: add PCIe FDMA MTU change support" documents
as 15498 on a 4KB-page, MAX_PAGE_ORDER=10 build, i.e. above any practical
jumbo value, so the change looks intentional and harmless in practice.
Would a sentence in this commit message noting the switch to FDMA and the
resulting max_mtu change make the series easier to bisect against later?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
