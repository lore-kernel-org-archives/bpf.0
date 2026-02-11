Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89423BD02
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842477; cv=none; b=DZA6rsNYmqun2VoeuQq2gk3mEONcUmk+4kOJYqt93h6bS2qSm7AmazEEXfq3xI5mISMACkxMeZbnmINNcXaRle/vbhyiNiXhibnZaHcFwo0hloo1Um0wYiSUb6tG3i+6qP7X0Tl8TrA7bEDKtz97ixu+p15XsUb3ewup+U4NjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842477; c=relaxed/simple;
	bh=eN5IH+Nl1N2wqlzj74v+TF2bJuacRJIc6dIqMPwHPbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KhYFTvKmiZSZjJ/QpBLHGdP1ygpr8zQ6QGe5/lDMBGjEUtwzeHfUk6xaEAtNvxTI1TuCxJdvBIfkQV0CTEBNt9UpurXwmJeZQ8R9XiYFuDu0KGLReIPFAPoeSvj4cOvJ6JBSpnGCwg7CLtsXYxAiERQfijpy/HFn28Pbivi+ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKCBM0Uq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKCBM0Uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13948C4CEF7;
	Wed, 11 Feb 2026 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770842477;
	bh=eN5IH+Nl1N2wqlzj74v+TF2bJuacRJIc6dIqMPwHPbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nKCBM0UqJZv8abdo3DuI+k+6fdfFbxxQabPjzJpU/cEfZmvSvBoX9iVw0KBMIOjBq
	 eksWoJ3fPqbLxcDPKMcQZAU8NEhAuJwofKgJNGFCXEORbP5Kjc+pyRAqw08ivAzC05
	 ypNNDWoHduBMq0VDqCTkU6Mhm6RNZwtZAz5qPii6IGqrG2o8U91mzwyXfVS7wu31iN
	 ZlWPV4AQnkXtLFixvlplzKsjTZkjz/tTG8kvIVlHG3QkdXSKxOpVUi65UMo4T7mR4Q
	 5Vftgm/IZUoBtRay8aPMJhUam3mtaTskoueaaVWJ0aAf9XXZthMiDZMH5D1WSu2f2h
	 xIRNFiZRCsd4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B32039EF964;
	Wed, 11 Feb 2026 20:41:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: migrate align.c tests to
 test_loader framework
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177084247189.712221.12630954972277493827.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 20:41:11 +0000
References: <20260211051310.2782558-1-eddyz87@gmail.com>
In-Reply-To: <20260211051310.2782558-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Feb 2026 21:13:10 -0800 you wrote:
> While working on pointer tracking changes I found it necessary to
> update expected log messages in align.c series of tests.
> As a preliminary step, migrate these tests to test_loader framework.
> 
> The tests in question load BPF program and check if expected log is
> produced, the log is specified as:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: migrate align.c tests to test_loader framework
    https://git.kernel.org/bpf/bpf-next/c/4475cdac12c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


