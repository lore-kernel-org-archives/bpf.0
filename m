Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3673F4DE0
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476886; cv=none; b=Vd1bc3ahSstQKOboQiApTgfmXwi8muiVztVWD7ntPYWvg8kphdAiv68ytjhkoHYhylvGTzQEaeE4lvM7kQwMkoC2Qk3PXRTSNrNXNNz3IJZobt+3cbeUkF7tFLcYzG5jhZyB5Jlmu04XakUwOX52YwCMTWWJz3De7JYE6xrz1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476886; c=relaxed/simple;
	bh=tuWvA/bslmiqHWt51T0uGddqFubKkBWYBxC5awGVNbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sfgfOQ39pp1LXEnFn/XYcwtp+Yb1dTsnDzKrUs0Q+oPkh2/QIa9EIB+mxRrFeLjOOlA9OKxe/+3YzDqzF3bgvaI7Ula1X3JjnzUnxcCBR2OEmfphFFqk//FA34Z47z3DO4Z8Noi+kq2UTs7xkkqt9+u94o6XgzU/Z3/Ho0j+VOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENbBZ6/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENbBZ6/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B232E1F000E9;
	Fri, 26 Jun 2026 12:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476885;
	bh=rzUyzRxrkqSTu7/4WmIu04VcEpaEmwfiGOKLnInNGZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ENbBZ6/lhC4Dz1NYmcOPpwPFgWV1qGjvzmbT/scOoglgB1Jq6xIvGUTw8rB8KBB2S
	 K2bnjvP5rbaiPy2x9YukSJuXrrmHF56fAND82mRqw/aWBj66QMWVjGn9q8aJIsIg3U
	 5D+384vAzlNcHjuroSGNHm1uRpJTNkaHRUYFY2JB9/jnOQZPPn7Gz9myUjJj2YV/3+
	 Lpi+5dsvoFQJon8oBcewOEf2FjGwvWcy5ktXXFjSZX8Gf8un3n4kXpmeFNGafix7pr
	 7MgEBmbfb/jHv3TFzwdJnOHelU+gLk8tc8K95DaowQe+OI/6euWbK+APVeYGb/8XsH
	 4B9Xq8fKb52Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DF939389F8;
	Fri, 26 Jun 2026 12:27:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF fixes for 7.2-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178247687248.457674.7317619493339785154.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 12:27:52 +0000
References: <20260625201934.54233-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260625201934.54233-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 25 Jun 2026 13:19:32 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit ef0c9f75a19532d7675384708fc8621e10850104:
> 
>   lib: Add stale 'raid6' directory to .gitignore file (2026-06-21 14:09:49 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.2-rc1
    https://git.kernel.org/bpf/bpf/c/4edcdefd4083

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


