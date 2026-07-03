Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2A241CB7;
	Fri,  3 Jul 2026 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047403; cv=none; b=WZmmdSmKAAErzhqrNi2bQqWqmZBDRIWwEg1PzYjME3vKcxkPLyW9QwP8JhiMFESKgBuAqoqTvRBrkJYdtsrx8eLd+pPhAzKIsepEbbeUHlh/N/UctG5YBe60SqxKW28Fu7W381mo0lStvOkezyl/gXcqrkvKA+tUNG7GzZgito4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047403; c=relaxed/simple;
	bh=RaFQMdkpEoVR6KJoEmgF279zJwstg7vgm73R8tqH4/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hd71Z59rUPfcDYSGMmSCSOTkonkWqn0tTIaDu4WTiKXpGBgtLzd3NtDha64iGGWlXPvGfxFUcMugfYh14eqiyNRbyVgou4Xk5lIyly8ObG2l9NOuEFFW+/gmZn2HZSM9Seb8iBuO+2VsarcjwUCXxVOrF/PDhftJCxm64CofsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJl3poR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJl3poR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12481F000E9;
	Fri,  3 Jul 2026 02:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783047401;
	bh=s8PVoJ+b8X3k4uMk0vy1UNw9mHtZS66rq5aPqtG/280=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bJl3poR6VE2WsCekNh77ZKQinfbbipRbJz/wR5fp0ubsZuSwcwQzz93uM7Ut5brjN
	 XjGfDwY0ADg/iF07/ogK0sZ6aiA/g/FRSYe8TZ8SMUMrQOBCe5+hec5Z2zkrp4WQg+
	 KLX5SUBiTbefQguanYWK86WkOLgQ7Wl5/xzCTNP91EElUPSWP6ruinCaRu3ge8Bc7H
	 E3h8ja8dqpti26v7mcVeV9D7aDqLr/KNKqgHf4n0COW24WJp+tTEX0sY5njAvD0MSW
	 T0/IfC8hLNVVdjYH8ayxZQyKS9a6uUYRBJKtLwAr9wbEKq3Gbpbi9EITfIEU4iszlv
	 ncVCK77kTIY2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399F3938454;
	Fri,  3 Jul 2026 02:56:25 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260702192836.260994-1-daniel@iogearbox.net>
References: <20260702192836.260994-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260702192836.260994-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: b72e29e0f7ee329d89f86db8700c8ea99b4a370a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51512e22efe813d8223de27f6fd02a8a48ea2323
Message-Id: <178304738411.2410170.17412242970340729892.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jul 2026 02:56:24 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Jul 2026 21:28:36 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51512e22efe813d8223de27f6fd02a8a48ea2323

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
