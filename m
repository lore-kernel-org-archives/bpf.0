Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025572DB794
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998624; cv=none; b=WmxPUp5hbtMvxHOQfJaX9LKcOmil8RjqukFd64mWk6/hloKo9cA6oG9y76JnY05BtpsdmT321HNEOP6qjzsW4zUlO7ggHwBgiD3zg0lQskdgsVuDHVymyXZF4ZQKz5Hd+zFMaKIIgSFKlqaaKEoOmSznL1uT0C9H86tglPjPH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998624; c=relaxed/simple;
	bh=1Uju1j0ZYe/C4L7kG3eN/4isbe3UeeYCxhjEPdpgYw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DYny5wfzbDpQsK/IYQ55mwml4eHLxF2887jj9LFE1NsJgzQ+59C8b7dnNThun4GlpPZ71/ogTl9O5sVxqpduLahccyMXsiKEXH2ZU5roSshtslXFuUsttAyfWK4P9frKBNVeY2+KRjqES0WaS0Wj4qKPaGJRs8oH3PV4XTs5jgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+VMs2TQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+VMs2TQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D1FC19423;
	Tue, 31 Mar 2026 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774998623;
	bh=1Uju1j0ZYe/C4L7kG3eN/4isbe3UeeYCxhjEPdpgYw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A+VMs2TQ1GseatmBRA1eqJbiEaPEINxQkxD8WrjvkywGaDZ6e4qyw5ND0Un/JQ++D
	 GHO3yvPmFhUzSSg9PHqDxwJRpO7h9br6jZ4fssdjiCYlVHdxrQIkKHbTvXhSb+ZyKG
	 ShTIjyLR5IMh7U1LTBhIIvAhW2K/YhLAXqQAYSlvTKdg6AMU8Ko5VWXgvWRFvk/ouO
	 +anHqk56vv6ZCkREIsttgny/eZO/rEk1TeE6wU2XXfmLvoRmtCBw1tpNEgbPFo5jMo
	 AUQtXJ0N9vg3aP8TF3CTLd8gm+9VTgmFp0xNgTiHD5A3B/6EsLKqvswjSx8kmzsiSq
	 VZIBoE5SydLoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD203808203;
	Tue, 31 Mar 2026 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/1] Fix bpf_link grace period wait for tracepoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177499860704.2983413.11566673938472181354.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 23:10:07 +0000
References: <20260331211021.1632902-1-memxor@gmail.com>
In-Reply-To: <20260331211021.1632902-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 paulmck@kernel.org, rostedt@goodmis.org, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 31 Mar 2026 23:10:19 +0200 you wrote:
> A recent change to non-faultable tracepoints switched from
> preempt-disabled critical sections to SRCU-fast, which breaks
> assumptions in the bpf_link_free() path. Use call_srcu() to fix the
> breakage.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/1] bpf: Fix grace period wait for tracepoint bpf_link
    https://git.kernel.org/bpf/bpf/c/c76fef7dcd93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


