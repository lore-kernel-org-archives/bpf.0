Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175C22F767;
	Wed, 19 Aug 2026 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109055; cv=none; b=i75HDtFN5z+/XZWrGvTQyTeUEL1tNmHWCnTPZ1/Y/y9QwKXgGo5hRJzzG8d/VcwLrEmSYvg2lN3S5ujJUcgQc+bIvtfPyz7MIhwxWEZgRljHnKJDbWJ7h6l9A3s64HF3h18JZsp2hGNPKUkztm/46PF4oLzsfI3WzqD5dA/5RGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109055; c=relaxed/simple;
	bh=q+qNFr8WNRQhCEYcGxwhAoG6AxZI4yJV5uowv6vxHsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WD7fEvELIBFo9LCwV4dZxNdo/1eMLOw0AmeTcfMvvaTbsCEmC2vqsMa9L+0bZY/h7mNC7qTNylzzmItqyTBc7PgUwkNpzbeRh6p2L/Q73RVo9JV/uZXyKT9aWoX6F4aqOtwP2/uI/UdAAVcrlpY6/kSkqVRBfq5aCZXVOz9Kfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqHq2qew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqHq2qew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673FE1F000E9;
	Wed, 19 Aug 2026 03:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787109054;
	bh=4+k18eV6rqaDHf7L8yYWvs1oCR2gyuTUmm6qOq1AYio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VqHq2qewrsiwkRmlwevHc34ca1hRkE0Gfq7qHbdtUfj26dl5AligpFexxzwEL1Thr
	 CgxOF9kfZluTsY8BRXZz5+eHpyEZt/+DnWsBFkbYsTml90wqfggYrrD9E4b8RwTyaE
	 dG3KZwb7CUGrewA8705D9/KSQS8a4O4XVQfejERpBnugwsFHC7NmZ2chkM1mLiqo03
	 NX2+sVXnWerAjzeXq5X+o9xwh0w/Gg7XuIvjr0SiMIB67XMqMFtBVntHH3rclSdr89
	 lU53bJ+3gCZ4LcgFkGuGOO2tZ1QIzZ8kOygjuXOBweOr83neJ2xA3TDktlXfin2qEF
	 ouwNeO3c7Ae3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E55E63927072;
	Wed, 19 Aug 2026 03:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] xsk: fix NULL pointer dereference in __xsk_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178710900561.2824559.3358618619338695557.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 03:10:05 +0000
References: <20260813215328.99311-1-blbllhy@gmail.com>
In-Reply-To: <20260813215328.99311-1-blbllhy@gmail.com>
To: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, kerneljasonxing@gmail.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Aug 2026 17:53:28 -0400 you wrote:
> In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> loop without checking its return value. xsk_buff_can_alloc() only
> counts fill queue entries without validating their addresses, so it
> can succeed while xsk_buff_alloc() rejects all remaining entries and
> returns NULL.
> 
>   Oops: general protection fault, probably for non-canonical address
>    0xdffffc0000000000
>   KASAN: null-ptr-deref in range
>    [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
>   Call Trace:
>    xsk_generic_rcv+0x26d/0x5f0
>    xdp_do_generic_redirect+0x3c5/0xcf0
>    do_xdp_generic+0x92f/0xe70
>    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> 
> [...]

Here is the summary with links:
  - [net,v4] xsk: fix NULL pointer dereference in __xsk_rcv()
    https://git.kernel.org/netdev/net/c/73cee2bd5c96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


