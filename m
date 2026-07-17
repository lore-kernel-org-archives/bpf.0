Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F28175A6C
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319470; cv=none; b=k4xIHNviitd448LmAa39DzNPVZrUU7J+0WeC5seott5yMDXNd6nHWLDYs6bm38a2rvxesryz/qvnIzZ6GZNLTQQWt+cIi4a+G+KOiDMUrbEvfl6DUAw35xx//Wh1kBHLrs2WLp/LSY4qgJCBoL8ZeqBqNNls6kH02XfL9bQKWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319470; c=relaxed/simple;
	bh=H/8aYBE4Dhjo+vXQBNMduioODEsubMx22EWoOVjT4HI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QXgQX+q8ZrndPiv26n3BrVkocFCVAcqYrt4c/6s7W1rxB6xzWUO2zwxgbaS8uSfKIthUB4ESpC4imwVqyjZK6bvZkyo0V/mqnbbtdXNQn2Eer0IlzoKfgjex2vdGoAwTDlV7DjSteB8xS7Zwhzdwn8WjkEqhh4yiE8Qo4UBUxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1VAgoW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1VAgoW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589F31F000E9;
	Fri, 17 Jul 2026 20:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784319469;
	bh=4f4xZPz3CQgvkzxVr3NQWzlnN/mLa8jo9lci51oxpiU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=R1VAgoW33zIeQrzsYm8nl+Q3XbN+O7FOa0xKKrtc8ab/5a6yYQ6HLeWCi3l67mBnO
	 zgCAS0LNhXEKlYtJ0RP+kjqDpQf51g3bMEln0+P55HBGmemVcI4a+LvYO0briCIoAN
	 J2x1vKd2Lo5b9cJ4WX972jrjFO/qT6c+2PXCHc3vB7dXlw8P9xACtSPK/DZZZAjMI4
	 GD/U+BbVixUe9AGlCu9eGEHnY4CWG41p0qSC0tIz7D//JIu7uWGJLBr9M4YE79yMnt
	 D39T9vCFbLRXOAWRpDUFusubEDGE0I5/AcKYSVgXY7b4vm6VOBSzT3z3MNT5S90JcY
	 efQYUNBfDdLNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AC0380CFED;
	Fri, 17 Jul 2026 20:17:22 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260717191356.3513879-1-memxor@gmail.com>
References: <20260717191356.3513879-1-memxor@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260717191356.3513879-1-memxor@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 3d84d674e3a5a33ce5eaa14b92bc839c3821a348
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94515f3a7d4256a5062176b7d6ed0471938cd51a
Message-Id: <178431944140.1854741.6932683056408668620.pr-tracker-bot@kernel.org>
Date: Fri, 17 Jul 2026 20:17:21 +0000
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jul 2026 21:13:56 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94515f3a7d4256a5062176b7d6ed0471938cd51a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
