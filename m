Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530021;
	b=dNjiy1stwckrovkr4bcHZQ6CMMZCrw7k3ZGCUPrSXXs5ndzgIuKI579enT3SBa5pmVii
	 OiTdH8zEfeCrJyuBsoFCm+2fLh2H89vkFKammGb82SZ2soUIaDKgY1oOL/PE2PIna3Lmg
	 3MrhYiEx3sKUB+LEI/vQyEOioo3sGPXYqLfBTSzc/ruwUuf0okhc+udZdfyaZ9F0Fhsvp
	 x4VzH6CpX8vmDowr3z3xEvrPuizOBSQG7J+n7Yb7E3syCJ/2059sqTmvKUsdEicLzXD+C
	 FA72fcKTavhr1mj6Gs83nNCxNRIo71iMJqHwoX1AliJxY8R+kkMhpN4eZdINGws4xdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530021;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rXhJ4L/NzZHRNleuPwZVcwoS29a45TpivMkwEHBOWew=;
	b=Pr16G6nUUtsaU2aphu+Iam/nTkAt2f9Bzi9OWmrEZ6Gl40DX+4q9x43cgLmR2f/7ATmw
	 h7ggd5kyHEMm0jdnMgAF51yoFzOPb7ndpTgYb/zsk8VODb2BE1RbsRvnujG5u0qGZFlUD
	 T0g4zXykBfPhj4xVQ4zrRn3snZQJyBmS6mTtnHP3TMsLcyTKfVlvGpd5qcGMf7ILgRAYq
	 hEMq6JpElkRuRA4RuCTM94QG4Q5pb/LcJO4+9wpsRS3MZWYxrGLIkSVb1TVNXQRxg/49T
	 rHeuMTXNgTjuweRYvXYFjyqy/T+KK+Hx1PCzZzMAiYkMzOMMPfwbwkocjIV7ikLFCPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTmDRsy3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B79606A326;
	Tue, 20 Oct 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTmDRsy3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C791F000C9;
	Tue, 20 Oct 2026 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530020;
	bh=rXhJ4L/NzZHRNleuPwZVcwoS29a45TpivMkwEHBOWew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MTmDRsy3nLBQ0PhKm6Gb0dU33W8UFBz7XMBQN21MCWcbcn62H6RMM4ALcD7PujBR2
	 2hZODVAK2ICJeo8rw54l1P80smzfFiYoy0JAkwuyvKBsrRE6ZPPz/Je5ct62o1fw2x
	 sGkpw9CUbCSqQJ51JxYRMywQv2e13LQ6dNAIWGq0OYdnR+jvx3mB8p4IjWu7lcycif
	 2SmlkwP4RMnQ73tzKepKaAPBmRZSDuu0Hb2JGAPXVUcy9crBnwzZPaRsEvK+buBcDd
	 nf5RgO2xJhpd1VhgLGjzkV+pKWT1i+pu60aAEs4vcgiMNpG9K0a0CAZLy7UqRvN/+R
	 FoRNQQ7Oal5zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A44E3809A09;
	Tue, 20 Oct 2026 21:00:20 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Add syscall common attrs support for
 xdp
 link_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253001886.208021.6536312952037292688.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:00:18 +0000
References: <20261020152804.39863-1-leon.hwang@linux.dev>
In-Reply-To: <20261020152804.39863-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org, kuniyu@google.com,
 liuhangbin@gmail.com, mkarsten@uwaterloo.ca, masashi.honma@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Oct 2026 23:27:58 +0800 you wrote:
> I'm planning to add syscall common attrs support for LINK_CREATE cmd.
> 
> This is the first series for the plan, that adds syscall common attrs
> support for xdp LINK_CREATE.
> 
> Thereafter, retire the tracepoint bpf_xdp_link_attach_failed, because
> the underlying driver's error can be back-propagated to user space via
> the syscall common attrs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] bpf: Add syscall common attrs support for link_create
    https://git.kernel.org/bpf/bpf-next/c/c8e3a753a9ee
  - [bpf-next,v3,2/6] bpf: Add syscall common attrs support for xdp link_create
    https://git.kernel.org/bpf/bpf-next/c/d80d00835520
  - [bpf-next,v3,3/6] bpf: Retire tracepoint bpf_xdp_link_attach_failed
    https://git.kernel.org/bpf/bpf-next/c/278568acb588
  - [bpf-next,v3,4/6] libbpf: Factor out __sys_bpf_fd helper
    https://git.kernel.org/bpf/bpf-next/c/deb9732f53da
  - [bpf-next,v3,5/6] libbpf: Add bpf_link_create_log API
    https://git.kernel.org/bpf/bpf-next/c/1480f290d1f7
  - [bpf-next,v3,6/6] selftests/bpf: Add tests to verify link_create logs
    https://git.kernel.org/bpf/bpf-next/c/f23fa8f01ce3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


