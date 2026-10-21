Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544703;
	b=NmqCppAoc19KGMXVawxjPCAksaC1L0Shkbi2XRKNW0RSryw81tBy4kqfTkIIMy+J2e8d
	 6EecUpqNMvSDoLYsHwhqQvGQ+hszU2NLNeXvaOSm3WC4kKbwODYggImQ3hqgRgrjyej6Z
	 CFhXrP7AOODCCXPF6gXz038//RrpN1v5KtQshmk7xHypvLl7mBrzsKEnTLl7grnERax+S
	 ubgIwTUToMXWoQEmJ0fR6SUKPNhWaRvBMWkAXoGsWxE3sPEnufjWWS5ZZlG0vpiCv2P61
	 ARtqQtRApZqRKdL8856OaFyv5DM/IFq0bqPSzn05+biesv0t5ayFuOytDa2uY+H9B+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544703;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Nek6SQB9HilcNqrUDKvbjnwNeRbszXlVW1qjIvvxAf8=;
	b=AGYQ9WvaP2AG13uI7zfRhBlDfhLdZONLMAxKrXwNlzEiBaoGmSVVrrrgIC+5EQZgtkTj
	 awGtw8x09WnCaQN98tK8dPEs+RYGyrjUrk1FbnuGJvoXzeHgs3b1tAwhICH7fLI8ZafsG
	 Ne14ERutplOfqRVSdVIs/pYeZYCzhw3C5sy+JdOjsxjvrCwSgCWHMP0EJXfAYKHiEuaIn
	 yKS8m9/74m4zh2W54/ReIwlv6urr6Bv6nsGlNTQVkotelmtr2abweN5jV44nD24TZiwnN
	 GVA90tehRRd2Zs/LE6wUzxBnCFW6wB2mQEPaJammS5/PxNCOIsAtGV+Pz2aEgA8P6yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQn6XZEm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD140606A319;
	Wed, 21 Oct 2026 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQn6XZEm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B860C1F000C9;
	Wed, 21 Oct 2026 01:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792544702;
	bh=Nek6SQB9HilcNqrUDKvbjnwNeRbszXlVW1qjIvvxAf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CQn6XZEmx4JuBxOCkGUoJxghD6fgxKGGvSTb7ELHt1bjWPlVx48I+kyKIgnc0qr7c
	 NhgbVZWa4Lwo67KLrbjDl6sjNbG4cTE3Y5zwpFpZVpbAbOITcS/Wfx9vxPUj1slJkb
	 WQsgQF7PJo+NWG+9REo4JUnCIzps60aCpEq1pTNgCxknuRGsxQ/gOkPWoyRJ4hCZQJ
	 oygMrQghn5CeQf526xtBNeHcN/kfyQUR9srbICRbEtVMDVVoumuUqSJ5TVXxHPjBdT
	 nNgxYhhdyIj2yHGGFqz+jS84eNxdAe8gyzYkwDhnv3dL3FzNUVDWKKnYaMtQSYdKhy
	 MV4yOooKiLIxA==
Date: Tue, 20 Oct 2026 18:05:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eric
 Dumazet <edumazet@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: Avoid freeing and
 re-requesting IRQ during XDP set prog
Message-ID: <20261020180501.59a77f38@kernel.org>
In-Reply-To: <20261015-tc956x-stmmac-no_irq_teardown-v3-0-8189870be545@riscstar.com>
References: <20261015-tc956x-stmmac-no_irq_teardown-v3-0-8189870be545@riscstar.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 15:55:00 +0100 Daniel Thompson wrote:
> Currently stmmac will run a full cycle of IRQ tear down and setup when
> setting up a new XDP program. This makes tuning TSN systems difficult
> because whenever a new XDP program is installed then the irq threads will
> be stopped and restarted which will undo any thread tuning.

Series does not apply
