Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836444E67E
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975499; cv=none; b=YSRKJeDCjARbT0GM5TysSbibsJrpakQZazHStijJD5FtSgibfBO6x00uIWMoMdoWODQu16ld97id99BPJO1z2cBJDDBA0GnQvpTiWVzxTTRG0GU9B/VrhCTb7jQHsLVPXNUdDu7f2CkxVcV2eBAD0B6fQPZ5LJPgwUyTeS3jICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975499; c=relaxed/simple;
	bh=vRSrDbhna+H+y5xGfilcW71AsHWGNCS5YqYAze2EB2s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TdyK+q2Q+G+rgWZsGAx4p4M9o2d5NbcUXRNlsAHoQBWJpbrErcKB89GsM7cUA2Ul3i/aRles5Gi8sCAgZg0GFkuEOOhyz1pxZWn6sW+LjZGnIKPtWdhmwQmCZ8amFcQuvsBhCKocY01odDUP5zmnRTuzPT80lMkAU0wMR3vi9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf6NfSRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf6NfSRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4031F000FF;
	Fri,  2 Oct 2026 21:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975495;
	bh=5vm5KUSRIDF/HRbFDWDH78mW/Dsi6B1uzfQxQgz8WF0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Rf6NfSRU5UV/I5KBGluI7SCcG6bzKxpoTBgC5BkywyyNI7VJlXPaMpqffFDdULrIV
	 2t6eByO7CN7Wgtf+hqeGMRnnfgqpg554pP2ZGxOcWsNjjlzLmkSyB71oFm0MIhMm5N
	 MCVdB3UbnNWVgX/pwKbM4dyjClk6Gqx4BLrabQV7DENkZpAsoaAvdMFWLP9Ho5dpqg
	 OPHWm/XewE+Gl5k5l1AcgNfxDjTNbPNDRzC49k2hFFBTRIHFNI0/lu+2+lZ5mCXmbD
	 X2onhAMlqsCmwIVe5pAkL4C+FUmwrcH7sO7ly9Uz+/ORWJPbp7EOmOhb5XFK9LOkJp
	 S59ahZ0L6IYng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44743811A72;
	Fri,  2 Oct 2026 21:11:35 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261002155400.661252-1-alexei.starovoitov@gmail.com>
References: <20261002155400.661252-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261002155400.661252-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: de020dc8049bfb2b22e3b6d99c031feb2e22d112
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f150ccedfbd610aa25509ff42365d70fb20478f
Message-Id: <179097549436.3587474.17085696581807915614.pr-tracker-bot@kernel.org>
Date: Fri, 02 Oct 2026 21:11:34 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  2 Oct 2026 15:53:57 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f150ccedfbd610aa25509ff42365d70fb20478f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
