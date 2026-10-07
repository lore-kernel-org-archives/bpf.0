Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D8383987;
	Wed,  7 Oct 2026 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416415; cv=none; b=MKAmRnifSpbq+cAsM8bT+pB/fdjiZNp5vzIpmCoYc8y5qVm5hCkNOnwd4isGZEMfrJfNmZwdcOF18pSmijFkl+U9Dkl4U0uN2RKay3ANEY2VQrgnGlLMQT2qH7geh8cTXxWlstNdYBNzGffQ3wNmAOSR9HFRqdE7zWQVQmIyqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416415; c=relaxed/simple;
	bh=0xTaqb7WhiAKNSyUaKjITeULuFqp8nKEKePYCjXx1Qg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QwlUAISxCiyf2nss7BlRu91EDkpB1UvxIi01KbsymnPFKN/18FdUpBLe1LnjsdzZXOMXwM33qGK1HtN68lKvtKpWpJXygexiwGKujmW28flJzoXyrZrvsMSy38v5XQwPyZELDF8uV1n8g/hQaYgic775nclldTqkMANOWgH+GAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnWFo7Si; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnWFo7Si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D221F000FF;
	Wed,  7 Oct 2026 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791416413;
	bh=veAoBh3gQ8yvmCMTC76V//pPu6pB67Slyg/Ya+dLB2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EnWFo7Sip49zS96xjYBGPOxN+Jnn4yG3VER4DKafy0fsQXy11YWSXJpw5x4qFZNTu
	 V0Vn2gA1t072tznEN8Gj7ixFEOyTKFPI53BUoNQhUPW0UMA37nwvrg+KvvTXM5Jch0
	 W1wrVd8wOn1GwbnnAlC2anxXCmiZJF09MirdS7TQXmCJWCAaNC3MwK6Z56zAtgqDzV
	 UuJdudVmvTVWnHwMi5QREPS6Or4Z6Z0oNe7Nh2pwFpXt8RsE724O1/J2rtQ1z4wWSy
	 tu+cgOAEoCDLctFCGr73IOhJbAm8cF/KNa2HOqKqHjG/XTzd7H+O48bTjDn9j9CK6J
	 LpOAc3jwtkmew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F18593809A08;
	Wed,  7 Oct 2026 23:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] net: stmmac: introduce XDP multi-buff
 support for TX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179141641178.3735789.348400294857878106.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 23:40:11 +0000
References: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
In-Reply-To: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, boon.leong.ong@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 01 Oct 2026 11:26:11 +0200 you wrote:
> Extend stmmac_xdp_xmit_xdpf() to transmit XDP frames with fragments.
> Fix TX coalesce race and div-by-zero in XDP/legacy path
> 
> ---
> Changes in v4:
> - Add patch 1/2 to fix theoretical division by zero issue in xdp/legacy
>   tx path.
> - Link to v3: https://lore.kernel.org/r/20260925-b4-stmmac-xmit-mb-v3-1-ca08f029e81c@oss.qualcomm.com
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: stmmac: fix TX coalesce race and div-by-zero in XDP/legacy path
    https://git.kernel.org/netdev/net-next/c/237782c3d416
  - [net-next,v4,2/2] net: stmmac: add XDP multi-buff support for TX side
    https://git.kernel.org/netdev/net-next/c/74c553648fb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


