Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4D44E045;
	Tue, 16 Jun 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626219; cv=none; b=QbmIkXtLW8toOnJvoVsaO/3T7ZeWyb4/WwjWXeL8bqY6urT+w8oGnv5V91oRdg3pjxFuB0xzVyW6aVJ88T0q6Nu6Yz6gk8gDqkDRw6MJQkmUIZR0DBW9yPOghrlSzrdkqMaw4975smVwcW+JoRSKI3fmhqizCCbFj8ncMnreAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626219; c=relaxed/simple;
	bh=ogTgS1jVkWDMupmCeIfpN/zACidCFcsMLCYNh0k14Mk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4krbXjaVrZwvc/WwBa55OgkWw264pNo92pFjyn3y19j0ierdR2Oz+6MlHMOMtIHDn3Y+skrgjtOGbEMvxuckU4g8rH3erehCTH/fxfPjEQLb2jJ2nKGQUrw9rRC3aMvuVs0pMQUkB3wD6Va7vDDE+3clGXSO7JdgxYE3+vPArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8cNWj6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8cNWj6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4C71F000E9;
	Tue, 16 Jun 2026 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781626217;
	bh=iOEMBj+SMmhTxgAMAdDbP7Hgv7+uyAEdMJ2s+ta4Zmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W8cNWj6ZJ76nq1ZaMGWDK2BPGXPMMqaFkkJkaZMD69BX/dP2pcJlPKYlxftlzeVUM
	 Klt5erPAuRdRaNLWEETqEz5ohL9DptSUFxFO5OaJgkG+hnX2gcBDdF0NJxxTc7nY2l
	 avtQhogcxxA9+wcEDUQpo0aEqcKLn0aaKNP3d+PfyKEprUKGNxBrK2WExhs/Zwwdsw
	 yJRPBJ3UhcCc8AXvsEsNZ1YISAkV5tat1w5T2SUBI/04GHZ1TI8e6HzeIwHo5EwknE
	 Oi5G3pwy5Vfc/ihfETEiQi1Bwg4L9jCu06NIVtbJ1z6u7/ZOi+viakUsL+zZf+9bA+
	 ri1a8qf4tjfCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391E3930ABA;
	Tue, 16 Jun 2026 16:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] tls: reject the combination of TLS and
 sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178162621239.1143794.13386729126363922107.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 16:10:12 +0000
References: <20260614014102.461064-1-kuba@kernel.org>
In-Reply-To: <20260614014102.461064-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
 sd@queasysnail.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 18:40:55 -0700 you wrote:
> There are no known TLS+sockmap users and it has some known
> hard to solve bugs. Let's reject this configuration as we
> discussed a number of times.
> 
> Jakub Kicinski (5):
>   tls: reject the combination of TLS and sockmap
>   tls: remove dead sockmap (psock) handling from the SW path
>   selftests/bpf: remove sockmap + ktls tests
>   selftests/bpf: drop the unused kTLS program from test_sockmap
>   selftests/bpf: test that TLS crypto is rejected on a sockmap socket
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] tls: reject the combination of TLS and sockmap
    https://git.kernel.org/netdev/net-next/c/460e6486617c
  - [net-next,2/5] tls: remove dead sockmap (psock) handling from the SW path
    https://git.kernel.org/netdev/net-next/c/79511603a65b
  - [net-next,3/5] selftests/bpf: remove sockmap + ktls tests
    https://git.kernel.org/netdev/net-next/c/faf89584e436
  - [net-next,4/5] selftests/bpf: drop the unused kTLS program from test_sockmap
    https://git.kernel.org/netdev/net-next/c/6af8971d910e
  - [net-next,5/5] selftests/bpf: test that TLS crypto is rejected on a sockmap socket
    https://git.kernel.org/netdev/net-next/c/5949a7cf11e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


