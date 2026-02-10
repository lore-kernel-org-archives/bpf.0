Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F332E751
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753606; cv=none; b=m80h6s1OD8lu3mDeqXKTNgqo9CS9/mtr32KlpXSxzm23BP4GbftKcUKMdulvf7cE42gu3vxSwbqB/7OgmlpYL6mKn4LZddTFQqeU648E1Iru/RngVFtXPIy5sF/L9oPqD/jW2D8NBV7ZBY5+d1KeOEpnYww6hBa0zjAT+s1FkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753606; c=relaxed/simple;
	bh=R7xx2DXZLJJdwanF7+wD0ld1IgJp8Ik+mxmq14sFadc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YcyLh3vW+pgn+8cVvOk7ZYzhFKSR3iVSjiMpW/JMtmUhoeS2iApPeUA7jkuNcF7tsGhHOw1hhvz6jrkbzFkbW2YlujnXqULDF24XgZJ6AyHeD+mffsWzddJSu4cDQYMFa7t4U5t8jFquuaR4CR7ip8np3J7lNJbV87JgKvJVmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT6REY3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT6REY3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853FCC116C6;
	Tue, 10 Feb 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770753606;
	bh=R7xx2DXZLJJdwanF7+wD0ld1IgJp8Ik+mxmq14sFadc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NT6REY3vHyfaxgg94ThwQxLig0maM+tHSro54tPAHj1uOsDKusk6lRXUQxtm5O8Iv
	 NwXsb0DsuU+9/B40DuOcJcszvuIs7rLWORBROTcQMN+eD84JOokbSCiQ4my916PWYS
	 rfcmhwbF18z9tNxkYxXSoPeT2a0cxicIWUOwfiTTfUR9VPj2z1S90kDWw1p7E8KuB6
	 vvtZJNKyoVjj/nbuSIAvr3IgYrdd4x8AoRC7fTjh8VA8+yDCSRwoK5LtdwQeTKDS5o
	 2sMCf9SIyQrZFsYtNWG1LuPTIxQg6OjLhcAiC4AKM8/8W86c/kZPU3wYRkj4KI9vgC
	 LSwlnLg9n3xZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1F539E4DAD;
	Tue, 10 Feb 2026 20:00:03 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260207020456.36237-1-alexei.starovoitov@gmail.com>
References: <20260207020456.36237-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260207020456.36237-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.0
X-PR-Tracked-Commit-Id: db975debcb8c4cd367a78811bc1ba84c83f854bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f17b474e36647c23801ef8fdaf2255ab66dd2973
Message-Id: <177075360146.3655785.4140516928394697638.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 20:00:01 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Feb 2026 18:04:55 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f17b474e36647c23801ef8fdaf2255ab66dd2973

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
