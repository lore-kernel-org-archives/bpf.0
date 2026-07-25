Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EE38A728
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949157; cv=none; b=squhNrQ1P9DrcHIT4Ko8nj8985qAULARy5WQGSAvhXtEIRxXrNQg1J84BlB3xvYvPf+fS+ORgde3nPb20Pp7+CX/oTWcxzwZE00NcB/hZxQbWi5ZX9s9s3t4Jh//vzV411qKvUUXSaXY/X51zFaABLHjtGD4IHBCgsAbuLDsgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949157; c=relaxed/simple;
	bh=069+L4xFvvPg/jjUuJF09eZq29EGEnsj+/oOepJO/Qw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PXTz34L7YI+07QLPyCYrdKwQVF1DnFUgTD3Jhew7J359QM8iM+hmmUlCcy15YQPdzUaZz0wwJLT/sg+LJ5ErorjWSyGQHWCBiWc62fA2mOEaTUYgBkKqQIuyQ2fn88oVgp1jjplBKGlHuvG8Hx9NvBVE+Sp9aIvDXrlr9+LRjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9wTaedw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9wTaedw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D27B1F00ACA;
	Sat, 25 Jul 2026 03:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784949145;
	bh=IiPVC1/wXNhZyMnkEXUUV96s079x14p4OAwlnrXBxuk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=O9wTaedwevN8JZFrcj5Q6o1jXHU9YUE9B8jB/t5U+XC1KjEd69veP8oEjb5lmKZ7R
	 PwoOVP7DkSaVgrR9UYrylFR09/7VuEEZNNWnz03sEYIMnk7ZljdbQuY2up2Xi5Rx1B
	 5ueh9S5APBNozh4UvpTSLvm1Ljqa57zz2zRsVL28EwHIlpkf+NBLPsi4Pk705ykDff
	 HX+g7D8kS5WLNa6HCDDOEmFZ/MuwA11UKm5w5yCUWqfMpBb3HOntFUwy7x60M2Vgni
	 YAdcYBrRoKJsP0PCYl58BBqvEzqBZd1hcQJgKLya/nfZ0uAnYv5VusDsXyMBSWRm2C
	 Z1eKiRNRQK6sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3638111D8;
	Sat, 25 Jul 2026 03:11:53 +0000 (UTC)
Subject: Re: [GIT PULL] bpf for 7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260724231535.854435-1-eddyz87@gmail.com>
References: <20260724231535.854435-1-eddyz87@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260724231535.854435-1-eddyz87@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 2d66a033864e27ab8d5e44cb36f31d9d2413bee4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae453eef925945a02bb558bff9debbee352e33e9
Message-Id: <178494911248.3393598.2398016713245164342.pr-tracker-bot@kernel.org>
Date: Sat, 25 Jul 2026 03:11:52 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, Eduard Zingerman <eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Jul 2026 16:15:35 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae453eef925945a02bb558bff9debbee352e33e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
