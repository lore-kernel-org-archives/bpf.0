Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142F47D929;
	Thu, 10 Sep 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045547; cv=none; b=GkO45mpWSCYC50+qcCNiKDHrn1ZY6DTerS9RQRitr6Tpq4QSl1kLKVCvs0XbQPBYcRn0j9hTS74wGmwo9LEdMXda4+BvQYA1/RFGYTFVLklRHEZgBgHC1CL0GpJNGtJxk3/ZHTbY3t/2VELt6isL+gG547+enCz9X8GvBRWpXQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045547; c=relaxed/simple;
	bh=YfZxjSebQm0KNO16hOubujqCYwvIr86jGOjzNkHJv9M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qf241qg1U/AM4VdCMvCuIZotZfxKOhx0KIMMnst5P3tmboC5WB6q6BnQ1+dzxtClTdvwWOKbtzbxDq3ixqf5s5IP6VReaZlzRhcesGPNw0XrQymgzLCRq0+Sqm7t0iwTaB9SY4dcKrQYanjFoc3oLrA3kFsSm3gpm8gt3m7oxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4c7sph7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4c7sph7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEDD1F00893;
	Thu, 10 Sep 2026 13:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045545;
	bh=gOi0B08jroi+7YK16BHAVZKLiDfFvFzht6sMRqtKgtk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m4c7sph70DFrARJ9f/ZMcI/d15wCGz0ci9wqGNd/uOBcnpQDhhrTjyrmhNAv2wZb9
	 Si687zXj4iJTBVolRj/a6RUQvp9lv14LTFlV7ccna97Cr63304HTQiMqhtQe0SVkS1
	 acaqnY5rtbAXciTxOpqwhhY4Iyc6OGOJpPo30a/UyGLX4PLs8jHdQoI41MIm9A/v5l
	 N/M4A8viB/kex3qkocwFkwdFcoignGPnTouI1S7IPEr7enpzWbH8fU2fMLIFdoNvnr
	 h3PKrdlQOughnzjPHlU9A2/VhjmGTOtZQ2uy6Kc+PmjyD6hPDwMo2L3LNzEMNnil6e
	 Ml9q66GP8+YiA==
Subject: Re: [PATCH net-next v6 08/14] net: lan966x: clear FDMA interrupt
 stickies after switch reset
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
Date: Thu, 10 Sep 2026 13:05:43 +0000
Message-ID: <178904554399.219967.11177166628090236711@kernel.org>
In-Reply-To: <20260909-lan966x-pci-fdma-v6-8-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-8-6f48dab9d671@microchip.com>
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

- [Low] Commit-message/comment vs. reachability at this revision: the
  added FDMA sticky clear in lan966x_reset_switch()…

--

net: lan966x: clear FDMA interrupt stickies after switch reset

The patch acks FDMA_ERRORS, FDMA_INTR_ERR and FDMA_INTR_DB right after
reset_control_reset() in lan966x_reset_switch(), so that spurious sticky
bits latched by the GCB soft reset in PCI mode do not make the FDMA IRQ
handler fire as soon as the IRQ is requested. The clear is unconditional and
is described as a no-op on the platform path.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 6e6c08bb8eea..11094a381ec2 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1067,6 +1067,15 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
>  
>  	reset_control_reset(switch_reset);
>  
> +	/* When in PCI mode, the GCB soft reset issued by the reset
> +	 * controller can latch spurious bits in the FDMA error stickies.
> +	 * Clear them before request_irq hooks up the FDMA IRQ line,
> +	 * otherwise the handler fires immediately on probe.
> +	 */
> +	lan_wr(lan_rd(lan966x, FDMA_ERRORS), lan966x, FDMA_ERRORS);
> +	lan_wr(lan_rd(lan966x, FDMA_INTR_ERR), lan966x, FDMA_INTR_ERR);
> +	lan_wr(lan_rd(lan966x, FDMA_INTR_DB), lan966x, FDMA_INTR_DB);

[Severity: Low]
This isn't a bug in the register writes themselves, but is the failure
described in the changelog reachable at this point in the series?

The commit message says the latched bits "sit in FDMA_INTR_ERR until the FDMA
IRQ is requested later in probe, at which point the handler fires immediately
and WARNs". In lan966x_probe() the FDMA handler is only installed when a named
"fdma" interrupt exists:

	lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
	if (lan966x->fdma_irq > 0) {
		err = devm_request_irq(&pdev->dev, lan966x->fdma_irq,
				       lan966x_fdma_irq_handler, 0,
				       "fdma irq", lan966x);
		...
		lan966x->fdma = true;
	}

At this commit the PCI overlay in drivers/misc/lan966x_pci.dtso does not
describe that interrupt:

	interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
		     <9 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "xtr", "ana";

so platform_get_irq_byname(pdev, "fdma") fails and lan966x_fdma_irq_handler()
is never requested on the PCI path.

The overlay also disagrees with the positional list in
Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml, where the
second entry is reserved for "fdma":

	interrupt-names:
	  minItems: 1
	  items:
	    - const: xtr
	    - const: fdma
	    - const: ana

Both points are resolved later in the same series by "misc: lan966x-pci: dts:
add fdma interrupt to overlay", which switches the overlay to
interrupts <12>,<14>,<9> and interrupt-names = "xtr", "fdma", "ana", so this is
only an observation about the ordering of the changelog against the code state
here rather than an actionable defect.

Would it help to mention in the commit message that the WARN only becomes
reachable once the overlay gains the "fdma" interrupt?

>  	/* Don't reinitialize the switch core, if it is already initialized. In
>  	 * case it is initialized twice, some pointers inside the queue system
>  	 * in HW will get corrupted and then after a while the queue system gets

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
