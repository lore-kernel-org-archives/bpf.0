Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298583;
	b=C/4qrj1TRRB0SeEaLQB15PUjCQV2HTTwK+2CUQOt4J09ry7FJijT+7DvY4Ft/DqsoQwK
	 zY3EoFMADtx1rIgPA8cOuXfRlGQQGddOJ9FSlvA1Npke+r16dmnGWXEaGojPE1XngmoDP
	 kMP5kGHKZke9UHXlKk5KeX8m94acT2mjMp519t3kwBzysi01zMXhSazB7yY+bKb6MKxBL
	 Dyu5sQzQUJOttPPMPv3rirOtYykgCkUXnQCX7vWIlsKXRE2XCJPQ/E7PVgfBbRzXYjneu
	 LY0lcDN0q6hlE1q8/N3XFixELq3tqTj6JwsLBKpCaH49ap03yler6Tcv7o2dUGqjmDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298583;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=06zW45DUFP/zK/ec9CoMol+2UH3yt/gENlMofm7Ojpk=;
	b=aGbQIAr8wlO2lEtZBYSpg7l7gjIiU/Qy17PH14u5X8edwLK29lV1RKoTprojWNUPV8Nk
	 c4qksW6FcVpLNTdN1c/4+5MiCR9zEY6wq+nr/zMADCWfwPCFmhDlPk5LuN+29b87rrr4b
	 12ILBm2fepUqDbOAlHJkVjLDCxrrOuqoM7+MLcg6/eIc6TW9ve/4W5ySTmHyZy8XMLIsI
	 Js8BSpno7iRjIe5UMdP6A7HSyG2FMSfPOzFproHMg8qYEvZrXX5pwlhHyI0q17s3cKF1V
	 LHhSGGh9qdWjbciD5d1EJOHGSZ55pJnT6WVidnn+axAN/ikGzqs+leKnG0k1mGe1nRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEIiZJD5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E1606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEIiZJD5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879CC1F01816;
	Thu, 29 Oct 2026 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793298582;
	bh=06zW45DUFP/zK/ec9CoMol+2UH3yt/gENlMofm7Ojpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=WEIiZJD5dNmhJJs12y7GuvbLMghCbV+rOqPqAYXYyAx7FaTroAlrBFlfjz4pybhm4
	 fDeH/Xin0JPxQcCcpPjRva5ToVjT4QLxZlk34c3eo4QEINB8IpxpH3hyfIGn3lD8j/
	 JTOHoNMTDoe9R1s6WyfMVtJyg+lTSp/9NB4yIo8wuXJLjlZf4yHOeOLK5xl9TVLsIP
	 kAdsbt7S2qYpIJIOcN73PNNdbQ35dwM7yJHaTFSAVhHEylabMM/HOQHC7uC2ZUIgo+
	 EL8sz/QUaBER7YFkQ6cbLRKVge7j2DTAjEVZ2xWlI5RUQEtF/XNEv83PeET0sSg3cR
	 l2JdQGQ5ZP/vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1FB3808228;
	Thu, 29 Oct 2026 18:29:42 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261029162030.1312952-1-alexei.starovoitov@gmail.com>
References: <20261029162030.1312952-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261029162030.1312952-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: c8a8a68d3ab4a06c8f5a13a8c00275351c8239b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46806af187f448b0d5481f284e7c900a57ee6a6d
Message-Id: <179329858100.621556.15861288667974154869.pr-tracker-bot@kernel.org>
Date: Thu, 29 Oct 2026 18:29:41 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, Alexei Starovoitov <ast@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 29 Oct 2026 16:20:29 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46806af187f448b0d5481f284e7c900a57ee6a6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
