Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DA4A4984
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264864; cv=none; b=HDLTWKnTePMYWEb6g975jxWxgGVtTtQh2v6j6/Buf3dQThfKtLQYjO4DTXA922dJJH9vQZ5nAbNYtAewuPdehJb8fomYYokA9rkzI14T0LBKsbHhexONUU7VkXUieDS2ViTIXoKFGOCA0bHBIQy8NxaGmOcKnv6goVIuHW7Ce64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264864; c=relaxed/simple;
	bh=3mdwUgc/1b5Apup413EV+l2z3hzpJsHTfm6t9UFL6Zk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Yen150AiQ2m2u3MDVgZKfSAHaho4nYhqaUpEmPbaEpKHxUpbHIliE3tmY3r6fxiEM8CySB/waD6URwanBeoLGE3ehdCnZGfoMYLOk07Y0uK7HCGUgbiaM4oP6Zp26jesfI/tlA1TvToT7BsOb3ZVzuuNGJ1g3WRMpEirZjw+2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRslii/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRslii/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D094A1F000FF;
	Thu, 24 Sep 2026 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264859;
	bh=jJvlRA4Xkd55O8YhCCfjNFZwdZwa2WKHl4HSXvS/eTQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VRslii/CDQn754OBJ3riDRQ+BpFPdRDvfbF3iRByHUxG363ME2PC595kLOafwDoPq
	 7yhhvTB8t0Sap7eLvOpwW8Ty1o3OVjiIIkopTXMTxCQChibQwWxZ0pGrGR25G8iAqJ
	 +uv7qJYwgf9X0VS8ooQ3SSwRxvrp9e495M6E1YR1NElSZlB6eWN9MVT0+Zsrk3NyW9
	 WqUFpWUSrf1uc0frq55rSL5klCAj6dnuaYmdPMDWVTRE3FrYbj3aoj8d1VpmHnbhvg
	 Ss9jdsLUss+ChyR0UFsawc5h8uwzY0QXtphxksTcke+AWttXJF0VVmVQM9HioDatQm
	 SACV0jK6m53FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C0F3A566C7;
	Thu, 24 Sep 2026 15:46:30 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260924145521.3616829-1-alexei.starovoitov@gmail.com>
References: <20260924145521.3616829-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260924145521.3616829-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 1b1dca56828f33bc5e39b930ebed062e77fbe3b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fc5768c7ca92895ccd1de94dc521e5a55ae7896
Message-Id: <179026478864.1617440.1569873003573011190.pr-tracker-bot@kernel.org>
Date: Thu, 24 Sep 2026 15:46:28 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Sep 2026 14:55:21 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fc5768c7ca92895ccd1de94dc521e5a55ae7896

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
