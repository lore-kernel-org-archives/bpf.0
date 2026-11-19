Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065008;
	b=XDE3UYYncmUcIv91MsPbdxuMBh8r07BhND8he3yr3lGh39Oh4wXJpyRaaTKR5xgiXHaq
	 GAfKEO/F+ktSbPUqzYGK2E5tYjMCf9wJlxWgsjdlWnwqkPod+uARsszip+LeGcytkClZc
	 Dgi23NCFWPEZxzOmxWRxvxWreFZWvjqYQHQy3684rdbTX9l0accvaoAI27F50pZUcAGGG
	 VE9WmMoOnpZxcJ3U59b/+1BZ9oND6VJ0HfuH04RFulkjnUfVfPCtzK3rbKAaxLI0LcNF/
	 umckWsYGPuBSdMcnQAjQIzvozvwEWlSB8/+juFmWdAzudNblTgVSHSVo1ZVHKQX422w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=IPtV6SJgf6Wxy3uTehK7LVQQgB4p02AXu5qgWg1WzaE=;
	b=noEvJDteYWKbDwYcOv0CdxtO3/L0aDBAJmspUnXbSfpJNq06C10WpiuNR85KNl18DCo7
	 acPNzwprK2RTksNYurmPsto/P9hASh6IX51bL+d4jerjeO9vVKSQXttgwTeqtrMqubdYu
	 g2+I3w4dV92k7adqyK5u/ZkDXAVET9OdvnR0bdZsUisBngNXbn4l+R8H+0ExnDF0Yfg5g
	 bkwmS1uO2YQGKTqgaR2/tvpXAVcb0UYrqfKauCKFHi32vIYlbIkzMwnT3He6rlFHILfbP
	 spZuoQyTfP9D/HHkCGb0dae9DgRgzHcU3C+byGvpPRx9N8VoPAZx1QisvT6nGo1OkQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWc6ECdC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0642606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWc6ECdC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF901F000C4;
	Thu, 19 Nov 2026 05:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065007;
	bh=IPtV6SJgf6Wxy3uTehK7LVQQgB4p02AXu5qgWg1WzaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MWc6ECdC4FWMiq33UrNe0/kLxrwQTRILWtvSRbEc+LWeOlyYYCOIK1U8vpvcU0MLY
	 zp25/rpqfZwf23N1mtPhmd7avobRTd8RjSiCB3olK2yjI+WbQvUNjMdxt4IP3T32G4
	 c147L7hYJSyofxkoHTe/t88u9LOQk2kWmdsKVo1Ybbrz8tfcXHsi5EkpUjCD8fj2P4
	 wIA78Zfoqlf7eleJ+wVz25+1uwkpU0y7CKQ932QTlL1A6/piMHYAkP3Qfe2LYUsLMk
	 6GPdwMGkFzXopparG4Uy0uim1WDrErX2eF+zZu9Bmv9ggRhwMyR7GdKmB4m4ELl9qO
	 btISsYIvcECwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775853808210;
	Thu, 19 Nov 2026 05:10:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/5] bpf: Trampolines: the size of the image,
 the type of the return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179506500628.2857527.7428213974746565874.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 05:10:06 +0000
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Nov 2026 01:29:04 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Two things that the x86-64 and arm64 trampolines get wrong, and a limit
> that does not hold what it promises.
> 
> Patches 1 - 3, the size of the image. BPF_MAX_TRAMP_LINKS programs are
> meant to fit in a page. They may not: on x86-64 with call depth tracking
> the pass that finds the size warns or writes past its scratch page. Let
> that pass count without an image, as the other JITs do. Then the size is
> the limit on each architecture, and BPF_MAX_TRAMP_LINKS can go.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/5] bpf, x86: Count the size of a trampoline, do not emit it
    https://git.kernel.org/bpf/bpf-next/c/71531b583c94
  - [bpf-next,2/5] selftests/bpf: Don't use BPF_MAX_TRAMP_LINKS
    https://git.kernel.org/bpf/bpf-next/c/9e22f382de87
  - [bpf-next,3/5] bpf: Remove BPF_MAX_TRAMP_LINKS
    https://git.kernel.org/bpf/bpf-next/c/cfe2171b0bd9
  - [bpf-next,4/5] bpf, x86, arm64: Fit the return value of a prog to the return type
    https://git.kernel.org/bpf/bpf-next/c/664fde3a58f0
  - [bpf-next,5/5] selftests/bpf: Test the width of the value of an fmod_ret program
    https://git.kernel.org/bpf/bpf-next/c/7af0b756a8ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


