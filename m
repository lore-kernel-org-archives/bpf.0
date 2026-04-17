Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CE37EFED
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467520; cv=none; b=VJjLX39sgnO+3t3ZS4gaWLKHt8230WtdLYVLRcRBstEExZN1R2RtersKOIlHxLmH3mz+A4TyvzmtNaXd1sBF9L/gT4Ujvv1EtrWy85dX0vgopyKNv6GEpfyRubkMKgQoaL8lKQ4jF6V+2wZbzBtQ8uQDukdaR+dnzwxpwZZClsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467520; c=relaxed/simple;
	bh=dcqA4qiWdBRRcGvj661Ffs51pBsiWPpdL9injbPd2jo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aHi8ejdFwEjeoqyZ/bibhd/G/eLbS7OJ2c3VhYuAGLClTJRpG2s9uPzKG0yi7nNaIF4BRoUxrt17vw1n6wtwN76oKje+6QfkgcFDBOaVDNiqG/c59MYjurL6wQfhFK2Q1uYWXGrZc6IHrRF2plwSW2wZacQUAd8m1uvnzZUKFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKIexrNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKIexrNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89227C19425;
	Fri, 17 Apr 2026 23:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467520;
	bh=dcqA4qiWdBRRcGvj661Ffs51pBsiWPpdL9injbPd2jo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DKIexrNscq1uyFTTorArsAc6IDAS0tc35zdwcpmgZzobgWGSS3iKYruJs+H0iAr7k
	 ocPOCifbC7E4qe5pu7DhpOJPCafgW2F2jYPTZYjn8WQ3c039M+9j6/7nRnJEVoEd/L
	 vOHkh3u9wHHqhYPmrS/IU8+j5zxdmRPkv6siLVnqkC9Os8NOoKDyDh31ICJ1b3poXH
	 +6zl5qRwwq22m3t8pWeHq9rLXTwTMp+cF/6hVS7vmSs1Mua/vJ2SZ5jJbwaS4nmGL1
	 gXbUStgppwLPjtnML6Ynk9XpbYeJ1iltfPdXZU207zcnJcehnLWs3wtqPfRpEgsf2X
	 5WjuiGYxPokdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E9F380CEEC;
	Fri, 17 Apr 2026 23:11:29 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260417192627.51395-1-alexei.starovoitov@gmail.com>
References: <20260417192627.51395-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260417192627.51395-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: e1d486445af3c392628532229f7ce5f5cf7891b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb0d6d97c27c29cd7392c8fd74f46edf7dff7ec2
Message-Id: <177646748746.192740.6752785807511377510.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 23:11:27 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Apr 2026 12:26:27 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb0d6d97c27c29cd7392c8fd74f46edf7dff7ec2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
