Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3623644C6;
	Fri, 12 Jun 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306410; cv=none; b=XAW4AGWocx3tgIsh2DUYS3Uz/XAeHiU2lr7NXVY37YYC5Be4GN0+Z3Th9roZvgegnKKClQgPRUufy5vkzxabyTGg6OXILUxqdlmFYR0yuu8NSk06McvayeKGAB3ClXcfDMA1QISHwqz/7f7oC6Vn4XcM8xlxjomuUm708qn1YjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306410; c=relaxed/simple;
	bh=tvQw45qsskbgDSUvCYtgumFBdlExqh0eEEDPwilRRfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ljtpdPzYMa7MGB+azW9UW5emi6Cd/wKNE68dEhUA6mlVCXI17Pe4nK//dM81+oWBut8vzuv7+/fsipwU03QFcFcsdSwfRc4kRSrW0fpEPfJmzOuHc14iKnL2ByvWxoYSTRpm4k3jCYbxS1HfIQnvhgXjDwFymy3Z22K00ByNDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF/c224/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF/c224/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F6E1F000E9;
	Fri, 12 Jun 2026 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306408;
	bh=/Zj5QSWL28w/NEVx93SEz1kBpK/lIrdznOIRHCEw+Kw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HF/c224/cXYM1sOu8szgK7OQKl7Dzw0zlCPpW17EaLOXkncLsJ6fY3sXbGI8/gqvL
	 wJ2p+6QKMQAn7n4fG/n+N0Iq9SOAghmKc2AtUdRg2BUpa6bNA3TsMes/EqnWFkGV2q
	 TYqLZ9TnNTsDKGEedsv/+G/vfyOGmu8FYfCx4K+T++XRgpMVjf78A5pOkVxS7nJy6Z
	 HZ/EbsiiKio1sIQerb/F+POqcld5NbNNj6AITenE/ZMO+fee/Hy2xADpEodwQnecDw
	 90NOHitU64PQSwZWKaXIHVtQPnXya7NhKZ2EqUD2dZ45/rDT2iSVQjmWQBGTVqa5WI
	 f5CQ1Adz6mWvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8F39E9601;
	Fri, 12 Jun 2026 23:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt: fix head underflow on XDP head-grow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130640539.1287691.17272459611021895737.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:20:05 +0000
References: <20260609204458.2237787-2-joe@dama.to>
In-Reply-To: <20260609204458.2237787-2-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrew.gospodarek@broadcom.com, somnath.kotur@broadcom.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 13:44:58 -0700 you wrote:
> The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
> a bnxt machine (and also crashes in NIPA).
> 
> It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
> builds the skb head:
> 
>   napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt: fix head underflow on XDP head-grow
    https://git.kernel.org/netdev/net/c/e26657fe3b85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


