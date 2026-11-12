Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513606;
	b=05af1M9u7P+h9IjyHjTlicERzwikYUip2oI1vbEmLUrIhgVD3MeUB18hM01O08ZyzAUh
	 yhi69+4ieD6r0/rhiJ5wG0vFUURRT5pyoknJE53T+wsNO9eaRclHh43BzngNPqLRnwYsA
	 8fDP21b1WPauqkQIWLd1GERDmWCxiAYF1ayAJie+17PKU+irDB8YvElRpyCqoNUgsVQkx
	 dDGTl1skPnkn+34P91hK1GqI9/BHjHpf1lmpiAYVW+1WZT/jSveV1ZompNbYJg5y+ZVwV
	 TZgCC1uggezmB/Fv60VRyMMBUR24zLUdsIlBfHENkuLIBoSvXsz8x4qHqeeHX3qYWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eADNhIR/8AdgtYlqwva/DUsocjsGydfTGfDeMLQXaJg=;
	b=o6ZMCxmlmcoLHx7SLc4fmi9w4qm5sg4ChoQGuNhqwmf3rfRMO3as0wcMukKMWO7Pklnr
	 nAs1m0UhpmQACLmzrDMmywGu4d9OCJrLIoI2p5Ct8ne4i7DvAIzTF7DRgxpERo7dhtGcu
	 dQ1ZXCItKB1FVJzP4eqrV05AD08pVf78M3wBPMrhuF0QVOzjLNxpWOHJcFcs8OVDHEhao
	 vxmvgRqE0H9vp3IAdyIufx8dO/GHdNPYJdfBtdyGqMKTbQImMJzVojvXTRkR6VbhUEFR6
	 OgvcJXRfoHCtV9cLyWP6vHlU8z8BlPbQsNB/zStIoW9ufo383n06EEFbIfXxSFBL2Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQAPZXoX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244E606A32D
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQAPZXoX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DFE1F000C4;
	Thu, 12 Nov 2026 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513605;
	bh=eADNhIR/8AdgtYlqwva/DUsocjsGydfTGfDeMLQXaJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jQAPZXoXGF6I0T3JJxItMynoQ4Rv84Nqjf1oBxnxQ4IAU6YVBZUbSzMUETPJzmgFe
	 /B4AgQADDqGCiA2uwo7jcABq0BHNsNUUQ3z/JwHcltQN3jEJGabsBEh7mubBA+EAIm
	 H6EwA6JHt3sCKuyRCZz551u/G5wH4uiUiWzhseswqSyB30Pa9InD+XuTRgnwX43PYp
	 24rMRzg2ddp7l2YJYoUR+wc4oo5ZjkP8hDUdZCah8wvbN5RrcuiegJXmh/qrPIfIMj
	 gthxC9lkUZHE72eFxdW6/+FKiPLnVlJgZGnQn8FCp6irELusvkUFN0IlTfvF8S9LjH
	 4N5mjmvHpPC6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7737F3926259;
	Thu, 12 Nov 2026 20:00:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3] bpf,
 sockmap: Fix ring capacity invariant break in bpf_msg_push_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451360403.621483.1862904929520371421.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 20:00:04 +0000
References: <tencent_F9A4094B6B79A77230BD540754D65D17BD0A@qq.com>
In-Reply-To: <tencent_F9A4094B6B79A77230BD540754D65D17BD0A@qq.com>
To: bo cao <treebacker@foxmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Nov 2026 15:09:53 +0800 you wrote:
> From: Bo Cao <treebacker@foxmail.com>
> 
> A push at msg->size on a full ring reads the length of the free slot.
> It is 0, so nothing is copied and sg.end moves onto sg.start.
> The ring looks empty and the next push overwrites live elements.
> The prog needs CAP_BPF and CAP_NET_ADMIN.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()
    https://git.kernel.org/bpf/bpf/c/f6562cd116a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


