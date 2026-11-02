Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617208;
	b=PH4r/gELq/6KBKKavZ63kbi3TB8NfLTLR6/iYMK7bcog1GwZ2NLMs0H14v3J57/jAv1w
	 f2CuBwwzgMeUQ1yBBVCcCnRhFtVFu6cWAqJ9NF1HtDt0co7mHfLwMPw+rr9/5y4355+cc
	 aOaBO6CL+zIEYi0wmkqBcCKofKZKR1SR6e1MF+bR1vrcuQBR7NGTNSnLgds9+c0ojUzXs
	 ilq8eEpis8LZ48srdSN8eW4GS0LHVAQ6U9JoDBC/BFT9t9cydcHd+P6/MmDn0m8ojo//v
	 A5gZaHwoR6fXh2cBDZO+alqBWXWsBJ0Cx3sUMixTMqJf8TcHDEBTy+UtmwyS7UFlegw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5iQnN8C63bWH6bekwH74CSDmUU2uCzmKfmamRH3PQoo=;
	b=xfHc6qHVMC+8nPreHrEPpr5x5jFMfriNN+aik1B+PeTZzRo/KHZWVs9oheijSsk223b/
	 OXL2318MZW6jDrEw+8NzhgrWjaa6wnnsQwSxG81tc9MBRuR/UI1N0ZLNZ2+7NKycj7WmK
	 6OPgRvylsyjWh1ygOYPaxy8OCKWV9jCHnJlmz/LkOQsNM6aLEy20Ln1qwfaaEoIxeU9B4
	 pct65EVpXSyLhHVJu2cHIUdi06XTCHDCzOdp72WwhYn/D7TT2HMvfhiHF3lBdPpCqnXQN
	 5n3/s0aqZ5RqTMy2/ZOC8yCwcw6jrNE1XUe4gZ+YEkbD7Ag4+HWrbZWc6LBEhYTOamA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+sUANhi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A0606A32F;
	Mon,  2 Nov 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+sUANhi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1A1F00A1A;
	Mon,  2 Nov 2026 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793617208;
	bh=5iQnN8C63bWH6bekwH74CSDmUU2uCzmKfmamRH3PQoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B+sUANhi1MCbeOc9OJhw+ITLJ+WMmIZV42HIb1sLDzJnu6nzPvXPJQi5Q8M4zkiM+
	 uy2dYdNZ8xnwoMfrE864BxdsPHP4FRKK3Sut55ddiCKmYU/8AX4EkXyWQ7FBn2+8in
	 7Jtn1hvRdyIc30GbqS9H+Ff4xPRVsOPfo9iZpYxErpn6V1tcYMTvEKGr+VrNYO3HOf
	 hbsa8hQMK3SDdUX3Z0nk8vM55S1nV8L6UP9IWjz/sxHgdS39pvSogRKuZ5Hd05ERTm
	 DhmJRY8JUkh9UP4pJLdAdriKG0ALBt341dd+uKGizBmxi0EhhhcUUFNYKv9AwHdUG3
	 wuDUpkVNdazUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FD2380821F;
	Mon,  2 Nov 2026 11:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/6] net: stmmac: XDP path fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179361720655.3945611.14288786310433074072.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 11:00:06 +0000
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
In-Reply-To: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 james.hilliard1@gmail.com, nb@tipi-net.de

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Oct 2026 14:48:35 +0100 you wrote:
> This series adds some stmmac XDP preliminary fixes needed to introduce XDP
> RX multi-buff support.
> 
> ---
> Changes in v2:
> - Rebase on top of net main branch
> - Fix commit messages
> - In order to avoid possible dirty cache overwrites, sync the full page
>   dropping the xdp_buff in stmmac_rx().
> - Link to v1: https://lore.kernel.org/r/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com
> 
> [...]

Here is the summary with links:
  - [net,v2,1/6] net: stmmac: take ownership of saved RX state at poll entry
    https://git.kernel.org/netdev/net/c/26219e9402c2
  - [net,v2,2/6] net: stmmac: drop split frames on AF_XDP zero-copy RX
    https://git.kernel.org/netdev/net/c/834ec9530832
  - [net,v2,3/6] net: stmmac: drop multi-buffer frames in XDP mode
    https://git.kernel.org/netdev/net/c/52ffd771e002
  - [net,v2,4/6] net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
    https://git.kernel.org/netdev/net/c/41d78e9ac098
  - [net,v2,5/6] net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
    https://git.kernel.org/netdev/net/c/68bdbffcae08
  - [net,v2,6/6] net: stmmac: fix XDP RX buffer DMA sync length
    https://git.kernel.org/netdev/net/c/363ff816277d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


