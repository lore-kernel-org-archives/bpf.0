Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FF34388F
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779653525; cv=none; b=loyseRySvOiNiL7SuzHYTWGGfwqpBxpjOO/pypicwgWSRPT3WXZ13bTplLm0K9AngevFdfy/9NoKvF5MeoLTp5djDU5om7gZyULP9/U535x8U8VmgyGPF36z9CZ7n+3/QNPUa5Y3tG2ruHy+GEsG06h2KG12trAhb9ZPz4EOkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779653525; c=relaxed/simple;
	bh=E7b93qPIERuwyGFVZkYNbfMfXB2pnPaRiBJry7HzR4o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ghfTZIUfu0NDIdN16/8rTDnWLzrinqQB05RvBr/3Z5VZwL+rD8cVmyPkGcuwQVSxxVRIazPYV9uGQAhm09vFxTn9xiPugnN7ybtvcp0eakq0Bvpc6QtriIQExTbPjzist8QMj+F37ly9PUHuee0rQXrTmcx9rEhpUQxttmTVW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WElVlT5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WElVlT5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C5C1F000E9;
	Sun, 24 May 2026 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779653521;
	bh=yIBcyO3MDyBStUBjamtkTbRuBjgirOHoFVdNL5ODLXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=WElVlT5jXhNN8we2tgl2Ivvw9VK9czvfVWnHf4EDPNzsYs/AtFlsf8LcVzD1STv2a
	 w5JJBvLabX4OhFWCCgDYIwx8f87lScni4yjYpwUdaT3juqLCh34DMWvRCH/IaaFE/N
	 lUEYidvMRO/2VE1hzHyPBi/Ex9cYPSTDCx1GUll7sTCFZAt65le6FFD7Z0uZ8/FVGv
	 1RDdDo8sDS1pzjsaXOiuezT9PeXwvpLRJKot2HJDMoaZh5inJu0nI/f00LI9NAhVR+
	 Nt8Y5PJW0hlUTZilKvMSI5tAGXkMyrF0/Fbp7BESecrjsfgo/2S6j56Cjs6qXWMHJf
	 NhmONZDFk/vQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93DAD3809A83;
	Sun, 24 May 2026 20:12:10 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260523145928.46476-1-alexei.starovoitov@gmail.com>
References: <20260523145928.46476-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260523145928.46476-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 7dd62566e0d108d29034bcff8503b827f8763320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0e77c598ebbb1ae055b156aaa33b7433ae45e51
Message-Id: <177965352906.1864217.2838995279361634726.pr-tracker-bot@kernel.org>
Date: Sun, 24 May 2026 20:12:09 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 May 2026 16:59:28 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0e77c598ebbb1ae055b156aaa33b7433ae45e51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
