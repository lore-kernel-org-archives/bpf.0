Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924418615E
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067627; cv=none; b=HVjdiI4gRKUx/wvy61nrwq/ffay6ji0xhuptUm5luX2pFmtHrC8VIp5IT0/piev6dGh7TDnMHvvUz44iWBQOay0MGnCMWS/h16LVc16dZzd2RTfs+bfH7ZC497fryd2plTW5E8UTkzmAQip/uPcKsQe5xlIpCUd+HybJiFBoioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067627; c=relaxed/simple;
	bh=R9HyQLfp0RBixRZMZBjXJjwUTtAYe40IvUuu9muVZSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZXDDsy2eiFwFwDxNtasmT0gRyy2rCcmTRAp3dX6GlfOuMRGoUZ21omKfQLM1M670Tx2ZIPwmYD0Kg2Tej/xrRGjYahu48qDIQhVd6K3Ox9nuYO3CXAfFi1HyPupw6AcDrrS8rlo2s8I4/9So6MrmJbJYlAXp0nu8kYDGXXY+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgCByEqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgCByEqV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D8B5C43390;
	Tue,  2 Apr 2024 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067627;
	bh=R9HyQLfp0RBixRZMZBjXJjwUTtAYe40IvUuu9muVZSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WgCByEqVFZyCqyzsVkBpEqX+Xc7E3ArejPs2MK76SaWVLB2+DqoQsNziktsuN316t
	 5gcItikqoSat9pWZYVwyj/6+0uWO//F2IOp60vzhr9nH4CJRzCwDegrfb+uL7NOjMb
	 wqx86Dqx485bgXqlKN0QshDoSj8XC1aLD2NT9XvvKSk+S/wbRnzbDkzI9vLBaOMhus
	 McSnZE1vicN7x1/WovMuAf1Qz8HyzA1hfLoC5evqcOEJzhcdhqzAm9PmyI7DOTQ2hn
	 xDL2VIX/bYqt1zRelNQ46FOUMbIjOnLj+oTzoGtpdBXyEyPIu1+OqvcdBCNAzef/Ld
	 7qnXccFlpWNqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E685D9A158;
	Tue,  2 Apr 2024 14:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Using llvm may_goto inline asm for
 cond_break macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171206762712.12718.11484045995204165562.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 14:20:27 +0000
References: <20240402025446.3215182-1-yonghong.song@linux.dev>
In-Reply-To: <20240402025446.3215182-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  1 Apr 2024 19:54:46 -0700 you wrote:
> Currently, cond_break macro uses bytes to encode the may_goto insn.
> Patch [1] in llvm implemented may_goto insn in BPF backend.
> Replace byte-level encoding with llvm inline asm for better usability.
> Using llvm may_goto insn is controlled by macro __BPF_FEATURE_MAY_GOTO.
> 
>   [1] https://github.com/llvm/llvm-project/commit/0e0bfacff71859d1f9212205f8f873d47029d3fb
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Using llvm may_goto inline asm for cond_break macro
    https://git.kernel.org/bpf/bpf-next/c/965c6167c93f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


