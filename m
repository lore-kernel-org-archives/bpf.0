Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BF158848
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166029; cv=none; b=Qbz6Dm3n3gk2R9TYLSZj98eN3R0k1XRkwKZLL05Gu8vYQD0Qc0G22+Nf0dT5RB8KA9m9INkrdhSQ9H8eAgAAyP+WU+AjRSzmVGvnQnOfC1jKfwAsg1KZvhoWufd6fNIBlCxdY/WzxC0g6pvj5rvn0+nxlZTcvCB+/zZUi5TcLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166029; c=relaxed/simple;
	bh=zHDScisCvRFllzLru9FRC8n5J4vLB1/1oq/vinQkDsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tIc9Yw3KV8lo/nvR5IwzK/q08QK6qlYlgcJE9Gd8xTUdrIhYipKuaCorjTLWc01nFgdDrDPil/+K637cg3dD29png8bi9yTO4AacFjXlzMtFYjoni4MoTtASpzamHEbPZuNPEqtRE23fk4rymfZUw999Bzy59S0FhybRnvyP6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJgu3kIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJgu3kIC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 001A3C43390;
	Wed,  3 Apr 2024 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712166029;
	bh=zHDScisCvRFllzLru9FRC8n5J4vLB1/1oq/vinQkDsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PJgu3kICEjYs6Lp+DI8N8uiVCEdmktWZwvYJoOdVa8y+4gJVEa0ZYm/sRLSmm9HGG
	 LGVj1oCVkPLipzazZNeGEGo2AnWYU42ftoVRWcLkCjY3KdT/ovN/DHLlgIQ1jHtF2Y
	 bjHkB3VNYjqkstH/AzIgl7hMGuWwknYRWmyT67EhObcwje7hsDXhsbPpOSXrADCHHB
	 l+yiNCVRg8a1F4LFX21tV15KiHesQvWXJk9aPLGhe+YdkQvGGaY/BdgVjuaIMwrR8a
	 XWmFRttJXQ0H55ZmVy7ZQDuo6Z8EVtWY4GGVx74COZ5PlCI7pkJcN1Zp6FPSon/p6N
	 o1RggI7hb0CJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5A05D84BB3;
	Wed,  3 Apr 2024 17:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171216602893.3077.3835815099521248973.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 17:40:28 +0000
References: <20240402021307.1012571-1-andrii@kernel.org>
In-Reply-To: <20240402021307.1012571-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  1 Apr 2024 19:13:01 -0700 you wrote:
> Add a new BPF instruction for resolving per-CPU memory addresses.
> 
> New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with
> insns->off set to BPF_ADDR_PERCPU (== -1). It resolves provided per-CPU offset
> to an absolute address where per-CPU data resides for "this" CPU.
> 
> This patch set implements support for it in x86-64 BPF JIT only.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] bpf: add special internal-only MOV instruction to resolve per-CPU addrs
    https://git.kernel.org/bpf/bpf-next/c/7bdbf7446305
  - [v2,bpf-next,2/4] bpf: inline bpf_get_smp_processor_id() helper
    https://git.kernel.org/bpf/bpf-next/c/1ae6921009e5
  - [v2,bpf-next,3/4] bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
    https://git.kernel.org/bpf/bpf-next/c/db69718b8efa
  - [v2,bpf-next,4/4] bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
    https://git.kernel.org/bpf/bpf-next/c/0b56e637f705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


