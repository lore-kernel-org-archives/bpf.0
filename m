Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA119DF62;
	Sat, 14 Mar 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773516011; cv=none; b=T3qqlU4MTjvdZ5og+gZrhOsAIaJmh0n9vkTlfRwiXWd2i4Q1HUnJpninVtoPSCUNcVQQl2mB8+Nm+kig7vWaIF10dtHSg0VG22zC+ZwAuWaJYJyssWGNyaDRhekqUT62Y2qDMwoV+rZm43fEJXvXKUJ+qmEkWvTEKCViKCEeFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773516011; c=relaxed/simple;
	bh=mv9gRneToAJrV7gs2ldMrUIGYl8qxv9erSyv2O03I8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A5LWMvpJjT46HN8sNsxlIsTAsWWRsOrnP5p9jc5wkvHl1+tts8ORdC2XXaI3/zPFQuZ/fB3uRkXhNAv9VmAN3C4vqWy3iJ2BfF5kf9obsLFoFS3AJ1TW76MNrigGdKnTjPZqFvxd2W/z6ZN3qw3Nr46mqLLFcgNDT2fxiIlzgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JioKRn5p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JioKRn5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3C6C116C6;
	Sat, 14 Mar 2026 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773516010;
	bh=mv9gRneToAJrV7gs2ldMrUIGYl8qxv9erSyv2O03I8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JioKRn5phSWN+Pg9U/nDu8tULPa8K/S0HTFil7Iprr7qTyQHyzv+J5oZgqCPv6PGD
	 Yt6nsRToT/SapJ8I3iW/WBWOTNQpSz2qdvOUrd339/V46piNjJbn2JPDts3Hjc5paA
	 gy7akA7lp4vI5HSRoeT+Roqmc083GavdEgFU6Kn3w7Uc+xhVcENMQ2vij5rpxLLsUS
	 JqNT85OoUoGKr1BFSaTsigUQ9XR4uleIe7anm0c8tpXPhWT8+zWYKUw1BEYI0Ad32D
	 Kys43C2V2pGjqsuCs6ZxAcmZzmzpf0Ic31sRHMoYO6nS5NzWf0OuYG92c/ahINweDI
	 8beNP4I73VXtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFD53808200;
	Sat, 14 Mar 2026 19:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix memory leak in XDP_DROP
 for
 non-zero-copy mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351600505.1761235.8171503216454901330.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 19:20:05 +0000
References: <20260311095441.1691636-1-m-malladi@ti.com>
In-Reply-To: <20260311095441.1691636-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vadim.fedorenko@linux.dev, haokexin@gmail.com, jacob.e.keller@intel.com,
 sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 15:24:41 +0530 you wrote:
> Page recycling was removed from the XDP_DROP path in emac_run_xdp() to
> avoid conflicts with AF_XDP zero-copy mode, which uses xsk_buff_free()
> instead.
> 
> However, this causes a memory leak when running XDP programs that drop
> packets in non-zero-copy mode (standard page pool mode). The pages are
> never returned to the page pool, leading to OOM conditions.
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssg-prueth: Fix memory leak in XDP_DROP for non-zero-copy mode
    https://git.kernel.org/netdev/net/c/719d3e71691d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


