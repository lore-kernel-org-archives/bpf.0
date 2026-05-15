Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8E35E1B2
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881793; cv=none; b=WbRyzwt0obmxnF61w/12n5ZtsHVXMfkwdQk8bi7KAZnxgl8dVyFYgXXpwHyUeQw/x7GtGetB1eBHFFfQMjaL8/7lCYXCrO4NVsUfatjhYkMpARJdcK/Yg4nKwz78OW2Fd+62L3gP+qsvnwPKSNmAkvkrgyZs1sh9a8XO6MzxHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881793; c=relaxed/simple;
	bh=WFsMMeR4duzN4SQwrHWvPzC2/RUHnZC/1BMoyZvpg38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GMd7joJaKfylGA2BywKfaWa1nujgFOO+rT5FLn6v5ZwzAfmEQAegRn0nR5MZkNXg+zBDtuISoRAeOMDY50kLkR0cRoQC3TyD86eXstiV0q/k+7FIZLVaGXWDxVMSabhie+ff9NJKQamESssAsqGULum466LS3FVvaq+5WUcujRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzUqNHD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzUqNHD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C6EC2BCB0;
	Fri, 15 May 2026 21:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778881792;
	bh=WFsMMeR4duzN4SQwrHWvPzC2/RUHnZC/1BMoyZvpg38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WzUqNHD4xbeFDeJNxWwwWIaIJvzZ8yzBHnaVjSneulVjpMHqFXWZnA28foVWA7k/e
	 5yVor1Ttp44kDuSKFoFp2EIMtpo4A+GmoIQhr4Z2sGatq0AktKWbzAIAH3DS0M2Nz+
	 A2JISOmJnhmSCPO0KZeDOIoalwsliEfl24UGOjOucD9yb6X/hHyu6jrvG7KdAND5Y8
	 tdfln+VusPB0areeW7tOCJtJfryGbV6Vdve7KIqIIxlhBxs4Gt6Gbip8C1jqEVwwa7
	 ihm7+0+fYT2wgb5dTXj6AvQ3gcSPVIvRHrLPLWctur65Szht3IMzeMgKcyRtgHQIUv
	 zMipiO3qGLI7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988E3930A12;
	Fri, 15 May 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Add Jiayuan Chen to sockmap maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177888180590.166525.10105377217463041007.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 21:50:05 +0000
References: <20260511-sockmap-ktls-fix-1-v1-1-96ff8c1906e4@cloudflare.com>
In-Reply-To: <20260511-sockmap-ktls-fix-1-v1-1-96ff8c1906e4@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jiayuan.chen@linux.dev, john.fastabend@gmail.com,
 martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 May 2026 14:10:22 +0200 you wrote:
> Nominate Jiayuan Chen for the sockmap co-maintainer. Jiayuan has been a
> regular contributor and reviewer for the sockmap and networking code.
> 
> Since we are now down to just two maintainers, and John has to split his
> time between BPF core, BPF networking, and sockmap, having three
> maintainers again will help with the review load.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Add Jiayuan Chen to sockmap maintainers
    https://git.kernel.org/bpf/bpf-next/c/c8993263ffd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


