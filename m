Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994610;
	b=miOkmavpJNGMTH09+MTRzT2gTR31QEVRXZjOYG7l0E3/H95Fc2eo5HRp0BfajpnN1OJV
	 PNbaPMh0g8I9Dhu81/QxJ14bFEPDnqT5CZe1JfTexpzhkRUgr82aIgQtCmXt/g1RDMPy6
	 8zM1lZ8McsjaonNBBtNDWvwLqHFPHZGo3TfWZEHCtLpQEmqs5mQXgY00RaLNbHRFn7mG9
	 yjNTykyFVmRtAC6LsWDYWeRqCnaTbP/nGejSaRRIIAAYdbTyU0rORb0lDsxvlhxeKJpM5
	 pvr4h6nVH6ik2RkcDdQUlxJm+VKgEM9JWcRp10pvxoqsLjjLmM+gTn3NHEmI4xqG9cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994610;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=G7DBE2G+tp6095Q25BTCpcOqibBp5M5QObNMDI8L5dY=;
	b=M9R4BfJVD4EAsdBhQ5+I7PPFbaLHm/FKUfE0wTeXxFCSbebWTt46UMcucNRNjKR/+GNV
	 IWI+Pu1RYWmdWLes8DPHD9Ch0zm8MtxuLsk7PSXyXFjtN1bcoGMRX3WMZ7nLcrpEBmZTn
	 GcTbA+ccESPTjCiBoytWVTUdaTG+x5iWvBR1DKOXYxE3AvJb28wOiIh/8v7f7/muRIDZn
	 k0Dgr6YKBK1mGgJarWMstTJptTUMlhBz6IgdUoAT8RJBGwBq6owldoSiG273YEkjOLP7i
	 fjhmwKSGdeIye+asWlmVBbho9Yp3wOLocbRQEvz/64YxyS0nUmR4ugyGVcvA0Y5ythQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEZsYvGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC6606A326;
	Fri,  6 Nov 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEZsYvGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E431F008A1;
	Fri,  6 Nov 2026 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994609;
	bh=G7DBE2G+tp6095Q25BTCpcOqibBp5M5QObNMDI8L5dY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZEZsYvGihbEJSqiy5PwNDboHV1Tw/K6ieI2fJaAAULouPFRsYWnmpa4it8X25xZ8S
	 2aiC/tbjjNe8e/OUbO7upWeY8xxA+7sF+yRy/aRDo2esfoaxozm/hkfFnfcLSQkLAE
	 H2k9sCEOYfUMmNJ3F6Rz9svEOc4vr5zPAG8b5/4xraxC3r9fd9PGkcWGJhw1zGQtxf
	 ka22+ax8crgHChENNY02W2KTthHR5tUMaeunjtuLhtqWs5BN4NxF4EooN53UoTUJzV
	 2mFyWKT9hqiiUaO9Pjw5I5k/rMDTJSWu7YTxH1a5Exrbum/fE7nyR2lUIhJX/roUhe
	 ylzvb2I+Sw0Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E1473A41038;
	Fri,  6 Nov 2026 19:50:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next v4 0/7] ipv4,ipv6: convert the getsockopt
 switches
 to sockopt_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179399460817.837391.9013486741760659942.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 19:50:08 +0000
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org,
 edumazet@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Nov 2026 03:00:59 -0800 you wrote:
> This series continues the migration to sockopt_t, as described in [1].
> do_ip_getsockopt() and do_ipv6_getsockopt() still take a sockptr_t pair,
> and everything they forward to now takes a sockopt_t, so convert them
> both.
> 
> Patch 1 settles what a negative optlen means on SOL_IPV6 before the
> conversion makes it matter. do_ip_getsockopt() rejects it, but
> do_ipv6_getsockopt() never has, and the int options answer it as 4.
> Treat it as 4, as David Laight suggested, instead of failing callers
> that rely on it.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] ipv6: treat a negative optlen as 4 in do_ipv6_getsockopt()
    https://git.kernel.org/netdev/net-next/c/61270b859fb5
  - [net-next,v4,2/7] net: cap sockopt_expand_out() at MAX_RW_COUNT
    https://git.kernel.org/netdev/net-next/c/6de30bde94b3
  - [net-next,v4,3/7] ipv6: mcast: convert ip6_mc_msfget() to sockopt_t
    https://git.kernel.org/netdev/net-next/c/11762c7f2191
  - [net-next,v4,4/7] ipv4: igmp: convert ip_mc_gsfget() to sockopt_t
    https://git.kernel.org/netdev/net-next/c/d845b553c6dc
  - [net-next,v4,5/7] ipv4: convert do_ip_getsockopt() to sockopt_t
    https://git.kernel.org/netdev/net-next/c/67582bdf5349
  - [net-next,v4,6/7] ipv6: convert do_ipv6_getsockopt() to sockopt_t
    https://git.kernel.org/netdev/net-next/c/52f243f4ff04
  - [net-next,v4,7/7] selftests: net: getsockopt_iter: cover ip and ipv6
    https://git.kernel.org/netdev/net-next/c/47e7aaf680a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


