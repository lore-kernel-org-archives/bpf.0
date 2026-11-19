Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129211;
	b=DYlONcq2rvnTVhSP7hw7rwiJVVFfc+N5inCu/5Gfoqvs64qabSSTkuJOH7v2FGNklHbG
	 AqWe24J5Q4hq9n5qe3OP6+MK4ha4z3IXJ4+2HrvuIxXrjo/JddyppBBnmW5vPP+6E6gNl
	 Rzx+hdS2fL8y7g1f8GdOPWXbGvtCcfV4vGli2rPoSQeKP0VMaHrrPKfPc18uRZ/fVedwc
	 RtABevWfzCWetJI/on14Fa2EuNUY4K5n0hGcVetrfCSdMwk955DKTlgke5mH4JZEXxrzx
	 lc8kMSgUTBrsDAEkVPzCBeGDcxBkv2+A/1eYIp7rliI4L8ykA1FMsbolU1xymNIujyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129211;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Vxioqb6ynVoESZaAK+qJnQo35AEnItFLxbsiEAit+rA=;
	b=4oa5qjt619iPZou4pa6qqMegw12oOOfhojycGdYi/jNxmGwopi29D3b3wExQ3RbqggSP
	 w6OdyazxDe64C9UTEOWyTyoKIwp8VkG5WOvc2EtlcHurKI5W0VMEQX6/I7mIMtF9JNuXZ
	 7SxiRI/OTe2ivvEtCD0U2i4XTgqujx+wtt2DR+LpVUAMwTg1tERX2R9f7AlRz4zIraiID
	 RYnMCutZaFN/wMsrrSRInb1tzpGYgBN71gjOQ18uzHgzyRpu6mGDFClz6gup6uzYZMA/5
	 PTIUYQSP/fXRN4UsMQYJaRYZJFfMbV6+hUxezXuUNYi37U8F3SG9nx8V4VGpgvMhyjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItG4gbqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD2606A320;
	Thu, 19 Nov 2026 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItG4gbqT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7151F000C4;
	Thu, 19 Nov 2026 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129211;
	bh=Vxioqb6ynVoESZaAK+qJnQo35AEnItFLxbsiEAit+rA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ItG4gbqT2mngKbv9I+k33hSnQXNFW5uaUk+4rxzYoHa+Qhk9KhXlO98+6n7E10yjJ
	 OCBtWt5xub77j66unQYkm93mgc3yI07Ka/ok+uA5g3XaXoVNZhl2SQcGJlVQkdov49
	 6MjCho6T3zJgcM/oH+ovh44ObbRaqtOVE7dckVrErGs74wrJZUyT3iSiiANfiTtMYb
	 9qLH/+U+RoMNYQY983j6FkqkS91MwU6rNPoZzb8cU+2UasPLgUxc5w8b9dm2uBzQbA
	 IyLljWRphoG55unvAnVf+FigDwn1YIU9OnAPqgHRhhcP0bVwkfCuu5wNoPlJhCzlsw
	 n+AHoI2Aqcy2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14723808209;
	Thu, 19 Nov 2026 23:00:10 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3 0/5] veth: link RX queues to their NAPI
 instances
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179512920952.3911009.243890206778536445.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 23:00:09 +0000
References: <20261115193531.57679-1-tianyi@cloudflare.com>
In-Reply-To: <20261115193531.57679-1-tianyi@cloudflare.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 lorenzo@kernel.org, horms@kernel.org, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, joe@dama.to, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com, tianyi.gao@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Nov 2026 19:35:26 +0000 you wrote:
> veth does not link its RX queues to their NAPI instances, so queue-get
> reports no napi-id for them. napi-get lists each NAPI instance, and its
> thread PID when NAPI is threaded, but not the RX queue it polls.
> Userspace cannot tell which NAPI thread to pin for a given queue, or
> which NAPI to change with napi-set.
> 
> There is also no way to busy poll an AF_XDP socket bound to a veth
> queue. xsk_bind() takes the socket's NAPI ID from the RX queue, and a
> veth RX queue has none.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] veth: refactor NAPI enable paths
    https://git.kernel.org/netdev/net-next/c/774a5a756d20
  - [net-next,v3,2/5] veth: link RX queues to their NAPI instances
    https://git.kernel.org/netdev/net-next/c/c6d21717a602
  - [net-next,v3,3/5] selftests: net: veth: test RX queue NAPI links
    https://git.kernel.org/netdev/net-next/c/5335fdbafea2
  - [net-next,v3,4/5] veth: use persistent NAPI config
    https://git.kernel.org/netdev/net-next/c/3c04f86ffab9
  - [net-next,v3,5/5] selftests: net: veth: test that RX queues keep their NAPI IDs
    https://git.kernel.org/netdev/net-next/c/59bbe682d4b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


