Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621406;
	b=TWK9JmmhWn5VJrok/mUJyvhrhiN0IJ6wzRnxERshy9QcWZKD6mk8j7F+oAjRGWz5WR8O
	 4UUC11WkIIBxJSrzV94l4a9RawuDCGXsy27snc1Nw2RJwvP+TpaDiJvCEAOeLJwKFWDS6
	 0xIkaHYLleLcqoXVOp1qHN6c6eteDPs1sHk0CUi8mfyz4AWPwnOPRglyIN4GzzfBBN7NK
	 /j0ak2JiDpGvSJWHriudap+Xsofi/V0YciQdlxhRcXmXKwyIlz0WnPi3kIeRFJPmPhzX9
	 6NMWeY25DSuc5mJYMKK69AyAh4012iD/OyDLrHf6LI6rQpxZaGca+SvslYERpl+hCEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BWqMIIQy5nCxgVDimM8+1fF53QLWzdY675fiHOqYMWk=;
	b=kVCwZD2KwbKn3Q9ArMXhjl605zsAFhGXYpUdV0MVIoLrt7g7/Tb88sJICyGcUioFPQGY
	 lyO8W+WXTPPiRRJxXbWxIMQycPrikqJ4CbNvDMFo85NVeP239nrh62ESa8NrhP7LS1FVy
	 uW1O/GB5J/M+HBLMlYqbAJ44U2VJQkJ+gyPEg/I6pUUOARfnNfi+Wb2Ivi7rOBbspWt7w
	 /NZ2gexoo1UgNpzFoIS9VIpWk1ARZGvJGTGadt7LHzvkkG7eGgLJFIhFiarRxtKAcrzL6
	 +2o5V4Mow7PhiDjsnwAd915VVEY7n6m9VMcDE8QMP3h6+7GLIvm5RiYIv/1D8K34RcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcUnO3oV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E445606A326;
	Mon,  2 Nov 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcUnO3oV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8777C1F00A17;
	Mon,  2 Nov 2026 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621405;
	bh=BWqMIIQy5nCxgVDimM8+1fF53QLWzdY675fiHOqYMWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gcUnO3oVH2N9gg0wBtplk9X0ahHTjyHkFbEu3zV0f6yg/Jaefw7jU2um0iLwN+8R0
	 Fp9J5jMsAXtBo3mn7ZcDksyRAtM19b90e1KuI2Q3c7/Im8gFbgTCgW8krOAYbC3wrh
	 laRWmcMUV3868o8uAxIAYdgflATYawmv5T78SFJ6dcAXMagcrxj42AvLEdTWx/RqAr
	 /AnRQhYDVjiuKK+8tEw2ZSHuDa8JPCLffB087/ui0zV+34Uc1dJQSSkePW0jacKb4t
	 qMYJ/08IedmJpsPTYPiEJp89hLAqVcRqTTDix/OTvUXSlu1Yl+P+7b0fDdHFbygY39
	 BUgTJnaU6YZXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D212380821F;
	Mon,  2 Nov 2026 12:10:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: lan966x: don't free XDP buffers in fdma tx clear
 with budget 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179362140430.3986178.8622216026383544498.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 12:10:04 +0000
References: 
 <20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c@microchip.com>
In-Reply-To: 
 <20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 12:47:47 +0100 you wrote:
> lan966x_fdma_tx_clear_buf() runs from the NAPI poll and frees the
> buffers of completed tx DCBs with napi_consume_skb(),
> page_pool_recycle_direct() and xdp_return_frame_bulk().
> 
> netpoll calls the NAPI poll with a budget of 0 and hardirqs disabled.
> With a budget of 0, a driver cannot call any XDP or page pool API.
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: don't free XDP buffers in fdma tx clear with budget 0
    https://git.kernel.org/netdev/net/c/263a5514cb95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


