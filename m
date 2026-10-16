Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DC2E175F;
	Fri, 16 Oct 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112412; cv=none; b=UltUboHER57Kf6kiI2saI3HBiCdrgaVpfSyIvtkRctkdK33uaZFmfkJ0lIJweJQwYNXuGpxJyNzMAbwJpbER+3kafJgkvq+BnQJ4bbFLQXEwsVTR0mLVyvd3wfVClU/ueJuiV+TSrX+OJW2cgwn6qZT3KgToQqVT88goxEYwaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112412; c=relaxed/simple;
	bh=27dUxT796tRpoD1PbzV+LMPAYMYVDTEOtfZDtP/nDzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IcFD54bwUESgNxKT3W/3JMG9B5dT0soq6x51/pGetQ06HjvRmXT1UKIdQX6QSwfHRavdg1cli8GAgZEbymPUxEzipqqdB4p3xkdfaWm8IZyFlvncVXyrjjf76kYMXHVpAJZO4RplwJBI6EjLc723bMuSRf6fw2A29ghtBf+dnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9mhMcKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9mhMcKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FAA1F000C4;
	Fri, 16 Oct 2026 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792112411;
	bh=bKEfWzAFkBWQwDCvKBQu3c2cYHNsOiRQvEAMVtC7ihY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h9mhMcKeoCTFM5sEJLzAXA9Ml9uwNhPwklbNItLhsNKThdJSXC6LtE43b6Omk7KHk
	 BWXrHIeAgAEF3Kwxe0xw7Ajvwj2cgR1W/zupw1VOtpaSjLE4bFobkAefmOTlYIoN5H
	 INp/oSjpsXnZJeh1g8E0vhLpEqLplfhuqw7jbqbXVBxfIPFevWi+hHcPMSYP9AdoQc
	 kYosP7+88Hh1aF/Pb2OhRUV7AmRregqSl78eotjK4pF5gJzcCZ4jhvRKqK9Cj8tw0J
	 mS88L9N9/K+9PA1vm2AOfLD2m6qcKZR8axr4cBeKz2stLYUbiLyMJjChloDTEhokme
	 c96Je0LTR+R3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773FC3808209;
	Fri, 16 Oct 2026 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: skbuff: replace most BUG_ON()s with
 error returns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211241001.4182913.5200516611523638723.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:00:10 +0000
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 07 Oct 2026 17:35:59 +0000 you wrote:
> v1: https://lore.kernel.org/all/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com/
> 
> v1->v2:
> - Use DEBUG_NET_WARN_ON_ONCE() instead of WARN_ON_ONCE(), so
>   panic_on_warn systems take the error path instead of panicking
>   (Willem, Fernando).
> - Split out the skb_copy_and_csum_bits() unreadable-frags fix and sent
>   it to net on its own with Cc: stable (Willem):
>   https://lore.kernel.org/all/20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com/
> - Rebased onto current net-next.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: skbuff: don't BUG() on bad arguments to pskb_expand_head()
    https://git.kernel.org/netdev/net-next/c/c7d8bc3dd511
  - [net-next,v2,2/8] net: skbuff: don't BUG() on a bad frag_list layout in skb_segment()
    https://git.kernel.org/netdev/net-next/c/7b32bee7db82
  - [net-next,v2,3/8] net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers
    https://git.kernel.org/netdev/net-next/c/279877d86c82
  - [net-next,v2,4/8] net: skbuff: don't BUG() on leftover length in skb_checksum() and friends
    https://git.kernel.org/netdev/net-next/c/20ddd0fd2fcd
  - [net-next,v2,5/8] net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
    https://git.kernel.org/netdev/net-next/c/56453199d28f
  - [net-next,v2,6/8] net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()
    https://git.kernel.org/netdev/net-next/c/417261779eab
  - [net-next,v2,7/8] net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()
    https://git.kernel.org/netdev/net-next/c/433380f5ab8f
  - [net-next,v2,8/8] net: skbuff: remove the BUG_ON()s from skb_shift()
    https://git.kernel.org/netdev/net-next/c/e6974aad4bd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


