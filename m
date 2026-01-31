Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C412388869;
	Sat, 31 Jan 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769896826; cv=none; b=D+QgWbzozKSzHNNcMXPXvyC0t+F45HH20aLLJM/QPfytxtEsO0CsZuC3/zOp1siY5wYJGT1h4X1DQS2+3gjrD9BZRVIeUySsLIlavZmrAdysQ8y1SssRtof4ZPiCcLQPD2TzlocynknGDDOllBA7zz02vk4XColhGj6cdzHIPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769896826; c=relaxed/simple;
	bh=SsSdTYBHd+jwsoK1gaPAcocIsd+yEdLGgFoksyOasTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hj4G5OhHVRHqybk4F9g3cpJB8g5JH3aWohvG90EV7NjFvB2ZBpQIDXbNHbrYmAUFsJaW1ggW+Ot5GvBBuOTJ7k83AGUVZ3FGESNknGqkubHE9J14v6KBYD/dx5qkBDqx/T8SZwR4nxk3C6JAP1fsAQp1xRky2+qGAaAOuAl6OcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrnRAseY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrnRAseY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876D9C4CEF1;
	Sat, 31 Jan 2026 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769896825;
	bh=SsSdTYBHd+jwsoK1gaPAcocIsd+yEdLGgFoksyOasTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IrnRAseYFrKTrSpL9AbMy3DAZ7SEucyXeAp8LvoMP8KHky91dOoCOxQyDwRcTDbIT
	 ZSifazYl6nDpj8HKrgIyu9VQ+K+tuda5WS8lTjy57vg72ZC6iF8kru6uz3kbkwrcog
	 ffpuTWX00JHodStlWZq4jFWNXTJZ7cg/7DHZuIh+4fVVO8R+H4s1PxX7yYsqWKIZt1
	 RTPSgbaXCRH/QwmRQneo4QoHXae5TGNSmS9QYW0npev8KTvVJudcrubyCN2qvzmd4y
	 2piPvy0io/nmhkMJyldaAZxcrXLFGXtpfnHvsvl25gfpAnTLN4is9MvZpGPSZLAftY
	 81u8sigR2BrDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD61380DBD4;
	Sat, 31 Jan 2026 22:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf, arm64: Add fsession support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176989681714.6968.8564830272874377531.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 22:00:17 +0000
References: <20260131144950.16294-1-leon.hwang@linux.dev>
In-Reply-To: <20260131144950.16294-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, menglong8.dong@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 31 Jan 2026 22:49:47 +0800 you wrote:
> Similar to commit 98770bd4e6df ("bpf,x86: add fsession support for x86_64"),
> add fsession support on arm64.
> 
> Patch #1 adds bpf_jit_supports_fsession() to prevent fsession loading
> on architectures that do not implement fsession support.
> 
> Patch #2 implements fsession support in the arm64 BPF JIT trampoline.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf: Add bpf_jit_supports_fsession()
    https://git.kernel.org/bpf/bpf-next/c/8798902f2b8b
  - [bpf-next,v5,2/3] bpf, arm64: Add fsession support
    https://git.kernel.org/bpf/bpf-next/c/e3aa56b3ac17
  - [bpf-next,v5,3/3] selftests/bpf: Enable get_func_args and get_func_ip tests on arm64
    https://git.kernel.org/bpf/bpf-next/c/7f10da2133b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


