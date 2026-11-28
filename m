Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834621;
	b=WgiYyfTQhkOPeW9IIL10IRdUTD63WWoQY2tAYCRCAtfCd6O6IxyzspS4u7KqTRrb+9Sm
	 MAdy/e1jsWf+oRBIt3E93YCIgZ1y4AgW72Ux8uH27zmUaJDr/fqyt/SeFVOSClOIzo8rz
	 XrQG/3gleYg2BMAHO8x4E4TvHsp2if7B9M3KlmDe6CK53CfdKT2fGRGmqu9OmplxA/NFX
	 1UPUo+Aq09i0agMsuop2XCcUnNzqQMu5oOVjZDDs3Z6oN7IuJr1NfV+3SI6BnRjMxaqRr
	 EsChfi6QRYbT3stI8nLrixbTkcd1q2rqieiVE6/MmSFdEp7IKs+9Ay/5Fxjiz2K7L4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834621;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=qbs+rWD6ZLzeLwdeSDt8LUN672KwkY6NBBgfahMnpA4=;
	b=wnZwjcWv4lpoY9rQZ/xWJ9FXL3IHUpPtXkAn24VylaWshqlFp37kGpFB+jp9Hro2bhU6
	 rqMMSjM1QnnFCQjCnwKSaNH0wGDKXoaPyBlHavcbV/QEbmqW2rqYFbzMRmAzGUSSYzRlY
	 EHqsFgHXQXybq+0G3Zuqhfbn/6ibUR7t8fDb3JkMenTRKQGuTVdv0MVMJlAtNmBym3feo
	 3y68U1KVehsvlc2Xpiob7bbEq051tpDTGSZPMhGMBliP77xXGWsOFT9iU1RFdJE/hWASv
	 9ZgGe2dnfdAvYIp6bLnw9/osukM0DEYWiY0uJbvY0mmiJSQq5VL1j5OdL0chiQUh+/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV9mgI3t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF23606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV9mgI3t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0302D1F00893;
	Sat, 28 Nov 2026 02:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795834621;
	bh=qbs+rWD6ZLzeLwdeSDt8LUN672KwkY6NBBgfahMnpA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PV9mgI3tmqxk+ZSKJRmAFAdTxpKRnONslbwuRP4tVKZk2/Y1rhARSlqDcGpqz7vcP
	 aoqF3kTlbZBV6VZg9DzsoFrTYoWKw6GCFS2Xt2GVM2zl4aONBwuZiWhrNSjC7zaj4F
	 ZcZbpG4GE3whs7xCumNiWgmj8GIy05l4hwe3jnoV8uHqDU2La8pUtdIe3dAAZGPlfe
	 jFZGRO4TwgTsseTEdCXCaliLfebyzEiejy2F/A8JCDg2jf0lsWBSkPK675L9ED4j4H
	 1y4tkdarVKLsNaLPqbbnUu/TlEltSVkqaco8rxInTodwHDUe82tWHfxy1TFp9qYqbI
	 4SQup3CyX1Wjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB85D392707B;
	Sat, 28 Nov 2026 02:57:00 +0000 (UTC)
Subject: Re: [GIT PULL] BPF fixes for 7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261127224422.3451200-1-alexei.starovoitov@gmail.com>
References: <20261127224422.3451200-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261127224422.3451200-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes
X-PR-Tracked-Commit-Id: 02d3452bdd80cf645694110128db2ed67da96490
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3a5ea8a82fabeb2314700c2e001130faf99df1f
Message-Id: <179583461943.1775590.7408750363152246857.pr-tracker-bot@kernel.org>
Date: Sat, 28 Nov 2026 02:56:59 +0000
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

The pull request you sent on Fri, 27 Nov 2026 22:44:22 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3a5ea8a82fabeb2314700c2e001130faf99df1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
