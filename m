Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291413;
	b=c8K8muxPBsnAza48tSd8y2WPqKxS4jm9BtesRLNqAPyJzfUMYLAUlIbH3L6uSgIUDCwk
	 Y9X/GxY9CaNgMczi3bwP4+qPdRQ6rWsYTzW17HgR6o77iUgEWyYmrPntiNWAZvd4gO/1W
	 iGCMIS9SIpxHN4CancdDgOXVjbqTb9sCI08iEio16vgXU4gmYsVaf+tL89r3rUCpxS+kP
	 5VfPKhHVQwCmsKpAM20+ixi+Ksn5j3fQ2v0OKaMrobEeKTwsvS6XrM4iF7qi0EusUp25L
	 0BFG5mwleasJSkAze2xwbHs6EA/v42s2oasAncoQL/YAvbRFLrRDzqd7Kk5iaycCheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291413;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=E19BMPrjdlaYAFVXrSdWhXQYi/WuuCVsgVtT7xwTeXA=;
	b=JEDGW5+WbVr+c8diZ+oZkrrJmurBgD0CAJuqc8PXR3UvHHmiNBICPGOH3X/xNCDC8u6y
	 VLKzLZJWnhwTbyaOQxW+HK/gLcuKsJPmxAh4G7UxHQkQiZGTkWcYMCgNSc9LjamcWUY4/
	 tHbkAbCpdHmHWyWk6oxlUFKoe1t9UD47LpdRWOzidDeDUcDAUMn9b5pheJY0QnNw8XejV
	 P/75ubu8kYaELwmBZZL4Zgbt8vsvScvsoyMX1MBNP3j/df6mGqT7EIAEQdZuxvfYAWfpx
	 3aa+O4kY5YTzOxZmtTPlUZgpfsiL8VmMfd7yTarHwfrlEUhmBh5YQ/qX/S8ZtvSmbaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J4wlMw/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69260A2619;
	Thu, 29 Oct 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4wlMw/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24F91F031F0;
	Thu, 29 Oct 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291412;
	bh=E19BMPrjdlaYAFVXrSdWhXQYi/WuuCVsgVtT7xwTeXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J4wlMw/xPOQ0Mm5M+Ny4lcPeswTPGc8uRrX+SqYgZls5LRL/BZRxw+H42jMprvIcD
	 TUqIMzkMScG+ObtvSxkjFVnBLuFZ4nmPUJJbY4QmUMU9N804GXtacVowSeW5ttTAKJ
	 /yUzXQ5f1qJ2dyD7S8DFLhCeIRBTkaOW+ipcI9prRya98onzPUS5pZmMrr6+haUsSy
	 BErW3F6HsrFYoEQj5hy8gzBYaec+tB6kC5cZnsk7mC209sCEvNBxEehtdLeJtLKmpv
	 7z23Hpdy59CSRcPwgQmfjqHyiDGbCUC33+Aq4FmdIHsCKAriTQFmB38CPcxX/d+yFM
	 7V6AXZXIqO/kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2C23808223;
	Thu, 29 Oct 2026 16:30:12 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/5] net: fix eth_type_trans() crashes on skbs
 coming
 from the stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329141129.559085.14393528345528530000.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:30:11 +0000
References: <20261028122703.2093730-1-edumazet@kernel.org>
In-Reply-To: <20261028122703.2093730-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, andrew+netdev@lunn.ch, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, jhs@mojatatu.com, jiri@resnulli.us,
 dev@openvswitch.org, willemdebruijn.kernel@gmail.com, weir@nebusec.ai

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 13:26:58 +0100 you wrote:
> eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> NIC drivers always provide this, and they should keep using the fast
> version, without an extra pskb_may_pull().
> 
> Devices looping skbs from their transmit path back to their receive
> path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
> act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
> or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
> than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
> the BUG() in __skb_pull().
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] net: add eth_type_trans_careful()
    https://git.kernel.org/netdev/net/c/2519a6fe7a8b
  - [net,v2,2/5] loopback: use eth_type_trans_careful()
    https://git.kernel.org/netdev/net/c/093a28998374
  - [net,v2,3/5] net: use eth_type_trans_careful() in __dev_forward_skb2()
    https://git.kernel.org/netdev/net/c/695e1408eb90
  - [net,v2,4/5] openvswitch: use eth_type_trans_careful() in internal_dev_recv()
    https://git.kernel.org/netdev/net/c/b55e5a0159c8
  - [net,v2,5/5] net/sched: act_ife: do not consume the inner header on egress
    https://git.kernel.org/netdev/net/c/498c631f9c6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


