Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134610;
	b=jRU9qCsKVhTCykaQRRQhMxodkXGCYIbzbNDDIrMC2bKfRh5Qp0JRpSm6vKzU3GvpDB0K
	 L+zF6xpntUu9wW7MsHCq3/E0ya89MVyKO8ButgmJ5zh0C7eZUZDRZMdqIpPY7ZYWoG+gd
	 5h31iLNipFY3UbQjHvMaOJM4m/j8NnS5VHUl7t5ZEfHssxvvPANBYfPdlxRfF/EVso0jU
	 A3/SbtIBdDh3hrP8Vrcb7EVSHOmqnWT5XJ83ohKmzK0B1EhyIFAp0C/c/jBCFkd22vQNE
	 f4z/ZRwwiiY+zG/Wn/vdTuII094qLG/y22UwrrPCnW3WeT+QxvixzYDxZJlWapJHjBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134610;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=j81a6CYqM4ciq174eNhPfqQfAzQAbu2OK1Ia3w78EoY=;
	b=ICzIUsa4v21spbb5ESRNoZwRPw67uJ11c/IP2/Oz43CI9FxEs7JFWlnEir6iEDfgsz9K
	 NPh2fYeIcNSivAJcrbDLFHu/SMOh/+QtBCOira81MEfeNCCeh2ByjNqksSGh+8js7mZYi
	 yG5f6L3FsiiL1teZZNJyPuFeBQP4yg2gbsw9m6BVUXJZhV1Q4Q5UDB08c6RPVY2T3x438
	 EVvJ4xgJxDWMWWcTkOowoaE4jPvPdLp7Vb29l3t00kRrUrdW+2VAoji7HnoAaQhDR0pJI
	 0BGafe4m4FTnMCNMtvPaKHd6w0MDhFKcPKXUwv4vXj1wrGuKMk4xgbVnngapOPyfA2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/sJDn1z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F83606A331;
	Fri, 20 Nov 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/sJDn1z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058B21F000CF;
	Fri, 20 Nov 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795134610;
	bh=j81a6CYqM4ciq174eNhPfqQfAzQAbu2OK1Ia3w78EoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O/sJDn1z7KySfP4y+JvOK1+VbxWSHK63A03oyQSWN+y7qYChmF5xnwo8SVfUacL3F
	 2LMa61zc3yy997nj2VxHn4oyVZtiCZ0Cccw0V3ZUz4uMb4vQS6pk2kBvwFMDzj8UKR
	 WvluGLy8BA7WV9P9vScYf/nh5oGZussPmmHX4EY8R/eHBxROOpTlSXgf8QckbP1OF2
	 saMAu2DcBoOvMgU/WrDolA5Fbg1KflIG+6x9jwUCOkIwNNEfVSgaf39Kwjdf/xtBtz
	 UfxDam1PMiokSpdx/JkzyLBwmr80fJ62o17VRHCWDZHes3S9zjDmTDdoQktV0d1aDy
	 SO1cZMAh5MYUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15D43808209;
	Fri, 20 Nov 2026 00:30:09 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/3] net: don't redirect decrypted skbs to ingress,
 psp time-wait validator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179513460852.3945374.16984787247285692246.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 00:30:08 +0000
References: <20261117192411.247117-1-toddfreed@meta.com>
In-Reply-To: <20261117192411.247117-1-toddfreed@meta.com>
To: Todd Bert Freed <toddfreed@meta.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, daniel.zahka@gmail.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com, jhs@mojatatu.com,
 jiri@resnulli.us, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 sd@queasysnail.net, borisp@nvidia.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Nov 2026 11:24:08 -0800 you wrote:
> Three fixes that are relevant for the net-next series, "psp: introduce
> socket-less associations". These were previously patches 6-8 of its v1:
> 
>   https://lore.kernel.org/netdev/20261111005533.6436-1-toddfreed@meta.com
> 
> The first two patches prevent sending decrypted skbs from egress to
> ingress, since the meaning of skb->decrypted depends on the direction.
> This affects the packets of kTLS and PSP device offload sockets.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net/sched: act_mirred: don't send decrypted skbs from egress to ingress
    (no matching commit)
  - [net,v2,2/3] bpf: don't redirect decrypted skbs from egress to ingress
    (no matching commit)
  - [net,v2,3/3] psp: only give time-wait sockets of PSP connections a validator
    https://git.kernel.org/netdev/net-next/c/82290fab668c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


