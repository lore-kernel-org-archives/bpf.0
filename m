Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140210;
	b=ayLeY099qRTetXOlbY/dI1L2bhwVQP1DH114S9svbAs3775AbKIHkU3DOFInxsmDPmEi
	 ZHxjH3c59omVPogyFI2pvh5WP8cbHr/v0kPw21pOxiGRvQ0u5z4OFCRQT3bb5Nej+aHkZ
	 373c/QuOnKtEVExkNfuwr/F7cdQqXsffQyaR9sZCS8SBhITEwbU/MsVpBGMWpz1WXP47D
	 aBsygD/guM6zHeF/p8hPneWo+1zpGDmXg6EbQLRJLCzQOOFCaHFF/2gP0sq+ed697dVR+
	 wNqH6/ybpjF9CBdPEZQnzgXUGZ/Mi3pFXQLa2XexZ9+sLethrlSrGrDj4cIP0Mok8Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fHlJ1wv5xEEQuy6wpLDTT9zC5ZVQRxUfazIXFu+TLHY=;
	b=QtXQK4yg6GVa9e4k9Eu9n5jGY2LlJi+jvy+YEHn0ImSepVmfbAZlz2fAN7s9jbvOaKeU
	 a3pJKBjZO7rHq9mURTx4gghnJlBU1LYOQZN6+9OPCT/vu0TI05RxPsjwbOs9+p65hk5ye
	 ST1dR8nKukEYyXR/YZ2ukiF8pcRcqt7qTB0vST86dr2ycFhJc4r/ZH4Fm7JosQLNmWipF
	 c05PzNv+lCEpFcRErGYf7/rzA02+M9BMZmnH4XVcSDkfoxfORb6kSUL5ZrruQPyRcP9Q9
	 xsTVFF9IcS9JUieFHQ8XTJPPlua62hlj1DBpBOq9UxNF6fc+sfhclU1S84O+zMawRTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9RJUtrE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB3606A324;
	Tue, 27 Oct 2026 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9RJUtrE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896EA1F031E4;
	Tue, 27 Oct 2026 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140210;
	bh=fHlJ1wv5xEEQuy6wpLDTT9zC5ZVQRxUfazIXFu+TLHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O9RJUtrE+d6xFCi411NyiykGbFIeEIPZot8R02yz6683geXxyR4Adrb0kO+Cp/wkz
	 CdDHZn7nfYQHQBKMuUAGsY7kgtYSHwL3OHLj4hnDohvfvVA2fK3zVhMgF1Wwul5jQd
	 hbKufASFkBQWbHeXFGZB1ImOGuUjKHKajOTdYDpaIn4vKF094I+f/ZX0A2iyBWBU4z
	 LiYhSWsYTTdpYa7Lb69/oJYPJ7Jwe8dc91JJwGHkWIzOBesxRqMXxlJnUmq031RS+H
	 pobwPon/D9NBnkG9h/IdwU3gC6TW7a9W5bKcCnm6vnd6gdsEIHWpdL8bNLSDLm4tjV
	 DPSvJtyXUr3XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814163AA940B;
	Tue, 27 Oct 2026 22:30:10 +0000 (UTC)
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
Subject: Re: [PATCH net] net: lan966x: fix the DB dataptr of frames from
 ndo_xdp_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314020904.360855.3604879146922588076.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 22:30:09 +0000
References: 
 <20261026-lan966x-xdp-xmit-dataptr-v1-1-d0dd068324de@microchip.com>
In-Reply-To: 
 <20261026-lan966x-xdp-xmit-dataptr-v1-1-d0dd068324de@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 14:46:39 +0100 you wrote:
> lan966x_fdma_xmit_xdpf() transmits both XDP_TX frames and xdp_frames
> from ndo_xdp_xmit, and builds the DB with
> lan966x_fdma_xdp_tx_dataptr_cb(), which adds XDP_PACKET_HEADROOM to the
> stored DMA address.
> 
> Before this patch, the headroom is also added for xdp_frames. For
> XDP_TX the stored address is the start of the page pool page, but for an
> xdp_frame it is the mapping of the IFH placed in front of the frame
> data, so frames from ndo_xdp_xmit are read from XDP_PACKET_HEADROOM
> bytes after their IFH.
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: fix the DB dataptr of frames from ndo_xdp_xmit
    https://git.kernel.org/netdev/net/c/ce3192e0dafa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


