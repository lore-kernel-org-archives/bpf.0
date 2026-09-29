Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4C4CDA3F;
	Tue, 29 Sep 2026 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671820; cv=none; b=q2Vp/YCgHOrxnxLwQC8LCuWnJLFOdtKucwOqC7FyTsD9mmbRXz9wRBjn5YwlmlGVdEAgckvy7s1nUbVOsGD0RE9Adok5TdE65ajmlRIeOgPkau/irThvDHQYqzkSvy2xoHDdnFDQU9f5zoy4mtGLMrLz1am192wCnwXusqophlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671820; c=relaxed/simple;
	bh=cF2ilHUIpA/LXAj+WHLrZxoLpRoqxAilVgcL2McyeHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wit/4mMlIMoygNTyA9osKB5pmiS3z6IdNGmweoUEzglLA5iYnnG7g66ESKU247iHojT9VGOe7Ms5JWopR6TDPS0XemEpaURNChdCcE1tLBMJuG4UYPZRvzB4d3lbjh4tjyD9SRkX9SHoVRSQ+4k0fmMsBJVJQ2/UlZysIfeDuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB2YPqP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB2YPqP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCC11F00893;
	Tue, 29 Sep 2026 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671809;
	bh=eOT0N7mg+KIFhs7vIUsk3+XRqoTXJr+Q6TtK+IqoAqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JB2YPqP4NyR6PUXh+uqU7Db1CgzTtQ/XPDi8aJHCWAr+toMQXN9Od1tgIuMQX777W
	 frKQ8/uqAwxq+6UlXbUmRQx1RqKh+uyJNywjrFe4iby/xOeC72IK3DzRPD8+3Be5ko
	 h0NTFLvaLbOrMXuxkozcCx0isHe9kiTBZQpHUGm25DC2f9ACyKCqqUw6w8nSs8nxfF
	 9JWvh+KCKk1HsqR4+3+3/ICYJBoinfeXvXiLPRl4mAKtO/EIemfb2hn6Qyfp5MuKdK
	 jfQX1unBEZykkNhZAxw0UWum628cI6uJV4AauqEVJvUlgCbxzL0Hnd/JdkyZy7M0n2
	 yfHX/6zrAXHvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45633926266;
	Tue, 29 Sep 2026 08:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] eth: mpnic: initial support for Meta
 Platforms NIC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067180853.363488.17435107690517923269.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 08:50:08 +0000
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
In-Reply-To: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 24 Sep 2026 17:35:13 -0700 you wrote:
> Meta Platforms NIC is the second-generation NIC from Meta. There are
> quite a few high-level similarities to fbnic, but all of the CSRs and
> descriptors have been reshuffled, and new features have been added.
> Since the device is sufficiently different from fbnic, and the design of
> our FW is minimal, we have decided a separate driver is appropriate.
> 
> Major new features compared to fbnic will take a while to land. This
> series includes only the bare-bones Tx/Rx datapath.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] eth: mpnic: add scaffolding for Meta Platforms NIC
    https://git.kernel.org/netdev/net-next/c/3251a68930f8
  - [net-next,v2,2/8] eth: mpnic: add register init for the device
    https://git.kernel.org/netdev/net-next/c/cda700bcb236
  - [net-next,v2,3/8] eth: mpnic: allocate MSI-X vectors
    https://git.kernel.org/netdev/net-next/c/2cf67a269224
  - [net-next,v2,4/8] eth: mpnic: implement Tx queue allocation and cleanup
    https://git.kernel.org/netdev/net-next/c/3d4e4ad43aa4
  - [net-next,v2,5/8] eth: mpnic: start and stop the Tx HW queues
    https://git.kernel.org/netdev/net-next/c/bd7ce2b2afea
  - [net-next,v2,6/8] eth: mpnic: add a netdevice and basic Tx handling
    https://git.kernel.org/netdev/net-next/c/1b8d005bd334
  - [net-next,v2,7/8] eth: mpnic: implement Rx queue allocation and cleanup
    https://git.kernel.org/netdev/net-next/c/4b26e9cdad78
  - [net-next,v2,8/8] eth: mpnic: add basic Rx handling
    https://git.kernel.org/netdev/net-next/c/a9a9bb541614

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


