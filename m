Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A014C59E
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577433; cv=none; b=JISr0xliEaRtS2tHjUCBDSz30JtHLMr9OaPTIFr45/+/cvahPRkUxFtMyRApeXUGjJwBTe7uy1HM41A1LzTMNSYyI4h2KPb6JPfp0xxhUf9bE/bCZLtR99rifFtwyMABktKfELlPxRkVvhWtjik2QQY7urH05O+Ra73sLKh0pk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577433; c=relaxed/simple;
	bh=N7uSYx5fxAIM211OQxu7ovqyRWkOtVPpdS7bBoKp40M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qXCI5T+7m9GvlWqN8FcSOvcUWqvhIXbHlZon8RMa9pDEwyI+/rQM2WxrhCjdVfacUlARWE52Ooyk8V+JEY1Vqkfi2+1LD6Ud+u7ghsA4XemGm5i02bo6Roo2B1HtHlYw08a/cFqIl0j35jq93Pt0CJkEcqVg337Q9nlvQOgxh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfYlKRIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfYlKRIO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28071C43394;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711577433;
	bh=N7uSYx5fxAIM211OQxu7ovqyRWkOtVPpdS7bBoKp40M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dfYlKRIOUArloi+7Q1bOjiHIazYeshO11/gPeNN6NRrvZVlep8Rn8X+s9Ia1QxDFA
	 FJDHp2YzEzd9WqJWoM0iYtlY+o8MZH2/rHJHsuvrQacnbt1HlY229/MYR4gGUJVt1Y
	 OMUJgmi9ypJqHyO8NYqDypsuI5U81G5p72e0OCjE2lMdltZxfInn+V1Rk30aixbKfB
	 SpaJGJDQxFs4MkuELCY41pKfKcKT5rBzP7Xzlh8B8qaOdyMj/LFSuFDpqwZnHkZyEU
	 07TDN8piujr2nHhgrrk73h0X4YeCQ1/0s8TO2qgMKJrouHXRAupFgb5JMine1fJeRQ
	 VAzjXNxhJNZRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16206D95063;
	Wed, 27 Mar 2024 22:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v2 1/1] bpf: Mitigate latency spikes associated with
 freeing non-preallocated htab
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171157743308.7147.94289008814836168.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 22:10:33 +0000
References: <20240327032022.78391-1-laoar.shao@gmail.com>
In-Reply-To: <20240327032022.78391-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 27 Mar 2024 11:20:22 +0800 you wrote:
> Following the recent upgrade of one of our BPF programs, we encountered
> significant latency spikes affecting other applications running on the same
> host. After thorough investigation, we identified that these spikes were
> primarily caused by the prolonged duration required to free a
> non-preallocated htab with approximately 2 million keys.
> 
> Notably, our kernel configuration lacks the presence of CONFIG_PREEMPT. In
> scenarios where kernel execution extends excessively, other threads might
> be starved of CPU time, resulting in latency issues across the system. To
> mitigate this, we've adopted a proactive approach by incorporating
> cond_resched() calls within the kernel code. This ensures that during
> lengthy kernel operations, the scheduler is invoked periodically to provide
> opportunities for other threads to execute.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/1] bpf: Mitigate latency spikes associated with freeing non-preallocated htab
    https://git.kernel.org/bpf/bpf-next/c/cb7b8322017e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


