Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744727A462
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728613; cv=none; b=pqaUu8CApipGFYYmAoNPcDK+JvzBP6AyUghmn7ompmLP6svkAHl5WkSI/hTFf/QdbqxedwvxYbriEDGHcHlYPtDc2Y/3Ud7MtNWAx+mrTDjKW9o2/tlpPtKiTnRI9UhojP7fiIK6DWMZTsAGxatTsSx4RulBhNEr5TQlb7v3WV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728613; c=relaxed/simple;
	bh=DbCPflqMi1+BB5xUBHCSLrCEa7F8dppWuxmZRK6TaTA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZPhVg6V/9/yK9qSJsF+Ou+UOENRuzg/dTCkSqYUUqjoY6Lcg5ihtVT4PXRjgUf7WqYRStUjHKcsrqXiZQr3QlDqo6tVA7zwl7i/BwiZGZahGWasquSWTW+1k/n4pfgUokJRnGcLZ89rWvYjbTwAC58oCyYZZ22y9iW7y0X+jKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpK8eQuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpK8eQuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF69B1F00A3D;
	Sun,  6 Sep 2026 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728612;
	bh=Cm88F1R/FYrrbisB1h57JWKj3VbcuM/M6XgQIAbmcvc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=KpK8eQuCrxPmgaIM90want10O5RqeEe95bJWRf6cB86okLNYG7tq5wev6QwYhw3x5
	 1UTHLoE75nqtwQEeG+LHU6LOvl6glQm2jrCrs6Y4ttuFzhK7+7GW3VWfkHswfg8kij
	 fc3OU+3Q8UY5s3olg4C8WwV9aa1r+jvDh86lu+h/j61sRaHTWUTCxpC57zZtvoi3Rn
	 kY4pirW+B3EXKr44VlwWzBXBJzPR6w+aej54nDJSDdTz43n9+Carqx9GSJLb9z4hvG
	 vJBp6LE/zL4nAsEy2miFXcQdpZeyOy2y9VRU8SZTyB4QFLuNLEv6ei/tUlMKcURl7P
	 z2v75hedoEpdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B163926274;
	Sun,  6 Sep 2026 21:02:33 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260906154249.75894-1-alexei.starovoitov@gmail.com>
References: <20260906154249.75894-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260906154249.75894-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 536b523b407397c8d3967c020ce7aad70a0ea030
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2beb1b31a12b57e19cd5c82ea6d54e56520605e8
Message-Id: <178872855210.1679652.15488368987018512488.pr-tracker-bot@kernel.org>
Date: Sun, 06 Sep 2026 21:02:32 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  6 Sep 2026 08:42:49 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2beb1b31a12b57e19cd5c82ea6d54e56520605e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
