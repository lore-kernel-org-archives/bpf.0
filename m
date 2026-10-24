Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800034;
	b=BxkNoeYGV8vsqAqmWoe1j9fcFAblIJ3sYj2wtyJD63kOo+7WMbvsomM/yDVKaBya+H45
	 TcWJCB3N/ZB0+GLwUI3ilonvqMQ3Z83ZqKpJu8qJIUy0hulFSwlYw3zm5jyZERVOXaE6o
	 GwK4s1nCR0e89pMSSszUY632Pb22e0Wwgj8dhStxBPJQI+5STkmg3I/jl5HdIgRtM+cLA
	 bDvSMmysdOIbdKF8Su+TU7yDgLmit61OmsGEm4vyKLLWzmeDTNWTadxs1CbUNQIYhTTBr
	 hKscET1hxVXsW5Gn0xsIZaEVT7Mou4V5qcUBBaqXDA1q95E4+5kJ1tlu6hhuMcVuMjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800034;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=REGw816tEEamUVlWNbWxyi2802DVT9MRoRXje0bK5sk=;
	b=bfD4A3Fd3vViRtE/H+Oi7AX5bNV2mce9DJcyaKdP6jEO43l6Sz07/CwbtZUnwf4kC64+
	 b+IWutvTvFvGQOpnXN/c1Ny02H4N3RTOLT5pEbjdM/pBnCX/b5GruEu7hpgBiEkrJ/ebD
	 Bzzj0xKPZ/PfixNOHEYpMv5IMPnpGJIqletsjmA37fa9faRNstl7H+FrRnuaV5UOpV+M/
	 6Louf7brLC9/zNgjbG1EvTyHpGNsCAPzSj5bVf0j4zi9aZv7y01tq7Y2v4hWlv3CgnfGo
	 vD3JFyL1lzailbAqFIAyWtC90siIlkfkY4djP52bMumoU+/ECAhvm4OgjNgQpEevgCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXtlTKHT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8F606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXtlTKHT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571F91F01825;
	Sat, 24 Oct 2026 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792800034;
	bh=REGw816tEEamUVlWNbWxyi2802DVT9MRoRXje0bK5sk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=jXtlTKHTNWeqIRCa+BXhboOcCqWnhT7VAZ056V4CoyAZoIQCpMEkZH9N3ynnm9uI4
	 vlCHSTANxvxKbQrs+X997Rb45Sgp1asGgpQIYWdams619PTUWJ+2klb4vRhe5ANyP/
	 hXIcipt0Wkbl2YJz9GQj5oOmpVObJhx0JIeoR88xBIgdehpC3PYICc98+CHPTesvZw
	 9kxnVbn0njZvX/K1zfdm1I4/xMQpnsZPbn5gkHi9PoTaLHdG/EvnMCPTWp6XQ9FsGP
	 4AWmo+X9C68ZehMFPizGV0vfPY+oFQOhhHq16wrCW3DpHHuuQ3LzysN7c9z6hpseWa
	 Z6h3n83kFdOFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4461D391B16C;
	Sat, 24 Oct 2026 00:00:34 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.4
X-PR-Tracked-Commit-Id: b116ac6087541d3d98031e786adbe9c733cd6df3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55fbedcec622a943cb09a969aef1ddcba87ee40a
Message-Id: <179280003328.1343641.10134281535989457172.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 00:00:33 +0000
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

The pull request you sent on Wed, 21 Oct 2026 21:01:45 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55fbedcec622a943cb09a969aef1ddcba87ee40a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
