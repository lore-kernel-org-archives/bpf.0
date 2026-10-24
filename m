Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800035;
	b=sBV4cTby4PyVoJFzO30/VUDqJ8+OaxCSqQ2n98L71TzbyFNtTJ+VRpQXCZgraCUOy3ZP
	 XcW4pkPX4Q8PNGFevBWVvZKHopiomm8C9imrVcqtoUbMSUoplFNs2ZLYTJI3SjbjYEzn0
	 D4L4QWmFUzTgSIL89NeBShsNNT84x5Gu5EYE0HHe/500J4V5cjQLSvq0JXVXeQj46IZ6l
	 gHOTQ29PhP7Ppe3MYUV5tSONdR6U6grLabhX0QceKF0Cno7I9XaOTXx+NyLIueakCfPWW
	 GE5qrWjTis/LjwXObA2/JfwVAs3AClwzgHEXDS+UcWlSAEVx0ek3ExAVhKHxAQn+sIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800035;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=REGw816tEEamUVlWNbWxyi2802DVT9MRoRXje0bK5sk=;
	b=GFCNwBylDNWsBWIV8fC0m/BxOvLmq8mqNP5vsf98pYXGMVWUD/lk2IB6s7zjcOjRQ+hZ
	 OrcOIlyiqoeYuZhKEDvnHC2fyzmOVq/APu/z0VbLQ/hCyXE7DHe7geClqS7FfiU730X6S
	 HJW/CpA5CPnMnf6DnHnsWFQmN6dUfyegcLJf6jAx3+fzlngduheSc0hiDxAwI1u/YfkMl
	 xzbu7u1gAUN8faIWmXJ/j4y97Bc8e42JzpR4F1sr28g4l2grCbJVo57Zd06usbrgqzhB4
	 cxB5yHUZuM/uH57Dq4WyDvTyu8tn2ZIsUkddRySrZdO0qaiWjimR3DNIYguZCcnfkdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xphgsepa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD4606A31D
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xphgsepa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2091F01828;
	Sat, 24 Oct 2026 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792800034;
	bh=REGw816tEEamUVlWNbWxyi2802DVT9MRoRXje0bK5sk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XphgsepaP817fNkUG/jilI179q7nnIqSJ+98vsug0U3CBHG/RjA3Mb6s0qLwTo52l
	 KunTlzkHoUSC3dpuEakyIQMApsDAmVfUg8fQ9TBFyhTTSNIt88ghdGBP3dRKwu7qh1
	 pZjq/udPEoISF1C0VHqtzLiAuhTYSxdSs427x5PLglbaRMFq196oHPZBU+1/Ptz1ug
	 NKBtuxK7wdvlx06BY4bWnQf8CCDr+0QUgKfCMvil7l+UGVUjB9Zt/wJQ88FifaHUDq
	 B+aQPw70tE+K/Bh+/w3R0jb1+5TcJPL2vkvVoiU+cLriF0AgCGZB0NkBGENkuGtLp4
	 2EjE359p12ayg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 45731391B16D;
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
Message-Id: <179280003284.1344554.14144093348465192737.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 00:00:32 +0000
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
