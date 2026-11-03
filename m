Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698806;
	b=uL8cajN0L8iVEVvT4EIQw1FOReDKOXr7G6U7zZ9+YQpr+ivrzDh/LzakDMyaFYLY23gZ
	 dYFlEHP9oxU0bUnzYLrLC86J7ogj8Um8FREeaRJAW4+rzuFCtja7t2mnt14X22XhgO46M
	 hDEZecKh1p64kEK+WeUwiMacf/ov1nR0Ri40DOfc3yW0iLdMbGVYfxCRix2yvdrW57bzh
	 xP9sa5Kya8hOwcI6CVEVDldMaGaKoi9XQQaUT+Zebsw+Kb+fyfjrIY0oJkEpetVHj4HJp
	 FqrFWSUdwjL9zrSYQOC8nfoh8ON2Hd3lOQJnU1jYrA0rWiik13GcqcqnpN8ViTdWGOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=l9NYlvgHlUWqzrB8ItT1431hoKjJzv5jDHoE1wF/pE8=;
	b=xoE5dO6n69tWQbLHqMWYILGGQG/Ygt7Gw+Cs3F7scARWbng2B+8Tvx69n6NX8WaX7mAB
	 of/DttBr9zKEnd7oOr2kbk5F22P/4jXbvAJXLw+PTKIi3m44/hy43LpzFHo/7pMKHhsIw
	 s5bXUPb7JPSAEmVL5byQCZriF5nrepJNwXxy7YBgDa6E3nGbYqSEHki2KvzJ4oxJdaIG/
	 QL8wYaXvmxF5YCfzntg7kWHy13zYwwa12ubwkasUqRr9wVlEUE8sCa+GIvAKCeCpeHFcV
	 n148nWe1mABEjcmnksnsROLYVkLeBgyIycJ7G2ZiIOCrbuVdhYPoX1GNTs9vzgi3hpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jea4Zofg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C6606A327;
	Tue,  3 Nov 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jea4Zofg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C904D1F000C1;
	Tue,  3 Nov 2026 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698805;
	bh=l9NYlvgHlUWqzrB8ItT1431hoKjJzv5jDHoE1wF/pE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jea4ZofgkJjMwLA5ETMUEGEDhwlRHat2oE9vgMNHgWOsIKp7O6VoWTr3lo/r1ZyKT
	 IaeWPOrXT/VPOdAHAWkUSaVS52mdHaONSEvnKSuiTVKjWiyHJ8CtfvEb1gHmQTrxaI
	 nm3DYcV7WDSyKXrN6xvkb2uGglJa9YrLeOsFIRDR6v/6U2NbqvlSkSDU7/nm+k2h0I
	 FA3KogDeaNO0PE3BJpLm2oWllFWha6lSq7k0U+7OeXYJMDcjPfd3eQKjQkWZlDeT0M
	 Z/H6Ho9niWN1sFoosFBtUwKZfODOwfubHDJflcKTTtigSZL9cByJdyNrZMzWl0QFjJ
	 wU1iMQK9TcE3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3153805CCA;
	Tue,  3 Nov 2026 09:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net] eth: fbnic: Report the logical RX queue to XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179369880455.983821.231132787856931883.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 09:40:04 +0000
References: <20261030141452.1173282-1-bjorn@kernel.org>
In-Reply-To: <20261030141452.1173282-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 15:14:50 +0100 you wrote:
> fbnic reports queue 0 to XDP on all RX queues. The XDP RX queue is
> registered with the header buffer queue index, which is always 0,
> instead of the completion queue index, which is the netdev queue id.
> 
> Any XDP program that reads rx_queue_index gets 0 on every queue, so a
> program that uses the queue id uses the wrong queue. AF_XDP has the
> same problem: XSKMAP finds the wrong socket, and redirect to a socket
> on another queue fails.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Report the logical RX queue to XDP
    https://git.kernel.org/netdev/net/c/c8848b2ca6e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


