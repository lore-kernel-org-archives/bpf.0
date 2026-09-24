Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1413603C0;
	Thu, 24 Sep 2026 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232385; cv=none; b=FA0lFXCTjKhVysc2peRBuFkyB7uNqSDW2WFabe9XfZaLPSme3XCcV8ja9qr9Ub9aG6i9DRbLKq63XxEDaE6pIpRJ1GSMZh1/Upy8XqH7lRFoIEm0Ly0iiL+viw+QDJKXrtUcHheJ4E2C58OfV1unLKOSYItF88KkRjWIrvbP4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232385; c=relaxed/simple;
	bh=+hGZUN0BKiqi0Y3XcVBSdIkGES37WxS6ncO6TFnsZuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUrIDpIlb7bz1E4sI9DcU8D5kc9yl9rof9BmDAw4+5dcG29/AQOyIdaLQtHduJP5xMUho9CfsKqoTuHuJfo71omtpnyzJSQZP3RB1MvHuqyPwfUtCaTGv4PIboYitShAGWbzCEfRbVYigBFCF8oo0No1fyIYrLdVKnxsNl06pXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koWTzwgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koWTzwgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882071F000FF;
	Thu, 24 Sep 2026 06:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232383;
	bh=R0wnoOO5pG/STL/OpzTwEdV4fc3ldm12F1eE4DwdDVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=koWTzwgXzfK1tsRkEa0NQlX7UtVL0Y2s+v/pZ/J4FNAIbfHcagmjIjvBhoxn6HzBE
	 cnIqWxAWh8srKT6XAWxK+jPnkL2VBHyWzH24so0+Pv2lyjD5oUyrJ7iLna46XHGyCj
	 P+NTR8r0f6g1SQLEpb4rEtYT0B4mu3Mr23gJsZQt1IxwD/qQt9cDIXtSFAu0jH3dIQ
	 EjF/Ug21v5k1kuw8Fpxc3eoZCu5QVrA8ZJsTSOc4X/0b05kKpZEtc7/WXZocn67RTw
	 6CsIEE2w4gPwBfLoKQMCkzA3nRVCr1gVG2iPDH1cQEv+QW6DJWlWs+ezKydrK4ZWQ4
	 74MydDOap5AOw==
Date: Thu, 24 Sep 2026 07:46:17 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horatiu.vultur@microchip.com,
	steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, herve.codina@bootlin.com,
	arnd@arndb.de, gregkh@linuxfoundation.org, mohsin.bashr@gmail.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 10/14] net: lan966x: add PCIe FDMA support
Message-ID: <20260924064617.GY13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
 <179008205148.2160803.12818321368571406375@kernel.org>
 <20260923084538.wgkw2nt5ergoxcot@DEN-DL-M70577>
 <20260923180730.GV13925@horms.kernel.org>
 <20260923201155.lbbbtx22adz2ilhg@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923201155.lbbbtx22adz2ilhg@DEN-DL-M70577.microsemi.net>

On Wed, Sep 23, 2026 at 10:11:55PM +0200, Daniel Machon wrote:
> > On Wed, Sep 23, 2026 at 10:45:38AM +0200, Daniel Machon wrote:
> > 
> > ...
> > 
> > > > [Severity: Medium]
> > > > Is this path expected to work on a big-endian host?
> > > >
> > > > Until now the descriptor producer and the FDMA engine were both on the
> > > > little-endian SoC, so the native-endian descriptor layout in
> > > > drivers/net/ethernet/microchip/fdma/fdma_api.h was fine:
> > > >
> > > >   struct fdma_db {
> > > >         u64 dataptr;
> > > >         u64 status;
> > > >   };
> > > >
> > > >   struct fdma_dcb {
> > > >         u64 nextptr;
> > > >         u64 info;
> > > >         struct fdma_db db[FDMA_DB_MAX];
> > > >   };
> > > >
> > > > With PCIe FDMA the descriptors live in host memory and are fetched by the
> > > > endpoint, so the host and the engine can disagree on byte order. The
> > > > translated addresses written here, and the status/info words written by
> > > > __fdma_db_add()/__fdma_dcb_add(), all go out in host byte order, and the
> > > > HW-written DONE/BLOCKL fields are read back the same way in
> > > > lan966x_fdma_pci_get_next_dcb() and lan966x_fdma_pci_rx_check_frame().
> > > >
> > > > CONFIG_MCHP_LAN966X_PCI in drivers/misc/Kconfig only has
> > > >
> > > >   depends on PCI
> > > >   depends on OF_OVERLAY
> > > >
> > > > so a big-endian host (e.g. powerpc) can select it. On such a host, would
> > > > the engine see byte-swapped nextptr/dataptr and length fields, i.e. would
> > > > RX/TX not work at all? Should the descriptor fields become explicit
> > > > little-endian types with accessors at the hardware boundary, or should the
> > > > Kconfig entry gain a little-endian dependency?
> > >
> > > Hmm. Never tested on PowerPC, not this driver nor the DT overlay mechanism it
> > > relies on for PCI deployment, which has only been exercised on ARM and x86 so
> > > far (AFAICT) [1].
> > >
> > > [1] https://lore.kernel.org/all/20240430183301.46568e35@bootlin.com/
> > 
> > I don't think that the baseline expectation is that drivers are tested
> > on big-endian systems, but rather that reasonable effort is made to ensure
> > that byte-order usage is correct.
> > 
> > In this case I suggest that will involve using __le64 instead of u64,
> > coupled with calling le64_to_cpu() and cpu_to_le64() as appropriate.
> > 
> > Sparse can aid with getting this right.
> 
> Ack.
> 
> I am a little reluctant, when I cant really test it properly. Sashiko gives
> another solution - adding a LE dependency to the Kconfig of the misc PCI driver,
> maybe that'll do?

I think that should be a last resort. I won't hold out on this,
but I would prefer the approach I suggested.

...
