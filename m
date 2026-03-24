Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4D358367;
	Tue, 24 Mar 2026 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384831; cv=none; b=D86y08N99tD0YOtHNVB9IQDAQ2XELZDV0QNKqvgbZW3g2IcSOYkJj2/Q/q6IB/W9evd+cQ7Z0JkhY4NbJ2QDhLP7U533oPjB4minRJcNRfL2zm/C0dR0fhWWb3wnV1gXaB0nn1oPIALdCfgpxWQK1QlSewUgtUYeLTy1czLAIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384831; c=relaxed/simple;
	bh=4pkM6tbojjAngRgzfZOdNEq2eRL2ZN2DA1jMzqE6YW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lgcupTALRIaLuj1XiVNo5hFSJ4YXNYh2r7TeJ7gJPTR9Z9Q28MfitlQOisl8A6DgmjFiAlme7bTX9iVr+M+/nPcbHfpHUhhPRnxG2yy8ZXFUQAj6+CIwJkVg6efgl7TSzBWxk1yaCLdhyBWjcupwl0RKyW2aM0lKmwGtj8cC00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqo6OY8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqo6OY8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2B7C19424;
	Tue, 24 Mar 2026 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774384831;
	bh=4pkM6tbojjAngRgzfZOdNEq2eRL2ZN2DA1jMzqE6YW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lqo6OY8q9Oo4BgRiog09Fuf+dgzS/6l6YlphSYj/CJykIwD7oWn8QyuHKOAWIvdqK
	 2LG5mfbYSFO2V12b10pG2UUOrneXbzBUHzc83ZOHwFgciAHrWbReo6eemhTOXmrx39
	 UyLImNpyDDe1hBhCynzJnD0iL4XRV6Zj/+Fxd66kFTHjuN7W9xFJsoRagP2JRU/erW
	 BFzeiAeI/2zW5co1Hk/sdrb5rtbZdNf+wEOMbdLbtMW/hwb3j26L2rGlr3womBsIBQ
	 8Lhrvv+XwoF3Wx63ZKweGRW/fDmUi9c8j83FykgfMq+dSrT85jnIY1rm5wojfllQoU
	 LMM1MWq+ZivGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC4C3808203;
	Tue, 24 Mar 2026 20:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Improve tc_tunnel test
 reliability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177438481881.1297770.5261150378919805874.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 20:40:18 +0000
References: <20260312083615.31835-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260312083615.31835-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, jiayuan.chen@shopee.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 alexis.lothore@bootlin.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Mar 2026 16:35:54 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> A test failure was discovered in BPF CI [1] caused by connection timeout.
> The current test timeout of 500ms is insufficient for CI environments,
> particularly under high load.
> 
> While the optimal timeout is unclear, this test was converted from the
> original test_tc_tunnel.sh script. The original script used nc with "-w 1"
> to specify a 1-second timeout [2]. Therefore, this test restores the
> timeout to 1s.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Improve tc_tunnel test reliability
    https://git.kernel.org/bpf/bpf-next/c/2790db208b44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


