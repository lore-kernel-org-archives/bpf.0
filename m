Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE33B8BB6;
	Fri, 24 Jul 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925647; cv=none; b=ZbFGTGiCZTc7Nd4aBgrTzUsQWfZ/YtZYFkcj/M49xehoHBddhwFcwqKcZtmEQU2UZ53fu87TrMycc3PKztRbuoI7aPkYmflRZAdSgpMPqgu2GGwT1xKfLDxyEewhLlgYBm4KMqlbEhQG3ABfQCN5z8T1PuC6trtDCT2XHhbLtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925647; c=relaxed/simple;
	bh=1yqdcP8irVIpontgjI0/lYzda+a6mGEgjN12M0XDoDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jJiZvs0ab3G330pOE47r+WMIh1KuW6cRpIXsS3mG6RUHL+qbZb1dBvW+u6mylkW2bZCM5a8UStCdptpF/47mhzaZHpYC5xe9jEZxt0MeJC6Tx23RyxCmVGONzNlsMqHh5bIP2iGm+g0xb5wQWHjECAW4KBK1YaCgzP3wLswl71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU0826zg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU0826zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3B41F000E9;
	Fri, 24 Jul 2026 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784925646;
	bh=PgdTP64+EVmHRzWKXnz5UKUEwhJNxUbT1LrMWFDT2MA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OU0826zgWCqvHhhLxBuOQQpNsmpvdlx6ExQbCRUT2AgArn0lM6KvY+yOSagxCnL3/
	 K1uFtP2ot8+CsAvF0muymCuWDPcV1X1EUhvdxYLQy7HoYIvW/WXaQ3cr6dnmM1LlJA
	 Eonkx+qrDAI/jsx2HSkWtFJmFOgfDWBE/GoC7TQmvCkezyPCs1/46dCJX5mK6s3dEd
	 nI/Xnxr3yHeq16L2DpzrkAIRONyUlyWZLeVEfzLr7nSLhTRO2jGFq7n6rjKEgCpwbJ
	 RHrnt9rSORmyouEXvzIy0JmjQHsJ6TaP2VcpakwD0HMaxPOskVJqanCDlaRyL7gCkt
	 A2S1RcTWn6o/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CBE38111D2;
	Fri, 24 Jul 2026 20:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf, riscv: add timed may_goto support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178492561340.3300548.13038272960987116593.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 20:40:13 +0000
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, shuah@kernel.org,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 23 Jul 2026 05:41:31 +0000 you wrote:
> This series adds RISC-V JIT support for the timed may_goto loop bound.
> 
> Patch 1 implements arch_bpf_timed_may_goto() and enables
> bpf_jit_supports_timed_may_goto() so the verifier uses the timed
> expansion path.
> 
> Patch 2 adds a test that checks R0-R5 are preserved across
> arch_bpf_timed_may_goto() calls.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf, riscv: add support for timed may_goto
    https://git.kernel.org/bpf/bpf-next/c/6ef8ff20c30b
  - [bpf-next,v5,2/3] selftests/bpf: test timed may_goto preserves R0-R5
    https://git.kernel.org/bpf/bpf-next/c/a0032241aa14
  - [bpf-next,v5,3/3] selftests/bpf: enable timed may_goto tests for riscv64
    https://git.kernel.org/bpf/bpf-next/c/3c2be3cbeb1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


