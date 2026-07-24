Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8C41378A;
	Fri, 24 Jul 2026 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931047; cv=none; b=AReBDl7Mc1p+c7sW8QN0eizjj6CP3oO+P+wVr+5dLmYA4eYRJSUGlLMcSPPHnAESVQRIXRCCntiuRdf6AjDeCwJ59PcEdjelTJtEfrem0UuXudTp/rXsMps2a8l5uOGibEjA5LegKRdwHL1YHAH3cdMp0+YL4x92/GoGF1QYEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931047; c=relaxed/simple;
	bh=yUGqR8d+w7J9S/tOLZRyEEhqfl7wrkbb7hFP6l+Vy8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GP7Vq0Ud6iC19ISViIE/0JxR+kdPwcWC0Y9we7o8ilf5HuLBbsNk9TKmwZvSZYxQoyfU+md0XdAu9E05MlFHhoNhKLYaUC0x3Hts/b9JUDQ3uy7t2FGFzjBu6u4XvTEDzsNSITPWenIRRUUhoHwMYqqR3hrA5fRoaT/V5UpIPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n01KEyKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n01KEyKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65FC1F000E9;
	Fri, 24 Jul 2026 22:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931045;
	bh=8uFQEOw6L0JAgFeR5Qb6WsRh3rOhAI5RJb9ONA74SSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n01KEyKGdBWcLPcIE1Q/pLSe0VwjQeHpagS05ftRFPeMtF3JYMAoD4NTgC8efE2D4
	 d7VsRwhPmorHWj0cFB8yxK7CN0QiiBiNVjGPxs65zagcFEzXEc8JBriE/xS9ko3Qxh
	 OhxZzM9fVDyFwVz+2XjfHXRZrOtpsaDa3LerpvC6KwbcllTYVGQL5C15FodwAZruTz
	 sSd8DWAXgTZn/21orJgJNRgwtCQKAxUbMIFh8mRPJkMTofWxTqgO8//QPEJBeoIh2y
	 fqSrgEEdgSxejbW9+zy+EDVyacsN+9W74ociQFPW74lhHxRPkLu8m1j/ZzBjeD1FaN
	 TTl92b8J140YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987638111D7;
	Fri, 24 Jul 2026 22:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] bpf,
 sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493101265.3330129.14153213405975087302.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 22:10:12 +0000
References: <20260724103856.3399001-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260724103856.3399001-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: emil@etsalapatis.com, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 jiayuan.chen@linux.dev, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Fri, 24 Jul 2026 18:38:56 +0800 you wrote:
> tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which
> drops and reacquires the socket lock.  Its error path tries to decide
> whether msg_tx names the local temporary message by comparing it with
> the current value of psock->cork.
> 
> This comparison is unsafe when two threads send on the same socket:
> 
> [...]

Here is the summary with links:
  - [bpf,v4] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
    https://git.kernel.org/bpf/bpf/c/2d66a033864e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


