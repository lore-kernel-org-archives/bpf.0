Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200373AE71F;
	Thu,  8 Oct 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481812; cv=none; b=S9o3ri3Y3WQZeoA8C8GH8+ttvH6VsInb0K9CNQMSGUooOJhZs3/EObs311vJciRbK20UrMRgCeRFgzwCUPyr+bQ+NEXEIKdIQ+NMKB9RD1Ln0N9MEyskS3gz0QCCkko7oSZftSNPSUodctxS9KwBUJm6TWP39xyvue6oOFC0KPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481812; c=relaxed/simple;
	bh=zQchMxpAvB7T7YI3jIpw79/wii+H/Qg4ZBTV2TTBpb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FyUiGPH55IBx2PTzW9Ski6aCl8RyHjpidSerMd/lIK1cRM2tj/0CzlRIQqggSsRloX5MRXRP+Px8nQvrMm8Jhx+TU9nZIxtdKQcKqv1IBaQewIEHRcMyTmQSJZKrY/iQB5qXai0oQsczNKi40Rq3nOivWzbxng38+fSykb5A5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBxActu8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBxActu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5941F000FF;
	Thu,  8 Oct 2026 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481810;
	bh=ro6bjvj+CfvhTH6Zl53WSSb6TekZ0Krn/oFKfWb09Sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SBxActu8x4Ys6uY0u+5FvaH+jlzr5lIETq3JnLmZLRho2N/6mq0fZ8giEfxO6GoVn
	 v4zanbcB33xUosSg0sUuNwDYwSVTnokq4M1D8Ri8r1b8TvUmkZlEndcoYiEyQjivz1
	 HZaH4Dk3cX2IpaQvHjoCTXYYgr5tjGqRy3nOwpllf9kSyJrN5ujp493vqN7CIfHlUo
	 kekgE6exFp8v2lPoaZD2nNkqBF9nW/5VicgXsNgspjgTPoLMv2o4V7lTXnDzzBFjSS
	 UaiQdjNhvJffzyFOYBlrlbQa6rzT5FjiOu27ECQ1SGuSjoWWWFgxNxkVorrLLR9Xl5
	 Ou9dVjOnBYaJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4426380AAFF;
	Thu,  8 Oct 2026 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO
 is
 toggled while down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148180926.369078.12761159008899596056.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 17:50:09 +0000
References: <20261006173241.65945-1-tianyi@cloudflare.com>
In-Reply-To: <20261006173241.65945-1-tianyi@cloudflare.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
 hawk@kernel.org, kernel-team@cloudflare.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Oct 2026 18:32:35 +0100 you wrote:
> Toggling GRO on a veth device while it is down leaves its peer's
> NETDEV_XDP_ACT_NDO_XMIT flag stale once the device comes up. XDP
> redirects into the peer are then rejected with -EOPNOTSUPP, or, if GRO
> was turned off, accepted and then dropped with -ENXIO. Patch 1 refreshes
> the peer's flags in veth_open().
> 
> Patch 2 extends veth.sh to check the peer's flag after GRO is toggled
> while the device is down, in both directions.
> 
> [...]

Here is the summary with links:
  - [net,1/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
    https://git.kernel.org/netdev/net/c/3f090039995f
  - [net,2/2] selftests: net: veth: test peer ndo-xmit after GRO toggle while down
    https://git.kernel.org/netdev/net/c/c017800af5c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


