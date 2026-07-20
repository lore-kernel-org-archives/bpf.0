Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB02DCF55
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574642; cv=none; b=CDE4jINbiIuJd5qZDc6J3dUxTyRII7xhh/DrDlmAEP1uemm0/IjgbfYjPzZsumZNrmil1R0j1WSMIUjuxx71LXCYvIYrZN8JbiQJI1yi9+lBSEgXHwiOM8eNbqH1ZcP34qeEelKm+30f8cPWEMGdtcJi+DGSLnNcrYNOvxiJIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574642; c=relaxed/simple;
	bh=4CJV/mKVrM6+VKdJl8TXhstkhJwnkk7OUAfzUtx9qm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BtvNlcsMz3B/0CtdNw6X12ugqCXlVmeTYWaP/p7/be5DbLRSC6Q2ffd1GelVWsNBDU8UL+IgX8qMC/WVwy4ghwTk5zKD9k4wlZlpP24haJepfUfNdFnYYpuot+74a/hNhHArEgoWvlMgqcy30De91Ug9mspNYq+Rmvd4VQcZCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlXLTyp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlXLTyp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676C21F000E9;
	Mon, 20 Jul 2026 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784574641;
	bh=U4/ZEUpqMgPvzSkQ5oimHUSdQNLaQpZgFBNHt+oTGS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VlXLTyp61hT+GCFX9svXFxU0EPsC/GsDRLawMzGHQKusR+gELAY0vIdeA7i/3OEI2
	 jJd9ipYGTSLt4rMzhIO6Qz7RIhJVDa9KaEa9hrzUQm0Zl17cAcpwfDplc8y34nuanu
	 OaWotAhga+bXal9LPXmx9odnLi2weTWb1lle4TqUThzQ9zii7QEPHymN1zD3w1wnKt
	 Sa9ByS7tyVhI5lesxuCNVzndQz0lPMBDW+dHBazISEpvbM7eukMfIymcitH8uQwQ/g
	 CV77qqDWS4UVVr9tRyM8G/pA72dorL7I19fgpQMtUThr8nv+pYU8ra5QQM7o25J9WN
	 I45hxinfWV0Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F039244CA;
	Mon, 20 Jul 2026 19:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix compilation with
 RELEASE=1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178457461164.4123047.1929607676311792554.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 19:10:11 +0000
References: <cover.1784112948.git.vmalik@redhat.com>
In-Reply-To: <cover.1784112948.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, ebiggers@kernel.org, sdf@fomichev.me

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 15 Jul 2026 13:21:59 +0200 you wrote:
> When compiling BPF selftests with RELEASE=1 (which most notably adds
> -O2), GCC reports several warnings. These are by default treated as
> errors and abort the compilation.
> 
> This series fixes all of the issues such that selftests can be compiled
> with RELEASE=1.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] selftests/bpf: Check malloc result with ASSERT_NEQ in test_loader
    https://git.kernel.org/bpf/bpf-next/c/40f986aed81f
  - [bpf-next,2/4] selftests/bpf: Check malloc result with ASSERT_NEQ in test_sha256
    https://git.kernel.org/bpf/bpf-next/c/eb5cd154f174
  - [bpf-next,3/4] selftests/bpf: Silence array bounds warning in global_map_resize
    https://git.kernel.org/bpf/bpf-next/c/dcd164ec67f8
  - [bpf-next,4/4] selftests/bpf: Silence maybe-uninitialized compiler warning in libarena
    https://git.kernel.org/bpf/bpf-next/c/5763790965eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


