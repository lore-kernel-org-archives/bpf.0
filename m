Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0AD30596F;
	Sat,  5 Sep 2026 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573073; cv=none; b=Fd3WqN5pPortZjzzl8Vb6hQTOTBUEMAJ3Os/6B+OTImgVpRuuDN1CS9Y/5TirUqsOVD2ue8uC/m2DdLGB5XCWfia32822QlZF4PqqCsKeAlMatm3pIF4WJCmufoRLu/FNtzS3aeoorjTIfypL9OgnCKJodDl8jxPNuoL3FSsz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573073; c=relaxed/simple;
	bh=N8CGRsD/t9N9iF7l84sZkET15Q9OiVr5F68p5XUmeNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P2eP3gONLEvz6Bhdpu8SXHnlcPGbhQkfISaS+mlAB4CxiFaypXvda1yD9OanU0TYQ5qLHwB4dIgPCryehKeeAOEXs2bVwDoqlcP56OjoupHarIDLBZyI0RNvTLlebY2fOLFAUk4cURzWZG+dDexOfbAeIJJTng3cYhDxnaEGMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo/GJL1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo/GJL1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B711F00A3D;
	Sat,  5 Sep 2026 01:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573071;
	bh=Jp3BdJ8iTt9F23SnvdSM3AxUUvxV9vY2ZQ6+hRdyW6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oo/GJL1EV44QFQQH72SSiius5uTQ0kS/p0fOTcSqcJmbDJFmTRgYq82okrzqjawGk
	 xC0CipPs8X/+RFBdkL3h5UDb3gb2xw1DM7Uz9oQY95A4ERI7+sUyZW+fCwMAhJkMq8
	 bOHwddkhSxoCRyyNDTlAcp7dZLPXaCFr7CZ/V7Vb7LNCf54RMLNAP/RrUHZkWfIhGi
	 l3JpsR8FPcQFaibebzByrKBzJZ2W9GLXkdRJIw0oBxobxa3ahp0H9Y/RzyyksjfwF/
	 cuDs1AzzDxJYEG3SBT1/Gd/Kb6pOFFgHRpDhx2iaIBNFR4kYFSe5EC6JhcUBvEM9wn
	 LN4Gqkbzb7BKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A03924FC0;
	Sat,  5 Sep 2026 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates
 2026-09-01 (i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178857301214.1055020.11678306566993952922.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 01:50:12 +0000
References: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 kohei.enju@gmail.com, enjuk@amazon.com, chris.packham@alliedtelesis.co.nz,
 przemyslaw.kitszel@intel.com, blair.steven@alliedtelesis.co.nz,
 carl.smith@alliedtelesis.co.nz, horms@kernel.org,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  1 Sep 2026 14:17:46 -0700 you wrote:
> Kohei Enju adds support for XDP metadata of Rx hash and VLAN tag.
> 
> Chris Packham reduces messaging when Rx filters are exhausted, and
> promiscuous mode is enabled, to occur once when the mode is enabled
> rather than repeated messaging for each filter.
> ---
> These are the i40e patches split off from this PR:
> https://lore.kernel.org/netdev/20260805213541.2281287-1-anthony.l.nguyen@intel.com/
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] i40e: prepare for XDP metadata ops support
    https://git.kernel.org/netdev/net-next/c/8b1db02b771f
  - [net-next,2/4] i40e: add support for bpf_xdp_metadata_rx_hash()
    https://git.kernel.org/netdev/net-next/c/cff6f1378df7
  - [net-next,3/4] i40e: add support for bpf_xdp_metadata_rx_vlan_tag()
    https://git.kernel.org/netdev/net-next/c/bbcaa1fe8749
  - [net-next,4/4] i40e: Avoid repeating RX filter warning
    https://git.kernel.org/netdev/net-next/c/907bd786209e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


