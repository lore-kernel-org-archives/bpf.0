Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71604314B96;
	Thu, 14 May 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778824; cv=none; b=C9M6QcpkpF1fWTk16E2qOmP/44ajL+4pVSOmefboivsybpYg0vhLYWAn6SnaqDZ/lKOVPdnY+Y3WmYnRZjA9e0zmRyYQZQ7sRwfoUf/0Cmth0sLw7kGde73IbLPcBpBdnT5D4ZVxPgW0ZgtuEWtYTsSyAij9C1p0fBoEnuQAPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778824; c=relaxed/simple;
	bh=KbZQRfnQm5mkUUB29RJHYmzgawQVwNxuILs/j++eqyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I6nb6ZSvQR7vabLJKcPzr8mu0dnRgfjXYwyWhWFwxS347fXkCH2ErH6/euk9RFzhcLgdaxtB0kR03AHM+1Y3jIW6Nj7oRhBzvlxeXg2JtFFjZHVqkfl/ExCtM8ulq244w9onRrj5CDqWTBW9vRLwIf7qKWtEuK2OYMvLlIt48fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8P1KZoI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8P1KZoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D87C2BCB3;
	Thu, 14 May 2026 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778778824;
	bh=KbZQRfnQm5mkUUB29RJHYmzgawQVwNxuILs/j++eqyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8P1KZoIstA5uS1GvXFst6q4cw/mBFQdXwOlDp3n6PXg+bwpS5bAsxFxlQcLmtWII
	 zSfcRo6965xx8hJ3WTkR5S9NL1e9NOf9ezAVDNUPkL7pe6GA8oFLAPVdN1Rn+qmdST
	 rNlDjTqXNc25qFTV5B2bLIzz9BtIdx1VNLNvQ2GoSGXQYWxqFzqOIR/gRvjH31Rnws
	 liquPneM0DTxIC6X2eEN9LTGIVwwnVM64BZUgBv4RALtzcI05tPQvEsyg6oGET445I
	 Co0He3L5tsUr4XWwvWYyj+RLyuDZVwJb995uYkfVmRWkLO58vOoCgVmeyIYrsFsI6E
	 77hQrfEo3Yybg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E7239D6579;
	Thu, 14 May 2026 17:12:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] fprobe: Fix unregister_fprobe() to wait for RCU grace
 period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177877876880.17572.18229192907232501978.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 17:12:48 +0000
References: 
 <177813998919.256460.2809243930741138224.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: 
 <177813998919.256460.2809243930741138224.stgit@mhiramat.tok.corp.google.com>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Masami Hiramatsu (Google) <mhiramat@kernel.org>:

On Thu,  7 May 2026 16:46:29 +0900 you wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
> changed fprobe to register struct fprobe to an rcu-hlist, but it forgot
> to wait for RCU GP. Thus there can be use-after-free if the fprobe is
> released right after unregistering. This can be happened on fprobe
> event and sample module code.
> 
> [...]

Here is the summary with links:
  - [v2] fprobe: Fix unregister_fprobe() to wait for RCU grace period
    https://git.kernel.org/netdev/net/c/657b594b2084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


