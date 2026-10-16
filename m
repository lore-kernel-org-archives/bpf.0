Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C029B20A;
	Fri, 16 Oct 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111208; cv=none; b=N1HsT1AZ9YloPTY6eigwQQh4D12wGmchoIsGFMAzkdQjz7P8oEQPamMCPuC/XgOPMAh+rM61DOmWUrH0HYEpyRpTIjBa2z5rGcRe03ZKHiNBqer3jHSr47VmqvOsrYHXxfVJn6lEQPnigOSlRFanlfWfNBAoZxacl48ocgPJNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111208; c=relaxed/simple;
	bh=dS+ZhYxu9Wr4P4GuChGj0Code8XRh47DXH0uej69Gvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JE+tjJaS9o+w4Z/LIWrHuXH2SbK+yhznYQ1x/RHrEQ5yYxC0ftexcyUrdXvUYE/UcwI+CIyKLBsTWj6fVEqDnGeRsPTsoH0nEmKU0/F+AKxUsCAj8wrMt5MR4prIfFhUs44/+sDGEIqDrazXMb0WcjpiJLdSNFST34myHt+grmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQwfufV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQwfufV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827441F000C4;
	Fri, 16 Oct 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111207;
	bh=qjwvKB/xDcOemQGK9fT4G7VhJX29Nh0Ww9yAkysQTbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VQwfufV3hlo9YRHL1bHgDma28eypY5OG26vtHsMjNQQ+DYZkzszG+BfkJixntpZqs
	 zs9l7NkTe/aV9i9jRR6Xff92SYL9oMahr/VxI6ydDtQIeIzusTEshtp6v16BRD5AFL
	 KplH2E2lCe1MxMzm0+nXCKNQ6++ZAB5FkigPJtnkulqkESRlGl2hjaIrB0MiGgsl3R
	 WIt3Pxwh2dItxOizjt0Z+o4nkZqbmIP7jqNy5m/S05tXtnCNjxgzCr5b2I4Dp8Koku
	 aDRv9g2qUqb1XWtTzR26jc9B4p9ZH6gIubEbRZdf1lnL/pkN8DGXQhTb9FKygn0+Br
	 k90jd+pdDEJhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7746B3808209;
	Fri, 16 Oct 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: Fix prog_tests framework
 self-tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211120627.4176565.2753939265281766433.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:40:06 +0000
References: <20261012140202.2754552-1-kafai.wan@linux.dev>
In-Reply-To: <20261012140202.2754552-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Oct 2026 22:01:58 +0800 you wrote:
> Three prog_tests framework self-tests fail depending on how test_progs
> is invoked:
> 
> - ./test_progs -t prog_tests_framework/test_fail -v
>   test_prog_tests_framework:FAIL:skip_cnt_check
>   unexpected skip_cnt_check: actual 0 != expected 2
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Fix prog_tests framework subtest count checks
    https://git.kernel.org/bpf/bpf-next/c/c87652656a55
  - [bpf-next,2/3] selftests/bpf: Skip expected_msgs subtests when stdout is not saved
    https://git.kernel.org/bpf/bpf-next/c/cc4b1c161d92
  - [bpf-next,3/3] selftests/bpf: Skip compare_text subtest when stdout is not saved
    https://git.kernel.org/bpf/bpf-next/c/7ebf808caa76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


