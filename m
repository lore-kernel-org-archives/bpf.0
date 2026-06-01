Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCF4A33
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275017; cv=none; b=WLr0ExcOibUSNVzF9hsYeDA9IiENZtx6gq8Md2VKf8jpEWN4Xt18tYlKS/pKRa9EfoIqK2KhVOuYmAxwzYig7UTIusWGu4MQRFWUs2U6a1xEb1//4U/5piRChCTCXL8RYuMUZhytyvxZ1nUJ5BtrzJ8NkErQ3z9GEQ1IC9rbVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275017; c=relaxed/simple;
	bh=GzitOWtOvx1jnPb7HgbFWGeCuFOGZ36CyiBAkgo9CVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lfJaoOchJo3grie8FSrhbAquMgTxbcLRqH2zbEi3+5SEyjMo9y/Bi4sa7EMonkDpdgsXWxoPA8M2G26KQDd3qeUlWKHoQw4UEJ08d16UqYRE/IZc6BKwmcO6YDbfCF8algXACUfLT0qQCXVFjjU57AIAZKHxzRnSkkOVm5K8Nes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxjb5nzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxjb5nzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A01F00893;
	Mon,  1 Jun 2026 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275016;
	bh=2CYqpQij/ZbTz2mq7N+UytPGyMcIDrlrg4OtwazAJ38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hxjb5nziPofw0ltdkWLzoQV6RWxmrR6vBq4n3mcBHl2UztllfAqteQ7p2QFzjBq3R
	 ZFndQ7yZXtKtqXnecLhKfWCL9jM+UM4J8dbM1HQNIU9Zt5UG1fjsXFZ2zeooVLOhZV
	 OIYKATY2O55JrIPYpXI9kEpeuJ/yrEEMv8sJAXQD2h7OwsvCuyPnxJb8cKXczM3fu5
	 3QWIlmN+0vWpQEuQSowJiA55GYCQablu85YnfecZmglBuF8BJwUrFFZ1wVdq+eE1j1
	 R0ApIUvanxGNT18VX1CpGOyeSIVRMIlVN1MWnmYJx8Gq9WOsww5bt+cRvDbximXM8o
	 gGdbxg04CXX+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A5639302FC;
	Mon,  1 Jun 2026 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf, arm64: Stack argument fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178027501939.3441607.3307361090146995963.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 00:50:19 +0000
References: <20260528161750.1900674-1-puranjay@kernel.org>
In-Reply-To: <20260528161750.1900674-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 May 2026 09:17:46 -0700 you wrote:
> Patch 1 fixes a redundant MOV in the arm64 JIT's
> emit_stack_arg_store_imm() and clarifies the stack layout comments. This
> is not a bug fix but an improvement.
> 
> Patch 2 bumps the stack argument tests from 6-8 args to at least 10 so
> they actually exercise the native stack on arm64, where x0-x7 cover the
> first 8 arguments.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, arm64: Fix redundant MOV and clarify stack arg comments
    https://git.kernel.org/bpf/bpf-next/c/12a585e607fa
  - [bpf-next,2/2] selftests/bpf: Use at least 10 args in stack argument tests
    https://git.kernel.org/bpf/bpf-next/c/157317ba662a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


