Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390040926E;
	Wed, 23 Sep 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153474; cv=none; b=UykALcX804FyG5CF6cEz7TP4j/42fU3fSl3AgUn4zi9WLNWgJrB4WCFT2ptPL9DHLmtXlLH/SfXGEJTSW2V3/BARNmvBDeFyHpZNeV6PwzAO78m0qspA10Ezb/uuKLD0oMCgWZ5pOMN/Vv812Jkcom8uzokhjqh/f4ASVobLUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153474; c=relaxed/simple;
	bh=+7FMOKX/U495rXpqit8lAtAJb9+uYHSyEnYDT1BGj7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJHFFmZeME0JTnFP5IpUYITv0du3FgLkv1GXEWltoT3oZw6946vrjNZxkhnxckiUkkE5uVeu/fTAvP21fmOrbOHfA79NvAu9wxJ8aJuHpt53K7Pjcx6UxOnVgLFyJTrcYitufKOKnaJhfy4zO7UhUBc0C6OeyS3WAQ4TQwvk7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U38BvoMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U38BvoMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B79D1F000FF;
	Wed, 23 Sep 2026 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153473;
	bh=9R/jdzp6H0trc2YHptwzrPBCOeYRbcCIeW7Re4MZVEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U38BvoMok+tVm3LD4Ox8Qje/Ld8r5MGUiJpdYr/Jfkn9dkII3NsVjrgAuBnuRCiXq
	 ogWXrdHo7tAqB7qAi2wc/OzUqDtWz9zl9+GPwdlr/uqVyP+6Gia9GfHI6VLfKDZfHC
	 nIN/kOJ028wE3w9LEY5xJ8np+WrRCSyUKdapHmMQ7XM5CrtM7UGYutgkC+yL8E0jkR
	 6rwemc1YCu2rFOe3+75D0zpdfR7MIPncEdcboAI9Mc7t3kmDGT4M2cyE029ClKegr8
	 RRzwKOUgVEBsbGHRoHcSo7CFAHyvH6TJhWsU1kUe4A9RCbf5hHAUmci0WI027bQfCC
	 4QmrVM1TVvucg==
Date: Wed, 23 Sep 2026 09:51:07 +0100
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
Subject: Re: [PATCH net-next v7 03/14] net: microchip: fdma: add PCIe ATU
 support
Message-ID: <20260923085107.GL13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-3-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-3-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:33:55PM +0200, Daniel Machon wrote:
> When lan966x or lan969x operates as a PCIe endpoint, the internal FDMA
> engine cannot directly access host memory. Instead, DMA addresses must
> be translated through the PCIe Address Translation Unit (ATU). The ATU
> provides outbound windows that map internal addresses to PCIe bus
> addresses.
> 
> The ATU outbound address space (0x10000000-0x1fffffff) is divided into
> six equally-sized regions (~42MB each). When FDMA buffers are allocated,
> a free ATU region is claimed and programmed with the DMA target address.
> The FDMA engine then uses the region's base address in its descriptors,
> and the ATU translates these to the actual DMA addresses on the PCIe bus.
> 
> Add the required functions and helpers that combine the DMA allocation
> with the ATU region mapping. These are used by the lan966x PCIe FDMA
> path.
> 
> The ATU cannot express a limit finer than its 64KB region granularity,
> so pad the mapped allocation to that boundary; otherwise the outbound
> window would extend past the memory the host allocated for DMA.
> 
> This implementation will also be used by the lan969x, when PCIe FDMA is
> added for that platform in the future.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

