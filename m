Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA328455638;
	Sun, 11 Oct 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726016; cv=none; b=Rwj0UozrNwqJWz9oFVBo3OZvIGIHaK9z/R9dccujfHzI+fNPwb2sMm8Clxq/NK+b2LJJd3jf7s30yYUV6c/4+fNwl04DIjMRt/M/bTzErdf6y3M1O0u4BWqtkeEvOgJjIxyqUt8hmv6NtMwXd2MwRckTfkHaNbCMMP7nvpjABUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726016; c=relaxed/simple;
	bh=S/3xpUmwsSUqah+Ty1+8K/MMPxm/63nclZvVfZxSghA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jf34d3sjsdCDFey2H+gbi4+kJSC1WMBM7oo4ZtyhVEUlF7fkusksN71CxrQCHNFYXimECOemoFfWKvx1DEmSnTq0kfPbD8vamyw9mUiUQB4KEAtqIBu6+O5zWEzIm0bA/rbnnzVHJgkLC4SQpnKmjCE0hXIBqhe1h6Cxeg7rD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZxffYvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZxffYvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766A1F0089D;
	Sun, 11 Oct 2026 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791726013;
	bh=Z+Ap3ydhCu4AooYx/51dx3+KSpMeHG8siG63oRlEFx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KZxffYvPeCalj/zsKFjYmNRiW7AvA3JUlBag1iNWnHoMQxX7Xhp1dg4zkfTrUmNbE
	 WMJsScCmDtlLvQ1YZ6c6G3eA0oIOsYPy4AykqjqLQlHZ0kMIQxpZJM/1rs1XothFYe
	 WPehT7puO99jOO+vJRfu1YClzxJuvyvHR/fFJ05AD4kTHQ6WaejRs259KRuUWlVQ4g
	 wGSgMpJfdptkwLBj5TMmhzHUt6DqB+n9EuDWVOo/uAnQj/1M2o1O2vsE3yjvHsCjgY
	 1FUHxC0pqTsCeG24/CjoaA4rLIGtGQuj8nz0geYIdAKU+uGj8E4K3s72w1eGFTD6VX
	 8nmQEqjrXDErg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F145B3811966;
	Sun, 11 Oct 2026 13:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] bpf,
 riscv: Add support for indirect jumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179172601151.2055679.7493510397466756418.git-patchwork-notify@kernel.org>
Date: Sun, 11 Oct 2026 13:40:11 +0000
References: <20260928071845.2432-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260928071845.2432-1-cp0613@linux.alibaba.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bjorn@kernel.org, puranjay@kernel.org, ihor.solodrai@linux.dev,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 pulehui@huawei.com, pjw@kernel.org, palmer@dabbelt.com, shuah@kernel.org,
 guoren@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 28 Sep 2026 15:18:41 +0800 you wrote:
> The indirect jump instruction (BPF_JMP | BPF_JA | BPF_X, "gotox") and the
> BPF_MAP_TYPE_INSN_ARRAY jump tables it consumes are core features: the
> verifier accepts them on every architecture, and the x86-64, arm64 and
> powerpc JITs implement them. On riscv64 a program using gotox passes
> verification and then fails to load, because the JIT does not know the
> opcode and CONFIG_BPF_JIT_ALWAYS_ON leaves no interpreter to fall back
> onto.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf, riscv: Add support for indirect jumps
    https://git.kernel.org/bpf/bpf-next/c/c0316386fecd
  - [bpf-next,v3,2/4] selftests/bpf: Enable gotox tests for riscv64
    https://git.kernel.org/bpf/bpf-next/c/5f750ad6d675
  - [bpf-next,v3,3/4] selftests/bpf: Enable gotox liveness test for riscv64
    https://git.kernel.org/bpf/bpf-next/c/6ce75af4f59e
  - [bpf-next,v3,4/4] selftests/bpf: Enable instruction array test for riscv64
    https://git.kernel.org/bpf/bpf-next/c/eec2444d9b9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


