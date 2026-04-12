Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B55189B84
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775972598; cv=none; b=EvvVkzmTXB/rHxK1ol6i5gDdVVttiCOVtiFYE4SJAuhtqRFO90/JQJcc5+5god3CF4HLcMLJrbh9J5V4zq6on7CkQE/4UWa3Suym9MBoIIJCvSkE/wn8gz9ec1xg5g8M9hPTQYNtd2i3lP71XVpqcCE1rEUfTmwZmgVVyyI2bRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775972598; c=relaxed/simple;
	bh=HSihEDGBA2TtCxy5BWQ8ZQKZxvnY0azXq6JcobsZCGw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dAuIyg4hv6fA3WvsFqHxKdqtk8j9mLnE7aOoipWpKjOdSK2+ZjfLuRVN3CwET2JaGz7zl5rS+vNCmWXISd7AXf9mz0k7wE0KIgi0EFXyDs387+Hy+pl3TarhROFYUKQuwM0NC61bMbf3s0QC4X6kp8vNFM8cEi+dtbXhLPfj3oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu3aXRo5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu3aXRo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58D4C19424;
	Sun, 12 Apr 2026 05:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775972598;
	bh=HSihEDGBA2TtCxy5BWQ8ZQKZxvnY0azXq6JcobsZCGw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Pu3aXRo57lrGhUq7jOkgwPW1e6v6NimbkPSi6pi7gHuyDHYxV5QDbH7OE1/iF+GDN
	 gdw4F2ZDHEviZ8E146Dt8M8Qiy1HW60ZPG2owo6FTTW+cN9KEMKy9KjPekOjCbXkgf
	 X3/1jMgKX0nv0nI8PNh59DHQhhTsKlBBgdI31C60iC7LYsWEuIp6534UtK71GaN1aC
	 +e6qE2vGXk0J5H6peLIpzh5smO4Kb0HHCTnGKEpE7YxAx8kwPYrwSnsTRsClyYeCZ3
	 TYHAptN5pli28YLZNshDz4Avj7eAthZK3hSm3JE9m7saLT3wnHaEKy1/KBoPjvVVJJ
	 rMhhCVKPTvztg==
Content-Type: multipart/mixed; boundary="===============7629351356186455603=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f163dcbf46e9511eba14b22ed10467984bda3bf07a3d1bd6cd27ae14eadc2056@mail.kernel.org>
In-Reply-To: <20260412050010.266625-1-yonghong.song@linux.dev>
References: <20260412050010.266625-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 12/18] bpf: Reject stack arguments if tail call reachable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:43:17 +0000 (UTC)

--===============7629351356186455603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Tailcalls are been deprecated. So reject stack arguments
> if tail call is in the way.

The commit message has a grammar issue ("are been" should probably
be "have been" or "are being"), but more importantly, is the claim
that tail calls are deprecated accurate?

Looking at the mailing list discussion on the v1 series, Alexei's
guidance was "let's disallow mixing 6+ args and tailcalls" due to
stack frame layout incompatibility, not because tail calls are being
deprecated.

Could the commit message more precisely describe the actual
reason for the restriction?  Something along the lines of "tail
calls and stack arguments require incompatible stack frame
handling" would better explain to future readers why the
combination is rejected.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============7629351356186455603==--
