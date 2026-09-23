Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A372FE042;
	Wed, 23 Sep 2026 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124055; cv=none; b=bdmORqo0a6ZUAEIv85l1D5/dofeN2B+CkhnaDZf8LbUgshf+wtLdvdVzU2+HgcS7ccdM/Cz2s5koYd9ougXDvGgEPGvfr6r8YRWUyfvfj6iaU4jcaGlnEg5YV4GKSRb65Z/CPBo83LtT4593Q5TXNoCorNH4sNwZ/iFTeFuK1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124055; c=relaxed/simple;
	bh=VyFbd6nfqIJNWgv40gqS7FIzOAgYWXfIbC+TcrSFa6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ8AkkUwtgaXRlPeZMwg8bVFRLnZSZO6U5xxZxzMTh4WCSw8/VSR+ThCqCl2S3NevZe0TKTyd6812O/+fgKKaNdkxexxXwkKVW9IrL2GyjoWI5JIaH/9VeKpus0777cb1RcGQUbuI2pWofE86rfdvuymh/eLy78jMM2NMjA5/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fVSSknXL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fVSSknXL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=byxZ3eQ63Vk9Fkq/DUT6PLJClKF/+WKsC5v2xz1cokk=; b=fVSSknXLY7SnkYsBrHenn0upvD
	aCkBvgdZGdFKY8xc8qqCgV4BXxncsWrorpDQpA7dzXqKYnXMpv8ZuUg2OT57RUdvjpSgoGn1Ig9uI
	NJqjRnaIo0uAhvaZHeSK2FLg23ECawRMG5qlDi6lMsF/tWZmExgMpuBkDSNSSS169eD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9B23-006hOo-TG; Wed, 23 Sep 2026 02:40:19 +0200
Date: Wed, 23 Sep 2026 02:40:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Alastair D'Silva <alastair@d-silva.org>,
	Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: phylink: allow stopping a suspended
 instance
Message-ID: <f93298c9-33b1-4954-a213-828925df30a9@lunn.ch>
References: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
 <20260922-submit-stmmac-reset-fixes-v1-v2-1-d92e609be996@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-submit-stmmac-reset-fixes-v1-v2-1-d92e609be996@gmail.com>

On Tue, Sep 22, 2026 at 05:27:40PM -0600, James Hilliard wrote:
> If a network driver's system resume fails before phylink_resume(), the
> network device can remain administratively up with phylink suspended.
> Closing the interface then needs to terminate that suspended instance.
> Calling phylink_resume() merely to make phylink_stop() work is not a safe
> substitute: resume reconfigures the MAC and restarts link resolution,
> although the driver has not successfully restored the MAC.

The first thing phylink_resume() does is:

	if (phylink_phy_pm_speed_ctrl(pl))
		phylink_speed_up(pl);

Is it guaranteed that phylink_stop() followed by phylink_start() will
somehow do the equivalent?

	Andrew
