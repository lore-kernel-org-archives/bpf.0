Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494007;
	b=UhTFgq7Cqm9N65m1GbamvBPDl4xexSe4B/HGWyh3kV2QbIYvF+f7VbYbQWnIzN/3SZ8o
	 52sU5omxiAqlYMuINvh7jGKIE3C9J7Tc5n2gUBERPivEWQGLZTicJyj2bW8Nl0liyqEvs
	 K9x+/xVQ1Z2S8ExpAfNY0iBDBUae/JZySz05zLxynQjxHywxsue1um/M+nOJVxC7Rbvz+
	 PgJlxYfZmMWH3+cAwbwApvPr4xPKCfPzQzQ8AzmxdBGy+tA4fsMUXdU5IbP1T58T/TG3j
	 ApIHgiX8nMip24BJJw/myWNwQntzCieiJT5OO4Xr9T9kZhlXNLoS//Oz/DtKuZL6hXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=WiR8iAXAhvMxD9bk2dRxOA7ofdhVuuIXZY/5WPc5+Io=;
	b=TYrfssFUuP1S5HOEGJgei7FSpWXE+q9BRxDfRbzZVjIanCt7skvyn/HaXtqESPcZ+0g+
	 igblgtheiGaF/yoG3/cZt+/eRgVCGhPPhvGOVp7HlVaJ7G60Cj0voLTo+/a5LLxU6N8u2
	 NFvY5G9wccySerFh7HGHe2ldons4N0KanO/ys+hJKut4hia21y7mSsi/NVkdyDSp2z5Nx
	 +94UQl34+zEMKDRJCiotM8LRWh98+YgyJ4izLdIzxLhqVR1FUzftEA9W15wvhgZJATNeY
	 Y0Q/G5YdW59ihYwqyn2Y4Y+mOZ20PZuMun2wV/S36PUiNwvbDT4rawA1EzGvfTD7GGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2hsQ4I3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A30606A31E;
	Tue, 20 Oct 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2hsQ4I3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0021F000C4;
	Tue, 20 Oct 2026 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792494007;
	bh=WiR8iAXAhvMxD9bk2dRxOA7ofdhVuuIXZY/5WPc5+Io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J2hsQ4I3EKFxk5XZkEpJYTRkmC3UMQ1MOzl2RU9D9wJOXp4SGcdY1jcK834b+dJhY
	 y2L1C4kzEHE58ed9JjwqiqOu6MlDGRJeYRg0PhjyJlUKaCul4uXjzzkMbv+GeQUrgk
	 iF1nk5vpefK82APXTBnBQi5dzDQpVCUPJVE9YjxG0BGEQQ0hZ6vmuxj8A+2hmRccGA
	 x7S6LDrITP//OZHdXAla9DQe4PakWY4vliJI0419JXRsyK6N+Wbo44JCOtCgmDf1Ax
	 y1n4Hkua5gVTySBe6sADi3etZ7xx8E0QulsjtSByYUfsf/wWUXsCuj3KiElHGDngaa
	 5khjIe7CiSQaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16503808209;
	Tue, 20 Oct 2026 11:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4] xsk: freeze deferred pool teardown without
 blocking
 unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179249400554.3664159.797074660449120287.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 11:00:05 +0000
References: <20261014-xsk-suspend-teardown-v4-1-27795582e4a3@gmail.com>
In-Reply-To: <20261014-xsk-suspend-teardown-v4-1-27795582e4a3@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 edumazet@kernel.org, davem@davemloft.net, bjorn@kernel.org,
 linux-kernel@vger.kernel.org, kerneljasonxing@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 14 Oct 2026 12:33:48 -0600 you wrote:
> Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
> not frozen during system sleep, so that callback can run after a
> device has suspended and gated its clocks. Use system_freezable_wq
> so running destruction finishes before device suspend and new work
> waits until process thaw.
> 
> Keep assigned pools visible to NETDEV_UNREGISTER independently of
> the socket list. A released socket has already left that list, but
> its final pool put can queue destruction after workqueues freeze.
> A resume-time unregister would then wait for a device reference
> whose release cannot run until the resume completes.
> 
> [...]

Here is the summary with links:
  - [net,v4] xsk: freeze deferred pool teardown without blocking unregister
    https://git.kernel.org/netdev/net/c/fece8420e76f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


