Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14F314D18;
	Thu,  6 Aug 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984047; cv=none; b=A0o/G6urx+4gkthu1DovpVCybYZ+KUDffyESyVyW9/BfVvUcV/CehJU8kbxhj6G7CfQmLPk/XzOR9PM0Z+SZTyOZemac9L3YZlQ7CFVZTrpPL/i6W3lHFqxv8ztNgGxJKqdFRvPtqwtQ+YJL5Ce4e7erhrWXgod8LprGr+FZ4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984047; c=relaxed/simple;
	bh=OOb8OwJ/vb1mdWa0UtChU/apByeEzfqC50dcI6yVFxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uBm1YxS6MANlIiLRsuCTXUAGBJmiSO+pi2WW7083K+i9uncMvUtmyOQleAoVDxYXlBaavY0acCR+bUvPmkpXFaUrbsfap9XD+PUzkSxAnDO1+kfKnJkrNzIrSdT/EBeVN9nBSR1l2dc+NeMLKl4EUgPafLD8asum4fPzNH2SbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Etq+RpvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Etq+RpvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A01F000E9;
	Thu,  6 Aug 2026 02:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785984046;
	bh=dt8J41MYYEwBfk3EEXTiLTd0kxqenP6x89GiRJGjOy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Etq+RpvGllySqbBO0MUre2RssAfUqA2CQ06xCS3zkQHiOnTkZzvNfBWMO48kbngO6
	 r42rgfa7aYT+zfi3KOSTyHcn7YaOxveyyPdXoZjW6iiAd0LOm9zXdn6padB2GX+Q57
	 3dSjVXsQsidIKM5oU/fYpmwMObRvZdHgaV/FQgYNr/bmu+RWZrdLV06MRMOosI4hPV
	 3jr+VPimN8Syclm3UciIkKgMWGbrsPoCJ89F5ywWqSVrpTlG599WAU8jFJ3oLbWAyi
	 18evSRMLWo4qF/eqBLfhSg36Q0rrnRvzYSwkiE99p+AHLkM7zVThaebkAos9gx6AqD
	 OkPydsb+zD5OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A41392FFFA;
	Thu,  6 Aug 2026 02:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] xsk: account uncharged AF_XDP ring allocations
 to
 memcg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178598400589.615253.8307683004000952692.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 02:40:05 +0000
References: <20260731164623.4694-1-zihanx@nebusec.ai>
In-Reply-To: <20260731164623.4694-1-zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 vega@nebusec.ai

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 16:46:22 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/xdp/xsk_queue.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] xsk: account ring allocations to memcg
    https://git.kernel.org/netdev/net-next/c/b0057c68df71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


