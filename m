Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752808;
	b=R6TdGIOALknZjAaUcKLWuK7D7tQ5uah4HnJ37J1G/cfyLbb1JgCFqfUXMYLgh5bfoHaJ
	 JniD6Z4lervJmKz/XU1CgEM365Az77wEP7BJv9VS/+yQU/HpxxwK4s3fMsT4WwL0uXdGM
	 ag8+DZr9rRr/v1ADBe738qUnEDS/PSUgiBHcILt79mLlP7dNbA6G7cShAk+9WiWoCLGJt
	 KdJFxNu2idg4CU/TQZciYjlSlELQV1Hkr8swdcLn9hTdlsH/Zao7Xx2ewpZruglZM2aFe
	 SaXlKyJf0loOddHzejkslngptAo/fAzJ/73nZ8E9txJzimXCxc1VCAEHcyggYzV1TUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=j2JaS/R7X/xCfgXzHtVUd9SRGUmcF3AJ821t7IZ28HE=;
	b=trE+aLznjv9CUhlvtTiFPHJV8mkfjFKyVwMsvmv9D4907EYfsTYYgisKJa3JAjDaR2n+
	 c3s20WKKQfU32oEsIrMgvC2a+OSTDXjUg8LsWRK1rguT28xPTLKcBN391cjEvnNLKyuMZ
	 BQW9MBCb2+57s4HcyNUA1Iwa8UO13Z0xHzykYZxSLjCfrreQTHdqVP+MVQ7j2AfHWQzFl
	 JRhSh9IAhlwFmu56bsjrEUpr4usGHDtv7QsO4n6jVoHr4bBYfgVLTk1bkH3BLIncJc2hS
	 N2Ry1YR+EO08lsRWehENwN48GUSCBl5P2sZAv3SPz1V/6aHDSM8yRxa2ZSWnwRprQOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRkxRMJ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DF606A31B;
	Wed,  4 Nov 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRkxRMJ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B1E1F000C1;
	Wed,  4 Nov 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793752807;
	bh=j2JaS/R7X/xCfgXzHtVUd9SRGUmcF3AJ821t7IZ28HE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bRkxRMJ2mht5hrVJIYWewOQuogYHCqN2a+ZYYRsID8Rfpu5wE4hexqAdPrpWKt3ee
	 2M53OMB78sKmVw+FPuIc7tV6ZA2+ZmpE4TVjnHwHpp0SKZ2zVEEUECabf5ryGIa7hC
	 SQUoI+KXyyj5n7OfAvpEJSB3rcExZpqhjrLDEtj+U07/cqipdPhwlz3bft8QOPy75U
	 5oyk5Qc+5/b0PK9cDLfjSq+ROYH2mFHPZv1Wioy6ESAVjSLPbBFaEZQPSnM+kwSkfu
	 VFbAeegPWrkYcaIxXbMkR13XjQPgDxtDEZHHlWDERhtYXofaFc18oRV84Zh3VSl8aL
	 bfOaVZG9dRioQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D519391B168;
	Wed,  4 Nov 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpftool: Make the LLVM disassembler an
 optional runtime dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179375280630.1976018.3900503813483067924.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 00:40:06 +0000
References: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
In-Reply-To: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
To: Mark Korenberg <socketpair@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, nathan@kernel.org,
 morbo@google.com, justinstitt@google.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, ndesaulniers@google.com, kuba@kernel.org,
 sdf@fomichev.me, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 03 Nov 2026 18:59:52 +0500 you wrote:
> libLLVM (~140 MiB on Fedora) is a hard dependency of bpftool, although it
> is only used by "bpftool prog dump jited". With this series, bpftool is
> no longer linked with libLLVM.so but loads it with dlopen() when it needs
> to disassemble JITed programs, so that distributions can make it optional.
> Patch 1 fixes a leak found on the way. Patch 2 makes "prog dump jited
> ... file FILE" work without a disassembler.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpftool: Fix disposal of the LLVM disassembler context
    https://git.kernel.org/bpf/bpf-next/c/abf197dfc622
  - [bpf-next,v5,2/3] bpftool: Don't require a disassembler to dump a JITed program to a file
    https://git.kernel.org/bpf/bpf-next/c/40dbd552e2b1
  - [bpf-next,v5,3/3] bpftool: Make the LLVM disassembler an optional runtime dependency
    https://git.kernel.org/bpf/bpf-next/c/1c9ca39c56ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


