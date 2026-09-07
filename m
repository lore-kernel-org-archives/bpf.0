Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F29475
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739629; cv=none; b=C3aYwJ/mgJsxoRv8JEargtTpS8K7KFpGuVoLqEUXU1kjae+oVG1rSJed8qUMISOFYgnSrj3B+ILMvyyLswABseEVdQ0TS/UT4pUUv3dDdFW0mPK+K9p+UUpnd/WDD/aKfnTQuBncHq2jiMfVWgEqdYsOcXCLUtRibKXfUP7qrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739629; c=relaxed/simple;
	bh=+NdAJ0eDIMlG31hj/dFM+dEkGG7KT+CCPgljay6uRrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fvRZiuGL6SPkvNy/utm7uk8mIekPoeHAicJN/rP/ugWZoLThNITmBFc9/r7RBwPzhPp/AL+fPqv5TyjgSpgfj+IkbRuW+H2qpxXhG2kPim73xixmo7bkQa2B7/fo+GqEFZJW9NI5NPC2bKZCJaZjJNSdDTq+quOvZkohHyG2Erc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXQajwqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXQajwqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937171F00A3A;
	Mon,  7 Sep 2026 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739627;
	bh=+EwQ4cahopPFMAK68xG7MgG5YWqm7AdWHZ9rf9/gTyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AXQajwqG9vmz+UBMxYbUIySINnbeJ17MogBH7pU7PM+Yx/tg+myQJhbALw5L54IA+
	 mt9+XWomwA8kyB0/vi9zEGSOlx7sdnmPUi23DLAoXxj47N2sFovOEPIx8NCLOEXzc2
	 tXoqNYdTQINKKDg1YGhricTsJiUzyEE+UTMFQa+HoihVVxsEyjFNZGSrDuXc4DT+a9
	 Y8uFX/ShF7excju7SDwH22Ma1kfNAQwmGXodCb0Nb1Y3YnZ1mf96t3P5f5F1lznkjT
	 jn9KnYKEjg9xBFdJJrWNF+Rqul3gAXRzts3MyD0BObpRWrMeUZ0XBwglfdkpQ08T3V
	 b4qcSK2lzgtQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568DF3927206;
	Mon,  7 Sep 2026 00:06:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF fixes for 7.3-rc2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178873956715.1695640.14469461340421651824.git-patchwork-notify@kernel.org>
Date: Mon, 07 Sep 2026 00:06:07 +0000
References: <20260906154249.75894-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260906154249.75894-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sun,  6 Sep 2026 08:42:49 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit 91ec2035134982b98fab0609a9fd8480e8217dc1:
> 
>   Merge tag 'net-next-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-08-20 08:16:04 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.3-rc2
    https://git.kernel.org/bpf/bpf/c/2beb1b31a12b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


