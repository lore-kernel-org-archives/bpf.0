Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAF3D1712;
	Wed, 23 Sep 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154167; cv=none; b=eQhX5LBKhRTL8RI9oAdsJSAei3gRNervT9UW+mVoTPFgMZO2R3cL1aGl9iULmYUZ+puOFgguUXgQRWLC6IrSX5jeT/PCGr9s0iDdV+3377F3s6SfW/JZynB2nD4UXsgJGRGn/pL2Zm68QBMgBkPiuKuKmtmbQ5HFmOhK5WLgG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154167; c=relaxed/simple;
	bh=cSCLKswE0dYCxdT9s6rlNNNALsaDPQbgfmMnNLwfG/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqH3x7/U5Coj9fzG02ITaYZPLyPIEk3nVBIkHlfaLhDGa2PqUS+B2Z95DNMB65YnF8eIV7Hrcwk9HWkvketbkww7pxLfeXb26iQhWonBhRYSPlv4VVbvAw+KFLjqq48figRYhFhlcZdzxopdqFmo5dUpnWySejKjdzG8SncPgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx1fzDL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx1fzDL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A19F1F000FF;
	Wed, 23 Sep 2026 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154165;
	bh=246+YFY0hcM1gZTyJYBwDA5GnPdAK2YN+khCzJ9w3xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fx1fzDL6n++zlKFba/TD6ua1TazikVupjqJ+tpB2waBe7XVD+F+lnJbkIVvRrElwe
	 S+6he4ANapJNJ/Ze0HxDGEOX0yxjravBL7HOehd2Ex37FDQdCd00tCSRZ87cd4+Mnr
	 sHiwZNMR2k6fi2LEZxorZKO3qiD5Q6FU9xnQ/d/dkX7dfB2m/5/WRYl8d3qN8F4c1M
	 aFBYXnwpbUfP2IQ5PCKADXrW+0GRtrH6rNknOYwlabC4oWP5WDznRFal9akAaOCPkV
	 USdsJUQTxiFkVJ0ZgmYOCOI6FbZlYB3tL2HLq/xebrNN/GcEVjrkC5rqm9ifYSaGu2
	 epfs3ppNEngXQ==
Date: Wed, 23 Sep 2026 10:02:10 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 09/14] net: lan966x: add shutdown callback to
 stop the FDMA on reboot
Message-ID: <20260923090210.GR13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-9-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-9-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:34:01PM +0200, Daniel Machon wrote:
> As a PCIe endpoint, lan966x is not reset by a host reboot: its FDMA
> channels and interrupt sources stay armed, and the OIC ORs every
> source into the shared PCIe INTx, asserted before the driver has
> re-probed. A still-active channel also keeps write access to host
> memory the next kernel will reuse.
> 
> Add a shutdown callback that:
> - frees the ana, xtr and FDMA irqs, masking and unmapping them at
>   the OIC (disable_irq() would leave both set - the OIC has no
>   irq_disable())
> - masks the analyzer source, armed unconditionally by lan966x_init()
>   and re-armed by the MAC table's age timer
> - stops and detaches the netdevs, draining in-flight xmit and
>   clearing netif_device_present() so ndo_open/ndo_change_mtu cannot
>   re-enter the FDMA against a disabled NAPI
> - disables both FDMA channels and masks their interrupts
> - unmaps the outbound ATU windows, leaving none armed
> 
> NAPI is skipped when fdma_ndev is unset (a probed switch with no
> usable port never adds one), and XDP attach cannot re-enter either,
> since lan966x_xdp_setup() returns early on PCIe before touching the
> FDMA.
> 
> Only the PCIe instantiation needs this - the SoC one resets with the
> chip - so the callback returns early on a platform device; the check
> is at runtime since .shutdown belongs to the driver, and a
> PCIe-enabled kernel binds both.
> 
> FDMA_INTR_ENA persists across a warm reboot, so also restore the
> full enable in lan966x_fdma_rx_start(), run after both rings are
> allocated, re-arming both backends from one site.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

