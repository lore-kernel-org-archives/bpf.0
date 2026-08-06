Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A3494802;
	Thu,  6 Aug 2026 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045248; cv=none; b=MQf66BoTVUDOEDRqpqmAdN3v6/zTe8OmD+XT+xliV4aGFCmUW3biBOijOWwrqdIxsRe5muA/40UzgqDjQKX+MItg1/ivtfiDgYlFSrboFDGfZOun1Bm8ehPXa361ZeQBSZsFnyOMHeApgmTyoqrD7HrYyJZ/K2O9hv2Ih0fK0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045248; c=relaxed/simple;
	bh=k+tUT7lpqCoLp08simO+a9IkTR+URcLxCvdpkLbrsCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NIp7zVT6YZ6lGRiC4MmYhLCx6sBYi3nEO4ZhEc3ZUvT2qaJZS1GsI8NNP9kxUsXoPfRVEKQHxwM6RLoxJ616a78/EpHP5BaGYzKAtbIOs4qnsWHyg3hIHh2x39qfc8RVMgvEuQVeKcoq+KqKoATb9/MZybSQmE4QsYLsyZiWmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XasFs6rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XasFs6rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E21F000E9;
	Thu,  6 Aug 2026 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786045246;
	bh=9OlunGY6evHzMTZhD21YtSX+v5/awnb4KeVwjJAxNKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XasFs6rdjHRm+rmonAkv8j33T+ovaBBKWbRy13MSssggCr7FyEjEpTT8r3J7aER2z
	 DihqHpafhR871vUTNcI8HxiWrlN1X+tzEmvpHNni9Yml8iZA4XtC/qeVqSM14KNVOu
	 qdbOli5Y2T3b07bgLrHqIXM1Nuen0T4BCPnRAvz+5kXRN6DYlAsnibAophHDd3LZ6h
	 /kZtva/+betwE1Ms8zfmnII/svIAsmrWLlUq9LdkmU3ThxZfZwdPycKd4gOzKEJXpY
	 c1RFVmPzyJCgujJzW52HAS939zemcYs/EywSgmmlR/jD1OMfpqs+BtLGuSKzt3phEc
	 ajC2anULgUGvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C63809A29;
	Thu,  6 Aug 2026 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active
 connect path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178604520590.1446418.17755776050398529654.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 19:40:05 +0000
References: <20260730220055.2946171-1-tejasbirajdar@meta.com>
In-Reply-To: <20260730220055.2946171-1-tejasbirajdar@meta.com>
To: Tejas Birajdar <tejasbirajdar@meta.com>
Cc: edumazet@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, dsahern@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 15:00:55 -0700 you wrote:
> BPF_SOCK_OPS_RWND_INIT lets a sockops BPF program pick the initial TCP
> receive window, e.g. to advertise a larger window up front in environments
> where that is known to be safe. Today it is only effective for the passive
> (listener) side; on the active (connect) side the value is computed and
> then silently discarded.
> 
> On the passive path tcp_openreq_init_rwin() inflates full_space when the
> program returns a non-zero window, so tcp_select_initial_window() can offer
> it:
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
    https://git.kernel.org/netdev/net-next/c/ca10634ebcca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


