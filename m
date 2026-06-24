Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD82F2914;
	Wed, 24 Jun 2026 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267665; cv=none; b=nOoIg90Zd+71ZzGsa+DZi8zInpmtw8CsbSVtH8S/oKMpIkpKg7wrfU1Tm2nBku9qbMldhy9xKuv4KCw3F3Stvc8X5sTgFhRvcpQu7snsHTPB0AL1TXiX+KEUNBa5+K83WZ0Jlcifv+vEtIKGtcVbHogWyQQbRIjpniTAdUnSbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267665; c=relaxed/simple;
	bh=P1SHEf+r9SqlcUKpE8vQ01ZlsQni2HvTEtqnTXGC2BY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H6/7/UqFYomBM5hdReInhKwYuMG067FO3xyrU2Ygzjjm76+U5KykKkLWmmYU902Nx+ayci4nmm7KInuzjZyzBK37cACUoeRl7wHKTOSV5pi34VFCLnUGodpI/rrLFiYl+Wl/qaLb8rMm8e99Nb+76b+OQd8otPWxbg6XqTnf9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlsPwXxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlsPwXxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DBA1F00A3E;
	Wed, 24 Jun 2026 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267664;
	bh=NxS9mrbKP726fs85ikjFZCarnEtd8bEGD4HrcC6GGO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XlsPwXxThQeXdwZpdadscet/WYdP3B3CGlbNz6zk9UowKlgHV2Tv5C8mz0wswkXmx
	 UThZFklbWI2L4I+DqMYcbyvPtDcmum2Nv18Ptfj0QyWrNkyz4EyoHsJbBh1oodHN6B
	 nz0aPB2yWy++MKlJ+Xlm2xzakGTlCYhcC2cvOnDoXFM2TPWi6r8pbNA/BwQfovNjGR
	 YLERWHK25HEJSArpvilkFhkCRm1pcn5dwNsi7h0kJO5+IJc2yfXrMHKZmfvLVwSfIE
	 EOGWIrMHBb112eGXQpcSu1soojU5Ego3Mk6+uz9cJMrnl1E2+gMgGW9JLKUtcnafC1
	 y0XKuv8y7gmrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B28393102A;
	Wed, 24 Jun 2026 02:20:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] Drop skb metadata before LWT encapsulation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226765332.2513445.486200797204394073.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:53 +0000
References: 
 <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
In-Reply-To: 
 <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 19:09:27 +0200 you wrote:
> See description for patch 1.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Changes in v3:
> - Clear metadata for non-BPF LWT encaps as well (Sashiko)
> - Add selftests for LWT encap + XDP metadata
> - Link to v2: https://lore.kernel.org/r/20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: lwtunnel: Drop skb metadata before LWT encapsulation
    https://git.kernel.org/netdev/net/c/c00320b0e355
  - [net,v3,2/2] selftests/bpf: Add LWT encap tests for skb metadata
    https://git.kernel.org/netdev/net/c/33a971d549d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


