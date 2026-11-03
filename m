Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724793;
	b=HL5cWN1i9zgLeWDKEYqkO45KaqteNEAoQybea2+8kMFUMpWxMRNbALkK2agIAjIW4+ei
	 1guZgvOOqL+cUGYx0jUbpybWqgoJktJ1DyR6tSLcR9EOg7yOjo1EQlmMNN/Pz/i26SqcU
	 AxsFHmQYGwdWrSo690n+zGAt1ZtT+HaQpR2MuN8iAZPam8/lrSwUsSoHaKo5eZzziyo5l
	 Bw/CUYNewKNcyBXAdjmCCUlbcvfJn7dLy89/SfAk0IPMs2ZaQT++y6uV+wOHYTDIYaMUJ
	 bIhpCh0cJEOI2RAxz5MemVii2cRg6WWPOZCKZiwstnlywgTEIIlW+4kexnjJ4LGeCKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724793;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Epw7LFSI+Vc1KBCqkZx2Tdj/yQ1FCu7g5ChBWY3RbUk=;
	b=Pqy/WZTzHSeUjnmbCPdVIRzVZxU0PIaCnDZxNzYok2ak0m6ktcAKs0HRox7s1ej6CLkW
	 ZyLXqR3LEZS7m0wmzu6KmJRVWKmgIVj+C+KAsgWXwpS3Twl00H8sG84KcWhz9/nrnEgID
	 rOyo5PRp8jwKU3PdasHk5UhKN1pG/h4ugcsZ/XwBlndVgDA0NpRkdhJLnLgWPr8W70nlR
	 vB4xlwJnqqTUn6BwBlxlvhOAPJDJ72m/Ea1Us7PInZHoX3sQINxLlf9HjWSvrZ58bkH9d
	 IUUcdqRqDlK0JMhLMLQ8fAzb8M4LTf6BvFBiX8Ty+eX/k7CqaeVFOAFrEdDBVYHFAsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4Q3XAV2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B99606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4Q3XAV2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52D91F000C1;
	Tue,  3 Nov 2026 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724792;
	bh=Epw7LFSI+Vc1KBCqkZx2Tdj/yQ1FCu7g5ChBWY3RbUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=j4Q3XAV2e0LWfxTzhjK7X0tx6yXFNMaCu1k3Iw6M3B9WrRzpey7KjGuWFlMIUo7mx
	 4TVzFZyDPye37vMsMr6IUkX6OcQw47DFd+cWrPRnWJ9sU82qGai/Yf6nS5kDgdE6K+
	 jVlpG2dwZUnNZdWnyVxRvVX6TxF/VzOHCkXx0+vbjCPuFP3vUq9n0xS9WVgg1iV9lU
	 jaJP5PtR61gDYC8ZMyR98vsN40pRRGFfYaPf77eHca10VEZjf0y1nAoH1XwptkTasY
	 h3MrhcBi6TV6xFpqtmL+sC+HKOVGDy35Fq3Ol4ucTtE3SlwQ7YMdfoOitItXNVzYmZ
	 YJqsFDDhneVLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA4C3391AFFF;
	Tue,  3 Nov 2026 16:53:12 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261102233400.1941543-1-alexei.starovoitov@gmail.com>
References: <20261102233400.1941543-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261102233400.1941543-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 9abe2c42ecab6c86b54838d2d645ca2e10204606
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4da531b171c664a6cf42c5b82d1610cbdf14fe4
Message-Id: <179372479120.1755341.153490011186531245.pr-tracker-bot@kernel.org>
Date: Tue, 03 Nov 2026 16:53:11 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon,  2 Nov 2026 23:34:00 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4da531b171c664a6cf42c5b82d1610cbdf14fe4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
