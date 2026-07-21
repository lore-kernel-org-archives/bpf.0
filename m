Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA7418A58;
	Tue, 21 Jul 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671855; cv=none; b=KafHI7mExJfD3typQ12hTr/IllxrT5X+iUIIO8cs52btXCniLCzPs/zj6MAgtPjNBi3HdE56MI4ZbSKCKVXq2bJk2SXGJWe01roY7TLJJp5rrp7fNgr5L0CNeVYKzGIQZ0fg66npVgbvNiURXelcQABT5FR+BvSH33MODPRPGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671855; c=relaxed/simple;
	bh=VzSFI/A/mU1RFixF+N00ArXIvSfEOMKn/Kgg/596AU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TyQqd4eDgteuLT4VRJs1ORWhQFg19p+mnSLbPwZQVLlO2MHqq12fO56upkuK2aIY34HFZv2KYl/JoEnXhNq5uOFAI3lf0A0GTmU1fzYws4iZJ4xg9MGH+QcwyZGWshbwR3homeEmbajZfhxcVQ1MBBEc2EE0WIxFfyZVPT3JLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2BkNgBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2BkNgBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19651F00A3A;
	Tue, 21 Jul 2026 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784671854;
	bh=6ghj0bAXJ7QM0jI0Z0cbalfZJOu7EbXC3apo2wHHgRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j2BkNgBCqE2rjYT68nNQ1r2DFARqy3UTnRM85Z6Vb6IMwcGo6+7JoJ+ctYwgtNFXm
	 FBk2ZY2+MAbKSN/WEqMIiAbTVDvdZBJAnh7ld3EcvMK78SUz9bcSNgsP8wcw4IRIDG
	 lLV2QIeJyiCylGkME6OBx1/qS897VWdSiqbFeWWis2+5oLQjMv1cgWSvZ6SGNC37NW
	 Pg9KlGg7Hs7IGUyg3e/Bd4TNrmqomrS8DZX0gijZQBGAZr5f72kyBkck1I41+KXDrY
	 sJkKiI2cfwT/HkeiyOxqjUQLByFuH763miOFJ5eZ5iXLOPCmlsmxxsgFHLKRu9z67a
	 JvC+QDdmPI6CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B86380820D;
	Tue, 21 Jul 2026 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] selftests: net: add missing kconfig and settings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467182339.1107545.10049647609744373439.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:10:23 +0000
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuniyu@google.com, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, dev@openvswitch.org,
 antonio@openvpn.net, sd@queasysnail.net, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, mohsin.bashr@gmail.com,
 dw@davidwei.uk, weibunny@fb.com, bpf@vger.kernel.org, leitao@debian.org,
 asantostc@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jul 2026 20:04:40 +0200 you wrote:
> When trying to execute the same selftests targets as the ones executed
> on NIPA, but using containers with minimal tools, I got some issues
> with a few tests.
> 
> Most of these issues are due to missing kernel config, but also too
> short timeout:
> 
> [...]

Here is the summary with links:
  - [net,1/7] selftests: af_unix: add USER_NS config
    https://git.kernel.org/netdev/net/c/f8b1abed7361
  - [net,2/7] selftests: openvswitch: add config file
    https://git.kernel.org/netdev/net/c/441a820ccef9
  - [net,3/7] selftests: ovpn: add IPV6 and VETH configs
    https://git.kernel.org/netdev/net/c/90c792681a37
  - [net,4/7] selftests: ovpn: increase timeout
    https://git.kernel.org/netdev/net/c/61ac7049aaa8
  - [net,5/7] selftests: drv-net: increase timeout
    https://git.kernel.org/netdev/net/c/3529d75d6741
  - [net,6/7] selftests: drv-net: add missing kconfig for psp.py
    https://git.kernel.org/netdev/net/c/c25dd7439f84
  - [net,7/7] selftests: netconsole: ignore busywait errors
    https://git.kernel.org/netdev/net/c/e6ad44a5b1d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


