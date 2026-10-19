Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678BB4F93D9;
	Mon, 19 Oct 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417808; cv=none; b=UWXB88IbGaZZxXngMVAYVgUoPkWbi45wUTFQ7SGC96SCROL++NecAeciy69x8J2wTPKRm+koxrtHdGbxTF8fN37uj723iVvFkPEmmGLPi5YdgEV9B+vSAUyFUYnRNeiJ0CiWMRqsC6368buJFFIYLIY+bx7YpB0OqA1zqqx0vAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417808; c=relaxed/simple;
	bh=ZmfuYNOG+ltTWn0KVMk4+eIni9jpCTJXO8HLKebsNng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=obHlo+3iiG2+JRjK1Nu23NvTtqSx7pFr9APQaQSw017+K2H4+QYcubXakYlcmBFyKkyORb8ukUuz6DnXFUX7sFy4pAYq+Wi6/vgjreBEAQU+n9HgVIgCYP7rIWFCYYldqgF8IkGjRuFEf4VZo+LGyhV2Flph9Yf8XXAaiMTD6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU+matu8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU+matu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C7D1F000C5;
	Mon, 19 Oct 2026 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792417807;
	bh=hq4TxYElKFWdoI1/k3xWmiLfjsbCVTluQCz28pFbtlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FU+matu8/47ThpqbUiljddUJ3ighPHTBEl9uxkhTLT9VP6UNv93rLzULADUTMrHdP
	 Y4VxZYkLE1Xi8LZZCllwVANoD626cfTlgJcLrpF/Xli7/FGwEoBDzCYia6Ek9NY6Vk
	 NZ8uPq1qFxHBoYmdk9rmFwHpi1K6rrsC1QWc9l/q1fUH2OFel2TChSh6CpMZypfkUp
	 l/CAzuLk3OjLMtS5T5S2ud32d36Gx23gB6xHJ6/YagkTn3jozr1Ho8kk38kfq7rMy3
	 FXXMIMPchR43VoOvTyW+x6UbOFSUMihKjXcOASdltPkVXhHsPofvNobElRCIjQQGKN
	 +j4srvXrGBPvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A50F3811A5D;
	Mon, 19 Oct 2026 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] stmmac: some XDP fixes in XDP_TX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179241780603.2650933.10407717867130544320.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 13:50:06 +0000
References: 
 <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
In-Reply-To: 
 <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, boon.leong.ong@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Oct 2026 17:24:38 +0200 you wrote:
> - Fix page address lookup for compound pages in XDP_TX path.
> - Disable TX checksum offload for jumbo frames in XDP_TX path.
> 
> ---
> Lorenzo Bianconi (2):
>       net: stmmac: fix XDP TX DMA address for compound RX pages
>       net: stmmac: disable TX checksum offload for jumbo frames on bugged cores
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: fix XDP TX DMA address for compound RX pages
    https://git.kernel.org/netdev/net-next/c/2d5c08ec1532
  - [net-next,2/2] net: stmmac: disable TX checksum offload for jumbo frames on bugged cores
    https://git.kernel.org/netdev/net-next/c/667a375a5294

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


