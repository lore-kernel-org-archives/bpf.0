Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7220FA81
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699434; cv=none; b=h6RLVjgcCaG7GIJbeiTI8woFvi+CQMVQF1gECagawUWsxC1Yc9G1QDNNA1owjVNtK4fRirAW2HDBMadH6GaKPP8/mUDCV144zCL4Tz7ZFzqGRiSjVTgSmf+WMc3hJXBesl5+yCx9hyQzLoJJQGZ/JrgCF90XU0H4QAEaBVhtFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699434; c=relaxed/simple;
	bh=5a+PvERBlx/BonOYuYrKkPHj2PjRY9Q97/sVwDuBjbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J8BQamE7PB8sODKm2DB8B1gJhXgKqbHqLsvhAaqP4zXQp1YxdTZUVx4aIxPTvF+ohUo+xNx6UD9A+mhIMHWM2SWBvKXvpJ5B5TW5fXMsU1S2+XPAYvhem67FujgUxV2Ttc6kn0QtRjCk1YUGEma3ua+J2zef4alWOHCePqc5Ttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW6RDEmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW6RDEmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0F8C19421;
	Thu,  9 Apr 2026 01:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775699433;
	bh=5a+PvERBlx/BonOYuYrKkPHj2PjRY9Q97/sVwDuBjbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UW6RDEmr100xfhuuTPD45L9EXyDfn5x+QZ0rgiRQ33YMOS/Z30QsUYA3LfdpncR2V
	 oY4O/e1XVm96nWCJbpuGTML59DQUOBcZVn+lB7cGwOngs9ESMumhOSmM8CMB8AHbHh
	 p4tj+9w8n2iSvxvQm5mDZmRN48dL3524uWm+0HisNFwX7ppkHEAsGm/IurcPoONH1u
	 NSxa0xvrhLcy0noaUDIbm2stVm4XIm89DTk4cF7m78uHjeLUHa7mGqIgjHhi7n7Kcs
	 8rnHsd+KqWDiIBIH4kSyn3ksbsQyf2VptQzz2vc7h9cIPV8Q92IsqG2MzrUPaIFwvM
	 WF/yqNZs4bS8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D673930793;
	Thu,  9 Apr 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Propagate error from
 visit_tailcall_insn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177569940955.949482.17510748914664571817.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 01:50:09 +0000
References: <20260408191242.526279-1-daniel@iogearbox.net>
In-Reply-To: <20260408191242.526279-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com, info@starlabs.sg

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Apr 2026 21:12:39 +0200 you wrote:
> Commit e40f5a6bf88a ("bpf: correct stack liveness for tail calls") added
> visit_tailcall_insn() but did not check its return value.
> 
> Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: Propagate error from visit_tailcall_insn
    https://git.kernel.org/bpf/bpf-next/c/6bd96e40f31d
  - [bpf-next,v2,2/4] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
    https://git.kernel.org/bpf/bpf-next/c/ee861486e377
  - [bpf-next,v2,3/4] bpf: Remove static qualifier from local subprog pointer
    https://git.kernel.org/bpf/bpf-next/c/9dba0ae973e7
  - [bpf-next,v2,4/4] selftests/bpf: Add tests for ld_{abs,ind} failure path in subprogs
    https://git.kernel.org/bpf/bpf-next/c/e0fcb42bc6f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


