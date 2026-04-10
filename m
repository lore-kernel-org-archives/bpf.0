Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFDD2C21DD;
	Fri, 10 Apr 2026 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786450; cv=none; b=fuRVX/+b6rC81pkfdv1XWdj40gaq6qgb9zYLOs72q9OoqIZ8fZ+dyOM70HihL5RC+88mBr4TJ0ZwyZdddWUpS0/rNDtu0Tp4W16IdN4MS9H4fIyKea6kKisDme3h8dUF3/3lDiCZT4HR70JnEQo3apPNo2zMpfQR0KuXZMDxO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786450; c=relaxed/simple;
	bh=0TCmYOHq41Oj1fMV0pLYX8/ff2euYn+1yz7s3K639fM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qAa7wihK/yIPDbbRjN3xwZZNHdYZRkmrn5e5/H3MU/0azcc9SI5ai1vzW4z+lo+/FzKQSjZ04hef3ecW1nCjGr/NaWwur5GfrnePxpbNaopab14m7MJXHbsgoO0B8nFMHoBje/Ed9kjOPhPS2dgRw9//Fv/ZtszPvt7nREQ6kPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D89z7A3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D89z7A3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14130C4CEF7;
	Fri, 10 Apr 2026 02:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775786450;
	bh=0TCmYOHq41Oj1fMV0pLYX8/ff2euYn+1yz7s3K639fM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D89z7A3popC3PPw+2FQaJFtoywyCSQdoWsc3Lqxt8qRxCOFXYWKFQUS5fc703swVo
	 n5c3BpSZAyWeDUUQIALBqYYH1vRXjP2TUz7Y0Q27r5lzzkmOLRRPb2+keQhHLtisdi
	 jg7uUiDrlQfZtyOArJdgcDkR6bVVqTWSvuXTSV1JawSZHqyjfE5iFbozjBz2JwmF+Q
	 khBTMz612Byu0dsKlUgsoBJmJ8X0CFJdLqV0EztSgMpJEMYCCHTkzdN4XbMl4YEi4k
	 hWWw28LtUz+tbn/D2BaiNtgY3vYbdIP5Kh4Ho1ILg7e6wi7cYEoVQOuLsFx9EWzLF1
	 S6arWOMDWJGAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCB93809A22;
	Fri, 10 Apr 2026 02:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 00/14] netkit: Support for io_uring zero-copy
 and
 AF_XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177578642530.1822769.2191540426332301302.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 02:00:25 +0000
References: <20260402231031.447597-1-daniel@iogearbox.net>
In-Reply-To: <20260402231031.447597-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, dw@davidwei.uk, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 01:10:17 +0200 you wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.
> 
> This patchset adds the concept of queue leasing to virtual netdevs that
> allow containers to use memory providers and AF_XDP at native speed.
> Leased queues are bound to a real queue in a physical netdev and act
> as a proxy.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,01/14] net: Add queue-create operation
    https://git.kernel.org/netdev/net-next/c/7789c6bb76ac
  - [net-next,v11,02/14] net: Implement netdev_nl_queue_create_doit
    https://git.kernel.org/netdev/net-next/c/d04686d9bc86
  - [net-next,v11,03/14] net: Add lease info to queue-get response
    https://git.kernel.org/netdev/net-next/c/21d58b35e500
  - [net-next,v11,04/14] net, ethtool: Disallow leased real rxqs to be resized
    https://git.kernel.org/netdev/net-next/c/22fdf28f7c03
  - [net-next,v11,05/14] net: Slightly simplify net_mp_{open,close}_rxq
    https://git.kernel.org/netdev/net-next/c/1e91c98bc9a8
  - [net-next,v11,06/14] net: Proxy netif_mp_{open,close}_rxq for leased queues
    https://git.kernel.org/netdev/net-next/c/5602ad61ebee
  - [net-next,v11,07/14] net: Proxy netdev_queue_get_dma_dev for leased queues
    https://git.kernel.org/netdev/net-next/c/222b5566a02d
  - [net-next,v11,08/14] xsk: Extend xsk_rcv_check validation
    https://git.kernel.org/netdev/net-next/c/9368397fb92a
  - [net-next,v11,09/14] xsk: Proxy pool management for leased queues
    https://git.kernel.org/netdev/net-next/c/910f636db958
  - [net-next,v11,10/14] netkit: Add single device mode for netkit
    https://git.kernel.org/netdev/net-next/c/481038960538
  - [net-next,v11,11/14] netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
    https://git.kernel.org/netdev/net-next/c/b789acc0695c
  - [net-next,v11,12/14] netkit: Add netkit notifier to check for unregistering devices
    https://git.kernel.org/netdev/net-next/c/25444470570b
  - [net-next,v11,13/14] netkit: Add xsk support for af_xdp applications
    https://git.kernel.org/netdev/net-next/c/a14fd6474883
  - [net-next,v11,14/14] selftests/net: Add queue leasing tests with netkit
    https://git.kernel.org/netdev/net-next/c/65d657d80684

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


