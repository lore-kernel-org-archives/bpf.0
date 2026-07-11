Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE0EED8;
	Sat, 11 Jul 2026 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728033; cv=none; b=g36KGfVUWkUToiu/CMRRdQnLRX7vZ5Uc+pFHNXaddL5L7agc4x6q3jzkooLHoT6m1P6aj+aESAZyKl+3CEFwDnL2Yqs+1qKfO6SlIEuw4ZdGt5uFv1dKzrRwG7MgJm9pnk8zw4udlZ05KUkE+kVMsYSWo/D+Nb2J9S85jU7A2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728033; c=relaxed/simple;
	bh=V4QNLe4IXuz97tFpsTP2Ei5WYdZxiiBb+u4aU+j2LHM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G714t3lPTfodTwRmDhCDYeW/Jdpc0MYwHtmv1MOdRuaT3oubHjRqqMj9V9BalNmyoxB3HPK0ZmS+QeUsg4h4r43L4/RkL2axsy/P70cqulpOlAJuUXZAkhFcCPek4xVH6Z3/u48OkeTJGXq3fo3liG/gCBqCTH/1C4sPwcKkr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJbxqpbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJbxqpbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3661F000E9;
	Sat, 11 Jul 2026 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783728031;
	bh=rseEh/EcAP9rXNY8fCcY8zrhvWK6WV1/p+5QCM7UzwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UJbxqpbBs6EWcVMM4QCbsofunl719j3PYZt+x/k+O435osqOpmoTukfK7YVtcdqGP
	 YnEvOhcJe/I/TGYdHmSSYLE9twu2akjcPwWUCr6W7ZwwIMRG+MIku5xj66PeD6B3Cp
	 VBLeh/8fEpXhl39EHB0CN2SNBZXIxJkOC79SRmGcd7HVxopmipnhFmH/N37Mes5Xhg
	 DQEPhPrPMJd9SGmWtD26n/1zQwiLHnpjolu4ctPzces+EqGroBCJW566cw/CMD6+YU
	 lXkXtrBWbBOUL3u7UPEacKYlKJ+KU9pu2NWgjVJiW3Q4NCLkGq3Z53m/SYGO51chhQ
	 iLyU4cgv3Hv4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1A39244DF;
	Sat, 11 Jul 2026 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: require an owned cpumask for
 bpf_cpumask_populate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178372800913.929145.8725635647781013521.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jul 2026 00:00:09 +0000
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
In-Reply-To: <20260709182800.2037938-1-main.kalliope@gmail.com>
To: Admin <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, tj@kernel.org, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org,
 sched-ext@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu,  9 Jul 2026 14:27:58 -0400 you wrote:
> bpf_cpumask_populate() writes its destination with bitmap_copy() but
> types it as struct cpumask *, so the verifier accepts a borrowed,
> read-only cpumask (for example from scx_bpf_get_online_cpumask()) as a
> writable destination. Fix it and add a selftest for coverage.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Require a BPF cpumask for bpf_cpumask_populate()
    https://git.kernel.org/bpf/bpf-next/c/63a704c8b369
  - [bpf-next,v3,2/2] selftests/bpf: test bpf_cpumask_populate() rejects a borrowed cpumask
    https://git.kernel.org/bpf/bpf-next/c/5aaad4d9fe9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


