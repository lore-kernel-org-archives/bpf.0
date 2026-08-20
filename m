Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF147DFBF
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240517; cv=none; b=eA+G2blvRf9mBsI1YjSvRFQhVUBmF75f22xbZUt3LCDBwpi/b7/iyAEpWEMz2C8lsK3pJGgrxYD3kJ+sABdpe8SfW/xHuwXNjxfTxwl7VuoT5ZyrqKu0R5NWqb/v3LeWo1DqzQKY+wNZ2ThbfK2yj36RRzFBUTNj5t46CS2lTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240517; c=relaxed/simple;
	bh=qp63Sx44pioLtUlXrFllptm03qTWR3NdqLVKkggEOmw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D11Gnw8Ajy/9Tllnz0XwFwlOfrsbI8AeI1/oOFBeGN8qsQS0ZcpwyCyb9MMBhRK4in8od6zLdysTcC0q17X8Mztdo3x1rv39NXuGc/bn8EP9bVJCkuv0BGbvN3K4pEf+T/YETzy1i/jmLh/RNFcq3kRvqlBp+J3uXuHiwftQSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS/qz92d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS/qz92d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF51B1F00ACF;
	Thu, 20 Aug 2026 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240513;
	bh=3NGQgV9KfvJRxXbnCZPnCLh3mbjvyrE2KK8Rp1sfC9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kS/qz92dW/1CzLYuFj5QDM4xeKELDqrxwyleT5Eut2QwahkLW69UqJoLOQkWObaGn
	 iMPw5oOcWcX7iNVsP4wsBMGIVtQQPG6gpKlGpzKM2TuyYso/gfcq0QuPSI158DiXEU
	 CDzfoLA+/weO/qW9tf/kxlAlX8xF9E9M+sWY5BRHFE9iye6uLsYudJVMq68CRTqGLU
	 qq4qmU4ZFJnFBN15A2Q5qL5TliR0G6gRQJvgiaSZyFGk4oE0/GWZwc61CN5WRKwsJx
	 hNH3baUPz2bJ3XM1oRzz032zEssRXSTGF9c20yPhPn09mEnYWiQmQwA47S+KEZ/2fu
	 y7sww2TRcyl3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42F913812FD7;
	Thu, 20 Aug 2026 15:41:05 +0000 (UTC)
Subject: Re: [GIT PULL] BPF changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260817212624.902049-1-daniel@iogearbox.net>
References: <20260817212624.902049-1-daniel@iogearbox.net>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260817212624.902049-1-daniel@iogearbox.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.3
X-PR-Tracked-Commit-Id: f79066c784022fda83f5936559a1af414e41b603
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a8cd539ac19f7a68e68e1d25ef9ca2ff55b8500
Message-Id: <178724046388.314069.3195244378553017180.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 15:41:03 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 23:26:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a8cd539ac19f7a68e68e1d25ef9ca2ff55b8500

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
