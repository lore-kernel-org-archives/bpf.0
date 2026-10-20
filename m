Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530019;
	b=qEcDJtyFj4h3kYfwhWgQGl34Q8Gtlw11P0T1ixwbDBDJ8UHOkrzs32kQzUrhc+nbs9ci
	 O+4dQ5Awve32kzmhEb1nXXGc7haQFPdcqiDod7jSpS3/GkbldZkHNVUUh+VMv/FgbjpxF
	 toFf6fV2aOaY3ypTYok3l3+ob2LFInChh2NK+vVsq3eATzT4VCQhoTwEe0Py7vCk5Rxwl
	 wnxXNpgrsDt1CTi7OAHYoHvYlCBXnQNCYvKte+/aEN236uAOox+HwxBbU9jUhxdBvtkvo
	 EEjhemc933J3W4wTSOes3oBMwEJfIx+Dfkg3PO/GqepwivH5XSYuFBWu8YM370Qd//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530019;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ify1310mMZ8uuE2erBzyqDtt89S2qx6Bc+9pzUyVrWA=;
	b=ahD7aJps+ZQIGaOh9W7WHlNNN9pjYBqxImAN/YZk2pkmjncLYcn61IwE0NqHu4NQYjLP
	 dfkz2YfeJ49K2DRAwWjmbnS17WSveccll0KSdJT0VTeqNLGb01j0iUaIU65ODBKDzuVlP
	 M+1fCtxvmm+kjgSLpPkC1T5kbRDhKhp6mc5RyBU0cil9DUGpTsYU9oVcrRmiVbv70OSur
	 t07eB5gxact+wl69bx3zGxS8FfAwGV1n9TWXbBCiAyRCQ2VHQQPbXyLTxL2yDkwerifa5
	 qO7WUBRyf9S3NyMwjEBwbOCAzMVx2RoeGsBHNda9wOhpAUAeNKamg2afG3IshDyqMpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ow3DmNm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E3606A327
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ow3DmNm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE521F000CF;
	Tue, 20 Oct 2026 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530018;
	bh=ify1310mMZ8uuE2erBzyqDtt89S2qx6Bc+9pzUyVrWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ow3DmNm09IB6FZRGQEaKuJcm7FywyOdtKh6vJb7bKgX5+Le9FCHoLBnyT5hCHfEdB
	 guHto8SBAHy71UyQr4hsAnTLe+vSRnSmfeaFyNMkeEG+f4WuXDv33UFQuJjR6w+dtF
	 8vktV5bjot7XLqlq8HKfbVb0CDYlOid1ccf6I0Gd6+wQuzhcIbj5ceIq8th9zj0KBg
	 4d3LdjBuJfwJgqQIuo7tbQvmiOma2aMrQjBqFsp0foJHQf70S5cyEF8LmLtqCVvbN8
	 vKzchimKLk0+DieNHzjqB0ioMyst2c3TCFBbF9bPbp/zOfDBPRCpy2ud41LO/4pfc0
	 by1olCgEe9UjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44553809A09;
	Tue, 20 Oct 2026 21:00:18 +0000 (UTC)
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
Subject: Re: [PATCH v4 bpf-next 0/6] bpf: Unwinding with unwind_goto and
 unwind_exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253001727.208021.10742384907000809104.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:00:17 +0000
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Oct 2026 18:13:14 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> 1. What is the problem?
> 
> A rust panic or a C++ exception has to run Drop impls or destructors of
> every frame it passes through. bpf_throw() discards the frames, so the
> verifier doesn't let a frame that owns a lock or a reference throw. In rust
> every index and every unwrap() can panic.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/6] bpf: Add unwind_goto and unwind_exit insns
    https://git.kernel.org/bpf/bpf-next/c/a2d274771321
  - [v4,bpf-next,2/6] bpf, x86: Support unwind_goto and unwind_exit
    https://git.kernel.org/bpf/bpf-next/c/cff94a3d78d8
  - [v4,bpf-next,3/6] bpf, arm64: Support unwind_goto and unwind_exit
    https://git.kernel.org/bpf/bpf-next/c/fc85015a5e86
  - [v4,bpf-next,4/6] selftests/bpf: Add tests for unwind_goto and unwind_exit
    https://git.kernel.org/bpf/bpf-next/c/86cec0897108
  - [v4,bpf-next,5/6] selftests/bpf: Add a C++ prog with exceptions
    https://git.kernel.org/bpf/bpf-next/c/0935acd1a8a7
  - [v4,bpf-next,6/6] selftests/bpf: Test unwinding from R0:R2 subprog
    https://git.kernel.org/bpf/bpf-next/c/55c34496ee99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


