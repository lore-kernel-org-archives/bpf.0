Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994611;
	b=lBtWQdURLMWee6WTCZPZJEuu0ViK5z40JaaNZx7ovxZl7kHCXS7FIyKkBsDB7bE+3ZTc
	 74yDBbJ5zz2wEe6eU3U2ErFFwG3zYfTpCiE1EoInySdKHvuVzkgH6FJMP19dCH/tMjxrU
	 wif1OiL61RddbdyQ6xzSeFHffZIxpgw8hXMT47RiX+cBRwNeBfP/eJyyDwlFkTa0afqtj
	 29wDrLYXe+wDcZd09XsAB3VdcLYyQLPzfp8q4X3ij0KDdDWthi+8eNmK8CzJo6sdXg+C9
	 zvcAdM3W9g3cMhXr2BV1Oia48r48k8OgjR2XLJHbm+8p742pNzCo9oEwaCtEnucCuXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994611;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2HMe9eZMYtzTydcc5IcP0okrDg6nvzxmOhb3AFgv5aM=;
	b=J7/OgC7vNuKLe226Sntx1as1uScsxDF2LduoSjrIxEOaHrtezPV3+ankQStDgk1d8+GS
	 EOVtoPt/z6KK8XXA+z9UNSgcJHppRN/78qBYpO5ogz4K8y0VPAUgXCdgZ9UCtls2TSYin
	 8whxUdCdd95eXLGhTVdFwL2sckr7Svig8pLKCFUcrCj6mjOX5DREhsqWA2EQY6n/T/rF1
	 lxGUf9E8BybTuuJw2uTSvGUyi81Ci/D9n1VFwPVpotBx73LNRsrfsNoaO+OQXCskXHEmb
	 W9dSJ8sjiQn43ujDPOirOntq1lqU3WshnJiNrMyuIbnX/HDbfJXWXWHGLLVvQSuf/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlcrQm9x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD72606A338;
	Fri,  6 Nov 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlcrQm9x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D821F008AB;
	Fri,  6 Nov 2026 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994610;
	bh=2HMe9eZMYtzTydcc5IcP0okrDg6nvzxmOhb3AFgv5aM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PlcrQm9xFffNJZFw/lvm3M8G0j9nxeGCLL9A1eJK7fZLysYWsqLDseXKezZJUHe9o
	 jRP62nGB/s86bNdbX2XWpy9/HeSprnBBVgba3Z03a/YEVcWobNYOBDC+1DE8buD2pk
	 N3DnPx3NMqHpDsbZrw4vlkJjoaH9bxxYZOV2mkvqoTFCiyntBbMDhra+wlL3kop321
	 1Lvt7dKZYOLTwQdihnXXSRmq8to57sXflNmn1O2eTwjrYAE8oBm3on+3Ae/zoCoOVW
	 nPpPEFZ2SfQYTfKzO8jC353+XLkwuBiql3agrqcVIJa/7z9EsAWfgCHGmzgobGL+yr
	 TxpjF9NTrYDXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D83323A41038;
	Fri,  6 Nov 2026 19:50:10 +0000 (UTC)
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
Subject: Re: [PATCH net v2] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179399460942.837391.13441261303055568861.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 19:50:09 +0000
References: 
 <20261103-nb-otx2-xdp-cqe-cleanup-net-v2-1-5430545c9cbc@tipi-net.de>
In-Reply-To: 
 <20261103-nb-otx2-xdp-cqe-cleanup-net-v2-1-5430545c9cbc@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sumang@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 daniel.machon@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Nov 2026 10:04:49 +0100 you wrote:
> On interface down, the TX completion cleanup also runs on the XDP
> queues, but treats the pending xdp_frames as skbs. Freeing them with
> dev_kfree_skb_any() corrupts page pool memory. AF_XDP TX completions
> in these queues were never reported to the socket either.
> 
> This happens when XDP_TX or redirected packets are still in flight on
> ifdown, or when the XDP program is replaced.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: fix XDP frames freed as skbs on interface down
    https://git.kernel.org/netdev/net-next/c/a4b93564a954

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


