Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30096128395
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439207; cv=none; b=Ko3afAB8KU3IdzKSJJWDyg825aukGxrnd5hPn7A/w30TG8CjLX7AK1q+CCBOrBcDaWYENQNOL/4LH14qhUOfTr/8MooZqmShrX5RTnTW4VEbE3V7aw84mgpuGRSyW6yLnHevplXbLpEKsqvrFOwoBUIEKEXMWGEf3u8FPpYyOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439207; c=relaxed/simple;
	bh=xEvpe4bV6XOWKWy/6xWxcbug1DOtl79KlQWemphgwcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UvVbW5bim5/EPPEFGgsxlXBnMGr4FvqeJ2CbiZ+GPxZDr7AAJIFnvzxldHjRBzoqbeGK1GveNN63nwzgb10KTYqexqtf3mjCicLhxApl3VT3lW3lEw8Nfv6/aOt8/m2R8VqgWLrNFKS5s5iEl8JuKRWf4CNabVwBZMfBVhIt/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG95BpF8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG95BpF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087F6C2BCB8;
	Sun, 10 May 2026 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778439207;
	bh=xEvpe4bV6XOWKWy/6xWxcbug1DOtl79KlQWemphgwcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BG95BpF8MOuNks4eGqwM1m4qaYm6Lze9fOnBQdJbv2BJJ55Ci2+AWOyTRxDouVhb3
	 nB1GldgwhTiB/5TfwkXgbQ5V9Et7ivHl88+XCyIwLp06JxdKyapUE59s1qfE6rZVM8
	 BLyo4eFY2sUZNqJ0m7HOXMp+mC5qXFZWFH5H3Cjs6KK1W7p70I3b95PhIAh6yLc+w5
	 ahk4GmgEWv99YzniG8pAE/1c6SHLfOHtx1/SA9mk9h6gYDedJsWKMxaDbU7Y9fN2pR
	 uJXi+S4Q8GRF56pff/ieKifG/V1a5MpPUNlPvfD4FU804dCWQiP6E/pDNDZKejiupW
	 lwDnd566Po0RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDBC380A977;
	Sun, 10 May 2026 18:52:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF fixes for 7.1-rc3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843915430.1446496.1247056062987413743.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 18:52:34 +0000
References: <20260509233456.39703-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260509233456.39703-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sat,  9 May 2026 16:34:56 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit eb5249b12507246dc959945454cd1be8d7dc3795:
> 
>   Merge tag 'parisc-for-7.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2026-04-18 11:37:36 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.1-rc3
    https://git.kernel.org/bpf/bpf/c/515186b7be48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


