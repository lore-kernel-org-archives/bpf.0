Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279296;
	b=qxHjtaNSYl0cQzE+Bi8wLnac3vOBl3XsHdrvTkc328TYaLA71GCObxewvlDiqkHp6RkK
	 kb4iinTxN3qBAHETtoM4DCBp+iOih2Wtijp+XUXEIBu4CBo/xY314O5QgAEOx4GZvXeD3
	 lI3QWijHun78ej0l72hHPysqAO1ejyn3gBwGcuDVRxAVgFd+O1Hv73bxDGz47GDBZ3nJc
	 mO2XEJqZnElM6Q1qiuuOw76DyxnPsQKOswZbEhrLyCnkUGuDa1ddqC6hFwt/ClZ2BQ6rs
	 cx9s/8G7+i7pdCk+8LH7o2ls8M15M1w8KpiGaXSLTDZoGChLwaj1U4tObW3EX+vONRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279296;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=U7V5XEhP/iiS/MAVShkGjf266XIw7aocN2TQf5MlDmI=;
	b=dow9K35OcXYUGQ7JHxMhUWw/02Ad0xszAiHbfb+EVTD0UXzBisUaQotdaCEsvlXYCkk7
	 dbIPzEgjvLQCLCtMfnOQIFJzS3e+X+PnVlF0wmrx502RviTzIU+2IZFRa9+can1Uefh//
	 aZN/6d7MUVKfTyzCtZmrlzkPGhA8fEHf52wHbpC9IaO/lq8RhP/O7impozvhjHYxW3WFO
	 t0lgLMeQBf/RB2CN82Kllp2y7GlbbR/O1u2YYwj2dkSqe0xjyWPVVtuTzYBnRbGjX6gF3
	 L2jc6Pcx3pvfUbMa6SKBLvVw+1MLqc58d2Kn9sMHqfkMuouNqSucHJ5NuNpM4A/+9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCyEvR4i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B5606A339;
	Tue, 10 Nov 2026 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCyEvR4i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39661F0089F;
	Tue, 10 Nov 2026 02:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279295;
	bh=U7V5XEhP/iiS/MAVShkGjf266XIw7aocN2TQf5MlDmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SCyEvR4i1diKT6f8VErdbh2u0FHcQS8GhpspORR/0pPUIdHXiObf7ZZHB7uBQ6yI5
	 WEfzSxCCn07UWO524ghPDTOUT9g5M5u6If5OajPJCbFnXJ9cDUL/CZzPhfzyRIdK8D
	 IqCQ3TlD/wU9zbFeKjCTb6nrjibK89B4ijr4J488avzBbjPayE0EBAFtJ30MmUEyKz
	 hcnty3zjrn6Ut4yHSuBJ+ngDBSSce0we9hejQzcrnBcRqF8JYdDXwudXpKfaP9IurJ
	 KmYdtU9o5bPuNt0Hvpk9CE7eEmt1uWoJ0urrfMA3YogbaXo128YD7CeK47ZpZX48dB
	 U30nkbCD67aOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B190391AFCB;
	Tue, 10 Nov 2026 02:54:55 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] docs: netdev: fix iproute2 process
 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427929417.3612825.2487623260094392811.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:54 +0000
References: <20261105184510.3230744-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20261105184510.3230744-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org,
 willemb@google.com, ast@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 13:44:51 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The instructions on sending patches to iproute2 span both netdev and
> bpf docs, contain outdated references and miss some instructions.
> Address this:
> 
> - Move all info to maintainer-netdev
> - Add a link in bpf_devel_QA to this location
> - Update URLs to git repositories
> - Update URLs to patchwork instance and delegates
> - Update subject prefix rules
> - Add suggestion to Cc: maintainers
> - Add pointer to iproute2 MAINTAINERS
> - Add pointer to iproute2 README.devel
> 
> [...]

Here is the summary with links:
  - [net-next,v2] docs: netdev: fix iproute2 process documentation
    https://git.kernel.org/netdev/net/c/c597eb68599e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


