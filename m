Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842212;
	b=kLI8b1DzYEqTGx6hiAr4QIj/pIiS8Vs5BUiw+Vis3pAPikTeDLJ0FPsDzUsvz90TWWY2
	 OJ/gObGfzDWfuLIMZNEwqF6wTHubuMBrIi46Fpn/r1ebWZHRNyy2Y7dpUcTCpBgvfx0fn
	 yI3qKXqxHYWkOTHBzOcrJJzpq/KpiaBj+PSbgy2QGOoLZGTD6X/UfSbl6nbi1rR6ELYXG
	 B6kZ9YVeRHrdPT+0tinFhzoWHi1Y8vkQ1xIBmuNy1GVYRR3Zbuia4ptLfKi6X1XHXCxaf
	 +uNNdUumYopV7AllHKUBcv7YrrL438/Qd3KsDwAXg+ymcFItmlyoFji45rD4ROvYT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bNlrPhpQ5XpM4H24b707S71Bb+NZPT5gpAY0vSZArFA=;
	b=1bY3mNIMw4cJtXeoZGdBHjGjRQ20aEboYNpH9PFY7jv6YDKbClx2OBStoS9vOIE+Un9P
	 3/ze9GbDjXNa9g8ANWr1EILBFG7bCjvKgxbbbaUdIysiF0GSRwYiD2BiwCoVOIzIsHKb+
	 3usdOtCLLeF7XZ7LPX5oNopexSwR+qSKP2Xd66Eu2ZIpDOpZ7SuckQoxh4K4oowUHFpLM
	 KWwhMdySiZJgPkGhAdt6Mpy8u+6FYhQ1km7aFeE+aJJ0E8R6tGVErOp+KnWJ0Y9JuQEpn
	 Hn/KMi3UtO/7F5kNtUFK+d072jkci8FkEIotUIEMAwjWFO9fDFZtV6emGGaLhBBFZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8oF0ChB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B4606A329
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8oF0ChB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3CE1F000C1;
	Thu,  5 Nov 2026 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793842212;
	bh=bNlrPhpQ5XpM4H24b707S71Bb+NZPT5gpAY0vSZArFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j8oF0ChBE5aE9cJVyqM/HwI3exZMFq+L5CbxfmbtrqbhcdMS0fDOsn3HVBQrYjAdz
	 3crtei70GJwULzTAJ99Z2SA4NNxfPINQvrps5psnk0P91g8R3S3RE+4Lh2kera9Oof
	 XSMajh+Or5IyT8qZRpO1t2EGlCPTzXyJGntnp66diFqFhksAv4K4L5Q7oMpmGCFCHE
	 e7B2i8/lEiQIvfaY23Sdv++U2f0Q02BHNo1/KyUfjR4kIHOv1p9suycC5UQTSSdLnu
	 v7KLRxv+LUHCCy5W1WLQkLdNyg2crSRvKHqXo1olxKZ+L9tGHsT7MIR2bxYLQUBu6r
	 xHXnAgQ3QpklA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030C738003F7;
	Thu,  5 Nov 2026 01:30:12 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/9] bpf: Check chains of calls over the call
 graph,
 allow 32 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179384221058.3342012.10154868315037998297.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 01:30:10 +0000
References: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Nov 2026 21:55:14 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> check_max_stack_depth() walks the chains of calls of a prog one by one:
> 
>       main          main -> A -> C -> D
>       /  \          main -> A -> C -> E
>      A    B         main -> B -> C -> D
>       \  /          main -> B -> C -> E
>        C
>       / \
>      D   E
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/9] bpf: Build the call graph of a prog after the main verification pass
    https://git.kernel.org/bpf/bpf-next/c/e4b57476a300
  - [bpf-next,2/9] bpf: Use the call graph to find what runs in a callback
    https://git.kernel.org/bpf/bpf-next/c/904f23207eb1
  - [bpf-next,3/9] bpf: Use the call graph to find what gets to a tail call
    https://git.kernel.org/bpf/bpf-next/c/e7e2abda5f28
  - [bpf-next,4/9] bpf: Use the call graph to find callbacks that take a stack in arena
    https://git.kernel.org/bpf/bpf-next/c/4bf031da4fdb
  - [bpf-next,5/9] bpf: Use the call graph to choose subprogs with a private stack
    https://git.kernel.org/bpf/bpf-next/c/cfede35c4193
  - [bpf-next,6/9] bpf: Use the call graph to compute the depth of chains of calls
    https://git.kernel.org/bpf/bpf-next/c/abbf6b7c6626
  - [bpf-next,7/9] selftests/bpf: Test what follows from the chains of calls
    https://git.kernel.org/bpf/bpf-next/c/b6e223c6435e
  - [bpf-next,8/9] bpf: Bump MAX_CALL_FRAMES to 32
    https://git.kernel.org/bpf/bpf-next/c/1b00d7dcaa03
  - [bpf-next,9/9] selftests/bpf: Test 32 call frames
    https://git.kernel.org/bpf/bpf-next/c/32a1783fd695

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


