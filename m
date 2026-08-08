Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C731D375
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183260; cv=none; b=aL37hdW167Lx8kpfdy5WBg4m/NpAEyGqov+UOyVNILxtrwqb8sR60gxZdJZo7P1eaOFcbhJ0Y8DbaK03hJuIzVwNynnUZTtDMA2JITI566g87HNrTu8rfggwK0Ma/JUOewvwRmWKoGLtViPpvkvwfuq/YpIQEJ7amCKME7H7L0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183260; c=relaxed/simple;
	bh=wNeBlKBYNws/kKkRre3qDKwwaXDePcMMQMpaUL0TOtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uz4wTvxNBW9xS6BdhDpr6WvArYvzLz5xG40ilXk/tz083OO/WEg5/go/LuN5hbbzdU46l4U4f0XYqPl3ktbJAbjXHpRQCLgm7FAL+Gi1oQyW8FAkevUPV3NUjk54WrCSifk0PI2iD5zerHGeL55Op3+ewSqXEpMDozL1Vi/uWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqDviRkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqDviRkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373F31F000E9;
	Sat,  8 Aug 2026 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786183259;
	bh=2/WnU+xI9l5lfIHNNPm1Mt/njPqa5/8Xxz94B9dlK9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HqDviRkAbvvsJ4Ksv4Z/0kAQbi7ItmcI9xddoejEVP2d8HtuRlfhUA4jwPTQS2kyd
	 eyReXMK12+clIuxsZ4+V2B3AzKqyr+XQhPH9Iukk31h4nZJXeHRxeTu+OBJz9YJw2Y
	 jpyzQBNcd27ZsPdqmD8ETwDZXiKsxDA5ZrLyBTGz9jGLoEmyTAL+s/jGc6wQlBhz+3
	 VAlpjyoSlXusL1AC/0kH2VIwWRzrzDrV0XOSoLc5oVFYVRAMJJk33ICWrdUlG1+DZ4
	 mO8PpeRhoeBddACrCLA3YQQxIaZSP5FtoLcdEqnybArmmPIFsZo8D59/UfFMsnQkGc
	 sDWsNRsPElX9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93979380CFDB;
	Sat,  8 Aug 2026 10:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/7] bpf: infer zext_dst based on static
 register
 liveness analysis
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178618321739.2608563.17198560772971650836.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 10:00:17 +0000
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
In-Reply-To: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, iii@linux.ibm.com,
 gimm78064@gmail.com, info@starlabs.sg

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  7 Aug 2026 13:59:29 -0700 you wrote:
> Min-gyu Kim reported a bug in 32-bit operations zero extension
> handling [1]. The same issue was independently identified by
> STAR Labs SG. The bug was introduced by the commit [2].
> The tl;dr of the bug is that the verifier does not carry zero
> extension marks across pruning points. The detailed mechanism is
> described in patch #3.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/7] bpf: do not print a newline after disassembly in bpf_verbose_insn()
    https://git.kernel.org/bpf/bpf-next/c/483a1bb0b6cf
  - [bpf-next,v4,2/7] bpf: extract is_addr_space_cast32() utility function
    https://git.kernel.org/bpf/bpf-next/c/d977dca7d073
  - [bpf-next,v4,3/7] bpf: move bpf_is_reg64() to fixups.c
    https://git.kernel.org/bpf/bpf-next/c/05b71078f305
  - [bpf-next,v4,4/7] bpf: track upper 32-bit register halves' liveness in compute_live_registers()
    https://git.kernel.org/bpf/bpf-next/c/ef1ddbfcfaef
  - [bpf-next,v4,5/7] bpf: infer zext_dst based on static register liveness analysis
    https://git.kernel.org/bpf/bpf-next/c/7ce090afbf72
  - [bpf-next,v4,6/7] bpf: simplify the bpf_is_reg64()
    https://git.kernel.org/bpf/bpf-next/c/be4f8d6f2ff7
  - [bpf-next,v4,7/7] selftests/bpf: verify zext_dst annotations for various instructions
    https://git.kernel.org/bpf/bpf-next/c/8b365b3c68b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


