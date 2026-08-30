Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A735975;
	Sun, 30 Aug 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788126663; cv=none; b=GiCv+tpmsmNC94MH2FiXlrbB35UACFRqcY2LdyooNORkgp0VhPPj/PwoopUtcJYHu72rLR5gtufnASZuc8R7JPP1p5/JLyTckKWp75bvp9nTlW0C+AcoGLMVkMe8PIrs/d/3gtdbaDTfOSsrIl1CNR4jAGZ3QBx8MMyOwRTB7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788126663; c=relaxed/simple;
	bh=pXlcSx2WEhhzgjRraMNDrn3x/LkBBUP4Wt4IBnPW3lI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CtQCgLzjo4wkhUfJWrEt6F7XyDWBWKfy6qCsxG3UqVJdUfXsyIqCcW7pI79NDFW2h9MvFqGlkPhS7g1BFLvtoPMnt5U7EQTnoNg9ghVBbANvQqZnHGUioQ+F+87WUgCGHrZZnIYt0DaBxeVcmzwGTFTfIRYEidl35CZLM9Xq2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5GbC7qz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5GbC7qz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2E91F000E9;
	Sun, 30 Aug 2026 21:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788126662;
	bh=MiSGywYAquNABA+EUcUkM5HduLrd5I06IeezS+6b8Kg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h5GbC7qzKXpyNZM3eODXGgDQ8fAEmj2JmFbuEenPKwodiJ7UUT1K4A3F6ghcxMlNA
	 qgrmCF434yhtULbERSkLB47ZiwAqsUiqR0vKbSG1zCqqOfkWTIZjH7XzKl1V78VQ8n
	 Nzg0TJIGpdAX/hrXm+DiYfd7RR8/4iP0pFa9oBLmTf4fXDmlzVKJFp+VHFg6TAFRJI
	 x2esBMPOoApdskD/GmI7sPWeQVNK70We2o5mkI7/2J199nPEeoj7tiC0cr+PD1Dk+T
	 +NXLHQD4kRY0XKN2iZgjPdjCfUvem2D9ww0BGoI8vukHdUuWjvEknSWVAMmrqrZFBq
	 RJGRatElw3ApA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19792380CEFA;
	Sun, 30 Aug 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipvlan: unregister upper devices outside
 pnodes_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178812660590.3522301.2585803188488084476.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 21:50:05 +0000
References: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 magnus.karlsson@intel.com, sdf@fomichev.me, bpf@vger.kernel.org,
 syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 18:49:18 +0200 you wrote:
> syzbot reported the following circular locking dependency:
> 
>   xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex
> 
> The pnodes_lock -> net->xdp.lock edge is recorded when
> ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
> while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
> an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipvlan: unregister upper devices outside pnodes_lock
    https://git.kernel.org/netdev/net/c/a8455260b2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


