Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043B358386;
	Thu, 19 Mar 2026 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955462; cv=none; b=TC8qj/SyEBwRKx5DKb16p0sJySj+2fWZnF0bNRXkjb0GSQWO/5N40B7TVmvW79nG5vj2DFgooQ59PIeVudY+pmc1VVqm7SSyoKiTbBKvRDpW6Q8xV/1GoifKVY4TDmsN7vC9RLNPlxheeVGrPXlSl2Cttn4BrQXJ0sUWm3/mWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955462; c=relaxed/simple;
	bh=7QMcKkitHSe5yPhGmP83fIi+rSv+5T64EME3dNEitIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J+P0FvR/f+ULBC2/GRVsChtNL6bKDJVr5laHS1yGMMyeCEmmUw/eusJ9AFJdRTBZ+Xuz6OT59Mif1pSWVe+PWK+CkI+ZEi0Sxr0xn7EMtPzjcf9t6TzrDlFj1YmOOb/TLs9FYefRsLfBGbemdcJOBn7XU5N1Lai/+KRhiLOHKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzLTw/yt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzLTw/yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E252C19424;
	Thu, 19 Mar 2026 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773955462;
	bh=7QMcKkitHSe5yPhGmP83fIi+rSv+5T64EME3dNEitIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uzLTw/ytJdBIPr6XhiwHgDhGKjxUHEE7dIQoI8Eb+YebTbHcKGvy76yHMcjNnmE3f
	 5hpWLXCnKuzUaUSb4kUs+CTGM40Arsg71xWIZOmGZEBlanwUuA3fUDHHFGSBZSHLBK
	 jMt+tLTc8ARL32KTKDDEa2pXcKQkXmIjg22hIL7ekAJ8Tx2YpPl5y46tSZcQ4kDZTm
	 zokImpwvqGtlspoc8JyRWoM9qZekG6TJKX2Tdy7502D31cZVzhi5pTG6+ASFwP2vCY
	 OFTjQyh2fyyOUxCP+HiNtJ659946Dy50jEo5aEudxZzkjJzcZ8c4f7jeLIjNFaAZF1
	 +j4gueu9uyjOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4001439302F6;
	Thu, 19 Mar 2026 21:24:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] LoongArch: BPF: Make arch_protect_bpf_trampoline()
 return
 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177395545307.1805592.472462208613814092.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 21:24:13 +0000
References: <20260310064706.4985-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260310064706.4985-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: chenhuacai@kernel.org, hengqi.chen@gmail.com, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Huacai Chen <chenhuacai@loongson.cn>:

On Tue, 10 Mar 2026 14:47:06 +0800 you wrote:
> Occasionally, there exists "text_copy_cb: operation failed" when executing
> bpf selftests, the reason is copy_to_kernel_nofault() failed and the ecode
> of estat register is 0x4 (PME: Page Modification Exception) due to the pte
> is not writeable, the root cause is that there is another place to set pte
> readonly which is in the generic weak arch_protect_bpf_trampoline().
> 
> There are two ways to fix this race condition issue, the direct way is to
> modify the generic weak arch_protect_bpf_trampoline() to add a mutex lock
> for set_memory_rox(), but the other simple and proper way is to just make
> arch_protect_bpf_trampoline() return 0 in the arch-specific code because
> LoongArch already uses BPF prog pack allocator for trampoline.
> 
> [...]

Here is the summary with links:
  - [v1] LoongArch: BPF: Make arch_protect_bpf_trampoline() return 0
    https://git.kernel.org/netdev/net/c/b254c629a963

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


