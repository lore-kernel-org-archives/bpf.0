Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8C306779;
	Tue, 29 Sep 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646012; cv=none; b=LixBCk390hnonSyDlG0D0oZLW/9cX89sAaY12FazuCpJC0pMIi+faCaxFEAOaIFEtT5Fgs+6BG8NAs4He+Yr5Itdj4O+Lhcv0ojHacWu35jHthv+WlQItzAp0u+p7q2bV1lpqwQSzR4VzdMO01MKBFxjs4CRc8xdvgYYf2qQfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646012; c=relaxed/simple;
	bh=Rlpy8w+K1gw0fkHkVeM/6WE5nC4jzij0BMzDlhR+Vb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U+yIGc60GE0phvYVhRFti1Ms+Uc2/UK6lV7iZKNr14Pb2GDTfrjHcKdmPCFYQpHyStf2B5LcUWE7bTv2AmXcz+PAL25a/O6U8J66k/OA9EWtLL0P+1Bxg77xh4A55Cq9pmoRbfkENNG++Eanrie3ghYk+t2puZeCzRBo2qpor94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kseBpQH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kseBpQH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4201F00893;
	Tue, 29 Sep 2026 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790646011;
	bh=5GXLsHRwa/uiWR9gXSCFqUPaVMTCXPSoRNkmYXel1pM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kseBpQH1sZvpnkpmUR0DGwExC4M9xjqzM7cQCjYitlnkM8Hvu1sQJ0jAe+Gf9/dF0
	 ZP+qO183z9k6HINhMuzgRTtVOV6pBTqZan94OG81h2FIKIbPKTu3+aR4VIQG7fE6Qq
	 0Q1sEl5tov9BbgfU63TFPIG7+lQbZ3HEZCrTv4coucO8HO1+mLcYgBPYCkmjMOTPUz
	 HMyG29BZNNK32GOdwQxs7vWjAySivARUxZ+zSUjZVian1aBffgFzsOSHLYwPL15Huu
	 +G7NHOJqJxURngR2SJqvg0kCTp7bKgGn+oNvpJ3njQMidNBU54f7t10FDighUj4DVh
	 2Ll4DdjZBgZ6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A46D3924FED;
	Tue, 29 Sep 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: fix rx Scatter-Gather support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064600978.210624.11551401846700650328.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 01:40:09 +0000
References: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
In-Reply-To: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 11:14:28 +0200 you wrote:
> When a received frame is larger than dma_buf_sz, the DMA scatters it
> across multiple RX descriptors (rx Scatter-Gather). The secondary RX
> buffer (sec_page) was only allocated and programmed when split-header
> (SPH) was active, so for regular frames buffer2 was neither allocated
> nor backed by a valid mapping. As soon as an incoming frame overflowed
> buffer1, the DMA wrote the overflow into the unmapped secondary-buffer
> address, triggering an SMMU translation fault on IOMMU-based platforms:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: fix rx Scatter-Gather support
    https://git.kernel.org/netdev/net/c/88095728511e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


