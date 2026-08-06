Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4B262FC1;
	Thu,  6 Aug 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032047; cv=none; b=S1/213OIMRqf+NmOMcYuEuOx6s+fiuL3La/1gKRlwkbP5t0abKGgqleSon6pTWxn0VIx7vwCtL1eGvvj1RCeZ7ysqLleEuLOlNlclHY2kLgoy8ruYZi2ONxH1uhvQ0DUL6gW4f1+RWec24uPKeM7nY8ObUtzySSnAQyjSLZMK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032047; c=relaxed/simple;
	bh=xIaMgxzIeFkZecC0gg3xDIPWCsomt36MAHNf7hmlR5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SWXBUoBcPAd+OtL+ur1tRJV/sxon9yG8yTROX35Q5YQ1hvbYd6xe0t3C6BT/8ELdtSmtdB/RmCQ3hmYIf6CVlkruuzjDvwXJ6dhgRXF6HkcTEQPMBeGZ8GGuiUjskN2GDKqA7C2usOuVAFKeIzbFBEI4c9bxwPgbHxUeXmqxIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqQujhKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqQujhKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B75B1F00A3A;
	Thu,  6 Aug 2026 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032046;
	bh=0tcMC15jYQkKS+cvZ0gIOKyxB9ENTxwSpsaRcvoud+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HqQujhKvMB+bgqSOI76LajlHph989NeKBTIexibh0/1XddSdBaDypWmkLvj+StfFd
	 nzNfwCCyvDDJd1Zoo4u88T4KTooYqzdjuuM4n+E6SwAqbeBinrvONwTQCJMLNh7uTP
	 eaNdacraBnrSVhMhSOA9D53tdggt5idp0XqP1yZNqXiPmp7jvmYEPfYpSQ9v2RJZxB
	 iu3vDMmcYG22qbjOM8qJrkMMouG6j+BawGWxxnrRKYvEYXGN8Am2unPQQYd9CoKuhn
	 pWx/dHzbofzQhqFXBwqTtiS9M3CKPr0L6k9WToXZ1PZ9d0lDy7alNVexFu8em6NSJ3
	 DOoLdDeKdHVig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A2380820D;
	Thu,  6 Aug 2026 16:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] xdp: reject clones that overrun skb_shared_info
 tailroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603200563.1353047.6718868638541951645.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:00:05 +0000
References: <cover.1785757386.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1785757386.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, liuhangbin@gmail.com, kafai@fb.com,
 toke@redhat.com, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 20:15:31 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/core/xdp.c. The bug was reproduced as
> root in the initial namespace through XDP devmap broadcast cloning.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,1/1] xdp: reject clones that overrun skb_shared_info tailroom
    https://git.kernel.org/netdev/net/c/e48e8edbef2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


