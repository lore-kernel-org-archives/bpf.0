Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41027FB18;
	Fri, 10 Jul 2026 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677655; cv=none; b=JDH5UmBsL6xZpM/V1Ank7vQDZU4JtzMkahOxMLq+Kaa6u+/cWtvA0z7sCo/RXyFpY9jqpRlBmAnULz1QLSu8SKJPw1wYvoSjSRwfg4L95l4zRGFaokyBKBVId5vk7GrkR1yGr+VUxIY9/6iu2e5Fo9IpR8lzMdpO4c8oBYLhPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677655; c=relaxed/simple;
	bh=EtmPUHcRvdHeZmHMBbKSfuWvPQbB2lI+zq2exzqfSno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AuFgimRQbXdG4pZ2Ar8rllpdDOriXq6Bv8wLDkDFO36ZqQp8O91Nx4fHqyw7+O3TW8djb7r5FerJWIPNiADL4Ycr2f5mMVW36m7yUk+NrxweeIkI1KSEcRCHWcp7QDqcl4FktJIVfifblPMnriXOuRcfXYh4Bord5IaOVr2A3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjXm91pO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjXm91pO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334871F000E9;
	Fri, 10 Jul 2026 10:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677654;
	bh=HzPqK4xMTB2qqBgyyqGaAQo0knBfJ2oc1EJuW1FOnNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gjXm91pOJcwSsl/qH4F4fQ0psvb8fmy5DPplFFcGeTJoJjp/zc5dTyDac0bTBML7R
	 ELopZ/rio8QX3XRU43v9Yh0G+HZn+xXWTgdUId4HQvfIQeyhYSGz9nGUpQQg7tE8t0
	 Eq/0K2slsxuu1F05ZtbnguDNgltxYrDhD8YepC54WA4+zNjdqBBL709mDlgIf8IRyE
	 Rr7gXgwXJ6V5oZoO1e0iHw/eK3FxqN+JSvxfd65nRzNwNFBkiMXs3jY7adVOn5OB/T
	 e14JuwTAs6VUwtvzJ4zOST/NL25kUhJ+As05gvyXLvZQTzF/aFe8ZWDI0K6FHZMi64
	 w/58Em2bf0QnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 60E903924A7B;
	Fri, 10 Jul 2026 10:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v11 0/5] bpf: add icmp_send kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178367763213.156295.1145469306231918635.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 10:00:32 +0000
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io,
 martin.lau@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
 netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org,
 sdf.kernel@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  9 Jul 2026 14:48:55 +0000 you wrote:
> Hello,
> 
> This is v11 of adding the icmp_send kfunc, as suggested during
> LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
> actively reject east-west traffic, similarly to what is possible to do
> with netfilter reject target. Applications can receive early feedback
> that something went wrong during the TCP handshake.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v11,1/5] bpf: add bpf_icmp_send kfunc
    (no matching commit)
  - [bpf-next,v11,2/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
    https://git.kernel.org/bpf/bpf-next/c/39b337a3d995
  - [bpf-next,v11,3/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
    (no matching commit)
  - [bpf-next,v11,4/5] selftests/bpf: add bpf_icmp_send recursion test
    (no matching commit)
  - [bpf-next,v11,5/5] selftests/bpf: add bpf_icmp_send no route test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


