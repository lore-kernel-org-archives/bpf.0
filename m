Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6203BADAA;
	Mon, 17 Aug 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958456; cv=none; b=BP2MGMk0vHNFvW2NXbvCHVXa+e/Ik+LsHclLyoOi1BR1m/6ZdYaiYhIvtTtyv24l5Vc4SmRg8K+exLEpL4gtSzcZ9pHsdKeWwvra5OlmUu9h/B9Xp6d85roY/jdRBgFwTNFweMjnyrvZsa8kghSrhJ0yeV1tq+lium2NqxAoZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958456; c=relaxed/simple;
	bh=ta7g2cxvov7TUku22VQzLqA7VtXieNjevpBzlEjV810=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZoySYGqnqou1Q0V5oWDdVpuSCNn5QkSkztsnOsVT/zl7e68ezG7t7/qZPlVsISCDnqSdmwA+TDUVjg+2zYeMZSbQhCOZB/nSgM/jUEKXx19nf9RZA8i7VvzCfXjRCbQK5tdHt8qPWvjaLfKSYyuWBY+pbNld22YZbjzdYL1sZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TADieu4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TADieu4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E987E1F000E9;
	Mon, 17 Aug 2026 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786958455;
	bh=n2q+8bFM8NBLHAUHpM6PZHD+hNnTopAORAsNWi9JvSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TADieu4R4szcOqgjWQa+I0KOllmdTY1Bl0IDjkrQs1OmNbA6JIk8FZzEQ/s8zQi02
	 /K6Z2gVa4nxRFNI46mrjt7a0MHrKWzd+1HrT5dgp/2FZd9aARz0SHAvrRuBxLg+mMs
	 8gw89fYDiyXdx9VHjb9kZmNNxAt2EzbqElEZD1epXEVBQ6NCZaS9+gVrjY69H1WYN4
	 6h3X4Dpo1hvXoRX8qUezwEqACesPOQulH/e5DueFvehzDqZtKrIiK62hbJ78ttXE3D
	 tSwD9786P77D2KAd2zZzWsgdXVKG3HXTRlHA6jRXra3hICSCc8zga8cbyg2UIZLXwj
	 q8zOYm27YUQdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938833924FE9;
	Mon, 17 Aug 2026 09:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX
 getname
 hooks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178695840740.1036045.289178403447627477.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 09:20:07 +0000
References: <20260812091654.244752-1-zirajs7@gmail.com>
In-Reply-To: <20260812091654.244752-1-zirajs7@gmail.com>
To: Junseo Lim <zirajs7@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, kuniyu@google.com,
 emil@etsalapatis.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 rhkrqnwk98@gmail.com, daan.j.demeyer@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 12 Aug 2026 18:16:54 +0900 you wrote:
> _bpf_setsockopt() and _bpf_getsockopt() call sock_owned_by_me() for
> full sockets, so these helpers expect the socket lock to be held.
> 
> BPF_CGROUP_UNIX_GETPEERNAME and BPF_CGROUP_UNIX_GETSOCKNAME run BPF
> programs without acquiring the socket lock. A program attached to
> either hook can therefore trigger the sock_owned_by_me() warning by
> calling bpf_setsockopt() or bpf_getsockopt().
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
    https://git.kernel.org/bpf/bpf-next/c/84473a7e1813

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


