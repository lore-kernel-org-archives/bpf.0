Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086007;
	b=0loBa2CPlldSBCfrNhI2UsGmTS6Grhzu0LN6BOszV/2GNqOXPGNw/X4G4eeYlKGBotGD
	 osKCaSIlBM+ETUeKpP3hEfo6h0LDivoVYnphHWdMhLhaUvugkwfbo0KvhW1KnbbmiDqrn
	 Yy31Qwio+gxGb+U4kvXzlZDAl2TvTabu4wcmXxDe94xiUZv+iTNR+H+jitRwbWxk5uieA
	 jNh5rIandq0xiFx4ACJX1cQTQb4va/rwvQKRbz0qkFZpPt8rADUaWQRRgkNXn3DNUcoi0
	 S1S3RDEViXmyKU/ZgApa9LUM4jiKwBHLbKYmoLAeSoC0w+TaMSZkzBmpd1P+ZHSkMaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BzVNMLS1qfrHvKiMU+xpkxa4/gmmoxIdRkjq+Jhj9+s=;
	b=vIQgSJj5yPHVQLWUXK5qvoCVvqd/CmihdpTh/GCtIHR+TzFgRVqK1pSgLHk8afy9INKL
	 C+S7Yf8yQ9ClhkdsToY/xB+CfRew0W/CSxI5lqnrD7ZxaUUCo1s9hTdpwK3uIIvYxDKDL
	 fW1r6//3UaWD3l5iT+gtkJvQFmVFLPmbRhoKQ2aBNKF/IGiabeCjLD3PHVycbzxfNRAgp
	 XLMaLV/ilTLw2+y15/418KU1Ysjz8XQkGOt34w88sL3d/uIWbgrxNylU9DAvafiYI93J2
	 A8qydE4hG1dS6CPmwS9JLRJIpGmEygzoDm6ttLG3n+l/sW0nVWYLBB/sBGMXFp+QsQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VL/J1M3I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0302606A320;
	Thu, 19 Nov 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VL/J1M3I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CB31F000C5;
	Thu, 19 Nov 2026 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086007;
	bh=BzVNMLS1qfrHvKiMU+xpkxa4/gmmoxIdRkjq+Jhj9+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VL/J1M3IXvyksRO6nc0sFMOyh9GW7RNVxkOICAxHPhLVQO10MNGBmvRJ4cYBdcNuU
	 eCniukVA5uGgg0oG102G7oCujWHq1ht3k2hOQKbXqdZWpqyJcsK6/zudDyjiEgSasF
	 3xgXXVVjz1h8t0jVKsGCMmdXLvWqW8cN+tST+8qvI9r2/yFQKBZ6blFl5tKNpDIu86
	 nvVTKapmOi0+tAQ6siNt/cNbVML/I85ERDbWUTXFGhOdLQtPuwwvNpuyX/ad211W3k
	 zTK1NwYOSboydqf3byK0dsyKasqsE9h6zWPWHXU1spsFTDwXxGuMeSil3mrDybdSB0
	 Z4l5csjKcGt8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2FC3808210;
	Thu, 19 Nov 2026 11:00:07 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] veth: fix txqs that are never woken after
 backpressure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179508600603.3017313.9159228473932241217.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 11:00:06 +0000
References: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 toshiaki.makita1@gmail.com, j.koeppeler@tu-berlin.de, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Nov 2026 11:46:46 +0100 you wrote:
> While debugging the veth BQL series [1], I found two ways in which a veth
> txq that veth_xmit() stopped on a full ptr_ring is never woken again.
> 
> Patch 1 lets veth_poll() wake txqs beyond real_num_tx_queues, as a txq
> stopped before a TX channel shrink is otherwise left stopped.
> 
> Patch 2 wakes the peer txq when NAPI is deleted, as veth_xmit() can stop
> it after the last poll.
> 
> [...]

Here is the summary with links:
  - [net,1/2] veth: wake a stopped peer txq beyond real_num_tx_queues
    https://git.kernel.org/netdev/net/c/8a0b03058ff7
  - [net,2/2] veth: wake the peer txq when deleting NAPI
    https://git.kernel.org/netdev/net/c/b2f4c44d7d83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


