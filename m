Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438015;
	b=i+IM2XYW8Uf+egZ1BpDO66LqVsd0yAAATqt0AQRzIdsuvJMtf7iQ04mvMi+h8/hsDVSK
	 sDu16E+4T4befoZz3C97xAXV2vFE6WDqX97Hkt5j9t1fjY6/f7vClk2t5vJnNbAgVEYMl
	 8QVwJgUBs6otcah9lxhsRSQH0XDIvTEoQEuAlU8RMunbhAAyvuic8gWHtINGt6hTULIlO
	 Mx5vw5Rs+AWj+69awXpNRXG3NDBGgCFMm4NaufH5SWwNboh6kWtLdRy2rvtGGOuNW84qO
	 BUsp4raoSmwWlp9bpLfnvJfZ5ULJMPlnT/R85Pps7n4lkrrDim8V+zPEvTOTFfN7eTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438015;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QvHPWhUDhGQe+aSH3oMEMaQLcsuAkJhKskKeU6rQjjI=;
	b=ha+E/4hm/ReFFv2Xu/MLQjSPwiuY1RAuBziMOm2TUB888JRJr3DMhvgKWGMrT68NY3ZL
	 Z1T9myg//6Bpbn1EgT0Athfq3mMVEkrQzTm+mIua/Sjnh2q/mJlFUxFrdpGLuvXUlVNWU
	 fu2DI6UGyllIkLYDluCH+JBYFz19aSAO8OlFWpwGNo+bZe31ksull5XeItSZe9uB4682p
	 Sqzqgoao+TBS7SYEGwu5WbVhk88cwP3Ec12u1RLM6uEKqM5MngObjFTpeVDdpfk463Zdz
	 ofp8H6RLv5YDKTaUnPKHy4U2kA0br+W3nOxTuEPd5F4zj1hBcGC7j3TwyRrVti/246A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlWWD4N3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A7606A339;
	Wed, 11 Nov 2026 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlWWD4N3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37A11F00A06;
	Wed, 11 Nov 2026 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438014;
	bh=QvHPWhUDhGQe+aSH3oMEMaQLcsuAkJhKskKeU6rQjjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dlWWD4N34FBCuGcbDp3JJCD8TA0i7eVdM7u3OdNmWFeNMfRGGGGJySvX8EHFJp0mf
	 ReCnKrZBs4If9d/vQoAd7aZW/cL3LGgRRDUtIy2c/6dTNCbqWAakfLaTL27tAQP5FH
	 dRw5Azh1ieA3qQ3OQmcc8e7jFFuyhnDOm8RQOvYzkRtqVTeuzVpLI65wYbaqPDWK6+
	 c6Y65qprWkli1EuvcclAArBVrwmdh/i9EkG/4x1CPvZ2XRkVTWSRRnaq3PjcynLgbX
	 FcbCr5sEm76PCa4lmiQgaw+BRtVJfjCsFFXcyJAKMjmmpLIgTMB50uwEBCVo1q+Fix
	 VTaBHRgW1e0UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8546391AFC6;
	Wed, 11 Nov 2026 23:00:14 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: lwtunnel: use GFP_KERNEL in build_state
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443801343.1692642.14984112787619912038.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 23:00:13 +0000
References: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
In-Reply-To: 
 <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
To: Boone@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Max <mboone@akamai.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 justin.iurman@gmail.com, andrea.mayer@uniroma2.it, sharpd@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dbanerje@akamai.com, nhudson@akamai.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Nov 2026 12:40:55 +0100 you wrote:
> Since 3d25eabbbf67 ("ip_tunnel: Add dst_cache support in lwtunnel_state
> of ip tunnel"), build_state runs outside RCU and all its callers can
> sleep, but paths still use GFP_ATOMIC.
> 
> For dst caches, that limits allocation to populated percpu pages. A
> large burst of SRv6 nexthops outruns the refill worker and will fail
> with -ENOMEM despite there being free memory:
> 
> [...]

Here is the summary with links:
  - [net-next] net: lwtunnel: use GFP_KERNEL in build_state paths
    https://git.kernel.org/netdev/net-next/c/f2a6f9151f64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


