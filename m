Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD73E557D
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700809; cv=none; b=hG8iDqmGncO7W8+7Vm9EQXPA7f4dWgqwVp0mblPa034QhTejYs02eQ45e7egY9ZxwElel6NgGDbfYIIUKOT4k/y+NY7ZejFlEjVepwYoQ38zY5iNSdzO+/PG/r3Q01xjUYS1t9cIi5QLPcmsD4NG1a0bAk/K/yYxYnm51radnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700809; c=relaxed/simple;
	bh=iigMW4CJSSWSa8Wc+0LrdEtr3xHxpI0TUPdRMbfd3x8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=apIQZnAo8H2ADnbyUSjlkAJyyh6gDGxhziadjBnwbWOKbLNAva/Aw7xpxotWjALBSHB9FsEa37rcpQKqmNRbBM2L+/uBdeVv8Hzq6QXj90eomj1t9d7ECkmnnqBHy5JApqJs+PToaOsYwGJzE2rDBdE+jTGMSSKYNBa41SHvaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb4bnlrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb4bnlrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BF71F0089B;
	Sun, 11 Oct 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791700806;
	bh=/r1uPWJwx9nUQFFqP4lpVtwmCTMeEP/pen4xVLKou08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yb4bnlrSgnJ3wcZxArTpw5mJtu3SERXDhao3UBSrByEwOIJFIZ+PvzhuaYtENU3bY
	 NdP9gQelcBydYRu251OaVXYQx34//dxFoodizNY5mAwsq0NzVv8CTzdfhtm7GWGemD
	 k01E83hiyOslyT2kr0MYRB34/ASNx+Y/DvG2jgDq2n02mb8jtvqs9WElbOLAqkRzSw
	 zgB3UM27cgg4lE0YgNKXl9lURjLZ2/Ag4vxFcOaILQbB1nDLPsHM1a/MrBguFVu66O
	 nLAjFjaTG9Q6xwZ/gCEAjDrH934bgGBdjCsnwPMvZ6uVgYlwidWb0jHEBsGQs+bpq7
	 b4UZoDJRbSEXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F180A3811966;
	Sun, 11 Oct 2026 06:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: use div64_u64{,_rem}() in scev.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179170080477.1955060.13676447498848225873.git-patchwork-notify@kernel.org>
Date: Sun, 11 Oct 2026 06:40:04 +0000
References: <20261010205828.3366892-1-eddyz87@gmail.com>
In-Reply-To: <20261010205828.3366892-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev,
 tj@kernel.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat, 10 Oct 2026 13:58:26 -0700 you wrote:
> For whatever reason gcc built-ins implementing 64-bit division are not
> wired into 32-bit kernel builds:
> 
>    ld: kernel/bpf/scev.c:2074:(.text+0x4512): undefined reference to `__udivdi3'
>    ld: kernel/bpf/scev.c:2141:(.text+0x475b): undefined reference to `__udivmoddi4'
> 
> Instead, one has to use div64_u64() and div64_u64_rem() explicitly.
> 
> [...]

Here is the summary with links:
  - bpf: use div64_u64{,_rem}() in scev.c
    https://git.kernel.org/bpf/bpf-next/c/4cce28612bf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


