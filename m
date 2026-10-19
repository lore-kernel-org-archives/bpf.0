Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452010;
	b=AUlObgeLrbSuB5Up0shgsPFcaRNwF5DEtVJ8LN58mRYiuPdVRpzs+mdU1FeNX3GfPMpX
	 U7ATNOoyBW8kLESGbJJozVqB+hsB9mI2spEY0eHzqElAa8i898owMIVN6WUyA7bdxP2Ts
	 SAVbZTuSOM5U5AteB4AcW6EJSqvjOY7BIP5kgpAQZi1zKspEGt10xtRvsfwboIjGmbX02
	 19UIdSZnx9GE+qowHmksOx4aPGfVQ4TkTP5dlXO+a1Dwcz07QlTl+nSXKoMgNgBiCY0v9
	 o2qQRG/2wjzunkudmq8BSOpvczVyS+N78htQevS5YIZVyqBlWskUDTyjBrVst+c6Klg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=etyA7tj16oGG+i6KQTmMm2D6MsiKVfqzLNULRao/h4M=;
	b=1beQJ5iUWBGqn9PkWPeGS68wX6vgbK3TFlKLZG9CL0OZSbWNwPw4DvORTACCDn5TZkbx
	 eNbPNsRWiKt8+Z2vL4KPyTZV5RIwCZcqgeeOJI6K8Qn0XB7o1r69Rrxxl1OH9hFGSVFe3
	 OQxn0gsuYsU/GDWj4cOZ9oi6bTJQc2hEm/NU0Fb0i9PQpAHCbd7cDubAhyNMnRqR7uhcx
	 Z2IlmP6pkshKUbdpmYaTi+wKjF3Fa/9W5cg8vsczfInaRIws5RLYJiZO3M2YVv9YtTjvl
	 AS3CoMu8pHtQbAkofCVYm8Z8hyyC0CZQx+BPclMitu9/hUG4RnJdb/DYGlAe4zx8rig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEJzBCSq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65821606A31C;
	Mon, 19 Oct 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEJzBCSq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D301F000C4;
	Mon, 19 Oct 2026 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452010;
	bh=etyA7tj16oGG+i6KQTmMm2D6MsiKVfqzLNULRao/h4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gEJzBCSqH97I5fVCEHt7wuzGg9HbOnKo+fm8Hk7ohwXqMVWGYyfbqd3V9aSU/aG7y
	 H5B7Hy98Ms/RTL0NVDU2vxXU6CUJn11cFdignm6aijPRoMKXh/NPVH1idvwmEiDk62
	 K0z62Dwwjevqsej+eLPZArQHSoeppQO109MCO/NN3Ws0t8nAHdBRNEteJCXBGbx1a6
	 PPh9NkEEeUQUQpdYkAoqgSMZmj3kdwnyw6hII7A9EU/VooJKqJZOgFgt9a5tmU1kvs
	 3zCgMMU9LWORLrOG+VppwMFX4BHQ8QOfYixRA25BDUwKBx1Mwx9BTGnh6AvGWzrDut
	 /pO/gixR3q0aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F143F3924A66;
	Mon, 19 Oct 2026 23:20:09 +0000 (UTC)
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
Subject: Re: [PATCHv10 net-next] tcp: Add TCP ROCCET congestion control
 module.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245200852.3379641.9369534757805507535.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 23:20:08 +0000
References: <asdfdDIQb7Nhm692@volt-roccet-vm>
In-Reply-To: <asdfdDIQb7Nhm692@volt-roccet-vm>
To: =?utf-8?b?VGltIEbDvGNoc2VsIDx0LmZ1ZWNoc2VsQGdteC5kZT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 fmancera@suse.de, ebiggers@kernel.org, bpf@vger.kernel.org,
 lukas.prause@ikt.uni-hannover.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Oct 2026 11:16:36 +0200 you wrote:
> TCP ROCCET is a new congestion control algorithm based on TCP CUBIC
> that improves its overall performance in cellular networks. By its mode
> of function, CUBIC causes bufferbloat while it tries to detect the
> available throughput of a network path. This is particularly a problem
> with large buffers in mobile networks. A more detailed description and
> analysis of this problem caused by TCP CUBIC can be found in [1].
> TCP ROCCET's main method of addressing the bufferbloat problem is by
> adding two additional metrics. The first metric is the relative increase
> in RTT from its minimum, the srRTT. Here, bufferbloat can be detected
> when RTTs increase due to buffer filling. The second metric is the
> acknowledgment arrival rate sampled over 100ms intervals and the bytes
> sent and received over 5 RTTs. If CUBIC increases the send rate or
> congestion window, and the acknowledgment arrival rate stays at the
> same level, the connection is limited by the bottleneck link's capacity.
> In such cases, ROCCET reduces the send rate to prevent bufferbloat.
> ROCCET uses a modified version of slow start rather than HyStart because
> HyStart is known to enter the congestion avoidance phase too early when
> used in cellular networks [2]. Therefore, ROCCET uses a combination of
> srRTT and the acknowledgment arrival rate to determine when to exit slow
> start. For the congestion avoidance phase, ROCCET relies on the srRTT and
> monitoring the sent and received bytes to detect the filling of the
> bottleneck buffer. To keep the minimum RTT updated, ROCCET performs
> minimum RTT probing if no new minimum RTT was found in the last 5 seconds.
> To this end ROCCET halves the cwnd and probes for 200ms but at least for
> one RTT, for a new minimum RTT. After probing, ROCCET refills the pipe
> carefully. In addition, ROCCET reacts to packet loss by adapting CUBIC's
> behavior. ECNs are handled as ROCCET congestion event, where the cwnd gets
> reduced and ROCCET enters a buffer drain state.
> 
> [...]

Here is the summary with links:
  - [PATCHv10,net-next] tcp: Add TCP ROCCET congestion control module.
    https://git.kernel.org/netdev/net-next/c/819d59638796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


