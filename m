Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593188;
	b=x5SWw/alC+GsLcNquTy6mRJJy5MN4UbMhOdmJiJ8ubSqWqJSf+xNywV1SrB4cjSFfzqB
	 rEcXpCT4k0ivS0zc4rpcg4YgV3nQGEh5i187FHdnUvr66FbCGOD5zmzKiae9fCPfDIC7F
	 qYDj+Xu5FU2H0tu+jOGsOdZOfcwLUYmbGl9oM9SxgZoVNz/EtFKw4loAChIcdEfSsQO3v
	 ueF+h8eRIQnwtsxV6KhXhz1fMfB+H7HsXf6M4sGbCKTHVf8ISD+N8tyeb2MkrSesGY7Nl
	 jRy6Yc+bA2G2hNz7AiESPM983Gnb4cvTytpEwKDw1luHBvOCy2lxGGHZwyqKZHn1sKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593188;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZO0R7AUCd3fn8n7Ia6A45uzQOJbzCgxNKEP+cM/ZrgU=;
	b=JUCtZ8OWPprSSbWNTYDWTN8vkEkk7ZOLUazJOLFx8ZIjqY9/itC7e0p1B3R8bbdotbu+
	 QD+7qr82bxGmZxR00EOFTg2xIF5ltObO4yBILx0Z8HzrcYvZZxZ8mpQlHjlgRn35KmeR4
	 qRQE6ljEBGXoP8pOKqAsCcx9p8Mmzq11QIpLrPeg19PPrDbfDwP49WdyDvdKhWXSy+X0z
	 rxmzeAMwZX2OLMW6ppn8GK42BEF106Tv5dSRb/IYMvKF7nTQsu1BoQjUSMWEvEm+xB3A2
	 pKCpZ3z+0i82Mt9EUhTfeI1vsdtT46uZzWbbb8iJHssQPf9zadXyTc72siSSDyP/vIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL71qw1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D882606A31A;
	Wed, 21 Oct 2026 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL71qw1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177EB1F000C4;
	Wed, 21 Oct 2026 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792593187;
	bh=ZO0R7AUCd3fn8n7Ia6A45uzQOJbzCgxNKEP+cM/ZrgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EL71qw1TUN5cW41RTrsuoUw2znHrbg0f1ajBkG3QMsazwtTvyR5ZaKNIoRrtyhDm3
	 eJoFN849bTc5gPNLOoGIwAi96XBWmfWNXRJPjqhHeLgyIpEECXz/PIY/5+tBoVUqvS
	 FycVxB/tvFuRBDJBI7/bl6CHcuuUoSMWSjCIbOprgClI1lXMMJ7T7lJ33lh6IiKHN3
	 4gvi8ToDmBdVy9uMYzhuc9LF6HWJtT7SDee7mCoPBl070yaAF+gb6DOYv5htAqZT+Q
	 L59pNgrK82cbE4BIL7BNqc6SaVyGhp6alH/KhEP4YCwhKSoRszm7hGQ/OYWwsf1zhY
	 FjhRmN46nG3eA==
Date: Wed, 21 Oct 2026 07:33:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Song Yoong Siang <yoong.siang.song@intel.com>, Mohd
 Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] net: stmmac: Fix XSK crashes on stm32mp2
Message-ID: <20261021073306.61972417@kernel.org>
In-Reply-To: <874iefjjan.fsf@jax.kurt.home>
References: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
	<20261020140849.12fc79ef@kernel.org>
	<874iefjjan.fsf@jax.kurt.home>
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

On Wed, 21 Oct 2026 15:05:20 +0200 Kurt Kanzenbach wrote:
> On Tue Oct 20 2026, Jakub Kicinski wrote:
> > On Tue, 13 Oct 2026 10:57:20 +0200 Kurt Kanzenbach wrote:  
> >> while looking at the TBS thingy [1], I've noticed kernel crashes. That
> >> happens when opening or closing an AF_XDP/ZC socket while parallel Tx
> >> traffic is going on.  
> >
> > Let's respin this against net-next. The merge window has started,
> > applying this to net would give us an immediate conflict and pain.  
> 
> I'll send this against net-next when it opens again. Thank you.

I mean that you can repost it now, just rebase on net-next.
By the time we apply it net-next will be net so to speak.
