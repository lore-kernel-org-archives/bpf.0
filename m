Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41E2EA749
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527478; cv=none; b=difBbHgS4RzmJkzdfsKrdgsxYoEFiqDaxPLLeiLAlBd5K8chXlzAKjGNvErW1lVppQsDUVEYB1/nHRnTqBHuwJKK2HmQBqsvfvO+2w0teeo63JyUFpUMAQ5VKDnSAuXV/aP/FUYjNZRV9Q5pOSHsb5pY8EEtqo8uFCqJY9KSGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527478; c=relaxed/simple;
	bh=nRXAd3qavdE4jxrmFoi3Q7C1SaHfQbHOeIGpdbCQ8Wk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WNJm2eTxAw7tyey7ADp58roVGeuJsseHJgwT96Tp+vi9B/M2X9gmRWaG0vii1eJFA26TKonMPB8YABF4F87UUqVGNu4/t3wgDRlwx7Ipo4iy1+HxeiuyRH254qHj4JmwpGwUa+T3ZJOAxAmbRgx2Fb2Tvkqm6JJmwWdFb0p8Lfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrMMd2PS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrMMd2PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD89C116D0;
	Thu, 19 Feb 2026 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771527477;
	bh=nRXAd3qavdE4jxrmFoi3Q7C1SaHfQbHOeIGpdbCQ8Wk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jrMMd2PSJsg6wEoIOQ3LyoL2BV/eoTBPyYZzhYs+MX2ViNy+ZAJaXYGEyyf5Q8cKW
	 WXF2irTpxW0qXHdtpNBREb5TMwCHMv5AaOM+AINcgEtcvg6CL6VWtonFNZFI/ZYOWo
	 zycUsTcfUtsk1lESbA8lFtYxqhGvbcC6DPAsRe52X3EliDSCOkF/QBCeEoaSosvOGI
	 9WyqQYlAjmIz4/MueFmluma5GbJbHwIZc4gqN7fvWjqvyf2EdmWXxyQQKkaBQceC8y
	 HIKI+XCfrrmR4ODmVZcx1DlNKNuTvNtwDMQsvL2jV6BwM/VFCIfWKFsIzdH1eH6p8o
	 uJ+oFUVyFgDWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2B73809A85;
	Thu, 19 Feb 2026 18:58:07 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260219173515.51586-1-alexei.starovoitov@gmail.com>
References: <20260219173515.51586-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260219173515.51586-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 1e5c009126952f673ffa2427acbd69e57493f0d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f13d0dabc87fb585b96d90cc4b29f67a2995405
Message-Id: <177152748614.17614.4760036957530104794.pr-tracker-bot@kernel.org>
Date: Thu, 19 Feb 2026 18:58:06 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Feb 2026 09:35:15 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f13d0dabc87fb585b96d90cc4b29f67a2995405

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
