Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE088377AAA
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096540; cv=none; b=lEei5gWppDSTaNcH+S2w/oUff4NIzU+JmaEVOPxUbKUizo6cfxaAStElubH+YHjDf6mtRDwJKqarKsz5vP2SN9HhMMR75WKvXCrMew5syp/JL0btfSecFZVOc1QBtApQ4i+puEO1uHQts0OUUHJsakekrHJ6FskxQiykvhEaqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096540; c=relaxed/simple;
	bh=HSNJh2ypOWKtQxqvdpRkIkGdfBaTk0zv++RKQHNkyCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nnIKQQv0TidtPHEUw15SZUqdsvDG+UfKOyY0uuY9X/KQWTeubi/lgCYyi/w2hTo9ZdIRWrcN+sz40nSjoc12czXVBebRx4+IeUXwczhhECCZIdw0sn4DzQrgCWZLlrjJWBAm309xnIMWAYin39G5mNfIppZh0W9dA58MGg0wkT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfWqAA5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfWqAA5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678E21F000E9;
	Sun, 26 Jul 2026 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096539;
	bh=nGbhyugUsalS8pdJVcjdRCMe1VwZI24eFUIR0jiKE7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OfWqAA5wyP50xzxoXacS2SMg84lkavPMXuI4LV41iXkqQcBfvytSAIS3EHSc/ojmj
	 yHeAD9IfU9+1oasqqz+a3gyasSUQcI/E1h5XakELLadrXtHYL8q0aOVCYbp3fITh81
	 wdIleoLI0wvn6BDtRcsIo4vmqjPoh+zfzxVqECxv9PtC+sFmhUABJAgf5sa77YaPI+
	 64clJsWOlOPfjvan62i7RMgciVHK7finJU42/cNrmHXpk7UMWOu57T+EICU+CW/ges
	 e2VXsrJ6DNCDgO2fbbKHtwHzyr8bw3n0ckYP7fVO2wpSGZKOV1Iov3p0RiwPEf+XK2
	 qwRW3dDJVtSGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C3B38119F4;
	Sun, 26 Jul 2026 20:08:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bpf for 7.2-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178509650514.3839402.1276706444033403788.git-patchwork-notify@kernel.org>
Date: Sun, 26 Jul 2026 20:08:25 +0000
References: <20260724231535.854435-1-eddyz87@gmail.com>
In-Reply-To: <20260724231535.854435-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 24 Jul 2026 16:15:35 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit 94515f3a7d4256a5062176b7d6ed0471938cd51a:
> 
>   Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2026-07-17 12:55:24 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bpf for 7.2-rc5
    https://git.kernel.org/bpf/bpf/c/ae453eef9259

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


