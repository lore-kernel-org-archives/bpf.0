Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9144FC8CC;
	Fri, 25 Sep 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369557; cv=none; b=nRrFuKEPKt/oXZ9QPEVU2ITijT6e3VujIuTTvIxAGoYi3uxueeaNsFpYw/tbASUP79FL5Tepb+57Ntpp9uEHTe7r5fUpiEhmpIEIWHjjGmuyRaEVynTYffaGNQkuNoZct/HazjZAaDQQcwDy/JP3i3tABljik+gMglAHeACW9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369557; c=relaxed/simple;
	bh=5ORrd5E+6/0AYzsIE4LqdejwdmcCbDjdYqpMoxWtxSk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Erse49oTyoVR08dvflDkkz9lJcFniNKGEtgXv7YkfCJdj0jL5lPPSCVjVI6UZOTW+qrU6nogtk5D/5vCi02aZ1+UZ5wdnX9hmQWzRXyhsnIqGNwQw1mQ4W3HObm7vmagVW4HcWB5BcsW6a1+Rb/066iZVbn3OwZ88rqD+4acoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9g30EiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9g30EiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E481F00893;
	Fri, 25 Sep 2026 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369555;
	bh=YHkMxQooC2tRVfPMnOlsBhSHdC58bg6gLKzsTSxr2+s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L9g30EiK0FsV1GEDudwje+Tetrpiwzw50beq+oi0YICWr46OSAoeWJ6MFaVpl/Y0r
	 4XNXzTC1Z5qnkYKLWqHdZmDp19kVCsDhKh86HKA7uLlZnf/YPdtojUgKALnAWdqZKF
	 /6blq7RhqZT429p7ep95OkS2y2dn4LpP+fsU6q5GlH1xeCNv9xV2eP9+2IbjR2De7b
	 VsIbvWO9zMudZiLENvCyGY2TeplQMUOFS2ZfFg20eh7Gu+c6QfqxESh4Uy3TBFRO+z
	 P/mEpupt/EL8yY4vNOeQIYqtBOWZ3hy8bRNjmronWoFuGVRiY0NCj6xwamTgTn0J/M
	 tdb6suPf/2C9Q==
Subject: Re: [PATCH net-next v8 14/15] misc: lan966x-pci: dts: extend cpu reg
 to cover PCIE DBI space
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, horms@kernel.org,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 25 Sep 2026 20:52:34 +0000
Message-ID: <179036955409.2160803.9449763908060819367@kernel.org>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-14-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-14-201c7b707d8b@microchip.com>
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

- [Low] Concern: nothing enforces the contract between the DT "cpu" reg
  size and the driver's hard-coded TARGET_PCIE_DBI offset (0x400000)…

--

misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space

This patch grows the "cpu" reg of the switch node in the lan966x PCI
overlay from 1MB to 8MB. The FDMA engine programs its ATU outbound windows
through registers at offset 0x400000 and above, and the old mapping did
not reach them.

> diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
> index 7b196b0a0eb65..7bb726550cafd 100644
> --- a/drivers/misc/lan966x_pci.dtso
> +++ b/drivers/misc/lan966x_pci.dtso
> @@ -135,7 +135,7 @@ lan966x_phy1: ethernet-lan966x_phy@2 {
>  
>  				switch: switch@e0000000 {
>  					compatible = "microchip,lan966x-switch";
> -					reg = <0xe0000000 0x0100000>,
> +					reg = <0xe0000000 0x0800000>,

[Severity: Low]
This isn't a bug, but the driver only works if the size here is large
enough, and nothing in the driver checks that.

The driver computes the DBI target from a fixed offset into the "cpu"
resource:

drivers/net/ethernet/microchip/lan966x/lan966x_main.c:
	{ TARGET_PCIE_DBI,             0x400000, 0 }, /* 0xe0400000 */

lan966x_create_targets() then adds that offset to the ioremapped base
without comparing it to resource_size():

	lan966x->regs[iomap->id] = begin[iomap->range] + iomap->offset;

fdma_pci_atu_addr_get() in drivers/net/ethernet/microchip/fdma/fdma_pci.c
adds a further FDMA_PCI_ATU_ADDR (0x300000) + idx * 0x200 + offset:

	return addr + FDMA_PCI_ATU_ADDR + FDMA_PCI_ATU_IDX_SIZE * idx + offset;

With this patch, the in-tree overlay covers the highest register touched
(about 0x700A18 into the cpu range). The native lan966x.dtsi still uses a
1MB cpu reg, but it never reaches this path, because lan966x_is_pci() is
false there and lan966x_shutdown() returns early.

So there is no in-tree problem. Would it still make sense to check in
lan966x_create_targets() that TARGET_PCIE_DBI plus the ATU range fits
within the "cpu" resource on PCI, rather than depending on the DT size
alone?

>  					      <0xe2000000 0x0800000>;
>  					reg-names = "cpu", "gcb";
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-lan966x-pci-fdma-v8-0-201c7b707d8b%40microchip.com
