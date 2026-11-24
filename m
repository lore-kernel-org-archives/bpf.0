Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491011;
	b=5MihpT84J/MZBFdh9BICALBRsnn8FAjH69mhwnNSRbvuzrv6XtrIih+0ZDx0Eu5qVXQV
	 1/TeF205keLs9AcYbWqqbe4ldHNkt36ZNQZuS8J5vaParRkQPly1rMDGtxA5mK2bPRchI
	 YWtf/v2tR8Yq8QLFE24doc2dViVVDCL7oMgEi0eY51n4t0KlsI/cGH54xGJB8SYOdZSR8
	 SEg2TQxi8UxaY1LtJG8v0dtBB+P/vz4LpxTWZTxd7e6pu8GmNExU0eCuCQCk9ieQ/9+mL
	 +3KSv2utjzttuAU6fk+yxiOoWSIOvHX2v4SSRHG7x9Y8ytVHFp01vUhzm+WdVWxLm6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Hrtd9aykcLs4LwrELChQWcfLvuM5gLZORgIyOfyzweQ=;
	b=2qfo7bj2/RSBDs1x9UlFo0uGl12fA2pb9QgTJlksancGaOduy4Jtl+IN9B0V5brxJFJ3
	 EDQpPUmEG0Zxp9SX4diD8VsItOHzUbvxyQ2P358RjJWOw7yrEz3cW9HzWYDwnFxyLrdJM
	 nAmVAysRNw2nwfv4fwbN6QMUcbfnn8eQR5Qq/nTgzQNrVoY2++5ScASyCk8MqxCqSLl9x
	 OPQCCph2D2x+UR+v8JbKzna0K/wOjeFFk2BBRae+H1HevWtfO25hWfjVPxRruKVA7IXIM
	 GWcS5IEMD3L4Ece+50lgzJ4nO8KhUXCbqOGgdQ3wbBTVmTQpWWXS4USZEHrVe+j7/iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cy9hYumC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCB606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cy9hYumC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD29A1F000CF;
	Tue, 24 Nov 2026 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795491010;
	bh=Hrtd9aykcLs4LwrELChQWcfLvuM5gLZORgIyOfyzweQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cy9hYumCYD1+XMMFfB9WoccqObrcLnHfMFUM15VlJc8tZQjD/uUTLx7zuBRIEWkeb
	 UMKkM4vUFKanrjRw1dUPaTSCIjJg9fwerglsepBjf4+PK9DFuJkZkXL33kCUfV9hTJ
	 daM5gIs69WfuwhR7wPTaOSBMWCJf7VI3/3T/4MCatJK/FciZXJMu76FV2DwjYJrg1V
	 N1ZTgM9i7i5lN863zn2xe4bU8pmsOUi6MA1BkL6pMQh1LIRBNkRV8qaklBo01z4pp7
	 d/koytv4pEa2Wv4dktZ1iy+DJtsM2GKeZ/87K6XSTCSD79k26SZmRi2BizcOP3Nacr
	 9iCFRw+wxc1kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B449B39302D7;
	Tue, 24 Nov 2026 03:30:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] bpf: Force BPF_JIT on x86-64 and arm64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179549100927.3259463.11786725199313565138.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 03:30:09 +0000
References: <20261123205713.4094553-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261123205713.4094553-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Nov 2026 20:57:13 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> An arm64 kernel with CONFIG_BPF_SYSCALL=y and CONFIG_BPF_JIT=n is open
> to Spectre v1 if unprivileged BPF is enabled. The verifier adds
> BPF_NOSPEC to such progs. The interpreter calls barrier_nospec() for it,
> which is empty on arm64.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Force BPF_JIT on x86-64 and arm64
    https://git.kernel.org/bpf/bpf-next/c/6c725670966a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


