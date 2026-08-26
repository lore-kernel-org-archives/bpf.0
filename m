Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08A403B1B
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762483; cv=none; b=E4yBi8d5FAcCXtyi9Oin2/fRA4jEUqZqb/7RGCvrmzk+oJZt/XA/gwPqme9946GJU0qASiFKtUyMwRmxo0MeS+mEyfD1pnYkP6otgkP5ST9CzwfZP5Qe8/qo4Wx1+6stSUxH3jy14hFigJYkvR2I44eJdwQocyUfy+n9fb2xmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762483; c=relaxed/simple;
	bh=JU3illwzGW16EHi6lmzgZqSDsq029j4ZWxi7pit4dYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXgp2RrE7crMdmp5AvYGEIoeICPbO80GTx4qk30QMU/UhWWzO8+u3guRirZsk8pxTLr5mV4IqgjHH5T0+y4TAR3RJrLYxVsQr8et4ERJtePtYjZz2M9/NxVKvpdYGhLM30MFM7VblhPwP1cEGOnQEEGDAm6/UVApOFhTsu+rklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTc58BYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTc58BYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A331F00A3A;
	Wed, 26 Aug 2026 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787762462;
	bh=zcq/9JXZzbTbEVQS9y/s7Y3eKAZJ8U0sHlPsTj/Rs/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lTc58BYCKlmYmdd9XG5Rgf3rzC3pOxuofSMUXjer5vC9S6LgK0atuW2TshMOiQAMH
	 O+HMRWIqVfmQKN3ayRibSyDtEu+c1Xf222jYqelJGzo1S8hftBGXhijTb7NfsTXlbu
	 1rmK+MBvzmn+6GqAM7ZK6ovm2ONivYJeJvxah+zNbHKfQAHgD7RWLktBaEMT6wa9BP
	 e5tyJbuffDRC0bKFu4m3HBwM/Pu5dFri0+ONZdlbawJSMdE8tj0u+YeLL+Br9VTkah
	 dLkhvzzw0pjxURb8ENcEVzOFE90IB8Cj2pOStvhIZ3IqPX3e3jMZc+VHKdNf0LlQdZ
	 ENvEmL9YhXr8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA7380820D;
	Wed, 26 Aug 2026 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: unblock bpf-gcc test
 coverage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178776240864.752663.6336517424647128260.git-patchwork-notify@kernel.org>
Date: Wed, 26 Aug 2026 16:40:08 +0000
References: <20260824210142.3933580-1-vineet.gupta@linux.dev>
In-Reply-To: <20260824210142.3933580-1-vineet.gupta@linux.dev>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 24 Aug 2026 14:01:39 -0700 you wrote:
> When doing some unrelated testing, stumbled upon this. A lot of tests
> are skipped under BPF_GCC due to clang only gate. On top, the test
> harness declares them passing/OK.
> 
> Patch 1 renames a few placeholders a consistent dummy_test name [NFC].
> 
> A sample test with BPF_GCC used to say:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] selftests/bpf: name the remaining placeholder programs dummy_test [NFC]
    https://git.kernel.org/bpf/bpf-next/c/b0eeb9e0f548
  - [bpf-next,v2,2/3] selftests/bpf: report placeholder tests as SKIP, not OK
    https://git.kernel.org/bpf/bpf-next/c/8928f5ffdb65
  - [bpf-next,v2,3/3] selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-gcc
    https://git.kernel.org/bpf/bpf-next/c/48b69cc8825d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


