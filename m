Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517212;
	b=uxeS+MBsSpe5kxMFYdKx80qfl+wl3plpu/yRk+SkBMWu1+jOxNOdkfdDInKA2m0uqwaP
	 p/SWfvN0h7TgNdz1kaZM3rBFkLzwYv4KZbXMggXY0uylg6IJyx4v+kOpCRevZnWQbzAl7
	 0GUat1MkwlmkXI0etDW//KHIE7w47LhsLhczyzb/KXWT96dP9EkqcIWENNfpnOigN0pNe
	 PYijVYESY/AB7aJ/HabY0FDvyflVqZ8fQ8dZcwGQ2X5YnSFCIo9a8Z/R3FM3lZpsvFs0T
	 T/sxcYISTYYvC3GgpzDx9NBBM5+b+S9rttEiCl0f895btFnydYaLmPwk6zPJv9c39cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+Xb5/Hi1fhtSmjduwpgMNrnk/IQzptnRp6BJg3pLqig=;
	b=OfQg0s4bYuJwFpah1jPdodCJXTwjSdPjdveGK+iLtgzjl/Zfh3Ya135ogKlB/HxivuQx
	 2W0uyzRVwlkkkl2z6jJhuKrIfgAfhCGFSvvHCs86zT/qaZOu8AFvykUYYgx/pQgfMs/HJ
	 VwRF0khtoR/2/hXVpXtL3iZC9frigXBPkhlCJM8QlfQF3NOoY4EZEIIyWdmakoKLZWnl/
	 zb2D1e8BEZEibtAq7LZ/zy1k5GwdYLsLncmyEnO8lSwOoirWOb5PFFqLb+0iU8PfHvmEN
	 oZ5g6rNoZgDo3L4PoWYC1dPv+a46caBKlrHxBXy3aEZJ9vprg4XQ2tEN/p0MVSXN6NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnpV4bfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71414606A335
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnpV4bfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BCD1F000C4;
	Thu, 12 Nov 2026 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794517212;
	bh=+Xb5/Hi1fhtSmjduwpgMNrnk/IQzptnRp6BJg3pLqig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DnpV4bfJ6I2nTBOSfmgXdkzjwLUXU6wNCt0oFiTZ8vXOXRYFNom7SfLajcLRx1a6c
	 Ev6QFn90udrvHhrJOvp3T5Lvz+ELF44F6CMjts7yKflXSoWy/M1UdoxzrbotYoFKVa
	 F/eTWn/28fS9wWREZ309rOR98tJdf+rfOZ3EhylHH3UQyjaCAkbpfbtB1RJucWt863
	 eerkFqFD28xme89FRF/guysVG5oI/N6R7fi/rV2kpCabXfLMSt7HdaKp9Bn5yBlHQU
	 A61vVN9Rf16wT9UnbifBQdyVMnEH+EQhuIbbQHyxQpRyTiiO4YzjfR6IbEX6uqapt6
	 HEKT4Lk0GfX9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3743926266;
	Thu, 12 Nov 2026 21:00:12 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v5 0/9] bpf libarena allocator improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451721077.643214.10911738929932344847.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 21:00:10 +0000
References: <20261110003838.8739-1-emil@etsalapatis.com>
In-Reply-To: <20261110003838.8739-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, daniel@iogearbox.net, harry@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Nov 2026 00:38:29 +0000 you wrote:
> The libarena buddy allocator's design has up until now prioritized
> ease of verification. With new verifier features like unlimited
> global stack frames and a large stack size we can now improve
> the allocator's performance and robustness.
> 
> This patch introduces per-CPU caches for the allocator. The overall
> caching design is inspired by tcmalloc. Each CPU has its own static
> object LIFOs, one for each allocator order. This speeds up allocation
> and freeing for BPF programs that have some degree of locality. The
> CPU caches are lockless. The caches are replenished from and spilled
> into "transfer caches", per-order caches shared between the CPUs that
> amortize the cost of spilling/refilling. Data from the transfer caches
> is in turn moved from and to the allocator.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/9] selftests/bpf: libarena: Add bulk buddy allocation helpers
    https://git.kernel.org/bpf/bpf-next/c/d8276c0d08cc
  - [bpf-next,v5,2/9] selftests/bpf: Add a parallel buddy allocator benchmark
    https://git.kernel.org/bpf/bpf-next/c/4d71673bc4b5
  - [bpf-next,v5,3/9] selftests/bpf: libarena: Make spinlock trylock match arena_spin_unlock
    https://git.kernel.org/bpf/bpf-next/c/b77e7e9c49fd
  - [bpf-next,v5,4/9] selftests/bpf: libarena: Raise arena spinlock CPU limits
    https://git.kernel.org/bpf/bpf-next/c/27f2cf406a35
  - [bpf-next,v5,5/9] selftests/bpf: libarena: Add buddy per-CPU caches
    https://git.kernel.org/bpf/bpf-next/c/c8d21d25241b
  - [bpf-next,v5,6/9] selftests/bpf: libarena: Handle NMI reentrancy
    https://git.kernel.org/bpf/bpf-next/c/633635ab8d51
  - [bpf-next,v5,7/9] selftests/bpf: libarena: Refill local caches in batches
    https://git.kernel.org/bpf/bpf-next/c/e5728f923b03
  - [bpf-next,v5,8/9] selftests/bpf: libarena: Add a transfer cache
    https://git.kernel.org/bpf/bpf-next/c/be73f5c9f9d3
  - [bpf-next,v5,9/9] selftests/bpf: libarena: Cover buddy cache fast paths
    https://git.kernel.org/bpf/bpf-next/c/ed5558fb22a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


