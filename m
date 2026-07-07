Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACED15E8B;
	Tue,  7 Jul 2026 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427467; cv=none; b=U8xuRju2XfAv4GwiUByhWeqb5JZvampIRo0BD0kXmrBEi4KG/YSRpF8OtT/R09I8PFMf2jirSX9nP87cyQpn4Gusr2fbVblt7qmZFX9RN76Si59TykwnzGZmubHZ9esKAmLQ3mQAd+F6V+5hBYJI1UOgW7VtpMGfFaXn0/EZ6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427467; c=relaxed/simple;
	bh=E4BEozHHtTSkSGV8Rk9+sjvBGqUJqw9CaHbPk5V9hRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU+xIGFeTqYvv+YKcqRRj08L0bQ06BjWFuciQ5RCdDhNQmStNmsUzpPydk9g/AJc84Y/KS193iS6I+swIB8FHo36vUJSRY0fJRiBCtvc+2eV03VnJwpveW/8kLuOfnCaJ2hXcYXEgxia0biFXF1xluHmJcbdrTqqxmwJgzgHsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XIu7VbCJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XIu7VbCJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cbADDMxZOUl90eLH+497cEm5EOEWvROIQWQdHvcJbd0=; b=XIu7VbCJJ5FSDP+kiIZr7v7aZQ
	cWr5G4/+cmIowfkA/MRJl9l/ONJvX97HXe6BAvm3DSf4gZp8V8N/dRLpCvb2IS0Sq7aYqKcq0m1Vj
	QoIUOqLBlgAoyCzv7QKT6cyQvcXTgjpmzw2DIWuzfEhwV3fR82NxlcEnjcWy3udvAGIg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh4wm-00B9uK-EB; Tue, 07 Jul 2026 14:30:44 +0200
Date: Tue, 7 Jul 2026 14:30:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Message-ID: <9f949b97-da81-4bdc-8be5-68f7883d768c@lunn.ch>
References: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
 <akzLgrzsw4xYmnLH@aspen.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akzLgrzsw4xYmnLH@aspen.lan>

On Tue, Jul 07, 2026 at 10:48:50AM +0100, Daniel Thompson wrote:
> On Mon, Jul 06, 2026 at 05:17:58PM +0100, Daniel Thompson wrote:
> > Currently stmmac will run a full cycle of IRQ tear down and setup when
> > setting up a new XDP program. This makes tuning TSN systems difficult
> > because whenever a new XDP program is installed then the irq threads will
> > be stopped and restarted which will undo any thread tuning.
> >
> > The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
> > from stmmac_xdp_release()/stmmac_xdp_open().
> >
> > stmmac_free_irq() implicitly synchronizes interrupts and, with that
> > removed, I was unable to prove that later actions in
> > stmmac_xdp_release() are safe when there are concurrent interrupts. To
> > avoid problems let's also move the code to disable DMA interrupts earlier
> > in the sequence and explicitly sync the interrupts handler(s).
> >
> > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > <snip>
> > @@ -7156,10 +7201,8 @@ int stmmac_xdp_open(struct net_device *dev)
> >  	stmmac_reset_queues_param(priv);
> >
> >  	/* DMA CSR Channel configuration */
> > -	for (chan = 0; chan < dma_csr_ch; chan++) {
> > +	for (chan = 0; chan < dma_csr_ch; chan++)
> >  		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> > -		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> > -	}
> 
> Sashiko picked up that stmmac_init_chan() has the effect of enabling DMA
> irqs, making this code unsafe.
> 
> Given stmmac_xdp_open() can only be called on a running interface (and that
> stmmac_xdp_open() explicitly sets sph) then re-initializing with stmmac_init_chan()
> should have no effect and we can drop that as well.

Something i like to see is symmetry. In theory, stmmac_xdp_open() and
stmmac_xdp_release() should be mirrors of each other. But i don't see
anything like the opposite of stmmac_init_chan() in
stmmac_xdp_release(). So i can well understand that something is
wrong.

Maybe rather than just fixing this IRQ issue, you can look at both
functions and see about making them symmetric? I've no idea what that
actually entails, it could be a can of worms, which is not so uncommon
with stmmmac.

     Andrew
