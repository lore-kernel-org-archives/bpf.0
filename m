Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF458AA3
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197436; cv=none; b=Yq5m0qSgDl3tpRO2yMICdluqyGtKg6+ZWw89c87175n3h5p3dklbAiLgWATYrBjRFq67REY7EanINajLd+3I33uqm+YVGPjGJyZIYJL7ZTCBtBI+CjqPEDlObZif053GvI7rPkxCG1qt3yknH49uIEH+F9qVw0U40jCg3UOR9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197436; c=relaxed/simple;
	bh=zKXYKLJLTFvG2zlhuFiYXj4eOLZu93Dmhz0acT5x4oo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ev5MW1tECUbR9YWHvjUzF1+erIyEl/qX9RexESh6Mb8bi6dAEt/vh+TCJiAPz5Ix5sV+MQMpZ9QJxmJPk++ToR6GKrGG9eBV5w17ffK4QrTsHyGNxICJi8LQUGqR2LKIfLyVQdV2er1XMOEY19WKt0jIEIMzUqeru3abRjBYMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmH6EJWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmH6EJWI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B053C433C7;
	Mon, 11 Mar 2024 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197436;
	bh=zKXYKLJLTFvG2zlhuFiYXj4eOLZu93Dmhz0acT5x4oo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AmH6EJWIBcbhoAKjZbEbas0kw+Ppmjy1M7y+c11uowu/2Ze0WqlpjvFnyuMpOJliy
	 ry6jirNUOhGiFpXnYk5jrjWgBSGKCBtryYQeQrSENuBQ4SOIFtWOno7z69lrFkgVoI
	 msj/GWkp0g6tOrpYnw8dundCI3A0zoaAR6+t+dI1sGIhH9mG5uYnume7ddxFWuT1uK
	 nIihhClmNsBUEMNRPrWzOQihgPC/elRJaL9729WU+eBqRgjxftMFR4SfmHg9WkZx73
	 bnxHEYiAad1K/XcrUGLPFu+14i0y7rkiOdtT93CTMoN2nr1uTmHvUmdIi0XjqutIa0
	 a/IBpmN4fApXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDC60D95056;
	Mon, 11 Mar 2024 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 00/14] bpf: Introduce BPF arena.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019743596.8733.12295118460292244286.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:50:35 +0000
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Mar 2024 17:07:58 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v2->v3:
> - contains bpf bits only, but cc-ing past audience for continuity
> - since prerequisite patches landed, this series focus on the main
>   functionality of bpf_arena.
> - adopted Andrii's approach to support arena in libbpf.
> - simplified LLVM support. Instead of two instructions it's now only one.
> - switched to cond_break (instead of open coded iters) in selftests
> - implemented several follow-ups that will be sent after this set
>   . remember first IP and bpf insn that faulted in arena.
>     report to user space via bpftool
>   . copy paste and tweak glob_match() aka mini-regex as a selftests/bpf
> - see patch 1 for detailed description of bpf_arena
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,01/14] bpf: Introduce bpf_arena.
    https://git.kernel.org/bpf/bpf-next/c/317460317a02
  - [v3,bpf-next,02/14] bpf: Disasm support for addr_space_cast instruction.
    https://git.kernel.org/bpf/bpf-next/c/667a86ad9b71
  - [v3,bpf-next,03/14] bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
    https://git.kernel.org/bpf/bpf-next/c/2fe99eb0ccf2
  - [v3,bpf-next,04/14] bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.
    https://git.kernel.org/bpf/bpf-next/c/142fd4d2dcf5
  - [v3,bpf-next,05/14] bpf: Recognize addr_space_cast instruction in the verifier.
    https://git.kernel.org/bpf/bpf-next/c/6082b6c328b5
  - [v3,bpf-next,06/14] bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
    https://git.kernel.org/bpf/bpf-next/c/2edc3de6fb65
  - [v3,bpf-next,07/14] libbpf: Add __arg_arena to bpf_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/4d2b56081c32
  - [v3,bpf-next,08/14] libbpf: Add support for bpf_arena.
    https://git.kernel.org/bpf/bpf-next/c/79ff13e99169
  - [v3,bpf-next,09/14] bpftool: Recognize arena map type
    https://git.kernel.org/bpf/bpf-next/c/eed512e8ac64
  - [v3,bpf-next,10/14] libbpf: Recognize __arena global varaibles.
    https://git.kernel.org/bpf/bpf-next/c/2e7ba4f8fd1f
  - [v3,bpf-next,11/14] bpf: Add helper macro bpf_addr_space_cast()
    https://git.kernel.org/bpf/bpf-next/c/204c628730c6
  - [v3,bpf-next,12/14] selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
    https://git.kernel.org/bpf/bpf-next/c/80a4129fcf20
  - [v3,bpf-next,13/14] selftests/bpf: Add bpf_arena_list test.
    https://git.kernel.org/bpf/bpf-next/c/9f2c156f90a4
  - [v3,bpf-next,14/14] selftests/bpf: Add bpf_arena_htab test.
    https://git.kernel.org/bpf/bpf-next/c/8df839ae23b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


