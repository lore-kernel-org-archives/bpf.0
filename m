Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400006;
	b=12PJjrvY1erWbafxF5+Pku3ZNuw2EgsTxc3K7NPGNvcL28qqvVDURpYspOYsV1N/8Y2F
	 vWw9Ww/530CtDJwSqLmhlajuRpwEshXovTjpf5s/X56ZNf5MrGZ6IkFul74lkGMvdnEpv
	 sFW+20GjwVFfGPnSx6pj9gUnOP3/Tho4BcbrHPlL8MYuyYnrwcfUY4NLXPWkUBUJedeB+
	 t38ObNP1K/bCPbrOEGotko3m4dK+EJ5UBD+ueUqZ6bpSI7raXO6SLEVX0B9Ytln6dmPvM
	 WJCh9/jcDiAovO6XwYzhvUlf4zF929coDoEMa7EbjC7nP36+7e7hmHi1b/+uUxB+oQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2917MQdWb7ZVHpTWRczogd/OU9+rUmeFfqqry+6Zqyo=;
	b=FgMW3KERbQzxJIrTzrBoNV3lstI0DLTD+vKVSiK4OCqKtBuogcgynpFJumalmWRjabtG
	 rQFLQ4ZCmPNpHvu/PhpGMK4CLNtKTf5rHmZ8AA71t7OhikYmJFCrHvD3QxvrRc9jhyWDD
	 xZdBlWQtNPDgVL0MUIHgFvr9Blg0aSh+O/onAiUuv4j3KzS/+aejYtdoXO9ytb/8wKOlN
	 wkzPv9KfOHN54PwCLYXQGQVZBN1TOt+EmGU5e2m27LSrUTqUh42DcP4bQ6AR+t6lGQaSZ
	 qSy4DNO08EFiu/eIQivrgOV8cJda/OnTPjakMA6oMT8fWM34H123ZxcAIffHcHO5/AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwxVVD1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA78606A320
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwxVVD1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9AD1F0093A;
	Fri, 30 Oct 2026 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400006;
	bh=2917MQdWb7ZVHpTWRczogd/OU9+rUmeFfqqry+6Zqyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iwxVVD1Q/0iBldy8Uu/fvZBSMdCiwsmukz77TD2Ay38LAdQE82l176kbsE14JX7vh
	 2U9gsMwZ9I0CsTcwn62BeQcfM6uLW+0OjxOEAf32Go4adVVQSWr/mpjiyGrf1IY4yz
	 QlsXm8ytfkY20abc95td3hLaocfJAmnMj5MsXVRRVa5LIrWw6RwdDgS6UnVdVG5x2X
	 n7Laeq215g8SzEbPmLaaiPONtoJI4xEcN8U8+9flnMNaBHfuLYMpF7Pzzt3kWW6nby
	 V4K5QA73n7C6xnAHCEuTYP1eiI5rt9A7sotV+dUG6aeylTfc+SDvyNKz/lO7UwHTSg
	 j1rn6RMItGs8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400B93800478;
	Fri, 30 Oct 2026 22:40:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Cap the CPUs taking part in
 the
 rqspinlock stress test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179340000506.1810026.1894626929998366923.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 22:40:05 +0000
References: 
 <7fb2cf7baeb262c7486b8e9b5204e2a159402608.1793394762.git.memxor@gmail.com>
In-Reply-To: 
 <7fb2cf7baeb262c7486b8e9b5204e2a159402608.1793394762.git.memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Oct 2026 22:14:54 +0100 you wrote:
> The stress test module starts a worker on every online CPU, and each one
> holds its lock for 20ms with interrupts disabled before releasing it and
> queueing again at once. A waiter that is not at the head of the queue has
> no timeout, so the queue holds every worker but the holder, and the last
> one in line waits for all of them: the longest wait, spent with interrupts
> off, grows linearly with the number of CPUs. On a 4 CPU VM that is 40ms,
> on a 128 CPU VM it is 2.5s, and the NMI handlers of the test spend the
> same time in the queue:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Cap the CPUs taking part in the rqspinlock stress test
    https://git.kernel.org/bpf/bpf-next/c/05f8c094848f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


