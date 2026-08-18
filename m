Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4622D8796;
	Tue, 18 Aug 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051455; cv=none; b=A4RVrbqRvGZn04NNfwpe4H3kYgP0tM5PMxistWOZuh2f8mR2d5dBjt4lh2HlPZ/Xl3SHpQXMiSqF5Yz4ztZWdYDJuvL5x/YmlvMjhUha2uWUVWeTH+1ja9VOFv7QZw2Ivb2/JKpIzAyIlR7LHXtWmhBkMeWZBFeUrmGwuLGcQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051455; c=relaxed/simple;
	bh=3X7/dQ6bTg86rXCSwF7IbJzGngg33AD/IShGwpoyeOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ikybp8x/UCArk8lyxTpUpcTWJZcyDi7No4Ul85A+Ai7UbvbmN0V2irVvYAZyM5nY8L01RDIslqmf3ehAssmmxkB/IQLEZVxK0qbCKP4L81k27SIJbtSoEIcTF712739flByyP6FFjxYvzBP8CP4eRQLHA5fOC8pnmHJgtSU6pTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmB7VVUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmB7VVUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B9F1F000E9;
	Tue, 18 Aug 2026 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787051454;
	bh=4VarVjUxbU2bNbt6dSVmQC6sjss0nJg4rZeCCoW6Y7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PmB7VVUAsmagM/5kee0NUESrCc8djV4SLSW0l5Vq0x6TI6Of8bF6cRM/HPIALuWLS
	 tUygB1ol0eWojZn9a4fmP8x5MvSKrAmGAsyFH9Ac+fxepH/wvJ/vNj6st+SBbqLp33
	 gdkLnjB911sQNTOf4G0Kv83EAbvsaWmIkY/PmCETyXxnWPfVyzW6kkyYCZnXJUBbn/
	 QC5AcxWQ14Lnpgd8ZZnjLAP3NboboDMEnyCIJa+UCUPUGCBc0dht//AsCsJR5fuPk4
	 mq9gULsF7STMdVuTNmAoF2Oy1LHapElxUtC2OLt8c+uQlzK8Q9FSRoZFuFw45fyOHD
	 eqbMhQGNhOa+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568273926658;
	Tue, 18 Aug 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] ip: orphan prefetched skbs before multicast
 forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178705140589.2028744.11274670506233013396.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 11:10:05 +0000
References: <cover.1786552223.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1786552223.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 kafai@fb.com, joe@wand.net.nz, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Aug 2026 00:36:37 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/ipv4/ipmr.c and net/ipv6/ip6_input.c.
> The bug is reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] ip: orphan prefetched skbs before multicast forwarding
    https://git.kernel.org/netdev/net/c/e36ce6e78fe3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


