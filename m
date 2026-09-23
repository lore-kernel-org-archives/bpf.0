Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4E414422;
	Wed, 23 Sep 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153360; cv=none; b=I74jhMvS/Dg0qPrETrzGC3eCUhk45/30C+ZuVfxVkE8IOkKDedbeO0VPFnKMHXXOG0TUTwzSHBZOxjcie8KrzEhqJtWz+BvxwtaRxinYf/k5qNOLjUaEJY4VFT/BS6kMvVf6UmT0ik3HnwEgfXrNZBlgakGSwpln1Xg/w27+mwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153360; c=relaxed/simple;
	bh=cCCGHw7/DEA0GepKlNU2qM3ok3XRscT19tUf7Mps2XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHPSgutimu2MpirjU34CTl44yfqFwQ1Kf2S3U27j9lccXIwlhmC7YivKefmP+6vVOvMQ0kqDAQv3YXYpofemXDeLkfZezIaSXpWfpqRLf5amOIOojnscvtdhlUk/JstRLC1nXcoWDl2ADBmYUD6in4CrOSx9RZMZGSNs+NeXKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVX9AkCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVX9AkCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB811F00893;
	Wed, 23 Sep 2026 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153359;
	bh=f075M+FkaXFq6FQ+b283d+9CbB/IXNjPn2ZG7KSa2oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WVX9AkCHPtjL3cwKw6FP2SHlHp4k5uJL4DgzLsjaEIeku0zwp/COqWxMlvsIv7QeY
	 caIySluKoyNWvQUjY+Ur0uOs5MKCKAKCQwyIlHlrMu7IHTSGgPgdvQ3T/dE98Vyv7k
	 Yo7ULe8T55fqc/0GFtxZdY3OQvB3SFYPg6C19Do6PiaBfPB4hKCPeNOIgafTZLjfQL
	 4XFPYOy32Zijyos1O9dNvVHUOdbgCnKb9WR7+TOwEXkrQ3E+4n19+ZEpXk1eZc0Avj
	 AOnhA5I+tJLZY+EAy/bwfEiK7wC8zmWh06TpsTejkZPd5ciG4zB8ol0bNcrXFu6zD4
	 5Ep9Jojg9h7sQ==
Date: Wed, 23 Sep 2026 09:48:42 +0100
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
Subject: Re: [PATCH net-next v7 01/14] MAINTAINERS: add FDMA library to
 Sparx5 SoC entry
Message-ID: <20260923084842.GJ13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-1-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-1-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:33:53PM +0200, Daniel Machon wrote:
> The FDMA library under drivers/net/ethernet/microchip/fdma/ is shared by
> the lan966x, sparx5 and lan969x drivers, but is not covered by an entry
> in the MAINTAINERS file. A subsequent patch will add new files to the
> FDMA library, so let's make sure it's covered.
> 
> Add drivers/net/ethernet/microchip/fdma/ to the Sparx5 SoC entry, since
> I am already listed there.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

