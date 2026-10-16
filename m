Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3A175A8D;
	Fri, 16 Oct 2026 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110615; cv=none; b=TX5CKW86gAznERzHaW9m8O/u71UYvC/X8Mz+pInxDdPWkBXBSpi1kuN9Q5XMDI+UQWRCYuDBZIyTOyImZwsjitjZ7oRONGxInIv9r/NwBb/JcY6R0XA4ypa9USkHAbWbDRyFzinKjZmlecTGcWtklEnPEa6H19SYKC3x6eqt6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110615; c=relaxed/simple;
	bh=83usOsp8wI9IPRWQWLGRxDReGbsK2PJhzM7PHTbD2MU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOnnNLEEZAwojO97JS0dkNCaOCy703jj+VqdRPlYPcWd80wclgodXpKTiyThsDY/CRn+7EsT8/foTiWf4G1uUOscB9alr+Dvty+FgA+CWKA33k0jOKGLK5EGa6p5hDPo76/j69Dc0tLle2BkUycrcQnYkOpYCy5qEzmx3Xho2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL69kCTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL69kCTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436131F000C4;
	Fri, 16 Oct 2026 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110614;
	bh=/v3m9J02eLlgdzrAWc/Zr2vpapNYcTrxiQ5gLn/oefg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lL69kCTXal9fRozZgLfEdIC4FkKYfhLoswLSsLLxWE4GUk52uk9jYE9DhczIavym6
	 22M88OIzGOFM+MRmAN3NhZbCi9n71CKnEZrrOECVAUVWRxLAjMol33DNdfmeJOKysm
	 87kYtG0EnHO3WuHwX5yssYt3oWIuSsHczsQqXsfmnlQHuZNXbeP2kbELVZ8vQeJmfe
	 S4V3dNjwY+BO/xhp3PtXgKQM6pasV91FDMNpZkFpIguRv2KD0LtAP48vRaWRBcNX58
	 22U9ypyA7HSr9jJ0SFROYnjn+AXRqmvjhwFpRThsqKov/eC8fCDB4v5tw9y4++ugHK
	 QqDa1Yyn8abhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2973808209;
	Fri, 16 Oct 2026 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: netmem: document design principles
 and
 intended direction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211061289.4173731.14620671802966494191.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:30:12 +0000
References: <20261010033630.1171692-1-almasrymina@google.com>
In-Reply-To: <20261010033630.1171692-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 lrizzo@google.com, bjorn@kernel.org, asml.silence@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 03:36:07 +0000 you wrote:
> Because the networking stack and drivers are only partially converted to
> netmem_ref and current memory providers only supply unreadable net_iovs,
> automated code review and analysis tools (such as LLMs) frequently infer
> the wrong architectural invariants from existing code. Specifically,
> they often assume that page_pool's struct page APIs are primary rather
> than legacy wrappers, that memory providers always imply net_iov, that
> net_iov is inherently unreadable, or that callers should branch on or
> downcast netmem_ref directly.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: netmem: document netmem and memory provider design in comments
    https://git.kernel.org/netdev/net-next/c/72ebc685bca9
  - [net-next,v3,2/2] docs: netmem: document netmem and memory provider design principles
    https://git.kernel.org/netdev/net-next/c/b35ec0d877f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


