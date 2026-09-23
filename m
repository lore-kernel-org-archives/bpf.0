Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66E47C0E1;
	Wed, 23 Sep 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154090; cv=none; b=T6vXpAo92CkmF12iZlP2LmL2mYKnQuvvjllk1Vztj4jQgnqsfag8L8hZTwnkOdxhYFvzJXiu/WgF06Mrq5e20CQlbRk29WVCrXuU+Qb2a4mkJ2K7tN/flwVCHBkU8gbHFfo8KzTYRfD/7oVITbliYhZgz6TJl1NaE+1e7kKVUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154090; c=relaxed/simple;
	bh=ISzdWoXfaKo8vJPGY0V42vVJBxlBsiuOOm6jPC3xnbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvZqd/nlAnDu323gpmNtU6VjzdeLoF6x2vf4XVVZTgkAXFswImRsCcolcBQF0qacgo1Mle2keHAwBp4OfmlGpJUf8QaJM0jCShrPj8r8+WQl/MlS/wuVza1ewh0QpD62ecnYNxyqj/31NidSbavcSY08JWOyeKafLRy97HDoJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQDVBRwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQDVBRwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B18C1F000FF;
	Wed, 23 Sep 2026 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154089;
	bh=C3iALwKhweGWgTgs/ynHjahU+T6YJ3fzthsWNjuqcpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KQDVBRwgaZwcyX5kpUVev23cDupF4Yh0z/fQO5qma/hc1uSWR8aM3MyA/UoS0L4Xo
	 bzk2Kxuq/oqwzFX1QgelXBLrA3Si7Ttj7nClPFH9WklMhJN+O0Ik3wOZxjNuQ1ueoi
	 Snw0YyzBU0UJZNACEiSNy2w5aeGPhmI1Ncdv0uUrN5tA9RD9GHHPP+78+sSxbbXBmr
	 fn9OLDprYrYuhrQNcL6V7CkdphZZJ65tn1kdFp9R3qHl/Kx/Bvv6hHt/SGsm8lRhz+
	 wytn/6x4dJlHU+gzet1xW3w2o7CsJUu9jfW3j8X/p/jq60GgcUg+OofmGnWbjRMiHc
	 9UZk/FFH3rBzw==
Date: Wed, 23 Sep 2026 10:01:23 +0100
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
Subject: Re: [PATCH net-next v7 08/14] net: lan966x: clear FDMA interrupt
 stickies after switch reset
Message-ID: <20260923090123.GQ13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-8-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918-lan966x-pci-fdma-v7-8-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:34:00PM +0200, Daniel Machon wrote:
> When in PCI mode, the GCB soft reset issued by the reset controller
> can latch spurious bits in the FDMA error stickies. The latched bits
> sit in FDMA_INTR_ERR until the FDMA IRQ is requested later in probe,
> at which point the handler fires immediately and WARNs.
> 
> Clear FDMA_ERRORS, FDMA_INTR_ERR and FDMA_INTR_DB right after the
> switch reset so the FDMA comes out clean and the IRQ handler does not
> see ghost errors on probe.
> 
> The clear runs on both the PCI and platform paths. On the platform
> path it has no effect — there are no spurious stickies to clear — but
> keeping it unconditional avoids a PCI-specific code path here.
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

