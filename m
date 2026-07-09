Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3173CE497;
	Thu,  9 Jul 2026 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578631; cv=none; b=TdGqsxrjNaSwMO+FueIJLCyNadpgCj3rOlNzf0RTk4hhCZkAXx/FSgv5k5yYjDl6drimphXKyU+TFYbuFG/AaqPUreSO1qeuW7Dpif5ttXNrv+P0L8Ulbi0DENox/nt9FuWi5yImn8Uj6r56X1Nqk9C5Xp1S+Kthqi8fK6nTzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578631; c=relaxed/simple;
	bh=CGeFweZa+MarH70ErqBjdIuXjMXMSZLpvl5d/YCSR9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iv9W4BuGd/ARMW1PeVrCh1zwWeCmL9c2fRi/auL7gT8VLSazPhzduYyGTlRDkKTGNbUvS1NUIG5sKgFTguNIqBCvhsHmsouIsrGEgpqm3gkf/DjTKvkGDzhdrwiApXfZjLznfw6WTMNy2hH5eeiwLJIAcbzUCJAng2JDbn+VMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcck6wKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcck6wKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614101F000E9;
	Thu,  9 Jul 2026 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783578630;
	bh=DV8AMPE4pRCDJDpvb2lN/ruPP8+mA12vNkh/8YKEr90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jcck6wKdYoSG2XOS+RgeHybpdz95EFkBhz7Ggm8vUrblZ8wPCuijUebc3WqoF2tbP
	 r4ODT0w82hFDn4jTxSXOYsuf5ef/l9gYXuT+WB65FjhdkHydGbVIWMIm6EI1qYxLBE
	 azY5HBFqG4mDj1f23K9Bnv+PBIxEF6h+48H0ACpqvOAmNswXQtMziGlS4jv7ENIsmQ
	 xo4eI/cjmTDO6IoeKIvnAFsMzWYDvAoFxs+0codK1nEYoct8H8LuIVSg6CSoCsen+u
	 MBOV5fzBhTwcRvsHh+xkQleSBPupJnZc0FlF/IneeodTskaTxbC65YLs8Srdnt1X3O
	 b9LOLf4/nBI2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569903938EB4;
	Thu,  9 Jul 2026 06:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/2] Introduce jit_required to prevent a
 kernel
 panic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178357860889.3274983.15989221425379475238.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 06:30:08 +0000
References: <20260708101806.18885-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260708101806.18885-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 kafai.wan@linux.dev, bpf@vger.kernel.org, loongarch@lists.linux.dev,
 leon.hwang@linux.dev, puranjay@kernel.org, bjorn@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Wed,  8 Jul 2026 18:18:04 +0800 you wrote:
> This series introduces a 'jit_required' flag in struct bpf_prog
> to track programs that strictly require JIT.
> 
> The aim is to prevent a kernel panic by rejecting programs with
> inlined helpers when JIT is not available.
> 
> v8 -> v9:
>   -- Initialize 'fp->jit_required' with
>      'IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON)'
>      in bpf_prog_alloc_no_stats()
>   -- Simplify __bpf_prog_select_runtime()
>   -- Simplify the commit description for patch 1
>   -- Enhance the commit description for patch 2
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/2] bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
    https://git.kernel.org/bpf/bpf-next/c/9a6df65d5c6a
  - [bpf-next,v9,2/2] bpf: Reject programs with inlined helpers if JIT is not available
    https://git.kernel.org/bpf/bpf-next/c/f1c27922576e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


