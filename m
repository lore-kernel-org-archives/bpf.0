Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28B2FFFB5;
	Mon, 15 Jun 2026 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566823; cv=none; b=VYDNtD58scE2IrJO3PjLUSEm85rv4aQR/l/PQy7L6db6/5moBboJY3+D6jz7p12v/e1UOWHvJ7gFWF2rGDyR1rtE8LX3eyHkrbSJ9wddf8t8eel3kYN2h4m/vLnP00+59XD1Fq9BWPwlveXgva3ZtCAypT6XQcf5juc0Z57zTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566823; c=relaxed/simple;
	bh=HHdUfbaEjQ41R9T6Q1Qd+ec2nt8+WSsNqfTCq1pmptU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bw+amFtcZeY17XtV72n2AcUde3HF3xtEzD0sHin4nBiJ4u0k1PNWEwDSPI35Sa6TJkAfuylSeusG52+zPJ+pKlZUbk1Rvr6zeiZ4y3BENJzumB04Y4PkV6fT25Br0EaN4Jg3aPcsV25Q/q5rDuT/is/xbuDamKqL2siLpnl4g/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEoY0qeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEoY0qeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67BD1F000E9;
	Mon, 15 Jun 2026 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566821;
	bh=WzzZkl0ITKGF+e89UCTNrQ3QOTm2s+mNTX72P5uC134=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AEoY0qeQ6ryZxCtIx8/jTZzyAqawRslLOub3uUTkYMX0kiicXnwmjkT+oK4NhxzGF
	 EQ7Clm9X03BRFRHtMMxlM12FqgogeM39l96olju/Cz3JSbq8H5FNB4szo83f3KRRmi
	 WN6VVVLB5Fhyabn0d/I+19gDZa5dP7kYodSIveQNLNuB+qkBgdk0BBbmfxAF2NsUOJ
	 hc77OMZA8O8rRqOM93gqmpdoz8C9v91aJxCYGRGVDmic4JX5fnlASBDdbMweeq4K9z
	 ordxeihikraCNS9LC7EHq/7Fp5KucgMJ0OMp4WF39JJpsxxH3u81TyBzcFpPNUxOy/
	 d08IJJQWk/7pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198093839A08;
	Mon, 15 Jun 2026 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] ICSSG XDP zero copy bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156681669.339383.12184092559832097375.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:16 +0000
References: <20260611185744.2498070-1-m-malladi@ti.com>
In-Reply-To: <20260611185744.2498070-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: diogo.ivo@siemens.com, haokexin@gmail.com, vadim.fedorenko@linux.dev,
 devnexen@gmail.com, horms@kernel.org, jacob.e.keller@intel.com,
 sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 00:27:40 +0530 you wrote:
> This patch series fixes bugs introduced while adding xdp
> zero copy support in the icssg driver.
> 
> Patch 1/4: Fix wakeup handling for Rx when available CPPI
> descriptor is zero
> Patch 2,3/4: Fix destination tag in CPPI descriptor to enable
> proper Tx xmit for HSR offload mode with XDP and zero copy
> Patch 4/4: Fix Tx copy wakeup handling for XDP zero copy
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: ti: icssg-prueth: Fix AF_XDP fill ring alloc and wakeup condition
    https://git.kernel.org/netdev/net/c/dfb787f7d157
  - [net,2/4] net: ti: icssg: Use undirected TX tag for native XDP in HSR offload mode
    https://git.kernel.org/netdev/net/c/bcbf73d98195
  - [net,3/4] net: ti: icssg: Use undirected TX tag for XDP zero copy in HSR offload mode
    https://git.kernel.org/netdev/net/c/f9691288413c
  - [net,4/4] net: ti: icssg: Fix XSK zero copy TX during application wakeup
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


