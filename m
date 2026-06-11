Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60AD376A11;
	Thu, 11 Jun 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165415; cv=none; b=bFWDvT6ILIJAg1K+WbjNjbOy5UGOK2fGRRBv2owLlTo54c7DuB1iuIHq0OYkVBUzMt4RDTsN++vCVWvRthv7G5ByeC8kX1GEKcaHlBQ3DKX8Zp8cQmYWgXzP73mCvWqZRdvF2HpQYAGPmBn3GQrhS9mMy7nJPkhucg4GS8GVcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165415; c=relaxed/simple;
	bh=YJ0fAnSRnIsFy1zVnT27GeLkaCz2frpAJKhwSdua/uE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nyjqn5FUu6cpWpbpYv3LldcTf4Uw6Ec6Lz8QAHhu81XcB6gt1uzj1vkE213QGJc85Fyf+1EIGxq5ivsyCw92f9cEosjKKOszJ95qk80g3yLFZQ2B9gcy1WnrP1klI/Q92EnCPmPj9GaTEOQ+VhW7GApC8kIqRMx0r8Xl4BH/A4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkf/C2ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkf/C2ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE601F00893;
	Thu, 11 Jun 2026 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781165413;
	bh=uCT//8qwRZJv/4U5lHEeXtQTx0gUMrOIJ1wQ0T6xN+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nkf/C2dsGJEmKDXBm8QoKfJS445nrzAxGRtcgUP02h4Jx37cIPdZqEdVy5hQLsWpW
	 +ULc7TqPuDH/CYJ2BEdmntXm6H96dixmmLloACkpSdQHPsxZZ5CveHUkVs9+uQzI4h
	 EB/n3n5P7F4iOTVUAfy1/j25KdEhDl7S+cqCtdZ8qEfuEtAghrdhAD6rqYBSP+Cf9i
	 uVcBSAgdb7ja3LSQWPcTy2fhrwIzZ6rUfYxKuE2bC6F7sd4xy6HoKNjcjfuR/7B/+A
	 eYmrC9gPy7Wft6MpBaS5nj4AO3NkVOrm0jisUeCYUQ4Ty4c7HT3Ai/ez16mPxD72gc
	 JZ/PP0E6ZTbrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199763930E1D;
	Thu, 11 Jun 2026 08:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/4] net: mvpp2: fix XDP RX buffer handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178116541089.3821943.18053203843069098515.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 08:10:10 +0000
References: <20260607134943.21996-1-mail@tk154.de>
In-Reply-To: <20260607134943.21996-1-mail@tk154.de>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, mcroce@redhat.com, sven.auhagen@voleatech.de,
 lorenzo@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  7 Jun 2026 15:49:39 +0200 you wrote:
> This is v5 of the earlier XDP_PASS fix. The XDP_PASS change is
> retained, and the series also fixes related RX/XDP buffer handling
> issues found during review.
> 
> Tested with tools/testing/selftests/drivers/net/xdp.py on mvpp2
> hardware.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/4] net: mvpp2: sync RX data at the hardware packet offset
    https://git.kernel.org/netdev/net/c/180235600934
  - [net,v5,2/4] net: mvpp2: limit XDP frame size to the RX buffer
    https://git.kernel.org/netdev/net/c/f3c6aa078927
  - [net,v5,3/4] net: mvpp2: refill RX buffers before XDP or skb use
    https://git.kernel.org/netdev/net/c/5e8e2a9624df
  - [net,v5,4/4] net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
    https://git.kernel.org/netdev/net/c/77a6b90ce56b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


