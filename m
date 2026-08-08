Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D7EEC0;
	Sat,  8 Aug 2026 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147851; cv=none; b=YAMuG6665nfQSmOkjftP2l4mFJBaPWxqnQNabqY5hRP/HVGaM2reEidq8dq6/1HXYHJA9loeV7suf5ONDpiXAL0oGp4d5u2QrtmTNPo2pLBREGNxa/PBbJ1Vw8dspPG7VUa8IIpVAzbl/zIAZulSZ8bORcfkngDtNKYzteHkVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147851; c=relaxed/simple;
	bh=y2v5yEx1ykxuqIscpI+kikZELGWq6AtiOQM6cPbVjzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kTAz5FTmMdQuXjauTZqOMDV83Idcr1c2WEMJ2lsLBE3Ht6rjm0JE7AVJDSSuyFbgk+PH/XVdi79WEEoWajAYC2r5NY3wJsXZ51wImpGxccpPmx3o2DyXo+I/D1eY8I7J3nMiT3WTfVO7oeH78i0k+YI3ryp+hweN1bqHp2sEm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5KgZ9iU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5KgZ9iU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0111F000E9;
	Sat,  8 Aug 2026 00:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786147850;
	bh=w7F3AyY/5h0rb3HIwTJQQ/4aHuhHhQV79zFLC/ujako=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n5KgZ9iU+4e4aYggYm4CoK9o+v57gEXeI4f7NgGGFPfGnpfv0IX+Xl/IvCU/d/1/Q
	 jMwUCcxi8n3eTlYewMXTFBSJWXAVrMNA7bPKI2+w5iyhTpKvErVfgSnRwEZfB3nsOl
	 WNbjCUMsRMLAhdeQ8tloapqMk63kQEH+d4pJRIzeIIEZBEQty8q4bEzJDH53nPUf4b
	 Nk6S0XlhGERAUdRw1VEWbPv15hJQZa6yHVdYG2xJSBqdXK1zsefEwxNlGwO3FP52v0
	 n/7KOWWEfSajm1viiEWC7OJ3sMO28po+BAX9/MdnsGYucqpCOXzi8W+PVJhw+t0e9n
	 QGVi/S91i8bPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AA2380CEF9;
	Sat,  8 Aug 2026 00:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] fix skb length accounting after XDP frag
 adjustment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614780893.2472232.3476445161092062849.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 00:10:08 +0000
References: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 22:40:37 -0700 you wrote:
> This series fixes skb length accounting after an XDP program adjusts its
> fragment area, in both the generic XDP path (net/core/dev.c) and the veth
> native path (drivers/net/veth.c). When the fragment area is resized,
> skb->len and skb->data_len can go out of sync, and in the reproduced UDP
> receive path this leaked skb_shared_info contents (including a kernel
> pointer) to userspace while truncating real payload.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: fix skb length accounting after generic XDP frag adjustment
    https://git.kernel.org/netdev/net/c/33f2b2eb33d6
  - [net,v3,2/2] veth: fix skb length accounting after XDP frag adjustment
    https://git.kernel.org/netdev/net/c/cb6379feaaff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


