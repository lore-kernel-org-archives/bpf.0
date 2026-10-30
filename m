Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385608;
	b=oguV+tiQhsVtrur7EqxxzGlngMCKF5hRr0dspbdWUGElDYDs4Rie/8WroC3uR8E1etmc
	 Yn9qG1V4zvOm32leNsHHXb0wevQYkv/aATtlUy3M/38W+uSJMUCyIWw/iBGbXvYgKqq9s
	 BckmSO7S6DguKHUrx4r8LP4uZ1JSiH0TgssUHqWY2pv7Svz710s/gy7W/VRha4EhVN7JL
	 HBqgzAjYAScAYPRCkgKk4QiY7zq3hex7Mb9EHzkNec63mNIoYUuY6r5Xr9n3ZZsg1bQsk
	 ww1boii0BSoRpDZ30wCOnO41HJDEgMfToBRylf546SCkQoaTwp9C/01xSqg6jm9hODw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=T2n59IE0yCrWOypfcOUz1/K0hkOUiLvNn/nB/VszxIg=;
	b=lazkV1GZEoTTkfsiYFoSsjSB08Lqrk4DqAECIXWo7qb6EGGcQe+cFLbtxa4Z+GZ1GNLm
	 q/uKmXXG2FOX/+azh1IZXyDfmM1jEQpFGXvFVA9Pjq5tyvT8OmZocPJgflFU5IT+htewo
	 Py+tZNRH0esTfhBJVL3Tt43GPTq19QYA3g0Xa3L7gghdTANY6LQ7spk5Sq+ISXqL01oY2
	 uDPRP1BP2yTWfV7LQwwvOgJRo826iw56+jZp4w9QReZC6CqGCngvyqTF1QktJm31im7+v
	 vYY3CfhBWvtzWoPK5pyt64LT/Y1oeaIs/vcHSlUb1s9ZkKWWffAfYc2JNo8mU5h+o4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPGkakVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E5606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPGkakVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C273C1F000C1;
	Fri, 30 Oct 2026 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385607;
	bh=T2n59IE0yCrWOypfcOUz1/K0hkOUiLvNn/nB/VszxIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iPGkakVTPaZbEODKL8G/Ur4aA80wOkjok2ulHxAQP+xPE1Wl17qd6V/IRhW1YHKHD
	 AC09TxcyC9/0W+hsdy22vkquwrywRuxfq97Jnp8s//klDZ4h/j9pPj0fmWoG+/KFLt
	 kHepyyLxFdFT6HfMz9DdGPFcW5z/rNnGTlXu5w3RyYWAP0Y2HHjVXaEiMoXMamo5+8
	 k9hY/phtZwdAhvU+HQNtJCMdaCagTRTZoLV+EOkSaf3HSsoY2M4G+zfpyApeFTAVFJ
	 WWumQLf8JAYl9ZnYuk+Tt8oBae4TcyVUQkvzEAUxL4zRsPmggZp1JZg/aug7RggLsk
	 mCev/RmhQWRSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2C83800474;
	Fri, 30 Oct 2026 18:40:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v9 0/7] libbpf: BPF program manual loading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179338560630.1712658.8774924351807641695.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 18:40:06 +0000
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 29 Oct 2026 18:33:41 -0400 you wrote:
> This series was originally posted in January 2025 [1] as a two-patch RFC
> introducing a per-program tri-state load strategy (disabled/auto/manual)
> to let large BPF applications load a subset of their programs lazily,
> independent of the initial bpf_object load.
> 
> Motivation:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/7] libbpf: Reject gen_loader set after PREPARE step.
    https://git.kernel.org/bpf/bpf-next/c/c9b2a0975c39
  - [bpf-next,v9,2/7] libbpf: Free func_info, line_info and subprogs in bpf_program__exit()
    https://git.kernel.org/bpf/bpf-next/c/899345f5d768
  - [bpf-next,v9,3/7] libbpf: BPF program load strategy enum
    https://git.kernel.org/bpf/bpf-next/c/5db39ae40725
  - [bpf-next,v9,4/7] libbpf: BPF programs manual loading and attaching
    https://git.kernel.org/bpf/bpf-next/c/354aaa519cb4
  - [bpf-next,v9,5/7] libbpf: Support declarative manual load via SEC("!...") prefix
    https://git.kernel.org/bpf/bpf-next/c/c29809ea29e2
  - [bpf-next,v9,6/7] selftests/bpf: Cover BPF program load strategies and manual loading
    https://git.kernel.org/bpf/bpf-next/c/3a59ddfaea5e
  - [bpf-next,v9,7/7] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


