Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D312E11C7;
	Mon,  5 Oct 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238215; cv=none; b=Fx/COwzZffl2NvPD16wosL3u88m36iW8JKhDMh/Pnb4P6TMTvmGJ6/fE+TaLibfkrxuZ+nguhMMD42++BGar2kDdDvEetReleRlVsP6Ak7CC04CRwcMWHiPBH5klhZrz+5Xw6xQhwfkAFBLuArQk/lqb06tnDUUG7UD+0iY/9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238215; c=relaxed/simple;
	bh=R7N5gHd+iGgfHq63AKGSsUyAQLXmkvXtCxCJMeibuW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UMWoOhTGIZRdgh6y7euJE3L2BvZNiTzSE2LeE0WVB+M7qaCgkeYsmX5hoKNNFj4cBxz/F8x4/Tuen7UpmRO3fCaS0wzSmoyRiKZcZgMM1QOUwCtBLoSpDhSucUSFh4AuyxPA+HVAzw2ZzcV2aL7Q5F19ksUsRIVPcTl896BB3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTmdJ8PL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTmdJ8PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C9B1F000FF;
	Mon,  5 Oct 2026 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238213;
	bh=DAhjuddAMts7kMqsMKrE9o2p2Jem31xFhPjACqPIYOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kTmdJ8PLZSqVxPzh5qhv9c8TLClPeND4VUP2ROktSH2HCQv+rjWfGDoYGstj2Slhy
	 44hr/rhiQU7mWgaCSgyHrHRTqVHxDfjGvUt4yfO1I9Esbnu2LbxRbijG4bJNcFxztp
	 Jn7DPH1f/zU5tS0vSRaxECKjmr1wNiAr87Giogr75JwiITcBp3QNYGUVdhuc/dpn1F
	 cV9J5mj6GGUhPE8a6K2q5nODsZMHTjtXd1Z/wcgl7LDrjTM3VJmTVD5hlT6J/Plraw
	 p7hqAjHpcPhZDr6mFRXZjXUZCkVzRb9PoYk9McTdppa5mW/Y9VcuhMNYSVX8c5XWQh
	 CqAKyR4TDVIlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7727D3926672;
	Mon,  5 Oct 2026 22:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: make dev_xdp_sb_prog_count() see programs
 attached
 through a link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179123821228.1914306.8115752348017905480.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 22:10:12 +0000
References: <20261001012559.297751-1-kuba@kernel.org>
In-Reply-To: <20261001012559.297751-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, ap420073@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 18:25:59 -0700 you wrote:
> ethtool refuses to enable tcp-data-split on a device running
> a single-buffer XDP program (which can't deal with the payload
> landing in a separate buffer). dev_xdp_sb_prog_count() only looks
> at xdp_state[].prog though, ignoring bpf_link integration.
> Get the prog pointer from dev_xdp_prog(), which will consult both.
> 
> bpf_xdp_link_update() needs a bit of a touch-up, too, since
> ethtool calls dev_xdp_sb_prog_count() with just the instance
> lock (for ops-locked devices) - we now have to make sure the
> link updates happen under that lock.
> 
> [...]

Here is the summary with links:
  - [net] net: make dev_xdp_sb_prog_count() see programs attached through a link
    https://git.kernel.org/netdev/net/c/d333c8bca6dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


