Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081008;
	b=gX18SgN44Dd/fHfOnqm94NylnSQonmNovdptGr2rwO2AA2v/yRqGdg3PVa53Gm68Z1Cp
	 G2lcJZTFnCx7lFthYF9w7ZRNiXuow8mlIv7i3jNCT8PTym/3rjGcEzG9sC+6cNnKcMsVR
	 YeWv3bphEzTGzSt3QC1QmxQiUTm/vFSHJxqfDwUvv2A57yxytbxaYVV9CBFgCnRwfFPcH
	 dM3nPEUPT+9WgNyJd0w2KK+ooJt9DHcOO2CeIk9Ehng5MAZgzWMzCLWEZWO5vx+0fkb+L
	 r7d4sBwFEYcgYPUV3jIjEIYuROMgtg1yTr0Ucja2TgOSusJSEIrzJPq2ca+eu4ca+4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZxU/4YrfrHTeWGJqbvJeThiC9nQU3SQCFCWIfOT95gM=;
	b=pM8j/1/G6aA9RG/ptB6FGYwyHHitGCUHI49IX/d7zJeJVjVhYYQX0aongUvl+IVLT0jT
	 XF5YRebc2lHHm8tQAY9P4FIQ7H4qpkCwBoET9Va+RdJ2Xd2kdfJPQmKr0TBakJ+50gRLn
	 Bd7x32PIDqkNOVzw2f0qYBfs20as+Jcnk1SPaeRvgnfibM36OeeBJubUeXufK1EFKBmj0
	 EuYi+l1pSOFLRXkldSGzMY9zscqqiNYzgrrL8TpzP2J0t+qvOkieMxUY+BFj4LwQ6Ssoh
	 kcIPKi0hGqtHgH2XHJBFTYRqXZQN+c6v8UtyAjB+Th52P0PCWp0dJbzaeaA2LcfyROw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O0YCX/wn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3627606A33B
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0YCX/wn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3D71F0089F;
	Sat,  7 Nov 2026 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081007;
	bh=ZxU/4YrfrHTeWGJqbvJeThiC9nQU3SQCFCWIfOT95gM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O0YCX/wnYBMCMQMdUiwrCuWupDatQ+WPGVVavw4RZ8Xt9ieabL1cdpqgke+jFXB2O
	 caBpQ93PrjoZgKU28dak2RyyaarUP/WxquNkj1QbcZNYZTcEJ31sTQuEPMjzdck1fl
	 zNIhwy3DB+vPQbdpG2yLFr26CJJIjIvcNhUC7FvO6qlI8LZSyc836YTBQDPK9RCLLg
	 0Llej37IQGGEIDaXns7J7EHkp/Hqd37BXPwSQaDDC7rd5MWr8oyrYCRI8rnzKgqFv3
	 +T3WfQSuGNtL2kOW2XPRMkYEzdReshkqHq2hFaS9OoRGdKs2KmcSbQky4TKDsdIbDY
	 /6i8d6u41MydQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E013380821F;
	Sat,  7 Nov 2026 19:50:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 1/2] bpf: Walk a short loop for what it loads if
 something looks at it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179408100592.1307894.1595889978869890203.git-patchwork-notify@kernel.org>
Date: Sat, 07 Nov 2026 19:50:05 +0000
References: <20261107175819.3707050-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261107175819.3707050-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  7 Nov 2026 17:58:18 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
>   for (i = 0; i < 64; i++) {
>           if (have)
>                   sum += t->pid;
>           t = v->task;                  /* __kptr: a task or NULL */
>           have = t && t->prio > 100;
>   }
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Walk a short loop for what it loads if something looks at it
    https://git.kernel.org/bpf/bpf-next/c/3fba1a6cf43a
  - [bpf-next,2/2] selftests/bpf: Test short loops that carry what they load
    https://git.kernel.org/bpf/bpf-next/c/1f56fd122f47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


