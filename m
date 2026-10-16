Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534B59B56;
	Fri, 16 Oct 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109412; cv=none; b=jE0L7722cmKC6HOnCiC1bRXGQ1OcnmVDQobRJRjvhtz+2bBIRgJKnf1NjANRBuTy8DtnX+Tif9ym98FyUWkrcmdUWF0skXFyQnPAI6orfvHq6ZKL2WuCXLVRD+6DD64ZWuYwDZbIkNQA/wIgjB/QpAZo3L5mJmcHgbMXfP5WklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109412; c=relaxed/simple;
	bh=osXrkjf+p0s3EoJcL6n7f2ki3L9qb2+xrGqOofZ+5TY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uC6HKPYIDyjTsY8QsEWIJvKQV4RlkijzeoUNoR/8VC2RjXQi+BZOu1USwMKH2zLJAyIAC3/9wqaZqU99tF2NCUTy+VBm+klecpo7b3jO3/MSwkiJIDdohZIoISESHVx3ST4BsrQEpwHFIrXAgwhjeDGMa6Fslo91x8wHQxC47uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiVAMAQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiVAMAQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00111F000C4;
	Fri, 16 Oct 2026 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109410;
	bh=scCm+gybNBnZNt2kTmfpH4i6FuWenuNMphLgqWxECZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZiVAMAQCoBPpkWPjPfhVagf2mmWP4pxCCJ1af/Y430seGXglyktkNZ7lZlr312PgC
	 /K7R2I/frYEJkm5VJYgDun5fpMi5uGczKezeN6ICgTS87Dbdau8fPanF0L2TyIyvPq
	 GqpyY9EJul5E04xD/VRgaX57AjMFdujX6KUoxMnbYcTOFignLKwZ26oxp34mT6Z+ep
	 LQgw8+B+YAQWMuJPkbaMDFuyLPCHrHUjLgaTwNmr4PGIiJiot5D4YzGyF1ywBmM2NA
	 bzyKnywUFm8PxP2BDUgmN2v0TGVQ72tItHGIM0VKUq1TH+sO1L+mq9X98cwVjWMK0M
	 ib3ksUpKq/hQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44D13808209;
	Fri, 16 Oct 2026 00:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] netlink: add lwtunnel encap sub-message
 support to rt-route
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179210940926.4168191.14040928625419046386.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:10:09 +0000
References: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
In-Reply-To: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, liuhangbin@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 Oct 2026 16:24:00 +0800 you wrote:
> This series adds YNL sub-message support for lwtunnel encap data in
> the rt-route netlink family, and describes the tunnel-specific
> attribute sets that were previously opaque binary blobs.
> 
> The kernel currently emits encap_type after the encap payload nest,
> but YNL sub-message parsing needs the selector (encap_type) first to
> dispatch on the correct attribute set. Patch 1 reorders the kernel
> output, and patch 2 teaches the YNL C code generator to convert enum
> selectors to their string form for sub-message dispatch.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] net: lwtunnel: change encap fill order
    https://git.kernel.org/netdev/net-next/c/499f32f0eb56
  - [net-next,v4,2/6] tools: ynl: convert enum selector to string for sub-message parsing
    https://git.kernel.org/netdev/net-next/c/05d3030eff5b
  - [net-next,v4,3/6] netlink: specs: rt-route: add lwtunnel encap sub-message support
    https://git.kernel.org/netdev/net-next/c/24d11a55860b
  - [net-next,v4,4/6] netlink: specs: rt-route: describe lwtunnel IP options
    https://git.kernel.org/netdev/net-next/c/e32b5eb4f237
  - [net-next,v4,5/6] netlink: specs: rt-route: describe lwt BPF program options
    https://git.kernel.org/netdev/net-next/c/8ab5eb3bf6e0
  - [net-next,v4,6/6] netlink: specs: rt-route: describe seg6-local attrs
    https://git.kernel.org/netdev/net-next/c/5f9d4edccf0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


