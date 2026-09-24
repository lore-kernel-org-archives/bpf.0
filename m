Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D04A3D28;
	Thu, 24 Sep 2026 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263905; cv=none; b=OIxBSEyd8AaoVF1MDOVQqJC952E5tplotzZZdY/xjoEQc4aLS4U7ONvewW9FujG8z27zI+bzQObsCwW6hUxzaAOUVq4igptiPC06lODqE9UJuI0dRwQsON6oQaGwFzctrOTtekUCway1unvS14USY1aoFXcgWKrE/ZOoZRaZkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263905; c=relaxed/simple;
	bh=BnX5o5678+dXh41cBXWjTwI7OMQmpH0M30x8Bvl5Aug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCmAftXpjzbNQfR903COBzy+0zQidds2xJCxkt8079QtTd7NBST4OhpFGYTATkdl86TVZu/LWUOZ3AM9zgmCvE6DX/f5R0yldmw0I62u1wGVO1ZdiJCtGpUttkHO32fBhiV8fWYqtitMUjAVpsAy1ZXsmSauRxN0e1YGWj0G1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUdAey/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUdAey/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EDD1F000FF;
	Thu, 24 Sep 2026 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790263903;
	bh=PJsB05AjJ/cKcal0omGmz6Mh1wn0N/L2T5+QooWmyb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZUdAey/4b08tNkuWELhF4djU3Q1gl2NJ9Pk605r1+X3SP3UzgUuFUTljQJO6CEzU5
	 yf7/ZDeCQlr7f73tv75PoXb+6Oobp5DHq/ImoI9jQld86L8uluSygbDYNbafFbG5bW
	 y6buKYc+UYNyiGGKMF4easgOkNBD06aon1x39CLu0MRfOxLD4cQBq9quICXHptWIWd
	 wdUfdDVzbo3LZsgToPtaJd7ek1udGry7+xdyOjkI+AaUfC32/3NXZvW32VIs8ieo4c
	 cfGPqsfBphjnP1/yJHZqh3h1QExX8R+DmbHKtxXi4bnaDI6/eMRI8Q7PoJUMxI6HHU
	 FCmPHzliQ80pw==
Date: Thu, 24 Sep 2026 08:31:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Daniel Machon <daniel.machon@microchip.com>,
 netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 10/14] net: lan966x: add PCIe FDMA support
Message-ID: <20260924083141.67eecb6e@kernel.org>
In-Reply-To: <20260924064617.GY13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
	<179008205148.2160803.12818321368571406375@kernel.org>
	<20260923084538.wgkw2nt5ergoxcot@DEN-DL-M70577>
	<20260923180730.GV13925@horms.kernel.org>
	<20260923201155.lbbbtx22adz2ilhg@DEN-DL-M70577.microsemi.net>
	<20260924064617.GY13925@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 07:46:17 +0100 Simon Horman wrote:
> > I am a little reluctant, when I cant really test it properly. Sashiko gives
> > another solution - adding a LE dependency to the Kconfig of the misc PCI driver,
> > maybe that'll do?  
> 
> I think that should be a last resort. I won't hold out on this,
> but I would prefer the approach I suggested.

+1
