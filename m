Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611E544A3F2
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373267; cv=none; b=NvQoR8yQCMb4QxwqcQZ3SqBfWJ+THkGGNfyfNcGjHQEKn8X94ihKjXqkLx31rCkdiLM5xKFz7OMyMwbBCBs8CKvHcR5estlywy1qzGBp6W9ErrYz1za1gOi9OLLiIFdlCV+jNwz6eqtjJYSGpBE5NEYk56bJYSiwDIfDuOencDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373267; c=relaxed/simple;
	bh=YzTMtsDyPbiQwz1vLNBwseBVoSHO7uKXuT1q8jHY8GA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A9UP8jqPORCHxt1uPTTEp6BOoy3ViK9mW+8mYRVXHM5Fym5Z23f+AOyzcKhPFWLgM3VW9qimvkGHHjqIvQS7qMp73ktMAs8Vb+NpzOXwghyORmYcSvLy6mjzqzwwXbZTRVkUQl8VcxILUNK3rbhZBLylYPtj021Yf2WtjLl4Cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAqGzDXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAqGzDXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E031F000E9;
	Wed,  2 Sep 2026 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788373265;
	bh=+RbdSCWn35/fLBHRH9Z6RSOdiqhybJZFifTffeFIT3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eAqGzDXPaPPoYu+A2qLZYeJVo8DqxIhC/0rCqhpuUEcy1o0fwUmJ/22PcTjqFsXwC
	 yD7+6r0JGdkdwCv2J7Udj+uHlrIUhGLJurNI72ItfXmkNigebngPkfqV62yeltuNH0
	 Q1yAzuX5t7rCGUzDdqOPn9yq1r7I0CuolQDq7UxOuxRbKgCfB8jyyL08/PQsk8K0jc
	 q72Ia+3iggRVCgEAgPRTe2VdSa7Np8wICGMAK8fNaxNH+Ef8qF20w/PqzyMG69LL8N
	 5roeidB9MPvvjYfITZVgk0tT1NCLxfS+KtXJFUbwgoz3G5Ng9i0L8qNttO9lErryb5
	 afqyIrg+GEFxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A173926662;
	Wed,  2 Sep 2026 18:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: backtracking shouldn't clear outer frame
 R1-R5
 for callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178837320765.2884595.7267988121668407897.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 18:20:07 +0000
References: 
 <20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
In-Reply-To: 
 <20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 31 Aug 2026 18:36:09 -0700 you wrote:
> When processing calls to bpf_loop() verifier marks R1 (and R4) as
> precise. R1 tracks loop iterations number and because of the
> 'callback_depth < R1' mechanics in check_helper_call() must be marked
> precise. However, precision propagation for R1 was broken,
> when bpf_loop() call was verified on a second iteration.
> 
> Consider the following verification trace:
> - main: bpf_loop(nr_loops, callback ...)
> - callback: BPF_EXIT
> - main: bpf_loop(nr_loops, callback ...)
> - ...
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks
    https://git.kernel.org/bpf/bpf/c/e3e4f66cc4b7
  - [bpf,2/2] selftests/bpf: test case for unsafe pruning of bpf_loop checkpoints
    https://git.kernel.org/bpf/bpf/c/7ac966218906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


