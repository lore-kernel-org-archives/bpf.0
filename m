Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10899257825
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124438; cv=none; b=MULYdRh2k+GXhaVfYYmQ1gtbk+bcVwz+TIsU1fPa81w4l54VvUqWtDK2lYE4oISqcwruWIBTvHuuRbvQPDbryTdMJhGXAq5GKp/lRAoLnS8lDPodxSVr4kYciYv5wn5OltTcwTFnhMVLtVLxRf3brVRElpw7QtY7f2PgE8AcyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124438; c=relaxed/simple;
	bh=levmuqAZAvY3CSjfNP1GgsPdASqdxsNzSWmLiMNsoBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LLls8c9O2PVceHYb/DEvbipG9DAcpoLXWzQDAcDiFBIkMSJ8tRTxnqxMATT77Y4HQ3dGTmgplu+tkGcJsBvsTlgGUrGG4M/xwn+ApRD6xiJ6s5vlMrDeu8bZczwri7emJkvlfCfaPH9Z/2poISa8Tkob54ZPF9GlXG45povaSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSqDQl+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSqDQl+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE52BC19421;
	Sat, 21 Mar 2026 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124437;
	bh=levmuqAZAvY3CSjfNP1GgsPdASqdxsNzSWmLiMNsoBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mSqDQl+NgZOS+KQMMTuT5em5Bma5cruMKZkS2bsiX71JBiCUq3grKor2cleUu7WiO
	 fUa4pob8tEeHxWrAJjGYB37oGB1deoEqBvG6NOSjBDoVonj7Ft/rqQ21wIF6v7nvRy
	 Z4aYB+zB0NDuwS3EqUqxATrLStcHw9mOcXIreAcziIzEJ2bWqSxemobdrENm1l5SG5
	 OwZTxUldOSoJMEMEjWpuoOdzkcsogUOuBT+xaK82FfND81jT15N6fKmJiQ5+Lc/9Ns
	 2u9dlxGALOcYYZATe8F1uSwkjWxDwwkEliEQDXIlIX9CdYYV8Pe8ZRKCTULdwOkzOb
	 uwUh9NKZ2g6FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEEB3808200;
	Sat, 21 Mar 2026 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpf: Consolidate sleepable context checks in
 verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177412442703.2951219.5720198596539931772.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 20:20:27 +0000
References: <20260318174327.3151925-1-puranjay@kernel.org>
In-Reply-To: <20260318174327.3151925-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Mar 2026 10:43:23 -0700 you wrote:
> The BPF verifier has multiple call-checking functions that independently
> validate whether sleepable operations are permitted in the current
> context. Each function open-codes its own checks against active_rcu_locks,
> active_preempt_locks, active_irq_id, and in_sleepable, duplicating the
> logic already provided by in_sleepable_context().
> 
> This series consolidates these scattered checks into calls to
> in_sleepable_context() across check_helper_call(), check_kfunc_call(),
> and check_func_call(), reducing code duplication and making the error
> reporting consistent. No functional change.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Consolidate sleepable checks in check_helper_call()
    https://git.kernel.org/bpf/bpf-next/c/a0d06cf102e4
  - [bpf-next,2/3] bpf: Consolidate sleepable checks in check_kfunc_call()
    https://git.kernel.org/bpf/bpf-next/c/cd9840c413e3
  - [bpf-next,3/3] bpf: Consolidate sleepable checks in check_func_call()
    https://git.kernel.org/bpf/bpf-next/c/a2542a91aafd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


