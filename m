Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A330ACF0
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335272; cv=none; b=atzt7za3eAYI/k9F3xufAaDcC7uS1iM3+tlETlBUapfDAP/HJfeApOHY2ZLCSmh3caaCQQjHtxgl27JTClaLo8526m0ARomX1JqnWGDoz6+Y3Eu+Rga/q9UvDYAH01qK/KuA7DZy2t9zs12vDHENf8ouDuEAHP91ki4aE6rpG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335272; c=relaxed/simple;
	bh=CS8q/aqMG8QSM7nMUbqAFaWgWsIwEzub24w0y7rFKNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UcpUlHtrHoZG/ztQI44zXHaR9EE43u/09ViCnLqYxyzExWZrNlCv9tZ9C9aIwrhBt2ipKclCwQ1dZ40/dEWOqN5473DC649XNVKrO2VpH1TQTc+n7tZIh67tH5vkktM6ljWYRblBuDcFPYBv79+IGZwdi5fKls9YxTiaplxaZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPG8984f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPG8984f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8071F000E9;
	Fri, 21 Aug 2026 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787335271;
	bh=QmHiHGD2yEUCuakjlaXjKPyTwVep77N0CcRbvlltw2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PPG8984fDGAEZ78HxelfuMTSksiwCdPa8+BxhgDKTvbqswMA1KB3/9iAdcW3nf9dm
	 VLqQg7aaXpgx7yCyaujMoqg42V0fHGOwMbPBQUxa/Jy8NMTy5+TTjPjwkrP3sI5RG+
	 KqEQiowySD3qE7oWhLXewg0zbs0et/98twgubk3hzo2jyjGOPawS6oX7zYa5yNSjaE
	 9X2uUkOMJ1AXUsxjjniJT4bPPu2NyyZdEESQn4jRHvX8UCqMAYbARRUxTI2bt+3H/i
	 yLCLdDLYj67yQaB/kEYvrZ+XaGFXjFCUfmWB78CE0zaBTVoy+Gytg0BlIlMYVntVOg
	 765z0nm+G1tmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19888380AAFF;
	Fri, 21 Aug 2026 18:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 00/10] bpf: Support aggregate return values up
 to
 16 bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178733522090.1415880.6317390395534862749.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 18:00:20 +0000
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
In-Reply-To: <20260819055239.3293449-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Tue, 18 Aug 2026 22:52:39 -0700 you wrote:
> LLVM 23 can return an __int128, or a struct/union larger than 8 bytes and
> no larger than 16 bytes, in the BPF R0:R2 register pair [1][2]. Before
> that the BPF backend could not return such values at all: a by-value
> aggregate return was rejected at compile time with "aggregate returns are
> not supported", and an __int128 return failed in the backend with "unable
> to allocate function return #1".
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,01/10] bpf: Factor check_global_ret_scalar_reg() out of the global return check
    https://git.kernel.org/bpf/bpf-next/c/da13c047cda6
  - [bpf-next,v7,02/10] bpf: Add helpers to describe the R0:R2 return register pair
    https://git.kernel.org/bpf/bpf-next/c/cf5b96d95548
  - [bpf-next,v7,03/10] bpf: Wire up JIT support for 16-byte kfunc returns
    https://git.kernel.org/bpf/bpf-next/c/34c3503cb29a
  - [bpf-next,v7,04/10] bpf: Handle R2 as a return register in precision backtracking
    https://git.kernel.org/bpf/bpf-next/c/5bbb242c0859
  - [bpf-next,v7,05/10] bpf: Account R2 of register-pair returns in live register analysis
    https://git.kernel.org/bpf/bpf-next/c/991fb7823106
  - [bpf-next,v7,06/10] bpf: Add verifier support for 16-byte returns in R0:R2
    https://git.kernel.org/bpf/bpf-next/c/0630ad00d96d
  - [bpf-next,v7,07/10] bpf: Enable aggregate return types up to 16 bytes
    https://git.kernel.org/bpf/bpf-next/c/a2e98481a639
  - [bpf-next,v7,08/10] selftests/bpf: Add C tests for 16-byte returns in R0:R2
    https://git.kernel.org/bpf/bpf-next/c/7b7b511e0cf5
  - [bpf-next,v7,09/10] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
    https://git.kernel.org/bpf/bpf-next/c/0b9fc795f83f
  - [bpf-next,v7,10/10] Documentation/bpf: Document up to 16-byte kfunc return values in R0:R2
    https://git.kernel.org/bpf/bpf-next/c/d50d9a06c86a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


