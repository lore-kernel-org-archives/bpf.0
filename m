Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9C2AE76
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875865; cv=none; b=OotaUisFdO20n/hVNGE1qjs7YYA/+d1HBU+mSOXyZNoFNpkMMSJ69MCS7s6sE+hIABAY/SG+FCjmfr2i9jzQqUcsXPs1Nn+NawNqbUdxIQ+iEnEjBow9CqxDgUwAITMvL2JFCiHOSkV8JCcUfjQM7F6S9nzL9UKI+5ysSGikl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875865; c=relaxed/simple;
	bh=gkriD01FCcI2WpjZ8QzwF0vC7lvuCdSWxX2SvJyxsb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VWxfBGM4Tc1oVSkte3amOel4wASRaPzi35AvFfZfYinDPOw1RbhDw40zXs55CQwLF/q5I9mIAkvz/L4f1LtdnkSOIRSevRZu25mAxbdXIitsynPF3s2O1BnlZW8bop26RZ4Z8+R6TOX3mBfLwhYPD7Z2pskDQ+iQJFVlNCUtx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBCJiJg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBCJiJg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1571F000E9;
	Fri, 28 Aug 2026 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787875863;
	bh=+gdb42AqW9MxFHRsVR3/kTjZZsZFu4QUnZQBDkac1K4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mBCJiJg9xfjN6KcHjWrshRAKuF9BHvbGRGRXA9Gt2N2Qh5XW1K+lZj4iyt2CDM9ur
	 iVO7QfgUB8x9nq72yU4FVZrsoyyfb5909bGN/IiPZb6jAre7eipVIYAbjmcQ9TdQnL
	 j44gLKZEUOHRQo/oHBxPsWZIfwPbGJiki9X4kVwe4gJKcNJMguRdDAKCvGFQAFFiY5
	 CvGvcfInSmq2NPuKxPA5X4z5hrotalgD9oCzkLmZ7K0ZFAoeUBdxMJ+VvZJWQa9e/I
	 NKiWNbtUBVrk4WsF4j00wYk6y8bLJEhTy4mcr20CNaBcet8rw4gF1Lz5lOlHsmwBGa
	 Q34NHtqEj4qow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395F3809A8D;
	Fri, 28 Aug 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 1/2] bpftool: fix spurious batch file read
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178787580816.1904688.16155648098881499182.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 00:10:08 +0000
References: <20260824092657.1789956-2-chenyuan_fl@163.com>
In-Reply-To: <20260824092657.1789956-2-chenyuan_fl@163.com>
To: Yuan Chen <chenyuan_fl@163.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 andrii.nakryiko@gmail.com, chenyuan@kylinos.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 24 Aug 2026 17:26:56 +0800 you wrote:
> do_batch() checks errno after the read loop to detect read failures,
> but fgets() does not clear errno on success, so a stale errno left by
> a previously executed command (e.g. map dump's EBADF from a double
> close) makes bpftool report a batch file read failure and exit with an
> error even though every command succeeded.
> 
> Clear errno before each fgets() call, so the post-loop check only
> sees the outcome of the last read: zero on success or EOF, E2BIG for
> an overlong line, and a genuine errno when fgets() fails.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpftool: fix spurious batch file read error
    https://git.kernel.org/bpf/bpf-next/c/713c02b59e21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


