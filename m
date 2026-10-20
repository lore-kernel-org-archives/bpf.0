Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495810;
	b=iZxH8ueV7OX90xQGxlxkoNJ2zAHvJUlUVqJ5HQNi4WQ9TbOXt5UTy+gZY2c/pu71XS6l
	 F+jsncGmSH0U/ke8App+3DvyA8QeIhDhHq5BipPxfO7QbC+Ek++ai4d9J1z9jbXtAh47u
	 YWgvw/3VniuTxsS01VlDDSkrxFaPYLoWRTWUmZVHICKdzORzoSkfB2Z1Y3WRI9/IJXxYI
	 b1McYOThKNzxhld9CN66sQ7sfnsvqLVDl/kK1D82GTpmD0WPErStzTVft40mCyzGANqXo
	 vFVMp5klmUyXNTnEtHcvlKNIj54Qu8/8T5DD2Dy4efzExZdwp6IJLEepSapWmQll4cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=WNzvN09+u5OQMM8RhOHb4xncYgXuaiHDoxMOmi2ghBc=;
	b=epEAgqTP8dlJAV5s9pmiD0GWBSKKE/3cxHp1B0Xl3SXV+ipm/fT4HKTKdR6ZVohKVxTw
	 CsVmceTR2hynqzCR6x8R1f289ZG58R44kpjKBUmAfCWsGnhIc+EeCxuxvWXCgg1D2oYXs
	 4GrYxVzY6nXhajwtUJEtYZFCYhl72y0aTWKie9wy2aeKKswZZm1DCiZLHqWXqu13QYU0i
	 SgOoNbr0qAx5Dp6l92E1ee6Sm6+vmx3m4O2zSFCgJlYdPt0mn14MLxaDK27YSl6K03ghl
	 iaMR6m1I+e933G30fiDQzp4rFdxl4yBOgLJfep66Y+OjPw8Vomnz1kkahVYgNNFRXQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJIqhAk6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D9606A328;
	Tue, 20 Oct 2026 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJIqhAk6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5681F000C5;
	Tue, 20 Oct 2026 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792495809;
	bh=WNzvN09+u5OQMM8RhOHb4xncYgXuaiHDoxMOmi2ghBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kJIqhAk6H6ec91Q6x6d3y9lW6WVAYFdoNpQY4/ZsPFMqh+WjK6MYqaJy8o9kZ0RKG
	 ofurGH6xE/3s5ipG9LRlBEFD6FefkcGQaWJNZFtaEBXWZR4LuRCs+3MdgsuQ8Tl1eq
	 AS0DnYJpGW17IAankHeNT18GiEICm9/+oUXPdw/RiJ5e9ud3LVSUHj89jDyn9XT7pI
	 n5KsVGXxw577oOv+AAOPlUIITO/sVPvC7nlUOJYums8jmGYRdxppVDRW8ykMeclKiD
	 CfiHQwIxDEfrgvggywVkQoQMifFzNUYyWizS2IRBCej33pYbSYbFI3578NjYkRNzs9
	 AM/WjrgeCQ3qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44B53808209;
	Tue, 20 Oct 2026 11:30:09 +0000 (UTC)
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
Subject: Re: [PATCH net] net: stmmac: avoid duplicate XSK TX completions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179249580829.3679022.10463877602062629830.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 11:30:08 +0000
References: 
 <20261013-submit-stmmac-xsk-tx-completion-v1-v1-1-f21b9d098e62@gmail.com>
In-Reply-To: 
 <20261013-submit-stmmac-xsk-tx-completion-v1-v1-1-f21b9d098e62@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 boon.leong.ong@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 14:35:42 -0600 you wrote:
> stmmac_tx_clean() reports completed AF_XDP TX descriptors through
> xsk_tx_completed(), but leaves their buffer type as STMMAC_TXBUF_T_XSK_TX.
> The slots retain that type until they are reused for another buffer type.
> 
> On interface close or XDP teardown, dma_free_tx_skbufs() walks the entire
> TX ring, not just the dirty_tx..cur_tx range. stmmac_free_tx_buffer()
> counts the stale XSK_TX slots again, causing xsk_tx_completed() to advance
> the completion-ring producer for buffers that have already been returned.
> This publishes completion entries without matching outstanding TX
> reservations and corrupts completion accounting for a socket which stays
> bound across the teardown.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: avoid duplicate XSK TX completions
    https://git.kernel.org/netdev/net/c/daac93975b8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


