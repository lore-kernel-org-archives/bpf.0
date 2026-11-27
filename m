Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776006;
	b=Br3vOo/+BybioZUUF7H11RxlTbt7C5xFZ4jqnN2ZxUVDLiXOThI+R5gq5BX2FjWMuDwH
	 npKa/ajNHhb+qH/LMB0bOzjjhIuAl7r4ythXMElahqSDCByZVujvpqRh6KAXuTmiCBy0s
	 iSgVBrYyTsdwYY6ghO7wI0b6+v+ExcfdxrwOS+6nPw5X08U7YxyF68w0WXMrOgXf1Xpw2
	 J+pMcKv0zmGKSkhDobuyhhcNY/XhNxQf5ABsx3UR0ukkZ83EQq9vleXyi6PWFqdqWRN/x
	 lvbj4RidK0Mjki7cEUFgyU5Q5Ywt+pUPciq06K5OqghFYQreYVDN8HtVeojh4BCGP6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pHV3DUpd76XiDAZxihmr+LCQ5S6rYdImM4dkHk4pa1Q=;
	b=hv4RN/YFsQmeHzNdBHdXVsMT1Zv36EBLjgRZdBPUHE8do8ta0Gv0MfgrM/c9AkyHwAHe
	 1D9hLz7xQvhcqzeAXEdqoqeoLBOh8EVXMSGwsSQzW9sM8GcJoTtL6Q2ZLS/yonlneUkrc
	 n56JRjudWCPEafrJd0q7Vfrqlj8JsRzecU7zu90tVk3A/8qPjNhs40bBmNeCtt4hl/XXy
	 UfrGQTSUpU91pUpkxl/SViLpeK80PPFv/63C2m5VdGuLATti99XDJiRGwCns1E8iv12ki
	 LwmEWCie6xfGw4JiyfScFnV5rPUq+1+6kGqG+jEKgZlwhlqTj+g8/aKukPfP1CYSqDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zx1FdJlT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACD606A31E;
	Fri, 27 Nov 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zx1FdJlT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B86E1F00897;
	Fri, 27 Nov 2026 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776005;
	bh=pHV3DUpd76XiDAZxihmr+LCQ5S6rYdImM4dkHk4pa1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zx1FdJlTdhEkDqVQB1OUusG19jvT3yn9/dL69t52YjVChzitvy8Mg9+jzLNTxnn9c
	 VvYIcTR3BbOTtpWE5LDRPfBxhdab2o/4X/yxy/dYKYKhpZ1ocFjzWXL6qMoYXuo/Gc
	 TiAKKgWLnw6rdCH4IBV7cPVaPoxJwPK9aXXWTUdSDTwy4jgDff03wEfF+ZBG/oyeDz
	 2JlgXosI1umEbAIIcjHyWRt5WlFAQ5dzV/oTtWPcJQahszzpaSl/60JM1eDH0FjeDS
	 aQASoKMoXp8TPcdnAPF+/spmCPwRf+UoYLM1a3PHlqWnPjMFU7v1PLz64Yt7HIYxp3
	 1hfMrWosRWOzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716E538003C5;
	Fri, 27 Nov 2026 10:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: lan966x: return an error for XDP frames that are
 not queued
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179577600425.905521.1768225417330969328.git-patchwork-notify@kernel.org>
Date: Fri, 27 Nov 2026 10:40:04 +0000
References: <20261123-lan966x-xdp-xmit-errors-v1-1-f25b6661167d@microchip.com>
In-Reply-To: 
 <20261123-lan966x-xdp-xmit-errors-v1-1-f25b6661167d@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Nov 2026 15:54:36 +0100 you wrote:
> lan966x_xdp_xmit() counts a frame as transmitted when
> lan966x_fdma_xmit_xdpf() returns 0, and its caller only returns the
> frames that were not counted.
> 
> Before this patch, lan966x_fdma_xmit_xdpf() returns NETDEV_TX_OK, which
> is 0, when an xdp_frame has less headroom than the IFH or when its DMA
> mapping fails, without queueing the frame. The frame is then counted as
> transmitted and never freed. An xdp_frame can have less headroom than
> the IFH when an XDP program grows the head of a frame with
> bpf_xdp_adjust_head() before redirecting it to a lan966x port.
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: return an error for XDP frames that are not queued
    https://git.kernel.org/netdev/net/c/0651cae60e84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


