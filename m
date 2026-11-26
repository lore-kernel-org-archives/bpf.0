Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726810;
	b=k/DaoAJWKY0SjXjkhq9JOXV9nAlyInLfU89kvK2i6TpCg7QgKO4vP8au4yERNCgavGzx
	 qYy7P+WbQte0g7U+InBUiQBaUJ6ZW5AafexC/GNx6V38YcWQJCEOYI+UjmBPzlsJdgnry
	 SU4dFZBmtA7fAhxymK8huvmEOgVuT0VVY93Qnp0A8+GH300mgugU5AhM8YicayWsscp0b
	 U9VH74dWoaEYWPD9Qi6Z7gmb7e7v+miwsZmysAD4g6WkVMQ0+t+Bae/mjagW7WujL7ppY
	 RNNaWh0xEnuNA2MOxK9oc6u1arO16ileXypoaJwWLLi0WIaN7H6f5dXf4l5PmcCbB+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=L2EUDWrGprysBtTQg6JNgt9Au2GThQvZuOs0KqhjIOc=;
	b=LYIqHWFPzu6XF9pjsiuql3pJcesU5Ptma0Bj+8y98EkkJqFwCx3Mf+tsmWkWTU7Us90x
	 2F0TsYflr/2pVwzM/3RKAgCRL+YhE0BvbU2vv60CTTjjrkbRdedZ7T4np6GTZhWhm2V1Z
	 axu96DeU0x8GwRyZbl81vFbGqZ/VjCTg3dGGQh2m6XeLuw2R5vuL7/M5MJgYQjdyXUi9d
	 kLMMeik8+Of3PC+ddbzvI+sIJQCqVtFJe083cmwMYzN2zYeqOZbX40ketNAt53iiPo5LX
	 k8ESQiOmmRTwCLDX99HPMExYPGEX0GkESx8+ND8aMYIAn4kGHxY4fvdoUHu6TsBxXxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acxnUDQv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B226606A323;
	Thu, 26 Nov 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acxnUDQv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72D31F000C1;
	Thu, 26 Nov 2026 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795726809;
	bh=L2EUDWrGprysBtTQg6JNgt9Au2GThQvZuOs0KqhjIOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=acxnUDQvYX7IUP6aztJayBqdQ+yBjo1O220TVMSoV6okvGms61PVW0Ga6u/m0JMeD
	 oqgKZTFgaaKrbkPHwGYXZGf+Pl2nBeD7HwKwwl7Nnzz9tE5+JU5FahrMfbCmHBPnkT
	 JDL1xZUwUJIR+myWD2TH/0QPZu8pbD4Js6KAyqZutBrfhW1BVmwcnf3lJNL5Xz/lz7
	 FVrIcn2XWXAeBNpS3ZD1E+S7wUj8KbSQcOLFxAGABistMtV4Ay0Gm5usIC2a/WS7xU
	 Zpc4Zm0sJNDsxeruF1D1Jq1AM6F+n44Y3F2cxFPdMhCDKx0pjdgPKL6yd8sgtiS7tP
	 mVLSxW+i0Ahbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE82F3803326;
	Thu, 26 Nov 2026 21:00:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v4 0/6] bpf: Add log support for tracing
 link_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572680824.617567.1633909900114303634.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 21:00:08 +0000
References: <20261125143138.47174-1-leon.hwang@linux.dev>
In-Reply-To: <20261125143138.47174-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, kpsingh@kernel.org, matt@bobrowski.net,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Nov 2026 22:31:32 +0800 you wrote:
> I'm planning to add syscall common attrs support for LINK_CREATE cmd.
> 
> This is the second series for the plan, that adds syscall common attrs
> support for LINK_CREATE of tracing prog and cgroup prog.
> 
> BTW, address Andrii's review [1] in patch 5:
> 1. Change if (!OPTS_ZEROED(opts, iter_info_len)) to if
>    (!OPTS_ZEROED(opts, log_opts)).
> 2. Add comment to iter_info and iter_info_len that they are
>    deprecated, and use iter.info and iter.len instead.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/6] bpf: Add log support for tracing link_create
    https://git.kernel.org/bpf/bpf-next/c/be52e74c3df1
  - [bpf-next,v4,2/6] bpf: Add log support for tracing_multi link_create
    https://git.kernel.org/bpf/bpf-next/c/3e5de7a1a5a8
  - [bpf-next,v4,3/6] bpf: Add log support for iter link_create
    https://git.kernel.org/bpf/bpf-next/c/892d17776b75
  - [bpf-next,v4,4/6] bpf: Add log support for cgroup prog link_create
    https://git.kernel.org/bpf/bpf-next/c/554864149321
  - [bpf-next,v4,5/6] libbpf: Add log_opts support for BPF_TRACE_ITER
    https://git.kernel.org/bpf/bpf-next/c/72fb27b0551d
  - [bpf-next,v4,6/6] selftests/bpf: Test tracing and cgroup link creation logs
    https://git.kernel.org/bpf/bpf-next/c/42fe7db4d6b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


