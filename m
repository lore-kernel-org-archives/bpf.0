Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469734BA20;
	Thu,  2 Apr 2026 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096435; cv=none; b=Ay2iOz30T38XZIj04s+5SF1b4c47QcoNDh40fR7yLDNj9EIH+GYndo1Um19kvXkzd912L3enzivIakaah4KUXO3x0F81mOPNH+vtUBQGl668WoQ9zhyL7fe7CgK2hhHL1AWfloJn2HcrKDWLRj8Vn9ZpaaFMb8FBjWwGXdQ7ndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096435; c=relaxed/simple;
	bh=N//2P+lz7SfJKAD0hN3i1t7bWcKBsU88Pm7zgSVfWww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LlNAY0q6lNHWHbgBq8FytCSBpcuua3Z4rh+56fhfXYHhE2eIf9U9X8KPsiRNh5K/9l7OmLaiS3CSBfCSXpRA5aO+TXK3U32nsJDO4q5w+lSNlCdC2XGtrPMuTb/3j+Sv3GtVAqIfQlBg1EBoR9qhCTlEP/pVquIRrKBWhiPgzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrUc9RQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrUc9RQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569C3C2BCAF;
	Thu,  2 Apr 2026 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775096435;
	bh=N//2P+lz7SfJKAD0hN3i1t7bWcKBsU88Pm7zgSVfWww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nrUc9RQgZVzqBDB3AiEaw4/yyfYcFYsl4VdossEMMdw6rKIzp3wJuSLWy6wIoxFcv
	 3R24Lygw6FuvKOq1h8lYz2suXsioVsMcQrRB6Onaz3JIaQW1ZeVEIFB83Zr0qOSTh7
	 Anh7Wrbh6YWXCrmiUkcjps1KreOJvnCRPx77dHx9mVNzaS4C1HUcRXh2zvFh+E80sY
	 kASteOtljOVdESNepWkDiQ+2DvaI68snXa0D21a4CheQoRlY8rL+IOrpWesC+8lJpC
	 WpE+0BsxDNAKOfArDO0lh2JCEZ167QLf5dZFMQDduk5547Qzl7Z6nAacqRAI+sFfAO
	 X0Ho6la2o2Z8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF223808203;
	Thu,  2 Apr 2026 02:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2026-04-01
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509641803.3954047.11010791965205644195.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:20:18 +0000
References: <20260401233956.4133413-1-martin.lau@linux.dev>
In-Reply-To: <20260401233956.4133413-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 16:39:56 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 2 non-merge commits during the last 2 day(s) which contain
> a total of 3 files changed, 139 insertions(+), 23 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2026-04-01
    https://git.kernel.org/netdev/net-next/c/6c3dec3e3d20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


