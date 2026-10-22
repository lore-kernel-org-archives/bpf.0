Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629010;
	b=Qw5fqwNBo8+tpJ2txdgtzQtrKWqZ/Bp1sObs3NEN1Vs0LzXq4ooWcFi7+MemDwFg7Sex
	 zKyaLVyMgXZP9KFbqBY51o/KJxDd4U7Xt3PL+3bRyUS+6asuQrLD+B9h3r2aXbvKvHBAN
	 OpmwRIXypxp8VL2CMQegkOI9JbChSGwjT+F3DIqBkYFBG5DaEeM+iEyb/hfN+aGgddeP0
	 W/mcKGx+qSOomgU+1lsD0Un0sE/sEOUwP/QgyVJ82l+SFi/pVnxNw7X3P/R/7weAJ6Q2j
	 qIpx4Ql1F8LlYV90Fw4zEidvWoZWdHsMoJyPtUxXp5iCkvN18wz56fnncbUtywZtyfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zQ/jWfczyqUkVFNRLqvp4pw0qXBlneGqxYek0vm4Ltw=;
	b=kN1aIpKdO0eSZgxmrXngsM0t9JRt7LadohdiMigXMFgIXYI5XAIgXcR/F3UwFcgztRhX
	 ufdTGgjKePEKEZr1DMIzQuuUcIOv6/e/AYFNZ7Bi4s+vVVFgiOb/KG29YHle/6hzNRow7
	 GjW69JEix2d3TiEtf0XT221ZNcc9m3qFVfVdVyum7WVBJxXqCd0M2BlcvN/QIW7yby1JF
	 syzJ2p1UyH8KfKiDHkHs3n3/sVwisJ9+f3J57wZmEhzTr5mSgvUr1AyeJk4xSQJgzj4bc
	 lOsrXD+TNgMHhmcY0GY1xqZts4azXUTgSbPzEocej10/mGuVooxTe/IeyLsZQ0sU9fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1i0jV6k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782B606A31A;
	Thu, 22 Oct 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1i0jV6k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3581F000C1;
	Thu, 22 Oct 2026 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629009;
	bh=zQ/jWfczyqUkVFNRLqvp4pw0qXBlneGqxYek0vm4Ltw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d1i0jV6kcVuPfUrBGGZJBusmNzacflXL7GS7eLeRTMp3kdOivvWNjeC4EAEZEyC+a
	 Z6yNM4MNs0X6kq5lQn9RMQapBD+DgNevHcjBKmOlWO7Uqb8O+gUix3rpb72n+ZgPWh
	 q7pkwSdhdcUz4g4+G9T+6vyGlaZ9mxWWJ+n7osBfZJH5QcMNhbNPbd083q6Ic6ntVf
	 G8ig6QqRZEkmRL8CyECfyJrqAT9/3LZyZbAdyut/55knJxcODOS25Aw0KRgY785Die
	 RJ7P0TUkG9e/WAnc5wwe4IA7vU/59LIhB2lnri84asIdQfK4zO+3hvSgiHez0OYY/v
	 0pTfIGz6f/7Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B444E380A963;
	Thu, 22 Oct 2026 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] veth: schedule the peer's NAPI after XDP_TX when
 only
 GRO is enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262900853.1378903.11234441353449708793.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:08 +0000
References: <20261016214217.16942-1-tianyi@cloudflare.com>
In-Reply-To: <20261016214217.16942-1-tianyi@cloudflare.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org, hawk@kernel.org,
 kernel-team@cloudflare.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org,
 bochaolucky@gmail.com, toshiaki.makita1@gmail.com, lorenzo@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 22:42:15 +0100 you wrote:
> When an XDP program on a veth device returns XDP_TX and the peer has
> GRO enabled but no XDP program, the frames are queued on the peer's
> ring, but the peer's NAPI is never scheduled to process them. Once the
> ring is full, every XDP_TX frame is dropped.
> 
> Commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before
> xmit of XDP frame") made such a peer work as an XDP_REDIRECT target,
> where veth_xdp_xmit() both queues the frames and schedules the peer's
> NAPI. XDP_TX queues its frames through the same function but schedules
> the NAPI in veth_xdp_flush(), which still checks xdp_prog.
> 
> [...]

Here is the summary with links:
  - [net,1/2] veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled
    https://git.kernel.org/netdev/net/c/f16b8c6a656e
  - [net,2/2] selftests: net: veth: test XDP_TX to a peer with GRO enabled
    https://git.kernel.org/netdev/net/c/a70575ae9e81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


