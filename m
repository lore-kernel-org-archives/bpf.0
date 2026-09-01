Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AE1A5B8C;
	Tue,  1 Sep 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788220869; cv=none; b=aOh7EE0w3eQ62x843ts8GYM1MGEy5/nGMZSVvEVAub2MtZMRblsbeKN1vwqfxmKc0GceXxnjycBLA/USE1FjznBWOcwsSmiSzZq21eIFjO7LeVIlqmdrosbvSM7yLROXjMjbXnSUqKmSHnqQVDoPLWTcbRLftmF2vYpV7r+Jpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788220869; c=relaxed/simple;
	bh=F3BV/S6M68LleNMlJ7LaSIcMlEk1oo/MZ49HA8HvT04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I2OpkmHFFto6GQ+qYDSHUoLAtkNhSnlFXGS5vKo+asmNYMBpI6F9oA0BDow+1KBY9qUQhTgX1QHGo7c9stNejLCs4w220L5bqujMOBlLvI3/5hy+BS15FLzxixE4mOx1oJBTazxXSN2ONTWKdnZf3Ix7hwOaDDbN/nIRIYsIYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z66Ms5Yy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z66Ms5Yy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5231F000E9;
	Tue,  1 Sep 2026 00:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788220868;
	bh=Qw3RqNtN77+Ds2okqCPu4wUjPF1qz1+DraeC9q0xAvI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z66Ms5YyfdGHoEcoSfIqJoW10iQoln/9ofP7T/5u28Yz4sXXxNNMF9g/iZ7j3qsPJ
	 hiCTbMCYPEfi+kBQ6slo1b55JQS+hxz3x2wdzG+2bsyIiVH1p7ewNz+n6w5P2OjiAJ
	 g5H6H1xGVitz/j35r/gMTKOl/uYeRRBOids5htNWixlRGnZjGaRTB7/BlJED69kpiw
	 c4S4GDfhsZi5I0x901Kz6mBdGR6G+CC4vK4Eyl1dwCZ9HzsqXKpbAM+81+0Ni4uske
	 NWcj3zcAP4PorczXG5etg7CaYscu6b484p3Jt0i2jyBi59BK93OkPGu/CneGfqXqP3
	 KHjc4+BlU3K6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198DB392447E;
	Tue,  1 Sep 2026 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] page_pool: keep frag_offset aligned for odd-sized
 requests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822081064.841883.3266545254539695421.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 00:00:10 +0000
References: <20260828060822.2628276-1-florian@schauer.to>
In-Reply-To: <20260828060822.2628276-1-florian@schauer.to>
To: Florian Schauer <florian@schauer.to>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, linyunsheng@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 08:08:22 +0200 you wrote:
> page_pool_alloc_frag_netmem() rounds the requested fragment size with
> 
> 	size = ALIGN(size, dma_get_cache_alignment());
> 
> dma_get_cache_alignment() returns 1 unless the architecture defines
> ARCH_DMA_MINALIGN, which DMA-coherent architectures such as x86 do not.
> There the ALIGN() is a no-op and pool->frag_offset advances by the raw,
> unrounded size.
> 
> [...]

Here is the summary with links:
  - [net,v2] page_pool: keep frag_offset aligned for odd-sized requests
    https://git.kernel.org/netdev/net/c/dc0df5a0c62c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


