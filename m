Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59247B428
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937456; cv=none; b=gjIRMRYFE9TCpDTOVD21AYlknlJMJG+Tz+uQWOb5LFWB8ZvVu6A09LAoDflmte5WS08a6X656XV5KZxTVrO7Xbwx7EK41i1Si0WYbijCgFOKdiUB8V9wEHKFDS+SP+qHh0NzqNNJLwElYktyRLn7NseAZpKmn623OUoS+J+pt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937456; c=relaxed/simple;
	bh=fOeRw6eNrANTOnE191EakWEVRdDFwiV9p6y6ZddbwJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d50yRw0Y59mxXMt4qYznQmY9O6vczgXujYMCNvP4vXEtg2DIRyxGG/NH3BoxLUCTNDAqvcJDi+9PxXPuG52+e9y7aPy5jILRpTQw9sbFApitk1TS/mZ7jbjSoUQySNaQADZa8GFgZqE/ee3GakXws264fiT4pQ48r39Q3FXzEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed528EOe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed528EOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917F7C16AAE;
	Tue, 20 Jan 2026 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937456;
	bh=fOeRw6eNrANTOnE191EakWEVRdDFwiV9p6y6ZddbwJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ed528EOeyFp2bNnh96DA5BBwIEtDZVAh3IRCaLH9XqEb7Zi9VGBMx3COaCr5rNZvt
	 ddH8Lx4NHEK3M5pigCzJ0QlYV04yWvw9T5RPozduVFrTSqbRNXcKUsxhMhMpfJBwaC
	 qT2wG8aB3k7NVkBHiA/PGElh/2rwYQWeD53N6kVPcWamYcHNBsrWnQNmfmBDiG9gmb
	 0jFg0D7wSZsGCZngLe6nLZIROOB8tT7+keP8d2kgr6zWYpyrVij2DT0+gA3FpMuJmC
	 4JF/XJ2vjKJpBd+kZgdn8AWpWzAh6fBXWcuqfHU2XkQI5E8ZdG+X2TL+DZ6sUZifks
	 q3q4zpOFnDNPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EBC7380820D;
	Tue, 20 Jan 2026 19:30:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: verifier: Make sync_linked_regs() scratch
 registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176893745410.579155.10082785877014837582.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 19:30:54 +0000
References: <20260116141436.3715322-1-puranjay@kernel.org>
In-Reply-To: <20260116141436.3715322-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 16 Jan 2026 06:14:35 -0800 you wrote:
> sync_linked_regs() is called after a conditional jump to propagate new
> bounds of a register to all its liked registers. But the verifier log
> only prints the state of the register that is part of the conditional
> jump.
> 
> Make sync_linked_regs() scratch the registers whose bounds have been
> updated by propagation from a known register.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: verifier: Make sync_linked_regs() scratch registers
    https://git.kernel.org/bpf/bpf-next/c/ef7d4e42d16f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


