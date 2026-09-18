Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4F33D4F3;
	Fri, 18 Sep 2026 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689677; cv=none; b=ZqfDyEi0rHHKHjC850Yb4Ye5zt/+uOJjDpPBzTArFg7zYBVKPu42K36+ieRqu7EN+DDBqlDgNw4G2Jtw96ToSKDfIAFm9EGMRjqSoC7fmdeilyrA0hncE4zDyMxkcKbkF6j+/vJCk3mAfuxPEDrZiyZ+moOVqzfZOUBWaTqqX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689677; c=relaxed/simple;
	bh=lQ1mda/bxKlrYadLTbtckswVSV6KLK5jn5JG9KzYyYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gfVNwexeCHi3RN/BO5AFDYc8e/3wDGIK89WC8enAZraLht4jKAIcKuz59LRCr2rkuJrKX5ue1uDojTXWJxlYRis53nNDDLN8fmk7RVfweh1zsuc5Cz+K4cd0mhV38M2a3fNE0/KSMPltIirkeniTP38Q388kgt2sUy8NhndlK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvqcQBnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvqcQBnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C101F00893;
	Fri, 18 Sep 2026 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689675;
	bh=N630KvaHBATeUU1PEVGbc5SjI1TuyG7Z7N/HXl5rJfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nvqcQBnEZTaBRJc5OILcE48ImB1eN/kgJzGjmJ4YdH8RfplBuS7EuU2Sh/Ucm3q0m
	 HWfMHmidUmwon6lMQHGDQZy6BjNMQTlqPaPWQVXjIamrIRnkm0BDuFQLF1nXEdUSuq
	 NaJIlA0dHlwuXG7Lf8qZHbAueyvEpvg+TDlQJQUccAN61EWKB2ShqJJUcJN/5ZZ0lU
	 dXJ6tDqqP7YZQ9WIqARhXmYuJQZbjanavRHhS2v+lB2ggqLb5GhlYP0U8eYY8iHF2D
	 7kmodaiiUF4CbEYaYua8eC89E13NUffVDMzbTYn5G3SVqLgQL6Re2Vd+ruYEuTerDr
	 jLYS9YrHfWp9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08C2380820D;
	Fri, 18 Sep 2026 00:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: specs: netdev: update doc for xsk
 tx-checksum and zc-max-segs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968960837.187564.13298642054405181183.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:00:08 +0000
References: <20260916021608.1702731-1-kuba@kernel.org>
In-Reply-To: <20260916021608.1702731-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 razor@blackwall.org, dw@davidwei.uk, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 19:16:08 -0700 you wrote:
> Minor touch ups to the XSK-related doc strings in the netdev spec.
> 
> Tx checksum is (obviously?) Layer 4 (TCP/UDP), not Layer 3 (IP).
> 
> The xdp_zc_max_segs change is more subtle, I guess, but to kernel devs
> saying "frags" may sound like the number of skb frags. The value includes
> the head in this case. The default of 1 means single buffer, XDP_USE_SG
> sockets are refused when it is 1. Let's use the word "buffer" instead
> of "frag".
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: specs: netdev: update doc for xsk tx-checksum and zc-max-segs
    https://git.kernel.org/netdev/net-next/c/8050e0efd4cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


