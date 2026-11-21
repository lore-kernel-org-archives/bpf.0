Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225814;
	b=UE1nko876aPUQnkuMhF4hIqsKT0mTCCl7/vt/VYm1//ZbVy2t25RROf/iM8f8ZIIJwj7
	 pCX/LZ/qXH/mhzE/Bj07ig8Xojq6QdqFnZIOwxaohr1mmzPeVgAOd25Vf4sqJFzicLlHt
	 ptv0NvqGIkabKGlwgeSPyHBHWPqHU3X2f0W5QqlQrFwfDnWcHb42oIXPOzSslNglD09+T
	 UkUAeGqPtWokZXKCXoyRGcov/zQMAlYBlqbqYG3SsOGTFbeEaNG/SmBAVXoGxQvEz3ZqZ
	 F+EYQtj5IwejYlnue2V5Ss1yDUK3vt3iJ4iD2NE1liQNKyTS+ugqjuu6vbt2I0CLMCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FHj/Zy9VIbTu9QHe6UylXawidw+Q/iF3Pt00xxs1BPo=;
	b=h+AK5XcyHKzWVk8j/gIDvbPiO252JA0d2+Fv8we7jBP/cMLMHBH4hCcD40w0yUGUV+dM
	 jjRDIXTt265fS7q9pScNeA0/53zMNQFORM475EHrt5i/MHBHx201oCv05ye4i2IKRX9K8
	 RABEnbwEejN3jRZy6StdysbQZ8m8smh+xdkS2e6RFDB0CLLS3PK0Dgc9mKqRYoUdpv1f5
	 YQ29kkYIw02DBLv7aclWy1yIcUOsvGRRVu4j4g1ZIK5OQEM8CvZFtrr9mJCgknzGqOgg+
	 Iey/pan1EIepKiENGm8rnAThkCcGO6kgzqTWn2hUDflFATOcLXDPaFKlbzqWIok7o5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/4E/bd8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A4606A6AC;
	Sat, 21 Nov 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/4E/bd8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068401F000D0;
	Sat, 21 Nov 2026 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225814;
	bh=FHj/Zy9VIbTu9QHe6UylXawidw+Q/iF3Pt00xxs1BPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J/4E/bd8Au4OIjhaT6SE0R/7Ov89wx4DvLWNvHIYvgph3V3/jfWJVOe2Xw9palJ2S
	 tKnxYSkwyndOLgx2y19EY2gLpej9kvv9r5c8DwxI3O4o9fzApVg4+jvbcUw3BHk9rn
	 8yi3x9A7egQCCmBsQAwHqEBvlHmQNWTQhks/4bhmc5gO3Pn/dHHmBJn+mB/erefGJq
	 ea3kbuIGOzttHUGv775pD2rQLEnnJiWhjGA/nUZ+KnSlYbIzi6ezPKPzyrWVU2HFeT
	 YRAn0/Fzi2v0QHY2cGxh0gs7IOrTECTVtsI8Dg4NL3i2hf8z32m0XrHDYXEKPxLpYU
	 wYzW1y6u5qang==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1504380AA5E;
	Sat, 21 Nov 2026 01:50:13 +0000 (UTC)
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
Subject: Re: [PATCH v2] net: stmmac: Disable checksum insertion for XDP frame
 TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179522581252.882976.1234416180646847261.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 01:50:12 +0000
References: <20261116134848.4793-1-jszhang@kernel.org>
In-Reply-To: <20261116134848.4793-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Nov 2026 21:48:48 +0800 you wrote:
> stmmac enables TX checksum insertion for XDP frames whenever the queue
> supports it. XDP frames carry no TX checksum offload request, so this
> can overwrite a checksum already present in the packet.
> 
> dwmac can only do HW checksum for normal particular packets
> layouts, such as TCP, UDP etc. The stmmac_has_ip_ethertype() has
> well demostrated this limitation. Different with normal tx where the
> common stack supplies the skb->ip_summed metadata, XDP path doesn't
> have the necessary metadata. So to make the XDP always work properly
> when transmiting arbitrary Eth frames, dwmac HW csum needs to be
> disabled by default.
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: Disable checksum insertion for XDP frame TX
    https://git.kernel.org/netdev/net-next/c/7e7ef57374f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


