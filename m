Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3AE1C3C08;
	Thu, 29 Jan 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694612; cv=none; b=UuDrHgkWm9eYTx+nn08q/Xcn9XL62acwpgJXW+aOG/wGBy80CZcME1ix3KHCSZ3/nTEydPLNHFE3by2lOuHeWiQiROvozGtq/7AlMvRiBDWO8TGyNo2UTfuEOslVH0tuwDg9/RYGRB1f2vlJjC38kBdW+mr7C+8OmJwADEYMhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694612; c=relaxed/simple;
	bh=njAphseulUjoK8AcV8JEhX+CD2myxOkOYR9RBZrz5cM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cH5u9VZ/Bn+N21LiCygF7m8KSiav3iAbbOvLFF5EzYi1YOOzHvAhG4CkkvTTAuPiwXWOp+AdMCqMtpmzmxGKg3up0URQxrVhP92IeKHgDpbLwL1o4cXrACvTCbiwy+h7irbZPaT0IB7BNUlOPNYnPA7FE5LdH3dLi0zjH5kbB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0WZL1tk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0WZL1tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173B4C116D0;
	Thu, 29 Jan 2026 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769694612;
	bh=njAphseulUjoK8AcV8JEhX+CD2myxOkOYR9RBZrz5cM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u0WZL1tkJowyLwckCyw8Rdp7Hy6l7Ju1AFUKkMjjazQl5IbCZcbdcuV/oL2Yu5tzE
	 5odwCTVEMcKCeOEmantn7kbzk04mJ9R4n1q7T8l7bnuffpA+7TvrEjM+Lxkno51MYG
	 pjw+bAgdwYflOmorrKAMV9vMbtUOM/fnkM/6efv8WU4pQqHD2HkfHnfa+P9ywrQ2Tf
	 R5nVNq6uwI7irsKZBEviIYr99UCPoXDukVvmvRH9YyiuUBJDIDVKFewwVjzauAsEin
	 2u8BwEcz1Eiux4WdFepqcB58psKEPMcxcK9lEfZILlEliWRV7cJ/mR1ugetoN2/oG1
	 gSM3zG1+4bTAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB4B380CEC7;
	Thu, 29 Jan 2026 13:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: fix segmentation of forwarding fraglist GRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176969460511.2509271.18000962996568146768.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 13:50:05 +0000
References: <20260126152114.1211-1-jibin.zhang@mediatek.com>
In-Reply-To: <20260126152114.1211-1-jibin.zhang@mediatek.com>
To: Jibin Zhang <jibin.zhang@mediatek.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 wsd_upstream@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Jan 2026 23:21:11 +0800 you wrote:
> This patch enhances GSO segment handling by properly checking
> the SKB_GSO_DODGY flag for frag_list GSO packets, addressing
> low throughput issues observed when a station accesses IPv4
> servers via hotspots with an IPv6-only upstream interface.
> 
> Specifically, it fixes a bug in GSO segmentation when forwarding
> GRO packets containing a frag_list. The function skb_segment_list
> cannot correctly process GRO skbs that have been converted by XLAT,
> since XLAT only translates the header of the head skb. Consequently,
> skbs in the frag_list may remain untranslated, resulting in protocol
> inconsistencies and reduced throughput.
> 
> [...]

Here is the summary with links:
  - [v4] net: fix segmentation of forwarding fraglist GRO
    https://git.kernel.org/netdev/net/c/426ca15c7f6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


