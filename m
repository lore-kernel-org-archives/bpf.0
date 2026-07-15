Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A941D65D;
	Wed, 15 Jul 2026 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107236; cv=none; b=VJVZPAu5NNRXFTwvtAczw8ZG7AOmGIV9HVrAJIiprnvSvNVLa06GtrY40avD3fjk+7cudg/qqa/aV0zgl/qHNMVG66xAr+AdUWXxhmxky/U/w7D7d6wPW0dLOPaGUSEIlSG2ZsT/72pHKJz2ksLVOC6C7s1ct4dwLTwJGtlH/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107236; c=relaxed/simple;
	bh=K3lc3/SJqlFIf+u1/wXLZhZwPtLLwAmXLFruIwBFY5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M6o460lXGzaNIdMgZRUaxgQo9mczMbobOd9uKl+HRp81cwae1dIV7bygCEzvOrOyN7XGlPMdkrzUXG+NnFhCL++2vHyI0g5D2B9AJsXR62G4CfEmivo92t8HWK2VGdjlBOLznnMhpUwM/pztJ6mRoIzL+eAgvBBFNnZNNvxBObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAudLFSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAudLFSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93911F000E9;
	Wed, 15 Jul 2026 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784107234;
	bh=BvW5fMXW2I+0++iWJ3nKKN2dWxiW8VsR77HyEPA+1KQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kAudLFSaTK7FKUkJlIQ1eesZNmS8g09P6PxxZFjV/QRpY2UvASF1GK0LuTlpkSPvG
	 UxYOj0myM2OazqUuL6vOk714kT3Ju6hnY6zAPi3PQ5L7ZjO6xz3E38C4qhHBv6cDJC
	 mh5zwcUvIJ74uLZQ0fxY0qqAGoEtQt0vN/aE3L/G2v3DECaBGDR1sDKl75H4aZ6nQA
	 c5pJHp0ck9rV4G4JO1ifUK7GFqdUAyIrGjVcd5zQVeEVMZ9AXFUYDv2dYTYFT3FZo2
	 OxJqk86ONJk82oq5ac6AyXTNw4AzrJq2NXrOfZuJx5FuB+j19twDEhnn4cSlwfvgv6
	 i4NntyXcTbLaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199553938E8D;
	Wed, 15 Jul 2026 09:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf, sockmap: Fix FIONREAD for sockets without
 a verdict program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410720889.3980181.6978995644978494942.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 09:20:08 +0000
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
In-Reply-To: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
To: Mattia Meleleo <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, john.fastabend@gmail.com,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, memxor@gmail.com,
 emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 08 Jul 2026 18:54:59 +0200 you wrote:
> Sockets added to a sockmap/sockhash with no stream/skb verdict program
> attached answer FIONREAD with 0 even when unread data is pending in
> sk_receive_queue. Fix tcp_bpf_ioctl() to account for the receive queue
> in that case, and add a selftest.
> 
> Changes in v3:
> - Remove unused sk_psock_msg_inq()
> - Link to v2: https://patch.msgid.link/20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf, sockmap: Account for receive queue in FIONREAD without a verdict program
    https://git.kernel.org/bpf/bpf/c/04af4efde58a
  - [bpf,v3,2/2] selftests/bpf: Test FIONREAD on a sockmap socket without a verdict program
    https://git.kernel.org/bpf/bpf/c/a42f05cc4c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


