Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516606;
	b=LemmzCcyCrOaQzKERXFLL3DbP+nLFrLdvnW1bIQzj+LNm/drPSYy2pa99S7u60x2CJYe
	 OwaNUZahi8QdIZuSDmwebXCoyH8Y2o4gp6STG2zs5Ro7o73cXNY3X4zXHu4ChXmSz/1s/
	 EJzKfyf6X+xLp8kaa8Ypjwn8yRyXyM3+GVRhTTKepX8PPb+lmzxybX6r665nG2NvSrDH+
	 MlJIzAe+9LjJVMGUKl9MRL7mxTmw2wnFmVHBMSw+nqpEEgWoj5AqWNyZjAqS/ROtePov0
	 Cbnm5mwf9HNa5dn7UL9lcD3qO/m3GHzFZHub3w4tpFGcPeTYWEunziUYwDYqy1zBiJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3PToSMWFoN0xA/uPz6dKOkwe1AHDFE44wLneKSd1bRA=;
	b=XBkj2vUiir2SCz9hy0N+B0EYTjfcLQJx0hqkwMGLxVermNBri3xvEQeY48VCX3dulSUN
	 l75b2dp2C9f8U3GLVzhGRdH8HhmwBmRSgYkPvokW0NHojSruFgn9rd47rKbZr4a+Ri1Rj
	 Ji0i/h79URS/vIvyC+Xt2ODWAxAf80FHBWQ+wZz63geAGO1Lr2n4UKGrYx6HPbS59xzV5
	 ET2D/5J4R4NFrN37AAm6TLmWHNqfVIk2lCHLwXmQkycBNUvKPShTLddq02/4bf8USeH16
	 yQA1XoN/roJ8odYzlBklyuLvFhhl932XkjK692MUNLEzTP6dDDEL5lOkFFCdfTRMgzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es96BZaO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30883606A333
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es96BZaO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECF41F000C4;
	Thu, 12 Nov 2026 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516605;
	bh=3PToSMWFoN0xA/uPz6dKOkwe1AHDFE44wLneKSd1bRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Es96BZaOX7M+nGSBnvFd0vWYHyKKsuAqdIm2CTnS4wVqHRUZ1j6u61IP9aksrbpj3
	 At8GBUVokGKpv/eldnoNkjndXNj3mPM0fJ02HwQjIZ2oq54PjhgHZXsF4SSBFEirfA
	 uwvvyQQB/4VBclb2+ewpUn1/1n6NlISiO5z5cUZhGzq7ZWQuXobeyfIUrf5PnGdZCm
	 PzT/KMJq72DTsBebFr2hA2n6gTsA/ooH7tIbg2MecyiY3xXBVOM1QcJEhrDcjU8hFS
	 LdT8Tu45mPEoHJLPpfetjDNZ01LCckXkSsF5ge/5WKGSERCckwBZmi1JEnZclhCaKo
	 sAT8D+kARvriw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45F63926266;
	Thu, 12 Nov 2026 20:50:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3] bpf: Use dedicated workqueue for freeing BPF
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451660453.639875.12006588634526597525.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 20:50:04 +0000
References: <20261109181610.7027-1-emil@etsalapatis.com>
In-Reply-To: <20261109181610.7027-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Nov 2026 18:16:10 +0000 you wrote:
> BPF program freeing currently runs from the system workqueue. With BPF
> program pack allocations, freeing the last program in a pack can take
> pack_mutex and call into execmem/vmalloc code to change page permissions.
> That path may queue a vmalloc purge helper to the same CPU and wait for it
> to finish.
> 
> If enough other BPF program free workers are already active on that CPU,
> they can all block on pack_mutex and consume the system workqueue active
> slots. The worker holding pack_mutex then waits for the vmalloc purge work,
> but that purge work cannot run because the queue is full of pack_mutex
> waiters:
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Use dedicated workqueue for freeing BPF programs
    https://git.kernel.org/bpf/bpf/c/bd59a5866389

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


