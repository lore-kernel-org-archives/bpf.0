Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795406;
	b=Y/2dRAcmiSOFiKTmYFBYuFKrrA0sMdEgTNELtbyoEKEeDfor96BZogJ5cBTl6Or7BmnV
	 RYfnC4HbnaJ9OJ2xJlBFYtJDf+N8lZOt5u3KK35rd4lVt+ERmfnDy21SV1ulPVqk+25Hm
	 cr1hu8yvu0zyIycCAcG4S5q+P6/lxnWVIzMCxRXovN+Ne6ww0A89puUzAhqbpmNXxyLG6
	 Ko9yIIueHx+TJrnMz887aahBQs/yBoq7rAzJ4Y+/4GvR1NIdRH28K6sd+OPFN4Sl7L3+P
	 bXHb6WEnIVLFsUogBbUIINhGr3hNSxme6hOxfJIcvSpLVmIVx6goRDCX47skGsfJBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=k6J5Oay+doQJoJNSxtmcBiGyQv209ScAO6Mt3sjwyK0=;
	b=KZP6t13+Rq8E4IfrFlm0NNWd3kk1b5uuP/E9T+e4zSdN07M+i4lFyzNi+Zd2jJv8gB2H
	 ChsItssSfl3ya++4RQ8iTpgv9gJYWo3mxrWE6BUc8qZhtOk0blCmqvYFfiQrvDD4QNzjR
	 JZF9mPBjCCZs30YqBWJjkfshU5E4eahzLvVtZ0igyGm984DmtFZ74mnwTyFllQHBr4CZX
	 plRx5bZe96cal6F1wLVJJrdkifoUuqTkxi6b/wCibtX5kul/5OyxVeDWX+i94J9We9/BX
	 SD3jvxcponNA4Nz6oVSU4G2fBdnvvjBrQMecbfndBsAQopoFdMny0YjFsUzPXGK8zUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhGYHuX1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839F606A328;
	Wed,  4 Nov 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhGYHuX1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B651F00919;
	Wed,  4 Nov 2026 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795405;
	bh=k6J5Oay+doQJoJNSxtmcBiGyQv209ScAO6Mt3sjwyK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PhGYHuX1DuAPDH9YsQZ/gsFZr2FPpvNjUIBJOnl/5qg3cuIUXNXC1A1eK7fXy8LfU
	 LTT6i7JfP6jz7SF5mjVxlbBaKJBuHqwJJ9pjuK2WCl+utgWrVG96wiHpNhAnNP/JR2
	 2QSvuyyFj468m2ADkc7329EgH8wI7S7vbbnQsOTz0c1eYIrfomRv3nOOp2kAzMPQGJ
	 dxjsGPIH+wk8y7QTQG077KJFmWfj+FDMV498gaVr64nTk3K9mTv4EE2WSsMxvuQi0r
	 01kYlbmw8xA93mCn/xNiohXEewx2QN+j/DuXyTvoe86Z/SpJ6LKd7mFLcwxCPIH5h5
	 lrM4duSKdVHbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA39939D60A0;
	Wed,  4 Nov 2026 12:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179379540455.2315543.14713236386636383599.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 12:30:04 +0000
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dongchenchen2@huawei.com, bpf@vger.kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Nov 2026 19:44:33 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
> offset, in the unsigned hdr_len. A header in front of skb->data gives a
> negative offset. For an offset a little below zero, pskb_may_pull() gets a
> small length and succeeds. Then a 64-bit kernel reads the TCP header far
> after the skb and can crash. Further below zero pskb_may_pull() fails.
> 
> [...]

Here is the summary with links:
  - [net] net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()
    https://git.kernel.org/netdev/net/c/35d2d6e5ac0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


