Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960037F75B
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240871; cv=none; b=aSZQMOBtIp3WD091JzONrnIDGezrq6yrVslSyjEM+2m59AJviiuquZfkuwDcGLFlqKd5l1b8TiWFIQcUAnEMmDCqRCQchJF4uBF1AX23c7O9pXbghQMz9dPSpj6TuaEB3S0TBJ+JUekhHV2cmDlzGHz4U4njUkxzp7afJy6umzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240871; c=relaxed/simple;
	bh=6uM1ukBHTEHxzKM9xYVofLehBNgZSSEN/ZmMovqA4Wk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a/t3fnffMJUhbNAtdhJf25WWVOQhY9vY4bI5U7vyGGEICcVBFcsX97tqjqQJxX1UJtTUJ5y135o2tnEFy78lqLhUshuorkxVaMzABR7MRkB1inW0PY1CTsIYs6B8pXrDpvTvrZJ7N47jiX2Z9Ju4jCiJAQNMHyxJf4Vb4Kn66CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrbpvKBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrbpvKBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A791F00893;
	Sat, 12 Sep 2026 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240867;
	bh=Iw4dZFAaBRwajNx8jkfEQR9E5hmFi6lptIGpHUYIIBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PrbpvKBBLfajrfiGticgakzYoq80ee+G+CCC+4bJtA3+VVfQv544q5ifoZ1d79sMV
	 CeDQFTn1YrE+nBUCejbgGQ1lnGIs69YAKg8C/Qa62apUUrpCTFGUdWYdrZo9PbevMS
	 01nebOGu7VxXpYkKKdJkPzsvxLJuRoRnwePbqYPql1djmjqBb3xcY5jn0yxH5WuZRK
	 t7iYMguMzwDysloZo1aQig8usuXGLfVBtViXDf2zIqEryizGtLDwk0LhrKZitU32Uq
	 MueQVQ3pSVgQVNtf24LRB2727Cq3oUphRdzifBHhqQrTogUYE7bFn6BRh2+IIZOq11
	 Fiyd1/Wnone2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E6380820D;
	Sat, 12 Sep 2026 19:20:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Use kvfree() in xdp_test_run_teardown()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178924080365.3614666.15190881427976855112.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 19:20:03 +0000
References: <20260903104358.29228-1-running910@gmail.com>
In-Reply-To: <20260903104358.29228-1-running910@gmail.com>
To: Zhixing Chen <running910@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 18:43:58 +0800 you wrote:
> xdp_test_run_setup() allocates xdp->frames and xdp->skbs with
> kvmalloc_array(). The setup error path already releases both arrays with
> kvfree(), while the normal teardown path still uses kfree().
> 
> Use kvfree() in xdp_test_run_teardown() as well, so the release helper
> matches the allocator on both paths.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Use kvfree() in xdp_test_run_teardown()
    https://git.kernel.org/bpf/bpf/c/7d70a0b02d26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


