Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059EDF76
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776475851; cv=none; b=Kf83IFjDCU29h5DOI1XzGbIVLH33uuOh5bIB1NxZ+mJgwUUUxPPuGjNIPRRsTd5/iQAe2Q60r82ByqE21ikRnxLh+HCpmrdlfcfcVAMLJxVUjM9ZJdI+gjSWpa1hD5h8jiHbNssyFQrHl5f6lTbpSwFuGOIP4qNRIfQ8/DAzD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776475851; c=relaxed/simple;
	bh=uoDKlql8pLZsdd5Kd3SSQtE06FeUCsaxXr4Gh9+mZ8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mGwLcqobEhzlh71mvacGiVX9qdJZbO1nW6l8jh7cIToNYnWzw5P+gPkbg087dN+tJmd1gHJr/NjN+aL7pZ+D7YM8pCpRq9DrO1Ery9scdC1wf9IUy/q4lj4yic9jXoEr4kSWYz3+4Y4TZpvV2tPQ9oDhDQ5dPQwgRwSEUaSUj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn1YDikB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn1YDikB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9EFC19425;
	Sat, 18 Apr 2026 01:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776475850;
	bh=uoDKlql8pLZsdd5Kd3SSQtE06FeUCsaxXr4Gh9+mZ8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dn1YDikBStd5mhlLgQcbmP2pWzzhxoubRd/2xUskgsK913tVwg8U/GBuk/w7tsvLc
	 bFUm94//87iMjXvfMDYdYtPXVDmga5sHnIJF0gxIw3d9ti0q1HMW+csVm+3TGMYNfB
	 mT8FUq0KjlpIpIBtw5eJeIJV3o5o4s6IOl+eKwBQPVPm/IbzAcA4wfuSbrg5sq0WMA
	 8aC32pjYxLHJBXOOLEXgLBMo3KN+eUwbaxTLzdEUOvG3iOK/tyhAc0NlODkkArXBb+
	 OZxsWDqTGlS6j4SjttsKXZki9Ad4s3fvLuaS/DiDTKgJbQNtlIDa3byE1L63sJ0m7W
	 yiwCHZVHTS5LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCB3380CEEE;
	Sat, 18 Apr 2026 01:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF fixes for 7.1-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177647581780.215801.5986207627976050697.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 01:30:17 +0000
References: <20260417192627.51395-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260417192627.51395-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 17 Apr 2026 12:26:27 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:
> 
>   Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.1-rc1
    https://git.kernel.org/bpf/bpf/c/eb0d6d97c27c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


