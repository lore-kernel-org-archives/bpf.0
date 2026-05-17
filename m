Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B02E4257
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042597; cv=none; b=r204trgjEP61IVXGjXtzXJMDDbK3d+0CnjyuE7AP8dXT/LLN2nuMa9dJtD87snZ+jPwNPIW9MRdm17YPmXldZ1T6CtuED3WFqUyahvLxeqimQoztmPBzlY+YtGT3r7S2hgrI1cE5HeGiXnI6gmAKLD5BeYt4agX/fShbIWl2Z78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042597; c=relaxed/simple;
	bh=S9/YxYiHtOppHNhoPbMa/XD3QmO9yd7YgVzVAAuTh7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d5qHeHDJBTVeEQEw+XhbNxpyLc806WJGJjV7/VahRJk8PyybAoRiGYFQXypyiMkGYdOzBZrEuApHCuZcKOwsPQJq9OZln1xsLanRlmJUo4oJ7fh6f6sJfmg+bU0BSDCEj4GVibls/gCZaoV9MpArZAd8bYTaeC46FIa4+65BtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1ByCx+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1ByCx+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C8BC2BCB8;
	Sun, 17 May 2026 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042596;
	bh=S9/YxYiHtOppHNhoPbMa/XD3QmO9yd7YgVzVAAuTh7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1ByCx+4xkb5Uw8vB21fEH78EPXWxeicGqNCt5hAS/NQa+JBLqC8FCzSqh910bkhP
	 t4k9wtomb6xSXaOUd1jruObg5aRb47oHWkeiK1V9mgFph41ltijbY0KmL7Uz3Dbxtq
	 1LCR7xQwHEVHiss55QficBOrexnBDbRjMING2p9aA6BDa6O2qeles6kaKuAj3/Dp0C
	 O9o44U+Gk01438U1x2w5XRWan1HTLruopCtseI4SkQmIAOJ3bgylBOdgZOCTYpquzP
	 yJ6RcGGHpkcTCKIOEU3T1WqsuaHYRlTmSm6SUQTPr4ImP5wl2cjbwvsa2Xa8ZMO1tJ
	 ZD4o9N8f+PqPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197C33930B3F;
	Sun, 17 May 2026 18:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Fix bpf_throw() <> global subprogs interaction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177904260889.659339.4569039554862787314.git-patchwork-notify@kernel.org>
Date: Sun, 17 May 2026 18:30:08 +0000
References: <20260517075530.3461166-1-memxor@gmail.com>
In-Reply-To: <20260517075530.3461166-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 17 May 2026 09:55:27 +0200 you wrote:
> There is a bug where bpf_throw()'s reachability across global subprogs
> is missed by the verifier, leading to successful verification when any
> kernel resource or lock is held across global subprog call boundary.
> 
> Fix this by effect summarization like other related side effects and
> propagate exception reachability into callees.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Check global subprog exception paths
    https://git.kernel.org/bpf/bpf/c/3d562d35a044
  - [bpf,v2,2/2] selftests/bpf: Cover global subprog exception leaks
    https://git.kernel.org/bpf/bpf/c/511a5db3c9ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


