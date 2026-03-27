Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409D2DEA62;
	Fri, 27 Mar 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607632; cv=none; b=A3UgixlnQVf6ji6gaz+LRSoShz6xjxcTieM+3YruyNa52ou4qEwFuq1nxXuTju5bPLsvjUDiDVba67mPvKU9NrRGjNNoThv0amupKYh0xGdqzma966cVVduw6Kp99jbA/BUQYb79o6wDxFgjLDg5OG8f8Gh+8nP+oQ7TTxdqu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607632; c=relaxed/simple;
	bh=6IOfFrFF0I2K+THl5oa33+53JXBomLzKcMfmf5zREik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYiu4gCX9e9oE5Jxb641oCZTbFxfl4evnhkZHKgQyZ8DKraX7hvR5DIbqqqs5YSS9YySoDMia5WbpQiAEewq3ofcVH/KVNvsFlron2S8Se/qiG9QHKY0MrYlnd38jI1x68egqWh88GpUD/oQLLCO8m/Rp2jZHXFjGZoQOe+QAiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eijEnQjJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eijEnQjJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7143E4E42822;
	Fri, 27 Mar 2026 10:33:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 432B160230;
	Fri, 27 Mar 2026 10:33:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AE6910450B66;
	Fri, 27 Mar 2026 11:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774607626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eoilEMPRsemsEpzPv4qMKHRscMyqonJPZi2TragghrE=;
	b=eijEnQjJKrc4O1bnP7acnJgcpgpm5r/nemVW6BUa9W76cIdXFOPNhFwy8vP4c5P5ewNvu3
	nPHvWUZ0DyeLDno8+gnwbuaFPnYTFjS9IDQp7jYWLNodVqUS7vk4sC5VznCZ0f6PyHK7cN
	2ckT0vL/9QZWl58VlC26VTSwR1u/57TWr08U0CFWuUu9Sp899H00elkISc6kExlYQkP+II
	MUyDi+F2e93J0pKp0/KlKEv7b+dMhteSDKkkZwnpVZX6QvgmzBdD3SssyK0Qz520OL18ep
	IBEWmZfaU4RNFSnsRgD7PzhkIoDewfzmdlKPA8mZAd4X4t1P2g2MIVoRtl75tg==
Date: Fri, 27 Mar 2026 11:33:37 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260327113337.0368eea3@bootlin.com>
In-Reply-To: <20260326154833.jp6rx5x2rlpmwrg3@DEN-DL-M70577>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260323155204.0321db13@bootlin.com>
 <20260323172640.2669232d@bootlin.com>
 <20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
 <20260324090752.0799acb1@bootlin.com>
 <20260326154833.jp6rx5x2rlpmwrg3@DEN-DL-M70577>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On Thu, 26 Mar 2026 16:48:33 +0100
Daniel Machon <daniel.machon@microchip.com> wrote:

...

> 
> As I remembered, doing rmmod on the lan966x_switch followed by modprobe
> lan966x_switch works fine. This is because neither the switch core, nor the FDMA
> engine is reset, so they remain in sync.
> 
> When the lan966x_pci module is removed and reloaded (what you did), the DT
> overlay is re-applied, which causes the reset controller
> (reset-microchip-sparx5) to re-probe. During probe, it performs a GCB soft reset
> that resets the switch core, but protects the CPU domain from the reset. The
> FDMA engine is part of the CPU domain, so it is not reset.
> 
> This leaves the switch core in a reset state while the FDMA
> retains state from the previous driver instance. When the switch driver
> subsequently probes and activates the FDMA channels, the two are out of
> sync, and the FDMA immediately reports extraction errors.
> 
> Theres actually an FDMA register called NRESET that resets the FDMA controller
> state. Calling this in the FDMA init path causes traffic to work correctly on
> lan966x_pci reload, but it does not get rid of the FDMA splats you posted above.
> They get queued up between the switch core reset, in the reset controller, and
> the FDMA enabling. I tried different approaches to drain or flush queues, but
> they wont go away entirely.
> 
> The only thing that seems to work consistently is to *not* do the soft reset in
> the reset controller for the PCI path. The soft reset is actually the problem:
> it only resets the switch core while protecting the CPU domain (including FDMA),
> causing a desync.
> 
> A simple fix could be (in reset-microchip-sparx5.c):
> 
> +static bool mchp_reset_is_pci(struct device *dev)
> +{
> +	for (dev = dev->parent; dev; dev = dev->parent) {
> +		if (dev_is_pci(dev))
> +			return true;
> +	}
> +	return false;
> +}
> 
> -	/* Issue the reset very early, our actual reset callback is a noop. */
> -	err = sparx5_switch_reset(ctx);
> -	if (err)
> -		return err;
> +	/* Issue the reset very early, our actual reset callback is a noop.
> +	 *
> +	 * On the PCI path, skip the reset. The endpoint is already in
> +	 * power-on reset state on the first probe. On subsequent probes
> +	 * (after driver reload), resetting the switch core while the FDMA
> +	 * retains state (CPU domain is protected from the soft reset)
> +	 * causes the two to go out of sync, leading to FDMA extraction
> +	 * errors.
> +	 */
> +	if (!mchp_reset_is_pci(&pdev->dev)) {
> +		err = sparx5_switch_reset(ctx);
> +		if (err)
> +			return err;
> +	}
> 
> Could you test it and see if it helps the problem on your side.
> 

I have tested it on my ARM and x86 system. It fixes the lan966x_pci module
unloading / reloading issue.

However an other regression is present. After a reboot, without power
off/on, the board is not working (tested on both my ARM and x86 systems).

According to your explanation, this makes sense.

IMHO, the problem is that we cannot make the assumption that "The endpoint
is already in power-on reset state on the first probe". That's not true
when you just call the reboot command.

Best regards,
Hervé
