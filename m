Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913807;
	b=UHhFAKDefFIiNTFmGMT7zGdiz1gHwhi38+78rLATB9E8I6U7IJAACb5B3xQ4XM3GyQV3
	 mi1T2TKBdD6vWbBmbh7WXNT8nesyKFLbInwog8WHTJsiQBl6mt1R4rlWb87uzsA75vOtu
	 O3l849hwNHFgWJmp9A1QSwkATp5Rp9yWjrPLv7LHMoKkUf508WxC81ypkBjU/bOyUvQOV
	 MrSxlUE/ToTrltl9FCctI5x2EsxjCW2GpbzyyFKoJuQFYzlw+UfdyyyEU047AXo1L3+1q
	 uazU84vR6ifJDbAo/nQUHk46Q7FPMS3wQDhUjCRVR8JCByfFLIazo+4V0fqO8m/fdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=IFfxwEqCS987CA847tfgMTe8ZHEtuG+CHagJtYNVW7g=;
	b=WSGf57mKHz1tbfbnuFkV39TrbJFK7NEPsVUy1cJFiFD5d0daXwQbgNwHlmy/mSAlT4QO
	 EvCc6b0viVsjmHHxb4LWTilAICHQ0M4N05gCECJdLConoo+cMMSocIZEJUfovEbdS/8Qm
	 74yqE+jviDLIJEHngCT0JCe3sG9rLLGikA3qxlsOcTme+qlKNVuGsYWbJBD+Ku5plJYTK
	 rRWUHkmvt3IqM1PGpyVgA8PRmR5pstwy6dSNop6NrjdzOL8XlpsAuOhUK/wBV3woj7xsB
	 hNDypf57/dl/N8+VF/YmjI7Ing0J2CnPa9OkTg9BJ2hqSzFV/NWFfwOofNL+o/ibUEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2rlQIsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC4606A329;
	Tue, 17 Nov 2026 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2rlQIsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820C71F000C6;
	Tue, 17 Nov 2026 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794913807;
	bh=IFfxwEqCS987CA847tfgMTe8ZHEtuG+CHagJtYNVW7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S2rlQIsDBuHprvS0mbTlvq/sZLIKX5QF7UQM+73Lc1RVZefrLMuk18Ze8dgVR6gSK
	 T49KOzK+BIDpa/MMhDwY4kAdtkJR9ZpO0XPNf9FqnBDw4nGMJY5lQWuXWSmQ04m87Y
	 oW++kQlUch1pxl6Lr/zTTG7EjTmoOOyd+z5KTXGiIbSY5pjCY0GwcfOBTcfwusrHRx
	 DlvK960NwC7U0/8LD9G1FBou/KqZawhDsKDDmqAEj0G6m68uTqXfjNL97jpprwMizz
	 gmsW/SwO/xqqE97nKXzNSyn0yhwl7RLkjQd/pmBcJ6sl5NOdS9XQEReYnUTqiAJC3H
	 VtAbuRgOUEEHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775083926659;
	Tue, 17 Nov 2026 11:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next 0/5] net: make xdp config checks effective vs
 netif_xdp_propagate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179491380628.507650.9016407672221458935.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 11:10:06 +0000
References: <20261112235027.4072149-1-kuba@kernel.org>
In-Reply-To: <20261112235027.4072149-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Nov 2026 15:50:22 -0800 you wrote:
> Bonding (and netvsc) try to auto-propagate XDP programs down
> to their lower devices. These programs were installed directly
> with .ndo_bpf and not recorded in struct net_device of the lowers.
> This makes all the config checks for features incompatible with XDP
> ineffective - HDS, memory providers etc. use dev_xdp_prog_count()
> and do not call down to the driver to ask it whether it has XDP
> installed.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: don't safety-check device features for XDP uninstall
    https://git.kernel.org/netdev/net-next/c/390095fe5405
  - [net-next,2/5] net: move dev_xdp_set_link() and dev_xdp_set_prog() up
    https://git.kernel.org/netdev/net-next/c/63e4bfec2cd7
  - [net-next,3/5] net: record XDP programs propagated to lower devices
    https://git.kernel.org/netdev/net-next/c/f564749b3b26
  - [net-next,4/5] selftests/bpf: check XDP attach on a nested bond slave
    https://git.kernel.org/netdev/net-next/c/29260040ae3b
  - [net-next,5/5] selftests/bpf: check replacing and detaching XDP on a bond through a link
    https://git.kernel.org/netdev/net-next/c/221ceda44838

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


