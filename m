Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B38347BB5
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189559; cv=none; b=KyWMS1/8xsA+0LJLyoYypnOFItGjivJf8ecR2PeGvTuF4S5xMMKrq+C3fDMFqQppRaWAxixBPtaeV5NxK8KXH9w1uxfs5HXdqyXNQWFWTJRZAg4fbOP5iWSTiHvVp9b1GEosR//M7NKGPYFlsMfqizWknmCNH+P1Ll7nUgm2s9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189559; c=relaxed/simple;
	bh=77b5XQBN85pPaSZXnNd4HliaAbB71/yvHBqqMsNpdjU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZZe9qqn7Cyw3a+z4ekwO3Qs5mvAfJXtoWLBJ91451aaP8S+Z6KQe0LuqB1dsuJSCR/PMJRCVN+M70ZrKvLddzPIqcH4s6lR8FEGpWNJxzNhN89MdAo0sxyqVopTkYFtnYzeS/IAIrXVElPJ66KwQ4/eC8t5IqgQRDT3NiEyAdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHzXpEzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHzXpEzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0045DC4CEF7;
	Fri,  3 Apr 2026 04:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775189559;
	bh=77b5XQBN85pPaSZXnNd4HliaAbB71/yvHBqqMsNpdjU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RHzXpEzBUlIW70cyzkIdIp5n7jr+Yl+KyQkJ+VNB/3MBXoMx76MV6LzU+ebVLNMuw
	 aosZqnCZqvLYKdwpdxqCQpdGJwX7cFEgHZFSNPpwEz9rv7+U7g4/XhOuNhdm3T6GL7
	 vUn53hDDggbJD5Bi6kzJXl2qX9SuA+92SD5nWHZP7GOUs5jPNdVuDbVDyGKrhgKPUT
	 GCbtw/L/XBvIdSzOOwWtb4x7PSSSZH7hVNpedk1ry+QDJ2N+keud0pq4fmAwkLZp/Q
	 GgSe+8bcregCxRjQC581qC3zl4XIoSibwlLDTwA25FtR1z/W5wzQecRxaPcrVhtX67
	 09jolujCMRpuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFAC3809A09;
	Fri,  3 Apr 2026 04:12:22 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260403014431.67976-1-alexei.starovoitov@gmail.com>
References: <20260403014431.67976-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260403014431.67976-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: e1b5687a862a43429f1d9f69065b3bbc7780a97a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b9e74c5a49e1331e03c8ae5f981067da4f33328
Message-Id: <177518954074.733087.4587233824827650703.pr-tracker-bot@kernel.org>
Date: Fri, 03 Apr 2026 04:12:20 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Apr 2026 18:44:31 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b9e74c5a49e1331e03c8ae5f981067da4f33328

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
