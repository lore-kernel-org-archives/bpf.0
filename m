Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071373E1CE2;
	Mon, 30 Mar 2026 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909223; cv=none; b=lv5UTa0ZQSPe4oVNVqJ7ShcjWGZ4TPaImgITm6336PA7+4lvIDRb7NAemwGYY7OwIEbzuCyEzxixc5hbltamWMnO5eaR0MjtBJWeWFmbcFbemLWs0fs9tdbIyaovT0OJHnqVCmbE8DkaL1JyuHrDg79ekZS0WFjhdNxLxMjL7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909223; c=relaxed/simple;
	bh=pMi/WvQhiD88WMv6+51QIS/yzn0J2cBfkD/DASpvQAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HKR1TyPcMdKbKpESrJzGcLm/aeaT9jaLzPdpar47f3Wsg2iARcwMFsrhgdmSjO0UgI03u2/XHLhaAsP3F7e5uL5YeJ2V88BxU3j50eWGL3s51QH9YKjGTn01eg8mQ6NNOobV1uGXktC4C1U7uq+NzvH1Fj9DhZJP2OFCQitQTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i86b9JsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i86b9JsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDBBC4CEF7;
	Mon, 30 Mar 2026 22:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774909222;
	bh=pMi/WvQhiD88WMv6+51QIS/yzn0J2cBfkD/DASpvQAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i86b9JsDkBrIGmQvJsuT5n7kKuQLS97KR4IopKqt1p79/+lQhCZot69g0B2BVDS+z
	 qszGoT7OsmAsma4Hpta8HOVNpqXAAEZ5WmVZpc8ZlnVDp2LeTqM36en+gOTh2ovmLX
	 f0zjPUQNBtONjmBg3gPW98SXYENMoHXPVNmXdOEG7hCYFevu0RtmwjLnDXi6TsBjX4
	 jazs+K4kL98zid3iU/P3h2VPXs5m3/oNC7LkRwPQ6rlhr8afrQzV7n9E3cAruw4kL8
	 GJTrICYWf9ZwOt13m2IphgO8KsnFHwMeJq0KpY+cw5H5TMfQ0u0la4unqbHrDeD6bj
	 rLPs8ZciPE+sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF0392FF83;
	Mon, 30 Mar 2026 22:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] net: clear the dst when performing encap
 /
 decap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177490920605.1961104.13650171609512464999.git-patchwork-notify@kernel.org>
Date: Mon, 30 Mar 2026 22:20:06 +0000
References: <20260329180428.2657785-1-kuba@kernel.org>
In-Reply-To: <20260329180428.2657785-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, maze@google.com, willemdebruijn.kernel@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sun, 29 Mar 2026 11:04:27 -0700 you wrote:
> Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
> added dst clearing when a BPF program changes the skb protocol
> (e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
> the L3 protocol actually changes to keep it minimal. As suggested during
> the discussion (see Link) encap or decap operation which wraps or unwraps
> a same-protocol header may also render the existing dst incorrect - even
> if that doesn't result in a crash, just the wrong route for the now-outermost
> IP dst.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] net: clear the dst when performing encap / decap
    https://git.kernel.org/bpf/bpf-next/c/648c1bc05997
  - [bpf-next,v2,2/2] selftests/bpf: test that dst is cleared on same-protocol encap
    https://git.kernel.org/bpf/bpf-next/c/660735c4182c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


