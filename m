Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81440B38C;
	Wed, 23 Sep 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154056; cv=none; b=XoAKRJDpwSkpa2a6PGG4mZs3Lnv38JLk+Ctktm+NEyLu5dH4DHCye4amv7h0f3VKR/UjgXRD2lkszF0S4eJosH/OhgHDp2eBFiqbyc8tLSRXcE/W3X2gMen1l5eAZqUKfk/3l6wIc5Eb19lkIHqbyJwwP7xM2l7BkMpagOoWS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154056; c=relaxed/simple;
	bh=uEzAGmm+d2eCLvndQFM46mFZuUXS0IuO1mRiQwgfeeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr3b9PKDU8oWJV+Bxbo1gwmDbhunWkbhNQl3jcG4eYW++zZZOoxua7H3rh7g3Y68kG5jc+6aIVKque6geYv5+W7JwEVY+AUkiyDL3rJCszdkEeKC39KWz1hs6fiO9lBNi9VyLgrBsY8qnR2bvnShIH3xIDSPSuTl2BHIgRxYuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpm5fEi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpm5fEi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A291F000FF;
	Wed, 23 Sep 2026 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154049;
	bh=SSNNLlOcgV5+a/p7HUMpI0Cbgs5lb/bti2MHEm0fkBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fpm5fEi1NJSxefT9yqK6u/GKP9/fciJCIfL5mC5R83B3StrmalHVvuT3Abv0IMGYm
	 CxU+NXzWPV3OHBsHrikPoQQgJlFB6vz3XbaHjn0vSCgSzfTZ+0Rm6pfntzrdfaVcJh
	 SjdZQmAN3ziidT5cQjJPfGGqAVzTmSlUKL5gqGOxfbyqrtUMvsh2ys/oTBOGTAsKd/
	 O+Ap167UvdK2i2ufMWuukI9HVP6451qIJOgFHaTAeg3i5VY1wx47dMFu14xh9wVt4s
	 GgzKpMjD7htnjvpqnDsQuUVTvtAquCa7LeKIwBpwP2YQ6LBRIlukT7ATAeMYtMahQp
	 2qsnrTJ0EmbAg==
Date: Wed, 23 Sep 2026 10:00:13 +0100
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
Subject: Re: [PATCH net-next v7 07/14] net: lan966x: add FDMA ops dispatch
 for PCIe support
Message-ID: <20260923090013.GP13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-7-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-7-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:33:59PM +0200, Daniel Machon wrote:
> Introduce lan966x_fdma_ops to support different FDMA implementations
> for platform and PCIe. Plumb fdma_init, fdma_deinit, fdma_xmit,
> fdma_poll and fdma_resize through the ops table, and select the
> implementation at probe time. Only the platform implementation exists
> at this point; the PCIe implementation is added in a later patch.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

