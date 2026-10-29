Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291409;
	b=Vy3TAmseMnY3GhUkcDgXqUsIBMjoepTvRnsJM+5Aer1jtZIdKxVD3MxGbWv1JJ2Lv31O
	 7XXNFHlAzv5ogJbL3LhKWdpMezfMn8Idq2oyl4aGo5gLBAhEa55ABFQUEmB3ksYzM/+ei
	 O7hwmW4njCvN8ul7/tgSIjaCip3RphQJjxjaW2cSyjPvvoPRZIr7zFBUMoUuoDTQw2h1J
	 hLiPvPws5HcFFIahj+ZJtT8POElLMvmgtbLjbNj7XiYmGE8iNuRwznMZTeyZXXNvdxduB
	 jYRK6A6FR39HywdIGcJrdIWrB8aszIepQAa/pCqH2WxZJMvN+3UT6CJ2GdEWkt/Ghmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9sdoxOsij3ml0E4hBz0Uk1W+O3KE/Jevu63peRDA6+g=;
	b=nibnCAR6UztfyS6rKyDcyVp89ARhbh3Ig9XmAycy79mk0X4WTEptqCDpdXCzBkN0K94h
	 EJaSimUo1OjZKqPBDE5HGtHGLnzWBg5M1OgZNHq3h4+jUSlSwCeWqAdF29dfLeMOjs67j
	 P93HQzlEBZFbP/ajVQcnzkZBLEdLOLRfPS+rgjs7Aku+NoDTYfuC+1s+eVD9mjLF7gyEd
	 3sBBKXyonVDZ5wG1UWReaFGK9Nd/1aypv97Fa7J9rAGjJ2+Jlrg/4e+lGoamGxBZPEHXb
	 eVftrbIq2nDPhW+if/cQp7MbRz32uwWGXTJLDGjMEohYHAKV1IXQuovOMRu72NUOU4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuYpXVpz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3F606A320;
	Thu, 29 Oct 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuYpXVpz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63D21F01816;
	Thu, 29 Oct 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291407;
	bh=9sdoxOsij3ml0E4hBz0Uk1W+O3KE/Jevu63peRDA6+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LuYpXVpzcgZf5I4egFlI4i+W1uV5kDaqKb6zxyn667htazDz/UY5voP6+zzEpXm80
	 ioWwC0HW+4d/gANJuXS4MTqacHCbrVpK4gMBKRJdj+XgtgjC+Mx/+CO5DeCaVYL/J1
	 Cf4iWG8Fd0kJDrHQrsfQ17eNGej57KeXNRkpKsVYksC98LjBXhLPUIPSqFEbcPjwp1
	 SQPUBku2b8m6YljgP62sQ7XYU2ijiMmgXifT2DwJbYSusl6tjT35PPSv9RnOr+81tJ
	 lxRDpXr7kcht53KRFVmgOLFvu3AwOqQHK9LfqfzdQW1d5kRmrEZ7lMXfXK8fY0PeUy
	 GLpEJSB1STrjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3963808223;
	Thu, 29 Oct 2026 16:30:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v5 0/6] bpf: Add syscall common attrs support for
 xdp
 link_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329140655.559085.2587539582409074788.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:30:06 +0000
References: <20261026154948.99408-1-leon.hwang@linux.dev>
In-Reply-To: <20261026154948.99408-1-leon.hwang@linux.dev>
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 26 Oct 2026 23:49:41 +0800 you wrote:
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
  - [bpf-next,v5,1/6] bpf: Add syscall common attrs support for link_create
    https://git.kernel.org/bpf/bpf-next/c/b891bce3fe4d
  - [bpf-next,v5,2/6] bpf: Add syscall common attrs support for xdp link_create
    https://git.kernel.org/bpf/bpf-next/c/cbb143cc97b6
  - [bpf-next,v5,3/6] bpf: Retire tracepoint bpf_xdp_link_attach_failed
    https://git.kernel.org/bpf/bpf-next/c/d33d3ec8f730
  - [bpf-next,v5,4/6] libbpf: Factor out __sys_bpf_fd helper
    https://git.kernel.org/bpf/bpf-next/c/d6ef68efcece
  - [bpf-next,v5,5/6] libbpf: Add log_opts support for bpf_link_create
    https://git.kernel.org/bpf/bpf-next/c/0be729f9f030
  - [bpf-next,v5,6/6] selftests/bpf: Add tests to verify link_create logs
    https://git.kernel.org/bpf/bpf-next/c/a1a714b7e947

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


