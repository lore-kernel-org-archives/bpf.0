Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795228698;
	b=N5jZ4kP553p8ZMDqYLG0oGKx1C8nZKaCkj3dhfkRusL5TCeLgUzxePsKpYE4Cndrh5o2
	 M9mA6PX3Cmgb03C0yRnCcBUSFsm+pfOccw7APHJHuZher5F3Z2t+lz2JpQeytKrQrnquf
	 0PjqSvROcZULH2CEGg28HBBVih1YVQHZwFepIYiuZiX7sk4V61k1btzVxbDaXGfuNTAqz
	 pNv6BbHIQ4tyjGsDX8ruAdfTDSwrMUC75ldsDheTZHz6jZUOONa5J5s9qCzafuLCKlVXc
	 egCu3fhJpPP+z4PjMLNgzv4DHK1VvP2Jewg5zSNtPu6g5buCsfOoIvjF6nS7Z2EdoUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795228698;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=/7vS8PV+sgmDZ9BX3F8Q1JOIebzvqtIHGiXyF9KwyBo=;
	b=BWgCKtvPz9u1+BWBH1ffZ/b82W9t33vFs1XitlbYNURMXISH4g95hVQtXe6w+K5Ln7On
	 tbVhd8yGOU/np8pZrCTnoAmdr0d4j8CwuY5D4IZj7350wRm7T6EmFQPkYIIZuvWASLMXp
	 4I0hEfb3SCGcVAT/pelNncPFMkEmyKHOxvJKt1++T/z6WnFjX/eh8EBMTjXoZbGgQ5Ne7
	 SBwU2nSlUH6YL7Il2XxpL24e2dQ/sSpPC0LLv0+MwPpLFwebuEU7Qpy94KZCZUjtoiYse
	 oZChg+P6Kov4zNYQUeqdyvb2Ic0wlr54aM3tY5u4WqNAYMFJTDOz9y8tWMZ9BqhU/gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EadYAF18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76740606A33B
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EadYAF18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0574A1F000C4;
	Sat, 21 Nov 2026 02:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795228698;
	bh=/7vS8PV+sgmDZ9BX3F8Q1JOIebzvqtIHGiXyF9KwyBo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EadYAF18c09bsWdBrnpiN0fUnGcfbSAlU0j4iQRGMhH3UYVLpQiY/WGwRxD12Imxr
	 TscmU9PRj9ZoCtNdskfGCsgm51TyZbOMl4FikdpOlnsTFtOrHZBGv27zfSGOBQAj1q
	 yssrG9P/f+XmwAfwc4Z22pE4iFXlUoCpoYrXo7k23R/0k4p8whRLrnTB9tHU2ZKUeh
	 V4h+g7YfCXcoady1UceEiPBhR8Wur1gwKXk572HlwBjJNvF16c2aQNdV+BME3a9nfP
	 S2K+DxWHuhsUBqjQ8gsQOUqUyjXMrf9NKj/HAeKA6VryZQyQTqfqQBHeWOHIU4aofD
	 ZoRKEWL4mD4Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1536380AAFE;
	Sat, 21 Nov 2026 02:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261120200948.532961-1-alexei.starovoitov@gmail.com>
References: <20261120200948.532961-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261120200948.532961-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: d5ba86298b45e1a81c578c499e9a222a3b734d5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84afebd853437e44cb71f718be11d90e4c1a59dd
Message-Id: <179522869665.895295.4778661675306699989.pr-tracker-bot@kernel.org>
Date: Sat, 21 Nov 2026 02:38:16 +0000
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

The pull request you sent on Fri, 20 Nov 2026 20:09:48 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84afebd853437e44cb71f718be11d90e4c1a59dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
