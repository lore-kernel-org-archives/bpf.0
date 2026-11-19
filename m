Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129206;
	b=uuHUsUkI0eZ6VQM886leKWjvdvWhqbhI//yNcB0+8XjUaAdm6mc4RuQum+/Uxe9Wcvun
	 ugvImAOZQXTeVJgxl/mbZaX1YW+grRYd7ofuuo1OGlrLuTesWmuip8LOSpO4UFBXn1MDJ
	 JY7w3T/TKG5OJfw4t5VVz8uEjY1DoiukAiKGyYVg7wts8oEGF9Xc2EPaTG91MJ/JrrPP7
	 ughxGAn0tFZXdcNSme3iIU6NsAO8Oy9v3uFPSyyEP81ZXNRXbwYZVW6LCqvzK9s/MMk8y
	 NnknzkY5+BnMexj1lYac24X1b0sN6gpDSn5c/Pu0291RnQjpwb3P16NN/ofx4120QUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZwNqfd/ODl08kn0gCF5pEuaFr4IKC9hu1iMaP7bAi+w=;
	b=Uea6pJl7JpJSHS0Dn8BGSSyTbPquJHJHUfRV8fKeHhnt4oo6B8MYDXUHYDkQ3vG+dZD0
	 v1AQjW3SMfhZuAh/tZX9YYO5xAL2CsnTFo3B34b3sSmblzTrmiTjskHnf0rs/lZGr01aM
	 4RemRRjY/tvnwuRwCEsK2XuAkEU63VaxbUen8eSFKCxhJWG2ZW5cXS2zFgkiB9M0+23FN
	 haTwWJIPirGQX984cF5k7eJ3E2h3LSCKT/iUHu/y58xKe0z8zAiVuaRZ1VzLOJDKNP8xo
	 5eMX1tULNSbBhf5o0CpWDiW0vOEChnb7zyw+DDEN5EoftJY5IkqfKx4ljBqLAV07RbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjEfug11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E1606A32A;
	Thu, 19 Nov 2026 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjEfug11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3F81F000C4;
	Thu, 19 Nov 2026 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129205;
	bh=ZwNqfd/ODl08kn0gCF5pEuaFr4IKC9hu1iMaP7bAi+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hjEfug11oE92j5tXZnKI2dU2lpKVZByphynV1t9qBCKA3qnOSJdOtboGH7dLBkaci
	 teyO3+hIN9gSRdI3jQ2as2DogtUQJ7CMg9Z5moIRD9uGG7/19Sb7UP3bx0iskm/k5L
	 WCOtMStCPiTLa90UUfGM1ekSipAI3e1OI2Gqj/KPP60jBO5Y/9PP7j232IoGhHMs7A
	 DDHgn/0+jLA0TUsRugXSKNZEQKsX/sssfQUCg/EAphdW3v7Ofz9r7sCbOGnzZdf5D6
	 wCcczJMJ5bEP9QrzKoC/I4y1AFXp4vpLvMUL9DsKClT/MwVhv3+MNuBEs51sMUycQr
	 wGQpbUNMcs5jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B46AA3808209;
	Thu, 19 Nov 2026 23:00:05 +0000 (UTC)
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
Subject: Re: [PATCH net] xsk: reject TX checksum requests that overflow
 skb->csum_start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179512920454.3911009.381821320115182795.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 23:00:04 +0000
References: <20261116162834.30087-1-tianyi@cloudflare.com>
In-Reply-To: <20261116162834.30087-1-tianyi@cloudflare.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, yoong.siang.song@intel.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev, sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Nov 2026 16:28:34 +0000 you wrote:
> xsk_skb_metadata() sets the u16 skb->csum_start to hr + csum_start. With
> 64K pages, csum_start can be close to U16_MAX, so the sum can overflow.
> The checksum offset then becomes negative. With XDP_UMEM_TX_SW_CSUM,
> skb_checksum_help() triggers a warning. Without it, the device gets a
> CHECKSUM_PARTIAL skb with a negative offset.
> 
> Reject this with -EINVAL. Use the limit of skb_partial_csum_set(), which
> also rejects U16_MAX, the "not set" value of transport_header. That
> helper cannot be used here, as the skb built for an IFF_TX_SKB_NO_LINEAR
> device has no linear data.
> 
> [...]

Here is the summary with links:
  - [net] xsk: reject TX checksum requests that overflow skb->csum_start
    https://git.kernel.org/netdev/net/c/4fdfed6d0990

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


