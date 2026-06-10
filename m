Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC17A2C11CA
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065812; cv=none; b=GxDSLohGK4O/iyIZBKRqRE2if+w+OYVATULs+YRQzHDSl7dUQPCKjlIsOvXSKV7KUuricfr+3JqaUXV+LEt42LWFdSO5r7KDKtJDQxVl4Je+fuPE3sD7e/tOclEUgl0/TbLbNEpR60u4VWebrvpJszBHob0LFBDYt/Qkm0HTx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065812; c=relaxed/simple;
	bh=gLyl6he89aQe/J0A1C/VC3ntdg3Km+6DaLlpYEXS6FM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LrWFN2jkLhlddw4FsFY4dGHlbR3si49gRD2cQULYycelLV1TUwB7WsyPUtyopmEttEU+bzRcWIhH5FnzgqqvcLFiz2wtY0iNqLd0IgbRCdUMO9ilMZIaylzr8NOrtqZKaQHx/9mZyL3NL1ZSLtC/WVZg9aGh0SEMYc2y99mNNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIkuVz54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIkuVz54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839681F00893;
	Wed, 10 Jun 2026 04:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781065811;
	bh=Q2dbDMYtMWJ7GrwXOUIfrARKrLgRR91NvzaEon9RZuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EIkuVz54SuOUsIdgzfbsppbVXLGzABmU7HPfrroifyec2JG8AAHmf84odEFVLHBTm
	 JmkFLi+SpSFMBZ9YtzLvLrb9Xu/6U/emodblh2V7Ogk+UwZF+qSK1Q2Stu65qvWyKj
	 6jDONQqLYUafL4kFimS7m3ksoHJvwY+7MrAZ8kUJ0lioXPMcf+mGAwia93gpFr0rsa
	 3FD8TRVDGi61LfMNga+sWls+G6cAv64NT7N4ioX6e2xqzp1JrbQj5bF7fEvBUuQT43
	 ahtmj89MJ6xwmnCn7uZ9VbfJ9ROCkOczz7SKawj1FPyzzky6/sGUXKVv2KiFGgg3A+
	 n5v6nZbQeF21A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B5F3930A21;
	Wed, 10 Jun 2026 04:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: Fix tests for llvm23 true
 signature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178106580939.2828762.10870449379729084922.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 04:30:09 +0000
References: <20260609233402.2711071-1-yonghong.song@linux.dev>
In-Reply-To: <20260609233402.2711071-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jun 2026 16:34:02 -0700 you wrote:
> LLVM23 ([1]) records the 'true' function signature in BTF, i.e. the
> signature inferred after optimization rather than the one written in C.
> This caused two kinds of selftest failures (see below).
> 
> Case 1: keep int return type for tailcall subprogs
> 
> The verifier requires any subprog that issues a bpf_tail_call to return
> an 'int' (see check_btf_func() in kernel/bpf/check_btf.c, which rejects
> it with "tail_call is only allowed in functions that return 'int'").
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Keep int return type for tailcall subprogs
    https://git.kernel.org/bpf/bpf-next/c/be1d838b88e4
  - [bpf-next,v2,2/2] selftests/bpf: Adjust fexit_bpf2bpf ctx layout for llvm23 true signature
    https://git.kernel.org/bpf/bpf-next/c/e775c522a455

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


